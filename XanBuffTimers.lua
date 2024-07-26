
local ADDON_NAME, addon = ...
if not _G[ADDON_NAME] then
	_G[ADDON_NAME] = CreateFrame("Frame", ADDON_NAME, UIParent, BackdropTemplateMixin and "BackdropTemplate")
end
addon = _G[ADDON_NAME]

local debugf = tekDebug and tekDebug:GetFrame(ADDON_NAME)
local function Debug(...)
    if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end
end

addon:RegisterEvent("ADDON_LOADED")
addon:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" or event == "PLAYER_LOGIN" then
		if event == "ADDON_LOADED" then
			local arg1 = ...
			if arg1 and arg1 == ADDON_NAME then
				self:UnregisterEvent("ADDON_LOADED")
				self:RegisterEvent("PLAYER_LOGIN")
			end
			return
		end
		if IsLoggedIn() then
			self:EnableAddon(event, ...)
			self:UnregisterEvent("PLAYER_LOGIN")
		end
		return
	end
	if self[event] then
		return self[event](self, event, ...)
	end
end)

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
local LibClassicDurations = LibStub("LibClassicDurations", true)

local isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
local UnitAura = _G.UnitAura

--wrap the UnitAura function if addon is running in classic
--Aura does not provide duration or expiration in classic.
if LibClassicDurations then
    LibClassicDurations:Register(ADDON_NAME)
    UnitAura = LibClassicDurations.UnitAuraWrapper
end

addon.timersTarget = {}
addon.timersFocus = {}
addon.timersPlayer = {}
addon.timersSupport = {}

--buff arrays
addon.timersTarget.buffs = {}
addon.timersFocus.buffs = {}
addon.timersPlayer.buffs = {}
addon.timersSupport.buffs = {}

addon.MAX_TIMERS = 15

local ICON_SIZE = 20
local BAR_ADJUST = 25
local BAR_TEXT = "llllllllllllllllllllllllllllllllllllllll"
local band = bit.band
local locked = false

local targetGUID = 0
local focusGUID = 0
local playerGUID = 0
local supportGUID
local supportUnitID
local UnitAura = UnitAura
local UnitIsUnit = UnitIsUnit
local UnitGUID = UnitGUID
local UnitName = UnitName

local timerList = {
	["target"] = addon.timersTarget,
	["focus"] = addon.timersFocus,
	["player"] = addon.timersPlayer,
	["support"] = addon.timersSupport,
}

local barsLoaded = false

----------------------
--      Enable      --
----------------------
function addon:CheckSupportGUID()
	if not XBT_DB.showSupport then return nil end

	--local _, _, subGroup = GetRaidRosterInfo(UnitInRaid("player"))
	--GetNumSubgroupMembers

	local tankGUID
	local unitID
	local sTargetGUID
	local sTargetUnitID

	--first check group
	for i=1, GetNumSubgroupMembers() do
		local unit = "party"..i
		if ( UnitExists(unit) ) then
			if isRetail then
				local role = UnitGroupRolesAssigned(unit)
				if role and role == "TANK" then
					tankGUID = UnitGUID(unit)
					unitID = unit
				end
			end

			local name = GetUnitName(unit, true)
			if name and XBT_DB.supportTarget and XBT_DB.supportTarget == name then
				sTargetGUID = UnitGUID(unit)
				sTargetUnitID = unit
			end
		end
	end

	--check raid only if we have a support target
	if IsInRaid() and XBT_DB.supportTarget and not sTargetGUID then
		for i=1, MAX_RAID_MEMBERS do
			local unit = "raid"..i
			if ( UnitExists(unit) ) then

				local name = GetUnitName(unit, true)
				if name and XBT_DB.supportTarget and XBT_DB.supportTarget == name then
					sTargetGUID = UnitGUID(unit)
					sTargetUnitID = unit
				end
			end
		end
	end

	if sTargetGUID and sTargetUnitID then
		tankGUID = sTargetGUID
		unitID = sTargetUnitID
	end

	--clear the buffs if we have nothing to work with
	if not tankGUID or not unitID then
		addon:ClearBuffs("support")
	end

	return tankGUID, unitID
end

function addon:SetSupportTarget()

	--make sure we have a target
	if not UnitExists("target") then
		DEFAULT_CHAT_FRAME:AddMessage(L.SlashSupportTargetInvalid)
		return
	end

	local name = GetUnitName("target", true)

	--make sure it isn't the player
	if name and name == GetUnitName("player", true) then
		DEFAULT_CHAT_FRAME:AddMessage(L.SlashSupportTargetInvalid)
		return
	end

	XBT_DB.supportTarget = name
	supportGUID, supportUnitID = addon:CheckSupportGUID()

	if not supportGUID then
		DEFAULT_CHAT_FRAME:AddMessage(L.SlashSupportTargetInvalid)
		return
	end

	DEFAULT_CHAT_FRAME:AddMessage(string.format(L.SlashSupportTargetUnit, name))
