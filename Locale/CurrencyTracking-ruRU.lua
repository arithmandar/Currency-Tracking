-- $Id$

local _G = getfenv(0)
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):NewLocale("CurrencyTracking", "ruRU", false)

if not L then return end

if L then
L["CT_TITLE"] = "Currency Tracking"
L["CT_ADDON_NOTES"] = "Currency Tracking - это аддон, чтобы помогать вам отслеживать валюты, которые вы получили, показывая выбранную валюту даже на верхней части игрового экрана."
L["Options"] = "Параметры"
L["About"] = "О нас"
L["Author"] = "Автор"
L["Addon Info"] = "Информация о Аддоне"

-- Trading goods
L["Elemental"] = "Стихии"
L["Meat"] = "Мясо"
L["Potion"] = "Зелье"
-- Display Settings
L["Display Settings"] = "Настройки отображения"
L["Show currency info on screen"] = "Показать информацию о валюте на экране"
L["Show tooltip"] = "Показать подсказку"
L["Show all currency's info in tooltip."] = "Показать всю информацию о валюте в подсказке."
L["Show money info"] = "Показать информацию о деньгах"
L["Enable to show total money together with currencies' info."] = "При включении, показывает общую сумму золота, вместе с информацией валют."
L["Reset position"] = "Сбросить позицию"
L["Reset on-screen currency frame's position."] = "Сброс позиции рамки валюты на экране."
L["Breakup numbers"] = "Разделитель цифр"
L["Converts a number into a localized string, grouping digits as required."] = "Конвертирует числа в локализованную строку, группируя цифры по мере необходимости."
L["Hide zero"] = "Скрыть ноль"
L["Auto-hide items / currencies which have zero amount."] = "Авто-скрытие предметов / валюты, имеющих нулевую сумму."
L["Icon first"] = "Сначала значок"
L["Put currency icon prior to its amount"] = "Поставить значок валюты перед суммой"
L["Always lock the currency info frame"] = "Заблокировать окно"
L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."] = "При включение навсегда зафиксировать рамку, даже не в бою. Если отключено, только блокировать рамку во время боя."
L["Hide while in pet battle"] = "Скрыть во время битвы питомцев"
L["Automatically hide the tracking frame while in pet battle."] = "Автоматически скрывать рамку отслеживания во время битвы питомцев."
L["Hide while in combat"] = "Скрыть во время боя"
L["Automatically hide the tracking frame while in combat."] = "Автоматически скрывать рамку отслеживания во время боя."
L["Hide while in battleground"] = "Скрыть во время битвы на поле боя"
L["Automatically hide the tracking frame while in battleground."] = "Автоматически скрывать рамку отслеживания на поле боя."
L["Show icon only"] = "Показать только значок"
L["Show only the currency / item's icon, do not show the amounts."] = "Показывать только значок валюты / предмета, не показывать сумму."
L["Max items per row"] = "Максимальное количество предметов в строке"
L["Set the maximum number of items to be displayed per row. Set to 0 to allow unlimited items on one single row."] = "Установите максимальное количество предметов для каждой строки. Установите значение 0, чтобы разрешить неограниченное количество предметов в одной строке."
L["Show Lower Denominations"] = "Показать более низкую стоимость"
L["Enable to show all the lower denominations, disable to only show money in gold."] = "Включите, чтобы показать все низкие стоимости, отключите, чтобы показывать только деньги в золоте."
-- Scale and Transparency
L["Scale and Transparency"] = "Масштаб и прозрачность"
L["On-screen frame"] = "Рамка на экране"
L["Tooltip"] = "Подсказка"
L["Scale"] = "Масштаб"
L["Transparency"] = "Прозрачность"
L["Background"] = "Фон"
L["Currencies info's background transparency"] = "Прозрачность фона информации о валютах"
-- Others
L["Currencies to be tracked on screen:"] = "Валюты, отслеживаемые на экране:"
L["Tracked Currencies"] = "Отслеживать валюты"
L["Tracked Items"] = "Отслеживать предметы"
L["Profile Options"] = "Параметры профиля"
end
