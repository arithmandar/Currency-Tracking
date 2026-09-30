-- $Id$
-----------------------------------------------------------------------
-- Localized item-data cache and item query support.
-----------------------------------------------------------------------

local _G = getfenv(0)

local pairs = _G.pairs
local ipairs = _G.ipairs
local GetLocale = _G.GetLocale

local C_Item = _G.C_Item
local GetItemInfo = C_Item.GetItemInfo

local _, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)

local Query = addon:NewModule("Query", "AceEvent-3.0")
addon.Query = Query

local ITEM_CACHE_MIGRATION_VERSION = 2
local ITEM_CACHE_KEY = "localized_item_cache"

local item_list

function Query:OnInitialize()
    if CurrencyTrackingDB.item_cache_migration_version
        ~= ITEM_CACHE_MIGRATION_VERSION
    then
        -- Old entries used this locale-unaware positional format:
        --
        -- CurrencyTrackingDB.item_list[itemID] = {
        --     itemName,
        --     icon,
        --     itemLink,
        -- }
        --
        -- Discard it because names and item links are client-localized.
        CurrencyTrackingDB.item_list = nil
        CurrencyTrackingDB[ITEM_CACHE_KEY] = {}

        CurrencyTrackingDB.item_cache_migration_version = ITEM_CACHE_MIGRATION_VERSION
    end

    CurrencyTrackingDB[ITEM_CACHE_KEY] =
        CurrencyTrackingDB[ITEM_CACHE_KEY] or {}

    item_list = CurrencyTrackingDB[ITEM_CACHE_KEY]
end

function Query:OnEnable()
end

function Query:OnDisable()
end

--[[
CurrencyTrackingDB.localized_item_cache = {
    [itemID] = {
        name = "Localized item name",
        icon = iconFileID,
        link = "item link, when available",
        locale = "zhTW",
    },
}
]]

function Query:RefreshItem(item)
    if not item
        or not item.itemID
        or not item.itemName
        or not item.icon
    then
        return false
    end

    local locale = GetLocale()
    local cached = item_list[item.itemID]

    if cached
        and cached.locale == locale
        and cached.name == item.itemName
        and cached.icon == item.icon
        and cached.link == item.itemLink
    then
        return false
    end

    item_list[item.itemID] = {
        name = item.itemName,
        icon = item.icon,
        link = item.itemLink,
        locale = locale,
    }

    return true
end

function Query:GetCachedItem(itemID)
    if not itemID then
        return nil
    end

    local cached = item_list[itemID]

    if cached
        and cached.locale == GetLocale()
        and cached.name
        and cached.icon
    then
        return cached
    end

    return nil
end

local function QueryItem(itemID)
    local itemName, itemLink, _, _, _, _, _, _, _, icon =
        GetItemInfo(itemID)

    if not itemName or not icon then
        return false
    end

    return Query.RefreshItem({
        itemID = itemID,
        itemName = itemName,
        itemLink = itemLink,
        icon = icon,
    })
end

-- Pre-scans known items for the current client locale. Entries unavailable in
-- WoW's item cache are skipped and can be collected during a later scan.
function Query:ScanItems()
    local changed = false

    for _, category in pairs(addon.items) do
        for _, expansionItems in ipairs(category) do
            for _, itemID in ipairs(expansionItems) do
                if not Query:GetCachedItem(itemID) then
                    changed = QueryItem(itemID) or changed
                end
            end
        end
    end

    if changed and addon.InvalidateItemOptions then
        addon:InvalidateItemOptions()
    end

    return changed
end

