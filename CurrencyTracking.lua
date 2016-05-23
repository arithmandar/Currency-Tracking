-- $Id$
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local ipairs = _G.ipairs
local pairs = _G.pairs
CurrencyTracking_Player = UnitName("player");
CurrencyTracking_Server = GetRealmName();

local CurrencyTracking_Version = GetAddOnMetadata("CurrencyTracking", "Version");
local CurrencyTracking_Category = GetAddOnMetadata("CurrencyTracking", "X-Category");
local isInLockdown;

local CT_DefaultOptions = {
	offsetx = 150,
	offsety = 0,
	show_currency = true,
};

local LibStub = _G.LibStub;
local L = LibStub("AceLocale-3.0"):GetLocale("CurrencyTracking");

-- Codes adopted from TitanPanel
local function CurrencyTracking_AddTooltipText(text)
	if ( text ) then
		-- Append a "\n" to the end 
		if ( string.sub(text, -1, -1) ~= "\n" ) then
			text = text.."\n";
		end
		
		-- See if the string is intended for a double column
		for text1, text2 in string.gmatch(text, "([^\t\n]*)\t?([^\t\n]*)\n") do
			if ( text2 ~= "" ) then
				-- Add as double wide
				GameTooltip:AddDoubleLine(text1, text2);
			elseif ( text1 ~= "" ) then
				-- Add single column line
				GameTooltip:AddLine(text1);
			else
				-- Assume a blank line
				GameTooltip:AddLine("\n");
			end			
		end
	end
end

function CurrencyTracking_OnLoad(self)
	self.registry = { 
		id = "CurrencyTracking",
		category = CurrencyTracking_Category,
		version = CurrencyTracking_Version,
		menuText = L["TITLE"], 
		tooltipTitle = L["TITLE"],
		tooltipTextFunction = "CurrencyTracking_GetTooltipText",
		buttonTextFunction = "CurrencyTracking_GetButtonText",
		controlVariables = {
			DisplayOnRightSide = true,
		},
		savedVariables = {
			DisplayOnRightSide = false,             
		},
	};

	-- Register the CurrencyTracking frame for the following events
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("PLAYER_REGEN_ENABLED");
	self:RegisterEvent("PLAYER_REGEN_DISABLED");

	self:RegisterForDrag("LeftButton");
end

function CurrencyTracking_OnEvent(self, event, ...)
	local arg1 = ...;
	if (event == "ADDON_LOADED" and arg1 == "CurrencyTracking") then
		CurrencyTracking_Init();
	end
	-- for combact lockdown
	if (event == "PLAYER_REGEN_DISABLED") then
		isInLockdown = true;
	elseif (event == "PLAYER_REGEN_ENABLED") then
		isInLockdown = false;
	end
end

function CurrencyTracking_InitOptions()
	if ( CurrencyTrackingDB == nil ) then
		CurrencyTrackingDB = { };
	end
	if ( CurrencyTrackingDB[CurrencyTracking_Server] == nil ) then
		CurrencyTrackingDB[CurrencyTracking_Server] = { };
	end
	if ( CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player] == nil ) then
		CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player] = { };
		CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"] = CT_DefaultOptions;
	end
end

function CurrencyTracking_Init()
	CurrencyTracking_InitOptions();
	local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"];

	local tooltiptxt = CurrencyTracking_GetTooltipText();

	-- Make an LDB object
	LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("CurrencyTracking", {
		type = "launcher",
		text = L["TITLE"],
		OnClick = function(self, button)
			if button == "LeftButton" then
				--CurrencyTracking_OnClick();
			elseif button == "RightButton" then
				CurrencyTracking_Options_Toggle();
			end
		end,
		icon = "Interface\\Icons\\timelesscoin",
		OnTooltipShow = function(tooltip)
			if not tooltip or not tooltip.AddLine then return end
--			GameToolTip:AddLine(L["TITLE"]);
			CurrencyTracking_AddTooltipText(tooltiptxt)
		end,
	});
	if ( TitanPanelButton_UpdateButton ) then
		--TitanPanelButton_UpdateButton("CurrencyTracking");
	end

	if(options.show_currency == true) then
		CurrencyTrackingFrame:Show();
		if ( options.offsetx and options.offsety ) then
			CurrencyTrackingFrame:SetPoint("TOPLEFT", nil, "TOPLEFT", options.offsetx, options.offsety);
		end
	else
		CurrencyTrackingFrame:Hide();
	end
