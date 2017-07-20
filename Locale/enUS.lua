-- $Id$

local _G = getfenv(0)
local LibStub = _G.LibStub
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("CurrencyTracking", "enUS", true, true)

if L then
L["CT_TITLE"] = "Currency Tracking"
L["CT_ADDON_NOTES"] = "Currency Tracking is an addon to help you track the currencies you gained, showing the selected currency even on top of the game screen."
L["Options"] = "Options"
-- Display Settings
L["Display Settings"] = "Display Settings"
L["Show currency info on screen"] = "Show currency info on screen"
L["Show money info"] = "Show money info"
L["Enable to show total money together with currencies' info."] = "Enable to show total money together with currencies' info."
L["Reset position"] = "Reset position"
L["Reset on-screen currency frame's position."] = "Reset on-screen currency frame's position."
L["Breakup numbers"] = "Breakup numbers"
L["Converts a number into a localized string, grouping digits as required."] = "Converts a number into a localized string, grouping digits as required."
L["Icon first"] = "Icon first"
L["Put currency icon prior to its amount"] = "Put currency icon prior to its amount"
L["Always lock the currency info frame"] = "Always lock the currency info frame"
L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."] = "Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."
-- Scale and Transparency
L["Scale and Transparency"] = "Scale and Transparency"
L["On-screen frame"] = "On-screen frame"
L["Tooltip"] = "Tooltip"
L["Scale"] = "Scale"
L["Transparency"] = "Transparency"
L["Background"] = "Background"
L["Currencies info's background transparency"] = "Currencies info's background transparency"
-- Others
L["Currencies to be tracked on screen:"] = "Currencies to be tracked on screen:"
L["Tracked Currencies"] = "Tracked Currencies"
L["Tracked Items"] = "Tracked Items"
L["Profile Options"] = "Profile Options"
end