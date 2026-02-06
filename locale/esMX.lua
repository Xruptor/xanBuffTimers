local ADDON_NAME, private = ...

local L = private:NewLocale("esMX")
if not L then return end

L.SlashAnchor = "ancla"
L.SlashAnchorText = "Alternar anclas del marco"
L.SlashAnchorOn = "xanBuffTimers: Anclas ahora [|cFF99CC33MOSTRADAS|r]"
L.SlashAnchorOff = "xanBuffTimers: Anclas ahora [|cFF99CC33OCULTAS|r]"
L.SlashAnchorInfo = "Alterna las anclas movibles."

L.SlashReset = "reiniciar"
L.SlashResetText = "Restablecer posiciones de ancla"
L.SlashResetInfo = "Restablece las posiciones de ancla."

L.Reset = "Restablecer"

L.SlashScale = "escala"
L.SlashScaleSet = "xanBuffTimers: la escala se ha establecido en [|cFF20ff20%s|r]"
L.SlashScaleSetInvalid = "Escala invalida! El numero debe ser de [0.5 - 5].  (0.5, 1, 3, 4.6, etc..)"
L.SlashScaleInfo = "Establece la escala de los marcos de botin LootRollMover (0.5 - 5)."
L.SlashScaleText = "Escala de barras de xanBuffTimers"

L.SlashGrow = "crecer"
L.SlashGrowUp = "xanBuffTimers: Las barras ahora creceran [|cFF99CC33ARRIBA|r]"
L.SlashGrowDown = "xanBuffTimers: Las barras ahora creceran [|cFF99CC33ABAJO|r]"
L.SlashGrowInfo = "Alterna la direccion en la que crecen las barras (|cFF99CC33ARRIBA/ABAJO|r)."
L.SlashGrowChkBtn = "Las barras creceran [|cFF99CC33ABAJO|r]."

L.SlashSort = "ordenar"
L.SlashSortDescending = "xanBuffTimers: Las barras ahora se ordenaran [|cFF99CC33DESCENDENTE|r]"
L.SlashSortAscending = "xanBuffTimers: Las barras ahora se ordenaran [|cFF99CC33ASCENDENTE|r]"
L.SlashSortInfo = "Alterna la ordenacion de las barras. (|cFF99CC33ASCENDENTE/DESCENDENTE|r)."
L.SlashSortChkBtn = "Las barras se ordenaran [|cFF99CC33ASCENDENTE|r]."

L.SlashTarget = "objetivo"
L.SlashTargetOn = "xanBuffTimers: Mostrar seguimiento del objetivo [|cFF99CC33ACTIVO|r]"
L.SlashTargetOff = "xanBuffTimers: Mostrar seguimiento del objetivo [|cFF99CC33INACTIVO|r]"
L.SlashTargetInfo = "Alterna el seguimiento del objetivo (|cFF99CC33ACTIVO/INACTIVO|r)."
L.SlashTargetChkBtn = "Mostrar seguimiento del objetivo. [|cFF99CC33ACTIVO|r]."

L.SlashFocus = "foco"
L.SlashFocusOn = "xanBuffTimers: Mostrar seguimiento del foco [|cFF99CC33ACTIVO|r]"
L.SlashFocusOff = "xanBuffTimers: Mostrar seguimiento del foco [|cFF99CC33INACTIVO|r]"
L.SlashFocusInfo = "Alterna el seguimiento del foco (|cFF99CC33ACTIVO/INACTIVO|r)."
L.SlashFocusChkBtn = "Mostrar seguimiento del foco. [|cFF99CC33ACTIVO|r]."

L.SlashPlayer = "jugador"
L.SlashPlayerOn = "xanBuffTimers: Mostrar seguimiento del jugador [|cFF99CC33ACTIVO|r]"
L.SlashPlayerOff = "xanBuffTimers: Mostrar seguimiento del jugador [|cFF99CC33INACTIVO|r]"
L.SlashPlayerInfo = "Alterna el seguimiento del jugador (|cFF99CC33ACTIVO/INACTIVO|r)."
L.SlashPlayerChkBtn = "Mostrar seguimiento del jugador. [|cFF99CC33ACTIVO|r]."

L.SlashSupport = "apoyo"
L.SlashSupportOn = "xanBuffTimers: Mostrar seguimiento de apoyo [|cFF99CC33ACTIVO|r]"
L.SlashSupportOff = "xanBuffTimers: Mostrar seguimiento de apoyo [|cFF99CC33INACTIVO|r]"
L.SlashSupportInfo = "Alterna el seguimiento de apoyo (|cFF99CC33ACTIVO/INACTIVO|r)."
L.SlashSupportChkBtn = "Mostrar seguimiento de apoyo. [|cFF99CC33ACTIVO|r]."

