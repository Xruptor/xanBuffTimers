local ADDON_NAME, private = ...

local L = private:NewLocale("frFR")
if not L then return end

L.SlashAnchor = "ancre"
L.SlashAnchorText = "Basculer les ancres du cadre"
L.SlashAnchorOn = "xanBuffTimers: Ancres maintenant [|cFF99CC33AFFICHEES|r]"
L.SlashAnchorOff = "xanBuffTimers: Ancres maintenant [|cFF99CC33CACHEES|r]"
L.SlashAnchorInfo = "Bascule les ancres deplacement."

L.SlashReset = "reinit"
L.SlashResetText = "Reinitialiser les positions d'ancre"
L.SlashResetInfo = "Reinitialise les positions d'ancre."
L.SlashResetAlert = "xanBuffTimers: Positions d'ancre reinitialisees !"

L.SlashScale = "echelle"
L.SlashScaleSet = "xanBuffTimers: l'echelle a ete definie sur [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "Echelle invalide ! Le nombre doit etre entre [0.5 - 5].  (0.5, 1, 3, 4.6, etc..)"
L.SlashScaleInfo = "Definir l'echelle des cadres de butin LootRollMover (0.5 - 5)."
L.SlashScaleText = "Echelle des barres xanBuffTimers"

L.SlashGrow = "croissance"
L.SlashGrowUp = "xanBuffTimers: Les barres vont maintenant croitre [|cFF99CC33VERS LE HAUT|r]"
L.SlashGrowDown = "xanBuffTimers: Les barres vont maintenant croitre [|cFF99CC33VERS LE BAS|r]"
L.SlashGrowInfo = "Basculer la direction de croissance des barres (|cFF99CC33HAUT/BAS|r)."
L.SlashGrowChkBtn = "Les barres vont croitre [|cFF99CC33VERS LE BAS|r]."

L.SlashSort = "tri"
L.SlashSortDescending = "xanBuffTimers: Les barres seront triees [|cFF99CC33DECROISSANT|r]"
L.SlashSortAscending = "xanBuffTimers: Les barres seront triees [|cFF99CC33CROISSANT|r]"
L.SlashSortInfo = "Basculer le tri des barres. (|cFF99CC33CROISSANT/DECROISSANT|r)."
L.SlashSortChkBtn = "Les barres seront triees [|cFF99CC33CROISSANT|r]."

L.SlashTarget = "cible"
L.SlashTargetOn = "xanBuffTimers: Afficher le suivi de la cible [|cFF99CC33ACTIF|r]"
L.SlashTargetOff = "xanBuffTimers: Afficher le suivi de la cible [|cFF99CC33INACTIF|r]"
L.SlashTargetInfo = "Bascule le suivi de la cible (|cFF99CC33ACTIF/INACTIF|r)."
L.SlashTargetChkBtn = "Afficher le suivi de la cible. [|cFF99CC33ACTIF|r]."

L.SlashFocus = "focus"
L.SlashFocusOn = "xanBuffTimers: Afficher le suivi du focus [|cFF99CC33ACTIF|r]"
L.SlashFocusOff = "xanBuffTimers: Afficher le suivi du focus [|cFF99CC33INACTIF|r]"
L.SlashFocusInfo = "Bascule le suivi du focus (|cFF99CC33ACTIF/INACTIF|r)."
L.SlashFocusChkBtn = "Afficher le suivi du focus. [|cFF99CC33ACTIF|r]."

L.SlashPlayer = "joueur"
L.SlashPlayerOn = "xanBuffTimers: Afficher le suivi du joueur [|cFF99CC33ACTIF|r]"
L.SlashPlayerOff = "xanBuffTimers: Afficher le suivi du joueur [|cFF99CC33INACTIF|r]"
L.SlashPlayerInfo = "Bascule le suivi du joueur (|cFF99CC33ACTIF/INACTIF|r)."
L.SlashPlayerChkBtn = "Afficher le suivi du joueur. [|cFF99CC33ACTIF|r]."

