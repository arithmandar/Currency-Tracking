--[[
$Id$
]]

local LibStub = _G.LibStub;
local L = LibStub("AceLocale-3.0"):GetLocale("CurrencyTracking");

function CurrencyTrackingOptions_Toggle()
	if(InterfaceOptionsFrame:IsVisible()) then
		InterfaceOptionsFrame:Hide();
	else
		InterfaceOptionsFrame_OpenToCategory(L["TITLE"]);
		-- Yes we have to call this twice
		InterfaceOptionsFrame_OpenToCategory(L["TITLE"]);
	end
end

function CurrencyTrackingOptions_OnLoad(self)
	UIPanelWindows['CurrencyTrackingOptionsFrame'] = {area = 'center', pushable = 0};
	
	self.name = L["TITLE"];
	InterfaceOptions_AddCategory(self);
	if (LibStub:GetLibrary("LibAboutPanel", true)) then
		LibStub("LibAboutPanel").new(L["TITLE"], "CurrencyTracking");
	end
end

function CurrencyTrackingOptions_OnShow()
	local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"];
	
	CurrencyTrackingOptionsFrame_ShowOnScreen:SetChecked(options.show_currency);
end

function CurrencyTrackingOptions_OnHide(self)
	if(MYADDONS_ACTIVE_OPTIONSFRAME == self) then
		ShowUIPanel(myAddOnsFrame);
	end
end

function CurrencyTracking_ShowOnScreenToggle()
	local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"];
	
	if(CurrencyTrackingFrame:IsVisible()) then
		CurrencyTrackingFrame:Hide();
		options.show_currency = false;
	else
		CurrencyTrackingFrame:Show();
		options.show_currency = true;
	end
end

function CurrencyTracking_ResetPosition()
	local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"];

	CurrencyTrackingFrame:SetPoint("TOPLEFT", nil, "TOPLEFT", 150, 0);
	options.offsetx = 150;
	options.offsety = 0;
end