L.SlashSupportTarget = "objetivoapoyo"
L.SlashSupportTargetInfo = "Establece el objetivo de apoyo en tu objetivo actual. (AUTO: Tanque del grupo)"
L.SlashSupportTargetUnit = "Objetivo de apoyo establecido en: [|cFF99CC33%s|r]"
L.SlashSupportTargetInvalid = "El objetivo de apoyo es [|cFFDF2B2BINVALIDO|r]"

L.SlashInfinite = "infinito"
L.SlashInfiniteOn = "xanBuffTimers: Mostrar beneficios sin duracion/temporizador o infinitos. [|cFF99CC33ACTIVO|r]"
L.SlashInfiniteOff = "xanBuffTimers: Mostrar beneficios sin duracion/temporizador o infinitos. [|cFF99CC33INACTIVO|r]"
L.SlashInfiniteInfo = "Alterna beneficios sin duracion/temporizador o infinitos. (|cFF99CC33ACTIVO/INACTIVO|r)."
L.SlashInfiniteChkBtn = "Mostrar beneficios sin duracion/temporizador o infinitos. [|cFF99CC33ACTIVO|r]."

L.SlashIcon = "icono"
L.SlashIconOn = "xanBuffTimers: Mostrar iconos de beneficios [|cFF99CC33ACTIVO|r]"
L.SlashIconOff = "xanBuffTimers: Mostrar iconos de beneficios [|cFF99CC33INACTIVO|r]"
L.SlashIconInfo = "Alterna iconos de beneficios. (|cFF99CC33ACTIVO/INACTIVO|r)."
L.SlashIconChkBtn = "Mostrar iconos de beneficios. [|cFF99CC33ACTIVO|r]."

L.SlashSpellName = "nombrehechizo"
L.SlashSpellNameOn = "xanBuffTimers: Mostrar nombres de hechizos de beneficios [|cFF99CC33ACTIVO|r]"
L.SlashSpellNameOff = "xanBuffTimers: Mostrar nombres de hechizos de beneficios [|cFF99CC33INACTIVO|r]"
L.SlashSpellNameInfo = "Alterna nombres de hechizos de beneficios (|cFF99CC33ACTIVO/INACTIVO|r)."
L.SlashSpellNameChkBtn = "Mostrar nombres de hechizos de beneficios. [|cFF99CC33ACTIVO|r]."

L.SlashHealers = "sanadores"
L.SlashHealersOn = "xanBuffTimers: Mostrar solo para sanadores [|cFF99CC33ACTIVO|r]"
L.SlashHealersOff = "xanBuffTimers: Mostrar solo para sanadores [|cFF99CC33INACTIVO|r]"
L.SlashHealersInfo = "Alterna mostrar barras de beneficios solo para clases de sanacion (|cFF99CC33ACTIVO/INACTIVO|r)."
L.SlashHealersChkBtn = "Mostrar solo para sanadores. [|cFF99CC33ACTIVO|r]."

L.SlashReload = "recargar"
L.SlashReloadText = "Recargar barras de beneficios"
L.SlashReloadInfo = "Recargar barras de beneficios."
L.SlashReloadAlert = "xanBuffTimers: Barras de beneficios recargadas!"

L.TimeHour = "h"
L.TimeMinute = "m"
L.TimeSecond = "s"

L.BarTargetAnchor = "xanBuffTimers: Ancla de objetivo"
L.BarFocusAnchor = "xanBuffTimers: Ancla de foco"
L.BarPlayerAnchor = "xanBuffTimers: Ancla de jugador"
L.BarSupportAnchor = "xanBuffTimers: Ancla de apoyo"

L.HideInRested = "Ocultar barras de beneficios en un area de descanso."
L.ShowTimerOnRight = "Mostrar el temporizador a la derecha del icono de perjuicio."

L.GraphicBarChkBtn = "Usar barras gráficas de beneficios."
L.BarColorText = "Color de la barra de beneficio."

L.RetailWarningTitle = "ADVERTENCIA ¡LEA POR FAVOR! SOLO RETAIL"
L.RetailWarningBody = "Este addon ya no puede funcionar en Retail debido a los cambios de API de Blizzard.\n\nBlizzard ahora marca los datos de auras en combate como \"valores secretos\" protegidos. Esto significa que los addons no pueden leer ni calcular duraciones de buffs, tiempos de expiración u otros datos de combate mientras estás en combate. Como este addon debe calcular el tiempo restante para dibujar barras, su función principal queda bloqueada por el propio cliente.\n\n|cFFFFFF00Esto no es un error de xanBuffTimers.|r\n\n|cFFFF2020Es una restricción impuesta por Blizzard.|r\n\nAddons similares de auras/temporizadores (por ejemplo, WeakAuras y otros rastreadores de buffs/debuffs) han chocado con el mismo problema y no pueden mostrar temporizadores precisos en Retail.\n\nEn resumen: Retail bloquea el acceso a los datos exactos que este addon necesita, por lo que las barras de buffs no funcionarán allí. Este addon sigue funcionando plenamente en Classic, TBC, Wrath y otros clientes no-Retail."
