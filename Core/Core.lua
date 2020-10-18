-- $Id$
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs, ipairs, select, unpack, type = _G.pairs, _G.ipairs, _G.select, _G.unpack, _G.type
local string, tonumber = _G.string, _G.tonumber
-- Libraries
local format, strsub, strlen, strgmatch = string.format, string.sub, string.len, string.gmatch
local floor, fmod = math.floor, math.fmod
-- WoW
local GetAddOnInfo, GetAddOnMetadata = _G.GetAddOnInfo, _G.GetAddOnMetadata
local GameTooltip = _G.GameTooltip
local BreakUpLargeNumbers = _G.BreakUpLargeNumbers
local GetCurrencyListSize, GetCurrencyListInfo, GetCurrencyInfo = _G.GetCurrencyListSize, _G.GetCurrencyListInfo, _G.GetCurrencyInfo
local GetItemInfoInstant, GetItemCount, GetItemInfo, GetItemIcon = _G.GetItemInfoInstant, _G.GetItemCount, _G.GetItemInfo, _G.GetItemIcon
local UnitName, GetRealmName = _G.UnitName, _G.GetRealmName
local GetMoney = _G.GetMoney
local GetLocale = _G.GetLocale

local GetBuildInfo = _G.GetBuildInfo

-- Determine WoW TOC Version
local WoWClassic, WoWRetail
local wowtocversion  = select(4, GetBuildInfo())
if wowtocversion < 19999 then
	WoWClassic = true
else
	WoWRetail = true
end

if WoWClassic then
	GetCurrencyListSize, GetCurrencyListInfo, GetCurrencyInfo = _G.GetCurrencyListSize, _G.GetCurrencyListInfo, _G.GetCurrencyInfo
else -- Shadowlands
	GetCurrencyListSize, GetCurrencyListInfo, GetCurrencyInfo = C_CurrencyInfo.GetCurrencyListSize, C_CurrencyInfo.GetCurrencyListInfo, C_CurrencyInfo.GetCurrencyInfo
end
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local LibCurrencyInfo = LibStub:GetLibrary("LibCurrencyInfo")
local AceDB = LibStub("AceDB-3.0")
local LDB_CurrencyTracking = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(private.addon_name, {
	type = "data source",
	text = L["CT_TITLE"],
	label = L["CT_TITLE"],
})

local addon = LibStub("AceAddon-3.0"):NewAddon(private.addon_name, "AceEvent-3.0")
addon.constants = private.constants
addon.constants.addon_name = private.addon_name
addon.Name = FOLDER_NAME
local _
_, addon.LocName, addon.Notes = GetAddOnInfo(addon.Name)
-- ToC Metadata
addon.Version 		= GetAddOnMetadata(addon.Name, "Version")
addon.UpdateDate 	= GetAddOnMetadata(addon.Name, "X-Date")
addon.Author 		= GetAddOnMetadata(addon.Name, "Author")

_G.CurrencyTracking = addon
local profile
local item_list

-- local booleans, constants, and arrays
local isInLockdown = false		-- boolean to check if player is in combat
local isInBattleGround = false		-- boolean to check if player is in battleground
local CT_ORIG_GAMPTOOLTIP_SCALE = GameTooltip:GetScale()	-- to get the original GameTooltip's scaling value
local CT_CURRSTR = nil
local CURRENCIESLIST = {}		-- initialize currency list array
local numCurrencies = 0			-- initialize the number of currencies

