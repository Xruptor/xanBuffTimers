--Inspired by TextTimers

local timers = {}
local timersFocus = {}
local timersPlayer = {}
local math_max = _G.math.max
local math_min = _G.math.min
local MAX_TIMERS = 15
local ICON_SIZE = 20
local BAR_ADJUST = 25
local BAR_TEXT = "llllllllllllllllllllllllllllllllllllllll"

local targetGUID = 0
local focusGUID = 0
local playerGUID = 0
local UnitAura = UnitAura
local UnitIsUnit = UnitIsUnit

local f = CreateFrame("frame","XanBuffTimers",UIParent)
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

----------------------
--      Enable      --
----------------------
	
function f:PLAYER_LOGIN()

	if not XBT_DB then XBT_DB = {} end
	if XBT_DB.scale == nil then XBT_DB.scale = 1 end
	if XBT_DB.grow == nil then XBT_DB.grow = true end

	playerGUID = UnitGUID("player")
	
	--create our anchors
	f:CreateAnchor("XBT_Anchor", UIParent)
	f:CreateAnchor("XBT_FocusAnchor", UIParent)
	f:CreateAnchor("XBT_PlayerAnchor", UIParent)
	
	--create our timers
	for i=1,MAX_TIMERS do
		timers[i] = f:CreateBuffTimers()
		timersFocus[i] = f:CreateBuffTimers()
		timersPlayer[i] = f:CreateBuffTimers()
	end
	
	--do our growth process for the buff bars (SETPOINT)
	f:ProcessGrowth()

	f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	f:RegisterEvent("PLAYER_TARGET_CHANGED")
	f:RegisterEvent("PLAYER_FOCUS_CHANGED")
	f:RegisterEvent("UNIT_AURA")
	
	SLASH_XANBUFFTIMERS1 = "/xanbufftimers"
	SLASH_XANBUFFTIMERS2 = "/xbt"
	SLASH_XANBUFFTIMERS3 = "/xanbt"
	SlashCmdList["XANBUFFTIMERS"] = function(msg)
	
		local a,b,c=strfind(msg, "(%S+)"); --contiguous string of non-space characters
		
		if a then
			if c and c:lower() == "anchor" then
				if XBT_Anchor:IsVisible() then
					XBT_Anchor:Hide()
					XBT_FocusAnchor:Hide()
					XBT_PlayerAnchor:Hide()
				else
					XBT_Anchor:Show()
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
							timers[i]:SetScale(tonumber(scalenum))
							timersFocus[i]:SetScale(tonumber(scalenum))
							timersPlayer[i]:SetScale(tonumber(scalenum))
						end
						DEFAULT_CHAT_FRAME:AddMessage("XanBuffTimers: Scale has been set to ["..tonumber(scalenum).."]")
						return true
					end
				end
			elseif c and c:lower() == "grow" then
				if XBT_DB.grow then
					XBT_DB.grow = false
					DEFAULT_CHAT_FRAME:AddMessage("XanBuffTimers: Bars will now grow [|cFF99CC33UP|r]")
				else
					XBT_DB.grow = true
					DEFAULT_CHAT_FRAME:AddMessage("XanBuffTimers: Bars will now grow [|cFF99CC33DOWN|r]")
				end
				f:ProcessGrowth()
				return true
			end
		end

		DEFAULT_CHAT_FRAME:AddMessage("XanBuffTimers")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt anchor - toggles a movable anchor")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt scale # - sets the scale size of the bars")
		DEFAULT_CHAT_FRAME:AddMessage("/xbt grow - changes the direction in which the bars grow (UP/DOWN)")
	end
	
	local ver = tonumber(GetAddOnMetadata("XanBuffTimers","Version")) or 'Unknown'
	DEFAULT_CHAT_FRAME:AddMessage("|cFF99CC33XanBuffTimers|r [v|cFFDF2B2B"..ver.."|r] loaded: /XBT")
	
	f:UnregisterEvent("PLAYER_LOGIN")
	f.PLAYER_LOGIN = nil
end

function f:UNIT_AURA(event, unit)
	if not unit then return end
	if unit == "target" and UnitGUID(unit) and UnitGUID(unit) == targetGUID then
		f:ProcessBuffs("target", timers)
	elseif unit == "focus" and UnitGUID(unit) and UnitGUID(unit) == focusGUID then
		f:ProcessBuffs("focus", timersFocus)
	elseif unit == "player" and UnitGUID(unit) and UnitGUID(unit) == playerGUID then
		f:ProcessBuffs("player", timersPlayer)
	end
end
	
function f:PLAYER_TARGET_CHANGED()
	if UnitName("target") and UnitGUID("target") then
		targetGUID = UnitGUID("target")
		f:ProcessBuffs("target", timers)
	else
		f:ClearBuffs(timers)
		targetGUID = 0
	end
end

function f:PLAYER_FOCUS_CHANGED()
	if UnitName("focus") and UnitGUID("focus") then
		focusGUID = UnitGUID("focus")
		f:ProcessBuffs("focus", timersFocus)
	else
		f:ClearBuffs(timersFocus)
		focusGUID = 0
	end
