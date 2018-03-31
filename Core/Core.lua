-- $Id$
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs, ipairs, select, unpack, type = _G.pairs, _G.ipairs, _G.select, _G.unpack, _G.type
local string, tonumber = _G.string, _G.tonumber
-- Libraries
local GameTooltip = _G.GameTooltip
local BreakUpLargeNumbers = _G.BreakUpLargeNumbers
local GetItemInfoInstant, GetItemCount, GetItemInfo = _G.GetItemInfoInstant, _G.GetItemCount, _G.GetItemInfo
local format, strsub, strlen, strgmatch = string.format, string.sub, string.len, string.gmatch
local floor, fmod = math.floor, math.fmod
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
	icon = "Interface\\Icons\\timelesscoin",
})

local addon = LibStub("AceAddon-3.0"):NewAddon(private.addon_name, "AceEvent-3.0")
addon.constants = private.constants
addon.constants.addon_name = private.addon_name
addon.Name = FOLDER_NAME
addon.LocName = select(2, GetAddOnInfo(addon.Name))
addon.Notes = select(3, GetAddOnInfo(addon.Name))
_G.CurrencyTracking = addon
local profile

local isInLockdown = false
local isInBattleGround = false
local CT_ORIG_GAMPTOOLTIP_SCALE = GameTooltip:GetScale()
local CT_CURRSTR = nil
local CURRENCIESLIST = {}
local numCurrencies = 0

