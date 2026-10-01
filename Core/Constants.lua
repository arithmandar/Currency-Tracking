-- $Id$
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local string = _G.string
-- Libraries
local format = string.format
-- WoW
local GetBuildInfo = _G.GetBuildInfo
local C_Item, C_Spell = _G.C_Item, _G.C_Spell
local GetSpellInfo  =  C_Spell.GetSpellInfo
local GetItemInfoInstant, GetItemCount, GetItemInfo, GetItemIcon = C_Item.GetItemInfoInstant, C_Item.GetItemCount, C_Item.GetItemInfo, C_Item.GetItemIcon

-- Determine WoW client family
local _, _, _, interfaceVersion = GetBuildInfo()
local projectID = WOW_PROJECT_ID

local PROJECT_MAINLINE = WOW_PROJECT_MAINLINE
local PROJECT_CLASSIC = WOW_PROJECT_CLASSIC
local PROJECT_TBC = WOW_PROJECT_BURNING_CRUSADE_CLASSIC
local PROJECT_CATA = WOW_PROJECT_CATACLYSM_CLASSIC
local PROJECT_MISTS = WOW_PROJECT_MISTS_CLASSIC

-- Beta-only fallback:
-- Replace these bounds with values verified from the actual Forever client.
local isForeverBeta = projectID == PROJECT_MAINLINE and interfaceVersion >= 10000 and interfaceVersion < 20000

local isRetail = projectID == PROJECT_MAINLINE and not isForeverBeta
local isClassicEra = projectID == PROJECT_CLASSIC
local isAnniversaryTBC = PROJECT_TBC ~= nil and projectID == PROJECT_TBC
local isCataclysmClassic = PROJECT_CATA ~= nil and projectID == PROJECT_CATA
local isMistsClassic = PROJECT_MISTS ~= nil and projectID == PROJECT_MISTS
local isProgressionClassic = isCataclysmClassic or isMistsClassic
local isClassicForever = isForeverBeta
-- For API calls, Classic Forever is using same APIs with the mainline client.
local isAnyClassic = isClassicEra or isAnniversaryTBC or isProgressionClassic

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local _, private = ...
private.addon_name = "CurrencyTracking"

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

local constants = {}
private.constants = constants

if (isRetail or isProgressionClassic) then
	constants.ldb_icon = "Interface\\Icons\\wow-token01"
	--constants.ldb_icon = "Interface\\Icons\\timelesscoin"
else
	constants.ldb_icon = "Interface\\Icons\\wow-token01"
	--constants.ldb_icon = 237547
end

constants.defaults = {
	profile = {
		show_currency = true,
		show_money = true,
		show_iconOnly = false,
		show_tooltip = true,
		hide_zero = false,
		breakupnumbers = true,
		icon_first = false,
		always_lock = false,
		hide_in_combat = true,
		hide_in_petbattle = false,
		hide_in_battleground = true,
		--point = { "TOPLEFT", UIParent, "TOPLEFT", 150, -80 },
		latestpoint = { "TOPLEFT", "TOPLEFT", 150, -80 },
		scale = 1,
		alpha = 1,
		bgalpha = 0.3,
		tooltip_alpha = 0.9,
		tooltip_scale = 1,
		currencies = {},
		items = {},
		maxItems = 0, -- 0 means un-limited
		--optionsCopied = false,
		currencyFormatConverted = false,
		showLowerDenominations = true,
	},
}

constants.ITEM_CACHE_MIGRATION_VERSION = 2
constants.ITEM_CACHE_KEY = "localized_item_cache"
constants.CURRENCY_CACHE_MIGRATION_VERSION = 2
constants.CURRENCY_CACHE_KEY = "localized_currency_cache"

local function getProfessionText(spellid)
	if not spellid then 
		return ""
	end
	local spellInfo = GetSpellInfo(spellid)
	if spellInfo and spellInfo.iconID and spellInfo.name then
		return format("|T%d:16:16:2:0|t |cffffffff%s|r", spellInfo.iconID, spellInfo.name)
	else
		return ""
	end
end

local function getItemText(name, iconID)
    if not name or not iconID then
        return ""
    end

    return format("|T%d:16:16:2:0|t |cffffffff%s|r", iconID, name)
end

