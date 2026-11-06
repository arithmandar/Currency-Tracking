-----------------------------------------------------------------------
-- Click-to-track: toggle item tracking with a modifier + mouse click on
-- items in bags, bank / warband bank, guild bank, loot, merchant, chat
-- links, and on the item buttons of the on-screen tracking bar.
-----------------------------------------------------------------------
local _, private = ...

local _G = getfenv(0)
local pairs, ipairs, type, tonumber = _G.pairs, _G.ipairs, _G.type, _G.tonumber
local string = _G.string
local format, match = string.format, string.match
local hooksecurefunc = _G.hooksecurefunc
local GetTime = _G.GetTime
local GetMouseButtonClicked = _G.GetMouseButtonClicked
local IsAltKeyDown, IsControlKeyDown, IsShiftKeyDown = _G.IsAltKeyDown, _G.IsControlKeyDown, _G.IsShiftKeyDown
local C_Item = _G.C_Item
local GetItemInfo = C_Item.GetItemInfo
local GetItemInfoInstant = C_Item.GetItemInfoInstant or _G.GetItemInfoInstant
local RequestLoadItemDataByID = C_Item.RequestLoadItemDataByID

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

-- ---------------------------------------------------------------------
-- Predefined item lookup (items shipped in Data\Items-*.lua)
-- ---------------------------------------------------------------------
local predefined

local function buildPredefined()
	predefined = {}
	for _, category in pairs(addon.items or {}) do
		for _, expansionItems in ipairs(category) do
			for _, itemID in ipairs(expansionItems) do
				if type(itemID) == "number" then
					predefined[itemID] = true
				end
			end
		end
	end
end

function addon:IsPredefinedItem(itemID)
	if not predefined then buildPredefined() end
	return predefined[itemID] and true or false
end

