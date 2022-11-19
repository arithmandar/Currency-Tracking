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
local GetSpellTexture, GetSpellInfo, GetItemInfo, GetItemCount = _G.GetSpellTexture, _G.GetSpellInfo, _G.GetItemInfo, _G.GetItemCount

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
private.addon_name = "CurrencyTracking"

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

local constants = {}
private.constants = constants

constants.ldb_icon = "Interface\\Icons\\timelesscoin"

local WoWClassicEra, WoWClassicTBC, WoWWOTLKC, WoWRetail, WoWDragonflight
local wowversion  = select(4, GetBuildInfo())
if wowversion < 20000 then
	WoWClassicEra = true
elseif wowversion < 30000 then 
	WoWClassicTBC = true
elseif wowversion < 40000 then 
	WoWWOTLKC = true
elseif wowversion < 100000 then
	WoWRetail = true
else
	WoWDragonflight = true
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
		point = { "TOPLEFT", "UIParent", "TOPLEFT", 150, -80 },
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

local function getProfessionText(spellid)
	if not spellid then return end
	return format("|T%d:16:16:2:0|t |cffffffff%s|r", GetSpellTexture(spellid), GetSpellInfo(spellid))
end

local function getItemText(name, iconID)
	if not iconID then return end
	return format("|T%d:16:16:2:0|t |cffffffff%s|r", iconID, name)
end


constants.itemCategories = {
	["relics"] = 		getItemText(INVTYPE_RELIC, 134459),
	["world_events"] = 	getItemText(BATTLE_PET_SOURCE_7, 133858),
	["pvp"] = 			getItemText(PVP, 133282),
	["elemental"] = 	getItemText(L["Elemental"], 136006),
	["meat"] = 			getItemText(L["Meat"], 134007),
	["others"] = 		getItemText(MISCELLANEOUS,134503),
	["Tailoring"] = 	getProfessionText(3908),
	["Mining"] = 		getProfessionText(2575),
	["Leatherworking"] = getProfessionText(2108),
	["Enchanting"] = 	getProfessionText(7411),
	["Herbalism"] = 	getProfessionText(2366),
	["Engineering"] = 	getProfessionText(4036),
	["Alchemy"] = 		getProfessionText(2259),
	["Blacksmithing"] = getProfessionText(2018),
	["Fishing"] = 		getProfessionText(7620),
	["Cooking"] = 		getProfessionText(2550),
}

if (WoWWOTLKC or WoWRetail) then
	constants.itemCategories["Jewelcrafting"] = getProfessionText(25229)
	constants.itemCategories["Inscription"] = 	getProfessionText(86008)
end

-- below to force currency category to be displayed in specific order
constants.currencyCategories = {
	--252, --Tuskarr - Fishing Nets (Hidden)
	--251, -- Dragon Racing UI (Hidden)
	250, -- Dragonflight
	248, -- Torghast
	245, -- Shadowlands
	143, -- Battle for Azeroth
	141, -- Legion
	137, -- Warlords of Draenor
	133, -- Mists of Pandaria
	81, -- Cataclysm
	23, -- Burning Crusade
	21, -- Wrath of the Lich King
	2, -- Player vs. Player
	82, -- Archaeology
	22, -- Dungeon and Raid
	144, -- Virtual
	142, -- Hidden
	1, -- Miscellaneous
}

if (WoWClassicEra) then
	constants.expansions = {
		EXPANSION_NAME0, -- Classic
	}
elseif (WoWClassicTBC) then
	constants.expansions = {
		EXPANSION_NAME0, -- Classic
		EXPANSION_NAME1, -- The Burning Crusade
	}
elseif (WoWWOTLKC) then
	constants.expansions = {
		EXPANSION_NAME0, -- Classic
		EXPANSION_NAME1, -- The Burning Crusade
		EXPANSION_NAME2, -- Wrath of the Lich King
}
else
	constants.expansions = {
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
	}
end

if (WoWClassicEra or WoWClassicTBC) then
	constants.events = {
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
elseif (WoWWOTLKC) then
	constants.events = {
		"PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED",
--		"PET_BATTLE_OPENING_START",
--		"PET_BATTLE_CLOSE",
		"BATTLEFIELDS_SHOW",
		"BATTLEFIELDS_CLOSED",
		"BAG_UPDATE",
		"TRADE_CURRENCY_CHANGED",
--		"ARTIFACT_UPDATE",
--		"ARTIFACT_XP_UPDATE",
		"TRADE_PLAYER_ITEM_CHANGED",
		"PLAYER_TRADE_CURRENCY",
		"CHAT_MSG_CURRENCY",
--		"SHIPMENT_CRAFTER_REAGENT_UPDATE",
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

else
	constants.events = {
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