local ADDON_NAME, private = ...

local L = private:NewLocale("zhTW")
if not L then return end

L.SlashAnchor = "錨點"
L.SlashAnchorText = "切換錨點"
L.SlashAnchorOn = "xanBuffTimers: 錨點現在 [|cFF99CC33顯示|r]"
L.SlashAnchorOff = "xanBuffTimers: 錨點現在 [|cFF99CC33隱藏|r]"
L.SlashAnchorInfo = "切換可移動錨點。"

L.SlashReset = "重置"
L.SlashResetText = "重置錨點位置"
L.SlashResetInfo = "重置錨點位置。"

L.Reset = "重置"

L.SlashScale = "縮放"
L.SlashScaleSet = "xanBuffTimers: 縮放比例設定為 [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "縮放無效！數字必須為 [0.5 - 5].  (0.5, 1, 3, 4.6, 等..)"
L.SlashScaleInfo = "設定 LootRollMover 掉落框架的比例 (0.5 - 5)。"
L.SlashScaleText = "xanBuffTimers 比例"

L.SlashGrow = "成長方向"
L.SlashGrowUp = "xanBuffTimers: 現在成長方向為 [|cFF99CC33上|r]"
L.SlashGrowDown = "xanBuffTimers: 現在成長方向為 [|cFF99CC33下|r]"
L.SlashGrowInfo = "切換成長方向為 (|cFF99CC33上/下|r)。"
L.SlashGrowChkBtn = "成長方向 [|cFF99CC33下|r]。"

L.SlashSort = "排序"
L.SlashSortDescending = "xanBuffTimers: 排序選擇為 [|cFF99CC33降序|r]"
L.SlashSortAscending = "xanBuffTimers: 排序選擇為 [|cFF99CC33升序|r]"
L.SlashSortInfo = "切換排序方式為 (|cFF99CC33升序/降序|r)。"
L.SlashSortChkBtn = "排序選擇 [|cFF99CC33升序|r]。"

L.SlashTarget = "目標"
L.SlashTargetOn = "xanBuffTimers: 顯示目標 [|cFF99CC33開|r]"
L.SlashTargetOff = "xanBuffTimers: 顯示目標 [|cFF99CC33關|r]"
L.SlashTargetInfo = "切換目標顯示 (|cFF99CC33開/關|r)。"
L.SlashTargetChkBtn = "顯示目標。 [|cFF99CC33開|r]。"

L.SlashFocus = "焦點"
L.SlashFocusOn = "xanBuffTimers: 顯示焦點 [|cFF99CC33開|r]"
L.SlashFocusOff = "xanBuffTimers: 顯示焦點 [|cFF99CC33關|r]"
L.SlashFocusInfo = "切換焦點顯示 (|cFF99CC33開/關|r)。"
L.SlashFocusChkBtn = "顯示焦點。 [|cFF99CC33開|r]。"

L.SlashPlayer = "玩家"
L.SlashPlayerOn = "xanBuffTimers: 顯示玩家 [|cFF99CC33開|r]"
L.SlashPlayerOff = "xanBuffTimers: 顯示玩家 [|cFF99CC33關|r]"
L.SlashPlayerInfo = "切換玩家顯示 (|cFF99CC33開/關|r)。"
L.SlashPlayerChkBtn = "顯示玩家。 [|cFF99CC33開|r]。"

L.SlashSupport = "戰友"
L.SlashSupportOn = "xanBuffTimers: 顯示戰友 [|cFF99CC33開|r]"
L.SlashSupportOff = "xanBuffTimers: 顯示戰友 [|cFF99CC33關|r]"
L.SlashSupportInfo = "切換戰友顯示 (|cFF99CC33開/關|r)。"
L.SlashSupportChkBtn = "顯示戰友 [|cFF99CC33開|r]。"

L.SlashSupportTarget = "輔助"
L.SlashSupportTargetInfo = "將輔助目標設為你目前選定的目標 (自動: 隊伍坦克)"
L.SlashSupportTargetUnit = "輔助目標設為: [|cFF99CC33%s|r]"
L.SlashSupportTargetInvalid = "輔助目標為 [|cFFDF2B2B無效|r]"

