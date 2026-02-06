local ADDON_NAME, private = ...

local L = private:NewLocale("deDE")
if not L then return end

L.SlashAnchor = "anker"
L.SlashAnchorText = "Rahmenanker umschalten"
L.SlashAnchorOn = "xanBuffTimers: Anker jetzt [|cFF99CC33GEZEIGT|r]"
L.SlashAnchorOff = "xanBuffTimers: Anker jetzt [|cFF99CC33AUSGEBLENDET|r]"
L.SlashAnchorInfo = "Schaltet verschiebbare Anker um."

L.SlashReset = "zuruecksetzen"
L.SlashResetText = "Ankerpositionen zuruecksetzen"
L.SlashResetInfo = "Ankerpositionen zuruecksetzen."

L.Reset = "Zurücksetzen"

L.SlashScale = "skala"
L.SlashScaleSet = "xanBuffTimers: Skala wurde auf [|cFF20ff20%s|r] gesetzt"
L.SlashScaleSetInvalid = "Skala ungueltig! Zahl muss zwischen [0.5 - 5] liegen.  (0.5, 1, 3, 4.6, usw..)"
L.SlashScaleInfo = "Skalierung der LootRollMover-Beute-Frames setzen (0.5 - 5)."
L.SlashScaleText = "xanBuffTimers Balken-Skala"

L.SlashGrow = "wachsen"
L.SlashGrowUp = "xanBuffTimers: Balken wachsen jetzt [|cFF99CC33HOCH|r]"
L.SlashGrowDown = "xanBuffTimers: Balken wachsen jetzt [|cFF99CC33RUNTER|r]"
L.SlashGrowInfo = "Richtung der Balken umschalten (|cFF99CC33HOCH/RUNTER|r)."
L.SlashGrowChkBtn = "Balken wachsen [|cFF99CC33RUNTER|r]."

L.SlashSort = "sortieren"
L.SlashSortDescending = "xanBuffTimers: Balken werden jetzt [|cFF99CC33ABSTEIGEND|r] sortiert"
L.SlashSortAscending = "xanBuffTimers: Balken werden jetzt [|cFF99CC33AUFSTEIGEND|r] sortiert"
L.SlashSortInfo = "Sortierung der Balken umschalten. (|cFF99CC33AUFSTEIGEND/ABSTEIGEND|r)."
L.SlashSortChkBtn = "Balken sortieren [|cFF99CC33AUFSTEIGEND|r]."

L.SlashTarget = "ziel"
L.SlashTargetOn = "xanBuffTimers: Zielverfolgung anzeigen [|cFF99CC33AN|r]"
L.SlashTargetOff = "xanBuffTimers: Zielverfolgung anzeigen [|cFF99CC33AUS|r]"
L.SlashTargetInfo = "Zielverfolgung umschalten (|cFF99CC33AN/AUS|r)."
L.SlashTargetChkBtn = "Zielverfolgung anzeigen. [|cFF99CC33AN|r]."

L.SlashFocus = "fokus"
L.SlashFocusOn = "xanBuffTimers: Fokusverfolgung anzeigen [|cFF99CC33AN|r]"
L.SlashFocusOff = "xanBuffTimers: Fokusverfolgung anzeigen [|cFF99CC33AUS|r]"
L.SlashFocusInfo = "Fokusverfolgung umschalten (|cFF99CC33AN/AUS|r)."
L.SlashFocusChkBtn = "Fokusverfolgung anzeigen. [|cFF99CC33AN|r]."

L.SlashPlayer = "spieler"
L.SlashPlayerOn = "xanBuffTimers: Spielerverfolgung anzeigen [|cFF99CC33AN|r]"
L.SlashPlayerOff = "xanBuffTimers: Spielerverfolgung anzeigen [|cFF99CC33AUS|r]"
L.SlashPlayerInfo = "Spielerverfolgung umschalten (|cFF99CC33AN/AUS|r)."
L.SlashPlayerChkBtn = "Spielerverfolgung anzeigen. [|cFF99CC33AN|r]."

L.SlashSupport = "unterstuetzung"
L.SlashSupportOn = "xanBuffTimers: Unterstuetzung anzeigen [|cFF99CC33AN|r]"
L.SlashSupportOff = "xanBuffTimers: Unterstuetzung anzeigen [|cFF99CC33AUS|r]"
L.SlashSupportInfo = "Unterstuetzungsverfolgung umschalten (|cFF99CC33AN/AUS|r)."
L.SlashSupportChkBtn = "Unterstuetzung anzeigen. [|cFF99CC33AN|r]."

L.SlashSupportTarget = "stuetzziel"
L.SlashSupportTargetInfo = "Setzt das Unterstuetzungsziel auf dein aktuelles Ziel. (AUTO: Gruppen-Tank)"
L.SlashSupportTargetUnit = "Unterstuetzungsziel gesetzt auf: [|cFF99CC33%s|r]"
L.SlashSupportTargetInvalid = "Unterstuetzungsziel ist [|cFFDF2B2BUNGUELTIG|r]"

