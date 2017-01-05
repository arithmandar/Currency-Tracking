-- $Id$

local L = LibStub("AceLocale-3.0"):NewLocale("CurrencyTracking", "zhTW", false)

if not L then return end

if L then
--@do-not-package@
	L["TITLE"] = "通貨追蹤";
	L["ADDON_NOTES"] = "追蹤所有獲取的通貨，並顯示在遊戲畫面上";
	L["Options"] = "選項";
	L["OPT_ShowOnScreen"] = "在遊戲畫面上顯示通貨資訊";
	L["OPT_BTN_Reset"] = "重置位置";
	L["OPT_TRANSPARENCY"] = "通貨資訊提示的透明度";
	L["OPT_TOOLTIPSCALE"] = "通貨資訊提示的大小比例";
	L["OPT_BREAKUPNUMBERS"] = "將數字加上本地化千分號"
	L["CT_CURRENCY_TO_TRACK"] = "在遊戲畫面上要追蹤的通貨：";
--@end-do-not-package@
--@localization(locale="zhTW", format="lua_additive_table")@
end