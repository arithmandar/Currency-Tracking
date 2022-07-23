-- $Id$
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs, ipairs, type = _G.pairs, _G.ipairs, _G.type
local math = _G.math
local table = _G.table
local tsort = table.sort
local string = _G.string
-- Libraries
local format = string.format
-- WoW
local GetSpellTexture, GetSpellInfo, GetItemInfo, GetItemCount = _G.GetSpellTexture, _G.GetSpellInfo, _G.GetItemInfo, _G.GetItemCount
local GetLocale = _G.GetLocale

local WoWClassicEra, WoWClassicTBC, WoWWOTLKC, WoWRetail, WoWDragonflight
local wowversion  = select(4, GetBuildInfo())
if wowversion < 20000 then
	WoWClassicEra = true
elseif wowversion < 30000 then 
	WoWClassicTBC = true
elseif wowversion < 40000 then 
	WoWWOTLKC = true
elseif wowversion < 100000 then
	WoWRetail = true
else
	WoWDragonflight = true
end
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local LibCurrencyInfo = LibStub:GetLibrary("LibCurrencyInfo")

local AceConfigReg = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")

local profile
local item_list


local function orderednext(t, n)
	local key = t[t.__next]
	
	if not key then return end
	t.__next = t.__next + 1
	return key, t.__source[key]
end

local function orderedpairs(t, f)
	local keys, kn = {__source = t, __next = 1}, 1
	
	for k in pairs(t) do
		keys[kn], kn = k, kn + 1
	end
	tsort(keys, f)
	return orderednext, keys
end

