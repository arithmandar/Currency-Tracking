-- $Id$

local _G = getfenv(0)
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):NewLocale("CurrencyTracking", "zhCN", false)

if not L then return end

if L then
--@do-not-package@
L["CT_TITLE"] = "通货追踪";
L["CT_ADDON_NOTES"] = "追踪所有获取的通货，并显示在游戏画面上";
L["Options"] = "选项";
-- Display Settings
L["Display Settings"] = "显示设置"
L["Show currency info on screen"] = "在游戏画面上显示通货信息"
L["Show money info"] = "显示现金信息"
L["Enable to show total money together with currencies' info."] = "启用以与通货信息一起显示目前的总现金信息。"
L["Reset position"] = "重设位置"
L["Reset on-screen currency frame's position."] = "重设游戏画面窗格的位置。"
L["Breakup numbers"] = "千分号"
L["Converts a number into a localized string, grouping digits as required."] = "将数字加上本地化千分号"
L["Icon first"] = "图示优先"
L["Put currency icon prior to its amount"] = "先显示通货图标再显示其数量"
L["Always lock the currency info frame"] = "永远锁定通货信息窗口"
L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."] = "启用则将不仅限于战斗中才锁定。停用则仅会于战斗中才锁定。"
-- Scale and Transparency
L["Scale and Transparency"] = "大小与透明度"
L["On-screen frame"] = "游戏画面窗格"
L["Tooltip"] = "提示讯息"
L["Scale"] = "大小"
L["Transparency"] = "透明度"
L["Background"] = "背景"
L["Currencies info's background transparency"] = "通货信息的背景透明度"
-- Others
L["Currencies to be tracked on screen:"] = "在游戏画面上要追踪的通货："
L["Tracked Currencies"] = "追踪的通货"
L["Tracked Items"] = "追踪的物品"
L["Profile Options"] = "配置文件选项"
--@end-do-not-package@
--@localization(locale="zhCN", format="lua_additive_table")@
end