end

function addon:EnableAddon()

	if not XBT_DB then XBT_DB = {} end
	if XBT_DB.scale == nil then XBT_DB.scale = 1 end
	if XBT_DB.grow == nil then XBT_DB.grow = false end
	if XBT_DB.sort == nil then XBT_DB.sort = false end
	if XBT_DB.showTarget == nil then XBT_DB.showTarget = true end
	if XBT_DB.showFocus == nil then XBT_DB.showFocus = true end
	if XBT_DB.showPlayer == nil then XBT_DB.showPlayer = true end
	if XBT_DB.showSupport == nil then XBT_DB.showSupport = true end
	if XBT_DB.showInfinite == nil then XBT_DB.showInfinite = false end
	if XBT_DB.showIcon == nil then XBT_DB.showIcon = true end
	if XBT_DB.showSpellName == nil then XBT_DB.showSpellName = false end
	if XBT_DB.healersOnly == nil then XBT_DB.healersOnly = false end


	--create our anchors
	addon:CreateAnchor("XBT_TargetAnchor", UIParent, L.BarTargetAnchor)
	if isRetail then
		addon:CreateAnchor("XBT_FocusAnchor", UIParent, L.BarFocusAnchor)
	end
	addon:CreateAnchor("XBT_PlayerAnchor", UIParent, L.BarPlayerAnchor)
	addon:CreateAnchor("XBT_SupportAnchor", UIParent, L.BarSupportAnchor)

	--
	playerGUID = UnitGUID("player")
	supportGUID, supportUnitID = addon:CheckSupportGUID() --just in case they did a /reload

	--create our bars
	addon:generateBars()

	addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	addon:RegisterEvent("PLAYER_TARGET_CHANGED")
	if isRetail then
		addon:RegisterEvent("PLAYER_FOCUS_CHANGED")
	end
	addon:RegisterEvent("GROUP_ROSTER_UPDATE")

	SLASH_XANBUFFTIMERS1 = "/xbt"
	SlashCmdList["XANBUFFTIMERS"] = function(cmd)

		local a,b,c=strfind(cmd, "(%S+)"); --contiguous string of non-space characters

		if a then
			if c and c:lower() == L.SlashAnchor then
				addon.aboutPanel.btnAnchor.func()
				return true
			elseif c and c:lower() == L.SlashReset then
				addon.aboutPanel.btnReset.func()
				return true
			elseif c and c:lower() == L.SlashScale then
				if b then
					local scalenum = strsub(cmd, b+2)
					if scalenum and scalenum ~= "" and tonumber(scalenum) and tonumber(scalenum) >= 0.5 and tonumber(scalenum) <= 5 then
						addon:SetAddonScale(tonumber(scalenum))
					else
						DEFAULT_CHAT_FRAME:AddMessage(L.SlashScaleSetInvalid)
					end
					return true
				end
			elseif c and c:lower() == L.SlashGrow then
				addon.aboutPanel.btnGrow.func(true)
				return true
			elseif c and c:lower() == L.SlashSort then
				addon.aboutPanel.btnSort.func(true)
				return true
			elseif c and c:lower() == L.SlashTarget then
				addon.aboutPanel.btnTarget.func(true)
				return true
			elseif c and c:lower() == L.SlashFocus and isRetail then
				addon.aboutPanel.btnFocus.func(true)
				return true
			elseif c and c:lower() == L.SlashPlayer then
				addon.aboutPanel.btnPlayer.func(true)
				return true
			elseif c and c:lower() == L.SlashSupport then
				addon.aboutPanel.btnSupport.func(true)
				return true
			elseif c and c:lower() == L.SlashSupportTarget then
				addon:SetSupportTarget()
				return true
			elseif c and c:lower() == L.SlashInfinite then
				addon.aboutPanel.btnInfinite.func(true)
				return true
			elseif c and c:lower() == L.SlashIcon then
				addon.aboutPanel.btnIcon.func(true)
				return true
			elseif c and c:lower() == L.SlashSpellName then
				addon.aboutPanel.btnSpellName.func(true)
				return true
			elseif c and c:lower() == L.SlashHealers then
				addon.aboutPanel.btnHealers.func(true)
				return true
			elseif c and c:lower() == L.SlashReload then
				 addon.aboutPanel.btnReloadDebuffs.func()
				return true
			end
		end

		DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashAnchor.." - "..L.SlashAnchorInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashReset.." - "..L.SlashResetInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashScale.." # - "..L.SlashScaleInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashGrow.." - "..L.SlashGrowInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashSort.." - "..L.SlashSortInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashTarget.." - "..L.SlashTargetInfo)
		if isRetail then
			DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashFocus.." - "..L.SlashFocusInfo)
		end
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashPlayer.." - "..L.SlashPlayerInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashSupport.." - "..L.SlashSupportInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashSupportTarget.." - "..L.SlashSupportTargetInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashInfinite.." - "..L.SlashInfiniteInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashIcon.." - "..L.SlashIconInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashSpellName.." - "..L.SlashSpellNameInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashHealers.." - "..L.SlashHealersInfo)
		DEFAULT_CHAT_FRAME:AddMessage("/xbt "..L.SlashReload .." - "..L.SlashReloadInfo)

	end

	if addon.configFrame then addon.configFrame:EnableConfig() end

	local ver = C_AddOns.GetAddOnMetadata(ADDON_NAME,"Version") or '1.0'
	DEFAULT_CHAT_FRAME:AddMessage(string.format("|cFF99CC33%s|r [v|cFF20ff20%s|r] loaded:   /xbt", ADDON_NAME, ver or "1.0"))

	--reload all our buffs on login
	addon:ReloadBuffs()
