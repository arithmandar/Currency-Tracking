-- $Id$
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
local format = string.format
-- WoW
local GetItemCount, GetItemInfo = _G.GetItemCount, _G.GetItemInfo
local GetTime, CreateFrame = _G.GetTime, _G.CreateFrame
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local Query = addon:NewModule("Query", "AceEvent-3.0")
addon.Query = Query

local db
local item_list
local SPAM_PROTECT = 0.5

-- codes adopted from AtlasLoot ItemQuery

function Query:OnInitialize()
	db = addon.db
	if (db.item_list == nil) then db.item_list = {} end
	item_list = db.item_list
end

function Query:OnEnable()

end

function Query:OnDisable()

end

--[[ ///////////////////////////
item_list structure:
	["item_list"] = {
		[item_id] = {
			itemname, icon
		},
	}
/////////////////////////////// ]]

local function refreshItem(item)
	if not item_list[item.itemID] then
		if ( item.itemName and item.icon ) then
			item_list[item.itemID] = { item.itemName, item.icon, }
		end
	else
		if ( item_list[item.itemID][1] ~= item.itemName ) then
			item_list[item.itemID] = { item.itemName, item.icon, }
		end
	end
end


-- scanItems()
-- pre-scan items so that they will properly showed in option panel
-- this function will not generate any visible result but it's more like scanning items 
-- so that those will be in your cache
function Query.ScanItems()
	for k, v in pairs(addon.constants.items) do
		if k == "professions" then
			for ka, profs in pairs(v) do
				for kb, itemID in ipairs(profs) do
					if ( item_list[itemID] and item_list[itemID][1] ) then
						-- do nothing
					else
						local itemName, icon, _
						itemName, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
						if not itemName then itemName, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID) end
						local item = {}
						item.itemID = itemID
						item.itemName = itemName
						item.icon = icon
						refreshItem(item)
					end
				end
			end
		else
			for ka, itemID in ipairs(v) do
				if ( item_list[itemID] and item_list[itemID][1] ) then
					-- do nothing
				else
					local itemName, icon, _
					itemName, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
					if not itemName then itemName, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID) end
					local item = {}
					item.itemID = itemID
					item.itemName = itemName
					item.icon = icon
					refreshItem(item)
				end
			end
		end
	end
end