L.SlashSupport = "support"
L.SlashSupportOn = "xanBuffTimers: Afficher le suivi du support [|cFF99CC33ACTIF|r]"
L.SlashSupportOff = "xanBuffTimers: Afficher le suivi du support [|cFF99CC33INACTIF|r]"
L.SlashSupportInfo = "Bascule le suivi du support (|cFF99CC33ACTIF/INACTIF|r)."
L.SlashSupportChkBtn = "Afficher le suivi du support. [|cFF99CC33ACTIF|r]."

L.SlashSupportTarget = "ciblesupport"
L.SlashSupportTargetInfo = "Definit la cible de support sur votre cible actuelle. (AUTO: Tank de groupe)"
L.SlashSupportTargetUnit = "Cible de support definie sur : [|cFF99CC33%s|r]"
L.SlashSupportTargetInvalid = "Cible de support [|cFFDF2B2BINVALIDE|r]"

L.SlashInfinite = "infini"
L.SlashInfiniteOn = "xanBuffTimers: Afficher les buffs sans duree/minuteur ou infinis. [|cFF99CC33ACTIF|r]"
L.SlashInfiniteOff = "xanBuffTimers: Afficher les buffs sans duree/minuteur ou infinis. [|cFF99CC33INACTIF|r]"
L.SlashInfiniteInfo = "Bascule les buffs sans duree/minuteur ou infinis. (|cFF99CC33ACTIF/INACTIF|r)."
L.SlashInfiniteChkBtn = "Afficher les buffs sans duree/minuteur ou infinis. [|cFF99CC33ACTIF|r]."

L.SlashIcon = "icone"
L.SlashIconOn = "xanBuffTimers: Afficher les icones de buff [|cFF99CC33ACTIF|r]"
L.SlashIconOff = "xanBuffTimers: Afficher les icones de buff [|cFF99CC33INACTIF|r]"
L.SlashIconInfo = "Bascule les icones de buff. (|cFF99CC33ACTIF/INACTIF|r)."
L.SlashIconChkBtn = "Afficher les icones de buff. [|cFF99CC33ACTIF|r]."

L.SlashSpellName = "nomsort"
L.SlashSpellNameOn = "xanBuffTimers: Afficher les noms de sorts de buff [|cFF99CC33ACTIF|r]"
L.SlashSpellNameOff = "xanBuffTimers: Afficher les noms de sorts de buff [|cFF99CC33INACTIF|r]"
L.SlashSpellNameInfo = "Bascule les noms de sorts de buff (|cFF99CC33ACTIF/INACTIF|r)."
L.SlashSpellNameChkBtn = "Afficher les noms de sorts de buff. [|cFF99CC33ACTIF|r]."

L.SlashHealers = "soigneurs"
L.SlashHealersOn = "xanBuffTimers: Afficher pour les soigneurs uniquement [|cFF99CC33ACTIF|r]"
L.SlashHealersOff = "xanBuffTimers: Afficher pour les soigneurs uniquement [|cFF99CC33INACTIF|r]"
L.SlashHealersInfo = "Bascule l'affichage des barres de buff uniquement pour les classes de soin (|cFF99CC33ACTIF/INACTIF|r)."
L.SlashHealersChkBtn = "Afficher pour les soigneurs uniquement. [|cFF99CC33ACTIF|r]."

L.SlashReload = "recharger"
L.SlashReloadText = "Recharger les barres de buff"
L.SlashReloadInfo = "Recharger les barres de buff."
L.SlashReloadAlert = "xanBuffTimers: Barres de buff rechargees !"

L.TimeHour = "h"
L.TimeMinute = "m"
L.TimeSecond = "s"

L.BarTargetAnchor = "xanBuffTimers: Ancre de cible"
L.BarFocusAnchor = "xanBuffTimers: Ancre de focus"
L.BarPlayerAnchor = "xanBuffTimers: Ancre du joueur"
L.BarSupportAnchor = "xanBuffTimers: Ancre du support"

L.HideInRested = "Masquer les barres de buff en zone de repos."
L.ShowTimerOnRight = "Afficher le minuteur a droite de l'icone de debuff."
