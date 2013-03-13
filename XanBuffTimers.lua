
local timersTarget = {}
local timersFocus = {}
local timersPlayer = {}
local MAX_TIMERS = 15
local ICON_SIZE = 20
local BAR_ADJUST = 25
local BAR_TEXT = "llllllllllllllllllllllllllllllllllllllll"
local band = bit.band
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

local f = CreateFrame("frame","xanBuffTimers",UIParent)
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

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

	--create our anchors
	f:CreateAnchor("XBT_TargetAnchor", UIParent, "xanBuffTimers: Target Anchor")
	f:CreateAnchor("XBT_FocusAnchor", UIParent, "xanBuffTimers: Focus Anchor")
	f:CreateAnchor("XBT_PlayerAnchor", UIParent, "xanBuffTimers: Player Anchor")
	
	playerGUID = UnitGUID("player")
	f:ProcessBuffs("player", timersPlayer)
	
	f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	f:RegisterEvent("PLAYER_TARGET_CHANGED")
	f:RegisterEvent("PLAYER_FOCUS_CHANGED")

	SLASH_XANBUFFTIMERS1 = "/xanbufftimers"
	SLASH_XANBUFFTIMERS2 = "/xbt"
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
						for i=1, #timersTarget do
							timersTarget[i]:SetScale(tonumber(scalenum))
						end
						for i=1, #timersFocus do
							timersFocus[i]:SetScale(tonumber(scalenum))
						end
						for i=1, #timersPlayer do
							timersPlayer[i]:SetScale(tonumber(scalenum))
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
					f:ClearBuffs(timersTarget)
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show target tracking [|cFF99CC33OFF|r]")
				else
					XBT_DB.showTarget = true
					f:ProcessBuffs("target", timersTarget)
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show target tracking [|cFF99CC33ON|r]")
				end
				return true
			elseif c and c:lower() == "focus" then
				if XBT_DB.showFocus then
					XBT_DB.showFocus = false
					f:ClearBuffs(timersFocus)
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show focus tracking [|cFF99CC33OFF|r]")
				else
					XBT_DB.showFocus = true
					f:ProcessBuffs("focus", timersFocus)
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show focus tracking [|cFF99CC33ON|r]")
				end
				return true
			elseif c and c:lower() == "player" then
				if XBT_DB.showPlayer then
					XBT_DB.showPlayer = false
					f:ClearBuffs(timersPlayer)
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show player tracking [|cFF99CC33OFF|r]")
				else
					XBT_DB.showPlayer = true
					f:ProcessBuffs("player", timersPlayer)
					DEFAULT_CHAT_FRAME:AddMessage("xanBuffTimers: Show player tracking [|cFF99CC33ON|r]")
				end
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
	end
	
	local ver = tonumber(GetAddOnMetadata("xanBuffTimers","Version")) or 'Unknown'
	DEFAULT_CHAT_FRAME:AddMessage("|cFF99CC33xanBuffTimers|r [v|cFFDF2B2B"..ver.."|r] loaded: /xbt")

	f:UnregisterEvent("PLAYER_LOGIN")
	f.PLAYER_LOGIN = nil
end
	
function f:PLAYER_TARGET_CHANGED()
	if not XBT_DB.showTarget then return end
	if UnitName("target") and UnitGUID("target") then
		targetGUID = UnitGUID("target")
		f:ProcessBuffs("target", timersTarget)
	else
		f:ClearBuffs(timersTarget)
		targetGUID = 0
	end
end

function f:PLAYER_FOCUS_CHANGED()
	if not XBT_DB.showFocus then return end
	if UnitName("focus") and UnitGUID("focus") then
		focusGUID = UnitGUID("focus")
		f:ProcessBuffs("focus", timersFocus)
	else
		f:ClearBuffs(timersFocus)
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
}

function f:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, hideCaster, sourceGUID, sourceName, srcFlags, sourceRaidFlags, dstGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType, amount)

    if eventType == "UNIT_DIED" or eventType == "UNIT_DESTROYED" then
		--clear the buffs if the unit died
		--NOTE the reason an elseif isn't used is because some dorks may have
		--their current target as their focus as well
		if dstGUID == targetGUID and XBT_DB.showTarget then
			f:ClearBuffs(timersTarget)
			targetGUID = 0
		end
		if dstGUID == focusGUID and XBT_DB.showFocus then
			f:ClearBuffs(timersFocus)
			focusGUID = 0
		end
		if dstGUID == playerGUID and XBT_DB.showPlayer then
			f:ClearBuffs(timersPlayer)
		end
		
	elseif eventSwitch[eventType] and band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 then
		--process the spells based on GUID
		if dstGUID == targetGUID and XBT_DB.showTarget then
			f:ProcessBuffs("target", timersTarget)
		end
		if dstGUID == focusGUID and XBT_DB.showFocus then
			f:ProcessBuffs("focus", timersFocus)
		end
		if dstGUID == playerGUID and XBT_DB.showPlayer then
			f:ProcessBuffs("player", timersPlayer)
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
	frameAnchor:SetBackdropColor(0,183/255,239/255,1)
	frameAnchor:SetBackdropBorderColor(0,183/255,239/255,1)

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

