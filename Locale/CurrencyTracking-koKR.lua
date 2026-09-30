-- $Id$

local _G = getfenv(0)
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):NewLocale("CurrencyTracking", "koKR", false)

if not L then return end

if L then
L["CT_TITLE"] = "Currency Tracking"
L["CT_ADDON_NOTES"] = "Currency Tracking은 획득한 화폐를 추적하고 화면 상단에 선택한 화폐를 표시해주는 애드온입니다."
L["Options"] = "설정"
L["About"] = "대하여"
L["Author"] = "제작자"
L["Addon Info"] = "애드온 정보"

-- Trading goods
L["Elemental"] = "원소"
L["Meat"] = "고기"
L["Potion"] = "물약"
-- Display Settings
L["Display Settings"] = "표시 설정"
L["Show currency info on screen"] = "화면에 화폐 정보 표시"
L["Show tooltip"] = "툴팁 표시"
L["Show all currency's info in tooltip."] = "툴팁에 모든 화폐의 정보를 표시합니다."
L["Show money info"] = "소지금 정보 표시"
L["Enable to show total money together with currencies' info."] = "화폐 정보와 함께 전체 소지금을 표시하려면 활성화하세요."
L["Reset position"] = "위치 초기화"
L["Reset on-screen currency frame's position."] = "화면 표시 화폐 창의 위치를 초기화합니다."
L["Breakup numbers"] = "천단위 구분자"
L["Converts a number into a localized string, grouping digits as required."] = "화폐의 천단위 구분자를 표시"
L["Hide zero"] = "수량 0 숨기기"
L["Auto-hide items / currencies which have zero amount."] = "수량이 0인 아이템 / 화폐를 자동으로 숨깁니다."
L["Icon first"] = "아이콘을 앞에 표시"
L["Put currency icon prior to its amount"] = "화폐 아이콘을 앞에 표시"
L["Always lock the currency info frame"] = "화폐 정보 창 항상 고정"
L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."] = "전투 중이 아닐 때도 창을 항상 고정하려면 활성화하세요. 전투 중에만 창을 고정하려면 비활성하세요."
L["Hide while in pet battle"] = "애완동물 전투시 숨김"
L["Automatically hide the tracking frame while in pet battle."] = "애완동물 전투시에는 자동으로 추적창을 숨깁니다."
L["Hide while in combat"] = "전투중 숨김"
L["Automatically hide the tracking frame while in combat."] = "전투중에는 자동으로 추적창을 숨깁니다."
L["Hide while in battleground"] = "전장에서 숨김"
L["Automatically hide the tracking frame while in battleground."] = "전장에서는 자동으로 추적창을 숨깁니다."
L["Show icon only"] = "아이콘만 표시"
L["Show only the currency / item's icon, do not show the amounts."] = "현재 표시되는 화폐의 아이콘만 표시합니다."
L["Max items per row"] = "행의 아이템 최대 갯수"
L["Set the maximum number of items to be displayed per row. Set to 0 to allow unlimited items on one single row."] = "행에 표시할 아이템의 최대 갯수를 설정합니다. 무제한으로 표시하려면 0으로 설정합니다."
L["Show Lower Denominations"] = "소지금 전체 표시"
L["Enable to show all the lower denominations, disable to only show money in gold."] = "소지금 전체를 표시합니다. 해제하면 금화만 표시합니다."
-- Scale and Transparency
L["Scale and Transparency"] = "크기 비율 및 투명도"
L["On-screen frame"] = "화면 표시 창"
L["Tooltip"] = "툴팁"
L["Scale"] = "크기 비율"
L["Transparency"] = "투명도"
L["Background"] = "배경"
L["Currencies info's background transparency"] = "화폐 정보 배경 투명도"
-- Others
L["Currencies to be tracked on screen:"] = "화면에 추적중인 화폐:"
L["Tracked Currencies"] = "추적 중인 화폐"
L["Tracked Items"] = "추적 중인 아이템"
L["Profile Options"] = "프로필 설정"
end
