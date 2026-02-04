local ADDON_NAME, private = ...

local L = private:NewLocale("itIT")
if not L then return end

L.SlashAnchor = "ancora"
L.SlashAnchorText = "Attiva/disattiva ancore del frame"
L.SlashAnchorOn = "xanBuffTimers: Ancore ora [|cFF99CC33MOSTRATE|r]"
L.SlashAnchorOff = "xanBuffTimers: Ancore ora [|cFF99CC33NASCOSTE|r]"
L.SlashAnchorInfo = "Attiva/disattiva le ancore spostabili."

L.SlashReset = "reimposta"
L.SlashResetText = "Reimposta posizioni delle ancore"
L.SlashResetInfo = "Reimposta le posizioni delle ancore."
L.SlashResetAlert = "xanBuffTimers: Posizioni delle ancore reimpostate!"

L.SlashScale = "scala"
L.SlashScaleSet = "xanBuffTimers: la scala e stata impostata su [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "Scala non valida! Il numero deve essere tra [0.5 - 5].  (0.5, 1, 3, 4.6, ecc.)"
L.SlashScaleInfo = "Imposta la scala dei frame bottino LootRollMover (0.5 - 5)."
L.SlashScaleText = "Scala barre xanBuffTimers"

L.SlashGrow = "crescita"
L.SlashGrowUp = "xanBuffTimers: Le barre cresceranno [|cFF99CC33SU|r]"
L.SlashGrowDown = "xanBuffTimers: Le barre cresceranno [|cFF99CC33GIU|r]"
L.SlashGrowInfo = "Attiva/disattiva la direzione di crescita delle barre (|cFF99CC33SU/GIU|r)."
L.SlashGrowChkBtn = "Le barre cresceranno [|cFF99CC33GIU|r]."

L.SlashSort = "ordina"
L.SlashSortDescending = "xanBuffTimers: Le barre ora saranno ordinate [|cFF99CC33DECRESCENTE|r]"
L.SlashSortAscending = "xanBuffTimers: Le barre ora saranno ordinate [|cFF99CC33CRESCENTE|r]"
L.SlashSortInfo = "Attiva/disattiva l'ordinamento delle barre. (|cFF99CC33CRESCENTE/DECRESCENTE|r)."
L.SlashSortChkBtn = "Le barre saranno ordinate [|cFF99CC33CRESCENTE|r]."

L.SlashTarget = "bersaglio"
L.SlashTargetOn = "xanBuffTimers: Mostra tracciamento bersaglio [|cFF99CC33ATTIVO|r]"
L.SlashTargetOff = "xanBuffTimers: Mostra tracciamento bersaglio [|cFF99CC33INATTIVO|r]"
L.SlashTargetInfo = "Attiva/disattiva il tracciamento del bersaglio (|cFF99CC33ATTIVO/INATTIVO|r)."
L.SlashTargetChkBtn = "Mostra tracciamento bersaglio. [|cFF99CC33ATTIVO|r]."

L.SlashFocus = "focus"
L.SlashFocusOn = "xanBuffTimers: Mostra tracciamento focus [|cFF99CC33ATTIVO|r]"
L.SlashFocusOff = "xanBuffTimers: Mostra tracciamento focus [|cFF99CC33INATTIVO|r]"
L.SlashFocusInfo = "Attiva/disattiva il tracciamento del focus (|cFF99CC33ATTIVO/INATTIVO|r)."
L.SlashFocusChkBtn = "Mostra tracciamento focus. [|cFF99CC33ATTIVO|r]."

L.SlashPlayer = "giocatore"
L.SlashPlayerOn = "xanBuffTimers: Mostra tracciamento giocatore [|cFF99CC33ATTIVO|r]"
L.SlashPlayerOff = "xanBuffTimers: Mostra tracciamento giocatore [|cFF99CC33INATTIVO|r]"
L.SlashPlayerInfo = "Attiva/disattiva il tracciamento del giocatore (|cFF99CC33ATTIVO/INATTIVO|r)."
L.SlashPlayerChkBtn = "Mostra tracciamento giocatore. [|cFF99CC33ATTIVO|r]."

