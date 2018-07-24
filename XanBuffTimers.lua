
local timersTarget = {}
local timersFocus = {}
local timersPlayer = {}
local MAX_TIMERS = 15
local ICON_SIZE = 20
local BAR_ADJUST = 25
local BAR_TEXT = "llllllllllllllllllllllllllllllllllllllll"
local band = bit.band
local locked = false

local targetGUID = 0
local focusGUID = 0
local playerGUID = 0
local UnitAura = UnitAura
local UnitIsUnit = UnitIsUnit
local UnitGUID = UnitGUID
local UnitName = UnitName

local pointT = {
	["target"] = "XBT_TargetAnchor",
	["focus"] = "XBT_FocusAnchor",
	["player"] = "XBT_PlayerAnchor",
}

local timerList = {
	["target"] = timersTarget,
	["focus"] = timersFocus,
	["player"] = timersPlayer,
}

local f = CreateFrame("frame","xanBuffTimers",UIParent)
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

local debugf = tekDebug and tekDebug:GetFrame("xanBuffTimers")
local function Debug(...)
    if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end
end

--buff arrays
timersTarget.buffs = {}
timersFocus.buffs = {}
timersPlayer.buffs = {}

----------------------
--      Enable      --
----------------------
	
function f:PLAYER_LOGIN()

	if not XBT_DB then XBT_DB = {} end
	if XBT_DB.scale == nil then XBT_DB.scale = 1 end
	if XBT_DB.grow == nil then XBT_DB.grow = false end
	if XBT_DB.sort == nil then XBT_DB.sort = false end
	if XBT_DB.showTarget == nil then XBT_DB.showTarget = true end
	if XBT_DB.showFocus == nil then XBT_DB.showFocus = true end
	if XBT_DB.showPlayer == nil then XBT_DB.showPlayer = true end
	if XBT_DB.showInfinite == nil then XBT_DB.showInfinite = false end
	if XBT_DB.showIcon == nil then XBT_DB.showIcon = true end
	if XBT_DB.showSpellName == nil then XBT_DB.showSpellName = false end
	if XBT_DB.healersOnly == nil then XBT_DB.healersOnly = false end
	
	
	--create our anchors
	f:CreateAnchor("XBT_TargetAnchor", UIParent, "xanBuffTimers: Target Anchor")
	f:CreateAnchor("XBT_FocusAnchor", UIParent, "xanBuffTimers: Focus Anchor")
	f:CreateAnchor("XBT_PlayerAnchor", UIParent, "xanBuffTimers: Player Anchor")

	--
	playerGUID = UnitGUID("player")
	
	--create our bars
	f:generateBars()
	
	f:UnregisterEvent("PLAYER_LOGIN")
	f.PLAYER_LOGIN = nil
	
	f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	f:RegisterEvent("PLAYER_TARGET_CHANGED")
	f:RegisterEvent("PLAYER_FOCUS_CHANGED")

	SLASH_XANBUFFTIMERS1 = "/xanbufftimers"
	SLASH_XANBUFFTIMERS2 = "/xbt"
	SLASH_XANBUFFTIMERS3 = "/xanbt"
	SlashCmdList["XANBUFFTIMERS"] = function(msg)
	
		local a,b,c=strfind(msg, "(%S+)"); --contiguous string of non-space characters
		
		if a then
			if c and c:lower() == "anchor" then
				if XBT_TargetAnchor:IsVisible() then
					XBT_TargetAnchor:Hide()
					XBT_FocusAnchor:Hide()
					XBT_PlayerAnchor:Hide()
				else
					XBT_TargetAnchor:Show()
					XBT_FocusAnchor:Show()
					XBT_PlayerAnchor:Show()
				end
				return true
			elseif c and c:lower() == "scale" then
				if b then
					local scalenum = strsub(msg, b+2)
					if scalenum and scalenum ~= "" and tonumber(scalenum) then
						XBT_DB.scale = tonumber(scalenum)
						for i=1, MAX_TIMERS do
							if timersTarget[i] then
								timersTarget[i]:SetScale(tonumber(scalenum))
							end
							if timersFocus[i] then
								timersFocus[i]:SetScale(tonumber(scalenum))
							end
							if timersPlayer[i] then
								timersPlayer[i]:SetScale(tonumber(scalenum))
							end
						end
						DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Scale has been set to ["..tonumber(scalenum).."]")
						return true
					end
				end
			elseif c and c:lower() == "grow" then
				if XBT_DB.grow then
					XBT_DB.grow = false
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Bars will now grow [|cFF99CC33UP|r]")
				else
					XBT_DB.grow = true
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Bars will now grow [|cFF99CC33DOWN|r]")
				end
				f:adjustBars()
				return true
			elseif c and c:lower() == "sort" then
				if XBT_DB.sort then
					XBT_DB.sort = false
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Bars sort [|cFF99CC33DESCENDING|r]")
				else
					XBT_DB.sort = true
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Bars sort [|cFF99CC33ASCENDING|r]")
				end
				return true
			elseif c and c:lower() == "target" then
				if XBT_DB.showTarget then
					XBT_DB.showTarget = false
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show target tracking [|cFF99CC33OFF|r]")
				else
					XBT_DB.showTarget = true
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show target tracking [|cFF99CC33ON|r]")
				end
				f:ReloadBuffs()
				return true
			elseif c and c:lower() == "focus" then
				if XBT_DB.showFocus then
					XBT_DB.showFocus = false
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show focus tracking [|cFF99CC33OFF|r]")
				else
					XBT_DB.showFocus = true
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show focus tracking [|cFF99CC33ON|r]")
				end
				f:ReloadBuffs()
				return true
			elseif c and c:lower() == "player" then
				if XBT_DB.showPlayer then
					XBT_DB.showPlayer = false
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show player tracking [|cFF99CC33OFF|r]")
				else
					XBT_DB.showPlayer = true
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show player tracking [|cFF99CC33ON|r]")
				end
				f:ReloadBuffs()
				return true
			elseif c and c:lower() == "infinite" then
				if XBT_DB.showInfinite then
					XBT_DB.showInfinite = false
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show buffs whom have no durations/timers (Infinite) [|cFF99CC33OFF|r]")
				else
					XBT_DB.showInfinite = true
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show buffs whom have no durations/timers (Infinite) [|cFF99CC33ON|r]")
				end
				f:ReloadBuffs()
				return true
			elseif c and c:lower() == "icon" then
				if XBT_DB.showIcon then
					XBT_DB.showIcon = false
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show buff icons [|cFF99CC33OFF|r]")
				else
					XBT_DB.showIcon = true
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show buff icons [|cFF99CC33ON|r]")
				end
				f:ReloadBuffs()
				return true
			elseif c and c:lower() == "spellname" then
				if XBT_DB.showSpellName then
					XBT_DB.showSpellName = false
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show buff spell names [|cFF99CC33OFF|r]")
				else
					XBT_DB.showSpellName = true
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show buff spell names [|cFF99CC33ON|r]")
				end
				f:ReloadBuffs()
				return true
			elseif c and c:lower() == "healers" then
				if XBT_DB.healersOnly then
					XBT_DB.healersOnly = false
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show for healers only [|cFF99CC33OFF|r]")
				else
					XBT_DB.healersOnly = true
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show for healers only [|cFF99CC33ON|r]")
				end
				f:ReloadBuffs()
				return true
			elseif c and c:lower() == "reload" then
				f:ReloadBuffs()
				return true
			end
		end

		DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt anchor - toggles the movable anchor frames")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt scale # - sets the scale size of the bars")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt grow - changes the direction in which the bars grow (UP/DOWN)")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt sort - changes the sorting of the bars. (ASCENDING/DESCENDING)")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt target - toggles target tracking (ON/OFF)")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt focus - toggles focus tracking (ON/OFF)")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt player - toggles player tracking (ON/OFF)")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt infinite - toggles displaying buffs whom have no duration/timers (ON/OFF)")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt icon - toggles displaying of buff icons (ON/OFF)")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt spellname - toggles displaying of buff spell names (ON/OFF)")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt healers - toggles displaying of buff bars for only healing classes (ON/OFF)")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt reload - reload all the buff bars")
		
	end
	
	local ver = tonumber(GetAddOnMetadata("xanBuffTimers","Version")) or 'Unknown'
	DEFAULT_CHAT_FRAME:AddMessage("|cFF99CC33xanBuffTimers|r [v|cFFDF2B2B"..ver.."|r] loaded: /xbt")
