-- $Id$
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs = _G.pairs
local math = _G.math;
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub;
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name);

local AceConfigReg = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local Media = LibStub("LibSharedMedia-3.0")

local profile

local function setupTokenOptions(name)
	if (addon.db.profile["currencies"][name] == nil) then
		addon.db.profile["currencies"][name] = false;
	end
end

local function tokenContainer_Update()
	local numTokenTypes = GetCurrencyListSize();
	
	if (not CurrencyTrackingTokenOptionsFrame.TokenContainer.buttons) then
		return;
	end

	-- Setup the buttons
	local scrollFrame = CurrencyTrackingTokenOptionsFrame.TokenContainer;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local buttons = scrollFrame.buttons;
	local numButtons = #buttons;
	local name, isHeader, isExpanded, isUnused, isWatched, count, icon;
	local button, index;
	for i=1, numButtons do
		index = offset+i;
		name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo(index);
		button = buttons[i];
		button.check:Hide();
		--button.Select:Hide();
		if ( not name or name == "" ) then
			button:Hide();
		else
			if ( isHeader ) then
				button.categoryLeft:Show();
				button.categoryRight:Show();
				button.categoryMiddle:Show();
				button.expandIcon:Show();
				button.count:SetText("");
				button.icon:SetTexture("");
				if ( isExpanded ) then
					button.expandIcon:SetTexCoord(0.5625, 1, 0, 0.4375);
				else
					button.expandIcon:SetTexCoord(0, 0.4375, 0, 0.4375);
				end
				button.highlight:SetTexture("Interface\\TokenFrame\\UI-TokenFrame-CategoryButton");
				button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 3, -2);
				button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -3, 2);
				button.name:SetText(name);
				button.name:SetFontObject("GameFontNormal");
				button.name:SetPoint("LEFT", 22, 0);
				button.LinkButton:Hide();
			else
				setupTokenOptions(name);
				button.categoryLeft:Hide();
				button.categoryRight:Hide();
				button.categoryMiddle:Hide();
				button.expandIcon:Hide();
				button.count:SetText(addon.db.profile.breakupnumbers and BreakUpLargeNumbers(count) or count);
				button.icon:SetTexture(icon);
				--if ( isWatched ) then
				--	button.check:Show();
				--end
				button.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
				button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0);
				button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0);
				if ( count == 0 ) then
					button.count:SetFontObject("GameFontRed");
					--button.name:SetFontObject("GameFontDisable");
					button.name:SetFontObject("GameFontRed");
				else
					button.count:SetFontObject("GameFontHighlight");
					button.name:SetFontObject("GameFontHighlight");
				end
				button.name:SetText(name);
				button.name:SetPoint("LEFT", 11, 0);
				button.LinkButton:Show();
				if (addon.db.profile["currencies"][name] == true) then
					button.check:Show();
				end
			end
			--Manage highlight
			if ( name == CurrencyTrackingTokenOptionsFrame.TokenContainer.selectedToken ) then
				CurrencyTrackingTokenOptionsFrame.TokenContainer.selectedID = index;
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end

			button.index = index;
			button.isHeader = isHeader;
			button.isExpanded = isExpanded;
			button.isUnused = isUnused;
			button.isWatched = isWatched;
			button:Show();
		end
	end
	local totalHeight = numTokenTypes * (button:GetHeight()+TOKEN_BUTTON_OFFSET);
	local displayedHeight = #buttons * (button:GetHeight()+TOKEN_BUTTON_OFFSET);

	HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight);
end

function CurrencyTrackingTokenOptions_OnLoad(self)
	self.TokenContainer.update = tokenContainer_Update
	self.Text:SetText(L["Currencies to be tracked on screen:"])
end

function CurrencyTrackingTokenOptions_OnShow(self)
	-- Create buttons if not created yet
	if (not self.TokenContainer.buttons) then
		HybridScrollFrame_CreateButtons(self.TokenContainer, "CurrencyTrackingTokenButtonTemplate", 1, -2, "TOPLEFT", "TOPLEFT", 0, 0)
		local buttons = self.TokenContainer.buttons
		local numButtons = #buttons;
		for i=1, numButtons do
			if ( math.fmod(i, 2) == 1 ) then
				buttons[i].stripe:Hide();
			end
		end
	end

	-- SetButtonPulse(CharacterFrameTab3, 0, 1);	--Stop the button pulse
	tokenContainer_Update();
