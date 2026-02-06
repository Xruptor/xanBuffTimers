local ADDON_NAME, private = ...

local L = private:NewLocale("ruRU")
if not L then return end
-- Translator ZamestoTV
L.SlashAnchor = "якорь"
L.SlashAnchorText = "Переключить якоря фрейма"
L.SlashAnchorOn = "xanBuffTimers: Якоря теперь [|cFF99CC33ПОКАЗАНЫ|r]"
L.SlashAnchorOff = "xanBuffTimers: Якоря теперь [|cFF99CC33СКРЫТЫ|r]"
L.SlashAnchorInfo = "Переключает подвижные якоря."

L.SlashReset = "сброс"
L.SlashResetText = "Сбросить позиции якорей"
L.SlashResetInfo = "Сбрасывает позиции якорей."

L.Reset = "Сброс"

L.SlashScale = "масштаб"
L.SlashScaleSet = "xanBuffTimers: Масштаб установлен на [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "Неверный масштаб! Число должно быть в диапазоне [0.5 - 5]. (0.5, 1, 3, 4.6 и т.д.)"
L.SlashScaleInfo = "Установить масштаб фреймов добычи LootRollMover (0.5 - 5)."
L.SlashScaleText = "Масштаб полос xanBuffTimers"

L.SlashGrow = "рост"
L.SlashGrowUp = "xanBuffTimers: Полосы будут расти [|cFF99CC33ВВЕРХ|r]"
L.SlashGrowDown = "xanBuffTimers: Полосы будут расти [|cFF99CC33ВНИЗ|r]"
L.SlashGrowInfo = "Переключить направление роста полос (|cFF99CC33ВВЕРХ/ВНИЗ|r)."
L.SlashGrowChkBtn = "Полосы будут расти [|cFF99CC33ВНИЗ|r]."

L.SlashSort = "сортировка"
L.SlashSortDescending = "xanBuffTimers: Полосы будут сортироваться [|cFF99CC33ПО УБЫВАНИЮ|r]"
L.SlashSortAscending = "xanBuffTimers: Полосы будут сортироваться [|cFF99CC33ПО ВОЗРАСТАНИЮ|r]"
L.SlashSortInfo = "Переключить сортировку полос. (|cFF99CC33ПО ВОЗРАСТАНИЮ/ПО УБЫВАНИЮ|r)."
L.SlashSortChkBtn = "Полосы будут сортироваться [|cFF99CC33ПО ВОЗРАСТАНИЮ|r]."

L.SlashTarget = "цель"
L.SlashTargetOn = "xanBuffTimers: Отображение отслеживания цели [|cFF99CC33ВКЛ|r]"
L.SlashTargetOff = "xanBuffTimers: Отображение отслеживания цели [|cFF99CC33ВЫКЛ|r]"
L.SlashTargetInfo = "Переключает отслеживание цели (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashTargetChkBtn = "Отображать отслеживание цели. [|cFF99CC33ВКЛ|r]."

L.SlashFocus = "фокус"
L.SlashFocusOn = "xanBuffTimers: Отображение отслеживания фокуса [|cFF99CC33ВКЛ|r]"
L.SlashFocusOff = "xanBuffTimers: Отображение отслеживания фокуса [|cFF99CC33ВЫКЛ|r]"
L.SlashFocusInfo = "Переключает отслеживание фокуса (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashFocusChkBtn = "Отображать отслеживание фокуса. [|cFF99CC33ВКЛ|r]."

L.SlashPlayer = "игрок"
L.SlashPlayerOn = "xanBuffTimers: Отображение отслеживания игрока [|cFF99CC33ВКЛ|r]"
L.SlashPlayerOff = "xanBuffTimers: Отображение отслеживания игрока [|cFF99CC33ВЫКЛ|r]"
L.SlashPlayerInfo = "Переключает отслеживание игрока (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashPlayerChkBtn = "Отображать отслеживание игрока. [|cFF99CC33ВКЛ|r]."

L.SlashSupport = "поддержка"
L.SlashSupportOn = "xanBuffTimers: Отображение отслеживания поддержки [|cFF99CC33ВКЛ|r]"
L.SlashSupportOff = "xanBuffTimers: Отображение отслеживания поддержки [|cFF99CC33ВЫКЛ|r]"
L.SlashSupportInfo = "Переключает отслеживание поддержки (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashSupportChkBtn = "Отображать отслеживание поддержки. [|cFF99CC33ВКЛ|r]."