end
	
function f:PLAYER_TARGET_CHANGED()
	if not XBT_DB.showTarget then return end
	if UnitName("target") and UnitGUID("target") then
		targetGUID = UnitGUID("target")
		f:ProcessBuffs("target")
	else
		f:ClearBuffs("target")
		targetGUID = 0
	end
end

function f:PLAYER_FOCUS_CHANGED()
	if not XBT_DB.showFocus then return end
	if UnitName("focus") and UnitGUID("focus") then
		focusGUID = UnitGUID("focus")
		f:ProcessBuffs("focus")
	else
		f:ClearBuffs("focus")
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

function f:COMBAT_LOG_EVENT_UNFILTERED()

	--local timestamp, eventType, hideCaster, sourceGUID, sourceName, srcFlags, sourceRaidFlags, dstGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType, amount
	local timestamp, eventType, _, sourceGUID, _, srcFlags, _, dstGUID = CombatLogGetCurrentEventInfo()

    if eventType == "UNIT_DIED" or eventType == "UNIT_DESTROYED" then
		--clear the buffs if the unit died
		--NOTE the reason an elseif isn't used is because some dorks may have
		--their current target as their focus as well
		if dstGUID == targetGUID and XBT_DB.showTarget then
			f:ClearBuffs("target")
			targetGUID = 0
		end
		if dstGUID == focusGUID and XBT_DB.showFocus then
			f:ClearBuffs("focus")
			focusGUID = 0
		end
		if dstGUID == playerGUID and XBT_DB.showPlayer then
			f:ClearBuffs("player")
		end
		
	elseif eventSwitch[eventType] and band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 then
		--process the spells based on GUID
		if dstGUID == targetGUID and XBT_DB.showTarget then
			f:ProcessBuffs("target")
		end
		if dstGUID == focusGUID and XBT_DB.showFocus then
			f:ProcessBuffs("focus")
		end
		if dstGUID == playerGUID and XBT_DB.showPlayer then
			f:ProcessBuffs("player")
		end
    end
