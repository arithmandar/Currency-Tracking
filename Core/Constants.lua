-- $Id$
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
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

local WoWClassicEra, WoWClassicTBC, WoWWOTLKC, WoWRetail
local wowversion  = select(4, GetBuildInfo())
if wowversion < 20000 then
	WoWClassicEra = true
elseif wowversion < 30000 then 
	WoWClassicTBC = true
elseif wowversion < 40000 then 
	WoWWOTLKC = true
elseif wowversion > 90000 then
	WoWRetail = true
else
	-- n/a
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

constants.itemCategories = {
	["relics"] = INVTYPE_RELIC,
	["world_events"] = BATTLE_PET_SOURCE_7,
	["pvp"] = PVP,
	["elemental"] = L["Elemental"],
	["meat"] = L["Meat"], 
	["others"] = MISCELLANEOUS,
	["quest"] = ITEM_BIND_QUEST,
	["professions"] = TRADE_SKILLS,
}

if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then
	constants.events = {
		"PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED",
--		"PET_BATTLE_OPENING_START",
--		"PET_BATTLE_CLOSE",
		"BATTLEFIELDS_SHOW",
		"BATTLEFIELDS_CLOSED",
		"BAG_UPDATE",
--		"TRADE_CURRENCY_CHANGED",
--		"ARTIFACT_UPDATE",
--		"ARTIFACT_XP_UPDATE",
		"TRADE_PLAYER_ITEM_CHANGED",
--		"PLAYER_TRADE_CURRENCY",
		"CHAT_MSG_CURRENCY",
--		"SHIPMENT_CRAFTER_REAGENT_UPDATE",
--		"CURRENCY_DISPLAY_UPDATE",
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