local ADDON_NAME, addon = ...

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "enUS", true)
if not L then return end

L.SlashAnchor = "anchor"
L.SlashAnchorText = "Toggle Frame Anchors"
L.SlashAnchorOn = "xanBuffTimers: Anchors now [|cFF99CC33SHOWN|r]"
L.SlashAnchorOff = "xanBuffTimers: Anchors now [|cFF99CC33HIDDEN|r]"
L.SlashAnchorInfo = "Toggles movable anchors."

L.SlashReset = "reset"
L.SlashResetText = "Reset Anchor Positions"
L.SlashResetInfo = "Reset anchor positions."
L.SlashResetAlert = "xanBuffTimers: Anchor positions have been reset!"

L.SlashScale = "scale"
L.SlashScaleSet = "xanBuffTimers: scale has been set to [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "xanBuffTimers: scale invalid or number cannot be greater than 2"
L.SlashScaleInfo = "Set the scale of the xanBuffTimers bar (0-200)."
L.SlashScaleText = "xanBuffTimers Bar Scale"

L.SlashGrow = "grow"
L.SlashGrowUp = "xanBuffTimers: Bars will now grow [|cFF99CC33UP|r]"
L.SlashGrowDown = "xanBuffTimers: Bars will now grow [|cFF99CC33DOWN|r]"
L.SlashGrowInfo = "Toggle the direction in which the bars grow (|cFF99CC33UP/DOWN|r)."
L.SlashGrowChkBtn = "Bars will grow [|cFF99CC33DOWN|r]."

L.SlashSort = "sort"
L.SlashSortDescending = "xanBuffTimers: Bars will now sort [|cFF99CC33DESCENDING|r]"
L.SlashSortAscending = "xanBuffTimers: Bars will now sort [|cFF99CC33ASCENDING|r]"
L.SlashSortInfo = "Toggle the sorting of the bars. (|cFF99CC33ASCENDING/DESCENDING|r)."
L.SlashSortChkBtn = "Bars will sort [|cFF99CC33ASCENDING|r]."

L.SlashTarget = "target"
L.SlashTargetOn = "xanBuffTimers: Show target tracking [|cFF99CC33ON|r]"
L.SlashTargetOff = "xanBuffTimers: Show target tracking [|cFF99CC33OFF|r]"
L.SlashTargetInfo = "Toggles target tracking (|cFF99CC33ON/OFF|r)."
L.SlashTargetChkBtn = "Show target tracking. [|cFF99CC33ON|r]."

L.SlashFocus = "focus"
L.SlashFocusOn = "xanBuffTimers: Show focus tracking [|cFF99CC33ON|r]"
L.SlashFocusOff = "xanBuffTimers: Show focus tracking [|cFF99CC33OFF|r]"
L.SlashFocusInfo = "Toggles focus tracking (|cFF99CC33ON/OFF|r)."
L.SlashFocusChkBtn = "Show focus tracking. [|cFF99CC33ON|r]."

L.SlashPlayer = "player"
L.SlashPlayerOn = "xanBuffTimers: Show player tracking [|cFF99CC33ON|r]"
L.SlashPlayerOff = "xanBuffTimers: Show player tracking [|cFF99CC33OFF|r]"
L.SlashPlayerInfo = "Toggles player tracking (|cFF99CC33ON/OFF|r)."
L.SlashPlayerChkBtn = "Show player tracking. [|cFF99CC33ON|r]."

L.SlashInfinite = "infinite"
L.SlashInfiniteOn = "xanBuffTimers: Show buffs whom have no durations/timers or are infinite. [|cFF99CC33ON|r]"
L.SlashInfiniteOff = "xanBuffTimers: Show buffs whom have no durations/timers or are infinite. [|cFF99CC33OFF|r]"
L.SlashInfiniteInfo = "Toggle buffs whom have no durations/timers or are infinite. (|cFF99CC33ON/OFF|r)."
L.SlashInfiniteChkBtn = "Show buffs whom have no durations/timers or are infinite. [|cFF99CC33ON|r]."

L.SlashIcon = "icon"
L.SlashIconOn = "xanBuffTimers: Show buff icons [|cFF99CC33ON|r]"
L.SlashIconOff = "xanBuffTimers: Show buff icons [|cFF99CC33OFF|r]"
L.SlashIconInfo = "Toggles buff icons. (|cFF99CC33ON/OFF|r)."
L.SlashIconChkBtn = "Show buff icons. [|cFF99CC33ON|r]."

L.SlashSpellName = "spellname"
L.SlashSpellNameOn = "xanBuffTimers: Show buff spell names [|cFF99CC33ON|r]"
L.SlashSpellNameOff = "xanBuffTimers: Show buff spell names [|cFF99CC33OFF|r]"
L.SlashSpellNameInfo = "Toggle buff spell names (|cFF99CC33ON/OFF|r)."
L.SlashSpellNameChkBtn = "Show buff spell names. [|cFF99CC33ON|r]."

L.SlashHealers = "healers"
L.SlashHealersOn = "xanBuffTimers: Show for healers only [|cFF99CC33ON|r]"
L.SlashHealersOff = "xanBuffTimers: Show for healers only [|cFF99CC33OFF|r]"
L.SlashHealersInfo = "Toggles displaying of buff bars for only healing classes (|cFF99CC33ON/OFF|r)."
L.SlashHealersChkBtn = "Show for healers only. [|cFF99CC33ON|r]."

L.SlashReload = "reload"
L.SlashReloadText = "Reload Buff Bars"
L.SlashReloadInfo = "Reload buff bars."
L.SlashReloadAlert = "xanBuffTimers: Buff bars reloaded!"

L.TimeHour = "h"
L.TimeMinute = "m"
L.TimeSecond = "s"

L.BarTargetAnchor = "xanBuffTimers: Target Anchor"
L.BarFocusAnchor = "xanBuffTimers: Focus Anchor"
L.BarPlayerAnchor = "xanBuffTimers: Player Anchor"
