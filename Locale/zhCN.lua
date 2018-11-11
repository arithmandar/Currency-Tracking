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
L["About"] = "关于"
L["Author"] = "作者"
L["Addon Info"] = "插件信息"

-- Trading goods
L["Elemental"] = "元素"
L["Meat"] = "肉"
-- Display Settings
L["Display Settings"] = "显示设置"
L["Show currency info on screen"] = "在游戏画面上显示通货信息"
L["Show tooltip"] = "显示提示信息"
L["Show all currency's info in tooltip."] = "总是显示所有通货的提示信息。 "
L["Show money info"] = "显示现金信息"
L["Enable to show total money together with currencies' info."] = "启用以与通货信息一起显示目前的总现金信息。"
L["Reset position"] = "重设位置"
L["Reset on-screen currency frame's position."] = "重设游戏画面窗格的位置。"
L["Breakup numbers"] = "千分号"
L["Converts a number into a localized string, grouping digits as required."] = "将数字加上本地化千分号"
L["Hide zero"] = "隐藏数量为零的通货/物品"
L["Auto-hide items / currencies which have zero amount."] = "自动隐藏数量为零的通货或物品。"
L["Icon first"] = "图标优先"
L["Put currency icon prior to its amount"] = "先显示通货图标再显示其数量"
L["Always lock the currency info frame"] = "永远锁定通货信息窗口"
L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."] = "启用则将不仅限于战斗中才锁定。 停用则仅会于战斗中才锁定。"
L["Hide while in pet battle"] = "宠物对战时隐藏"
L["Automatically hide the tracking frame while in pet battle."] = "在宠物对战时自动隐藏追踪窗格。"
L["Hide while in combat"] = "战斗时隐藏"
L["Automatically hide the tracking frame while in combat."] = "在战斗时自动隐藏追踪窗格。"
L["Hide while in battleground"] = "在战场时隐藏"
L["Automatically hide the tracking frame while in battleground."] = "在战场时自动隐藏追踪窗格。"
L["Show icon only"] = "仅显示图标"
L["Show only the currency / item's icon, do not show the amounts."] = "仅显示通货/物品的图标，不显示其数量。"
L["Max items per row"] = "每行最多显示数量"
L["Set the maximum number of items to be displayed per row. Set to 0 to allow unlimited items on one single row."] = "设定每一行最多可显示多少通货/物品。 若设为0则表示单一一行显示无限数量的通货/物品。"
L["Show Lower Denominations"] = "显示较低面额"
L["Enable to show all the lower denominations, disable to only show money in gold."] = "勾选以显示所有较低面额的现金，取消则仅显示金币数量。"
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