-- /////////////////////////////////////////////////////////
-- Options
-- /////////////////////////////////////////////////////////
local optGetter, optSetter
do
	function optGetter(info)
		local key = info[#info]
		return addon.db.profile[key]
	end

	function optSetter(info, value)
		local key = info[#info]
		addon.db.profile[key] = value
		addon:Refresh()
	end
end

local aboutPanel, moduleOptions = nil, {}
local function getAboutPanel()
	if not aboutPanel then
		aboutPanel = {
			type = "group",
			name = addon.LocName,
			args = {
				general = {
					order = 1,
					type = "group",
					name = L["About"],
					args = {
						description = {
							order = 10,
							type = "description",
							name = addon.Notes,
							width = "full",
						},
						info = {
							order = 20,
							type = "group",
							name = L["Addon Info"],
							inline = true,
							args = {
								version = {
									order = 21,
									type = "description",
									name = GAME_VERSION_LABEL..HEADER_COLON.." "..addon.Version,
									width = "full",
								},
								update = {
									order = 22, 
									type = "description",
									name = UPDATE..HEADER_COLON.." "..addon.UpdateDate,
									width = "full",
								},
								author = {
									order = 23, 
									type = "description",
									name = L["Author"]..HEADER_COLON.." "..addon.Author,
									width = "full",
								},
							},
						},
					},
				},
			},
		}
		for k,v in pairs(moduleOptions) do
			aboutPanel.args[k] = (type(v) == "function") and v() or v
		end
	end
	
	return aboutPanel
end

local options

local function getOptions()
	profile = addon.db.profile
	if not options then
		options = {
			order = 1,
			type = "group",
			name = L["Options"],
			get = optGetter,
			set = optSetter,
			args = {
				group1 = { -- On-screen frame
					order = 10,
					type = "group",
					name = L["On-screen frame"],
					inline = true,
					args = {
						show_currency = {
							order = 11,
							type = "toggle",
							name = L["Show currency info on screen"],
							width = "full",
						},
						show_tooltip = {
							order = 11.1,
							type = "toggle",
							name = L["Show tooltip"],
							desc = L["Show all currency's info in tooltip."],
							width = "full",
							disabled = function() return not addon.db.profile.show_currency end,
						},
						always_lock = {
							order = 12,
							type = "toggle",
							name = L["Always lock the currency info frame"],
							desc = L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."],
							width = "full",
							disabled = function() return not addon.db.profile.show_currency end,
						},
						hide_in_combat = {
							order = 13,
							type = "toggle",
							name = L["Hide while in combat"],
							desc = L["Automatically hide the tracking frame while in combat."],
							width = "full",
							disabled = function() return not addon.db.profile.show_currency end,
						},
						hide_in_battleground = {
							order = 14,
							type = "toggle",
							name = L["Hide while in battleground"],
							desc = L["Automatically hide the tracking frame while in battleground."],
							width = "full",
							disabled = function() return not addon.db.profile.show_currency end,
						},
						hide_in_petbattle = {
							order = 15,
							type = "toggle",
							name = L["Hide while in pet battle"],
							desc = L["Automatically hide the tracking frame while in pet battle."],
							width = "full",
							disabled = function() return not addon.db.profile.show_currency end,
						},
						resetPos = {
							order = 20, 
							type = "execute",
							name = L["Reset position"],
							desc = L["Reset on-screen currency frame's position."],
							func = function()
								addon.frame:SetPoint("TOPLEFT", nil, "TOPLEFT", 150, -80)
								profile.point = { "TOPLEFT", "UIParent", "TOPLEFT", 150, -80 }
							end,
							disabled = function() return not addon.db.profile.show_currency end,
						},
					},
				},
				group2 = { -- Display Settings
					order = 20,
					type = "group",
					name = L["Display Settings"],
					inline = true,
					args = {
						show_money = {
							order = 21,
							type = "toggle",
							name = L["Show money info"],
							desc = L["Enable to show total money together with currencies' info."],
							width = "double",
						},
						showLowerDenominations = {
							order = 22,
							type = "toggle",
							name = L["Show Lower Denominations"],
							desc = L["Enable to show all the lower denominations, disable to only show money in gold."],
							width = "double",
							disabled = function() return not addon.db.profile.show_money end,
						},
						breakupnumbers = {
							order = 23,
							type = "toggle",
							name = L["Breakup numbers"],
							desc = L["Converts a number into a localized string, grouping digits as required."],
							width = "double",
						},
						hide_zero = {
							order = 24,
							type = "toggle",
							name = L["Hide zero"],
							desc = L["Auto-hide items / currencies which have zero amount."],
							width = "double",
						},
						show_iconOnly = {
							order = 25,
							type = "toggle",
							name = L["Show icon only"],
							desc = L["Show only the currency / item's icon, do not show the amounts."],
							width = "double",
						},
						icon_first = {
							order = 26,
							type = "toggle",
							name = L["Icon first"],
							desc = L["Put currency icon prior to its amount"],
							width = "double",
							disabled = function() return addon.db.profile.show_iconOnly end,
						},
						maxItems = {
							order = 27,
							type = "range",
							name = L["Max items per row"],
							desc = L["Set the maximum number of items to be displayed per row. Set to 0 to allow unlimited items on one single row."],
							width = "double",
							min = 0, max = 60, bigStep = 1,
						},
					},
				},
				group3 = { -- Scale and Transparency
					order = 30,
					type = "group",
					name = L["Scale and Transparency"],
					inline = true,
					args = {
						group31 = {
							order = 20,
							type = "group",
							name = L["On-screen frame"],
							inline = true,
							disabled = function() return not addon.db.profile.show_currency end,
							args = {
								scale = {
									order = 21,
									type = "range",
									name = L["Scale"],
									min = 0.5, max = 2, bigStep = 0.1, 
								},
								alpha = {
									order = 22,
									type = "range",
									name = L["Transparency"],
									min = 0, max = 1, bigStep = 0.1, 
								},
--[[
								bgalpha = {
									order = 23,
									type = "range",
									name = L["Background"],
									desc = L["Currencies info's background transparency"],
									min = 0, max = 1, bigStep = 0.1, 
								},
]]
							},
						},
						group32 = {
							order = 30,
							type = "group",
							name = L["Tooltip"],
							inline = true,
							args = {
								tooltip_scale = {
									order = 31,
									type = "range",
									name = L["Scale"],
									min = 0, max = 1.75, bigStep = 0.01, 
								},
								tooltip_alpha = {
									order = 32,
									type = "range",
									name = L["Transparency"],
									min = 0, max = 1, bigStep = 0.1, 
								},
							},
						},
					},
				},
			},
		}
	end
	
	return options
end

-- /////////////////////////////////////////////////////////
-- Currencies
-- /////////////////////////////////////////////////////////
local currenciesOptions = nil
local function currencyButton_ToggleTrack(id)
	profile = addon.db.profile
	if (not profile["currencies"][id]) then 
		profile["currencies"][id] = true
	else
		profile["currencies"][id] = nil
	end
	
	addon:Refresh()
end

local function getCurrenciesOptions()
	if not profile then profile = addon.db.profile end
	local lang = GetLocale()
	if not currenciesOptions then
		currenciesOptions = {
			type = "group",
			name = L["Tracked Currencies"],
			args = { },
		}
		local t = currenciesOptions.args
		local i = 1
		
		--for k,v in orderedpairs(LibCurrencyInfo.data.CurrencyByCategory) do
		for ki,vi in ipairs(addon.constants.currencyCategories) do
			local k = vi
			local v = LibCurrencyInfo.data.CurrencyByCategory[k]
			t["group"..i] = {}
			t["group"..i].order = i
			t["group"..i].type = "group"
			t["group"..i].name = LibCurrencyInfo:GetCurrencyCategoryNameByCategoryID(k, lang)
			t["group"..i].args = { }
			local j = 1
			local tg = t["group"..i].args
			for index, id in ipairs(v) do
				-- name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered, rarity, categoryID, categoryName, currencyDesc = lib:GetCurrencyByID(currencyID)
				local name, count, icon, _, _, totalMax, _, _, _, _, currencyDesc = LibCurrencyInfo:GetCurrencyByID(id)
				if not count then count = 0 end
				if not currencyDesc then 
					currencyDesc = ""
				else
					currencyDesc = currencyDesc.."\n\n"
				end
				
				if icon and name then
					local displayString = format("|T%d:16:16:2:0|t %s%s|r", icon or 0, count > 0 and HIGHLIGHT_FONT_COLOR_CODE or GRAY_FONT_COLOR_CODE, name or "")
					tg["currency"..index] = {}
					tg["currency"..index].order = index
					tg["currency"..index].type = "toggle"
					tg["currency"..index].name = displayString
					if (totalMax and totalMax > 0) then
						tg["currency"..index].desc = NORMAL_FONT_COLOR_CODE..currencyDesc..format(CURRENCY_TOTAL_CAP, HIGHLIGHT_FONT_COLOR_CODE, count, totalMax)
					else
						tg["currency"..index].desc = NORMAL_FONT_COLOR_CODE..currencyDesc..format(CURRENCY_TOTAL, HIGHLIGHT_FONT_COLOR_CODE, count)
					end
					tg["currency"..index].get = (function() return profile["currencies"][id] end)
					tg["currency"..index].set = (function() currencyButton_ToggleTrack(id) end)
				end
				j = j + 1
			end
			i = i + 1
		end
	end
	
	return currenciesOptions
end

-- /////////////////////////////////////////////////////////
-- Items
-- /////////////////////////////////////////////////////////
local itemOptions = nil
local function itemButton_ToggleTrack(itemID)
	if not profile then profile = addon.db.profile end
	if (not profile["items"][itemID]) then 
		profile["items"][itemID] = true 
	else
		profile["items"][itemID] = nil
	end

	addon:Refresh()
end

local function getItemOptions()
	if not profile then profile = addon.db.profile end
	if not item_list then item_list = addon.db.item_list end
	
	local function retrieveItems(tp, itemID, n)
		local itemName, icon, _
	
		if (item_list[itemID] and item_list[itemID][1] and item_list[itemID][2]) then
			itemName, icon = item_list[itemID][1], item_list[itemID][2]
		else
			itemName, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
			if not (itemName) then 
				itemName, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
			end
			if ( itemName and icon ) then
				item_list[itemID] = { itemName, icon, }
			end
		end
		local count = GetItemCount(itemID, true)
		
		if icon and itemName then
			local displayString = format("|T%d:16:16:2:0|t %s%s|r", icon, count > 0 and HIGHLIGHT_FONT_COLOR_CODE or GRAY_FONT_COLOR_CODE, itemName)
			tp["item"..n] = {}
			tp["item"..n].order = n
			tp["item"..n].type = "toggle"
			tp["item"..n].name = displayString
			tp["item"..n].desc = format(NORMAL_FONT_COLOR_CODE..CURRENCY_TOTAL, HIGHLIGHT_FONT_COLOR_CODE, count or 0)
			tp["item"..n].get = (function() return profile["items"][itemID] end)
			tp["item"..n].set = (function() itemButton_ToggleTrack(itemID) end)
		
			n = n + 1
		end
		
		return tp, n
	end
	
	if not itemOptions then
		itemOptions = {
			type = "group",
			name = L["Tracked Items"],
			args = { },
		}
		local i = 1
		for k, v in pairs(addon.items) do
			itemOptions.args["group"..i] = {}
			itemOptions.args["group"..i].order = i
			itemOptions.args["group"..i].type = "group"
			itemOptions.args["group"..i].name = addon.constants.itemCategories[k]
			itemOptions.args["group"..i].args = { }
			local t = itemOptions.args["group"..i].args
			local j = 1
			for ka, va in ipairs(v) do
				if (WoWClassicEra and j > 1) then
					break
				elseif (WoWClassicTBC and j > 2) then 
					break
				elseif (WoWWOTLKC and j > 3) then
					break
				else
					t["group"..j] = {}
					t["group"..j].order = j
					t["group"..j].type = "group"
					t["group"..j].name = addon.constants.expansions[j]
					t["group"..j].inline = true
					t["group"..j].args = { }

					local n = 1
					local tp = t["group"..j].args

					for kb, vb in ipairs(va) do
						if (type(vb) == "number") then
							tp, n = retrieveItems(tp, vb, n)
						end
					end
				end
				j = j + 1
			end
			i = i + 1
		end
	end
	
	return itemOptions
end

local function openOptions(openItems)
	-- open the profiles tab before, so the menu expands
	InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.Profiles)
	InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.Profiles) -- yes, run twice to force the tre get expanded
	if (openItems) then
		InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.Items)
	else
		if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then
			InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.General)
		else
			InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.Currencies)
		end
	end
	InterfaceOptionsFrame:Raise()
