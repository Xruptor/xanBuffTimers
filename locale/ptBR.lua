local ADDON_NAME, private = ...

local L = private:NewLocale("ptBR")
if not L then return end

L.SlashAnchor = "ancora"
L.SlashAnchorText = "Alternar ancoras do quadro"
L.SlashAnchorOn = "xanBuffTimers: Ancoras agora [|cFF99CC33MOSTRADAS|r]"
L.SlashAnchorOff = "xanBuffTimers: Ancoras agora [|cFF99CC33OCULTAS|r]"
L.SlashAnchorInfo = "Alterna ancoras moveis."

L.SlashReset = "reiniciar"
L.SlashResetText = "Redefinir posicoes das ancoras"
L.SlashResetInfo = "Redefine posicoes das ancoras."

L.Reset = "Reiniciar"

L.SlashScale = "escala"
L.SlashScaleSet = "xanBuffTimers: a escala foi definida para [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "Escala invalida! O numero deve ser de [0.5 - 5].  (0.5, 1, 3, 4.6, etc..)"
L.SlashScaleInfo = "Definir a escala dos frames de saque LootRollMover (0.5 - 5)."
L.SlashScaleText = "Escala das barras xanBuffTimers"

L.SlashGrow = "crescer"
L.SlashGrowUp = "xanBuffTimers: As barras agora crescerao [|cFF99CC33PARA CIMA|r]"
L.SlashGrowDown = "xanBuffTimers: As barras agora crescerao [|cFF99CC33PARA BAIXO|r]"
L.SlashGrowInfo = "Alterna a direcao em que as barras crescem (|cFF99CC33CIMA/BAIXO|r)."
L.SlashGrowChkBtn = "As barras crescerao [|cFF99CC33PARA BAIXO|r]."

L.SlashSort = "ordenar"
L.SlashSortDescending = "xanBuffTimers: As barras agora serao ordenadas [|cFF99CC33DECRESCENTE|r]"
L.SlashSortAscending = "xanBuffTimers: As barras agora serao ordenadas [|cFF99CC33CRESCENTE|r]"
L.SlashSortInfo = "Alterna a ordenacao das barras. (|cFF99CC33CRESCENTE/DECRESCENTE|r)."
L.SlashSortChkBtn = "As barras serao ordenadas [|cFF99CC33CRESCENTE|r]."

L.SlashTarget = "alvo"
L.SlashTargetOn = "xanBuffTimers: Mostrar rastreamento do alvo [|cFF99CC33ATIVO|r]"
L.SlashTargetOff = "xanBuffTimers: Mostrar rastreamento do alvo [|cFF99CC33INATIVO|r]"
L.SlashTargetInfo = "Alterna o rastreamento do alvo (|cFF99CC33ATIVO/INATIVO|r)."
L.SlashTargetChkBtn = "Mostrar rastreamento do alvo. [|cFF99CC33ATIVO|r]."

L.SlashFocus = "foco"
L.SlashFocusOn = "xanBuffTimers: Mostrar rastreamento do foco [|cFF99CC33ATIVO|r]"
L.SlashFocusOff = "xanBuffTimers: Mostrar rastreamento do foco [|cFF99CC33INATIVO|r]"
L.SlashFocusInfo = "Alterna o rastreamento do foco (|cFF99CC33ATIVO/INATIVO|r)."
L.SlashFocusChkBtn = "Mostrar rastreamento do foco. [|cFF99CC33ATIVO|r]."

L.SlashPlayer = "jogador"
L.SlashPlayerOn = "xanBuffTimers: Mostrar rastreamento do jogador [|cFF99CC33ATIVO|r]"
L.SlashPlayerOff = "xanBuffTimers: Mostrar rastreamento do jogador [|cFF99CC33INATIVO|r]"
L.SlashPlayerInfo = "Alterna o rastreamento do jogador (|cFF99CC33ATIVO/INATIVO|r)."
L.SlashPlayerChkBtn = "Mostrar rastreamento do jogador. [|cFF99CC33ATIVO|r]."

L.SlashSupport = "suporte"
L.SlashSupportOn = "xanBuffTimers: Mostrar rastreamento de suporte [|cFF99CC33ATIVO|r]"
L.SlashSupportOff = "xanBuffTimers: Mostrar rastreamento de suporte [|cFF99CC33INATIVO|r]"
L.SlashSupportInfo = "Alterna o rastreamento de suporte (|cFF99CC33ATIVO/INATIVO|r)."
L.SlashSupportChkBtn = "Mostrar rastreamento de suporte. [|cFF99CC33ATIVO|r]."