-- codes adopted from Accountant_Classic
local function getFormattedValue(amount)
	local gold = floor(amount / (COPPER_PER_SILVER * SILVER_PER_GOLD))
	local goldDisplay = profile.breakupnumbers and BreakUpLargeNumbers(gold) or gold
	local silver = floor((amount - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER)
	local copper = fmod(amount, COPPER_PER_SILVER)
	
	local TMP_GOLD_AMOUNT_TEXTURE
	local TMP_SILVER_AMOUNT_TEXTURE
	local TMP_COPPER_AMOUNT_TEXTURE

	if (profile.icon_first) then
		TMP_GOLD_AMOUNT_TEXTURE 	= "|TInterface\\MoneyFrame\\UI-GoldIcon:%d:%d:2:0|t %s"
		TMP_SILVER_AMOUNT_TEXTURE 	= "|TInterface\\MoneyFrame\\UI-SilverIcon:%d:%d:2:0|t %02d"
		TMP_COPPER_AMOUNT_TEXTURE 	= "|TInterface\\MoneyFrame\\UI-CopperIcon:%d:%d:2:0|t %02d"
	else
		TMP_GOLD_AMOUNT_TEXTURE 	= "%s|TInterface\\MoneyFrame\\UI-GoldIcon:%d:%d:2:0|t"
		TMP_SILVER_AMOUNT_TEXTURE 	= "%02d|TInterface\\MoneyFrame\\UI-SilverIcon:%d:%d:2:0|t"
		TMP_COPPER_AMOUNT_TEXTURE 	= "%02d|TInterface\\MoneyFrame\\UI-CopperIcon:%d:%d:2:0|t"
	end

	if (profile.icon_first) then
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
		if (gold >0) then
			return format(" |cffffffff"..TMP_GOLD_AMOUNT_TEXTURE.." "..TMP_SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE.."|r", goldDisplay, 0, 0, silver, 0, 0, copper, 0, 0)
		elseif (silver >0) then 
			return format(" |cffffffff"..SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE.."|r", silver, 0, 0, copper, 0, 0)
		elseif (copper >0) then
			return format(" |cffffffff"..COPPER_AMOUNT_TEXTURE.."|r", copper, 0, 0)
		else
			return ""
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
	local name, isHeader, isUnused, count, icount, icon, cCount, _
	cCount = GetCurrencyListSize()
	for i = 1, cCount do 
		-- // GetCurrencyListInfo() syntax:
		-- // name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo(index)
		name, isHeader, _, isUnused, _, count, icon = GetCurrencyListInfo(i)
		if ( isHeader ) then
			tooltip = tooltip..name.."\n"
		elseif ( (count >= 0) and not isUnused ) then
			if (icon ~= nil) then
				icount = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
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
		local a, b, c, d, e = addon.frame:GetPoint()
		profile.point = { a, b, c, d, e }
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
--[[
local function currencyButton_Update()
	local numTokenTypes = GetCurrencyListSize()

	local nf = _G["CurrencyTrackingFrame"]
	local button
	local gwidth = 0
	local bi = 1

	for i=1, numTokenTypes do
		-- // GetCurrencyListInfo() syntax:
		-- // name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo(index);
		local name, isHeader, _, _, _, count, icon = GetCurrencyListInfo(i)
		if not icon then icon = "" end -- somehow Legionfall War Supplies' icon is not available in 7.2.5.23959, this should temporary resolve the blocking issue
		if ((not isHeader) and profile["currencies"][name] == true) then
			if (count >= 0) then
				-- handle the new currency frame
				button = _G["CurrencyTrackingButton"..bi]
				if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
				button.icon:SetTexture(icon)
				if (count == 0) then 
					button.count:SetText("|cffff0000"..count.."|r")
				else
					count = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
					button.count:SetText(count)
				end
				local width = button.count:GetStringWidth()+10
				gwidth = gwidth + width
				button:SetWidth(width)
				button.index = i
				if (profile.icon_first) then
					button.icon:SetPoint("LEFT", 0, 0)
					button.count:SetPoint("LEFT", button.icon, "RIGHT", 2, 0)
				end
				if (bi == 1) then
					button:SetPoint("TOPLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", _G["CurrencyTrackingButton"..bi-1], "TOPRIGHT", 15, 0)
				end
				button:SetScript("OnMouseDown",	button_OnMouseDown)
				button:SetScript("OnMouseUp", 	button_OnMouseUp)
				button:SetScript("OnEnter", 	button_OnEnter)
				button:SetScript("OnLeave", 	button_OnLeave)
				button.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
				button.highlight:SetWidth(width)
				button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
				button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
				button.isCurrency = true
				button.isMoney = false
				button.isItem = false
				button.itemID = nil
				button.itemName = nil
				button.currencyID = nil
				button.LinkButton:Show()
				button:Show()
				bi = bi + 1
			end
		end
	end
	-- archaeology
	for index, id in ipairs(addon.constants.archaeology) do
		-- name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered, rarity = GetCurrencyInfo(id)
		local name, count, icon = GetCurrencyInfo(id)
		if not icon then icon = "" end -- somehow Legionfall War Supplies' icon is not available in 7.2.5.23959, this should temporary resolve the blocking issue
		if (profile["currencies"][name] == true) then
			if (count >= 0) then
				-- handle the new currency frame
				button = _G["CurrencyTrackingButton"..bi]
				if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
				button.icon:SetTexture(icon)
				if (count == 0) then 
					button.count:SetText("|cffff0000"..count.."|r")
				else
					count = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
					button.count:SetText(count)
				end
				local width = button.count:GetStringWidth()+10
				gwidth = gwidth + width
				button:SetWidth(width)
				button.index = nil
				if (profile.icon_first) then
					button.icon:SetPoint("LEFT", 0, 0)
					button.count:SetPoint("LEFT", button.icon, "RIGHT", 2, 0)
				end
				if (bi == 1) then
					button:SetPoint("TOPLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", _G["CurrencyTrackingButton"..bi-1], "TOPRIGHT", 15, 0)
				end
				button:SetScript("OnMouseDown",	button_OnMouseDown)
				button:SetScript("OnMouseUp", 	button_OnMouseUp)
				button:SetScript("OnEnter", 	button_OnEnter)
				button:SetScript("OnLeave", 	button_OnLeave)
				button.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
				button.highlight:SetWidth(width)
				button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
				button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
				button.isCurrency = true
				button.isMoney = false
				button.isItem = false
				button.itemID = nil
				button.currencyID = id
				button.itemName = name
				button.LinkButton:Show()
				button:Show()
				bi = bi + 1
			end
		end
	end
	-- tracked items
	for k, v in pairs(addon.constants.items) do
		if k == "professions" then
			for ka, profs in pairs(v) do
				for kb, itemID in ipairs(profs) do
					if (profile["items"][itemID] == true) then
						button = _G["CurrencyTrackingButton"..bi]
						if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
						
						local name, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
						local count = GetItemCount(itemID, true)
						button.icon:SetTexture(icon or 0)
						if (count and count == 0) then 
							button.count:SetText("|cffff0000"..count.."|r")
						elseif (count and count > 0) then
							count = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
							button.count:SetText(count)
						else
							button.count:SetText("")
						end
						local width = button.count:GetStringWidth()+10
						gwidth = gwidth + width
						button:SetWidth(width)
						if (bi == 1) then
							button:SetPoint("TOPLEFT", 0, 0)
						else
							button:SetPoint("TOPLEFT", _G["CurrencyTrackingButton"..bi-1], "TOPRIGHT", 15, 0)
						end
						button.index = nil
						button:SetScript("OnMouseDown",	button_OnMouseDown)
						button:SetScript("OnMouseUp", 	button_OnMouseUp)
						--button:SetScript("OnEnter", 	button_OnEnter)
						button:SetScript("OnLeave", 	button_OnLeave)
						button.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
						button.highlight:SetWidth(width)
						button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
						button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
						button.isCurrency = false
						button.isMoney = false
						button.isItem = true
						button.itemID = itemID
						button.currencyID = nil
						button.itemName = name or ""
						button.LinkButton:Show()
						button:Show()
						bi = bi + 1
					end
				end
			end
		else
			for ka, itemID in ipairs(v) do
				if (profile["items"][itemID] == true) then
					button = _G["CurrencyTrackingButton"..bi]
					if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
					
					local name, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
					local count = GetItemCount(itemID, true)
					button.icon:SetTexture(icon or 0)
					if (count and count == 0) then 
						button.count:SetText("|cffff0000"..count.."|r")
					elseif (count and count > 0) then
						count = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
						button.count:SetText(count)
					else
						button.count:SetText("")
					end
					local width = button.count:GetStringWidth()+10
					gwidth = gwidth + width
					button:SetWidth(width)
					if (bi == 1) then
						button:SetPoint("TOPLEFT", 0, 0)
					else
						button:SetPoint("TOPLEFT", _G["CurrencyTrackingButton"..bi-1], "TOPRIGHT", 15, 0)
					end
					button.index = nil
					button:SetScript("OnMouseDown",	button_OnMouseDown)
					button:SetScript("OnMouseUp", 	button_OnMouseUp)
					--button:SetScript("OnEnter", 	button_OnEnter)
					button:SetScript("OnLeave", 	button_OnLeave)
					button.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
					button.highlight:SetWidth(width)
					button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
					button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
					button.isCurrency = false
					button.isMoney = false
					button.isItem = true
					button.itemID = itemID
					button.currencyID = nil
					button.itemName = name or ""
					button.LinkButton:Show()
					button:Show()
					bi = bi + 1
				end
			end
		end
	end
	-- end of tracked items

	if (profile.show_money) then
		button = _G["CurrencyTrackingButton"..bi]
		if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
		button.icon:SetTexture(nil)
		button.count:SetText(getFormattedValue(GetMoney()))
		local width = button.count:GetStringWidth()
		gwidth = gwidth + width
		button:SetWidth(width)
		if (bi == 1) then
			button:SetPoint("TOPLEFT", 0, 0)
		else
			button:SetPoint("TOPLEFT", _G["CurrencyTrackingButton"..bi-1], "TOPRIGHT", 15, 0)
		end
		button.index = nil
		button:SetScript("OnMouseDown",	button_OnMouseDown)
		button:SetScript("OnMouseUp", 	button_OnMouseUp)
		--button:SetScript("OnEnter", 	button_OnEnter)
		button:SetScript("OnLeave", 	button_OnLeave)
		button.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		button.highlight:SetWidth(width)
		button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
		button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
		button.isCurrency = false
		button.isMoney = true
		button.isItem = false
		button.itemID = nil
		button.currencyID = nil
		button.itemName = nil
		button.LinkButton:Hide()
		button:Show()
		bi = bi + 1
	end

	nf:SetWidth(gwidth)
	button = _G["CurrencyTrackingButton"..bi]
	while button do
		button.icon:SetTexture(nil)
		button.count:SetText(nil)
		button:SetWidth(0)
		button.index = nil
		button.isCurrency = false
		button.isMoney = false
		button.isItem = false
		button.itemID = nil
		button.currencyID = nil
		button.itemName = nil
		button.LinkButton:Hide()
		button:Hide()
		bi = bi + 1
		button = _G["CurrencyTrackingButton"..bi]
	end

end
]]

local function handleTrackedButtons(button, currencyID, itemID)
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
	
	local name, count, icon, _
	local width = 15
	if (currencyID) then 
		name, count, icon = GetCurrencyInfo(currencyID) 
	elseif (itemID) then
		name, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
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
		
	else
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
	button.itemName = itemID and name or nil
	button.LinkButton.tooltipText = currencyID and LibCurrencyInfo:GetCurrencyTokenStrings(currencyID) or nil
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

	for i=1, numCurrencies do
		local currencyID = CURRENCIESLIST[i].id
		local name, count
		if (currencyID) then name, count = GetCurrencyInfo(currencyID) end
		if (name and profile["currencies"][name] == true) then
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
	for k, v in pairs(addon.constants.items) do
		if k == "professions" then
			for ka, profs in pairs(v) do
				for kb, itemID in ipairs(profs) do
					if (profile["items"][itemID] == true) then
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
			end
		else
			for ka, itemID in ipairs(v) do
				if (profile["items"][itemID] == true) then
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
		end
	end
	-- end of tracked items
	-- handle money
	if (profile.show_money) then
		button = _G["CurrencyTrackingButton"..bi]
		if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
		handleTrackedButtons(button, nil, itemID)
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

	for i=1, numCurrencies do
		local currencyID = CURRENCIESLIST[i].id
		local name, count, icon
		if (currencyID) then name, count, icon = GetCurrencyInfo(currencyID) end
		if not icon then icon = 0 end -- somehow Legionfall War Supplies' icon is not available in 7.2.5.23959, this should temporary resolve the blocking issue
		if (name and profile["currencies"][name] == true) then
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
	for k, v in pairs(addon.constants.items) do
		if k == "professions" then
			for ka, profs in pairs(v) do
				for kb, itemID in ipairs(profs) do
					if (profile["items"][itemID] == true) then
						local icon, _
						_, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
						local count = GetItemCount(itemID, true)
						
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
			end
		else
			for ka, itemID in ipairs(v) do
				if (profile["items"][itemID] == true) then
					local icon, _
					_, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
					local count = GetItemCount(itemID, true)
					
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

local function frame_OnUpdate(self)
	local currencystr = getButtonText()
	currencyButton_Update()
	if (currencystr ~= CT_CURRSTR) then
		LDB_CurrencyTracking.text = currencystr
		CT_CURRSTR = currencystr
	end
end

local function createCurrencyFrame()
--[[
	local f
	if not f then f = CreateFrame("Frame") end
	f:SetScript("OnUpdate", frame_OnUpdate)
	
	f.button = CreateFrame("Button", "CurrencyTrackingFrame")
	f.button:SetParent("UIParent")
	f.button:SetWidth(200)
	f.button:SetHeight(20)
	local point, relativeTo, relativePoint, ofsx, ofsy = unpack(profile.point)
	f.button:SetPoint(point or "TOPLEFT", "UIParent", relativePoint or "TOPLEFT", ofsx or 150, ofsy or -80)
	f.button:SetClampedToScreen(true)
	f.button:SetMovable(true)
	f.button:EnableMouse(true)
	f.button:RegisterForDrag("LeftButton")
	f.button:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	
	f.button.Texture = f.button:CreateTexture(nil, "BACKGROUND")
	
	f.button.Text = f.button:CreateFontString("CurrencyTrackingText", "OVERLAY", "GameFontNormal")
	f.button.Text:SetPoint("TOPLEFT", f.button, "TOPLEFT", 0, 0)
	f.button.Text:SetText(L["CT_TITLE"])
	
	f.button:SetScript("OnMouseDown", 	button_OnMouseDown)
	f.button:SetScript("OnMouseUp", 	button_OnMouseUp)
	f.button:SetScript("OnEnter", 		button_OnEnter)
	f.button:SetScript("OnLeave", 		button_OnLeave)
]]
	local f = CreateFrame("Frame")
	f:SetScript("OnUpdate", frame_OnUpdate)
	
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
	--nf:SetScript("OnUpdate", frame_OnUpdate)
	
	return nf
end
-- ////////////////////////////////////////////////////////////////
--[[
local function copyOptions()
	if (profile.optionsCopied) then return end
	if (CurrencyTrackingDB[CurrencyTracking_Server] and CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player] and CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"]) then
		local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"]

		profile.show_currency = options.show_currency
		profile.show_money = options.show_money
		profile.breakupnumbers = options.breakupnumbers
		profile.icon_first = options.icon_first
		profile.always_lock = options.always_lock
		profile.scale = options.scale
		profile.alpha = options.alpha
		profile.bgalpha = options.bgalpha
		profile.tooltip_alpha = options.tooltip_alpha
		profile.tooltip_scale = options.tooltip_scale
		profile.currencies = options.currencies
	end
	
	profile.optionsCopied = true
end
]]

-- pre-scan items so that they will properly showed in option panel
-- this function will not generate any visible result but it's more like scanning items so that those will be in your cache
local function scanItems()
	for k, v in pairs(addon.constants.items) do
		if k == "professions" then
			for ka, profs in pairs(v) do
				for kb, itemID in ipairs(profs) do
					local name, icon, _
					name, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
				end
			end
		else
			for ka, itemID in ipairs(v) do
				local name, icon, _
				name, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
			end
		end
	end
end

local function setupLDB()
	-- LDB object setting up
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
	for k,v in pairs(addon.constants.currencies) do
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
	for k,v in pairs(addon.constants.currencies) do
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

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	--copyOptions()
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
	scanItems() -- pre-scan items so that they will properly showed in option panel
	self:Refresh()
end

function addon:Refresh()
	profile = self.db.profile
	
	frameRefresh()
end

-- ///////////////////////////////////////////////////
-- Combat
-- Event fired whenever you enter combat
function addon:PLAYER_REGEN_DISABLED()
	isInLockdown = true
	if (profile.show_currency and profile.hide_in_combat) then
		local nf = _G["CurrencyTrackingFrame"]
		nf:Hide()
	end
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
	if (profile.show_currency and profile.hide_in_battleground) then
		local nf = _G["CurrencyTrackingFrame"]
		nf:Hide()
	end
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
	if (profile.show_currency and profile.hide_in_petbattle) then
		local nf = _G["CurrencyTrackingFrame"]
		nf:Hide()
	end
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