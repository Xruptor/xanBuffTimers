local ADDON_NAME, private = ...

local L = private:NewLocale("koKR")
if not L then return end

L.SlashAnchor = "앵커"
L.SlashAnchorText = "프레임 앵커 전환"
L.SlashAnchorOn = "xanBuffTimers: 앵커가 [|cFF99CC33표시|r]됩니다"
L.SlashAnchorOff = "xanBuffTimers: 앵커가 [|cFF99CC33숨김|r]됩니다"
L.SlashAnchorInfo = "이동 가능한 앵커를 전환합니다."

L.SlashReset = "초기화"
L.SlashResetText = "앵커 위치 초기화"
L.SlashResetInfo = "앵커 위치를 초기화합니다."
L.SlashResetAlert = "xanBuffTimers: 앵커 위치가 초기화되었습니다!"

L.SlashScale = "크기"
L.SlashScaleSet = "xanBuffTimers: 크기가 [|cFF20ff20%s|r]로 설정되었습니다"
L.SlashScaleSetInvalid = "크기 오류! 숫자는 [0.5 - 5] 사이여야 합니다.  (0.5, 1, 3, 4.6 등..)"
L.SlashScaleInfo = "LootRollMover 전리품 프레임의 크기를 설정합니다 (0.5 - 5)."
L.SlashScaleText = "xanBuffTimers 바 크기"

L.SlashGrow = "성장"
L.SlashGrowUp = "xanBuffTimers: 이제 막대가 [|cFF99CC33위|r]로 성장합니다"
L.SlashGrowDown = "xanBuffTimers: 이제 막대가 [|cFF99CC33아래|r]로 성장합니다"
L.SlashGrowInfo = "막대가 성장하는 방향을 전환합니다 (|cFF99CC33위/아래|r)."
L.SlashGrowChkBtn = "막대가 [|cFF99CC33아래|r]로 성장합니다."

L.SlashSort = "정렬"
L.SlashSortDescending = "xanBuffTimers: 막대가 [|cFF99CC33내림차순|r]으로 정렬됩니다"
L.SlashSortAscending = "xanBuffTimers: 막대가 [|cFF99CC33오름차순|r]으로 정렬됩니다"
L.SlashSortInfo = "막대 정렬을 전환합니다. (|cFF99CC33오름차순/내림차순|r)."
L.SlashSortChkBtn = "막대가 [|cFF99CC33오름차순|r]으로 정렬됩니다."

L.SlashTarget = "대상"
L.SlashTargetOn = "xanBuffTimers: 대상 추적 표시 [|cFF99CC33켜짐|r]"
L.SlashTargetOff = "xanBuffTimers: 대상 추적 표시 [|cFF99CC33꺼짐|r]"
L.SlashTargetInfo = "대상 추적을 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashTargetChkBtn = "대상 추적 표시. [|cFF99CC33켜짐|r]."

L.SlashFocus = "집중"
L.SlashFocusOn = "xanBuffTimers: 집중 추적 표시 [|cFF99CC33켜짐|r]"
L.SlashFocusOff = "xanBuffTimers: 집중 추적 표시 [|cFF99CC33꺼짐|r]"
L.SlashFocusInfo = "집중 추적을 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashFocusChkBtn = "집중 추적 표시. [|cFF99CC33켜짐|r]."

L.SlashPlayer = "플레이어"
L.SlashPlayerOn = "xanBuffTimers: 플레이어 추적 표시 [|cFF99CC33켜짐|r]"
L.SlashPlayerOff = "xanBuffTimers: 플레이어 추적 표시 [|cFF99CC33꺼짐|r]"
L.SlashPlayerInfo = "플레이어 추적을 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashPlayerChkBtn = "플레이어 추적 표시. [|cFF99CC33켜짐|r]."

L.SlashSupport = "지원"
L.SlashSupportOn = "xanBuffTimers: 지원 추적 표시 [|cFF99CC33켜짐|r]"
L.SlashSupportOff = "xanBuffTimers: 지원 추적 표시 [|cFF99CC33꺼짐|r]"
L.SlashSupportInfo = "지원 추적을 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashSupportChkBtn = "지원 추적 표시. [|cFF99CC33켜짐|r]."

L.SlashSupportTarget = "지원대상"
L.SlashSupportTargetInfo = "지원 대상을 현재 선택한 대상으로 설정합니다. (AUTO: 파티 탱커)"
L.SlashSupportTargetUnit = "지원 대상 설정: [|cFF99CC33%s|r]"
L.SlashSupportTargetInvalid = "지원 대상이 [|cFFDF2B2B유효하지 않음|r]"

L.SlashInfinite = "무한"
L.SlashInfiniteOn = "xanBuffTimers: 지속시간/타이머가 없거나 무한인 버프 표시 [|cFF99CC33켜짐|r]"
L.SlashInfiniteOff = "xanBuffTimers: 지속시간/타이머가 없거나 무한인 버프 표시 [|cFF99CC33꺼짐|r]"
L.SlashInfiniteInfo = "지속시간/타이머가 없거나 무한인 버프 표시를 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashInfiniteChkBtn = "지속시간/타이머가 없거나 무한인 버프 표시. [|cFF99CC33켜짐|r]."

L.SlashIcon = "아이콘"
L.SlashIconOn = "xanBuffTimers: 버프 아이콘 표시 [|cFF99CC33켜짐|r]"
L.SlashIconOff = "xanBuffTimers: 버프 아이콘 표시 [|cFF99CC33꺼짐|r]"
L.SlashIconInfo = "버프 아이콘 표시를 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashIconChkBtn = "버프 아이콘 표시. [|cFF99CC33켜짐|r]."

L.SlashSpellName = "주문이름"
L.SlashSpellNameOn = "xanBuffTimers: 버프 주문 이름 표시 [|cFF99CC33켜짐|r]"
L.SlashSpellNameOff = "xanBuffTimers: 버프 주문 이름 표시 [|cFF99CC33꺼짐|r]"
L.SlashSpellNameInfo = "버프 주문 이름 표시를 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashSpellNameChkBtn = "버프 주문 이름 표시. [|cFF99CC33켜짐|r]."

L.SlashHealers = "치유"
L.SlashHealersOn = "xanBuffTimers: 치유 전용으로 표시 [|cFF99CC33켜짐|r]"
L.SlashHealersOff = "xanBuffTimers: 치유 전용으로 표시 [|cFF99CC33꺼짐|r]"
L.SlashHealersInfo = "치유 직업만 버프 막대를 표시하도록 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashHealersChkBtn = "치유 전용으로 표시. [|cFF99CC33켜짐|r]."

L.SlashReload = "재시작"
L.SlashReloadText = "버프 막대 다시 불러오기"
L.SlashReloadInfo = "버프 막대를 다시 불러옵니다."
L.SlashReloadAlert = "xanBuffTimers: 버프 막대가 다시 로드되었습니다!"

L.TimeHour = "h"
L.TimeMinute = "m"
L.TimeSecond = "s"

L.BarTargetAnchor = "xanBuffTimers: 대상 앵커"
L.BarFocusAnchor = "xanBuffTimers: 집중 앵커"
L.BarPlayerAnchor = "xanBuffTimers: 플레이어 앵커"
L.BarSupportAnchor = "xanBuffTimers: 지원 앵커"

L.HideInRested = "휴식 지역에서는 버프 막대를 숨깁니다."
L.ShowTimerOnRight = "디버프 아이콘 오른쪽에 타이머 표시."