end

function f:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellID, spellName, spellSchool, auraType, amount)

    if eventType == "UNIT_DIED" or eventType == "UNIT_DESTROYED" then
		--clear the buffs if the unit died
		--NOTE the reason an elseif isn't used is because some dorks may have
		--their current target as their focus as well
		if dstGUID == targetGUID then
			f:ClearBuffs(timers)
			targetGUID = 0
		end
		if dstGUID == focusGUID then
			f:ClearBuffs(timersFocus)
			focusGUID = 0
		end
    end
end

----------------------
--  Frame Creation  --
----------------------

function f:CreateAnchor(name, parent)

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

		local beforeEnd = self.expiryTime - GetTime()
		local barLength = ceil( string.len(BAR_TEXT) * (beforeEnd / self.durationTime) )
		
		--self.timeleft = math_max(0, self.timeleft - (GetTime() - self.lastUpdate))
		--self.lastUpdate = GetTime()
		--local fraction = math_max(0, math_min(self.timeleft / self.durationTime, 1))
		--local barwidth = string.len(BAR_TEXT) * fraction

		--correct for buffs with no expiration
		if self.durationTime == 0 then
			barLength = string.len(BAR_TEXT)
		end
		
		if barLength <= 0 then
			self.active = false
			self:Hide()
			f:ArrangeBuffs(true, self.id)
			return               
		end
		
		if self.durationTime == 0 then
			self.tmpBL = string.len(BAR_TEXT)
		else
			self.tmpBL = barLength
		end

		self.Bar:SetText( string.sub(BAR_TEXT, 1, barLength) )
		self.Bar:SetTextColor(f:getBarColor(self.durationTime, beforeEnd, false))
		if self.stacks > 0 then
			self.stacktext:SetText(self.stacks)
		else
			self.stacktext:SetText('')
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
    Frm.timetext:SetPoint("RIGHT", Frm.icon, "LEFT" , -5, 0)

	Frm.Bar = Frm:CreateFontString(nil, "GameFontNormal")
	Frm.Bar:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
	Frm.Bar:SetText(BAR_TEXT)
	Frm.Bar:SetPoint("LEFT", Frm.icon, "RIGHT", 1, 0)
		
    Frm:SetScript("OnUpdate", TimerOnUpdate)

	Frm:Hide()
    
	return Frm
	
end

function f:ProcessGrowth()
	local adj = 0
	for i=1,MAX_TIMERS do
		if XBT_DB.grow then
			timers[i]:ClearAllPoints()
			timers[i]:SetPoint("TOPLEFT", "XBT_Anchor", "BOTTOMRIGHT", 0, adj)
			--FOCUS
			timersFocus[i]:ClearAllPoints()
			timersFocus[i]:SetPoint("TOPLEFT", "XBT_FocusAnchor", "BOTTOMRIGHT", 0, adj)
			--PLAYER
			timersPlayer[i]:ClearAllPoints()
			timersPlayer[i]:SetPoint("TOPLEFT", "XBT_PlayerAnchor", "BOTTOMRIGHT", 0, adj)
		else
			timers[i]:ClearAllPoints()
			timers[i]:SetPoint("BOTTOMLEFT", "XBT_Anchor", "TOPRIGHT", 0, (adj * -1))
			--FOCUS
			timersFocus[i]:ClearAllPoints()
			timersFocus[i]:SetPoint("BOTTOMLEFT", "XBT_FocusAnchor", "TOPRIGHT", 0, (adj * -1))
			--PLAYER
			timersPlayer[i]:ClearAllPoints()
			timersPlayer[i]:SetPoint("BOTTOMLEFT", "XBT_PlayerAnchor", "TOPRIGHT", 0, (adj * -1))
		end
		adj = adj - BAR_ADJUST
	end
end
----------------------
-- Buff Functions --
----------------------

function f:ProcessBuffs(sT, sdTimer)
	if f.selfProcessingBuffs then return end
	f.selfProcessingBuffs = true

	--only process for as many timers as we are using
	local countBuffs = 0
	for i=1, MAX_TIMERS do
	local name, _, icon, count, _, duration, expiryTime, unitCaster, _, _, spellId = UnitAura(sT, i, 'HELPFUL')
		if name then
			sdTimer[i].id = sT
			sdTimer[i].spellName = name
			sdTimer[i].spellId = spellId
			sdTimer[i].iconTex = icon
			sdTimer[i].icon:SetTexture(icon)
			sdTimer[i].startTime = expiryTime - duration
			sdTimer[i].durationTime = duration or 0
			sdTimer[i].expiryTime = expiryTime
			--sdTimer[i].timeleft = expiryTime and math_max(0, expiryTime - GetTime()) or 0
			--sdTimer[i].lastUpdate = GetTime()
			sdTimer[i].stacks = count or 0
			
			local tmpBL = ceil( string.len(BAR_TEXT) * ( (expiryTime - GetTime()) / duration ) )
			
			if duration == 0 then
				sdTimer[i].tmpBL = string.len(BAR_TEXT)
			else
				sdTimer[i].tmpBL = tmpBL
			end
			
			sdTimer[i].active = true
			if not sdTimer[i]:IsVisible() then sdTimer[i]:Show() end
			countBuffs = countBuffs + 1
		else
			sdTimer[i].timetext:SetText('')
			sdTimer[i].Bar:SetText('')
			sdTimer[i].icon:SetTexture(nil)
			sdTimer[i].active = false
			if sdTimer[i]:IsVisible() then sdTimer[i]:Hide() end
		end
	end
	
	f.selfProcessingBuffs = nil
	
	if countBuffs > 0 then
		f:ArrangeBuffs(false, sT)
	end
	
