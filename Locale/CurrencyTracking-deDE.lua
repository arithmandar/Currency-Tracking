-- $Id$

local _G = getfenv(0)
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):NewLocale("CurrencyTracking", "deDE", false)

if not L then return end

if L then
L["CT_TITLE"] = "Währungsverfolgung"
L["CT_ADDON_NOTES"] = "Currency Tracking ist ein Add-on, das dir hilft, deine erhaltenen Währungen zu verfolgen, und die ausgewählten Währungen sogar am oberen Rand des Spielbildschirms anzeigt."
L["Options"] = "Optionen"
L["About"] = "Über"
L["Author"] = "Autor"
L["Addon Info"] = "Add-on-Informationen"

-- Trading goods
L["Elemental"] = "Elementar"
L["Meat"] = "Fleisch"
L["Potion"] = "Trank"
-- Display Settings
L["Display Settings"] = "Anzeigeeinstellungen"
L["Show currency info on screen"] = "Währungsinformationen auf dem Bildschirm anzeigen"
L["Show tooltip"] = "Tooltip anzeigen"
L["Show all currency's info in tooltip."] = "Alle Währungsinformationen im Tooltip anzeigen."
L["Show money info"] = "Geldinformationen anzeigen"
L["Enable to show total money together with currencies' info."] = "Aktivieren, um das gesamte Geld zusammen mit den Währungsinformationen anzuzeigen."
L["Reset position"] = "Position zurücksetzen"
L["Reset on-screen currency frame's position."] = "Position des Währungsfensters auf dem Bildschirm zurücksetzen."
L["Breakup numbers"] = "Zahlen gruppieren"
L["Converts a number into a localized string, grouping digits as required."] = "Wandelt eine Zahl in eine lokalisierte Zeichenfolge um und gruppiert Ziffern nach Bedarf."
L["Hide zero"] = "Nullwerte ausblenden"
L["Auto-hide items / currencies which have zero amount."] = "Gegenstände/Währungen mit einem Betrag von null automatisch ausblenden."
L["Icon first"] = "Symbol zuerst"
L["Put currency icon prior to its amount"] = "Währungssymbol vor dem Betrag anzeigen"
L["Always lock the currency info frame"] = "Währungsinformationsfenster immer sperren"
L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."] = "Aktivieren, um das Fenster auch außerhalb des Kampfes immer zu sperren. Deaktivieren, um es nur im Kampf zu sperren."
L["Hide while in pet battle"] = "Während eines Haustierkampfs ausblenden"
L["Automatically hide the tracking frame while in pet battle."] = "Das Verfolgungsfenster während eines Haustierkampfs automatisch ausblenden."
L["Hide while in combat"] = "Im Kampf ausblenden"
L["Automatically hide the tracking frame while in combat."] = "Das Verfolgungsfenster im Kampf automatisch ausblenden."
L["Hide while in battleground"] = "Auf Schlachtfeldern ausblenden"
L["Automatically hide the tracking frame while in battleground."] = "Das Verfolgungsfenster auf Schlachtfeldern automatisch ausblenden."
L["Show icon only"] = "Nur Symbol anzeigen"
L["Show only the currency / item's icon, do not show the amounts."] = "Nur das Symbol der Währung/des Gegenstands anzeigen, keine Beträge."
L["Max items per row"] = "Maximale Gegenstände pro Zeile"
L["Set the maximum number of items to be displayed per row. Set to 0 to allow unlimited items on one single row."] = "Lege die maximale Anzahl der pro Zeile angezeigten Gegenstände fest. Setze den Wert auf 0, um unbegrenzt viele Gegenstände in einer einzelnen Zeile zu erlauben."
L["Show Lower Denominations"] = "Kleinere Geldeinheiten anzeigen"
L["Enable to show all the lower denominations, disable to only show money in gold."] = "Aktivieren, um alle kleineren Geldeinheiten anzuzeigen. Deaktivieren, um Geld nur in Gold anzuzeigen."
-- Scale and Transparency
L["Scale and Transparency"] = "Skalierung und Transparenz"
L["On-screen frame"] = "Bildschirmfenster"
L["Tooltip"] = "Tooltip"
L["Scale"] = "Skalierung"
L["Transparency"] = "Transparenz"
L["Background"] = "Hintergrund"
L["Currencies info's background transparency"] = "Hintergrundtransparenz der Währungsinformationen"
-- Others
L["Currencies to be tracked on screen:"] = "Auf dem Bildschirm zu verfolgende Währungen:"
L["Tracked Currencies"] = "Verfolgte Währungen"
L["Tracked Items"] = "Verfolgte Gegenstände"
L["Profile Options"] = "Profiloptionen"
-- Click to track
L["Click to track"] = "Per Klick verfolgen"
L["Use this combination on an item in your bags, bank, guild bank or a chat link to start or stop tracking it. Use it on an item of the tracking bar to stop tracking it."] = "Verwende diese Kombination auf einen Gegenstand in deinen Taschen, der Bank, der Gildenbank oder einem Chatlink, um ihn zu verfolgen oder die Verfolgung zu beenden. Auf einem Gegenstand der Verfolgungsleiste beendet sie die Verfolgung."
L["Modifier key"] = "Modifikatortaste"
L["Mouse button"] = "Maustaste"
L["Disabled"] = "Deaktiviert"
L["Left-click"] = "Linksklick"
L["Right-click"] = "Rechtsklick"
L["Show hint in item tooltip"] = "Hinweis im Gegenstands-Tooltip anzeigen"
L["Custom Items"] = "Eigene Gegenstände"
L["No custom items yet."] = "Noch keine eigenen Gegenstände."
L["Items you added by clicking or by item ID, which are not in the predefined lists."] = "Per Klick oder Gegenstands-ID hinzugefügte Gegenstände, die nicht in den vordefinierten Listen enthalten sind."
L["%s on an item in your bags to add it here."] = "%s auf einen Gegenstand in deinen Taschen, um ihn hier hinzuzufügen."
L["Add item"] = "Gegenstand hinzufügen"
L["Enter an item ID or paste an item link."] = "Gib eine Gegenstands-ID ein oder füge einen Gegenstandslink ein."
L["Remove"] = "Entfernen"
L["%s is now tracked."] = "%s wird jetzt verfolgt."
L["%s is no longer tracked."] = "%s wird nicht mehr verfolgt."
L["%s: start tracking"] = "%s: Verfolgung starten"
L["%s: stop tracking"] = "%s: Verfolgung beenden"
end