-- codes adopted from Accountant_Classic
local function getFormattedValue(amount)
	if (amount and type(amount) == "number") then 
		local gold = floor(amount / (COPPER_PER_SILVER * SILVER_PER_GOLD))
		local goldDisplay = profile.breakupnumbers and BreakUpLargeNumbers(gold) or gold
		local silver = floor((amount - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER)
		local copper = fmod(amount, COPPER_PER_SILVER)
		
		local TMP_GOLD_AMOUNT_TEXTURE, TMP_SILVER_AMOUNT_TEXTURE, TMP_COPPER_AMOUNT_TEXTURE

		if (profile.icon_first) then
			TMP_GOLD_AMOUNT_TEXTURE 	= "|TInterface\\MoneyFrame\\UI-GoldIcon:%d:%d:2:0|t %s"
			TMP_SILVER_AMOUNT_TEXTURE 	= "|TInterface\\MoneyFrame\\UI-SilverIcon:%d:%d:2:0|t %02d"
			TMP_COPPER_AMOUNT_TEXTURE 	= "|TInterface\\MoneyFrame\\UI-CopperIcon:%d:%d:2:0|t %02d"

			if (profile.showLowerDenominations) then
				if (gold >0) then
					return format("|cffffffff"..TMP_GOLD_AMOUNT_TEXTURE.." "..TMP_SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE.."|r", 0, 0, goldDisplay, 0, 0, silver, 0, 0, copper)
				elseif (silver >0) then 
					return format("|cffffffff"..TMP_SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE.."|r", 0, 0, silver, 0, 0, copper)
				elseif (copper >0) then
					return format("|cffffffff"..TMP_COPPER_AMOUNT_TEXTURE.."|r", 0, 0, copper)
				else
					return ""
				end
			else
				return format("|cffffffff"..TMP_GOLD_AMOUNT_TEXTURE.."|r", 0, 0, goldDisplay)
			end
		else
			TMP_GOLD_AMOUNT_TEXTURE 	= "%s|TInterface\\MoneyFrame\\UI-GoldIcon:%d:%d:2:0|t"
			TMP_SILVER_AMOUNT_TEXTURE 	= "%02d|TInterface\\MoneyFrame\\UI-SilverIcon:%d:%d:2:0|t"
			TMP_COPPER_AMOUNT_TEXTURE 	= "%02d|TInterface\\MoneyFrame\\UI-CopperIcon:%d:%d:2:0|t"

			if (profile.showLowerDenominations) then
				if (gold >0) then
					return format(" |cffffffff"..TMP_GOLD_AMOUNT_TEXTURE.." "..TMP_SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE.."|r", goldDisplay, 0, 0, silver, 0, 0, copper, 0, 0)
				elseif (silver >0) then 
					return format(" |cffffffff"..SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE.."|r", silver, 0, 0, copper, 0, 0)
				elseif (copper >0) then
					return format(" |cffffffff"..COPPER_AMOUNT_TEXTURE.."|r", copper, 0, 0)
				else
					return ""
				end
			else
				return format(" |cffffffff"..TMP_GOLD_AMOUNT_TEXTURE.."|r", goldDisplay, 0, 0)
			end
		end
	end
end

-- Codes adopted from TitanPanel
local function addTooltipText(text)
	if ( text ) then
		-- Append a "\n" to the end 
		if ( strsub(text, -1, -1) ~= "\n" ) then
			text = text.."\n"
		end
		
		-- See if the string is intended for a double column
		for text1, text2 in strgmatch(text, "([^\t\n]*)\t?([^\t\n]*)\n") do
			if ( text2 ~= "" ) then
				-- Add as double wide
				GameTooltip:AddDoubleLine(text1, text2)
			elseif ( text1 ~= "" ) then
				-- Add single column line
				GameTooltip:AddLine(text1)
			else
				-- Assume a blank line
				GameTooltip:AddLine("\n")
			end			
		end
	end
end

-- Codes adopted from TitanCurrency and revised by arith
local function getTooltipText()
	local display = ""
	local tooltip = ""
	local cCount
	cCount = GetCurrencyListSize()
	for i = 1, cCount do 
		-- // GetCurrencyListInfo() syntax:
		-- // name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo(index)
		local name, isHeader, isUnused, count, icon, _
		if WoWClassic then
			name, isHeader, _, isUnused, _, count, icon = GetCurrencyListInfo(i)
		else
			local curr = GetCurrencyListInfo(i)
			name = curr.name
			isHeader = curr.isHeader
			isUnused = curr.isTypeUnused
			count = curr.quantity
			icon = curr.iconFileID
		end
		if ( isHeader ) then
			tooltip = tooltip..name.."\n"
		elseif ( (count >= 0) and not isUnused ) then
			if (icon ~= nil) then
				local icount = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
				if (count == 0) then
					if (not profile.hide_zero) then
						display = " - "..name.."\t|cffff0000"..icount.." |r|T"..icon..":16|t"
					end
				else
					display = " - "..name.."\t|cffffffff"..icount.." |r|T"..icon..":16|t"
				end
			end
			-- trace(display)
			tooltip = strconcat(tooltip, display, "|r\n")
		end
	end 
	return tooltip    
end

local function button_OnMouseDown(self, buttonName)    
	-- Prevent activation when in combat or when lock is set to true
	if (isInLockdown or profile.always_lock) then
		return
	end
	if(addon.frame:IsVisible()) then
		-- Handle left button clicks
		if (buttonName == "LeftButton") then
			-- Hide tooltip while draging
			GameTooltip:Hide()
			addon.frame:StartMoving()
		elseif (buttonName == "RightButton") then
			addon:OpenOptions(self.isItem)
			GameTooltip_Hide()
		end
	end
end

local function button_OnMouseUp(self, buttonName)
	if (isInLockdown or profile.always_lock) then
		return
	end
	if(addon.frame:IsVisible()) then
		addon.frame:StopMovingOrSizing()
		local point, relativeTo, relativePoint, xOfs, yOfs = addon.frame:GetPoint()
		profile.point = { point, relativeTo, relativePoint, xOfs, yOfs }
	end
end

local function button_OnEnter(self)
	if (isInLockdown) then
		return
	end
	
	if(addon.frame:IsVisible()) then
		if (not GameTooltip:IsShown()) then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", -10, 0)
			GameTooltip:SetBackdropColor(0, 0, 0, profile.tooltip_alpha)
			GameTooltip:SetText("|cFFFFFFFF"..L["CT_TITLE"], 1, 1, 1, nil, 1)
			local tooltip = getTooltipText()
			if (tooltip) then
				addTooltipText(tooltip)
			end
			GameTooltip:SetScale(profile.tooltip_scale)
			GameTooltip:Show()
		else
			GameTooltip:Hide()
		end
	end
end

local function button_OnLeave(self)
	GameTooltip_Hide()
	GameTooltip:SetScale(CT_ORIG_GAMPTOOLTIP_SCALE)
end

local function handleTrackedButtons(button, currencyID, itemID)
	item_list = addon.db.item_list
	if not button then return end
	local buttonName = button:GetName()
	local bi = tonumber(strsub(buttonName, strlen("CurrencyTrackingButton")+1))
	local maxItems = profile.maxItems or 0
	local nRow, nRowItem
	local rowHeight = 20
	
	if (maxItems == 0) then 
		nRow = 1
	else
		nRow = ( (bi - (bi % maxItems) ) / maxItems ) + 1
		nRowItem = bi % maxItems
		if nRowItem == 0 then nRowItem = maxItems end
	end
	
	local itemName, itemLink, count, icon, _
	local width = 15
	if (currencyID) then 
		if WoWClassic then
			_, count, icon = GetCurrencyInfo(currencyID) 
		else
			local curr = GetCurrencyInfo(currencyID)
			count = curr.quantity
			icon = curr.iconFileID
		end
	elseif (itemID) then
		if (item_list[itemID] and item_list[itemID][1] and item_list[itemID][2] and item_list[itemID][3]) then
			itemName, icon, itemLink = item_list[itemID][1], item_list[itemID][2], item_list[itemID][3]
		else
			itemName, itemLink, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
			if not itemName then itemName, itemLink, _, _, _, _, _, _, _, icon = GetItemInfo(itemID) end
			local t = {}
			t.itemID = itemID
			t.itemName = itemName
			t.itemLink = itemLink
			addon.Query.RefreshItem(t)
		end
		count = GetItemCount(itemID, true)
	end

	if (currencyID or itemID) then
		button.icon:SetTexture(icon or 0)
		if (profile.show_iconOnly) then
			button.count:Hide()
		else
			if (count and count == 0) then 
				button.count:SetText("|cffff0000"..count.."|r")
			elseif (count and count > 0) then
				count = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
				button.count:SetText(count)
			else
				button.count:SetText("")
			end
			button.count:Show()
			width = button.count:GetStringWidth() + 10

			if (profile.icon_first) then
				button.icon:SetPoint("LEFT", 0, 0)
				if (not profile.show_iconOnly) then
					button.count:SetPoint("LEFT", button.icon, "RIGHT", 2, 0)
				end
			else
				if (profile.show_iconOnly) then
					button.icon:SetPoint("LEFT", 0, 0)
				else
					button.count:SetPoint("LEFT", 0, 0)
					button.icon:SetPoint("LEFT", button.count, "RIGHT", 2, 0)
				end
			end
		end
	else -- money
		button.icon:SetTexture(nil)
		button.count:SetText(getFormattedValue(GetMoney()))
		width = button.count:GetStringWidth()
	end
	
	button:SetWidth(width)
	if (bi == 1) then
		button:SetPoint("TOPLEFT", 0, 0)
	else
		if (nRow == 1) then
			button:SetPoint("TOPLEFT", _G["CurrencyTrackingButton"..bi-1], "TOPRIGHT", profile.show_iconOnly and 5 or 15, 0)
		else
			if (nRowItem == 1) then
				button:SetPoint("TOPLEFT", _G["CurrencyTrackingButton"..bi-maxItems], "TOPLEFT", 0, -rowHeight)
			else
				button:SetPoint("TOPLEFT", _G["CurrencyTrackingButton"..bi-1], "TOPRIGHT", profile.show_iconOnly and 5 or 15, 0)
			end
		end
	end
	button:SetScript("OnMouseDown", button_OnMouseDown)
	button:SetScript("OnMouseUp", button_OnMouseUp)
	if (currencyID and profile.show_tooltip) then
		button:SetScript("OnEnter", button_OnEnter)
	else
		button:SetScript("OnEnter", nil)
	end
	button:SetScript("OnLeave", button_OnLeave)
	button.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	button.highlight:SetWidth(width)
	button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
	button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
	button.isCurrency = currencyID and true or nil
	button.currencyID = currencyID or nil
	button.isMoney = (not currencyID and not itemID) and true or nil
	button.isItem = itemID and true or nil
	button.itemID = itemID or nil
	button.itemName = itemID and itemName or nil
	button.itemLink = itemLink or nil
	if (button.isItem) then
		button.LinkButton.tooltipText = itemLink or nil
	else
		button.LinkButton.tooltipText = currencyID and LibCurrencyInfo:GetCurrencyTokenStrings(currencyID) or nil
	end
	if (currencyID or itemID) then
		button.LinkButton:Show()
	else
		button.LinkButton:Hide()
	end
	button:Show()

end

local function currencyButton_Update()
	local nf = _G["CurrencyTrackingFrame"]
	local button
	local gwidth = 0
	local bi = 1

	-- tracked currencies
	for currencyID, v in pairs(profile["currencies"]) do
		if (currencyID and type(currencyID) == "number" and profile["currencies"][currencyID] == true) then
			local _, count
			if WoWClassic then
				_, count = GetCurrencyInfo(currencyID)
			else
				local curr = GetCurrencyInfo(currencyID)
				count = curr.quantity
			end

			if (count >= 0) then
				if (profile.hide_zero and count == 0) then
					-- do nothing
				else
					button = _G["CurrencyTrackingButton"..bi]
					if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
					handleTrackedButtons(button, currencyID)
					gwidth = gwidth + button:GetWidth()
					bi = bi + 1
				end
			end
		end
	end
	-- tracked items
	for itemID, v in pairs(profile["items"]) do
		if (itemID and profile["items"][itemID] == true) then
			local count = GetItemCount(itemID, true)
			if (profile.hide_zero and count == 0) then
				-- do nothing
			else
				button = _G["CurrencyTrackingButton"..bi]
				if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
				handleTrackedButtons(button, nil, itemID)
				gwidth = gwidth + button:GetWidth()
				bi = bi + 1
			end
		end
	end
	-- handle money
	if (profile.show_money) then
		button = _G["CurrencyTrackingButton"..bi]
		if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
		handleTrackedButtons(button)
		gwidth = gwidth + button:GetWidth()
		bi = bi + 1
	end

	nf:SetWidth(gwidth)

	button = _G["CurrencyTrackingButton"..bi]
	while button do
		button.icon:SetTexture(nil)
		button.count:SetText(nil)
		if (profile.show_iconOnly) then
			button.count:Hide()
		else
			button.count:Show()
		end
		button:SetWidth(0)
		button.isCurrency = nil
		button.isMoney = nil
		button.isItem = nil
		button.itemID = nil
		button.currencyID = nil
		button.itemName = nil
		button.itemLink = nil
		button.LinkButton.tooltipText = nil
		button.LinkButton:Hide()
		button:Hide()
		bi = bi + 1
		button = _G["CurrencyTrackingButton"..bi]
	end
end

local function currencyString_Update()
	local currencystr = ""

	local CT_CURRENCY_TEXTURE

	-- tracked currencies
	for currencyID, v in pairs(profile["currencies"]) do
		if (currencyID and type(currencyID) == "number" and profile["currencies"][currencyID] == true) then
			local _, count, icon
			if WoWClassic then
				_, count, icon = GetCurrencyInfo(currencyID)
			else
				local curr = GetCurrencyInfo(currencyID)
				count = curr.quantity
				icon = curr.iconFileID
			end
			if not icon then icon = 0 end -- somehow Legionfall War Supplies' icon is not available in 7.2.5.23959, this should temporary resolve the blocking issue
			
			if (count >= 0) then
				if (profile.hide_zero and count == 0) then
					-- do nothing
				else
					if (count == 0) then 
						if (profile.icon_first) then
							CT_CURRENCY_TEXTURE = "|T"..icon..":%d:%d:2:0|t "..RED_FONT_COLOR_CODE.."%s "..FONT_COLOR_CODE_CLOSE
						else
							CT_CURRENCY_TEXTURE = RED_FONT_COLOR_CODE.." %s"..FONT_COLOR_CODE_CLOSE.."|T"..icon..":%d:%d:2:0|t "
						end
					else
						if (profile.icon_first) then
							CT_CURRENCY_TEXTURE = "|T"..icon..":%d:%d:2:0|t "..HIGHLIGHT_FONT_COLOR_CODE.."%s "..FONT_COLOR_CODE_CLOSE
						else
							CT_CURRENCY_TEXTURE = HIGHLIGHT_FONT_COLOR_CODE.." %s"..FONT_COLOR_CODE_CLOSE.."|T"..icon..":%d:%d:2:0|t "
						end
					end
					count = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
					if (profile.icon_first) then
						currencystr = currencystr..format(CT_CURRENCY_TEXTURE, 0, 0, count)
					else
						currencystr = currencystr..format(CT_CURRENCY_TEXTURE, count, 0, 0)
					end
				end
			end
		end
	end
	-- tracked items
	for itemID, v in pairs(profile["items"]) do
		if (itemID and profile["items"][itemID] == true) then
			local count = GetItemCount(itemID, true)
			--local icon = select(10, GetItemInfo(itemID))
			local icon = GetItemIcon(itemID)

			if (profile.hide_zero and count == 0) then
				-- do nothing
			else
				local displayString
				if (profile.icon_first) then
					displayString = format("|T%d:%d:%d:2:0|t |cffffffff%d|r", icon, 16, 16, count)
				else
					displayString = format("|cffffffff%d|r|T%d:%d:%d:2:0|t ", count, icon, 16, 16)
				end
				
				currencystr = currencystr..displayString
			end
		end
	end
	-- return could be nil if no any currency being tracked
	return currencystr
end

local function getButtonText()
	local currencystr = currencyString_Update()

	if (currencystr) then 
		if (profile.show_money) then
			currencystr = currencystr..getFormattedValue(GetMoney())
		end
	else
		if (profile.show_money) then
			currencystr = getFormattedValue(GetMoney())
		else
			currencystr = L["CT_TITLE"]
		end
	end
	
	return currencystr
end

local function currencyUpdate()
	if (profile.show_currency) then currencyButton_Update() end

	local currencystr = getButtonText()
	if (currencystr ~= CT_CURRSTR) then
		LDB_CurrencyTracking.text = currencystr
		CT_CURRSTR = currencystr
	end
end

local function createCurrencyFrame()
	local f = CreateFrame("Frame")
	
	local nf = _G["CurrencyTrackingFrame"]
	if not nf then nf = CreateFrame("Frame", "CurrencyTrackingFrame") end
	nf:SetParent("UIParent")
	nf:SetWidth(200)
	nf:SetHeight(20)
	nf.Texture = nf:CreateTexture(nil, "BACKGROUND")
	local point, relativeTo, relativePoint, ofsx, ofsy = unpack(profile.point)
	nf:SetPoint(point or "TOPLEFT", "UIParent", relativePoint or "TOPLEFT", ofsx or 150, ofsy or -80)
	--nf:SetClampedToScreen(true)
	nf:SetMovable(true)
	nf:EnableMouse(true)
	
	return nf
end

local function setupLDB()
	-- LDB object setting up
	LDB_CurrencyTracking.icon = addon.constants.ldb_icon
	LDB_CurrencyTracking.OnClick = (function(self, button)
		if button == "LeftButton" then
			addon:OpenOptions()
		elseif button == "RightButton" then
		end
	end)

	LDB_CurrencyTracking.OnTooltipShow = (function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		local tooltiptxt = getTooltipText()
		GameTooltip:SetBackdropColor(0, 0, 0, profile.tooltip_alpha)
		GameTooltip:SetText(L["CT_TITLE"], 1, 1, 1, nil, 1)
		if (tooltiptxt) then
			addTooltipText(tooltiptxt)
		end
		GameTooltip:SetScale(profile.tooltip_scale)
	end)
	
	LDB_CurrencyTracking.text = getButtonText()
end

local function frameRefresh()
	if( profile.show_currency == true) then
		addon.frame:Show()
		addon.frame:SetAlpha(profile.alpha)
		--addon.frame.Texture:SetColorTexture(0, 0, 0, profile.bgalpha)
		addon.frame:SetScale(profile.scale)
		--addon.frame:SetBackdropBorderColor(0, 1.0, 0, 1)
		--addon.frame:SetBackdropColor(0, 0, 1.0, 1)
		local bi = 1
		local button
		button = _G["CurrencyTrackingButton"..bi]
		while button and button:IsVisible() and button.icon:GetTexture() do
			if (profile.icon_first) then
				button.icon:SetPoint("LEFT", 0, 0)
				if (not profile.show_iconOnly) then
					button.count:SetPoint("LEFT", button.icon, "RIGHT", 2, 0)
				end
			else
				if (profile.show_iconOnly) then
					button.icon:SetPoint("LEFT", 0, 0)
				else
					button.count:SetPoint("LEFT", 0, 0)
					button.icon:SetPoint("LEFT", button.count, "RIGHT", 2, 0)
				end
			end
			bi = bi + 1
			button = _G["CurrencyTrackingButton"..bi]
		end
	else
		addon.frame:Hide()
	end
end

local function getNumberOfCurrencies()
	local n = 0
	for k,v in pairs(LibCurrencyInfo.data.CurrencyByCategory) do
		n = n + 1 + #v
	end
	
	return n
end

local function populateCurrencyList()
	if not CURRENCIESLIST then CURRENCIESLIST = {} end
	-- CURRENCIESLIST table structure
	--CURRENCIESLIST = {
	--	[1] = { isHeader = true, headerKey = "MISC" },
	--	[2] = { id = 42 },
	--	....
	--}

	local i = 1
	local lang = GetLocale()
	for k,v in pairs(LibCurrencyInfo.data.CurrencyByCategory) do
		CURRENCIESLIST[i] = { isHeader = true, headerKey = k }
		i = i + 1
		for ka,id in ipairs(v) do
			CURRENCIESLIST[i] = { id = id }
			i = i + 1
		end
	end
end

function addon:OnInitialize()
	self.db = AceDB:New(addon.Name.."DB", addon.constants.defaults)
	profile = self.db.profile
	item_list = self.db.item_list

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	self:SetupOptions()
	self.frame = createCurrencyFrame()
	numCurrencies = getNumberOfCurrencies()
	populateCurrencyList()
end

function addon:OnEnable()
	for key, value in pairs( addon.constants.events ) do
		self:RegisterEvent( value )
	end

	setupLDB()
	self.Query.ScanItems() -- pre-scan items so that they will properly showed in option panel
	currencyUpdate()
	self:Refresh()
end

function addon:Refresh()
	profile = self.db.profile
	currencyUpdate()
	frameRefresh()
end

-- ///////////////////////////////////////////////////
-- Event handling
-- ///////////////////////////////////////////////////
local function hideFrame(key)
	if (profile.show_currency and profile[key]) then
		local nf = _G["CurrencyTrackingFrame"]
		nf:Hide()
	end
end

-- ///////////////////////////////////////////////////
-- Combat
-- Event fired whenever you enter combat
function addon:PLAYER_REGEN_DISABLED()
	isInLockdown = true
	hideFrame("hide_in_combat")
end

-- Event fired after ending combat
function addon:PLAYER_REGEN_ENABLED()
	isInLockdown = false
	
	local nf = _G["CurrencyTrackingFrame"]
	if (profile.show_currency and not nf:IsShown()) then
		if (isInBattleGround and profile.hide_in_battleground) then
			-- if player is in battleground and also set to auto-hide frame untile leave battle ground, 
			-- then we should not show the frame after player ending combat, so do nothing here!
		else
			nf:Show()
		end
	end
end

-- ///////////////////////////////////////////////////
-- Battleground
-- Event fired when the battlegrounds signup window is opened.
function addon:BATTLEFIELDS_SHOW()
	isInBattleGround = true
	hideFrame("hide_in_battleground")
end

-- Event fired when the battlegrounds signup window is closed.
function addon:BATTLEFIELDS_CLOSED()
	isInBattleGround = false
	
	local nf = _G["CurrencyTrackingFrame"]
	if (profile.show_currency and not nf:IsShown()) then
		nf:Show()
	end
end

-- ///////////////////////////////////////////////////
-- Pet battle
function addon:PET_BATTLE_OPENING_START()
	hideFrame("hide_in_petbattle")
end

function addon:PET_BATTLE_CLOSE()
	local nf = _G["CurrencyTrackingFrame"]
	if (profile.show_currency and not nf:IsShown()) then
		if (isInBattleGround and profile.hide_in_battleground) then
			-- if player is in battleground and also set to auto-hide frame untile leave battle ground, 
			-- then we should not show the frame right after pet battle ends, so do nothing here!
		else
			nf:Show()
		end
	end
end

-- Fired when a bags inventory changes.
function addon:BAG_UPDATE()
	currencyUpdate()
end

function addon:TRADE_CURRENCY_CHANGED()
	currencyUpdate()
end

-- This event fires whenever the data for an artifact has been updated, such as after completing a new one. 
function addon:ARTIFACT_UPDATE()
	currencyUpdate()
end

-- Event fired when gaining artifact power for the current equipped artifact weapon.
function addon:ARTIFACT_XP_UPDATE()
	currencyUpdate()
end

-- Fired when an item in the target's trade window is changed (items added or removed from trade).
function addon:TRADE_PLAYER_ITEM_CHANGED()
	currencyUpdate()
end

function addon:PLAYER_TRADE_CURRENCY()
	currencyUpdate()
end

-- Fires when you gain currency other than money (for example Chef's Awards or Champion's Seals). 
function addon:CHAT_MSG_CURRENCY()
	currencyUpdate()
end

function addon:SHIPMENT_CRAFTER_REAGENT_UPDATE()
	currencyUpdate()
end

-- Fired every time the UI need to draw the currencies list. 
function addon:CURRENCY_DISPLAY_UPDATE()
	currencyUpdate()
end

function addon:PLAYER_MONEY()
	currencyUpdate()
end
function addon:PLAYER_TRADE_MONEY()
	currencyUpdate()
end
function addon:TRADE_MONEY_CHANGED()
	currencyUpdate()
end
function addon:SEND_MAIL_MONEY_CHANGED()
	currencyUpdate()
end
function addon:SEND_MAIL_COD_CHANGED()
	currencyUpdate()
end
function addon:TRIAL_STATUS_UPDATE()
	currencyUpdate()
end
function addon:CHAT_MSG_MONEY()
	currencyUpdate()
end