end

local myaddon = {}
local function addTokenOptionFrame()
	
	UIPanelWindows['CurrencyTrackingTokenOptionsFrame'] = {area = 'center', pushable = 0}
	
	myaddon.panel = _G["CurrencyTrackingTokenOptionsFrame"]
	
	myaddon.panel.name = L["Tracked Currencies"]
	myaddon.panel.parent = addon.LocName
	InterfaceOptions_AddCategory(myaddon.panel)
end

-- /////////////////////////////////////////////////////////
local function tokenButton_ToggleTrack(name)
	profile = addon.db.profile
	if (profile["currencies"][name] ~= nil) then
		profile["currencies"][name] = not profile["currencies"][name];
	else
		profile["currencies"][name] = false;
	end
end

function CurrencyTrackingTokenButton_OnClick(self)
	if ( self.isHeader ) then
		if ( self.isExpanded ) then
			ExpandCurrencyList(self.index, 0);
		else
			ExpandCurrencyList(self.index, 1);
		end
	else
		CurrencyTrackingTokenOptionsFrame.TokenContainer.selectedToken = self.name:GetText();
		tokenButton_ToggleTrack(CurrencyTrackingTokenOptionsFrame.TokenContainer.selectedToken);
	end
	tokenContainer_Update();
end
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

local options, moduleOptions = nil, {}

local function getOptions()
	profile = addon.db.profile
	if not options then
		options = {
			type = "group",
			name = addon.LocName,
			args = {
				general = {
					order = 1,
					type = "group",
					name = L["Options"],
					get = optGetter,
					set = optSetter,
					args = {
						version = {
							order = 1,
							type = "description",
							name = addon.Notes,
							width = "full",
						},
						group1 = {
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
								always_lock = {
									order = 12,
									type = "toggle",
									name = L["Always lock the currency info frame"],
									desc = L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."],
									width = "full",
									disabled = function() return not addon.db.profile.show_currency end,
								},
								resetPos = {
									order = 13, 
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
						group2 = {
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
									width = "full",
								},
								breakupnumbers = {
									order = 22,
									type = "toggle",
									name = L["Breakup numbers"],
									desc = L["Converts a number into a localized string, grouping digits as required."],
									width = "full",
								},
								icon_first = {
									order = 23,
									type = "toggle",
									name = L["Icon first"],
									desc = L["Put currency icon prior to its amount"],
									width = "full",
								},
							},
						},
						group3 = {
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
				},
			},
		}
		for k,v in pairs(moduleOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end
	end
	
	return options
end

local function openOptions()
	-- open the profiles tab before, so the menu expands
	InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.Profiles)
	InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.Profiles) -- yes, run twice to force the tre get expanded
	InterfaceOptionsFrame_OpenToCategory(myaddon.panel)
	InterfaceOptionsFrame:Raise()
end

function addon:OpenOptions() 
	openOptions()
end

local function giveProfiles()
	return AceDBOptions:GetOptionsTable(addon.db)
end

function addon:SetupOptions()
	self.optionsFrames = {}

	-- setup options table
	AceConfigReg:RegisterOptionsTable(addon.LocName, getOptions)
	self.optionsFrames.General = AceConfigDialog:AddToBlizOptions(addon.LocName, nil, nil, "general")
	
	addTokenOptionFrame()

	self:RegisterModuleOptions("Profiles", giveProfiles, L["Profile Options"])
end

-- Description: Function which extends our options table in a modular way
-- Expected result: add a new modular options table to the modularOptions upvalue as well as the Blizzard config
-- Input:
--		name			: index of the options table in our main options table
--		optionsTable	: the sub-table to insert
--		displayName	: the name to display in the config interface for this set of options
-- Output: None.
function addon:RegisterModuleOptions(name, optionTbl, displayName)
	moduleOptions[name] = optionTbl
	self.optionsFrames[name] = AceConfigDialog:AddToBlizOptions(addon.LocName, displayName, addon.LocName, name)
end

