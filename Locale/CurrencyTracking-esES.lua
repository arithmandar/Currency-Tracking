-- $Id$

local _G = getfenv(0)
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):NewLocale("CurrencyTracking", "esES", false)

if not L then return end

if L then
L["CT_TITLE"] = "Seguimiento de monedas"
L["CT_ADDON_NOTES"] = "Currency Tracking es un addon que te ayuda a seguir las monedas obtenidas y muestra las monedas seleccionadas incluso en la parte superior de la pantalla del juego."
L["Options"] = "Opciones"
L["About"] = "Acerca de"
L["Author"] = "Autor"
L["Addon Info"] = "Información del addon"

-- Trading goods
L["Elemental"] = "Elemental"
L["Meat"] = "Carne"
L["Potion"] = "Poción"
-- Display Settings
L["Display Settings"] = "Ajustes de visualización"
L["Show currency info on screen"] = "Mostrar información de monedas en pantalla"
L["Show tooltip"] = "Mostrar descripción emergente"
L["Show all currency's info in tooltip."] = "Mostrar toda la información de monedas en la descripción emergente."
L["Show money info"] = "Mostrar información de dinero"
L["Enable to show total money together with currencies' info."] = "Actívalo para mostrar el dinero total junto con la información de monedas."
L["Reset position"] = "Restablecer posición"
L["Reset on-screen currency frame's position."] = "Restablecer la posición del marco de monedas en pantalla."
L["Breakup numbers"] = "Separar números"
L["Converts a number into a localized string, grouping digits as required."] = "Convierte un número en una cadena localizada y agrupa los dígitos según sea necesario."
L["Hide zero"] = "Ocultar cero"
L["Auto-hide items / currencies which have zero amount."] = "Ocultar automáticamente los objetos/monedas con cantidad cero."
L["Icon first"] = "Icono primero"
L["Put currency icon prior to its amount"] = "Mostrar el icono de moneda antes de la cantidad"
L["Always lock the currency info frame"] = "Bloquear siempre el marco de información de monedas"
L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."] = "Actívalo para bloquear siempre el marco, incluso fuera de combate. Desactívalo para bloquearlo solo durante el combate."
L["Hide while in pet battle"] = "Ocultar durante los combates de mascotas"
L["Automatically hide the tracking frame while in pet battle."] = "Ocultar automáticamente el marco de seguimiento durante los combates de mascotas."
L["Hide while in combat"] = "Ocultar durante el combate"
L["Automatically hide the tracking frame while in combat."] = "Ocultar automáticamente el marco de seguimiento durante el combate."
L["Hide while in battleground"] = "Ocultar en campos de batalla"
L["Automatically hide the tracking frame while in battleground."] = "Ocultar automáticamente el marco de seguimiento en campos de batalla."
L["Show icon only"] = "Mostrar solo el icono"
L["Show only the currency / item's icon, do not show the amounts."] = "Mostrar solo el icono de la moneda/objeto, sin mostrar las cantidades."
L["Max items per row"] = "Máximo de objetos por fila"
L["Set the maximum number of items to be displayed per row. Set to 0 to allow unlimited items on one single row."] = "Establece el número máximo de objetos que se mostrarán por fila. Establécelo en 0 para permitir una cantidad ilimitada de objetos en una sola fila."
L["Show Lower Denominations"] = "Mostrar denominaciones inferiores"
L["Enable to show all the lower denominations, disable to only show money in gold."] = "Actívalo para mostrar todas las denominaciones inferiores. Desactívalo para mostrar el dinero solo en oro."
-- Scale and Transparency
L["Scale and Transparency"] = "Escala y transparencia"
L["On-screen frame"] = "Marco en pantalla"
L["Tooltip"] = "Descripción emergente"
L["Scale"] = "Escala"
L["Transparency"] = "Transparencia"
L["Background"] = "Fondo"
L["Currencies info's background transparency"] = "Transparencia del fondo de la información de monedas"
-- Others
L["Currencies to be tracked on screen:"] = "Monedas que se mostrarán en pantalla:"
L["Tracked Currencies"] = "Monedas seguidas"
L["Tracked Items"] = "Objetos seguidos"
L["Profile Options"] = "Opciones de perfil"
end