end

function addon:OpenOptions(openItems) 
	openOptions(openItems)
end

local function giveProfiles()
	return AceDBOptions:GetOptionsTable(addon.db)
end

function addon:SetupOptions()
	self.optionsFrames = {}

	-- setup options table
	AceConfigReg:RegisterOptionsTable(addon.LocName, getAboutPanel)
	self.optionsFrames.General = AceConfigDialog:AddToBlizOptions(addon.LocName, nil, nil, "general")
	self:RegisterModuleOptions("Options", getOptions, L["Options"])
	self:RegisterModuleOptions("Items", getItemOptions, L["Tracked Items"])
	--addTokenOptionFrame()
	if (WoWRetail) then
		self:RegisterModuleOptions("Currencies", getCurrenciesOptions, L["Tracked Currencies"])
	end
	self:RegisterModuleOptions("Profiles", giveProfiles, L["Profile Options"])
end

-- Description: Function which extends our options table in a modular way
-- Expected result: add a new modular options table to the modularOptions upvalue as well as the Blizzard config
-- Input:
--		name		: index of the options table in our main options table
--		optionsTable	: the sub-table to insert
--		displayName	: the name to display in the config interface for this set of options
-- Output: None.
function addon:RegisterModuleOptions(name, optionTbl, displayName)
	moduleOptions[name] = optionTbl
	self.optionsFrames[name] = AceConfigDialog:AddToBlizOptions(addon.LocName, displayName, addon.LocName, name)
end