end

function addon:PLAYER_TARGET_CHANGED()
	if not XBT_DB.showTarget then return end
	if UnitName("target") and UnitGUID("target") then
		targetGUID = UnitGUID("target")
		addon:ProcessBuffs("target")
	else
		addon:ClearBuffs("target")
		targetGUID = 0
	end
end

function addon:GROUP_ROSTER_UPDATE()
	supportGUID, supportUnitID = addon:CheckSupportGUID()
end

function addon:PLAYER_FOCUS_CHANGED()
	if not isRetail then return end
	if not XBT_DB.showFocus then return end
	if UnitName("focus") and UnitGUID("focus") then
		focusGUID = UnitGUID("focus")
		addon:ProcessBuffs("focus")
	else
		addon:ClearBuffs("focus")
		focusGUID = 0
	end
end

local eventSwitch = {
	["SPELL_AURA_APPLIED"] = true,
	["SPELL_AURA_REMOVED"] = true,
	["SPELL_AURA_REFRESH"] = true,
	["SPELL_AURA_APPLIED_DOSE"] = true,
	["SPELL_AURA_APPLIED_REMOVED_DOSE"] = true,
	["SPELL_AURA_REMOVED_DOSE"] = true,
	["SPELL_AURA_BROKEN"] = true,
	["SPELL_AURA_BROKEN_SPELL"] = true,
	["ENCHANT_REMOVED"] = true,
	["ENCHANT_APPLIED"] = true,
	["SPELL_CAST_SUCCESS"] = true,
	["SPELL_PERIODIC_ENERGIZE"] = true,
	["SPELL_ENERGIZE"] = true,
	["SPELL_PERIODIC_HEAL"] = true,
	["SPELL_HEAL"] = true,
	["SPELL_DAMAGE"] = true,
	["SPELL_PERIODIC_DAMAGE"] = true,
	--added new
	["SPELL_DRAIN"] = true,
	["SPELL_LEECH"] = true,
	["SPELL_PERIODIC_DRAIN"] = true,
	["SPELL_PERIODIC_LEECH"] = true,
	["DAMAGE_SHIELD"] = true,
	["DAMAGE_SPLIT"] = true,
}

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo

function addon:COMBAT_LOG_EVENT_UNFILTERED()

	--local timestamp, eventType, hideCaster, sourceGUID, sourceName, srcFlags, sourceRaidFlags, dstGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType, amount
	local timestamp, eventType, _, sourceGUID, _, srcFlags, _, dstGUID = CombatLogGetCurrentEventInfo()

    if eventType == "UNIT_DIED" or eventType == "UNIT_DESTROYED" then
		--clear the buffs if the unit died
		--NOTE the reason an elseif isn't used is because some dorks may have
		--their current target as their focus as well
		if dstGUID == targetGUID and XBT_DB.showTarget then
			addon:ClearBuffs("target")
			targetGUID = 0
		end
		if isRetail and dstGUID == focusGUID and XBT_DB.showFocus then
			addon:ClearBuffs("focus")
			focusGUID = 0
		end
		if dstGUID == playerGUID and XBT_DB.showPlayer then
			addon:ClearBuffs("player")
		end
		if XBT_DB.showSupport then
			if supportGUID and dstGUID == supportGUID then
				addon:ClearBuffs("support")
			end
		end

	elseif eventSwitch[eventType] and band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 then
		--process the spells based on GUID
		if dstGUID == targetGUID and XBT_DB.showTarget then
			addon:ProcessBuffs("target")
		end
		if isRetail and dstGUID == focusGUID and XBT_DB.showFocus then
			addon:ProcessBuffs("focus")
		end
		if dstGUID == playerGUID and XBT_DB.showPlayer then
			addon:ProcessBuffs("player")
		end
		if XBT_DB.showSupport then
			if supportGUID and dstGUID == supportGUID  then
				addon:ProcessBuffs("support")
			end
		end
    end