local TimerOnUpdate = function(self, time)

	if self.active then
		self.OnUpdateCounter = (self.OnUpdateCounter or 0) + time
		if self.OnUpdateCounter < 0.05 then return end
		self.OnUpdateCounter = 0

		--we need to check for noncanceling auras if on
		local beforeEnd
		local barLength
		
		--this is in case of auras with everlasting buffs (Infinite)
		if XBT_DB and XBT_DB.showInfinite and self.durationTime <= 0 then
			beforeEnd = 0
			barLength = string.len(BAR_TEXT)
			self:SetAlpha(0.5)
		else
			beforeEnd = self.endTime - GetTime()
			barLength = ceil( string.len(BAR_TEXT) * (beforeEnd / self.durationTime) )
			self:SetAlpha(1)
		end
		
		--check the string length JUST in case for errors
		if barLength > string.len(BAR_TEXT) then barLength = string.len(BAR_TEXT) end

		if barLength <= 0 then
			self.active = false
			self:Hide()
			f:ArrangeBuffs(true, self.id)
			return               
		end
		
		self.tmpBL = barLength
		self.Bar:SetText( string.sub(BAR_TEXT, 1, barLength) )
		self.Bar:SetTextColor(f:getBarColor(self.durationTime, beforeEnd))
		if self.stacks > 0 then
			self.stacktext:SetText(self.stacks)
		else
			self.stacktext:SetText(nil)
		end
		self.timetext:SetText(f:GetTimeText(ceil(beforeEnd)))
		f:ArrangeBuffs(true, self.id)
	end
	
end

function f:CreateBuffTimers()
	
    local Frm = CreateFrame("Frame", nil, UIParent)
	
    Frm.active = false
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
		
    Frm:SetScript("OnUpdate", TimerOnUpdate)

	Frm:Hide()
    
	return Frm
	
end

----------------------
-- Buff Functions --
----------------------

function f:ProcessBuffs(sT, sdTimer)
	--only process for as many timers as we are using
	local slotNum = 0
	
	for i=1, MAX_TIMERS do
		local name, _, icon, count, _, duration, expTime, unitCaster, _, _, spellId = UnitAura(sT, i, 'HELPFUL|PLAYER')
		if not name then break end 
		
		local passChk = false
		
		--only allow non-cancel auras if the user allowed it
		if XBT_DB.showInfinite then
			--auras are on so basically were allowing everything
			passChk = true
		elseif not XBT_DB.showInfinite and duration and duration > 0 then 
			--auras are not on but the duration is greater then zero, so allow
			passChk = true
		end
		
		if passChk and name and unitCaster and unitCaster == "player" then
			--get the next timer slot we can use
			slotNum = slotNum + 1
			if not sdTimer[slotNum] then sdTimer[slotNum] = f:CreateBuffTimers() end --create the timer if it doesn't exist
			if not duration or duration <= 0 then 
				sdTimer[slotNum].isInfinite = true
				expTime = 0
			else
				sdTimer[slotNum].isInfinite = false
			end
			sdTimer[slotNum].id = sT
			sdTimer[slotNum].spellName = name
			sdTimer[slotNum].spellId = spellId
			
			--change the timer text according if we have icon or not and wether we are displaying spell name or not
			if XBT_DB.showIcon then
				sdTimer[slotNum].iconTex = icon
				sdTimer[slotNum].icon:SetTexture(icon)
				sdTimer[slotNum].showIcon = true
				sdTimer[slotNum].spellText2:SetText("")
				sdTimer[slotNum].stacks = count or 0
				if XBT_DB.showSpellName then
					sdTimer[slotNum].spellText:SetText(name)
				else
					sdTimer[slotNum].spellText:SetText("")
					sdTimer[slotNum].spellText2:SetText("")
				end
			else
				sdTimer[slotNum].iconTex = icon
				sdTimer[slotNum].icon:SetTexture(nil)
				sdTimer[slotNum].showIcon = false
				sdTimer[slotNum].spellText:SetText("")
				sdTimer[slotNum].stacks = 0
				sdTimer[slotNum].spellText2:SetText(name)
			end

			sdTimer[slotNum].startTime = (expTime - duration) or 0
			sdTimer[slotNum].durationTime = duration or 0
			sdTimer[slotNum].endTime = expTime or 0
				--this has to check for duration=0 because we cannot divide by zero
				local tmpBL
				if duration > 0 then
					tmpBL = ceil( string.len(BAR_TEXT) * ( (expTime - GetTime()) / duration ) )
				elseif duration <= 0 then
					tmpBL = string.len(BAR_TEXT)
				end
				if tmpBL > string.len(BAR_TEXT) then tmpBL = string.len(BAR_TEXT) end
			sdTimer[slotNum].tmpBL = tmpBL
			sdTimer[slotNum].active = true
			if not sdTimer[slotNum]:IsVisible() then sdTimer[slotNum]:Show() end
		end
	end
	--clear everything else
	for i=(slotNum+1), #sdTimer do
		if sdTimer[i] then
			sdTimer[i].active = false
			if sdTimer[i]:IsVisible() then sdTimer[i]:Hide() end
		end
	end
	if slotNum > 0 then
		f:ArrangeBuffs(false, sT)
	end