L.SlashSupportTarget = "цельподдержки"
L.SlashSupportTargetInfo = "Устанавливает цель поддержки на текущую выбранную цель. (АВТО: Танк группы)"
L.SlashSupportTargetUnit = "Цель поддержки установлена на: [|cFF99CC33%s|r]"
L.SlashSupportTargetInvalid = "Цель поддержки [|cFFDF2B2BНЕВЕРНАЯ|r]"

L.SlashInfinite = "бесконечный"
L.SlashInfiniteOn = "xanBuffTimers: Показывать баффы без длительности/таймеров или бесконечные. [|cFF99CC33ВКЛ|r]"
L.SlashInfiniteOff = "xanBuffTimers: Показывать баффы без длительности/таймеров или бесконечные. [|cFF99CC33ВЫКЛ|r]"
L.SlashInfiniteInfo = "Переключает отображение баффов без длительности/таймеров или бесконечных. (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashInfiniteChkBtn = "Показывать баффы без длительности/таймеров или бесконечные. [|cFF99CC33ВКЛ|r]."

L.SlashIcon = "иконка"
L.SlashIconOn = "xanBuffTimers: Показывать иконки баффов [|cFF99CC33ВКЛ|r]"
L.SlashIconOff = "xanBuffTimers: Показывать иконки баффов [|cFF99CC33ВЫКЛ|r]"
L.SlashIconInfo = "Переключает иконки баффов. (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashIconChkBtn = "Показывать иконки баффов. [|cFF99CC33ВКЛ|r]."

L.SlashSpellName = "название_заклинания"
L.SlashSpellNameOn = "xanBuffTimers: Показывать названия заклинаний баффов [|cFF99CC33ВКЛ|r]"
L.SlashSpellNameOff = "xanBuffTimers: Показывать названия заклинаний баффов [|cFF99CC33ВЫКЛ|r]"
L.SlashSpellNameInfo = "Переключает названия заклинаний баффов (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashSpellNameChkBtn = "Показывать названия заклинаний баффов. [|cFF99CC33ВКЛ|r]."

L.SlashHealers = "целители"
L.SlashHealersOn = "xanBuffTimers: Показывать только для целителей [|cFF99CC33ВКЛ|r]"
L.SlashHealersOff = "xanBuffTimers: Показывать только для целителей [|cFF99CC33ВЫКЛ|r]"
L.SlashHealersInfo = "Переключает отображение полос баффов только для целительских классов (|cFF99CC33ВКЛ/ВЫКЛ|r)."
L.SlashHealersChkBtn = "Показывать только для целителей. [|cFF99CC33ВКЛ|r]."

L.SlashReload = "перезагрузка"
L.SlashReloadText = "Перезагрузить полосы баффов"
L.SlashReloadInfo = "Перезагружает полосы баффов."
L.SlashReloadAlert = "xanBuffTimers: Полосы баффов перезагружены!"

L.TimeHour = "ч"
L.TimeMinute = "м"
L.TimeSecond = "с"

L.BarTargetAnchor = "xanBuffTimers: Якорь цели"
L.BarFocusAnchor = "xanBuffTimers: Якорь фокуса"
L.BarPlayerAnchor = "xanBuffTimers: Якорь игрока"
L.BarSupportAnchor = "xanBuffTimers: Якорь поддержки"

L.HideInRested = "Скрывать полосы баффов в зоне отдыха."
L.ShowTimerOnRight = "Показывать таймер справа от иконки дебаффа."

L.GraphicBarChkBtn = "Использовать графические полосы баффов."
L.BarColorText = "Цвет полосы баффов."

L.RetailWarningTitle = "ВНИМАНИЕ ПРОЧТИТЕ!!! ТОЛЬКО RETAIL"
L.RetailWarningBody = "Этот аддон больше не может работать на Retail из-за изменений API от Blizzard.\n\nBlizzard теперь помечает боевые данные аур как защищенные "секретные значения". Это означает, что аддоны не могут читать или вычислять длительность баффов, время окончания и другие боевые данные во время боя. Так как этот аддон должен вычислять оставшееся время для отрисовки полос, клиент блокирует его основную функциональность.\n\n|cFFFFFF00Это не баг xanBuffTimers.|r\n\n|cFFFF2020Это ограничение, введённое Blizzard.|r\n\nПохожие аддоны аур/таймеров (например, WeakAuras и другие трекеры баффов/дебаффов) столкнулись с той же проблемой и не могут показывать точные таймеры в бою на Retail.\n\nКороче: Retail блокирует доступ к точным данным, нужным этому аддону, поэтому бары баффов не будут работать. Этот аддон остаётся полностью работоспособным на Classic, TBC, Wrath и других не-Retail клиентах."