end

----------------------
--  Frame Creation  --
----------------------

function addon:CreateAnchor(name, parent, desc)

	--create the anchor
	local frameAnchor = CreateFrame("Frame", name, parent, BackdropTemplateMixin and "BackdropTemplate")

	frameAnchor:SetWidth(25)
	frameAnchor:SetHeight(25)
	frameAnchor:SetMovable(true)
	frameAnchor:SetClampedToScreen(true)
	frameAnchor:EnableMouse(true)

	frameAnchor:ClearAllPoints()
	frameAnchor:SetPoint("CENTER", parent, "CENTER", 0, 0)
	frameAnchor:SetFrameStrata("DIALOG")

	frameAnchor:SetBackdrop({
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 16,
			insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	frameAnchor:SetBackdropColor(0.75,0,0,1)
	frameAnchor:SetBackdropBorderColor(0.75,0,0,1)

	frameAnchor:SetScript("OnLeave",function(self)
		GameTooltip:Hide()
	end)

	frameAnchor:SetScript("OnEnter",function(self)

		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint(self:SetTip(self))
		GameTooltip:ClearLines()

		GameTooltip:AddLine(name)
		if desc then
			GameTooltip:AddLine(desc)
		end
		GameTooltip:Show()
	end)

	frameAnchor:SetScript("OnMouseDown", function(frame, button)
		if frame:IsMovable() then
			frame.isMoving = true
			frame:StartMoving()
		end
	end)

	frameAnchor:SetScript("OnMouseUp", function(frame, button)
		if( frame.isMoving ) then
			frame.isMoving = nil
			frame:StopMovingOrSizing()
			addon:SaveLayout(frame:GetName())
		end
	end)

	function frameAnchor:SetTip(frame)
		local x,y = frame:GetCenter()
		if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
		local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
		local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
		return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
	end

	frameAnchor:Hide() -- hide it by default

	addon:RestoreLayout(name)
end

function addon:CreateBuffTimers()

    local Frm = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")

    Frm:SetWidth(ICON_SIZE)
    Frm:SetHeight(ICON_SIZE)
	Frm:SetFrameStrata("LOW")

	addon:SetAddonScale(XBT_DB.scale, true)

    Frm.icon = Frm:CreateTexture(nil, "BACKGROUND")
    Frm.icon:SetTexCoord(.07, .93, .07, .93)
    Frm.icon:SetWidth(ICON_SIZE)
    Frm.icon:SetHeight(ICON_SIZE)
	Frm.icon:SetTexture("Interface\\Icons\\Spell_Shadow_Shadowbolt")
    Frm.icon:SetAllPoints(true)

    Frm.stacktext = Frm:CreateFontString(nil, "OVERLAY");
    Frm.stacktext:SetFont(STANDARD_TEXT_FONT,10,"OUTLINE")
    Frm.stacktext:SetWidth(Frm.icon:GetWidth())
    Frm.stacktext:SetHeight(Frm.icon:GetHeight())
    Frm.stacktext:SetJustifyH("RIGHT")
    Frm.stacktext:SetVertexColor(1,1,1)
    Frm.stacktext:SetPoint("RIGHT", Frm.icon, "RIGHT",1,-5)

    Frm.timetext = Frm:CreateFontString(nil, "OVERLAY");
    Frm.timetext:SetFont(STANDARD_TEXT_FONT,10,"OUTLINE")
    Frm.timetext:SetJustifyH("RIGHT")
    Frm.timetext:SetPoint("LEFT", Frm.icon, "RIGHT", 5, 0)

    Frm.spellText = Frm:CreateFontString(nil, "OVERLAY");
    Frm.spellText:SetFont(STANDARD_TEXT_FONT,10,"OUTLINE")
	Frm.spellText:SetTextColor(0,183/255,239/255)
    Frm.spellText:SetJustifyH("RIGHT")
    Frm.spellText:SetPoint("RIGHT", Frm.icon, "LEFT" , -5, 0)

    Frm.spellText2 = Frm:CreateFontString(nil, "OVERLAY");
    Frm.spellText2:SetFont(STANDARD_TEXT_FONT,10,"OUTLINE")
	Frm.spellText2:SetTextColor(0,183/255,239/255)
    Frm.spellText2:SetJustifyH("RIGHT")
    Frm.spellText2:SetPoint("RIGHT", Frm.icon, "LEFT" , 20, 0)

	Frm.Bar = Frm:CreateFontString(nil, "OVERLAY")
	Frm.Bar:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE, MONOCHROME")
	Frm.Bar:SetText(BAR_TEXT)
	Frm.Bar:SetPoint("LEFT", Frm.icon, "RIGHT", 33, 0)

	Frm:Hide()

	return Frm

end

function addon:SetAddonScale(value, bypass)
	--fix this in case it's ever smaller than   
	if value < 0.5 then value = 0.5 end --anything smaller and it would vanish  
	if value > 5 then value = 5 end --WAY too big  

	XBT_DB.scale = value

	if not bypass then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(L.SlashScaleSet, value))
	end

	for i=1, addon.MAX_TIMERS do
		if addon.timersTarget[i] then
			addon.timersTarget[i]:SetScale(XBT_DB.scale)
		end
		if isRetail and addon.timersFocus[i] then
			addon.timersFocus[i]:SetScale(XBT_DB.scale)
		end
		if addon.timersPlayer[i] then
			addon.timersPlayer[i]:SetScale(XBT_DB.scale)
		end
		if addon.timersSupport[i] then
			addon.timersSupport[i]:SetScale(XBT_DB.scale)
		end				
	end

end

function addon:generateBars()
	local adj = 0

	--lets create the max bars to use on screen for future sorting
	for i=1, addon.MAX_TIMERS do
		addon.timersTarget[i] = addon:CreateBuffTimers()
		if not addon.timersTarget.buffs[i] then addon.timersTarget.buffs[i] = {} end

		if isRetail then
			addon.timersFocus[i] = addon:CreateBuffTimers()
			if not addon.timersFocus.buffs[i] then addon.timersFocus.buffs[i] = {} end
		end

		addon.timersPlayer[i] = addon:CreateBuffTimers()
		if not addon.timersPlayer.buffs[i] then addon.timersPlayer.buffs[i] = {} end

		addon.timersSupport[i] = addon:CreateBuffTimers()
		if not addon.timersSupport.buffs[i] then addon.timersSupport.buffs[i] = {} end
	end

	--rearrange order
	for i=1, addon.MAX_TIMERS do
		if XBT_DB.grow then
			addon.timersTarget[i]:ClearAllPoints()
			addon.timersTarget[i]:SetPoint("TOPLEFT", XBT_TargetAnchor, "BOTTOMRIGHT", 0, adj)
			if isRetail then
				addon.timersFocus[i]:ClearAllPoints()
				addon.timersFocus[i]:SetPoint("TOPLEFT", XBT_FocusAnchor, "BOTTOMRIGHT", 0, adj)
			end
			addon.timersPlayer[i]:ClearAllPoints()
			addon.timersPlayer[i]:SetPoint("TOPLEFT", XBT_PlayerAnchor, "BOTTOMRIGHT", 0, adj)
			addon.timersSupport[i]:ClearAllPoints()
			addon.timersSupport[i]:SetPoint("TOPLEFT", XBT_SupportAnchor, "BOTTOMRIGHT", 0, adj)
		else
			addon.timersTarget[i]:ClearAllPoints()
			addon.timersTarget[i]:SetPoint("BOTTOMLEFT", XBT_TargetAnchor, "TOPRIGHT", 0, (adj * -1))
			if isRetail then
				addon.timersFocus[i]:ClearAllPoints()
				addon.timersFocus[i]:SetPoint("BOTTOMLEFT", XBT_FocusAnchor, "TOPRIGHT", 0, (adj * -1))
			end
			addon.timersPlayer[i]:ClearAllPoints()
			addon.timersPlayer[i]:SetPoint("BOTTOMLEFT", XBT_PlayerAnchor, "TOPRIGHT", 0, (adj * -1))
			addon.timersSupport[i]:ClearAllPoints()
			addon.timersSupport[i]:SetPoint("BOTTOMLEFT", XBT_SupportAnchor, "TOPRIGHT", 0, (adj * -1))
		end
		adj = adj - BAR_ADJUST
    end

	barsLoaded = true
end

function addon:adjustBars()
	if not barsLoaded then return end

	local adj = 0
	for i=1, addon.MAX_TIMERS do
		if XBT_DB.grow then
			addon.timersTarget[i]:ClearAllPoints()
			addon.timersTarget[i]:SetPoint("TOPLEFT", XBT_TargetAnchor, "BOTTOMRIGHT", 0, adj)
			if isRetail then
				addon.timersFocus[i]:ClearAllPoints()
				addon.timersFocus[i]:SetPoint("TOPLEFT", XBT_FocusAnchor, "BOTTOMRIGHT", 0, adj)
			end
			addon.timersPlayer[i]:ClearAllPoints()
			addon.timersPlayer[i]:SetPoint("TOPLEFT", XBT_PlayerAnchor, "BOTTOMRIGHT", 0, adj)
			addon.timersSupport[i]:ClearAllPoints()
			addon.timersSupport[i]:SetPoint("TOPLEFT", XBT_SupportAnchor, "BOTTOMRIGHT", 0, adj)
		else
			addon.timersTarget[i]:ClearAllPoints()
			addon.timersTarget[i]:SetPoint("BOTTOMLEFT", XBT_TargetAnchor, "TOPRIGHT", 0, (adj * -1))
			if isRetail then
				addon.timersFocus[i]:ClearAllPoints()
				addon.timersFocus[i]:SetPoint("BOTTOMLEFT", XBT_FocusAnchor, "TOPRIGHT", 0, (adj * -1))
			end
			addon.timersPlayer[i]:ClearAllPoints()
			addon.timersPlayer[i]:SetPoint("BOTTOMLEFT", XBT_PlayerAnchor, "TOPRIGHT", 0, (adj * -1))
			addon.timersSupport[i]:ClearAllPoints()
			addon.timersSupport[i]:SetPoint("BOTTOMLEFT", XBT_SupportAnchor, "TOPRIGHT", 0, (adj * -1))
		end
		adj = adj - BAR_ADJUST
    end
end

function addon:ProcessBuffBar(data)
	if data.isInfinite then return end --dont do any calculations on infinite

	local beforeEnd = data.endTime - GetTime()
	-- local percentTotal = (beforeEnd / data.durationTime)
	-- local percentFinal = ceil(percentTotal * 100)
	-- local barLength = ceil( string.len(BAR_TEXT) * percentTotal )

	--calculate the individual bar segments and make the appropriate calculations
	local totalDuration = (data.endTime - data.startTime) --total duration of the spell
	local totalBarSegment = (string.len(BAR_TEXT) / totalDuration) --lets get how much each segment of the bar string would value up to 100%
	local totalBarLength = totalBarSegment * beforeEnd --now get the individual bar segment value and multiply it with current duration
	local barPercent = (totalBarLength / string.len(BAR_TEXT)) * 100

	--100/40 means each segment is 2.5 for 100%
	--example for 50%   50/100 = 0.5   0.5 / 2.5 = 0.2  (50% divided by segment count) 0.2 * 100 = 20 (which is half of the bar of 40)

	if barPercent <= 0 or beforeEnd <= 0 or totalBarLength <= 0 then
		data.active = false
		return
	end

	data.percent = barPercent
	data.totalBarLength = totalBarLength
	data.beforeEnd = beforeEnd

end

----------------------
-- Buff Functions --
----------------------

--lets use one global OnUpdate instead of individual ones for each buff bar
addon:SetScript("OnUpdate", function(self, elapsed)
	self.OnUpdateCounter = (self.OnUpdateCounter or 0) + elapsed
	if self.OnUpdateCounter < 0.05 then return end
	self.OnUpdateCounter = 0

	local tCount = 0
	local fCount = 0
	local pCount = 0
	local sCount = 0

	if not barsLoaded then return end

	for i=1, addon.MAX_TIMERS do
		if addon.timersTarget.buffs[i].active then
			self:ProcessBuffBar(addon.timersTarget.buffs[i])
			tCount = tCount + 1
		end
		if isRetail and addon.timersFocus.buffs[i].active then
			self:ProcessBuffBar(addon.timersFocus.buffs[i])
			fCount = fCount + 1
		end
		if addon.timersPlayer.buffs[i].active then
			self:ProcessBuffBar(addon.timersPlayer.buffs[i])
			pCount = pCount + 1
		end
		if addon.timersSupport.buffs[i].active then
			self:ProcessBuffBar(addon.timersSupport.buffs[i])
			sCount = sCount + 1
		end
	end

	--no need to arrange the bars if there is nothing to work with, uncessary if no target or focus
	if tCount > 0 then
		addon:ShowBuffs("target")
	end
	if isRetail and fCount > 0 then
		addon:ShowBuffs("focus")
	end
	if pCount > 0 then
		addon:ShowBuffs("player")
	end
	if sCount > 0 then
		--if the player is not in anytype of group then clear the support bars
		--they only are for party and raid
		if not IsInGroup() then
			addon:ClearBuffs("support")
		else
			addon:ShowBuffs("support")
		end
	end
end)

function addon:ProcessBuffs(id)
	if not barsLoaded then return end

	local unitID = id
	local class = select(2, UnitClass("player"))

	local healers = {
		["DRUID"] = true,
		["SHAMAN"] = true,
		["MONK"] = true,
		["PRIEST"] = true,
		["PALADIN"] = true,
	}

	if XBT_DB.healersOnly and not healers[class] then
		return
	end

	local sdTimer = timerList[id] --makes things easier to read

	if id == "support" then
		if not supportGUID or not supportUnitID then
			addon:ClearBuffs("support")
			return
		end
		unitID = supportUnitID
	end

	for i=1, addon.MAX_TIMERS do
		local name, icon, count, debuffType, duration, expTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellId = UnitAura(unitID, i, 'PLAYER|HELPFUL')

		local passChk = false
		local isInfinite = false

		--only allow non-cancel auras if the user allowed it
		if XBT_DB.showInfinite then
			--auras are on so basically were allowing everything
			passChk = true
			if not duration or duration <= 0 or not expTime or expTime <= 0 then
				isInfinite = true
			end
		end
		if not XBT_DB.showInfinite and duration and duration > 0 then
			--auras are not on but the duration is greater then zero, so allow
			passChk = true
		end

		if name and passChk then
			local beforeEnd = 0
			local startTime = 0
			local totalDuration = 0
			local totalBarSegment = 0
			local totalBarLength = 0
			local barPercent = 0

			if isInfinite then
				barPercent = 200 --anything higher than 100 will get pushed to top of list, so lets make it 200 -> addon:ShowBuffs(id)
				duration = 0
				expTime = 0
				totalBarLength = string.len(BAR_TEXT) --just make it full bar length, it will never decrease anyways
			else
				beforeEnd = expTime - GetTime()
				startTime = (expTime - duration)
				totalDuration = (expTime - startTime) --total duration of the spell
				totalBarSegment = (string.len(BAR_TEXT) / totalDuration) --lets get how much each segment of the bar string would value up to 100%
				totalBarLength = totalBarSegment * beforeEnd --now get the individual bar segment value and multiply it with current duration
				barPercent = (totalBarLength / string.len(BAR_TEXT)) * 100
			end

			if barPercent > 0 or beforeEnd > 0 or totalBarLength > 0 then
				--buffs
				sdTimer.buffs[i].unitID = unitID
				sdTimer.buffs[i].spellName = name
				sdTimer.buffs[i].spellId = spellId
				sdTimer.buffs[i].iconTex = icon
				sdTimer.buffs[i].startTime = startTime
				sdTimer.buffs[i].durationTime = duration
				sdTimer.buffs[i].beforeEnd = beforeEnd
				sdTimer.buffs[i].endTime = expTime
				sdTimer.buffs[i].totalBarLength = totalBarLength
				sdTimer.buffs[i].stacks = count or 0
				sdTimer.buffs[i].percent = barPercent
				sdTimer.buffs[i].active = true
				sdTimer.buffs[i].isInfinite = isInfinite
			end
		else
			sdTimer.buffs[i].active = false
		end
	end

	addon:ShowBuffs(id)
end

function addon:ClearBuffs(id)
	if not barsLoaded then return end

	local sdTimer = timerList[id] --makes things easier to read
	local adj = 0

	for i=1, addon.MAX_TIMERS do
		sdTimer.buffs[i].active = false
		sdTimer[i]:Hide()
	end

end

function addon:ReloadBuffs()
	local class = select(2, UnitClass("player"))

	addon:ClearBuffs("target")
	if isRetail then
		addon:ClearBuffs("focus")
	end
	addon:ClearBuffs("player")
	addon:ClearBuffs("support")

	if XBT_DB.showTarget then
		addon:ProcessBuffs("target")
	end
	if isRetail and XBT_DB.showFocus then
		addon:ProcessBuffs("focus")
	end
	if XBT_DB.showPlayer then
		addon:ProcessBuffs("player")
	end
	if XBT_DB.showSupport then
		supportGUID, supportUnitID = addon:CheckSupportGUID()
		addon:ProcessBuffs("support")
	end
end

function addon:ShowBuffs(id)
	if not barsLoaded then return end

	if locked then return end
	locked = true

	local sdTimer
	local tmpList = {}

	if id == "target" then
		sdTimer = addon.timersTarget
	elseif id == "focus" and isRetail then
		sdTimer = addon.timersFocus
	elseif id == "player" then
		sdTimer = addon.timersPlayer
	elseif id == "support" then
		sdTimer = addon.timersSupport
	else
		locked = false
		return
	end

	for i=1, addon.MAX_TIMERS do
		if sdTimer.buffs[i].active then
			table.insert(tmpList, sdTimer.buffs[i])
		end
	end

	if XBT_DB.grow then
		--bars will grow down
		if XBT_DB.sort then
			--sort from shortest to longest
			table.sort(tmpList, function(a,b) return (a.percent < b.percent) end)

		else
			--sort from longest to shortest
			table.sort(tmpList, function(a,b) return (a.percent > b.percent) end)

		end
	else
		--bars will grow up
		if XBT_DB.sort then
			--sort from shortest to longest
			table.sort(tmpList, function(a,b) return (a.percent > b.percent) end)

		else
			--sort from longest to shortest
			table.sort(tmpList, function(a,b) return (a.percent < b.percent) end)
		end
	end

	for i=1, addon.MAX_TIMERS do
		if tmpList[i] then
			--display the information
			---------------------------------------
			sdTimer[i].Bar:SetText( string.sub(BAR_TEXT, 1, tmpList[i].totalBarLength) )

			if XBT_DB.showIcon then
				sdTimer[i].icon:SetTexture(tmpList[i].iconTex)
				sdTimer[i].spellText2:SetText("")
				if XBT_DB.showSpellName then
					sdTimer[i].spellText:SetText(tmpList[i].spellName)
				else
					sdTimer[i].spellText:SetText("")
				end
				if tmpList[i].stacks > 0 then
					sdTimer[i].stacktext:SetText(tmpList[i].stacks)
				else
					sdTimer[i].stacktext:SetText(nil)
				end
			else
				sdTimer[i].icon:SetTexture(nil)
				sdTimer[i].spellText:SetText("")
				sdTimer[i].stacktext:SetText(nil)
				if tmpList[i].stacks > 0 then
					sdTimer[i].spellText2:SetText(tmpList[i].spellName.." ["..tmpList[i].stacks.."]")
				else
					sdTimer[i].spellText2:SetText(tmpList[i].spellName)
				end
			end
			if tmpList[i].isInfinite then
				sdTimer[i].timetext:SetText("∞")
				sdTimer[i].Bar:SetTextColor(128/255,128/255,128/255)
			else
				sdTimer[i].timetext:SetText(addon:GetTimeText(ceil(tmpList[i].beforeEnd)))
				sdTimer[i].Bar:SetTextColor(addon:getBarColor(tmpList[i].durationTime, tmpList[i].beforeEnd))
			end
			---------------------------------------

			sdTimer[i]:Show()
		else
			sdTimer[i]:Hide()
		end
    end

	locked = false
end

----------------------
-- Local Functions  --
----------------------


function addon:SaveLayout(frame)
	if type(frame) ~= "string" then return end
	if not _G[frame] then return end
	if not XBT_DB then XBT_DB = {} end

	local opt = XBT_DB[frame] or nil

	if not opt then
		XBT_DB[frame] = {
			["point"] = "CENTER",
			["relativePoint"] = "CENTER",
			["xOfs"] = 0,
			["yOfs"] = 0,
		}
		opt = XBT_DB[frame]
		return
	end

	local point, relativeTo, relativePoint, xOfs, yOfs = _G[frame]:GetPoint()
	opt.point = point
	opt.relativePoint = relativePoint
	opt.xOfs = xOfs
	opt.yOfs = yOfs
end

function addon:RestoreLayout(frame)
	if type(frame) ~= "string" then return end
	if not _G[frame] then return end
	if not XBT_DB then XBT_DB = {} end

	local opt = XBT_DB[frame] or nil

	if not opt then
		XBT_DB[frame] = {
			["point"] = "CENTER",
			["relativePoint"] = "CENTER",
			["xOfs"] = 0,
			["yOfs"] = 0,
		}
		opt = XBT_DB[frame]
	end

	_G[frame]:ClearAllPoints()
	_G[frame]:SetPoint(opt.point, UIParent, opt.relativePoint, opt.xOfs, opt.yOfs)
end

function addon:getBarColor(dur, expR)
	if dur <= 0 then
		return 0, 183/255, 239/255
	end
	local r
	local g = 1
	local cur = 2 * expR/dur
	if cur > 1 then
		return 2 - cur, 1, 0
	else
		return 1, cur, 0
	end
end

function addon:GetTimeText(timeLeft)
	if timeLeft <= 0 then return nil end

	local hours, minutes, seconds = 0, 0, 0
	if( timeLeft >= 3600 ) then
		hours = ceil(timeLeft / 3600)
		timeLeft = mod(timeLeft, 3600)
	end

	if( timeLeft >= 60 ) then
		minutes = ceil(timeLeft / 60)
		timeLeft = mod(timeLeft, 60)
	end

	seconds = timeLeft > 0 and timeLeft or 0

	if hours > 0 then
		return string.format("%d"..L.TimeHour, hours)
	elseif minutes > 0 then
		return string.format("%d"..L.TimeMinute, minutes)
	elseif seconds > 0 then
		return string.format("%d"..L.TimeSecond, seconds)
	else
		return nil
	end
end