end

function f:ClearBuffs(sdTimer)
	for i=1, MAX_TIMERS do
		if sdTimer[i].active then
			sdTimer[i].active = false
		end
		sdTimer[i].timetext:SetText('')
		sdTimer[i].Bar:SetText('')
		sdTimer[i].icon:SetTexture(nil)
		if sdTimer[i]:IsVisible() then sdTimer[i]:Hide() end
	end
end

function f:ArrangeBuffs(throttle, id)
	if f.selfProcessingBuffs then return end
	
	--to prevent spam and reduce CPU use
	if throttle then
		if not f.ADT then f.ADT = GetTime() end
		if (GetTime() - f.ADT) < 0.1 then
			return
		end
		f.ADT = GetTime()
	end

	local adj = 0
	local active = {}
	local pointT
	local sdTimer
	
	if id == "target" then
		sdTimer = timers
		pointT = "XBT_Anchor"
	elseif id == "focus" then
		sdTimer = timersFocus
		pointT = "XBT_FocusAnchor"
	elseif id == "player" then
		sdTimer = timersPlayer
		pointT = "XBT_PlayerAnchor"
	else
		return
	end
	
    for i=1, MAX_TIMERS do
        if sdTimer[i].active then
            table.insert(active, sdTimer[i])
		else
			break
        end
    end
	
	--sort by the size of the progressbar... duh
    table.sort(active, function(a,b) 
		if a.tmpBL > b.tmpBL then
			return true;
		elseif a.tmpBL == b.tmpBL then
			return (a.durationTime < b.durationTime);
		end
	end)

	--rearrange order
	for i=1, #active do
		if XBT_DB.grow then
			active[i]:ClearAllPoints()
			active[i]:SetPoint("TOPLEFT", pointT, "BOTTOMRIGHT", 0, adj)
		else
			active[i]:ClearAllPoints()
			active[i]:SetPoint("BOTTOMLEFT", pointT, "TOPRIGHT", 0, (adj * -1))
		end
		adj = adj - BAR_ADJUST
    end
	
end

----------------------
-- Local Functions  --
----------------------
	
function f:SaveLayout(frame)

	if not XBT_DB then XBT_DB = {} end

	local opt = XBT_DB[frame] or nil;

	if opt == nil then
		XBT_DB[frame] = {
			["point"] = "CENTER",
			["relativePoint"] = "CENTER",
			["xOfs"] = 0,
			["yOfs"] = 0,
		}
		opt = XBT_DB[frame];
	end

	local f = getglobal(frame);
	local scale = f:GetEffectiveScale();
	opt.PosX = f:GetLeft() * scale;
	opt.PosY = f:GetTop() * scale;
end

function f:RestoreLayout(frame)

	if not XBT_DB then XBT_DB = {} end
	
	local f = getglobal(frame);
	local opt = XBT_DB[frame] or nil;

	if opt == nil then
		XBT_DB[frame] = {
			["point"] = "CENTER",
			["relativePoint"] = "CENTER",
			["xOfs"] = 0,
			["yOfs"] = 0,
		}
		opt = XBT_DB[frame];
	end

	local x = opt.PosX;
	local y = opt.PosY;
	local s = f:GetEffectiveScale();

	    if not x or not y then
		f:ClearAllPoints();
		f:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
		return 
	    end

	--calculate the scale
	x,y = x/s,y/s;

	--set the location
	f:ClearAllPoints();
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y);

end

function f:getBarColor(dur, expR, reverse)
	--check for buffs that don't expire
	if dur == 0 then
		return 153/255, 217/255, 234/255
	end
	
	local r
	local g = 1
	local cur = 2 * expR/dur
	if cur > 1 then
		r = 2 - cur
	else
		r = 1
		g = cur
	end
	if reverse then
		return g, r, 0
	else
		return r, g, 0
	end
end

function f:GetTimeText(timeLeft)
	local hours, minutes, seconds = 0, 0, 0
	if( timeLeft >= 3600 ) then
		hours = floor(timeLeft / 3600)
		timeLeft = mod(timeLeft, 3600)
	end

	if( timeLeft >= 60 ) then
		minutes = floor(timeLeft / 60)
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
