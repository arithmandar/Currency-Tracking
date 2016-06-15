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
	CurrencyTrackingOptionsFrameSliderAlpha:SetValue(options.tooltip_alpha);
	CurrencyTrackingOptionsFrameSliderToolTipScale:SetValue(options.tooltip_scale);
end

function CurrencyTrackingOptions_OnHide(self)
	if(MYADDONS_ACTIVE_OPTIONSFRAME == self) then
		ShowUIPanel(myAddOnsFrame);
	end
end

function CurrencyTrackingOptions_ShowOnScreenToggle()
	local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"];
	
	if(CurrencyTrackingInfoFrame:IsVisible()) then
		CurrencyTrackingInfoFrame:Hide();
		options.show_currency = false;
	else
		CurrencyTrackingInfoFrame:Show();
		options.show_currency = true;
	end
end

function CurrencyTrackingOptions_ResetPosition()
	local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"];

	CurrencyTrackingFrame:SetPoint("TOPLEFT", nil, "TOPLEFT", 150, 0);
	options.offsetx = 150;
	options.offsety = 0;
end

function CurrencyTrackingOptions_SetupSlider(self, text, mymin, mymax, step)
	self:SetMinMaxValues(mymin, mymax);
	self:SetValueStep(step);
end

function CurrencyTrackingOptions_UpdateSlider(self, text)
	_G[self:GetName().."Text"]:SetText("|cffffd200"..text.." ("..round(self:GetValue(), 3)..")");
end

function CurrencyTrackingOptions_SliderAlphaOnValueChanged(self)
	local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"];
	
	CurrencyTrackingOptions_UpdateSlider(self, CT_OPT_TRANSPARENCY);
	options.tooltip_alpha = self:GetValue();
end

function CurrencyTrackingOptions_SliderToolTipScaleOnValueChanged(self)
	local options = CurrencyTrackingDB[CurrencyTracking_Server][CurrencyTracking_Player]["options"];
	
	CurrencyTrackingOptions_UpdateSlider(self, CT_OPT_TOOLTIPSCALE);
	options.tooltip_scale = self:GetValue();
end

function CurrencyTrackingOptions_OnMouseWheel(self, delta)
	if (delta > 0) then
		self:SetValue(self:GetValue() + self:GetValueStep())
	else
		self:SetValue(self:GetValue() - self:GetValueStep())
	end
end

