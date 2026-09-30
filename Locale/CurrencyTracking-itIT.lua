-- $Id$

local _G = getfenv(0)
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):NewLocale("CurrencyTracking", "itIT", false)

if not L then return end

if L then
L["CT_TITLE"] = "Monitoraggio valute"
L["CT_ADDON_NOTES"] = "Currency Tracking è un addon che ti aiuta a monitorare le valute ottenute, mostrando le valute selezionate anche nella parte superiore della schermata di gioco."
L["Options"] = "Opzioni"
L["About"] = "Informazioni"
L["Author"] = "Autore"
L["Addon Info"] = "Informazioni sull'addon"

-- Trading goods
L["Elemental"] = "Elementale"
L["Meat"] = "Carne"
L["Potion"] = "Pozione"
-- Display Settings
L["Display Settings"] = "Impostazioni di visualizzazione"
L["Show currency info on screen"] = "Mostra informazioni sulle valute sullo schermo"
L["Show tooltip"] = "Mostra tooltip"
L["Show all currency's info in tooltip."] = "Mostra tutte le informazioni sulle valute nel tooltip."
L["Show money info"] = "Mostra informazioni sul denaro"
L["Enable to show total money together with currencies' info."] = "Abilita per mostrare il denaro totale insieme alle informazioni sulle valute."
L["Reset position"] = "Reimposta posizione"
L["Reset on-screen currency frame's position."] = "Reimposta la posizione del riquadro delle valute sullo schermo."
L["Breakup numbers"] = "Raggruppa numeri"
L["Converts a number into a localized string, grouping digits as required."] = "Converte un numero in una stringa localizzata, raggruppando le cifre secondo necessità."
L["Hide zero"] = "Nascondi zero"
L["Auto-hide items / currencies which have zero amount."] = "Nascondi automaticamente gli oggetti/le valute con quantità pari a zero."
L["Icon first"] = "Icona prima"
L["Put currency icon prior to its amount"] = "Mostra l'icona della valuta prima della quantità"
L["Always lock the currency info frame"] = "Blocca sempre il riquadro delle informazioni sulle valute"
L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."] = "Abilita per bloccare sempre il riquadro, anche fuori combattimento. Disabilita per bloccarlo solo durante il combattimento."
L["Hide while in pet battle"] = "Nascondi durante le battaglie tra mascotte"
L["Automatically hide the tracking frame while in pet battle."] = "Nascondi automaticamente il riquadro di monitoraggio durante le battaglie tra mascotte."
L["Hide while in combat"] = "Nascondi durante il combattimento"
L["Automatically hide the tracking frame while in combat."] = "Nascondi automaticamente il riquadro di monitoraggio durante il combattimento."
L["Hide while in battleground"] = "Nascondi nei campi di battaglia"
L["Automatically hide the tracking frame while in battleground."] = "Nascondi automaticamente il riquadro di monitoraggio nei campi di battaglia."
L["Show icon only"] = "Mostra solo l'icona"
L["Show only the currency / item's icon, do not show the amounts."] = "Mostra solo l'icona della valuta/dell'oggetto, senza visualizzare le quantità."
L["Max items per row"] = "Numero massimo di oggetti per riga"
L["Set the maximum number of items to be displayed per row. Set to 0 to allow unlimited items on one single row."] = "Imposta il numero massimo di oggetti da visualizzare per riga. Imposta 0 per consentire un numero illimitato di oggetti su una sola riga."
L["Show Lower Denominations"] = "Mostra le denominazioni inferiori"
L["Enable to show all the lower denominations, disable to only show money in gold."] = "Abilita per mostrare tutte le denominazioni inferiori. Disabilita per mostrare il denaro solo in oro."
-- Scale and Transparency
L["Scale and Transparency"] = "Scala e trasparenza"
L["On-screen frame"] = "Riquadro sullo schermo"
L["Tooltip"] = "Tooltip"
L["Scale"] = "Scala"
L["Transparency"] = "Trasparenza"
L["Background"] = "Sfondo"
L["Currencies info's background transparency"] = "Trasparenza dello sfondo delle informazioni sulle valute"
-- Others
L["Currencies to be tracked on screen:"] = "Valute da monitorare sullo schermo:"
L["Tracked Currencies"] = "Valute monitorate"
L["Tracked Items"] = "Oggetti monitorati"
L["Profile Options"] = "Opzioni del profilo"
end
