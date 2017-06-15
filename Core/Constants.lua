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

local constants = {}
private.constants = constants

constants.defaults = {
	profile = {
		show_currency = true,
		show_money = true,
		breakupnumbers = true,
		icon_first = false,
		always_lock = false,
		point = { "TOPLEFT", "UIParent", "TOPLEFT", 150, -80 },
		scale = 1,
		alpha = 1,
		bgalpha = 0.3,
		tooltip_alpha = 0.9,
		tooltip_scale = 1,
		currencies = {},
		optionsCopied = false,
	},
}

constants.events = {
	"PLAYER_REGEN_ENABLED",
	"PLAYER_REGEN_DISABLED",
}