-- Returns a sorted list of item IDs which belong to the "Custom Items" list:
-- items added by click / ID, plus any tracked item not in the predefined lists.
function addon:GetCustomItemIDs()
	local profile = self.db.profile
	local seen, list = {}, {}
	for itemID in pairs(profile.customItems or {}) do
		if type(itemID) == "number" and not seen[itemID] then
			seen[itemID] = true
			list[#list + 1] = itemID
		end
	end
	for itemID, tracked in pairs(profile.items or {}) do
		if tracked and type(itemID) == "number" and not seen[itemID] and not self:IsPredefinedItem(itemID) then
			seen[itemID] = true
			-- remember it, so it stays in the list after being unchecked
			profile.customItems = profile.customItems or {}
			profile.customItems[itemID] = true
			list[#list + 1] = itemID
		end
	end
	table.sort(list)
	return list
end

-- Accepts an item ID, an item link, an "item:12345" string or a Wowhead URL.
function addon:ParseItemID(value)
	if type(value) == "number" then return value end
	if type(value) ~= "string" or value == "" then return nil end
	local id = tonumber(value) or tonumber(match(value, "item[:=](%d+)"))
	if not id and GetItemInfoInstant then
		id = GetItemInfoInstant(value)
	end
	return id
end

-- ---------------------------------------------------------------------
-- Modifier combination
-- ---------------------------------------------------------------------
local MODIFIER_TEXT = {
	ALT = _G.ALT_KEY_TEXT or "Alt",
	CTRL = _G.CTRL_KEY_TEXT or "Ctrl",
	ALTCTRL = format("%s+%s", _G.ALT_KEY_TEXT or "Alt", _G.CTRL_KEY_TEXT or "Ctrl"),
}

local function isExactModifier(want)
	local alt, ctrl, shift = IsAltKeyDown(), IsControlKeyDown(), IsShiftKeyDown()
	if shift then return false end -- Shift is reserved for chat links / stack split
	if want == "ALT" then return alt and not ctrl end
	if want == "CTRL" then return ctrl and not alt end
	if want == "ALTCTRL" then return alt and ctrl end
	return false
end

function addon:IsClickTrackEnabled()
	return self.db and (self.db.profile.clickTrackModifier or "ALT") ~= "NONE"
end

-- button: "LeftButton" / "RightButton"; defaults to the button of the current click
function addon:IsClickTrackCombo(button)
	if not self:IsClickTrackEnabled() then return false end
	local profile = self.db.profile
	button = button or (GetMouseButtonClicked and GetMouseButtonClicked())
	if button ~= (profile.clickTrackButton or "RightButton") then return false end
	return isExactModifier(profile.clickTrackModifier or "ALT")
end

-- e.g. "Alt+Right-click"
function addon:GetClickTrackComboText()
	local profile = self.db.profile
	local mod = MODIFIER_TEXT[profile.clickTrackModifier or "ALT"]
	if not mod then return nil end
	local btn = (profile.clickTrackButton == "LeftButton") and L["Left-click"] or L["Right-click"]
	return format("%s+%s", mod, btn)
end

-- ---------------------------------------------------------------------
-- Tracking API
-- ---------------------------------------------------------------------
local function notify(itemID, tracked)
	local _, link = GetItemInfo(itemID)
	local text = format(tracked and L["%s is now tracked."] or L["%s is no longer tracked."], link or ("item:" .. itemID))
	print(format("|cff33ff99%s|r: %s", addon.LocName or "Currency Tracking", text))
end

local function changed()
	if addon.InvalidateItemOptions then addon:InvalidateItemOptions() end
	addon:Refresh()
end

function addon:SetItemTracked(itemID, tracked, silent)
	if not itemID then return end
	local profile = self.db.profile
	profile.items = profile.items or {}
	profile.customItems = profile.customItems or {}

	if tracked then
		profile.items[itemID] = true
		if not self:IsPredefinedItem(itemID) then
			profile.customItems[itemID] = true
		end
		if RequestLoadItemDataByID and not GetItemInfo(itemID) then
			RequestLoadItemDataByID(itemID)
		end
	else
		profile.items[itemID] = nil
	end
	changed()
	if not silent then notify(itemID, tracked) end
end

local lastToggleID, lastToggleTime = nil, 0
function addon:ToggleItemTracking(itemID, silent)
	if not itemID then return end
	-- Guard against a single click reaching us twice through different code paths
	local now = GetTime()
	if lastToggleID == itemID and (now - lastToggleTime) < 0.25 then return end
	lastToggleID, lastToggleTime = itemID, now

	self:SetItemTracked(itemID, not self.db.profile.items[itemID], silent)
end

-- Remove an item from the Custom Items list entirely (also stops tracking it)
function addon:RemoveCustomItem(itemID)
	if not itemID then return end
	local profile = self.db.profile
	if profile.customItems then profile.customItems[itemID] = nil end
	if not self:IsPredefinedItem(itemID) and profile.items then
		profile.items[itemID] = nil
	end
	changed()
end

-- ---------------------------------------------------------------------
-- Guild bank exclusion
-- ---------------------------------------------------------------------
-- Right-clicking a guild bank slot withdraws the item (also with a modifier
-- held), so click-to-track is disabled there to avoid accidental withdrawals.
local function isInGuildBank(frame)
	local guildBank = _G.GuildBankFrame -- load-on-demand (Blizzard_GuildBankUI)
	if not guildBank or not frame then return false end
	local depth = 0
	while frame and depth < 15 do
		if frame == guildBank then return true end
		frame = frame.GetParent and frame:GetParent()
		depth = depth + 1
	end
	return false
end

local function getMouseFocus()
	if _G.GetMouseFoci then
		local foci = _G.GetMouseFoci()
		return foci and foci[1]
	end
	return _G.GetMouseFocus and _G.GetMouseFocus()
end

-- ---------------------------------------------------------------------
-- Hook: bag / bank / loot / merchant / chat item clicks
-- ---------------------------------------------------------------------
-- Post-hook only, so Blizzard's own handling is never blocked or tainted.
hooksecurefunc("HandleModifiedItemClick", function(link)
	if not link or not addon.db then return end
	if not addon:IsClickTrackCombo() then return end
	if isInGuildBank(getMouseFocus()) then return end
	-- Only items; currencies / battle pets etc. are ignored
	if type(link) ~= "string" or not match(link, "|Hitem:") and not match(link, "^item:") then return end
	local itemID = GetItemInfoInstant(link)
	if itemID then
		addon:ToggleItemTracking(itemID)
	end
end)

-- ---------------------------------------------------------------------
-- Tooltip hint
-- ---------------------------------------------------------------------
local function addHint(tooltip, itemID)
	if not itemID or not addon.db then return end
	local profile = addon.db.profile
	if not profile.show_clickTrackHint or not addon:IsClickTrackEnabled() then return end
	if isInGuildBank(tooltip.GetOwner and tooltip:GetOwner()) then return end
	local combo = addon:GetClickTrackComboText()
	if not combo then return end
	local text = profile.items[itemID] and L["%s: stop tracking"] or L["%s: start tracking"]
	tooltip:AddLine(format(text, combo), 0.2, 1, 0.6)
	tooltip:Show()
end

if _G.TooltipDataProcessor and _G.Enum and _G.Enum.TooltipDataType and _G.Enum.TooltipDataType.Item then
	_G.TooltipDataProcessor.AddTooltipPostCall(_G.Enum.TooltipDataType.Item, function(tooltip, data)
		if tooltip ~= _G.GameTooltip or not data then return end
		addHint(tooltip, data.id)
	end)
elseif _G.GameTooltip and _G.GameTooltip.HookScript then
	_G.GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
		local _, link = tooltip:GetItem()
		if link then addHint(tooltip, (GetItemInfoInstant(link))) end
	end)
end