L.SlashInfinite = "無限制"
L.SlashInfiniteOn = "xanBuffTimers: 顯示無持續時間/計時器或無限的增益 [|cFF99CC33開|r]"
L.SlashInfiniteOff = "xanBuffTimers: 顯示無持續時間/計時器或無限的增益 [|cFF99CC33關|r]"
L.SlashInfiniteInfo = "切換顯示無持續時間/計時器或無限的增益 (|cFF99CC33開/關|r)。"
L.SlashInfiniteChkBtn = "顯示無持續時間/計時器或無限的增益為 [|cFF99CC33開|r]。"

L.SlashIcon = "圖示"
L.SlashIconOn = "xanBuffTimers: 顯示增益圖示 [|cFF99CC33開|r]"
L.SlashIconOff = "xanBuffTimers: 顯示增益圖示 [|cFF99CC33關|r]"
L.SlashIconInfo = "切換顯示增益圖示 (|cFF99CC33開/關|r)。"
L.SlashIconChkBtn = "顯示增益圖示 [|cFF99CC33開|r]。"

L.SlashSpellName = "技能"
L.SlashSpellNameOn = "xanBuffTimers: 顯示增益技能名稱 [|cFF99CC33開|r]"
L.SlashSpellNameOff = "xanBuffTimers: 顯示增益技能名稱 [|cFF99CC33關|r]"
L.SlashSpellNameInfo = "切換顯示增益技能名稱 (|cFF99CC33開/關|r)."
L.SlashSpellNameChkBtn = "顯示增益技能名稱。 [|cFF99CC33開|r]。"

L.SlashHealers = "治療"
L.SlashHealersOn = "xanBuffTimers: 僅為治療職業顯示 [|cFF99CC33開|r]"
L.SlashHealersOff = "xanBuffTimers: 僅為治療職業顯示 [|cFF99CC33關|r]"
L.SlashHealersInfo = "切換治療職業顯示 (|cFF99CC33開/關|r)."
L.SlashHealersChkBtn = "僅為治療職業顯示 [|cFF99CC33開|r]。"

L.SlashReload = "重載"
L.SlashReloadText = "重載增益條"
L.SlashReloadInfo = "重載增益條。"
L.SlashReloadAlert = "xanBuffTimers: 重新載入增益條！"

L.TimeHour = "h"
L.TimeMinute = "m"
L.TimeSecond = "s"

L.BarTargetAnchor = "xanBuffTimers: 目標錨點"
L.BarFocusAnchor = "xanBuffTimers: 焦點錨點"
L.BarPlayerAnchor = "xanBuffTimers: 玩家錨點"
L.BarSupportAnchor = "xanBuffTimers: 戰友錨點"

L.HideInRested = "在休息區時隱藏增益條。"
L.ShowTimerOnRight = "在減益圖示右側顯示計時器。"

L.GraphicBarChkBtn = "使用圖形化增益條。"
L.BarColorText = "增益條顏色。"

L.RetailWarningTitle = "警告 請務必閱讀!!! 僅限正式服"
L.RetailWarningBody = "由於 Blizzard 的 API 變更，本插件在正式服已無法正常運作。\n\nBlizzard 現在將戰鬥相關的光環資料標記為受保護的"秘密值"。這表示插件在戰鬥中無法讀取或計算 Buff 持續時間、到期時間等資料。而本插件必須計算剩餘時間才能繪製進度條，因此核心功能被客戶端直接阻止。\n\n|cFFFFFF00這不是 xanBuffTimers 的 Bug。|r\n\n|cFFFF2020這是 Blizzard 強制施加的限制。|r\n\n類似的光環/計時插件（例如 WeakAuras 及其他 Buff/Debuff 追蹤插件）也遭遇同樣問題，無法在正式服中顯示準確的戰鬥計時。\n\n簡而言之：正式服阻止了本插件所需的精確資料，因此 Buff 條無法工作。本插件在 Classic、TBC、Wrath 等非正式服客戶端中仍可正常運作。"
