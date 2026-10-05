-----------------------------------------------------------------------
-- Currency Tracking UI factories.
--
-- Lua replacement for the frame templates previously defined in
-- Templates.xml.
-----------------------------------------------------------------------

local _G = getfenv(0)

local CreateFrame = _G.CreateFrame
local GameTooltip = _G.GameTooltip
local GameTooltip_Hide = _G.GameTooltip_Hide
local IsModifiedClick = _G.IsModifiedClick
local HandleModifiedItemClick = _G.HandleModifiedItemClick
local BlizzardGetCurrencyLink = _G.GetCurrencyLink
local C_CurrencyInfo = _G.C_CurrencyInfo
local GetBuildInfo = _G.GetBuildInfo
-- Determine WoW client family
local _, _, _, interfaceVersion = GetBuildInfo()
local projectID = WOW_PROJECT_ID

local PROJECT_MAINLINE = WOW_PROJECT_MAINLINE
local PROJECT_CLASSIC = WOW_PROJECT_CLASSIC
local PROJECT_TBC = WOW_PROJECT_BURNING_CRUSADE_CLASSIC
local PROJECT_CATA = WOW_PROJECT_CATACLYSM_CLASSIC
local PROJECT_MISTS = WOW_PROJECT_MISTS_CLASSIC

-- Beta-only fallback:
-- Replace these bounds with values verified from the actual Forever client.
local isForeverBeta = projectID == PROJECT_MAINLINE and interfaceVersion >= 10000 and interfaceVersion < 20000

local isRetail = projectID == PROJECT_MAINLINE and not isForeverBeta
local isClassicEra = projectID == PROJECT_CLASSIC
local isAnniversaryTBC = PROJECT_TBC ~= nil and projectID == PROJECT_TBC
local isCataclysmClassic = PROJECT_CATA ~= nil and projectID == PROJECT_CATA
local isMistsClassic = PROJECT_MISTS ~= nil and projectID == PROJECT_MISTS
local isProgressionClassic = isCataclysmClassic or isMistsClassic
local isClassicForever = isForeverBeta
-- For API calls, Classic Forever is using same APIs with the mainline client.
-- So for functional wise (API calls), we consider Forever is not part of AnyClassic
local isAnyClassic = isClassicEra or isAnniversaryTBC or isProgressionClassic

if isRetail or isClassicForever then
    BlizzardGetCurrencyLink = C_CurrencyInfo.GetCurrencyLink
end

local _, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)

local Templates = {}
addon.Templates = Templates

local BUTTON_HEIGHT = 20
local ICON_SIZE = 16

local function SetTooltipBackground(tooltip, alpha)
    if tooltip.NineSlice
        and type(tooltip.NineSlice.SetCenterColor) == "function"
    then
        tooltip.NineSlice:SetCenterColor(0, 0, 0, alpha)
    end
end

local function LinkButton_OnEnter(self)
    local parent = self:GetParent()
    parent:LockHighlight()

    self.orig_tooltipScale = GameTooltip:GetScale()

    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetScale(addon.db.profile.tooltip_scale)

    SetTooltipBackground(GameTooltip, addon.db.profile.tooltip_alpha)

    if self.tooltipText then
        if parent.isItem and parent.itemLink then
            GameTooltip:SetHyperlink(self.tooltipText)

        elseif parent.isCurrency then
            GameTooltip:SetText(self.tooltipText)
        end

    elseif parent.isItem then
        GameTooltip:SetText(parent.itemName or "", 1, 1, 1, nil, false)
    end

    GameTooltip:Show()
end

local function LinkButton_OnLeave(self)
    self:GetParent():UnlockHighlight()

    if self.orig_tooltipScale then
        GameTooltip:SetScale(self.orig_tooltipScale)
        self.orig_tooltipScale = nil
    end

    GameTooltip:Hide()
end

local function LinkButton_OnMouseDown(self, button)
    if button == "LeftButton" then
        local parent = self:GetParent()
        local handler = parent:GetScript("OnMouseDown")
        if handler then
            handler(parent, button)
        end
    end
end

local function LinkButton_OnMouseUp(self, button)
    if button == "LeftButton" then
        local parent = self:GetParent()
        local handler = parent:GetScript("OnMouseUp")
        if handler then
            handler(parent, button)
        end
    end
end

local function LinkButton_OnClick(self, button)
    local parent = self:GetParent()

    if button == "RightButton" then
        addon:OpenOptions(parent.isItem)
        GameTooltip_Hide()
        return
    end

    if not IsModifiedClick("CHATLINK") then
        return
    end

    if parent.isItem and parent.itemLink then
        HandleModifiedItemClick(parent.itemLink)

    elseif parent.isCurrency and parent.currencyID then
        local currencyLink = BlizzardGetCurrencyLink(parent.currencyID, 0)

        if currencyLink then
            HandleModifiedItemClick(currencyLink)
        end
    end
end

function Templates.CreateLinkButton(name, parent)
    local button = _G[name]
    
    if button then
        return
    else
        button = CreateFrame("Button", name, parent)
    end

    button:SetAllPoints(parent)
    button:RegisterForClicks(
        "LeftButtonDown",
        "RightButtonDown"
    )

    button:SetScript("OnEnter", LinkButton_OnEnter)
    button:SetScript("OnLeave", LinkButton_OnLeave)
    button:SetScript("OnMouseDown", LinkButton_OnMouseDown)
    button:SetScript("OnMouseUp", LinkButton_OnMouseUp)
    button:SetScript("OnClick", LinkButton_OnClick)

    return button
end

function Templates.CreateTrackingButton(name, parent)
    local button = _G[name]
    if  button then
        return
    else
        button = CreateFrame("Button", name, parent)
    end

    button:SetHeight(BUTTON_HEIGHT)
    button:SetWidth(15)

    button:SetMovable(true)
    button:EnableMouse(true)

    button:RegisterForDrag("LeftButton")
    button:RegisterForClicks("LeftButtonDown", "RightButtonDown")

    local icon = button:CreateTexture(name .. "Icon", "ARTWORK")
    icon:SetSize(ICON_SIZE, ICON_SIZE)
    icon:SetPoint("LEFT", button, "LEFT", 0, 0)
    button.icon = icon

    local count = button:CreateFontString(name .. "Count", "OVERLAY", "GameFontHighlightSmall")
    count:SetPoint("LEFT", icon, "RIGHT", 2, 0)
    count:SetJustifyH("LEFT")
    count:SetText("")
    button.count = count

    local highlight = button:CreateTexture(name .. "Highlight", "HIGHLIGHT")
    highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    highlight:SetBlendMode("ADD")
    highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
    highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
    button:SetHighlightTexture(highlight)
    button.highlight = highlight

    local linkButton = Templates.CreateLinkButton(name .. "LinkButton", button)
    button.LinkButton = linkButton

    return button
end