L.SlashSupport = "supporto"
L.SlashSupportOn = "xanBuffTimers: Mostra tracciamento supporto [|cFF99CC33ATTIVO|r]"
L.SlashSupportOff = "xanBuffTimers: Mostra tracciamento supporto [|cFF99CC33INATTIVO|r]"
L.SlashSupportInfo = "Attiva/disattiva il tracciamento supporto (|cFF99CC33ATTIVO/INATTIVO|r)."
L.SlashSupportChkBtn = "Mostra tracciamento supporto. [|cFF99CC33ATTIVO|r]."

L.SlashSupportTarget = "bersagliosupporto"
L.SlashSupportTargetInfo = "Imposta il bersaglio di supporto sul bersaglio attuale. (AUTO: Tank del gruppo)"
L.SlashSupportTargetUnit = "Bersaglio di supporto impostato su: [|cFF99CC33%s|r]"
L.SlashSupportTargetInvalid = "Il bersaglio di supporto e [|cFFDF2B2BNON VALIDO|r]"

L.SlashInfinite = "infinito"
L.SlashInfiniteOn = "xanBuffTimers: Mostra buff senza durata/timer o infiniti. [|cFF99CC33ATTIVO|r]"
L.SlashInfiniteOff = "xanBuffTimers: Mostra buff senza durata/timer o infiniti. [|cFF99CC33INATTIVO|r]"
L.SlashInfiniteInfo = "Attiva/disattiva buff senza durata/timer o infiniti. (|cFF99CC33ATTIVO/INATTIVO|r)."
L.SlashInfiniteChkBtn = "Mostra buff senza durata/timer o infiniti. [|cFF99CC33ATTIVO|r]."

L.SlashIcon = "icona"
L.SlashIconOn = "xanBuffTimers: Mostra icone dei buff [|cFF99CC33ATTIVO|r]"
L.SlashIconOff = "xanBuffTimers: Mostra icone dei buff [|cFF99CC33INATTIVO|r]"
L.SlashIconInfo = "Attiva/disattiva le icone dei buff. (|cFF99CC33ATTIVO/INATTIVO|r)."
L.SlashIconChkBtn = "Mostra icone dei buff. [|cFF99CC33ATTIVO|r]."

L.SlashSpellName = "nomeincantesimo"
L.SlashSpellNameOn = "xanBuffTimers: Mostra nomi degli incantesimi dei buff [|cFF99CC33ATTIVO|r]"
L.SlashSpellNameOff = "xanBuffTimers: Mostra nomi degli incantesimi dei buff [|cFF99CC33INATTIVO|r]"
L.SlashSpellNameInfo = "Attiva/disattiva i nomi degli incantesimi dei buff (|cFF99CC33ATTIVO/INATTIVO|r)."
L.SlashSpellNameChkBtn = "Mostra nomi degli incantesimi dei buff. [|cFF99CC33ATTIVO|r]."

L.SlashHealers = "curatori"
L.SlashHealersOn = "xanBuffTimers: Mostra solo per curatori [|cFF99CC33ATTIVO|r]"
L.SlashHealersOff = "xanBuffTimers: Mostra solo per curatori [|cFF99CC33INATTIVO|r]"
L.SlashHealersInfo = "Attiva/disattiva la visualizzazione delle barre buff solo per classi curatrici (|cFF99CC33ATTIVO/INATTIVO|r)."
L.SlashHealersChkBtn = "Mostra solo per curatori. [|cFF99CC33ATTIVO|r]."

L.SlashReload = "ricarica"
L.SlashReloadText = "Ricarica barre dei buff"
L.SlashReloadInfo = "Ricarica barre dei buff."
L.SlashReloadAlert = "xanBuffTimers: Barre dei buff ricaricate!"

L.TimeHour = "h"
L.TimeMinute = "m"
L.TimeSecond = "s"

L.BarTargetAnchor = "xanBuffTimers: Ancora bersaglio"
L.BarFocusAnchor = "xanBuffTimers: Ancora focus"
L.BarPlayerAnchor = "xanBuffTimers: Ancora giocatore"
L.BarSupportAnchor = "xanBuffTimers: Ancora supporto"

L.HideInRested = "Nascondi le barre dei buff in un'area di riposo."
L.ShowTimerOnRight = "Mostra il timer a destra dell'icona del debuff."
