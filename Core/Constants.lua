-- $Id$
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
private.addon_name = "CurrencyTracking"

local LibStub = _G.LibStub

local constants = {}
private.constants = constants

constants.ldb_icon = "Interface\\Icons\\timelesscoin"

constants.defaults = {
	profile = {
		show_currency = true,
		show_money = true,
		show_iconOnly = false,
		show_tooltip = true,
		hide_zero = false,
		breakupnumbers = true,
		icon_first = false,
		always_lock = false,
		hide_in_combat = true,
		hide_in_petbattle = false,
		hide_in_battleground = true,
		point = { "TOPLEFT", "UIParent", "TOPLEFT", 150, -80 },
		scale = 1,
		alpha = 1,
		bgalpha = 0.3,
		tooltip_alpha = 0.9,
		tooltip_scale = 1,
		currencies = {},
		items = {},
		maxItems = 0, -- 0 means un-limited
		--optionsCopied = false,
		currencyFormatConverted = false,
		showLowerDenominations = true,
	},
}

constants.items = {
	world_events = {
		49927, -- Love Token, Love is in the Air
		44791, -- Noblegarden Chocolate
		37829, -- Brewfest Prize Token
		33226, -- Tricky Treat
		23247, -- Burning Blossom, Midsummer Fire Festiva
		21100, -- Coin of Ancestry, Lunar Festiva
	},
	pvp = {
		137642, -- Mark of Honor
		103533, -- Vicious Saddle
		26045, -- HALAA_BATTLE_TOKEN 
		26044, -- HALAA_RESEARCH_TOKEN 
	},
	others = {
		162461, -- Sanguicell
		157796, -- Purified Titan Essence, added in 7.3.5.25807
		151568, -- Primal Sargerite, added in patch 7.3.0.24484
		124124, -- Blood of Sargeras
		124099, -- Blackfang Claw
		120945, -- Primal Spirit
		119819, -- Caged Mighty Clefthoof
		119817, -- Caged Mighty Riverbeast
		119815, -- Caged Mighty Wolf
		119814, -- Leathery Caged Beast
		119813, -- Furry Caged Beast
		119810, -- Meaty Caged Beast
		118100, -- Highmaul Relic
		117397, -- Nats Lucky Coin
		116415, -- Pet Charm
		113578, -- Hearty Soup Bone
		76061, -- Spirit of Harmony
		43089, -- Vrykul Bones
		28558, -- Spirit Shard, currency tokens dropped by bosses in the Auchindoun
	},
	professions = {
		[3908] = { -- Tailoring
			158378, -- Embroidered Deep Sea Satin
			152577, -- Deep Sea Satin
			152576, -- Tidespray Linen
			151567, -- Lightweave Cloth
			146711, -- Bolt of Starweave
			146710, -- Bolt of Shadowcloth
			127681, -- Sharp Spritethorn
			127037, -- Runic Catgut
			127004, -- Imbued Silkweave
			124437, -- Shal'dorei Silk
			111557, -- Sumptuous Fur
			111556, -- Hexweave Cloth
			98619, -- Celestial Cloth
			92960, -- Silkworm Cocoon
			82447, -- Imperial Silk
			82441, -- Bolt of Windwool Cloth
			72988, -- Windwool Cloth
			54440, -- Dreamcloth
			53643, -- Bolt of Embersilk Cloth
			53010, -- Embersilk Cloth
			42253, -- Iceweb Spider Silk
			41595, -- Spellweave
			41594, -- Moonshroud
			41593, -- Ebonweave
			41511, -- Bolt of Imbued Frostweave
			41510, -- Bolt of Frostweave
			38426, -- Eternium Thread
			33470, -- Frostweave Cloth
			24272, -- Shadowcloth
			24271, -- Spellcloth
			21881, -- Netherweb Spider Silk
			21877, -- Netherweave Cloth
			21845, -- Primal Mooncloth
			21844, -- Bolt of Soulcloth
			21842, -- Bolt of Imbued Netherweave
			21840, -- Bolt of Netherweave
			14342, -- Mooncloth
			14341, -- Rune Thread
			14256, -- Felcloth
			14227, -- Ironweb Spider Silk
			14048, -- Bolt of Runecloth
			14047, -- Runecloth
			10285, -- Shadow Silk
			8343, -- Heavy Silken Thread
			4339, -- Bolt of Mageweave
			4338, -- Mageweave Cloth
			4337, -- Thick Spider's Silk
			4306, -- Silk Cloth
			4305, -- Bolt of Silk Cloth
			4291, -- Silken Thread
			3182, -- Spider's Silk
			2997, -- Bolt of Woolen Cloth
			2996, -- Bolt of Linen Cloth
			2592, -- Wool Cloth
			2589, -- Linen Cloth
			2321, -- Fine Thread
			2320, -- Coarse Thread
		},
		[2575] = { -- Mining
			152513, -- Platinum Ore
			152512, -- Monelite Ore
			152579, -- Storm Silver Ore
			151564, -- Empyrium
			124444, -- Infernal Brimstone
			123919, -- Felslate
			123918, -- Leystone Ore
			115508, -- Draenic Stone
			109992, -- Blackrock Fragment
			109991, -- True Iron Nugget
			109119, -- True Iron Ore
			109118, -- Blackrock Ore
			108391, -- Titanium Ore Nugget
			108309, -- Pyrite Ore Nugget
			108308, -- Elementium Ore Nugget
			108307, -- Obsidium Ore Nugget
			108306, -- Saronite Ore Nugget
			108305, -- Cobalt Ore Nugget
			108304, -- Khorium Ore Nugget
			108302, -- Adamantite Ore Nugget
			108301, -- Fel Iron Ore Nugget
			108300, -- Mithril Ore Nugget
			108299, -- Truesilver Ore Nugget
			108298, -- Thorium Ore Nugget
			108297, -- Iron Ore Nugget
			108296, -- Gold Ore Nugget
			108294, -- Silver Ore Nugget
			97546, -- Kyparite Fragment
			97512, -- Ghost Iron Nugget
			72103, -- White Trillium Ore
			72094, -- Black Trillium Ore
			72093, -- Kyparite
			72092, -- Ghost Iron Ore
			53038, -- Obsidium Ore
			52185, -- Elementium Ore
			52183, -- Pyrite Ore
			36912, -- Saronite Ore
			36910, -- Titanium Ore
			36909, -- Cobalt Ore
			23427, -- Eternium Ore
			23426, -- Khorium Ore
			23425, -- Adamantite Ore
			23424, -- Fel Iron Ore
			22203, -- Large Obsidian Shard
			22202, -- Small Obsidian Shard
			12365, -- Dense Stone
			11370, -- Dark Iron Ore
			10620, -- Thorium Ore
			7912, -- Solid Stone
			7911, -- Truesilver Ore
			3858, -- Mithril Ore
			2838, -- Heavy Stone
			2836, -- Coarse Stone
			2835, -- Rough Stone
			2776, -- Gold Ore
			2775, -- Silver Ore
			2772, -- Iron Ore
			2771, -- Tin Ore
			2770, -- Copper Ore
		},
		[2108] = { -- Leatherworking
			152542, -- Hardened Tempest Hide
			153051, -- Mistscale
			154165, -- Calcified Bone
			154722, -- Tempest Hide
			152541, -- Coarse Leather
			153050, -- Shimmerscale
			154164, -- Blood-Stained Bone
			151566, -- Fiendish Leather
			124116, -- Felhide
			124115, -- Stormscale
			124113, -- Stonehide Leather
			112177, -- Nerubian Chitin Fragment
			112158, -- Icy Dragonscale Fragment
			112156, -- Blackened Dragonscale Fragment
			110611, -- Burnished Leather
			110610, -- Raw Beast Hide Scraps
			110609, -- Raw Beast Hide
			79101, -- Prismatic Scale
			72163, -- Magnificent Hide
			72162, -- Sha-Touched Leather
			72120, -- Exotic Leather
			56516, -- Heavy Savage Leather
			38558, -- Nerubian Chitin
			38557, -- Icy Dragonscale
			33568, -- Borean Leather
			33567, -- Borean Leather Scraps
			25649, -- Knothide Leather Scraps
			23793, -- Heavy Knothide Leather
			15416, -- Black Dragonscale
			15414, -- Red Dragonscale
			15412, -- Green Dragonscale
			15408, -- Heavy Scorpid Scale
			8170, -- Rugged Leather
			8169, -- Thick Hide
			8168, -- Jet Black Feather
			8165, -- Worn Dragonscale
			8154, -- Scorpid Scale
			8150, -- Deeprock Salt
			6471, -- Perfect Deviate Scale
			6470, -- Deviate Scale
			5785, -- Thick Murloc Scale
			5784, -- Slimy Murloc Scale
			5116, -- Long Tail Feather
			5082, -- Thin Kodo Leather
			4461, -- Raptor Hide
			4304, -- Thick Leather
			4235, -- Heavy Hide
			4234, -- Heavy Leather
			4232, -- Medium Hide
			2319, -- Medium Leather
			2318, -- Light Leather
			783, -- Light Hide
		},
		[7411] = { -- Enchanting
			152875, -- Gloom Dust
			152876, -- Umbra Shard
			152877, -- Veiled Crystal
			124442, -- Chaos Crystal
			124441, -- Leylight Shard
			124440, -- Arkhana
			111245, -- Luminous Shard
			113588, -- Temporal Crystal
			115504, -- Fractured Temporal Crystal
			115502, -- Small Luminous Shard
			109693, -- Draenic Dust
			105718, -- Sha Crystal Fragment
			102218, -- Spirit of War
			94289, -- Haunting Spirit
			80433, -- Blood Spirit
			74248, -- Sha Crystal
			74247, -- Ethereal Shard
			74250, -- Mysterious Essence
			74252, -- Small Ethereal Shard
			74249, -- Spirit Dust
			52721, -- Heavenly Shard
			52720, -- Small Heavenly Shard
			52722, -- Maelstrom Crystal
			52719, -- Greater Celestial Essence
			52555, -- Hypnotic Dust
			52718, -- Lesser Celestial Essence
			89738, -- Essence or Dust
			34053, -- Small Dream Shard
			34052, -- Dream Shard
			34057, -- Abyss Crystal
			34055, -- Greater Cosmic Essence
			34054, -- Infinite Dust
			22449, -- Large Prismatic Shard
			22450, -- Void Crystal
			34056, -- Lesser Cosmic Essence
			22446, -- Greater Planar Essence
			22448, -- Small Prismatic Shard
			22445, -- Arcane Dust
			20725, -- Nexus Crystal
			22447, -- Lesser Planar Essence
			14344, -- Large Brilliant Shard
			16203, -- Greater Eternal Essence
			16204, -- Illusion Dust
			14343, -- Small Brilliant Shard
			16202, -- Lesser Eternal Essence
			11176, -- Dream Dust
			11178, -- Large Radiant Shard
			11175, -- Greater Nether Essence
			11174, -- Lesser Nether Essence
			11177, -- Small Radiant Shard
			11139, -- Large Glowing Shard
			11137, -- Vision Dust
			11135, -- Greater Mystic Essence
			11134, -- Lesser Mystic Essence
			11138, -- Small Glowing Shard
			11082, -- Greater Astral Essence
			11084, -- Large Glimmering Shard
			11083, -- Soul Dust
			10998, -- Lesser Astral Essence
			10978, -- Small Glimmering Shard
			10939, -- Greater Magic Essence
			10940, -- Strange Dust
			10938, -- Lesser Magic Essence
			6218, -- Runed Copper Rod
			6217, -- Copper Rod
		},
		[2366] = { -- Herbalism
			152505, -- Riverbud
			152506, -- Star Moss
			152507, -- Akunda's Bite
			152508, -- Winter's Kiss
			152509, -- Siren's Pollen
			152510, -- Anchor Weed
			152511, -- Sea Stalk
			151565, -- Astral Glory
			129289, -- Felwort Seed
			129288, -- Starlight Rose Seed
			129287, -- Fjarnskaggl Seed
			129286, -- Foxflower Seed
			129285, -- Dreamleaf Seed
			129284, -- Aethril Seed
			128304, -- Yseralline Seed
			124106, -- Felwort
			124105, -- Starlight Rose
			124104, -- Fjarnskaggl
			124103, -- Foxflower
			124102, -- Dreamleaf
			124101, -- Aethril
			116053, -- Draenic Seeds
			109629, -- Talador Orchid Petal
			109628, -- Nagrand Arrowbloom Petal
			109627, -- Starflower Petal
			109626, -- Gorgrond Flytrap Ichor
			109625, -- Broken Fireweed Stem
			109624, -- Broken Frostweed Stem
			109129, -- Talador Orchid
			109128, -- Nagrand Arrowbloom
			109127, -- Starflower
			109126, -- Gorgrond Flytrap
			109125, -- Fireweed
			109124, -- Frostweed
			108365, -- Whiptail Stem
			108364, -- Twilight Jasmine Petal
			108363, -- Heartblossom Petal
			108362, -- Azshara's Veil Stem
			108361, -- Stormvine Stalk
			108360, -- Cinderbloom Petal
			108359, -- Fire Leaf Bramble
			108358, -- Deadnettle Bramble
			108357, -- Talandra's Rose Petal
			108356, -- Icethorn Bramble
			108355, -- Lichbloom Stalk
			108354, -- Tiger Lily Petal
			108353, -- Adder's Tongue Stem
			108352, -- Goldclover Leaf
			108351, -- Mana Thistle Leaf
			108350, -- Nightmare Vine Stem
			108349, -- Netherbloom Leaf
			108348, -- Ancient Lichen Petal
			108347, -- Terocone Leaf
			108346, -- Ragveil Cap
			108345, -- Dreaming Glory Petal
			108344, -- Felweed Stalk
			108343, -- Icecap Petal
			108342, -- Sorrowmoss Leaf
			108341, -- Mountain Silversage Stalk
			108340, -- Golden Sansam Leaf
			108339, -- Dreamfoil Blade
			108338, -- Gromsblood Leaf
			108337, -- Ghost Mushroom Cap
			108336, -- Blindweed Stem
			108335, -- Sungrass Stalk
			108334, -- Arthas' Tears Petal
			108333, -- Purple Lotus Petal
			108332, -- Firebloom Petal
			108331, -- Goldthorn Bramble
			108330, -- Stranglekelp Blade
			108329, -- Dragon's Teeth Stem
			108328, -- Fadeleaf Petal
			108327, -- Grave Moss Leaf
			108326, -- Khadgar's Whisker Stem
			108325, -- Liferoot Stem
			108324, -- Kingsblood Petal
			108323, -- Wild Steelbloom Petal
			108322, -- Bruiseweed Stem
			108321, -- Swiftthistle Leaf
			108320, -- Briarthorn Bramble
			108319, -- Earthroot Stem
			108318, -- Mageroyal Petal
			97624, -- Desecrated Herb Pod
			97623, -- Fool's Cap Spores
			97622, -- Snow Lily Petal
			97621, -- Silkweed Stem
			97620, -- Rain Poppy Petal
			97619, -- Torn Green Tea Leaf
			79011, -- Fool's Cap
			79010, -- Snow Lily
			72238, -- Golden Lotus
			72237, -- Rain Poppy
			72235, -- Silkweed
			72234, -- Green Tea Leaf
			52988, -- Whiptail
			52987, -- Twilight Jasmine
			52986, -- Heartblossom
			52985, -- Azshara's Veil
			52984, -- Stormvine
			52983, -- Cinderbloom
			39970, -- Fire Leaf
			37921, -- Deadnettle
			36908, -- Frost Lotus
			36907, -- Talandra's Rose
			36906, -- Icethorn
			36905, -- Lichbloom
			36904, -- Tiger Lily
			36903, -- Adder's Tongue
			36902, -- Constrictor Grass
			36901, -- Goldclover
			22797, -- Nightmare Seed
			22794, -- Fel Lotus
			22793, -- Mana Thistle
			22792, -- Nightmare Vine
			22791, -- Netherbloom
			22790, -- Ancient Lichen
			22789, -- Terocone
			22788, -- Flame Cap
			22787, -- Ragveil
			22786, -- Dreaming Glory
			22785, -- Felweed
			22710, -- Bloodthistle
			19727, -- Blood Scythe
			19726, -- Bloodvine
			13468, -- Black Lotus
			13467, -- Icecap
			13466, -- Sorrowmoss
			13465, -- Mountain Silversage
			13464, -- Golden Sansam
			13463, -- Dreamfoil
			8846, -- Gromsblood
			8845, -- Ghost Mushroom
			8839, -- Blindweed
			8838, -- Sungrass
			8836, -- Arthas' Tears
			8831, -- Purple Lotus
			8153, -- Wildvine
			4625, -- Firebloom
			3821, -- Goldthorn
			3820, -- Stranglekelp
			3819, -- Dragon's Teeth
			3818, -- Fadeleaf
			3369, -- Grave Moss
			3358, -- Khadgar's Whisker
			3357, -- Liferoot
			3356, -- Kingsblood
			3355, -- Wild Steelbloom
			2453, -- Bruiseweed
			2452, -- Swiftthistle
			2450, -- Briarthorn
			2449, -- Earthroot
			2447, -- Peacebloom
			785, -- Mageroyal
			765, -- Silverleaf
		},
		[7620] = { -- Fishing
			162515, -- Midnight Salmon
			152543, -- Sand Shifter
			152544, -- Slimy Mackerel
			152545, -- Frenzied Fangtooth
			152546, -- Lane Snapper
			152547, -- Great Sea Catfish
			152548, -- Tiragarde Perch
			152549, -- Redtail Loach
		},
		[2550] = { -- Cooking
			152631, -- briny-flesh
			154897, -- stringy-loins
			154898, -- meaty-haunch
			154899, -- dickes-paleosteak
			160711, -- aromatic-fish-oil
			163782, -- cursed-haunch
		},
	},
}

