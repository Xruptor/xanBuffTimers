local ADDON_NAME, private = ...
if not _G[ADDON_NAME] then
	_G[ADDON_NAME] = CreateFrame("Frame", ADDON_NAME, UIParent, BackdropTemplateMixin and "BackdropTemplate")
end
local addon = _G[ADDON_NAME]

addon.configFrame = CreateFrame("frame", ADDON_NAME.."_config_eventFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
local configFrame = addon.configFrame

local L = (type(private) == "table" and private.L) or {}
local canFocusT = (FocusUnit and FocusFrame) or false

local layout = {
	parent = nil,
	column = nil,
}

local function initLayout(parent)
	layout.parent = parent
	layout.column = { x = 18, y = -10, last = nil }
end

local function addConfigEntry(objEntry, adjustY)
	local col = layout.column
	if not col or not layout.parent then return end

	objEntry:ClearAllPoints()
	if not col.last then
		objEntry:SetPoint("TOPLEFT", layout.parent, "TOPLEFT", col.x, col.y)
	else
		objEntry:SetPoint("LEFT", col.last, "BOTTOMLEFT", 0, adjustY or -18)
	end

	col.last = objEntry
end

local function createHeader(parentFrame, text)
	local header = parentFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	header:SetText(text)
	header:SetHeight(18)
	header:SetJustifyH("LEFT")
	return header
end

local chkBoxIndex = 0
local function createCheckbutton(parentFrame, displayText)
	chkBoxIndex = chkBoxIndex + 1

	local checkbutton = CreateFrame("CheckButton", ADDON_NAME.."_config_chkbtn_" .. chkBoxIndex, parentFrame, "ChatConfigCheckButtonTemplate")
	getglobal(checkbutton:GetName() .. 'Text'):SetText(" "..displayText)

	return checkbutton
end

local buttonIndex = 0
local function createButton(parentFrame, displayText)
	buttonIndex = buttonIndex + 1

	local button = CreateFrame("Button", ADDON_NAME.."_config_button_" .. buttonIndex, parentFrame, "UIPanelButtonTemplate")
	button:SetText(displayText)
	button:SetHeight(30)
	button:SetWidth(button:GetTextWidth() + 30)

	return button
end

local function createSmallButton(parentFrame, displayText)
	buttonIndex = buttonIndex + 1

	local button = CreateFrame("Button", ADDON_NAME.."_config_button_" .. buttonIndex, parentFrame, "UIPanelButtonTemplate")
	button:SetText(displayText)
	button:SetHeight(22)
	button:SetWidth(button:GetTextWidth() + 18)

	return button
end

local sliderIndex = 0
local function createSlider(parentFrame, displayText, minVal, maxVal, setStep)
	sliderIndex = sliderIndex + 1

	local SliderBackdrop  = {
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 3, right = 3, top = 6, bottom = 6 }
	}

	local slider = CreateFrame("Slider", ADDON_NAME.."_config_slider_" .. sliderIndex, parentFrame, BackdropTemplateMixin and "BackdropTemplate")
	slider:SetOrientation("HORIZONTAL")
	slider:SetHeight(15)
	slider:SetWidth(300)
	slider:SetHitRectInsets(0, 0, -10, 0)
	slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
	slider:SetMinMaxValues(minVal or 0.5, maxVal or 5)
	slider:SetValue(0.5)
	slider:SetBackdrop(SliderBackdrop)
	slider:SetValueStep(setStep or 1)

	local label = slider:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("CENTER", slider, "CENTER", 0, 16)
	label:SetJustifyH("CENTER")
	label:SetHeight(15)
	label:SetText(displayText)

	local lowtext = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	lowtext:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 2, 3)
	lowtext:SetText(minVal)

	local hightext = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	hightext:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -2, 3)
	hightext:SetText(maxVal)

	local currVal = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	currVal:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 45, 12)
	currVal:SetText('(?)')
	slider.currVal = currVal

	return slider
end