-- Item categories with icons and names
constants.itemCategories = {
	["World_Events"] = 	getItemText(BATTLE_PET_SOURCE_7, 133858),
	["PvP"] = 			getItemText(PVP, 133282),
	["Elemental"] = 	getItemText(L["Elemental"], 136006),
	["Meat"] = 			getItemText(L["Meat"], 134007),
	["Others"] = 		getItemText(MISCELLANEOUS,134503),
	["Tailoring"] = 	getProfessionText(3908),
	["Mining"] = 		getProfessionText(2575),
	["Leatherworking"] = getProfessionText(2108),
	["Enchanting"] = 	getProfessionText(7411),
	["Engineering"] = 	getProfessionText(4036),
	["Herbalism"] = 	getProfessionText(2366),
	["Alchemy"] = 		getProfessionText(2259),
	["Potion"] =        getItemText(L["Potion"], 134743),
	["Blacksmithing"] = getProfessionText(2018),
	["Fishing"] = 		getProfessionText(7620),
	["Cooking"] = 		getProfessionText(2550),
	["Relics"] = 		getItemText(INVTYPE_RELIC, 134459),
}

if (isRetail or isProgressionClassic) then
	constants.itemCategories["Jewelcrafting"] = getProfessionText(25229)
	constants.itemCategories["Inscription"] = 	getProfessionText(45357)
end

-- below to force currency category to be displayed in specific order
local currencyCategories = {}
local expansions = {}
local events = {}
if (isClassicEra) then
	currencyCategories = {
		-- Classic Era doesn't have any currency supported
	}
	expansions = {
		EXPANSION_NAME0, -- Classic
	}
	events = {
		"PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED",
		"BATTLEFIELDS_SHOW",
		"BATTLEFIELDS_CLOSED",
		"BAG_UPDATE",
		"TRADE_PLAYER_ITEM_CHANGED",
--		"CHAT_MSG_CURRENCY",
		-- Money
		"PLAYER_MONEY",
		"PLAYER_TRADE_MONEY",
		"TRADE_MONEY_CHANGED",
		"SEND_MAIL_MONEY_CHANGED",
		"SEND_MAIL_COD_CHANGED",
		"TRIAL_STATUS_UPDATE",
		"CHAT_MSG_MONEY",
	}
elseif(isAnniversaryTBC) then
	currencyCategories = {
		247, -- Player vs. Player
	}
	expansions = {
		EXPANSION_NAME0, -- Classic
		EXPANSION_NAME1, -- The Burning Crusade
	}
	events = {
		"PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED",
		"BATTLEFIELDS_SHOW",
		"BATTLEFIELDS_CLOSED",
		"BAG_UPDATE",
		"TRADE_PLAYER_ITEM_CHANGED",
--		"CHAT_MSG_CURRENCY",
		-- Money
		"PLAYER_MONEY",
		"PLAYER_TRADE_MONEY",
		"TRADE_MONEY_CHANGED",
		"SEND_MAIL_MONEY_CHANGED",
		"SEND_MAIL_COD_CHANGED",
		"TRIAL_STATUS_UPDATE",
		"CHAT_MSG_MONEY",
	}
elseif(isProgressionClassic) then
	currencyCategories = {
		133, -- Mists of Pandaria
		81, -- Cataclysm
	--	23, -- Burning Crusade
	--	21, -- Wrath of the Lich King
	--	4, -- Classic
		22, -- Dungeon and Raid
		2, -- Player vs. Player
		1, -- Miscellaneous
	--	3, -- Unused
	--	41, -- Test
		82, -- Archaeology
		89, -- Meta
	}
	expansions = {
		EXPANSION_NAME0, -- Classic
		EXPANSION_NAME1, -- The Burning Crusade
		EXPANSION_NAME2, -- Wrath of the Lich King
		EXPANSION_NAME3, -- Cataclysm
		EXPANSION_NAME4, -- Mists of Pandaria
	}
	events = {
		"PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED",
		"BATTLEFIELDS_SHOW",
		"BATTLEFIELDS_CLOSED",
		"BAG_UPDATE",
		"TRADE_PLAYER_ITEM_CHANGED",
		"CHAT_MSG_CURRENCY",
		"CURRENCY_DISPLAY_UPDATE",
		"PLAYER_MONEY",
		"PLAYER_TRADE_MONEY",
		"TRADE_MONEY_CHANGED",
		"SEND_MAIL_MONEY_CHANGED",
		"SEND_MAIL_COD_CHANGED",
		"TRIAL_STATUS_UPDATE",
		"CHAT_MSG_MONEY",
	}
