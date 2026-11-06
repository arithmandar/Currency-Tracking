-- $Id$

local _G = getfenv(0)
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):NewLocale("CurrencyTracking", "frFR", false)

if not L then return end

if L then
L["CT_TITLE"] = "Suivi des monnaies"
L["CT_ADDON_NOTES"] = "Currency Tracking est un addon qui vous aide à suivre les monnaies obtenues et affiche les monnaies sélectionnées même en haut de l’écran de jeu."
L["Options"] = "Options"
L["About"] = "À propos"
L["Author"] = "Auteur"
L["Addon Info"] = "Informations sur l’addon"

-- Trading goods
L["Elemental"] = "Élémentaire"
L["Meat"] = "Viande"
L["Potion"] = "Potion"
-- Display Settings
L["Display Settings"] = "Paramètres d’affichage"
L["Show currency info on screen"] = "Afficher les informations sur les monnaies à l’écran"
L["Show tooltip"] = "Afficher l’infobulle"
L["Show all currency's info in tooltip."] = "Afficher toutes les informations sur les monnaies dans l’infobulle."
L["Show money info"] = "Afficher les informations sur l’argent"
L["Enable to show total money together with currencies' info."] = "Activez cette option pour afficher l’argent total avec les informations sur les monnaies."
L["Reset position"] = "Réinitialiser la position"
L["Reset on-screen currency frame's position."] = "Réinitialiser la position de la fenêtre des monnaies à l’écran."
L["Breakup numbers"] = "Regrouper les nombres"
L["Converts a number into a localized string, grouping digits as required."] = "Convertit un nombre en chaîne localisée en groupant les chiffres selon les besoins."
L["Hide zero"] = "Masquer les zéros"
L["Auto-hide items / currencies which have zero amount."] = "Masquer automatiquement les objets/monnaies dont la quantité est nulle."
L["Icon first"] = "Icône en premier"
L["Put currency icon prior to its amount"] = "Afficher l’icône de monnaie avant sa quantité"
L["Always lock the currency info frame"] = "Toujours verrouiller la fenêtre d’informations sur les monnaies"
L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."] = "Activez cette option pour toujours verrouiller la fenêtre, même hors combat. Désactivez-la pour verrouiller la fenêtre uniquement en combat."
L["Hide while in pet battle"] = "Masquer pendant les combats de mascottes"
L["Automatically hide the tracking frame while in pet battle."] = "Masquer automatiquement la fenêtre de suivi pendant les combats de mascottes."
L["Hide while in combat"] = "Masquer en combat"
L["Automatically hide the tracking frame while in combat."] = "Masquer automatiquement la fenêtre de suivi en combat."
L["Hide while in battleground"] = "Masquer dans les champs de bataille"
L["Automatically hide the tracking frame while in battleground."] = "Masquer automatiquement la fenêtre de suivi dans les champs de bataille."
L["Show icon only"] = "Afficher uniquement l’icône"
L["Show only the currency / item's icon, do not show the amounts."] = "Afficher uniquement l’icône de la monnaie/de l’objet, sans afficher les quantités."
L["Max items per row"] = "Nombre maximal d’objets par ligne"
L["Set the maximum number of items to be displayed per row. Set to 0 to allow unlimited items on one single row."] = "Définissez le nombre maximal d’objets à afficher par ligne. Définissez 0 pour autoriser un nombre illimité d’objets sur une seule ligne."
L["Show Lower Denominations"] = "Afficher les unités inférieures"
L["Enable to show all the lower denominations, disable to only show money in gold."] = "Activez cette option pour afficher toutes les unités monétaires inférieures. Désactivez-la pour afficher l’argent uniquement en or."
-- Scale and Transparency
L["Scale and Transparency"] = "Échelle et transparence"
L["On-screen frame"] = "Fenêtre à l’écran"
L["Tooltip"] = "Infobulle"
L["Scale"] = "Échelle"
L["Transparency"] = "Transparence"
L["Background"] = "Arrière-plan"
L["Currencies info's background transparency"] = "Transparence de l’arrière-plan des informations sur les monnaies"
-- Others
L["Currencies to be tracked on screen:"] = "Monnaies à suivre à l’écran :"
L["Tracked Currencies"] = "Monnaies suivies"
L["Tracked Items"] = "Objets suivis"
L["Profile Options"] = "Options du profil"
-- Click to track
L["Click to track"] = "Suivre par clic"
L["Use this combination on an item in your bags, bank, guild bank or a chat link to start or stop tracking it. Use it on an item of the tracking bar to stop tracking it."] = "Utilisez cette combinaison sur un objet de vos sacs, de la banque, de la banque de guilde ou d’un lien de discussion pour commencer ou arrêter son suivi. Sur un objet de la barre de suivi, elle arrête le suivi."
L["Modifier key"] = "Touche de modification"
L["Mouse button"] = "Bouton de la souris"
L["Disabled"] = "Désactivé"
L["Left-click"] = "Clic gauche"
L["Right-click"] = "Clic droit"
L["Show hint in item tooltip"] = "Afficher l’astuce dans l’infobulle de l’objet"
L["Custom Items"] = "Objets personnalisés"
L["No custom items yet."] = "Aucun objet personnalisé pour le moment."
L["Items you added by clicking or by item ID, which are not in the predefined lists."] = "Objets ajoutés par clic ou par ID qui ne figurent pas dans les listes prédéfinies."
L["%s on an item in your bags to add it here."] = "%s sur un objet de vos sacs pour l’ajouter ici."
L["Add item"] = "Ajouter un objet"
L["Enter an item ID or paste an item link."] = "Saisissez un ID d’objet ou collez un lien d’objet."
L["Remove"] = "Retirer"
L["%s is now tracked."] = "%s est maintenant suivi."
L["%s is no longer tracked."] = "%s n’est plus suivi."
L["%s: start tracking"] = "%s : commencer le suivi"
L["%s: stop tracking"] = "%s : arrêter le suivi"
end