end

function f:ClearBuffs(sdTimer)
	local adj = 0

	for i=1, #sdTimer do
		if sdTimer[i].active then
			sdTimer[i].active = false
		end
		--reset the order
		if XBT_DB.grow then
			sdTimer[i]:ClearAllPoints()
			sdTimer[i]:SetPoint("TOPLEFT", pointT[sdTimer[i].id], "BOTTOMRIGHT", 0, adj)
		else
			sdTimer[i]:ClearAllPoints()
			sdTimer[i]:SetPoint("BOTTOMLEFT",  pointT[sdTimer[i].id], "TOPRIGHT", 0, (adj * -1))
		end
		adj = adj - BAR_ADJUST

		if sdTimer[i]:IsVisible() then sdTimer[i]:Hide() end
	end
	
end

function f:ReloadBuffs()
	f:ClearBuffs(timersTarget)
	f:ClearBuffs(timersFocus)
	f:ClearBuffs(timersPlayer)
	f:ProcessBuffs("target", timersTarget)
	f:ProcessBuffs("focus", timersFocus)
	f:ProcessBuffs("player", timersPlayer)
end

function f:ArrangeBuffs(throttle, id)
	--to prevent spam and reduce CPU use
	if throttle then
		if not f.ADT then f.ADT = GetTime() end
		if (GetTime() - f.ADT) < 0.1 then
			return
		end
		f.ADT = GetTime()
	end

	local adj = 0
	local sdTimer
	
	if id == "target" then
		sdTimer = timersTarget
	elseif id == "focus" then
		sdTimer = timersFocus
	elseif id == "player" then
		sdTimer = timersPlayer
	else
		return
	end
	
	if XBT_DB.grow then
		--bars will grow down
		if XBT_DB.sort then
			--sort from shortest to longest
			table.sort(sdTimer, function(a,b)
				if a.active == true and b.active == false then
					return true;
				elseif a.active and b.active and b.isInfinite then
					return false;
				elseif a.active and b.active and not b.isInfinite then
					return (a.tmpBL < b.tmpBL);
				end
				return false;
			end)
		else
			--sort from longest to shortest
			table.sort(sdTimer, function(a,b)
				if a.active == true and b.active == false then
					return true;
				elseif a.active and b.active and a.isInfinite then
					return true;
				elseif a.active and b.active and not a.isInfinite then
					return (a.tmpBL > b.tmpBL);
				end
				return false;
			end)
		end
	else
		--bars will grow up
		if XBT_DB.sort then
			--sort from shortest to longest
			table.sort(sdTimer, function(a,b)
				if a.active == true and b.active == false then
					return true;
				elseif a.active and b.active and a.isInfinite then
					return true;
				elseif a.active and b.active and not a.isInfinite then
					return (a.tmpBL > b.tmpBL);
				end
				return false;
			end)
		else
			--sort from longest to shortest
			table.sort(sdTimer, function(a,b)
				if a.active == true and b.active == false then
					return true;
				elseif a.active and b.active and b.isInfinite then
					return false;
				elseif a.active and b.active and not b.isInfinite then
					return (a.tmpBL < b.tmpBL);
				end
				return false;
			end)
		end
	end

	--rearrange order
	for i=1, #sdTimer do
		if XBT_DB.grow then
			sdTimer[i]:ClearAllPoints()
			sdTimer[i]:SetPoint("TOPLEFT", pointT[sdTimer[i].id], "BOTTOMRIGHT", 0, adj)
		else
			sdTimer[i]:ClearAllPoints()
			sdTimer[i]:SetPoint("BOTTOMLEFT", pointT[sdTimer[i].id], "TOPRIGHT", 0, (adj * -1))
		end
		adj = adj - BAR_ADJUST
    end
	
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