end

----------------------
--  Frame Creation  --
----------------------

function f:CreateAnchor(name, parent, desc)

	--create the anchor
	local frameAnchor = CreateFrame("Frame", name, parent)
	
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
			f:SaveLayout(frame:GetName())
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
	
	f:RestoreLayout(name)
end

function f:CreateBuffTimers()
	
    local Frm = CreateFrame("Frame", nil, UIParent)

    Frm:SetWidth(ICON_SIZE)
    Frm:SetHeight(ICON_SIZE)
	Frm:SetFrameStrata("LOW")
	Frm:SetScale(XBT_DB.scale)
	
    Frm.icon = Frm:CreateTexture(nil, "BACKGROUND")
    Frm.icon:SetTexCoord(.07, .93, .07, .93)
    Frm.icon:SetWidth(ICON_SIZE)
    Frm.icon:SetHeight(ICON_SIZE)
	Frm.icon:SetTexture("Interface\\Icons\\Spell_Shadow_Shadowbolt")
    Frm.icon:SetAllPoints(true)
    
    Frm.stacktext = Frm:CreateFontString(nil, "OVERLAY");
    Frm.stacktext:SetFont("Fonts\\FRIZQT__.TTF",10,"OUTLINE")
    Frm.stacktext:SetWidth(Frm.icon:GetWidth())
    Frm.stacktext:SetHeight(Frm.icon:GetHeight())
    Frm.stacktext:SetJustifyH("RIGHT")
    Frm.stacktext:SetVertexColor(1,1,1)
    Frm.stacktext:SetPoint("RIGHT", Frm.icon, "RIGHT",1,-5)
    
    Frm.timetext = Frm:CreateFontString(nil, "OVERLAY");
    Frm.timetext:SetFont("Fonts\\FRIZQT__.TTF",10,"OUTLINE")
    Frm.timetext:SetJustifyH("RIGHT")
    Frm.timetext:SetPoint("LEFT", Frm.icon, "RIGHT", 5, 0)

    Frm.spellText = Frm:CreateFontString(nil, "OVERLAY");
    Frm.spellText:SetFont("Fonts\\FRIZQT__.TTF",10,"OUTLINE")
	Frm.spellText:SetTextColor(0,183/255,239/255)
    Frm.spellText:SetJustifyH("RIGHT")
    Frm.spellText:SetPoint("RIGHT", Frm.icon, "LEFT" , -5, 0)
	
    Frm.spellText2 = Frm:CreateFontString(nil, "OVERLAY");
    Frm.spellText2:SetFont("Fonts\\FRIZQT__.TTF",10,"OUTLINE")
	Frm.spellText2:SetTextColor(0,183/255,239/255)
    Frm.spellText2:SetJustifyH("RIGHT")
    Frm.spellText2:SetPoint("RIGHT", Frm.icon, "LEFT" , 20, 0)
	
	Frm.Bar = Frm:CreateFontString(nil, "GameFontNormal")
	Frm.Bar:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE, MONOCHROME")
	Frm.Bar:SetText(BAR_TEXT)
	Frm.Bar:SetPoint("LEFT", Frm.icon, "RIGHT", 30, 0)
	
	Frm:Hide()
    
	return Frm

