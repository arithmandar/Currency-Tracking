-- $Id$

local _G = getfenv(0)
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):NewLocale("CurrencyTracking", "ptBR", false)

if not L then return end

if L then
L["CT_TITLE"] = "Rastreamento de moedas"
L["CT_ADDON_NOTES"] = "Currency Tracking é um addon que ajuda você a acompanhar as moedas obtidas, exibindo as moedas selecionadas até mesmo na parte superior da tela do jogo."
L["Options"] = "Opções"
L["About"] = "Sobre"
L["Author"] = "Autor"
L["Addon Info"] = "Informações do addon"

-- Trading goods
L["Elemental"] = "Elemental"
L["Meat"] = "Carne"
L["Potion"] = "Poção"
-- Display Settings
L["Display Settings"] = "Configurações de exibição"
L["Show currency info on screen"] = "Mostrar informações de moedas na tela"
L["Show tooltip"] = "Mostrar dica de ferramenta"
L["Show all currency's info in tooltip."] = "Mostrar todas as informações de moedas na dica de ferramenta."
L["Show money info"] = "Mostrar informações de dinheiro"
L["Enable to show total money together with currencies' info."] = "Ative para mostrar o dinheiro total junto com as informações de moedas."
L["Reset position"] = "Redefinir posição"
L["Reset on-screen currency frame's position."] = "Redefinir a posição do quadro de moedas na tela."
L["Breakup numbers"] = "Agrupar números"
L["Converts a number into a localized string, grouping digits as required."] = "Converte um número em uma sequência localizada, agrupando dígitos conforme necessário."
L["Hide zero"] = "Ocultar zero"
L["Auto-hide items / currencies which have zero amount."] = "Ocultar automaticamente itens/moedas com quantidade zero."
L["Icon first"] = "Ícone primeiro"
L["Put currency icon prior to its amount"] = "Exibir o ícone da moeda antes da quantidade"
L["Always lock the currency info frame"] = "Sempre bloquear o quadro de informações de moedas"
L["Enable to always lock the frame even not in combat. Disable to only lock the frame while in combat."] = "Ative para sempre bloquear o quadro, mesmo fora de combate. Desative para bloqueá-lo apenas durante o combate."
L["Hide while in pet battle"] = "Ocultar durante batalhas de mascotes"
L["Automatically hide the tracking frame while in pet battle."] = "Ocultar automaticamente o quadro de rastreamento durante batalhas de mascotes."
L["Hide while in combat"] = "Ocultar durante o combate"
L["Automatically hide the tracking frame while in combat."] = "Ocultar automaticamente o quadro de rastreamento durante o combate."
L["Hide while in battleground"] = "Ocultar em campos de batalha"
L["Automatically hide the tracking frame while in battleground."] = "Ocultar automaticamente o quadro de rastreamento em campos de batalha."
L["Show icon only"] = "Mostrar apenas o ícone"
L["Show only the currency / item's icon, do not show the amounts."] = "Mostrar apenas o ícone da moeda/do item, sem mostrar as quantidades."
L["Max items per row"] = "Máximo de itens por linha"
L["Set the maximum number of items to be displayed per row. Set to 0 to allow unlimited items on one single row."] = "Defina o número máximo de itens a serem exibidos por linha. Defina como 0 para permitir itens ilimitados em uma única linha."
L["Show Lower Denominations"] = "Mostrar denominações menores"
L["Enable to show all the lower denominations, disable to only show money in gold."] = "Ative para mostrar todas as denominações menores. Desative para mostrar dinheiro apenas em ouro."
-- Scale and Transparency
L["Scale and Transparency"] = "Escala e transparência"
L["On-screen frame"] = "Quadro na tela"
L["Tooltip"] = "Dica de ferramenta"
L["Scale"] = "Escala"
L["Transparency"] = "Transparência"
L["Background"] = "Plano de fundo"
L["Currencies info's background transparency"] = "Transparência do plano de fundo das informações de moedas"
-- Others
L["Currencies to be tracked on screen:"] = "Moedas a serem rastreadas na tela:"
L["Tracked Currencies"] = "Moedas rastreadas"
L["Tracked Items"] = "Itens rastreados"
L["Profile Options"] = "Opções de perfil"
end