L.SlashSupportTarget = "alvosuporte"
L.SlashSupportTargetInfo = "Define o alvo de suporte para seu alvo atual. (AUTO: Tank do grupo)"
L.SlashSupportTargetUnit = "Alvo de suporte definido para: [|cFF99CC33%s|r]"
L.SlashSupportTargetInvalid = "O alvo de suporte e [|cFFDF2B2BINVALIDO|r]"

L.SlashInfinite = "infinito"
L.SlashInfiniteOn = "xanBuffTimers: Mostrar buffs sem duracao/temporizadores ou infinitos. [|cFF99CC33ATIVO|r]"
L.SlashInfiniteOff = "xanBuffTimers: Mostrar buffs sem duracao/temporizadores ou infinitos. [|cFF99CC33INATIVO|r]"
L.SlashInfiniteInfo = "Alterna buffs sem duracao/temporizadores ou infinitos. (|cFF99CC33ATIVO/INATIVO|r)."
L.SlashInfiniteChkBtn = "Mostrar buffs sem duracao/temporizadores ou infinitos. [|cFF99CC33ATIVO|r]."

L.SlashIcon = "icone"
L.SlashIconOn = "xanBuffTimers: Mostrar icones de buffs [|cFF99CC33ATIVO|r]"
L.SlashIconOff = "xanBuffTimers: Mostrar icones de buffs [|cFF99CC33INATIVO|r]"
L.SlashIconInfo = "Alterna icones de buffs. (|cFF99CC33ATIVO/INATIVO|r)."
L.SlashIconChkBtn = "Mostrar icones de buffs. [|cFF99CC33ATIVO|r]."

L.SlashSpellName = "nomefeitico"
L.SlashSpellNameOn = "xanBuffTimers: Mostrar nomes de feiticos de buffs [|cFF99CC33ATIVO|r]"
L.SlashSpellNameOff = "xanBuffTimers: Mostrar nomes de feiticos de buffs [|cFF99CC33INATIVO|r]"
L.SlashSpellNameInfo = "Alterna nomes de feiticos de buffs (|cFF99CC33ATIVO/INATIVO|r)."
L.SlashSpellNameChkBtn = "Mostrar nomes de feiticos de buffs. [|cFF99CC33ATIVO|r]."

L.SlashHealers = "curadores"
L.SlashHealersOn = "xanBuffTimers: Mostrar apenas para curadores [|cFF99CC33ATIVO|r]"
L.SlashHealersOff = "xanBuffTimers: Mostrar apenas para curadores [|cFF99CC33INATIVO|r]"
L.SlashHealersInfo = "Alterna exibicao das barras de buffs apenas para classes de cura (|cFF99CC33ATIVO/INATIVO|r)."
L.SlashHealersChkBtn = "Mostrar apenas para curadores. [|cFF99CC33ATIVO|r]."

L.SlashReload = "recarregar"
L.SlashReloadText = "Recarregar barras de buffs"
L.SlashReloadInfo = "Recarregar barras de buffs."
L.SlashReloadAlert = "xanBuffTimers: Barras de buffs recarregadas!"

L.TimeHour = "h"
L.TimeMinute = "m"
L.TimeSecond = "s"

L.BarTargetAnchor = "xanBuffTimers: Ancora do alvo"
L.BarFocusAnchor = "xanBuffTimers: Ancora do foco"
L.BarPlayerAnchor = "xanBuffTimers: Ancora do jogador"
L.BarSupportAnchor = "xanBuffTimers: Ancora do suporte"

L.HideInRested = "Ocultar barras de buffs em uma area de descanso."
L.ShowTimerOnRight = "Mostrar o temporizador a direita do icone de debuff."

L.GraphicBarChkBtn = "Usar barras gráficas de buffs."
L.BarColorText = "Cor da barra de buff."

L.RetailWarningTitle = "AVISO POR FAVOR LEIA!!! SOMENTE RETAIL"
L.RetailWarningBody = "Este addon não pode mais funcionar no Retail devido às mudanças na API da Blizzard.\n\nA Blizzard agora marca dados de auras em combate como "valores secretos" protegidos. Isso significa que addons não podem ler ou calcular durações de buffs, tempos de expiração ou outros dados de combate enquanto você está em combate. Como este addon precisa calcular o tempo restante para desenhar as barras, a funcionalidade principal é bloqueada pelo próprio cliente.\n\n|cFFFFFF00Isso não é um bug do xanBuffTimers.|r\n\n|cFFFF2020É uma restrição imposta pela Blizzard.|r\n\nAddons semelhantes de auras/temporizadores (por exemplo, WeakAuras e outros rastreadores de buffs/debuffs) enfrentam o mesmo problema e não conseguem mostrar temporizadores precisos no Retail.\n\nEm resumo: o Retail bloqueia o acesso aos dados exatos que este addon precisa, então as barras de buff não funcionarão. Este addon continua funcionando plenamente no Classic, TBC, Wrath e outros clientes não-Retail."
