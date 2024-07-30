local ADDON_NAME, addon = ...

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "zhCN")
if not L then return end

L.SlashAnchor = "锚点"
L.SlashAnchorText = "切换锚点"
L.SlashAnchorOn = "xanBuffTimers: 锚点现在 [|cFF99CC33显示|r]"
L.SlashAnchorOff = "xanBuffTimers: 锚点现在 [|cFF99CC33隐藏|r]"
L.SlashAnchorInfo = "切换可移动锚点。"

L.SlashReset = "重置"
L.SlashResetText = "重置锚点位置"
L.SlashResetInfo = "重置锚点位置。"
L.SlashResetAlert = "xanBuffTimers: 锚点位置已重置！"

L.SlashScale = "缩放"
L.SlashScaleSet = "xanBuffTimers: 缩放比列设置为 [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "缩放无效！数字必需为 [0.5 - 5].  (0.5, 1, 3, 4.6, 等..)"
L.SlashScaleInfo = "设置xanBuffTimers比例为 (0.5 - 5)。"
L.SlashScaleText = "xanBuffTimers 比例"

L.SlashGrow = "增长方向"
L.SlashGrowUp = "xanBuffTimers: 现在增长方向为 [|cFF99CC33上|r]"
L.SlashGrowDown = "xanBuffTimers: 现在增长方向为 [|cFF99CC33下|r]"
L.SlashGrowInfo = "切换增长方向为 (|cFF99CC33上/下|r)。"
L.SlashGrowChkBtn = "增长方向 [|cFF99CC33上|r]。"

L.SlashSort = "排序"
L.SlashSortDescending = "xanBuffTimers: 排序选择为 [|cFF99CC33降序|r]"
L.SlashSortAscending = "xanBuffTimers: 排序选择为 [|cFF99CC33升序|r]"
L.SlashSortInfo = "切换排序方式为 (|cFF99CC33升序/降序|r)。"
L.SlashSortChkBtn = "排序选择 [|cFF99CC33升序|r]。"

L.SlashTarget = "目标"
L.SlashTargetOn = "xanBuffTimers: 显示目标 [|cFF99CC33开|r]"
L.SlashTargetOff = "xanBuffTimers: 显示目标 [|cFF99CC33关|r]"
L.SlashTargetInfo = "切换目标显示 (|cFF99CC33开/关|r)。"
L.SlashTargetChkBtn = "显示目标。 [|cFF99CC33开|r]。"

L.SlashFocus = "焦点"
L.SlashFocusOn = "xanBuffTimers: 显示焦点 [|cFF99CC33开|r]"
L.SlashFocusOff = "xanBuffTimers: 显示焦点 [|cFF99CC33关|r]"
L.SlashFocusInfo = "切换焦点显示 (|cFF99CC33开/关|r)。"
L.SlashFocusChkBtn = "显示焦点。 [|cFF99CC33开|r]。"

L.SlashPlayer = "玩家"
L.SlashPlayerOn = "xanBuffTimers: 显示玩家 [|cFF99CC33开|r]"
L.SlashPlayerOff = "xanBuffTimers: 显示玩家 [|cFF99CC33关|r]"
L.SlashPlayerInfo = "切换玩家显示 (|cFF99CC33开/关|r)。"
L.SlashPlayerChkBtn = "显示玩家。 [|cFF99CC33开|r]。"

L.SlashSupport = "战友"
L.SlashSupportOn = "xanBuffTimers: 显示战友 [|cFF99CC33开|r]"
L.SlashSupportOff = "xanBuffTimers: 显示战友 [|cFF99CC33关|r]"
L.SlashSupportInfo = "切换战友显示 (|cFF99CC33开/关|r)。"
L.SlashSupportChkBtn = "显示战友 [|cFF99CC33开|r]。"

L.SlashSupportTarget = "辅助"
L.SlashSupportTargetInfo = "将辅助目标设为你当前选定的目标 (自动: 副本坦克)"
L.SlashSupportTargetUnit = "辅助目标设为: [|cFF99CC33%s|r]"
L.SlashSupportTargetInvalid = "辅助目标为 [|cFFDF2B2B无效|r]"

L.SlashInfinite = "无限制"
L.SlashInfiniteOn = "显示无持续时间/计时器或无计时的增益 [|cFF99CC33开|r]"
L.SlashInfiniteOff = "xanBuffTimers: 显示无持续时间/计时器或无计时的增益 [|cFF99CC33关|r]"
L.SlashInfiniteInfo = "切换显示无持续时间/计时器或无计时的增益 (|cFF99CC33开/关|r)。"
L.SlashInfiniteChkBtn = "显示无持续时间/计时器或无计时的增益为 [|cFF99CC33开|r]。"

L.SlashIcon = "图标"
L.SlashIconOn = "xanBuffTimers: 显示增益图标 [|cFF99CC33开|r]"
L.SlashIconOff = "xanBuffTimers: 显示增益图标 [|cFF99CC33关|r]"
L.SlashIconInfo = "切换显示增益图标 (|cFF99CC33开/关|r)。"
L.SlashIconChkBtn = "显示增益图标 [|cFF99CC33开|r]。"

L.SlashSpellName = "技能"
L.SlashSpellNameOn = "xanBuffTimers: 显示增益技能名称 [|cFF99CC33开|r]"
L.SlashSpellNameOff = "xanBuffTimers: 显示增益技能名称 [|cFF99CC33关|r]"
L.SlashSpellNameInfo = "切换显示增益技能名称 (|cFF99CC33开/关|r)."
L.SlashSpellNameChkBtn = "显示增益技能名称。 [|cFF99CC33开|r]。"

L.SlashHealers = "治疗"
L.SlashHealersOn = "xanBuffTimers: 仅为治疗职业显示 [|cFF99CC33开|r]"
L.SlashHealersOff = "xanBuffTimers: 仅为治疗职业显示 [|cFF99CC33关|r]"
L.SlashHealersInfo = "切换治疗职业显示 (|cFF99CC33开/关|r)."
L.SlashHealersChkBtn = "仅为治疗职业显示 [|cFF99CC33开|r]。"

L.SlashReload = "重载"
L.SlashReloadText = "重载增益条"
L.SlashReloadInfo = "重载增益条。"
L.SlashReloadAlert = "xanBuffTimers: 重新加载增益条！"

L.TimeHour = "h"
L.TimeMinute = "m"
L.TimeSecond = "s"

L.BarTargetAnchor = "xanBuffTimers: 目标锚点"
L.BarFocusAnchor = "xanBuffTimers: 焦点锚点"
L.BarPlayerAnchor = "xanBuffTimers: 玩家锚点"
L.BarSupportAnchor = "xanBuffTimers: 战友锚点"
