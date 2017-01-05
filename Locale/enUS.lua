-- $Id$

local _G = getfenv(0);
local LibStub = _G.LibStub;
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("CurrencyTracking", "enUS", true, true);

if L then
	L["TITLE"] = "Currency Tracking";
	L["ADDON_NOTES"] = "Currency Tracking is an addon to help you track the currencies you gained, showing the selected currency even on top of the game screen.";
	L["Options"] = "Options";
	L["OPT_ShowOnScreen"] = "Show currency info on screen";
	L["OPT_BTN_Reset"] = "Reset position";
	L["OPT_TRANSPARENCY"] = "Currencies info tooltip's transparency";
	L["OPT_TOOLTIPSCALE"] = "Currencies info tooltip's scale";
	L["OPT_BREAKUPNUMBERS"] = "Converts a number into a localized string, grouping digits as required."
	L["CT_CURRENCY_TO_TRACK"] = "Currencies to be tracked on screen:";
end