L.SlashInfinite = "unendlich"
L.SlashInfiniteOn = "xanBuffTimers: Buffs ohne Dauer/Timer oder unendliche anzeigen. [|cFF99CC33AN|r]"
L.SlashInfiniteOff = "xanBuffTimers: Buffs ohne Dauer/Timer oder unendliche anzeigen. [|cFF99CC33AUS|r]"
L.SlashInfiniteInfo = "Buffs ohne Dauer/Timer oder unendliche umschalten. (|cFF99CC33AN/AUS|r)."
L.SlashInfiniteChkBtn = "Buffs ohne Dauer/Timer oder unendliche anzeigen. [|cFF99CC33AN|r]."

L.SlashIcon = "symbol"
L.SlashIconOn = "xanBuffTimers: Buff-Symbole anzeigen [|cFF99CC33AN|r]"
L.SlashIconOff = "xanBuffTimers: Buff-Symbole anzeigen [|cFF99CC33AUS|r]"
L.SlashIconInfo = "Buff-Symbole umschalten. (|cFF99CC33AN/AUS|r)."
L.SlashIconChkBtn = "Buff-Symbole anzeigen. [|cFF99CC33AN|r]."

L.SlashSpellName = "zaubername"
L.SlashSpellNameOn = "xanBuffTimers: Buff-Zaubernamen anzeigen [|cFF99CC33AN|r]"
L.SlashSpellNameOff = "xanBuffTimers: Buff-Zaubernamen anzeigen [|cFF99CC33AUS|r]"
L.SlashSpellNameInfo = "Buff-Zaubernamen umschalten (|cFF99CC33AN/AUS|r)."
L.SlashSpellNameChkBtn = "Buff-Zaubernamen anzeigen. [|cFF99CC33AN|r]."

L.SlashHealers = "heiler"
L.SlashHealersOn = "xanBuffTimers: Nur fuer Heiler anzeigen [|cFF99CC33AN|r]"
L.SlashHealersOff = "xanBuffTimers: Nur fuer Heiler anzeigen [|cFF99CC33AUS|r]"
L.SlashHealersInfo = "Anzeige der Buff-Balken nur fuer Heilklassen umschalten (|cFF99CC33AN/AUS|r)."
L.SlashHealersChkBtn = "Nur fuer Heiler anzeigen. [|cFF99CC33AN|r]."

L.SlashReload = "neu"
L.SlashReloadText = "Buff-Balken neu laden"
L.SlashReloadInfo = "Buff-Balken neu laden."
L.SlashReloadAlert = "xanBuffTimers: Buff-Balken neu geladen!"

L.TimeHour = "h"
L.TimeMinute = "m"
L.TimeSecond = "s"

L.BarTargetAnchor = "xanBuffTimers: Zielanker"
L.BarFocusAnchor = "xanBuffTimers: Fokusanker"
L.BarPlayerAnchor = "xanBuffTimers: Spieleranker"
L.BarSupportAnchor = "xanBuffTimers: Unterstuetzungsanker"

L.HideInRested = "Buff-Balken in einer Ruhezone verbergen."
L.ShowTimerOnRight = "Timer rechts vom Debuff-Symbol anzeigen."

L.GraphicBarChkBtn = "Grafische Buffbalken verwenden."
L.BarColorText = "Buffbalken-Farbe."

L.RetailWarningTitle = "WARNUNG BITTE LESEN!!! NUR RETAIL"
L.RetailWarningBody = "Dieses Addon kann auf Retail aufgrund von Blizzards API-Änderungen nicht mehr funktionieren.\n\nBlizzard markiert kampfbezogene Auradaten jetzt als geschützte \"secret values\". Das bedeutet, Addons können in Kämpfen keine Buff-Dauern, Ablaufzeiten oder andere Kampfdaten lesen oder berechnen. Da dieses Addon die verbleibende Zeit berechnen muss, um Balken zu zeichnen, wird die Kernfunktion vom Client selbst blockiert.\n\n|cFFFFFF00Dies ist kein Bug in xanBuffTimers.|r\n\n|cFFFF2020Es ist eine von Blizzard durchgesetzte Einschränkung.|r\n\nÄhnliche Aura-/Timer-Addons (z. B. WeakAuras und andere Buff/Debuff-Tracker) stoßen auf dasselbe Problem und können auf Retail keine genauen Kampf-Timer anzeigen.\n\nKurz gesagt: Retail blockiert den Zugriff auf die Daten, die dieses Addon benötigt, daher funktionieren Buff-Balken dort nicht. Dieses Addon funktioniert weiterhin vollständig in Classic, TBC, Wrath und anderen Nicht-Retail-Clients."