end

function f:generateBars()
	local adj = 0
	
	--lets create the max bars to use on screen for future sorting
	for i=1, MAX_TIMERS do
		timersTarget[i] = f:CreateBuffTimers()
		timersFocus[i] = f:CreateBuffTimers()
		timersPlayer[i] = f:CreateBuffTimers()
		if not timersTarget.buffs[i] then timersTarget.buffs[i] = {} end
		if not timersFocus.buffs[i] then timersFocus.buffs[i] = {} end
		if not timersPlayer.buffs[i] then timersPlayer.buffs[i] = {} end
	end
		
	--rearrange order
	for i=1, MAX_TIMERS do
		if XBT_DB.grow then
			timersTarget[i]:ClearAllPoints()
			timersTarget[i]:SetPoint("TOPLEFT", XBT_TargetAnchor, "BOTTOMRIGHT", 0, adj)
			timersFocus[i]:ClearAllPoints()
			timersFocus[i]:SetPoint("TOPLEFT", XBT_FocusAnchor, "BOTTOMRIGHT", 0, adj)
			timersPlayer[i]:ClearAllPoints()
			timersPlayer[i]:SetPoint("TOPLEFT", XBT_PlayerAnchor, "BOTTOMRIGHT", 0, adj)			
		else
			timersTarget[i]:ClearAllPoints()
			timersTarget[i]:SetPoint("BOTTOMLEFT", XBT_TargetAnchor, "TOPRIGHT", 0, (adj * -1))
			timersFocus[i]:ClearAllPoints()
			timersFocus[i]:SetPoint("BOTTOMLEFT", XBT_FocusAnchor, "TOPRIGHT", 0, (adj * -1))
			timersPlayer[i]:ClearAllPoints()
			timersPlayer[i]:SetPoint("BOTTOMLEFT", XBT_PlayerAnchor, "TOPRIGHT", 0, (adj * -1))
		end
		adj = adj - BAR_ADJUST
    end

end

function f:adjustBars()
	local adj = 0
	for i=1, MAX_TIMERS do
		if XBT_DB.grow then
			timersTarget[i]:ClearAllPoints()
			timersTarget[i]:SetPoint("TOPLEFT", XBT_TargetAnchor, "BOTTOMRIGHT", 0, adj)
			timersFocus[i]:ClearAllPoints()
			timersFocus[i]:SetPoint("TOPLEFT", XBT_FocusAnchor, "BOTTOMRIGHT", 0, adj)
			timersPlayer[i]:ClearAllPoints()
			timersPlayer[i]:SetPoint("TOPLEFT", XBT_PlayerAnchor, "BOTTOMRIGHT", 0, adj)			
		else
			timersTarget[i]:ClearAllPoints()
			timersTarget[i]:SetPoint("BOTTOMLEFT", XBT_TargetAnchor, "TOPRIGHT", 0, (adj * -1))
			timersFocus[i]:ClearAllPoints()
			timersFocus[i]:SetPoint("BOTTOMLEFT", XBT_FocusAnchor, "TOPRIGHT", 0, (adj * -1))
			timersPlayer[i]:ClearAllPoints()
			timersPlayer[i]:SetPoint("BOTTOMLEFT", XBT_PlayerAnchor, "TOPRIGHT", 0, (adj * -1))
		end
		adj = adj - BAR_ADJUST
    end
end