end

function CurrencyTracking_OnClick()

end


function CurrencyTracking_GetFormattedCurrency(currencyID)
	local _, amount, icon = GetCurrencyInfo(currencyID);
	
	if (amount >0) then
		local CURRENCY_TEXTURE = "%s\124T"..icon..":%d:%d:2:0\124t";
		return format(CURRENCY_TEXTURE.." ", BreakUpLargeNumbers(amount), 0, 0);
	else
		return "";
	end
end

function CurrencyTracking_BackpackTokenFrame_Update()
	local name, currencyID;
	local currencystr = "";
	for i=1, MAX_WATCHED_TOKENS do
		name, _, _, currencyID = GetBackpackCurrencyInfo(i);
		-- Update watched tokens
		if ( name ) then
			currencystr = currencystr..CurrencyTracking_GetFormattedCurrency(currencyID).." ";
		end
	end
	return currencystr;
end

function CurrencyTracking_Frame_Update()
	local currencystr = "|cFFFFFFFF"..CurrencyTracking_BackpackTokenFrame_Update();
	CurrencyTrackingText:SetText(currencystr);
end

function CurrencyTracking_GetButtonText()
	local currencystr = CurrencyTracking_BackpackTokenFrame_Update();

	if (currencystr) then 
		currencystr = "|cFFFFFFFF"..currencystr;
	else
		currencystr = L["TITLE"];
	end

	return currencystr;
end

-- Codes adopted from TitanCurrency and revised by arith
function CurrencyTracking_GetTooltipText()
	local display = "";
	local tooltip = "";
	local name, isHeader, isExpanded, isUnused, count, icon, cCount;
	local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"];
	cCount = GetCurrencyListSize();
	for i = 1, cCount do 
		name, isHeader, isExpanded, isUnused, _, count, icon = GetCurrencyListInfo(i);
		if ( isHeader ) then
			tooltip = tooltip..name.."\n";
		elseif ( (count ~= 0) and not isUnused ) then
			if (icon ~= nil) then
				display = " - "..name.."\t"..BreakUpLargeNumbers(count).." |T"..icon..":16|t"
			end
			-- trace(display)
			tooltip = strconcat(tooltip, display,"|r\n");
		end
	end 
	return tooltip;    
end

function CurrencyTracking_Frame_HandleMouseDown(self, buttonName)    
	-- Prevent activation when in combat
	if (isInLockdown) then
		return;
	end
	-- Handle left button clicks
	if (buttonName == "LeftButton") then
		CurrencyTrackingFrame:StartMoving();
	elseif (buttonName == "RightButton") then
		CurrencyTrackingOptions_Toggle();
		GameTooltip_Hide();
	end
end

function CurrencyTracking_Frame_HandleMouseUp(self, button)
	CurrencyTrackingFrame:StopMovingOrSizing();
	local x, y;
	local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"];
	_, _, _, x, y = CurrencyTrackingFrame:GetPoint();
	options.offsetx = x;
	options.offsety = y;
end

function CurrencyTracking_Frame_OnEnter(self)
	if (not GameTooltip:IsShown()) then
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", -10, 0);
		GameTooltip:SetBackdropColor(0, 0, 0, 0.9);
		GameTooltip:SetText("|cFFFFFFFF"..L["TITLE"], 1, 1, 1, nil, 1);
		local tooltip = CurrencyTracking_GetTooltipText();
		if (tooltip) then
			CurrencyTracking_AddTooltipText(tooltip);
		end
		GameTooltip:Show();
	else
		GameTooltip:Hide();
	end
end

function CurrencyTracking_Frame_OnLeave(self)
	GameTooltip_Hide();
end

function CurrencyTracking_Options_Toggle()

end