local function openColorPicker(r, g, b, onChange, onCancel)
	if not ColorPickerFrame then
		onChange(r, g, b)
		DEFAULT_CHAT_FRAME:AddMessage(ADDON_NAME..": Color picker unavailable, using current color.")
		return
	end
	if ColorPickerFrame and ColorPickerFrame.SetupColorPickerAndShow then
		local info = {
			r = r, g = g, b = b,
			hasOpacity = false,
			swatchFunc = function()
				local nr, ng, nb = ColorPickerFrame:GetColorRGB()
				onChange(nr, ng, nb)
			end,
			cancelFunc = function(prev)
				if prev then onCancel(prev.r, prev.g, prev.b) end
			end,
		}
		ColorPickerFrame:SetupColorPickerAndShow(info)
	else
		ColorPickerFrame.hasOpacity = false
		ColorPickerFrame.previousValues = { r = r, g = g, b = b }
		ColorPickerFrame.func = function()
			local nr, ng, nb = ColorPickerFrame:GetColorRGB()
			onChange(nr, ng, nb)
		end
		ColorPickerFrame.cancelFunc = function(prev)
			if prev then onCancel(prev.r, prev.g, prev.b) end
		end
		ColorPickerFrame:SetColorRGB(r, g, b)
		ColorPickerFrame:Show()
	end
end

local function createColorSwatch(parentFrame, displayText)
	local swatch = CreateFrame("Button", nil, parentFrame)
	swatch:SetSize(260, 24)

	swatch.text = swatch:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	swatch.text:SetPoint("LEFT", swatch, "LEFT", 0, 0)
	swatch.text:SetJustifyH("LEFT")
	swatch.text:SetText(displayText)

	swatch.box = CreateFrame("Frame", nil, swatch, BackdropTemplateMixin and "BackdropTemplate")
	swatch.box:SetSize(18, 18)
	swatch.box:SetPoint("LEFT", swatch.text, "RIGHT", 10, 0)
	swatch.box.bg = swatch.box:CreateTexture(nil, "BACKGROUND")
	swatch.box.bg:SetAllPoints(swatch.box)

	return swatch
end

local function LoadAboutFrame()

	--Code inspired from tekKonfigAboutPanel
	local about = CreateFrame("Frame", ADDON_NAME.."AboutPanel", InterfaceOptionsFramePanelContainer, BackdropTemplateMixin and "BackdropTemplate")
	about.name = ADDON_NAME
	about:Hide()

    local fields = {"Version", "Author"}
	local notes = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Notes")

    local title = about:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(ADDON_NAME)

	local subtitle = about:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetHeight(32)
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subtitle:SetPoint("RIGHT", about, -32, 0)
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetJustifyV("TOP")
	subtitle:SetText(notes)

	local anchor
	for _,field in pairs(fields) do
		local val = C_AddOns.GetAddOnMetadata(ADDON_NAME, field)
		if val then
			local title = about:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			title:SetWidth(75)
			if not anchor then title:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", -2, -8)
			else title:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -6) end
			title:SetJustifyH("RIGHT")
			title:SetText(field:gsub("X%-", ""))

			local detail = about:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
			detail:SetPoint("LEFT", title, "RIGHT", 4, 0)
			detail:SetPoint("RIGHT", -16, 0)
			detail:SetJustifyH("LEFT")
			detail:SetText(val)

			anchor = title
		end
	end

	if InterfaceOptions_AddCategory then
		InterfaceOptions_AddCategory(about)
	else
		local category, layout = _G.Settings.RegisterCanvasLayoutCategory(about, about.name);
		_G.Settings.RegisterAddOnCategory(category);
		addon.settingsCategory = category
	end

	return about
end