function f:ProcessBuffBar(data)
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
f:SetScript("OnUpdate", function(self, elapsed)
	self.OnUpdateCounter = (self.OnUpdateCounter or 0) + elapsed
	if self.OnUpdateCounter < 0.05 then return end
	self.OnUpdateCounter = 0

	local tCount = 0
	local fCount = 0
	local pCount = 0
	
	for i=1, MAX_TIMERS do
		if timersTarget.buffs[i].active then
			self:ProcessBuffBar(timersTarget.buffs[i])
			tCount = tCount + 1
		end
		if timersFocus.buffs[i].active then
			self:ProcessBuffBar(timersFocus.buffs[i])
			fCount = fCount + 1
		end
		if timersPlayer.buffs[i].active then
			self:ProcessBuffBar(timersPlayer.buffs[i])
			pCount = pCount + 1
		end
	end
	
	--no need to arrange the bars if there is nothing to work with, uncessary if no target or focus
	if tCount > 0 then
		f:ShowBuffs("target")
	end
	if fCount > 0 then
		f:ShowBuffs("focus")
	end
	if pCount > 0 then
		f:ShowBuffs("player")
	end
	
end)

function f:ProcessBuffs(id)
	local sdTimer = timerList[id] --makes things easier to read
	
	for i=1, MAX_TIMERS do
		local name, icon, count, debuffType, duration, expTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellId = UnitAura(id, i, 'PLAYER|HELPFUL')
		
		local passChk = false
		local isInfinite = false
		
		--only allow non-cancel auras if the user allowed it
		if XBT_DB.showInfinite then
			--auras are on so basically were allowing everything
			passChk = true
			if not duration or duration <= 0 then 
				isInfinite = true
			end
		elseif not XBT_DB.showInfinite and duration and duration > 0 then 
			--auras are not on but the duration is greater then zero, so allow
			passChk = true
		end
		
		--check for duration > 0 for the evil DIVIDE BY ZERO
		if name and passChk then
			local beforeEnd = 0
			local startTime = 0
			local totalDuration = 0
			local totalBarSegment = 0
			local totalBarLength = 0
			local barPercent = 0
		
			if isInfinite then
				barPercent = 200 --anything higher than 100 will get pushed to top of list, so lets make it 200 -> f:ShowBuffs(id)
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
				sdTimer.buffs[i].id = id
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

	f:ShowBuffs(id)
end

function f:ClearBuffs(id)
	local sdTimer = timerList[id] --makes things easier to read
	local adj = 0

	for i=1, MAX_TIMERS do
		sdTimer.buffs[i].active = false
		sdTimer[i]:Hide()
	end
	
end

function f:ReloadBuffs()
	local class = select(2, UnitClass("player"))

	local healers = {
		["DRUID"] = true,
		["SHAMAN"] = true,
		["MONK"] = true,
		["PRIEST"] = true,
		["PALADIN"] = true,
	}

	f:ClearBuffs("target")
	f:ClearBuffs("focus")
	f:ClearBuffs("player")
	
	if XBT_DB.healersOnly and not healers[class] then
		return
	end
	
	if XBT_DB.showTarget then
		f:ProcessBuffs("target")
	end
	if XBT_DB.showFocus then
		f:ProcessBuffs("focus")
	end
	if XBT_DB.showPlayer then
		f:ProcessBuffs("player")
	end
end

function f:ShowBuffs(id)

	if locked then return end
	locked = true
	
	local sdTimer
	local tmpList = {}

	if id == "target" then
		sdTimer = timersTarget
	elseif id == "focus" then
		sdTimer = timersFocus
	elseif id == "player" then
		sdTimer = timersPlayer
	else
		locked = false
		return
	end
	
	for i=1, MAX_TIMERS do
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
	
	for i=1, MAX_TIMERS do
		if tmpList[i] then
			--display the information
			---------------------------------------
			sdTimer[i].Bar:SetText( string.sub(BAR_TEXT, 1, tmpList[i].totalBarLength) )
			sdTimer[i].Bar:SetTextColor(f:getBarColor(tmpList[i].durationTime, tmpList[i].beforeEnd))
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
			else
				sdTimer[i].timetext:SetText(f:GetTimeText(ceil(tmpList[i].beforeEnd)))
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
	
	
function f:SaveLayout(frame)
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

function f:RestoreLayout(frame)
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

function f:getBarColor(dur, expR)
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

function f:GetTimeText(timeLeft)
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
		return string.format("%dh",hours)
	elseif minutes > 0 then
		return string.format("%dm",minutes)
	elseif seconds > 0 then
		return string.format("%ds",seconds)
	else
		return nil
	end
end

if IsLoggedIn() then f:PLAYER_LOGIN() else f:RegisterEvent("PLAYER_LOGIN") end