elseif (isClassicForever) then
	currencyCategories = {
		273, -- Professions & Tradeskills
		22, -- Dungeon and Raid
		2, -- Player vs. Player
		1, -- Miscellaneous
	}
	expansions = {
		EXPANSION_NAME0, -- Classic
	}
	events = {
		"PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED",
		"BATTLEFIELDS_SHOW",
		"BATTLEFIELDS_CLOSED",
		"BAG_UPDATE",
		"TRADE_PLAYER_ITEM_CHANGED",
--		"CHAT_MSG_CURRENCY",
		-- Money
		"PLAYER_MONEY",
		"PLAYER_TRADE_MONEY",
		"TRADE_MONEY_CHANGED",
		"SEND_MAIL_MONEY_CHANGED",
		"SEND_MAIL_COD_CHANGED",
		"TRIAL_STATUS_UPDATE",
		"CHAT_MSG_MONEY",
	}
else
	-- below to force currency category to be displayed in specific order
	currencyCategories = {
		264, -- Midnight
		250, -- Dragonflight
		245, -- Shadowlands
		143, -- Battle for Azeroth
		141, -- Legion
		137, -- Warlords of Draenor
		133, -- Mists of Pandaria
		81, -- Cataclysm
		21, -- Wrath of the Lich King
		23, -- Burning Crusade
		4, -- Classic
	--	278, -- Sites Score UI (Hidden)
		280, -- Professions
		281, -- Delves
		282, -- Crests
		283, -- Zones
		284, -- Features
	--	268, -- Season 1
		277, -- Season 2
		263, -- Season 2
		265, -- Season 3
		260, -- War Within
		266, -- Timerunning
	--	251, -- Dragon Racing UI (Hidden)
	--	252, -- Tuskarr - Fishing Nets (Hidden)
	--	248, -- Torghast UI (Hidden)
	--	253, -- Test Subcategory 1
	--	254, -- Test Subcategory 2
	--	255, -- Test Subcategory 3
	--	256, -- Test Subcategory 4
	--	41, -- Test
	--	246, -- Debug
		82, -- Archaeology
		89, -- Meta
		142, -- Hidden
		144, -- Virtual
		2, -- Player vs. Player
		22, -- Dungeon and Raid
		1, -- Miscellaneous
		257, -- Legacy
	--	3, -- Unused
	}
	expansions = {
		EXPANSION_NAME0, -- Classic
		EXPANSION_NAME1, -- The Burning Crusade
		EXPANSION_NAME2, -- Wrath of the Lich King
		EXPANSION_NAME3, -- Cataclysm
		EXPANSION_NAME4, -- Mists of Pandaria
		EXPANSION_NAME5, -- Warlords of Draenor
		EXPANSION_NAME6, -- Legion
		EXPANSION_NAME7, -- Battle for Azeroth
		EXPANSION_NAME8, -- Shadowlands
		EXPANSION_NAME9, -- Dragonflight
		EXPANSION_NAME10, -- The War Within
		EXPANSION_NAME11, -- Midnight
	}
	events = {
		"PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED",
		"PET_BATTLE_OPENING_START",
		"PET_BATTLE_CLOSE",
		"BATTLEFIELDS_SHOW",
		"BATTLEFIELDS_CLOSED",
		"BAG_UPDATE",
		"TRADE_CURRENCY_CHANGED",
		"ARTIFACT_UPDATE",
		"ARTIFACT_XP_UPDATE",
		"TRADE_PLAYER_ITEM_CHANGED",
		"PLAYER_TRADE_CURRENCY",
		"CHAT_MSG_CURRENCY",
		"SHIPMENT_CRAFTER_REAGENT_UPDATE",
		"CURRENCY_DISPLAY_UPDATE",
		-- Money
		"PLAYER_MONEY",
		"PLAYER_TRADE_MONEY",
		"TRADE_MONEY_CHANGED",
		"SEND_MAIL_MONEY_CHANGED",
		"SEND_MAIL_COD_CHANGED",
		"TRIAL_STATUS_UPDATE",
		"CHAT_MSG_MONEY",
	}
end

constants.currencyCategories = currencyCategories
constants.expansions = expansions
constants.events = events