function configFrame:EnableConfig()

	addon.aboutPanel = LoadAboutFrame()

	--scroll frame for options to prevent overflow
	local scrollFrame = CreateFrame("ScrollFrame", ADDON_NAME.."_ConfigScrollFrame", addon.aboutPanel, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", addon.aboutPanel, "TOPLEFT", 12, -125)
	scrollFrame:SetPoint("BOTTOMRIGHT", addon.aboutPanel, "BOTTOMRIGHT", -34, 16)

	local content = CreateFrame("Frame", nil, scrollFrame)
	content:SetSize(1, 800)
	scrollFrame:SetScrollChild(content)
	content.scrollFrame = scrollFrame

	initLayout(content)

	local headerActions = createHeader(content, L.ConfigHeaderActions or "Actions")
	addConfigEntry(headerActions, -6)

	--anchor
	local btnAnchor = createButton(content, L.SlashAnchorText)
	btnAnchor.func = function()
		if XBT_TargetAnchor:IsVisible() then
			XBT_TargetAnchor:Hide()
			if canFocusT then
				XBT_FocusAnchor:Hide()
			end
			XBT_PlayerAnchor:Hide()
			XBT_SupportAnchor:Hide()
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashAnchorOff)
		else
			XBT_TargetAnchor:Show()
			if canFocusT then
				XBT_FocusAnchor:Show()
			end
			XBT_PlayerAnchor:Show()
			XBT_SupportAnchor:Show()
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashAnchorOn)
		end
	end
	btnAnchor:SetScript("OnClick", btnAnchor.func)

	addConfigEntry(btnAnchor, -20)
	addon.aboutPanel.btnAnchor = btnAnchor

	--reset
	local btnReset = createButton(content, L.SlashResetText)
	btnReset.func = function()
		DEFAULT_CHAT_FRAME:AddMessage(L.SlashResetAlert)
		XBT_TargetAnchor:ClearAllPoints()
		XBT_TargetAnchor:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		if canFocusT then
			XBT_FocusAnchor:ClearAllPoints()
			XBT_FocusAnchor:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		end
		XBT_PlayerAnchor:ClearAllPoints()
		XBT_PlayerAnchor:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		XBT_SupportAnchor:ClearAllPoints()
		XBT_SupportAnchor:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
	btnReset:SetScript("OnClick", btnReset.func)

	btnReset:ClearAllPoints()
	btnReset:SetPoint("LEFT", btnAnchor, "RIGHT", 12, 0)
	addon.aboutPanel.btnReset = btnReset

	--scale
	local sliderScale = createSlider(content, L.SlashScaleText, 0.5, 5, 0.1)
	sliderScale:SetScript("OnShow", function()
		sliderScale:SetValue(XBT_DB.scale)
		sliderScale.currVal:SetText("("..XBT_DB.scale..")")
	end)
	sliderScale.sliderFunc = function(self, value)
		value = math.floor(value * 10) / 10
		if value < 0.5 then value = 0.5 end --always make sure we are 0.5 as the highest zero.  Anything lower will make the frame dissapear
		if value > 5 then value = 5 end --nothing bigger than this
		sliderScale.currVal:SetText("("..value..")")
		sliderScale:SetValue(value)
	end
	sliderScale.sliderMouseUp = function(self, button)
		local value = math.floor(self:GetValue() * 10) / 10
		addon:SetAddonScale(value)
	end
	sliderScale:SetScript("OnValueChanged", sliderScale.sliderFunc)
	sliderScale:SetScript("OnMouseUp", sliderScale.sliderMouseUp)

	addConfigEntry(sliderScale, -36)
	addon.aboutPanel.sliderScale = sliderScale

	--bar color (under scale)
	local btnBarColor = createColorSwatch(content, L.BarColorText)
	btnBarColor:SetScript("OnShow", function()
		local clr = XBT_DB.barColor or { r = 0.30, g = 0.50, b = 1.0 }
		btnBarColor.box.bg:SetColorTexture(clr.r, clr.g, clr.b)
	end)
	btnBarColor.func = function()
		local clr = XBT_DB.barColor or { r = 0.30, g = 0.50, b = 1.0 }

		local function setColor(r, g, b)
			XBT_DB.barColor = { r = r, g = g, b = b }
			btnBarColor.box.bg:SetColorTexture(r, g, b)
			addon:ReloadBuffs()
		end

		openColorPicker(clr.r, clr.g, clr.b, setColor, setColor)
	end
	btnBarColor:SetScript("OnClick", btnBarColor.func)

	addConfigEntry(btnBarColor, -32)
	addon.aboutPanel.btnBarColor = btnBarColor

	local btnBarColorReset = createSmallButton(content, L.Reset or "Reset")
	btnBarColorReset:SetPoint("LEFT", btnBarColor.box, "RIGHT", 16, 0)
	btnBarColorReset.func = function()
		XBT_DB.barColor = { r = 0.30, g = 0.50, b = 1.0 }
		btnBarColor.box.bg:SetColorTexture(XBT_DB.barColor.r, XBT_DB.barColor.g, XBT_DB.barColor.b)
		addon:ReloadBuffs()
	end
	btnBarColorReset:SetScript("OnClick", btnBarColorReset.func)
	addon.aboutPanel.btnBarColorReset = btnBarColorReset

	--reload buffs
	local btnReloadBuffs = createButton(content, L.SlashReloadText)
	btnReloadBuffs.func = function()
		addon:ReloadBuffs()
		DEFAULT_CHAT_FRAME:AddMessage(L.SlashReloadAlert)
	end
	btnReloadBuffs:SetScript("OnClick", btnReloadBuffs.func)

	addConfigEntry(btnReloadBuffs, -32)
	addon.aboutPanel.btnReloadBuffs = btnReloadBuffs

	local headerOptions = createHeader(content, L.ConfigHeaderOptions or "Options")
	addConfigEntry(headerOptions, -28)

	--graphic bar
	local btnGraphicBar = createCheckbutton(content, L.GraphicBarChkBtn)
	btnGraphicBar:SetScript("OnShow", function() btnGraphicBar:SetChecked(XBT_DB.useGraphicBar) end)
	btnGraphicBar.func = function(slashSwitch)
		local value = XBT_DB.useGraphicBar
		if not slashSwitch then value = XBT_DB.useGraphicBar end

		if value then
			XBT_DB.useGraphicBar = false
		else
			XBT_DB.useGraphicBar = true
		end

		addon:adjustBars()
		addon:ReloadBuffs()
	end
	btnGraphicBar:SetScript("OnClick", btnGraphicBar.func)

	addConfigEntry(btnGraphicBar, -18)
	addon.aboutPanel.btnGraphicBar = btnGraphicBar

	--grow
	local btnGrow = createCheckbutton(content, L.SlashGrowChkBtn)
	btnGrow:SetScript("OnShow", function() btnGrow:SetChecked(XBT_DB.grow) end)
	btnGrow.func = function(slashSwitch)
		local value = XBT_DB.grow
		if not slashSwitch then value = XBT_DB.grow end

		if value then
			XBT_DB.grow = false
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashGrowUp)
		else
			XBT_DB.grow = true
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashGrowDown)
		end

		addon:adjustBars()
	end
	btnGrow:SetScript("OnClick", btnGrow.func)

	addConfigEntry(btnGrow, -18)
	addon.aboutPanel.btnGrow = btnGrow

	--sort
	local btnSort = createCheckbutton(content, L.SlashSortChkBtn)
	btnSort:SetScript("OnShow", function() btnSort:SetChecked(XBT_DB.sort) end)
	btnSort.func = function(slashSwitch)
		local value = XBT_DB.sort
		if not slashSwitch then value = XBT_DB.sort end

		if value then
			XBT_DB.sort = false
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashSortDescending)
		else
			XBT_DB.sort = true
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashSortAscending)
		end

		addon:adjustBars()
	end
	btnSort:SetScript("OnClick", btnSort.func)

	addConfigEntry(btnSort, -14)
	addon.aboutPanel.btnSort = btnSort

	--target
	local btnTarget = createCheckbutton(content, L.SlashTargetChkBtn)
	btnTarget:SetScript("OnShow", function() btnTarget:SetChecked(XBT_DB.showTarget) end)
	btnTarget.func = function(slashSwitch)
		local value = XBT_DB.showTarget
		if not slashSwitch then value = XBT_DB.showTarget end

		if value then
			XBT_DB.showTarget = false
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashTargetOff)
		else
			XBT_DB.showTarget = true
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashTargetOn)
		end

		addon:ReloadBuffs()
	end
	btnTarget:SetScript("OnClick", btnTarget.func)

	addConfigEntry(btnTarget, -14)
	addon.aboutPanel.btnTarget = btnTarget

	if canFocusT then
		--focus
		local btnFocus = createCheckbutton(content, L.SlashFocusChkBtn)
		btnFocus:SetScript("OnShow", function() btnFocus:SetChecked(XBT_DB.showFocus) end)
		btnFocus.func = function(slashSwitch)
			local value = XBT_DB.showFocus
			if not slashSwitch then value = XBT_DB.showFocus end

			if value then
				XBT_DB.showFocus = false
				DEFAULT_CHAT_FRAME:AddMessage(L.SlashFocusOff)
			else
				XBT_DB.showFocus = true
				DEFAULT_CHAT_FRAME:AddMessage(L.SlashFocusOn)
			end

			addon:ReloadBuffs()
		end
		btnFocus:SetScript("OnClick", btnFocus.func)

		addConfigEntry(btnFocus, -14)
		addon.aboutPanel.btnFocus = btnFocus
	end

	--player
	local btnPlayer = createCheckbutton(content, L.SlashPlayerChkBtn)
	btnPlayer:SetScript("OnShow", function() btnPlayer:SetChecked(XBT_DB.showPlayer) end)
	btnPlayer.func = function(slashSwitch)
		local value = XBT_DB.showPlayer
		if not slashSwitch then value = XBT_DB.showPlayer end

		if value then
			XBT_DB.showPlayer = false
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashPlayerOff)
		else
			XBT_DB.showPlayer = true
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashPlayerOn)
		end

		addon:ReloadBuffs()
	end
	btnPlayer:SetScript("OnClick", btnPlayer.func)

	addConfigEntry(btnPlayer, -14)
	addon.aboutPanel.btnPlayer = btnPlayer

	--support
	local btnSupport = createCheckbutton(content, L.SlashSupportChkBtn)
	btnSupport:SetScript("OnShow", function() btnSupport:SetChecked(XBT_DB.showSupport) end)
	btnSupport.func = function(slashSwitch)
		local value = XBT_DB.showSupport
		if not slashSwitch then value = XBT_DB.showSupport end

		if value then
			XBT_DB.showSupport = false
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashPlayerOff)
		else
			XBT_DB.showSupport = true
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashPlayerOn)
		end

		addon:ReloadBuffs()
	end
	btnSupport:SetScript("OnClick", btnSupport.func)

	addConfigEntry(btnSupport, -14)
	addon.aboutPanel.btnSupport = btnSupport

	--infinite
	local btnInfinite = createCheckbutton(content, L.SlashInfiniteChkBtn)
	btnInfinite:SetScript("OnShow", function() btnInfinite:SetChecked(XBT_DB.showInfinite) end)
	btnInfinite.func = function(slashSwitch)
		local value = XBT_DB.showInfinite
		if not slashSwitch then value = XBT_DB.showInfinite end

		if value then
			XBT_DB.showInfinite = false
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashInfiniteOff)
		else
			XBT_DB.showInfinite = true
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashInfiniteOn)
		end

		addon:ReloadBuffs()
	end
	btnInfinite:SetScript("OnClick", btnInfinite.func)

	addConfigEntry(btnInfinite, -14)
	addon.aboutPanel.btnInfinite = btnInfinite

	--icon
	local btnIcon = createCheckbutton(content, L.SlashIconChkBtn)
	btnIcon:SetScript("OnShow", function() btnIcon:SetChecked(XBT_DB.showIcon) end)
	btnIcon.func = function(slashSwitch)
		local value = XBT_DB.showIcon
		if not slashSwitch then value = XBT_DB.showIcon end

		if value then
			XBT_DB.showIcon = false
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashIconOff)
		else
			XBT_DB.showIcon = true
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashIconOn)
		end

		addon:adjustBars()
		addon:ReloadBuffs()
	end
	btnIcon:SetScript("OnClick", btnIcon.func)

	addConfigEntry(btnIcon, -14)
	addon.aboutPanel.btnIcon = btnIcon

	--spellname
	local btnSpellName = createCheckbutton(content, L.SlashSpellNameChkBtn)
	btnSpellName:SetScript("OnShow", function() btnSpellName:SetChecked(XBT_DB.showSpellName) end)
	btnSpellName.func = function(slashSwitch)
		local value = XBT_DB.showSpellName
		if not slashSwitch then value = XBT_DB.showSpellName end

		if value then
			XBT_DB.showSpellName = false
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashSpellNameOff)
		else
			XBT_DB.showSpellName = true
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashSpellNameOn)
		end

		addon:adjustBars()
		addon:ReloadBuffs()
	end
	btnSpellName:SetScript("OnClick", btnSpellName.func)

	addConfigEntry(btnSpellName, -14)
	addon.aboutPanel.btnSpellName = btnSpellName

	--show on right
	local btnShowOnRight = createCheckbutton(content, L.ShowTimerOnRight)
	btnShowOnRight:SetScript("OnShow", function() btnShowOnRight:SetChecked(XBT_DB.showTimerOnRight) end)
	btnShowOnRight.func = function(slashSwitch)
		local value = XBT_DB.showTimerOnRight
		if not slashSwitch then value = XBT_DB.showTimerOnRight end

		if value then
			XBT_DB.showTimerOnRight = false
		else
			XBT_DB.showTimerOnRight = true
		end

		addon:adjustBars()
		addon:ReloadBuffs()
	end
	btnShowOnRight:SetScript("OnClick", btnShowOnRight.func)

	addConfigEntry(btnShowOnRight, -14)
	addon.aboutPanel.btnShowOnRight = btnShowOnRight

	--healers
	local btnHealers = createCheckbutton(content, L.SlashHealersChkBtn)
	btnHealers:SetScript("OnShow", function() btnHealers:SetChecked(XBT_DB.healersOnly) end)
	btnHealers.func = function(slashSwitch)
		local value = XBT_DB.healersOnly
		if not slashSwitch then value = XBT_DB.healersOnly end

		if value then
			XBT_DB.healersOnly = false
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashHealersOff)
		else
			XBT_DB.healersOnly = true
			DEFAULT_CHAT_FRAME:AddMessage(L.SlashHealersOn)
		end

		addon:ReloadBuffs()
	end
	btnHealers:SetScript("OnClick", btnHealers.func)

	addConfigEntry(btnHealers, -14)
	addon.aboutPanel.btnHealers = btnHealers

	--hide in rested
	local btnHideInRested = createCheckbutton(content, L.HideInRested)
	btnHideInRested:SetScript("OnShow", function() btnHideInRested:SetChecked(XBT_DB.hideInRestedAreas) end)
	btnHideInRested.func = function(slashSwitch)
		local value = XBT_DB.hideInRestedAreas
		if not slashSwitch then value = XBT_DB.hideInRestedAreas end

		if value then
			XBT_DB.hideInRestedAreas = false
		else
			XBT_DB.hideInRestedAreas = true
		end

		addon:ReloadBuffs()
	end
	btnHideInRested:SetScript("OnClick", btnHideInRested.func)

	addConfigEntry(btnHideInRested, -14)
	addon.aboutPanel.btnHideInRested = btnHideInRested
end