constants.itemCategories = {
	["world_events"] = BATTLE_PET_SOURCE_7,
	["pvp"] = PVP,
	["others"] = MISCELLANEOUS,
	["professions"] = TRADE_SKILLS,
}

constants.events = {
	"PLAYER_REGEN_ENABLED",
	"PLAYER_REGEN_DISABLED",
	"PET_BATTLE_OPENING_START",
	"PET_BATTLE_CLOSE",
	"BATTLEFIELDS_SHOW",
	"BATTLEFIELDS_CLOSED",
	"BAG_UPDATE",
	"TRADE_CURRENCY_CHANGED",
	"ARTIFACT_UPDATE",
	"ARTIFACT_XP_UPDATE",
	"TRADE_PLAYER_ITEM_CHANGED",
	"PLAYER_TRADE_CURRENCY",
	"CHAT_MSG_CURRENCY",
	"SHIPMENT_CRAFTER_REAGENT_UPDATE",
	"CURRENCY_DISPLAY_UPDATE",
	-- Money
	"PLAYER_MONEY",
	"PLAYER_TRADE_MONEY",
	"TRADE_MONEY_CHANGED",
	"SEND_MAIL_MONEY_CHANGED",
	"SEND_MAIL_COD_CHANGED",
	"TRIAL_STATUS_UPDATE",
	"CHAT_MSG_MONEY",
}
