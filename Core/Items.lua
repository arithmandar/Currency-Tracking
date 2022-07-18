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

local items = {}
private.items = items

local WoWClassicEra, WoWClassicTBC, WoWWOTLKC, WoWRetail
local wowversion  = select(4, GetBuildInfo())
if wowversion < 20000 then
	WoWClassicEra = true
elseif wowversion < 30000 then 
	WoWClassicTBC = true
elseif wowversion < 40000 then 
	WoWWOTLKC = true
elseif wowversion > 90000 then
	WoWRetail = true
else
	-- n/a
end


items.relics = {
	190189, -- Sandworn Relic, 9.2.0.42423
	174768, -- Cursed Relic
	174767, -- Mogu Relic
	174766, -- Mantid Relic
	174765, -- Tol'vir Relic
	174764, -- Tol'vir Relic Fragment
	174761, -- Aqir Relic
	174760, -- Mantid Relic Fragment
	174759, -- Mogu Relic Fragment
	174758, -- Voidwarped Relic Fragment
	174756, -- Aqir Relic Fragment
}
items.professions = {
	[3908] = { -- Tailoring: Cloth
		-- 9.2.5 Eternity's End

		-- Shadowland
		187703, -- Silken Protofiber, 9.2.0.42423
		173202, -- Shrouded Cloth
		173204, -- Lightless Silk
		172439, -- Enchanted Lightless Silk
		-- RoA
		167738, -- Gilded Seaweave
		-- BfA
		158378, -- Embroidered Deep Sea Satin
		152577, -- Deep Sea Satin
		152576, -- Tidespray Linen
		-- Legion
		151567, -- Lightweave Cloth
		146711, -- Bolt of Starweave
		146710, -- Bolt of Shadowcloth
		127681, -- Sharp Spritethorn
		127037, -- Runic Catgut
		127004, -- Imbued Silkweave
		124437, -- Shal'dorei Silk
		-- WoD
		111557, -- Sumptuous Fur
		111556, -- Hexweave Cloth
		-- MoP
		98619, -- Celestial Cloth
		92960, -- Silkworm Cocoon
		82447, -- Imperial Silk
		82441, -- Bolt of Windwool Cloth
		72988, -- Windwool Cloth
		-- Catalysm
		54440, -- Dreamcloth
		53643, -- Bolt of Embersilk Cloth
		53010, -- Embersilk Cloth
		--WotLK
		42253, -- Iceweb Spider Silk
		41595, -- Spellweave
		41594, -- Moonshroud
		41593, -- Ebonweave
		41511, -- Bolt of Imbued Frostweave
		41510, -- Bolt of Frostweave
		33470, -- Frostweave Cloth
		-- BC
		24272, -- Shadowcloth
		24271, -- Spellcloth
		21881, -- Netherweb Spider Silk
		21877, -- Netherweave Cloth
		21845, -- Primal Mooncloth
		21844, -- Bolt of Soulcloth
		21842, -- Bolt of Imbued Netherweave
		21840, -- Bolt of Netherweave
		-- Classic
		14342, -- Mooncloth
		14256, -- Felcloth
		14227, -- Ironweb Spider Silk
		14048, -- Bolt of Runecloth
		14047, -- Runecloth
		10285, -- Shadow Silk
		4339, -- Bolt of Mageweave
		4338, -- Mageweave Cloth
		4337, -- Thick Spider's Silk
		4306, -- Silk Cloth
		4305, -- Bolt of Silk Cloth
		3182, -- Spider's Silk
		2997, -- Bolt of Woolen Cloth
		2996, -- Bolt of Linen Cloth
		2592, -- Wool Cloth
		2589, -- Linen Cloth
	},
	[2575] = { -- Mining: Metal & Stone
		-- Shadowland
		180733, -- Luminous Flux
		171428, -- Shadowghast Ingot
		171828, -- Laestrite Ore
		171829, -- Solenium Ore
		171830, -- Oxxein Ore
		171831, -- Phaedrum Ore
		171832, -- Sinvyr Ore
		171833, -- Elethium Ore
		171834, -- Laestrite Nugget
		171835, -- Solenium Nugget
		171836, -- Oxxein Nugget
		171837, -- Phaedrum Nugget
		171838, -- Sinvyr Nugget
		171839, -- Elethium Nugget
		171840, -- Porous Stone
		171841, -- Shaded Stone
		-- RoA
		168185, -- Osmenite Ore
		-- BfA
		152513, -- Platinum Ore
		152512, -- Monelite Ore
		152579, -- Storm Silver Ore
		-- Legion
		151564, -- Empyrium
		124461, -- Demonsteel Bar
		124444, -- Infernal Brimstone
		123919, -- Felslate
		123918, -- Leystone Ore
		-- WoD
		115508, -- Draenic Stone
		109992, -- Blackrock Fragment
		109991, -- True Iron Nugget
		109119, -- True Iron Ore
		109118, -- Blackrock Ore
		108445, -- Draenic Coal
		108391, -- Titanium Ore Nugget
		108309, -- Pyrite Ore Nugget
		108308, -- Elementium Ore Nugget
		108307, -- Obsidium Ore Nugget
		108306, -- Saronite Ore Nugget
		108305, -- Cobalt Ore Nugget
		108304, -- Khorium Ore Nugget
		108303, -- Eternium Ore Nugget
		108302, -- Adamantite Ore Nugget
		108301, -- Fel Iron Ore Nugget
		108300, -- Mithril Ore Nugget
		108299, -- Truesilver Ore Nugget
		108298, -- Thorium Ore Nugget
		108297, -- Iron Ore Nugget
		108296, -- Gold Ore Nugget
		108295, -- Tin Ore Nugget
		108294, -- Silver Ore Nugget
		108257, -- Truesteel Ingot
		-- MoP
		97546, -- Kyparite Fragment
		97512, -- Ghost Iron Nugget
		72104, -- Living Steel, Alchemy
		72103, -- White Trillium Ore
		72096, -- Ghost Iron Bar
		72095, -- Trillium Bar, Alchemy
		72094, -- Black Trillium Ore
		72093, -- Kyparite
		72092, -- Ghost Iron Ore
		-- Cayaclysm
		65365, -- Folded Obsidium
		58480, -- Truegold, Alchemy
		54849, -- Obsidium Bar
		53039, -- Hardened Elementium Bar
		53038, -- Obsidium Ore
		52186, -- Elementium Bar
		52185, -- Elementium Ore
		52183, -- Pyrite Ore
		51950, -- Pyrium Bar, Alchemy
		-- WolTK
		41163, -- Titanium Bar, Alchemy
		37663, -- Titansteel Bar
		36916, -- Cobalt Bar
		36913, -- Saronite Bar
		36912, -- Saronite Ore
		36910, -- Titanium Ore
		36909, -- Cobalt Ore
		-- BC
		35128, -- Hardened Khorium
		23573, -- Hardened Adamantite Bar
		23449, -- Khorium Bar
		23448, -- Felsteel Bar
		23447, -- Eternium Bar
		23446, -- Adamantite Bar
		23445, -- Fel Iron Bar
		23427, -- Eternium Ore
		23426, -- Khorium Ore
		23425, -- Adamantite Ore
		23424, -- Fel Iron Ore
		-- Classic
		22203, -- Large Obsidian Shard
		22202, -- Small Obsidian Shard
		18567, -- Elemental Flux
		18562, -- Elementium Ingot
		17771, -- Enchanted Elementium Bar
		17203, -- Sulfuron Ingot
		12809, -- Guardian Stone
		12655, -- Enchanted Thorium Bar
		12365, -- Dense Stone
		12359, -- Thorium Bar
		11371, -- Dark Iron Bar
		11370, -- Dark Iron Ore
		10620, -- Thorium Ore
		7912, -- Solid Stone
		7911, -- Truesilver Ore
		6037, -- Truesilver Bar
		3857, -- Coal
		3577, -- Gold Bar
		3576, -- Tin Bar
		3575, -- Iron Bar
		3860, -- Mithril Bar
		3859, -- Steel Bar
		3858, -- Mithril Ore
		2842, -- Silver Bar
		2841, -- Bronze Bar
		2840, -- Copper Bar
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
		-- Shadowland
		187701, -- Protogenic Pelt
--			177281, --  Heavy Sorrowscale
		177279, --  Gaunt Sinew
		172438, --  Enchanted Heavy Desolate Hide
		172333, --  Purified Leather
		172332, --  Necrotic Leather
		172331, --  Sinful Leather
		172330, --  Unseelie Leather
		172097, --  Heavy Desolate Hide
		172096, --  Heavy Desolate Leather
		172095, --  Desolate Hide Scraps
		172094, --  Desolate Hide
		172093, --  Desolate Leather Scraps
		172092, --  Pallid Bone
		172090, --  Sorrowscale Fragment
		172089, --  Desolate Leather
		-- RoA
		168649, -- Dredged Leather
		168650, -- Cragscale
		-- BfA
--			164978, -- Mallet of Thunderous Skins, not quite a "gathered" item to be tracked
		152542, -- Hardened Tempest Hide
		153051, -- Mistscale
		154165, -- Calcified Bone
		154722, -- Tempest Hide
		152541, -- Coarse Leather
		153050, -- Shimmerscale
		154164, -- Blood-Stained Bone
		-- Legion
		151566, -- Fiendish Leather
		124116, -- Felhide
		124115, -- Stormscale
		124113, -- Stonehide Leather
		-- WoD
		112185, --  Wind Scale Fragment
		112184, --  Cobra Scale Fragment
		112183, --  Nether Dragonscale Fragment
		112182, --  Patch of Fel Hide
		112181, --  Fel Scale Fragment
		112180, --  Patch of Crystal Infused Leather
		112179, --  Patch of Thick Clefthoof Leather
		112178, --  Jormungar Scale Fragment
		112177, --  Nerubian Chitin Fragment
		112158, --  Icy Dragonscale Fragment
		112157, --  Prismatic Scale Fragment
		112156, --  Blackened Dragonscale Fragment
		112155, --  Deepsea Scale Fragment
		110611, --  Burnished Leather
		110610, --  Raw Beast Hide Scraps
		110609, --  Raw Beast Hide
		-- MoP
		79101, -- Prismatic Scale
		72163, -- Magnificent Hide
		72162, -- Sha-Touched Leather
		72120, -- Exotic Leather
		-- Catalysm
		56516, --  Heavy Savage Leather
		52982, --  Deepsea Scale
		52980, --  Pristine Hide
		52979, --  Blackened Dragonscale
		52977, --  Savage Leather Scraps
		52976, --  Savage Leather
		-- WotLK			
		44128, --  Arctic Fur
		38425, --  Heavy Borean Leather
		33568, --  Borean Leather
		38557, --  Icy Dragonscale
		38558, --  Nerubian Chitin
		38561, --  Jormungar Scale
		33567, --  Borean Leather Scraps
		-- BC
		29548, --  Nether Dragonscales
		29547, --  Wind Scales
		29539, --  Cobra Scales
		25708, --  Thick Clefthoof Leather
		25707, --  Fel Hide
		25700, --  Fel Scales
		25699, --  Crystal Infused Leather
		25649, --  Knothide Leather Scraps
		23793, --  Heavy Knothide Leather
		21887, --  Knothide Leather
		-- Classic
		20381, --  Dreamscale
		19768, --  Primal Tiger Leather
		19767, --  Primal Bat Leather
		17967, --  Refined Scale of Onyxia
		17012, --  Core Leather
		15419, --  Warbear Leather
		15417, --  Devilsaur Leather
		15416, --  Black Dragonscale
		15415, --  Blue Dragonscale
		15414, --  Red Dragonscale
		15412, --  Green Dragonscale
		15410, --  Scale of Onyxia
		15408, --  Heavy Scorpid Scale
		15407, --  Cured Rugged Hide
		12810, --  Enchanted Leather
		8172, --  Cured Thick Hide
		8171, --  Rugged Hide
		8170, --  Rugged Leather
		8169, --  Thick Hide
		8168, --  Jet Black Feather
		8167, --  Turtle Scale
		8165, --  Worn Dragonscale
		8154, --  Scorpid Scale
		7392, --  Green Whelp Scale
		7286, --  Black Whelp Scale
		6471, --  Perfect Deviate Scale
		6470, --  Deviate Scale
		5785, --  Thick Murloc Scale
		5784, --  Slimy Murloc Scale
		5116, --  Long Tail Feather
		5082, --  Thin Kodo Leather
		4461, --  Raptor Hide
		4304, --  Thick Leather
		4236, --  Cured Heavy Hide
		4235, --  Heavy Hide
		4234, --  Heavy Leather
		4233, --  Cured Medium Hide
		4232, --  Medium Hide
		4231, --  Cured Light Hide
		2934, --  Ruined Leather Scraps
		2319, --  Medium Leather
		2318, --  Light Leather
		783, --  Light Hide
	},
	[7411] = { -- Enchanting
		-- Shadowland
		172232, -- Eternal Crystal
		172230, -- Soul Dust
		172231, -- Sacred Shard
		-- RoA
		164766, -- Iwen's Enchanting Rod
		-- BfA
--			152882, -- Runed Norgal Rod
		152877, -- Veiled Crystal
		152876, -- Umbra Shard
		152875, -- Gloom Dust
		-- Legion
		156930, -- Rich Illusion Dust
		124442, -- Chaos Crystal
		124441, -- Leylight Shard
		124440, -- Arkhana
		-- WoD
		115504, -- Fractured Temporal Crystal
		115502, -- Small Luminous Shard
		113588, -- Temporal Crystal
		111245, -- Luminous Shard
		109693, -- Draenic Dust
		-- MoP
		105718, -- Sha Crystal Fragment
		102218, -- Spirit of War
		94289, -- Haunting Spirit
		89738, -- Essence or Dust
		80433, -- Blood Spirit
		74252, -- Small Ethereal Shard
		74250, -- Mysterious Essence
		74249, -- Spirit Dust
		74248, -- Sha Crystal
		74247, -- Ethereal Shard
		-- Cataclysm
		52722, -- Maelstrom Crystal
		52721, -- Heavenly Shard
		52720, -- Small Heavenly Shard
		52719, -- Greater Celestial Essence
		52718, -- Lesser Celestial Essence
		52555, -- Hypnotic Dust
		-- WolTK
		34057, -- Abyss Crystal
		34056, -- Lesser Cosmic Essence
		34055, -- Greater Cosmic Essence
		34054, -- Infinite Dust
		34053, -- Small Dream Shard
		34052, -- Dream Shard
		-- BC
		22450, -- Void Crystal
		22449, -- Large Prismatic Shard
		22448, -- Small Prismatic Shard
		22447, -- Lesser Planar Essence
		22446, -- Greater Planar Essence
		22445, -- Arcane Dust
		-- Classic
		20725, -- Nexus Crystal
		16204, -- Light Illusion Dust
		16203, -- Greater Eternal Essence
		16202, -- Lesser Eternal Essence
		14344, -- Large Brilliant Shard
		14343, -- Small Brilliant Shard
		11178, -- Large Radiant Shard
		11176, -- Dream Dust
		11175, -- Greater Nether Essence
		11174, -- Lesser Nether Essence
		10943, -- Strange Dust
		10939, -- Greater Magic Essence
		10938, -- Lesser Magic Essence
	},
	[2366] = { -- Herbalism
		-- Shadowland
		187699, -- First Flower
		170554, -- Vigil's Torch
		171287, -- Ground Death Blossom
		171288, -- Ground Vigil's Torch
		171289, -- Ground Widowbloom
		171290, -- Ground Marrowroot
		171291, -- Ground Rising Glory
		171292, -- Ground Nightshade
		-- RoA
		168487, -- Zin'anthid
		-- BfA
		152505, -- Riverbud
		152506, -- Star Moss
		152507, -- Akunda's Bite
		152508, -- Winter's Kiss
		152509, -- Siren's Pollen
		152510, -- Anchor Weed
		152511, -- Sea Stalk
		-- Legion
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
		-- WoD
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
		-- MoP
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
		-- Cayaclysm
		52988, -- Whiptail
		52987, -- Twilight Jasmine
		52986, -- Heartblossom
		52985, -- Azshara's Veil
		52984, -- Stormvine
		52983, -- Cinderbloom
		-- WolTK
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
		-- BC
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
		-- Classic
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
	[25229] = { -- Jewelcrafting
		-- Shadowland
		173108, -- Oriblase
		173109, -- Angerseye
		173110, -- Umbryl
		173168, -- Laestrite Setting
		173170, -- Essence of Rebirth
		173171, -- Essence of Torment
		173172, -- Essence of Servitude
		173173, -- Essence of Valor
		187532, -- Soulfire Chisel
		
		-- RoA
		168190, -- Lava Lazuli
		168188, -- Sage Agate
		168193, -- Azsharine
		168635, -- Leviathan's Eye
		168191, -- Sea Currant
		168189, -- Dark Opal
		168192, -- Sand Spinel
		
		154125, -- Royal Quartz
		154124, -- Laribole
		154123, -- Amberblaze
		154122, -- Tidal Amethyst
		154121, -- Scarlet Diamond
		154120, -- Owlseye
		153706, -- Kraken's Eye
		153705, -- Kyanite
		153704, -- Viridium
		153703, -- Solstone
		153702, -- Kubiline
		153701, -- Rubellite
		153700, -- Golden Beryl
		151722, -- Florid Malachite
		151721, -- Hesselian
		151720, -- Chemirine
		151719, -- Lightsphene
		151718, -- Argulite
		151579, -- Labradorite
		130245, -- Saber's Eye
		130183, -- Shadowruby
		130182, -- Maelstrom Sapphire
		130181, -- Pandemonite
		130180, -- Dawnlight
		130179, -- Eye of Prophecy
		130178, -- Furystone
		130177, -- Queen's Opal
		130176, -- Skystone
		130175, -- Chaotic Spinel
		130174, -- Azsunite
		130173, -- Deep Amber
		130172, -- Sangrite
		129100, -- Gem Chip
		76734, -- Serpent's Eye
		76142, -- Sun's Radiance
		76141, -- Imperial Amethyst
		76140, -- Vermilion Onyx
		76139, -- Wild Jade
		76138, -- River's Heart
		76137, -- Alexandrite
		76136, -- Pandarian Garnet
		76135, -- Roguestone
		76134, -- Sunstone
		76133, -- Lapis Lazuli
		76132, -- Primal Diamond
		76131, -- Primordial Ruby
		76130, -- Tiger Opal
		71810, -- Elven Peridot
		71809, -- Shadow Spinel
		71808, -- Lava Coral
		71807, -- Deepholm Iolite
		71806, -- Lightstone
		71805, -- Queen's Garnet
		52303, -- Shadowspirit Diamond
		52196, -- Chimera's Eye
		52195, -- Amberjewel
		52194, -- Demonseye
		52193, -- Ember Topaz
		52192, -- Dream Emerald
		52191, -- Ocean Sapphire
		52190, -- Inferno Ruby
		52182, -- Jasper
		52181, -- Hessonite
		52180, -- Nightstone
		52179, -- Alicite
		52178, -- Zephyrite
		52177, -- Carnelian
		42225, -- Dragon's Eye
		41334, -- Earthsiege Diamond
		41266, -- Skyflare Diamond
		36934, -- Eye of Zul
		36933, -- Forest Emerald
		36932, -- Dark Jade
		36931, -- Ametrine
		36930, -- Monarch Topaz
		36929, -- Huge Citrine
		36928, -- Dreadstone
		36927, -- Twilight Opal
		36926, -- Shadow Crystal
		36925, -- Majestic Zircon
		36924, -- Sky Sapphire
		36923, -- Chalcedony
		36922, -- King's Amber
		36921, -- Autumn's Glow
		36920, -- Sun Crystal
		36919, -- Cardinal Ruby
		36918, -- Scarlet Ruby
		36917, -- Bloodstone
		36784, -- Siren's Tear
		36783, -- Northsea Pearl
		32249, -- Seaspray Emerald
		32231, -- Pyrestone
		32230, -- Shadowsong Amethyst
		32229, -- Lionseye
		32228, -- Empyrean Sapphire
		32227, -- Crimson Spinel
		31079, -- Mercurial Adamantite
		25868, -- Skyfire Diamond
		25867, -- Earthstorm Diamond
		24479, -- Shadow Pearl
		24478, -- Jaggal Pearl
		24243, -- Adamantite Powder
		23441, -- Nightseye
		23440, -- Dawnstone
		23439, -- Noble Topaz
		23438, -- Star of Elune
		23437, -- Talasite
		23436, -- Living Ruby
		23117, -- Azure Moonstone
		23112, -- Golden Draenite
		23107, -- Shadow Draenite
		23079, -- Deep Peridot
		23077, -- Blood Garnet
		21929, -- Flame Spessarite
		21752, -- Thorium Setting
		20963, -- Mithril Filigree
		20817, -- Bronze Setting
		20816, -- Delicate Copper Wire
		13926, -- Golden Pearl
		12800, -- Azerothian Diamond
		12799, -- Large Opal
		12364, -- Huge Emerald
		12363, -- Arcane Crystal
		12361, -- Blue Sapphire
		11382, -- Blood of the Mountain
		7971, -- Black Pearl
		7910, -- Star Ruby
		7909, -- Aquamarine
		5500, -- Iridescent Pearl
		5498, -- Small Lustrous Pearl
		3864, -- Citrine
		1705, -- Lesser Moonstone
		1529, -- Jade
		1210, -- Shadowgem
		1206, -- Moss Agate
		818, -- Tigerseye
		774, -- Malachite
	},
	[4036] = { -- Engineering
		-- Shadowland
		183950, -- Distilled Death Extract
		172934, -- Handful of Laestrite Bolts
		172935, -- Porous Polishing Abrasive
		172936, -- Mortal Coiled Spring
		172937, -- Wormfed Gear Assembly
		
		-- RoA
		169470, -- Pressure Relief Valve
		167649, -- Hundred-Fathom Lure
		167064, -- 500S-Cybergenic Powercore
		168483, -- Protocol Transference Device
		167158, -- Pascal-K1N6's Proprietary Gizmo-matic			
		
		163569, -- Insulated Wiring
		161137, -- Blast-Fired Electric Servomotor
		161136, -- Azerite Forged Protection Plating
		161132, -- Crush Resistant Stabilizer
		161131, -- Barely Stable Azerite Reactor
		160502, -- Chemical Blasting Cap
		144329, -- Hardened Felglass
		140785, -- Hardened Circuitboard Plating
		140784, -- Fel Piston Stabilizer
		140783, -- Predictive Combat Operations Databank
		140782, -- Neural Net Detangler
		140781, -- X-87 Battle Circuit
		136638, -- True Iron Barrel
		136637, -- Oversized Blasting Cap
		136636, -- Sniping Scope
		136633, -- Loose Trigger
		111366, -- Gearspring Parts
		98717, -- Balanced Trillium Ingot
		94113, -- Jard's Peculiar Energy Source
		94111, -- Lightning Steel Ingot
		90146, -- Tinker's Kit
		77468, -- High-Explosive Gunpowder
		77467, -- Ghost Iron Bolts
		67749, -- Electrified Ether
		61981, -- Inferno Ink
		60224, -- Handful of Obsidium Bolts
		52188, -- Jeweler's Setting
		44501, -- Goblin-Machined Piston
		44500, -- Elementium-Plated Exhaust Pipe
		44499, -- Salvaged Iron Golem Parts
		40533, -- Walnut Stock
		39690, -- Volatile Blasting Trigger
		39684, -- Hair Trigger
		39683, -- Froststeel Tube
		39682, -- Overcharged Capacitor
		39681, -- Handful of Cobalt Bolts
		32423, -- Icy Blasting Primers
		23787, -- Felsteel Stabilizer
		23786, -- Khorium Power Core
		23785, -- Hardened Adamantite Tube
		23784, -- Adamantite Frame
		23783, -- Handful of Fel Iron Bolts
		23782, -- Fel Iron Casing
		23781, -- Elemental Blasting Powder
		18631, -- Truesilver Transformer
		17056, -- Light Feather
		16006, -- Delicate Arcanite Converter
		16000, -- Thorium Tube
		15994, -- Thorium Widget
		15992, -- Dense Blasting Powder
		10647, -- Engineer's Ink
		10561, -- Mithril Casing
		10560, -- Unstable Trigger
		10559, -- Mithril Tube
		10558, -- Gold Power Core
		10505, -- Solid Blasting Powder
		9061, -- Goblin Rocket Fuel
		9060, -- Inlaid Mithril Cylinder
		7191, -- Fused Wiring
		7071, -- Iron Buckle
		4611, -- Blue Pearl
		4404, -- Silver Contact
		4400, -- Heavy Stock
		4399, -- Wooden Stock
		4389, -- Gyrochronatom
		4387, -- Iron Strut
		4382, -- Bronze Framework
		4377, -- Heavy Blasting Powder
		4375, -- Whirring Bronze Gizmo
		4371, -- Bronze Tube
		4364, -- Coarse Blasting Powder
		4359, -- Handful of Copper Bolts
		4357, -- Rough Blasting Powder
		814, -- Flask of Oil
	},
	[2259] = { -- Alchemy
		-- Shadowland
		184090, -- Potion of the Psychopomp's Speed
		183942, -- Novice Crafter's Mark
		183823, -- Potion of Unhindered Passing
		182072, -- Bramblethorn Juice
		182071, -- Refined Submission
		182048, -- Crushed Bones
		182047, -- Brutal Oil
		182026, -- Pulverized Breezebloom
		182025, -- Distilled Resolve
		181984, -- Powdered Dreamroot
		181983, -- Liquid Sleep
		181859, -- Flask of Measured Discipline
		181858, -- Draught of Grotesque Strength
		181857, -- Elixir of Humility
		181375, -- Potion of Hibernal Rest
		180457, -- Shadestone
		176811, -- Potion of Sacrificial Anima
		173384, -- Crafter's Mark of the Chained Isle
		173383, -- Crafter's Mark III
		173382, -- Crafter's Mark II
		173381, -- Crafter's Mark I
		171428, -- Shadowghast Ingot
		171370, -- Potion of Specter Swiftness
		171352, -- Potion of Empowered Exorcisms
		171351, -- Potion of Deathly Fixation
		171350, -- Potion of Divine Awakening
		171349, -- Potion of Phantom Fire
		171301, -- Spiritual Anti-Venom
		171292, -- Ground Nightshade
		171291, -- Ground Rising Glory
		171290, -- Ground Marrowroot
		171289, -- Ground Widowbloom
		171288, -- Ground Vigil's Torch
		171287, -- Ground Death Blossom
		171286, -- Embalmer's Oil
		171285, -- Shadowcore Oil
		171284, -- Eternal Cauldron
		171278, -- Spectral Flask of Stamina
		171276, -- Spectral Flask of Power
		171275, -- Potion of Spectral Strength
		171274, -- Potion of Spectral Stamina
		171273, -- Potion of Spectral Intellect
		171272, -- Potion of Spiritual Clarity
		171270, -- Potion of Spectral Agility
		171269, -- Spiritual Rejuvenation Potion
		171268, -- Spiritual Mana Potion
		171267, -- Spiritual Healing Potion
		171266, -- Potion of the Hidden Spirit
		171264, -- Potion of Shaded Sight
		171263, -- Potion of Soul Purity
		-- BfA
		169451, -- Abyssal Healing Potion
		169300, -- Potion of Wild Mending
		169299, -- Potion of Unbridled Fury
		168656, -- Greater Mystical Cauldron
		168654, -- Greater Flask of the Undertow
		168653, -- Greater Flask of the Vast Horizon
		168652, -- Greater Flask of Endless Fathoms
		168651, -- Greater Flask of the Currents
		168529, -- Potion of Empowered Proximity
		168506, -- Potion of Focused Resolve
		168500, -- Superior Battle Potion of Strength
		168499, -- Superior Battle Potion of Stamina
		168498, -- Superior Battle Potion of Intellect
		168489, -- Superior Battle Potion of Agility
		166270, -- Potion of the Unveiling Eye
		163225, -- Battle Potion of Stamina
		163224, -- Battle Potion of Strength
		163223, -- Battle Potion of Agility
		163222, -- Battle Potion of Intellect
		163082, -- Coastal Rejuvenation Potion
		162519, -- Mystical Cauldron
		162461, -- Sanguicell
		162460, -- Hydrocore
		162113, -- Potion of Herb Tracking
		152668, -- Expulsom
		152641, -- Flask of the Undertow
		152640, -- Flask of the Vast Horizon
		152639, -- Flask of Endless Fathoms
		152638, -- Flask of the Currents
		152615, -- Astral Healing Potion
		152561, -- Potion of Replenishment
		152560, -- Potion of Bursting Blood
		152559, -- Potion of Rising Death
		152550, -- Sea Mist Potion
		152503, -- Potion of Concealment
		152497, -- Lightfoot Potion
		152496, -- Demitri's Draught of Deception
		152495, -- Coastal Mana Potion
		152494, -- Coastal Healing Potion
		151609, -- Tears of the Naaru
		151608, -- Lightblood Elixir
		151568, -- Primal Sargerite
		
		142117, -- Potion of Prolonged Power
		141323, -- Wild Transmutation
		136653, -- Silvery Salve
		128159, -- Elemental Distillate
		128158, -- Wildswater
		127851, -- Spirit Cauldron
		127850, -- Flask of Ten Thousand Scars
		127849, -- Flask of the Countless Armies
		127848, -- Flask of the Seventh Demon
		127847, -- Flask of the Whispered Pact
		127846, -- Leytorrent Potion
		127844, -- Potion of the Old War
		127843, -- Potion of Deadly Grace
		127841, -- Skystep Potion
		127840, -- Skaggldrynk
		127839, -- Avalanche Elixir
		127838, -- Sylvan Elixir
		127837, -- Draught of Raw Magic
		127836, -- Ancient Rejuvenation Potion
		127835, -- Ancient Mana Potion
		127834, -- Ancient Healing Potion
		124124, -- Blood of Sargeras
		118711, -- Draenic Water Walking Elixir
		118704, -- Pure Rage Potion
		118700, -- Secret of Draenor Alchemy
		118472, -- Savage Blood
		116981, -- Fire Ammonite Oil
		116979, -- Blackwater Anti-Venom
		116276, -- Draenic Living Action Potion
		116271, -- Draenic Water Breathing Elixir
		116268, -- Draenic Invisibility Potion
		116266, -- Draenic Swiftness Potion
		113264, -- Sorcerous Air
		113263, -- Sorcerous Earth
		113262, -- Sorcerous Water
		113261, -- Sorcerous Fire
		112090, -- Transmorphic Tincture
		109226, -- Draenic Rejuvenation Potion
		109223, -- Healing Tonic
		109222, -- Draenic Mana Potion
		109221, -- Draenic Channeled Mana Potion
		109220, -- Draenic Versatility Potion
		109219, -- Draenic Strength Potion
		109218, -- Draenic Intellect Potion
		109217, -- Draenic Agility Potion
		109160, -- Greater Draenic Stamina Flask
		109156, -- Greater Draenic Strength Flask
		109155, -- Greater Draenic Intellect Flask
		109153, -- Greater Draenic Agility Flask
		109152, -- Draenic Stamina Flask
		109148, -- Draenic Strength Flask
		109147, -- Draenic Intellect Flask
		109145, -- Draenic Agility Flask
		109123, -- Crescent Oil
		108996, -- Alchemical Catalyst
		93705, -- Nimble Wild Jade
		93351, -- Potion of Luck
		87872, -- Desecrated Oil
		76701, -- Mystic Sun's Radiance
		76698, -- Subtle Sun's Radiance
		76697, -- Smooth Sun's Radiance
		76684, -- Etched Imperial Amethyst
		76682, -- Veiled Imperial Amethyst
		76675, -- Lucent Vermilion Onyx
		76672, -- Artful Vermilion Onyx
		76669, -- Fierce Vermilion Onyx
		76667, -- Wicked Vermilion Onyx
		76660, -- Potent Vermilion Onyx
		76659, -- Crafty Vermilion Onyx
		76658, -- Deadly Vermilion Onyx
		76657, -- Steady Wild Jade
		76652, -- Jagged Wild Jade
		76648, -- Turbid Wild Jade
		76637, -- Stormy River's Heart
		76142, -- Sun's Radiance
		76141, -- Imperial Amethyst
		76140, -- Vermilion Onyx
		76139, -- Wild Jade
		76138, -- River's Heart
		76132, -- Primal Diamond
		76131, -- Primordial Ruby
		76098, -- Master Mana Potion
		76097, -- Master Healing Potion
		76096, -- Darkwater Potion
		76095, -- Potion of Mogu Power
		76094, -- Alchemist's Rejuvenation
		76093, -- Potion of the Jade Serpent
		76092, -- Potion of Focus
		76089, -- Virmen's Bite
		76088, -- Flask of Winter's Bite
		76087, -- Flask of the Earth
		76086, -- Flask of Falling Leaves
		76085, -- Flask of the Warm Sun
		76084, -- Flask of Spring Blossoms
		76083, -- Monk's Elixir
		76081, -- Elixir of Mirrors
		76080, -- Elixir of Perfection
		76079, -- Elixir of Peace
		76078, -- Elixir of the Rapids
		76077, -- Elixir of Weaponry
		76076, -- Mad Hozen Elixir
		72104, -- Living Steel
		72095, -- Trillium Bar
		68357, -- Lucent Ember Topaz
		67438, -- Flask of Flowing Water
		67415, -- Draught of War
		65460, -- Big Cauldron of Battle
		62288, -- Cauldron of Battle
		58489, -- Potion of Illusion
		58488, -- Potion of Treasure Finding
		58487, -- Potion of Deepholm
		58480, -- Truegold
		58148, -- Elixir of the Master
		58146, -- Golemblood Potion
		58145, -- Potion of the Tol'vir
		58144, -- Elixir of Mighty Speed
		58143, -- Prismatic Elixir
		58142, -- Deathblood Venom
		58094, -- Elixir of Impossible Accuracy
		58092, -- Elixir of the Cobra
		58091, -- Volcanic Potion
		58089, -- Elixir of the Naga
		58088, -- Flask of Titanic Strength
		58087, -- Flask of the Winds
		58086, -- Flask of the Draconic Mind
		58085, -- Flask of Steelskin
		58084, -- Ghost Elixir
		57194, -- Potion of Concentration
		57193, -- Mighty Rejuvenation Potion
		57192, -- Mythical Mana Potion
		57191, -- Mythical Healing Potion
		57099, -- Mysterious Potion
		56850, -- Deepstone Oil
		54464, -- Random Volatile Element
		52303, -- Shadowspirit Diamond
		52247, -- Subtle Amberjewel
		52246, -- Stormy Ocean Sapphire
		52245, -- Steady Dream Emerald
		52241, -- Smooth Amberjewel
		52239, -- Potent Ember Topaz
		52227, -- Nimble Dream Emerald
		52226, -- Mystic Amberjewel
		52223, -- Jagged Dream Emerald
		52217, -- Veiled Demonseye
		52214, -- Fierce Ember Topaz
		52213, -- Etched Demonseye
		52209, -- Deadly Ember Topaz
		52205, -- Artful Ember Topaz
		52195, -- Amberjewel
		52194, -- Demonseye
		52193, -- Ember Topaz
		52192, -- Dream Emerald
		52191, -- Ocean Sapphire
		52190, -- Inferno Ruby
		51950, -- Pyrium Bar
		46379, -- Flask of Stoneblood
		46378, -- Flask of Pure Mojo
		46377, -- Flask of Endless Rage
		46376, -- Flask of the Frost Wyrm
		45621, -- Elixir of Minor Accuracy
		44958, -- Ethereal Oil
		44332, -- Elixir of Mighty Thoughts
		44331, -- Elixir of Lightning Speed
		44330, -- Elixir of Armor Piercing
		44329, -- Elixir of Expertise
		44327, -- Elixir of Deadly Strikes
		44325, -- Elixir of Accuracy
		41334, -- Earthsiege Diamond
		41266, -- Skyflare Diamond
		41163, -- Titanium Bar
		40217, -- Mighty Shadow Protection Potion
		40216, -- Mighty Nature Protection Potion
		40215, -- Mighty Frost Protection Potion
		40214, -- Mighty Fire Protection Potion
		40213, -- Mighty Arcane Protection Potion
		40212, -- Potion of Wild Magic
		40211, -- Potion of Speed
		40195, -- Pygmy Oil
		40173, -- Turbid Eye of Zul
		40168, -- Steady Eye of Zul
		40166, -- Nimble Eye of Zul
		40165, -- Jagged Eye of Zul
		40153, -- Veiled Dreadstone
		40152, -- Potent Ametrine
		40149, -- Lucent Ametrine
		40147, -- Deadly Ametrine
		40146, -- Fierce Ametrine
		40143, -- Etched Dreadstone
		40127, -- Mystic King's Amber
		40124, -- Smooth King's Amber
		40122, -- Stormy Majestic Zircon
		40115, -- Subtle King's Amber
		40109, -- Elixir of Mighty Mageblood
		40087, -- Powerful Rejuvenation Potion
		40081, -- Potion of Nightmares
		40079, -- Lesser Flask of Toughness
		40078, -- Elixir of Mighty Fortitude
		40077, -- Crazy Alchemist's Potion
		40076, -- Guru's Elixir
		40073, -- Elixir of Mighty Strength
		40072, -- Elixir of Versatility
		40070, -- Spellpower Elixir
		40068, -- Wrath Elixir
		40067, -- Icy Mana Potion
		39671, -- Resurgent Healing Potion
		39666, -- Elixir of Mighty Agility
		36934, -- Eye of Zul
		36931, -- Ametrine
		36928, -- Dreadstone
		36925, -- Majestic Zircon
		36922, -- King's Amber
		36919, -- Cardinal Ruby
		36860, -- Eternal Fire
		35627, -- Eternal Shadow
		35625, -- Eternal Life
		35624, -- Eternal Earth
		35623, -- Eternal Air
		35622, -- Eternal Water
		34440, -- Mad Alchemist's Potion
		33448, -- Runic Mana Potion
		33447, -- Runic Healing Potion
		32852, -- Cauldron of Major Shadow Protection
		32851, -- Cauldron of Major Nature Protection
		32850, -- Cauldron of Major Frost Protection
		32849, -- Cauldron of Major Fire Protection
		32839, -- Cauldron of Major Arcane Protection
		32068, -- Elixir of Ironskin
		32067, -- Elixir of Draenic Wisdom
		32063, -- Earthen Elixir
		32062, -- Elixir of Major Fortitude
		31679, -- Fel Strength Elixir
		31677, -- Fel Mana Potion
		31676, -- Fel Regeneration Potion
		28104, -- Elixir of Mastery
		28103, -- Adept's Elixir
		28102, -- Onslaught Elixir
		28101, -- Unstable Mana Potion
		28100, -- Volatile Healing Potion
		25899, -- Brutal Earthstorm Diamond
		25868, -- Skyfire Diamond
		25867, -- Earthstorm Diamond
		23571, -- Primal Might
		22871, -- Shrouding Potion
		22866, -- Flask of Pure Death
		22861, -- Flask of Blinding Light
		22854, -- Flask of Relentless Assault
		22853, -- Flask of Mighty Versatility
		22851, -- Flask of Fortification
		22850, -- Super Rejuvenation Potion
		22848, -- Elixir of Empowerment
		22847, -- Major Holy Protection Potion
		22846, -- Major Shadow Protection Potion
		22845, -- Major Arcane Protection Potion
		22844, -- Major Nature Protection Potion
		22842, -- Major Frost Protection Potion
		22841, -- Major Fire Protection Potion
		22840, -- Elixir of Major Mageblood
		22839, -- Destruction Potion
		22838, -- Haste Potion
		22837, -- Heroic Potion
		22836, -- Major Dreamless Sleep Potion
		22835, -- Elixir of Major Shadow Power
		22833, -- Elixir of Major Firepower
		22832, -- Super Mana Potion
		22831, -- Elixir of Major Agility
		22830, -- Elixir of the Searching Eye
		22829, -- Super Healing Potion
		22828, -- Insane Strength Potion
		22827, -- Elixir of Major Frost Power
		22826, -- Sneaking Potion
		22825, -- Elixir of Healing Power
		22824, -- Elixir of Major Strength
		22823, -- Elixir of Camouflage
		22457, -- Primal Mana
		22456, -- Primal Shadow
		22452, -- Primal Earth
		22451, -- Primal Air
		21886, -- Primal Life
		21885, -- Primal Water
		21884, -- Primal Fire
		21546, -- Elixir of Greater Firepower
		20008, -- Living Action Potion
		20007, -- Mageblood Elixir
		20004, -- Mighty Troll's Blood Elixir
		20002, -- Greater Dreamless Sleep Potion
		19440, -- Powerful Anti-Venom
		18294, -- Elixir of Greater Water Breathing
		18253, -- Major Rejuvenation Potion
		17708, -- Elixir of Frost Power
		13512, -- Flask of Supreme Power
		13511, -- Flask of Distilled Wisdom
		13510, -- Flask of the Titans
		13506, -- Potion of Petrification
		13462, -- Purification Potion
		13461, -- Greater Arcane Protection Potion
		13459, -- Greater Shadow Protection Potion
		13458, -- Greater Nature Protection Potion
		13457, -- Greater Fire Protection Potion
		13456, -- Greater Frost Protection Potion
		13454, -- Greater Arcane Elixir
		13453, -- Elixir of Brute Force
		13452, -- Elixir of the Mongoose
		13447, -- Elixir of the Sages
		13446, -- Major Healing Potion
		13444, -- Major Mana Potion
		13443, -- Superior Mana Potion
		13442, -- Mighty Rage Potion
		13423, -- Stonescale Oil
		12808, -- Essence of Undeath
		12803, -- Living Essence
		12360, -- Arcanite Bar
		12190, -- Dreamless Sleep Potion
		10592, -- Catseye Elixir
		9264, -- Elixir of Shadow Power
		9233, -- Elixir of Detect Demon
		9224, -- Elixir of Demonslaying
		9210, -- Ghost Dye
		9206, -- Elixir of Giants
		9197, -- Elixir of Dream Vision
		9187, -- Elixir of Greater Agility
		9179, -- Elixir of Greater Intellect
		9172, -- Invisibility Potion
		9155, -- Arcane Elixir
		9154, -- Elixir of Detect Undead
		9144, -- Wildvine Potion
		9088, -- Gift of Arthas
		9061, -- Goblin Rocket Fuel
		9030, -- Restorative Potion
		8956, -- Oil of Immolation
		8949, -- Elixir of Agility
		8827, -- Elixir of Water Walking
		7082, -- Essence of Air
		7080, -- Essence of Water
		7078, -- Essence of Fire
		7076, -- Essence of Earth
		7068, -- Elemental Fire
		6662, -- Elixir of Giant Growth
		6453, -- Strong Anti-Venom
		6452, -- Anti-Venom
		6373, -- Elixir of Firepower
		6372, -- Swim Speed Potion
		6371, -- Fire Oil
		6370, -- Blackmouth Oil
		6149, -- Greater Mana Potion
		6052, -- Nature Protection Potion
		6051, -- Holy Protection Potion
		6050, -- Frost Protection Potion
		6049, -- Fire Protection Potion
		6048, -- Shadow Protection Potion
		6037, -- Truesilver Bar
		5997, -- Elixir of Minor Defense
		5996, -- Elixir of Water Breathing
		5634, -- Free Action Potion
		5633, -- Great Rage Potion
		5631, -- Rage Potion
		4596, -- Discolored Healing Potion
		3928, -- Superior Healing Potion
		3829, -- Frost Oil
		3828, -- Elixir of Detect Lesser Invisibility
		3827, -- Mana Potion
		3826, -- Major Troll's Blood Elixir
		3825, -- Elixir of Fortitude
		3824, -- Shadow Oil
		3823, -- Lesser Invisibility Potion
		3577, -- Gold Bar
		3391, -- Elixir of Ogre's Strength
		3390, -- Elixir of Lesser Agility
		3388, -- Strong Troll's Blood Elixir
		3387, -- Limited Invulnerability Potion
		3386, -- Potion of Curing
		3385, -- Lesser Mana Potion
		3383, -- Elixir of Wisdom
		3382, -- Weak Troll's Blood Elixir
		2459, -- Swiftness Potion
		2458, -- Elixir of Minor Fortitude
		2457, -- Elixir of Minor Agility
		2456, -- Minor Rejuvenation Potion
		2455, -- Minor Mana Potion
		2454, -- Elixir of Lion's Strength
		1710, -- Greater Healing Potion
		929, -- Healing Potion
		858, -- Lesser Healing Potion
		118, -- Minor Healing Potion
	},
	[2018] = { -- Blacksmithing
		-- Shadowland
		185960, -- Vestige of Origins
		183942, -- Novice Crafter's Mark
		182093, -- Soft Manacle Chains
		182092, -- Tempered Manacle Chains
		182090, -- Binding Cuffs
		182087, -- Soft Heavy Razor
		182086, -- Hardened Heavy Razor
		181792, -- Tarnished Kyrian Shield
		181791, -- Polished Kyrian Shield
		181790, -- Reforged Kyrian Shield
		181788, -- Unrefined Arrowheads
		181787, -- Molten Phaedrum
		181784, -- Bundle of Stalker Arrowheads
		180060, -- Relic of the Past V
		180059, -- Relic of the Past IV
		180058, -- Relic of the Past III
		180057, -- Relic of the Past II
		180055, -- Relic of the Past I
		173384, -- Crafter's Mark of the Chained Isle
		173383, -- Crafter's Mark III
		173382, -- Crafter's Mark II
		173381, -- Crafter's Mark I
		171441, -- Laestrite Skeleton Key
		171439, -- Shaded Weightstone
		171438, -- Porous Weightstone
		171437, -- Shaded Sharpening Stone
		171436, -- Porous Sharpening Stone
		171428, -- Shadowghast Ingot
		-- BfA
		162460, -- Hydrocore
		162461, -- Sanguicell
		168417, -- Inflatable Mount Shoes
		
		162120, -- Platinum Whetstone
		162115, -- Magnetic Mining Pick
		162109, -- Storm Silver Spurs
		159826, -- Monelite Skeleton Key
		152813, -- Monel-Hardened Stirrups
		152812, -- Monel-Hardened Hoofplates
		151923, -- Empyrial Rivet
		136708, -- Demonsteel Stirrups
		128777, -- Heated Leystone Bar
		128016, -- Steelforged Essence
		128015, -- Truesteel Essence
		127732, -- Savage Truesteel Essence
		127731, -- Savage Steelforged Essence
		127714, -- Mighty Truesteel Essence
		127713, -- Mighty Steelforged Essence
		124461, -- Demonsteel Bar
		124455, -- Masterwork Leystone Armguards
		124454, -- Brimstone-Crusted Armguards
		124453, -- Brimstone-Covered Armguards
		124450, -- Engraved Leystone Armguards
		124435, -- Leystone Neckplate
		124434, -- Handmade Leystone Helm
		124433, -- Handmade Leystone Boots
		124432, -- Leystone Dome
		124431, -- Leystone Faceguard
		124430, -- Leystone Soleplate
		124429, -- Leystone Footguard
		124428, -- Leystone Heelguard
		124427, -- Leystone Shinplate
		124424, -- Hard Leystone Nail
		124423, -- Heated Hard Leystone Ingot
		124422, -- Hard Leystone Ingot
		124421, -- Lump of Leystone Slag
		124420, -- Leystone Shard
		124419, -- Hard Leystone Bar
		124418, -- Leystone Slag
		124411, -- Scrapmetal Cuffplate
		124410, -- Scrapmetal Handguard
		124409, -- Scrapmetal Palmplate
		124408, -- Scrapmetal Fingerplates
		124407, -- Large Heated Metal Scrap
		124406, -- Medium Heated Metal Scrap
		124405, -- Small Heated Metal Scrap
		124397, -- Hard Leystone Armguards
		124396, -- Dull Hard Leystone Armguards
		124395, -- Heated Hard Leystone Bar
		124394, -- Hard Leystone Bar
		124393, -- Leystone Slag
		124049, -- Handcrafted Leystone Gauntlets
		124010, -- Leystone Fingerguard
		124009, -- Leystone Cuffplate
		124007, -- Leystone Bar
		123956, -- Leystone Hoofplates
		118720, -- Secret of Draenor Blacksmithing
		116654, -- Truesteel Grinder
		116428, -- Truesteel Reshaper
		108257, -- Truesteel Ingot
		98717, -- Balanced Trillium Ingot
		94111, -- Lightning Steel Ingot
		90046, -- Living Steel Belt Buckle
		86599, -- Ghost Iron Shield Spike
		86597, -- Living Steel Weapon Chain
		82960, -- Ghostly Skeleton Key
		65365, -- Folded Obsidium
		55057, -- Pyrium Weapon Chain
		55056, -- Pyrium Shield Spike
		55055, -- Elementium Shield Spike
		55054, -- Ebonsteel Belt Buckle
		55053, -- Obsidium Skeleton Key
		44936, -- Titanium Plating
		43854, -- Cobalt Skeleton Key
		43853, -- Titanium Skeleton Key
		42500, -- Titanium Shield Spike
		41976, -- Titanium Weapon Chain
		41611, -- Eternal Belt Buckle
		33185, -- Adamantite Weapon Chain
		28421, -- Adamantite Weightstone
		28420, -- Fel Weightstone
		25521, -- Greater Rune of Warding
		23576, -- Greater Ward of Shielding
		23575, -- Lesser Ward of Shielding
		23559, -- Lesser Rune of Warding
		23530, -- Felsteel Shield Spike
		23529, -- Adamantite Sharpening Stone
		23528, -- Fel Sharpening Stone
		18262, -- Elemental Sharpening Stone
		15872, -- Arcanite Skeleton Key
		15871, -- Truesilver Skeleton Key
		15870, -- Golden Skeleton Key
		15869, -- Silver Skeleton Key
		12645, -- Thorium Shield Spike
		12644, -- Dense Grinding Stone
		12643, -- Dense Weightstone
		12404, -- Dense Sharpening Stone
		9060, -- Inlaid Mithril Cylinder
		7967, -- Mithril Shield Spike
		7966, -- Solid Grinding Stone
		7965, -- Solid Weightstone
		7964, -- Solid Sharpening Stone
		7071, -- Iron Buckle
		6043, -- Iron Counterweight
		6042, -- Iron Shield Spike
		6041, -- Steel Weapon Chain
		3486, -- Heavy Grinding Stone
		3478, -- Coarse Grinding Stone
		3470, -- Rough Grinding Stone
		3241, -- Heavy Weightstone
		3240, -- Coarse Weightstone
		3239, -- Rough Weightstone
		2871, -- Heavy Sharpening Stone
		2863, -- Coarse Sharpening Stone
		2862, -- Rough Sharpening Stone
	},
	[7620] = { -- Fishing
		-- Shadowland
		171441, -- Laestrite Skeleton Key
		173032, -- Lost Sole
		173033, -- Iridescent Amberjack
		173037, -- Elysian Thade
		173192, -- Shrouded Cloth Bandage
		177025, -- Partially Eaten Fish
		177026, -- Lost Earring
		177028, -- Rusty Chain
		181387, -- Speckled Flametail
		
		-- 8.x.x
		174758, -- Voidwarped Relic Fragment
		174328, -- Aberrant Voidfin
		174327, -- Malformed Gnasher
		168646, -- Mauve Stinger
		168302, -- Viper Fish
		168262, -- Sentry Fish
		167562, -- Ionized Minnow
		166971, -- Empty Energy Cell
		166970, -- Energy Cell
		166846, -- Spare Parts
		166287, -- Silver Dawning Salvage
		164973, -- Severed Azurefin Head
		164972, -- Severed Crimsonscale Head
		162517, -- U'taka
		162516, -- Rasboralus
		162515, -- Midnight Salmon
		158771, -- Spirit Ichor
		157844, -- Iridescent Speck
		155609, -- Springy Eyeball
		152549, -- Redtail Loach
		152548, -- Tiragarde Perch
		152547, -- Great Sea Catfish
		152546, -- Lane Snapper
		152545, -- Frenzied Fangtooth
		152544, -- Slimy Mackerel
		152543, -- Sand Shifter
		152511, -- Sea Stalk
		152506, -- Star Moss
		152505, -- Riverbud
		
		139669, --  Ancient Black Barracuda
		139667, --  Axefish
		139666, --  Tainted Runescale Koi
		139664, --  Magic-Eater Frog
		139663, --  Thundering Stormray
		139662, --  Graybelly Lobster
		139661, --  Oodelfjisk
		139660, --  Ancient Highmountain Salmon
		139659, --  Coldriver Carp
		139658, --  Mountain Puffer
		139657, --  Ancient Mossgill
		139656, --  Thorned Flounder
		139655, --  Terrorfin
		139654, --  Ghostly Queenfish
		139653, --  Nar'thalas Hermit
		139652, --  Leyshimmer Blenny
		138967, --  Big Fountain Goldfish
		133742, --  Ancient Black Barracuda
		133740, --  Axefish
		133739, --  Tainted Runescale Koi
		133737, --  Magic-Eater Frog
		133736, --  Thundering Stormray
		133735, --  Graybelly Lobster
		133734, --  Oodelfjisk
		133733, --  Ancient Highmountain Salmon
		133732, --  Coldriver Carp
		133731, --  Mountain Puffer
		133730, --  Ancient Mossgill
		133729, --  Thorned Flounder
		133728, --  Terrorfin
		133727, --  Ghostly Queenfish
		133726, --  Nar'thalas Hermit
		133725, --  Leyshimmer Blenny
		133607, --  Silver Mackerel
		127994, --  Felmouth Frenzy Lunker
		127991, --  Felmouth Frenzy
		124669, --  Darkmoon Daggermaw
		124112, --  Black Barracuda
		124111, --  Runescale Koi
		124110, --  Stormray
		124109, --  Highmountain Salmon
		124108, --  Mossgill Perch
		124107, --  Cursed Queenfish
		122696, --  Sea Scorpion Lunker
		118565, --  Savage Piranha
		116822, --  Jawless Skulker Lunker
		116821, --  Fat Sleeper Lunker
		116820, --  Blind Lake Lunker
		116819, --  Fire Ammonite Lunker
		116818, --  Abyssal Gulper Lunker
		116817, --  Blackwater Whiptail Lunker
		111676, --  Enormous Jawless Skulker
		111675, --  Enormous Fat Sleeper
		111674, --  Enormous Blind Lake Sturgeon
		111673, --  Enormous Fire Ammonite
		111672, --  Enormous Sea Scorpion
		111671, --  Enormous Abyssal Gulper Eel
		111670, --  Enormous Blackwater Whiptail
		111669, --  Jawless Skulker
		111668, --  Fat Sleeper
		111667, --  Blind Lake Sturgeon
		111666, --  Fire Ammonite
		111665, --  Sea Scorpion
		111664, --  Abyssal Gulper Eel
		111663, --  Blackwater Whiptail
		111662, --  Small Blackwater Whiptail
		111659, --  Small Abyssal Gulper Eel
		111658, --  Small Sea Scorpion
		111656, --  Small Fire Ammonite
		111652, --  Small Blind Lake Sturgeon
		111651, --  Small Fat Sleeper
		111650, --  Small Jawless Skulker
		111601, --  Enormous Crescent Saberfish
		111595, --  Crescent Saberfish
		111589, --  Small Crescent Saberfish
		74866, --  Golden Carp
		74865, --  Krasarang Paddlefish
		74864, --  Reef Octopus
		74863, --  Jewel Danio
		74861, --  Tiger Gourami
		74860, --  Redbelly Mandarin
		74859, --  Emperor Salmon
		74857, --  Giant Mantis Shrimp
		74856, --  Jade Lungfish
		62778, --  Toughened Flesh
		53072, --  Deepsea Sagefish
		53071, --  Algaefin Rockfish
		53070, --  Fathom Eel
		53069, --  Murglesnout
		53068, --  Lavascale Catfish
		53067, --  Striped Lurker
		53066, --  Blackbelly Mudfish
		53065, --  Albino Cavefish
		53064, --  Highland Guppy
		53063, --  Mountain Trout
		53062, --  Sharptooth
		43652, --  Slippery Eel
		43647, --  Shimmering Minnow
		43646, --  Fountain Goldfish
		43572, --  Magic Eater
		43571, --  Sewer Carp
		41814, --  Glassfin Minnow
		41813, --  Nettlefish
		41812, --  Barrelhead Goby
		41810, --  Fangtooth Herring
		41809, --  Glacial Salmon
		41808, --  Bonescale Snapper
		41807, --  Dragonfin Angelfish
		41806, --  Musselback Sculpin
		41805, --  Borean Man O' War
		41803, --  Rockfin Grouper
		41802, --  Imperial Manta Ray
		41801, --  Moonglow Cuttlefish
		41800, --  Deep Sea Monsterbelly
		37588, --  Mostly Digested Fish
		35285, --  Giant Sunfish
		33824, --  Crescent-Tail Skullfish
		33823, --  Bloodfin Catfish
		27439, --  Furious Crawdad
		27438, --  Golden Darter
		27437, --  Icefin Bluefish
		27435, --  Figluster's Mudfish
		27429, --  Zangarian Sporefish
		27425, --  Spotted Feltail
		27422, --  Barbed Gill Trout
		23676, --  Moongraze Stag Tenderloin
		21153, --  Raw Greater Sagefish
		21071, --  Raw Sagefish
		13889, --  Raw Whitescale Salmon
		13888, --  Darkclaw Lobster
		13760, --  Raw Sunscale Salmon
		13759, --  Raw Nightfin Snapper
		13758, --  Raw Redgill
		13756, --  Raw Summer Bass
		13754, --  Raw Glossy Mightfish
		8365, --  Raw Mithril Head Trout
		6362, --  Raw Rockscale Cod
		6361, --  Raw Rainbow Fin Albacore
		6317, --  Raw Loch Frenzy
		6308, --  Raw Bristle Whisker Catfish
		6303, --  Raw Slitherskin Mackerel
		6291, --  Raw Brilliant Smallfish
		6289, --  Raw Longjaw Mud Snapper
		4603, --  Raw Spotted Yellowtail
	},
	[2550] = { -- Cooking
		-- Shadowland
		184624, -- Extra Sugary Fish Feast
		184682, -- Extra Lemony Herb Filet
		184690, -- Extra Fancy Darkmoon Feast
		186704, -- Twilight Tea
		186725, -- Bonemeal Bread
		186726, -- Porous Rock Candy
		-- 8.x.x
		174352, -- Baked Voidfin
		174351, -- K'Bab
		174350, -- Dubious Delight
		174349, -- Ghastly Goulash
		174348, -- Grilled Gnasher
		169449, -- Mecha-Bytes
		169280, -- Unagi Skewer
		168315, -- Famine Evaluator And Snack Table
		168314, -- Bil'Tong
		168313, -- Baked Port Tato
		168312, -- Fragrant Kakavia
		168311, -- Abyssal-Fried Rissole
		168310, -- Mech-Dowel's "Big Mech"
		166804, -- Boralus Blood Sausage
		
		166344, -- Seasoned Steak and Potatoes
		166343, -- Wild Berry Bread
		166240, -- Sanguinated Feast
		165755, -- Honey Potpie
		163781, -- Heartsbane Hexwurst
		156526, -- Bountiful Captain's Feast
		156525, -- Galley Banquet
		154891, -- Seasoned Loins
		154889, -- Grilled Catfish
		154888, -- Sailor's Pie
		154887, -- Loa Loaf
		154886, -- Spiced Snapper
		154885, -- Mon'Dazi
		154884, -- Swamp Fish 'n Chips
		154883, -- Ravenberry Tarts
		154882, -- Honey-Glazed Haunches
		154881, -- Kul Tiramisu
		152564, -- Feast of the Fishes
		142334, -- Spiced Falcosaur Omelet
		133681, -- Crispy Bacon
		133579, -- Lavish Suramar Feast
		133578, -- Hearty Feast
		133577, -- Fighter Chow
		133576, -- Bear Tartare
		133575, -- Dried Mackerel Strips
		133574, -- Fishbrul Special
		133573, -- Seed-Battered Fish Plate
		133572, -- Nightborne Delicacy Platter
		133571, -- Azshari Salad
		133570, -- The Hungry Magister
		133569, -- Drogbar-Style Salmon
		133568, -- Koi-Scented Stormray
		133567, -- Barracuda Mrglgagh
		133566, -- Suramar Surf and Turf
		133565, -- Leybeque Ribs
		133564, -- Spiced Rib Roast
		133563, -- Faronaar Fizz
		133562, -- Pickled Stormray
		133561, -- Deep-Fried Mossgill
		133557, -- Salt & Pepper Shank
		128498, -- Fel Eggs and Ham
		126936, -- Sugar-Crusted Fish Feast
		126935, -- Fancy Darkmoon Feast
		126934, -- Lemon Herb Filet
		122348, -- Buttered Sturgeon
		122347, -- Whiptail Fillet
		122346, -- Jumbo Sea Dog
		122345, -- Pickled Eel
		122344, -- Salty Squid Roll
		122343, -- Sleeper Sushi
		111458, -- Feast of the Waters
		111457, -- Feast of Blood
		111456, -- Grilled Saberfish
		111455, -- Saberfish Broth
		111454, -- Gorgrond Chowder
		111453, -- Calamari Crepes
		111452, -- Sleeper Surprise
		111450, -- Frosty Stew
		111449, -- Blackrock Barbecue
		111447, -- Talador Surf and Turf
		111446, -- Skulker Chowder
		111445, -- Fiery Calamari
		111444, -- Fat Sleeper Cakes
		111442, -- Sturgeon Stew
		111441, -- Grilled Gulper
		111439, -- Steamed Scorpion
		111438, -- Clefthoof Sausages
		111437, -- Rylak Crepes
		111436, -- Braised Riverbeast
		111434, -- Pan-Seared Talbuk
		111433, -- Blackrock Ham
		111431, -- Hearty Elekk Steak
		101750, -- Fluffy Silkfeather Omelet
		101749, -- Stuffed Lushrooms
		101748, -- Spiced Blossom Soup
		101747, -- Farmer's Delight
		101746, -- Seasoned Pomfruit Slices
		101745, -- Mango Ice
		101662, -- Pandaren Treasure Noodle Cart Kit
		101661, -- Deluxe Noodle Cart Kit
		101630, -- Noodle Cart Kit
		87264, -- Four Senses Brew
		87248, -- Great Banquet of the Brew
		87246, -- Banquet of the Brew
		87244, -- Great Banquet of the Oven
		87242, -- Banquet of the Oven
		87240, -- Great Banquet of the Steamer
		87238, -- Banquet of the Steamer
		87236, -- Great Banquet of the Pot
		87234, -- Banquet of the Pot
		87232, -- Great Banquet of the Wok
		87230, -- Banquet of the Wok
		87228, -- Great Banquet of the Grill
		87226, -- Banquet of the Grill
		86432, -- Banana Infused Rum
		86074, -- Spicy Vegetable Chips
		86073, -- Spicy Salmon
		86070, -- Wildfowl Ginseng Soup
		86069, -- Rice Pudding
		86057, -- Sliced Peaches
		86026, -- Perfectly Cooked Instant Noodles
		85504, -- Krasarang Fritters
		85501, -- Viseclaw Soup
		81414, -- Pearl Milk Tea
		81413, -- Skewered Peanut Chicken
		81412, -- Blanched Needle Mushrooms
		81411, -- Peach Pie
		81410, -- Green Curry Fish
		81409, -- Tangy Yogurt
		81408, -- Red Bean Bun
		81406, -- Roasted Barley Tea
		81405, -- Boiled Silkworm Pupa
		81404, -- Dried Needle Mushrooms
		81403, -- Dried Peaches
		81402, -- Toasted Fish Jerky
		81401, -- Yak Cheese Curds
		81400, -- Pounded Rice Cake
		75038, -- Mad Brewer's Breakfast
		75037, -- Jade Witch Brew
		75026, -- Ginseng Tea
		75016, -- Great Pandaren Banquet
		74919, -- Pandaren Banquet
		74656, -- Chun Tian Spring Rolls
		74655, -- Twin Fish Platter
		74654, -- Wildfowl Roast
		74653, -- Steamed Crab Surprise
		74652, -- Fire Spirit Salmon
		74651, -- Shrimp Dumplings
		74650, -- Mogu Fish Stew
		74649, -- Braised Turtle
		74648, -- Sea Mist Rice Noodles
		74647, -- Valley Stir Fry
		74646, -- Black Pepper Ribs and Shrimp
		74645, -- Eternal Blossom Fish
		74644, -- Swirling Mist Soup
		74643, -- Sauteed Carrots
		74642, -- Charbroiled Tiger Steak
		74641, -- Fish Cake
		74636, -- Golden Carp Consomme
		68687, -- Scalding Murglesnout
		67230, -- Venison Jerky
		62790, -- Darkbrew Lager
		62680, -- Chocolate Cookie
		62677, -- Fish Fry
		62676, -- Blackened Surprise
		62675, -- Starfire Espresso
		62674, -- Highland Spirits
		62673, -- Feathered Lure
		62672, -- South Island Iced Tea
		62671, -- Severed Sagefish Head
		62670, -- Beer-Basted Crocolisk
		62669, -- Skewered Eel
		62668, -- Blackbelly Sushi
		62667, -- Mushroom Sauce Mudfish
		62666, -- Delicious Sagefish Tail
		62665, -- Basilisk Liverdog
		62664, -- Crocolisk Au Gratin
		62663, -- Lavascale Minestrone
		62662, -- Grilled Dragon
		62661, -- Baked Rockfish
		62660, -- Pickled Guppy
		62659, -- Hearty Seafood Soup
		62658, -- Tender Baked Turtle
		62657, -- Lurker Lunch
		62656, -- Whitecrest Gumbo
		62655, -- Broiled Mountain Trout
		62654, -- Lavascale Fillet
		62653, -- Salted Eye
		62652, -- Seasoned Crab
		62651, -- Lightly Fried Lurker
		62649, -- Fortune Cookie
		62290, -- Seafood Magnifique Feast
		62289, -- Broiled Dragon Feast
		46691, -- Bread of the Dead
		45932, -- Black Jelly
		44953, -- Worg Tartare
		44840, -- Cranberry Chutney
		44839, -- Candied Sweet Potato
		44838, -- Slow-Roasted Turkey
		44837, -- Spice Bread Stuffing
		44836, -- Pumpkin Pie
		43492, -- Haunted Herring
		43491, -- Bad Clams
		43490, -- Tasty Cupcake
		43488, -- Last Week's Mammoth
		43480, -- Small Feast
		43478, -- Gigantic Feast
		43268, -- Dalaran Clam Chowder
		43015, -- Fish Feast
		43005, -- Spiced Mammoth Treats
		43004, -- Critter Bites
		43001, -- Tracker Snacks
		43000, -- Dragonfin Filet
		42999, -- Blackened Dragonfin
		42998, -- Cuttlesteak
		42997, -- Blackened Worg Steak
		42996, -- Snapper Extreme
		42995, -- Hearty Rhino
		42994, -- Rhinolicious Wormsteak
		42993, -- Spicy Fried Herring
		42942, -- Baked Manta Ray
		39520, -- Kungaloosh
		35565, -- Juicy Bear Burger
		35563, -- Charred Bear Kabobs
		34832, -- Captain Rumsey's Lager
		34769, -- Imperial Manta Steak
		34768, -- Spicy Blue Nettlefish
		34767, -- Firecracker Salmon
		34766, -- Poached Northern Sculpin
		34765, -- Pickled Fangtooth
		34764, -- Poached Nettlefish
		34763, -- Smoked Salmon
		34762, -- Grilled Sculpin
		34761, -- Sauteed Goby
		34760, -- Grilled Bonescale
		34759, -- Smoked Rockfin
		34758, -- Mighty Rhino Dogs
		34757, -- Very Burnt Worg
		34756, -- Spiced Worm Burger
		34755, -- Tender Shoveltusk Steak
		34754, -- Mega Mammoth Meal
		34753, -- Great Feast
		34752, -- Rhino Dogs
		34751, -- Roasted Worg
		34750, -- Worm Delight
		34749, -- Shoveltusk Steak
		34748, -- Mammoth Meal
		34747, -- Northern Stew
		34411, -- Hot Apple Cider
		33924, -- Delicious Chocolate Cake
		33874, -- Kibler's Bits
		33872, -- Spicy Hot Talbuk
		33867, -- Broiled Bloodfin
		33866, -- Stormchops
		33825, -- Skullfish Soup
		33053, -- Hot Buttered Trout
		33052, -- Fisherman's Feast
		33048, -- Stewed Trout
		33004, -- Clamlette Magnifique
		31673, -- Crunchy Serpent
		31672, -- Mok'Nathal Shortribs
		30816, -- Spice Bread
		30155, -- Clam Bar
		27667, -- Spicy Crawdad
		27666, -- Golden Fish Sticks
		27665, -- Poached Bluefish
		27664, -- Grilled Mudfish
		27663, -- Blackened Sporefish
		27662, -- Feltail Delight
		27661, -- Blackened Trout
		27660, -- Talbuk Steak
		27659, -- Warp Burger
		27658, -- Roasted Clefthoof
		27657, -- Blackened Basilisk
		27655, -- Ravager Dog
		27651, -- Buzzard Bites
		27636, -- Bat Bites
		27635, -- Lynx Steak
		24105, -- Roasted Moongraze Tenderloin
		22645, -- Crunchy Spider Surprise
		21217, -- Sagefish Delight
		21072, -- Smoked Sagefish
		21023, -- Dirge's Kickin' Chimaerok Chops
		20452, -- Smoked Desert Dumplings
		20074, -- Heavy Crocolisk Stew
		18254, -- Runn Tum Tuber Surprise
		18045, -- Tender Wolf Steak
		17222, -- Spider Sausage
		17198, -- Winter Veil Egg Nog
		17197, -- Gingerbread Cookie
		16766, -- Undermine Clam Chowder
		13935, -- Baked Salmon
		13934, -- Mightfish Steak
		13933, -- Lobster Stew
		13932, -- Poached Sunscale Salmon
		13931, -- Nightfin Soup
		13930, -- Filet of Redgill
		13929, -- Hot Smoked Bass
		13928, -- Grilled Squid
		13927, -- Cooked Glossy Mightfish
		13851, -- Hot Wolf Ribs
		12224, -- Crispy Bat Wing
		12218, -- Monster Omelet
		12217, -- Dragonbreath Chili
		12216, -- Spiced Chili Crab
		12215, -- Heavy Kodo Stew
		12214, -- Mystery Stew
		12213, -- Carrion Surprise
		12212, -- Jungle Stew
		12210, -- Roast Raptor
		12209, -- Lean Wolf Steak
		10841, -- Goldthorn Tea
		8364, -- Mithril Head Trout
		7676, -- Thistle Tea
		6890, -- Smoked Bear Meat
		6888, -- Herb Baked Egg
		6887, -- Spotted Yellowtail
		6657, -- Savory Deviate Delight
		6316, -- Loch Frenzy Delight
		6290, -- Brilliant Smallfish
		6038, -- Giant Clam Scorcho
		5527, -- Goblin Deviled Clams
		5526, -- Clam Chowder
		5525, -- Boiled Clams
		5480, -- Lean Venison
		5479, -- Crispy Lizard Tail
		5478, -- Dig Rat Stew
		5477, -- Strider Stew
		5476, -- Fillet of Frenzy
		5474, -- Roasted Kodo Meat
		5473, -- Scorpid Surprise
		5472, -- Kaldorei Spider Kabob
		5095, -- Rainbow Fin Albacore
		4594, -- Rockscale Cod
		4593, -- Bristle Whisker Catfish
		4592, -- Longjaw Mud Snapper
		4457, -- Barbecued Buzzard Wing
		3729, -- Soothing Turtle Bisque
		3728, -- Tasty Lion Steak
		3727, -- Hot Lion Chops
		3726, -- Big Bear Steak
		3666, -- Gooey Spider Cake
		3665, -- Curiously Tasty Omelet
		3664, -- Crocolisk Gumbo
		3663, -- Murloc Fin Soup
		3662, -- Crocolisk Steak
		3220, -- Blood Sausage
		2888, -- Beer Basted Boar Ribs
		2687, -- Dry Pork Ribs
		2685, -- Succulent Pork Ribs
		2684, -- Coyote Steak
		2683, -- Crab Cake
		2682, -- Cooked Crab Claw
		2681, -- Roasted Boar Meat
		2680, -- Spiced Wolf Meat
		2679, -- Charred Wolf Meat
		1082, -- Redridge Goulash
		1017, -- Seasoned Wolf Kabob
		787, -- Slitherskin Mackerel
		733, -- Westfall Stew
		724, -- Goretusk Liver Pie
	},
}
items.others = {
	191031, -- Packaged Soul Cinders
	190740, -- Automa Integration
	190739, -- Provis Wax
	190189, -- Sandworn Relic
	190182, -- Lovely Regal Pocopoc
	190129, -- Serene Pigment
	190128, -- Wayward Essence
	190098, -- Pepepec
	190096, -- Pocobold
	190062, -- Wicked Pocopoc
	190061, -- Admiral Pocopoc
	190060, -- Adventurous Pocopoc
	190059, -- Pirate Pocopoc
	190058, -- Peaceful Pocopoc
	189865, -- Anima Matrix
	189864, -- Anima Gossamer
	189544, -- Anima Webbing
	189451, -- Chef Pocopoc
	188957, -- Genesis Mote
	188673, -- Timebound Ruminations
	188657, -- Mind-Expanding Prism
	188656, -- Fractal Thoughtbinder
	188655, -- Crystalline Memory Repository
	188654, -- Grimoire of Knowledge
	188653, -- Grimoire of Knowledge
	188652, -- Grimoire of Knowledge
	188651, -- Grimoire of Knowledge
	188650, -- Grimoire of Knowledge
	188198, -- Traveler's Anima Cache
	-- 188168, -- zzOld Traveler's Anima Cache
	188005, -- Anima-Bathed Blade
	188004, -- Crate of Anima-Infused Parts
	188003, -- Crate of Revendreth Reserve
	188000, -- Grovetender's Pack
	187936, -- Mark of the Sable Ardenmoth
	187934, -- Mark of the Midnight Runestag
	187933, -- Mark of the Duskwing Raven
	187931, -- Mark of the Regal Dredbat
	187909, -- Unstable Containment Trap
	187908, -- Firim's Spare Forge-Tap
	187894, -- Energized Firmament
	187893, -- Volatile Precursor
	187892, -- Incorporeal Sand
	187891, -- Empyrean Essence
	187890, -- Anima-Charged Yolk
	187889, -- Unstable Agitant
	187888, -- Mark of the Shimmering Ardenmoth
	187887, -- Mark of the Gloomstalker Dredbat
	187885, -- Honeycombed Lattice
	187884, -- Mark of the Twilight Runestag
	187879, -- Pollinated Extraction
	187833, -- Dapper Pocopoc
	187822, -- A Defector's Request
	187791, -- Kismetric Circlet
	187790, -- Trace Enigmet
	187789, -- Eidolic Particles
	187728, -- Ephemera Strands
	187517, -- Animaswell Prism
	187478, -- White Razorwing Talon
	187467, -- Perplexing Rune-Cube
	187466, -- Korthian Cypher Book
	187465, -- Complicated Organism Harmonizer
	187463, -- Enigmatic Map Fragments
	187462, -- Scroll of Shadowlands Fables
	187460, -- Strangely Intricate Key
	187459, -- Vial of Mysterious Liquid
	187458, -- Unearthed Teleporter Sigil
	187457, -- Engraved Glass Pane
	187434, -- Lightseed Sapling
	187433, -- Windcrystal Chimes
	187421, -- Ashen Liniment
	187415, -- Mind-Expanding Prism
	187414, -- Fractal Thoughtbinder
	187413, -- Crystalline Memory Repository
	187350, -- Displaced Relic
	187349, -- Anima Laden Egg
	187347, -- Concentrated Anima
	187336, -- Forbidden Weapon Schematics
	187335, -- Maldraxxus Larva Shell
	187334, -- Shattered Void Tablet
	187333, -- Core of an Unknown Titan
	187332, -- Recovered Page of Voices
	187331, -- Tattered Fae Designs
	187330, -- Naaru Shard Fragment
	187329, -- Old God Specimen Jar
	187328, -- Ripped Cosmology Chart
	187327, -- Encrypted Korthian Journal
	187326, -- Half-Completed Runeforge Pattern
	187325, -- Faded Razorwing Anatomy Illustration
	187324, -- Gnawed Ancient Idol
	187323, -- Runic Diagram
	187322, -- Crumbling Stone Tablet
	187311, -- Azgoth's Tattered Maps
	187219, -- Attendant's Token of Merit
	187175, -- Runekeeper's Ingot
	187153, -- Tasty Mawshroom
	187112, -- Packaged Soul Ash (DNT)
	187077, -- Packaged Soul Ash
	187054, -- Lost Razorwing Egg
	186731, -- Repaired Riftkey
	186718, -- Teleporter Repair Kit
	186685, -- Relic Fragment
	186599, -- Stygian Ember
	186206, -- Vault Emberstone
	186204, -- Anima-Stained Glass Shards
	186203, -- Glowing Devourer Stomach
	186201, -- Ancient Anima Vessel
	186200, -- Infused Dendrite
	185974, -- Bahmeht Chain Link
	184776, -- Urn of Arena Soil
	184772, -- Ritual Maldracite Crystal
	184770, -- Roster of the Forgotten
	184766, -- Chronicles of the Paragons
	184765, -- Vesper Strikehammer
	184764, -- Colossus Actuator
	184763, -- Mnemis Neural Network
	184762, -- Fragmented Sorrow
	184761, -- Purified Misery
	184760, -- Quiescent Orb
	184688, -- Grimoire of Knowledge
	184687, -- Grimoire of Knowledge
	184686, -- Grimoire of Knowledge
	184685, -- Grimoire of Knowledge
	184684, -- Grimoire of Knowledge
	184519, -- Totem of Stolen Mojo
	184485, -- Mawforged Key
	184388, -- Plump Glitterroot
	184387, -- Misty Shimmerleaf
	184385, -- Fossilized Heartwood
	184382, -- Luminous Sylberry
	184381, -- Astral Sapwood
	184379, -- Queen's Frozen Tear
	184378, -- Faeweald Amber
	184374, -- Cartel Exchange Vessel
	184371, -- Vivacity of Collaboration
	184362, -- Reflections on Purity
	184360, -- Musings on Repetition
	184354, -- Soul Harvester Key
	184315, -- Multi-Modal Anima Container
	184307, -- Maldraxxi Armor Scraps
	184306, -- Soulcatching Sludge
	184305, -- Maldraxxi Champion's Armaments
	184293, -- Sanctified Skylight Leaf
	184286, -- Extinguished Soul Anima
	184169, -- Vault Chain Pull
	184149, -- Widowbloom-Infused Fragrance
	184148, -- Concealed Sinvyr Flask
	184147, -- Agony Enrichment Device
	184146, -- Singed Soul Shackles
	184051, -- Stitched Lich Effigy
	184050, -- Malleable Mesh
	184049, -- Counterfeit Luckydo
	184043, -- Lost Scroll
	183987, -- Prisoner Cage Key
	183939, -- Carefully Bottled Holy Water
	183873, -- Otherworldy Tea Set
	183804, -- Great Luckydo
	183790, -- Platter Master Stue
	183744, -- Superior Parts
	183734, -- Mysteriously Thrumming Orb
	183723, -- Brimming Anima Orb
	183596, -- Broken Artifact
	183519, -- Necromantic Oil
	183475, -- Indomitable Hide
	183200, -- Pitch Black Scourgestone
	182654, -- Bonescript Dispatches
	182599, -- Bucket of Clean Water
	182597, -- Comfortable Saddle Blanket
	182595, -- Sturdy Horseshoe
	182581, -- Handful of Oats
	182212, -- Magical Curio
	182211, -- Stone Brick
	182186, -- Stolen Memento
	181743, -- Plume of the Archon
	181650, -- Spellwarded Dissertation
	181649, -- Preserved Preternatural Braincase
	181648, -- Ziggurat Focusing Crystal
	181647, -- Stabilized Plague Strain
	181645, -- Engorged Monstrosity's Heart
	181644, -- Unlabeled Culture Jars
	181643, -- Weeping Corpseshroom
	181642, -- Novice Principles of Plaguistry
	181552, -- Collected Tithe
	181551, -- Depleted Stoneborn Heart
	181550, -- Hopebreaker's Field Injector
	181549, -- Timeworn Sinstone
	181548, -- Darkhaven Soul Lantern
	181547, -- Noble's Draught
	181545, -- Bloodbound Globule
	181544, -- Confessions of Misdeed
	181541, -- Celestial Acorn
	181479, -- Starlight Catcher
	181478, -- Cornucopia of the Winter Court
	181477, -- Ardendew Pearl
	181377, -- Illustrated Combat Meditation Aid
	181371, -- Spare Head
	181368, -- Centurion Power Core
	181166, -- Sigil of Haunting Memories
	180834, -- Renathal's Journal Pages
	180720, -- Darkened Scourgestone
	180595, -- Nightforged Steel
	180594, -- Calloused Bone
	180478, -- Champion's Pelt
	180477, -- Elysian Feathers
	180470, -- Wild Fungus
	180451, -- Grand Inquisitor's Sinstone Fragment
	180296, -- Shrouded Necromancer Head
	179928, -- Cell Chain Pull
	179295, -- Squeaky Bat
	178594, -- Anima-bound Wraps
	178061, -- Malleable Flesh
	177665, -- Spectral Handkerchief
	176804, -- Temp
	175752, -- Mirror Fragment
	175056, -- Waterborne Veterans Contract
	175054, -- Melee Veterans Contract
	175053, -- Ranged Veterans Contract
	175052, -- Mounted Veterans Contract
	175019, -- Holy Statuette
	175018, -- Shadowy Rune
	174971, -- Ripe Juicycrunch
	174891, -- Veteran Rajani Sparkcallers Contract
	174890, -- Veteran Ramkahen Lancers Contract
	174867, -- Shard of Corruption
	174858, -- Gersahl Greens
	174764, -- Tol'vir Relic Fragment
	174760, -- Mantid Relic Fragment
	174759, -- Mogu Relic Fragment
	174758, -- Voidwarped Relic Fragment
	174360, -- Shadowy Gem
	174049, -- Orb of Darkest Madness
	174048, -- Orb of Madness
	174047, -- Orb of Darkest Visions
	174046, -- Orb of Visions
	174045, -- Orb of Dark Portents
	172965, -- Sinstone Fragments
	171372, -- Alterac Valley Mark of Honor
	171347, -- Corrupted Bone Fragment
	171334, -- Void-Touched Cloth
	171206, -- Forgotten Weapon
	170500, -- Energy Cell
	170491, -- Burnt Journal Page
	170379, -- Sunwarmed Sand
	170193, -- Sea Totem
	170174, -- Muck Slime
	170170, -- Fermented Deviate Fish
	169898, -- Well Lurker
	169897, -- Thin Air Flounder
	169884, -- Green Roughy
	169870, -- Displaced Scrapfin
	169765, -- Worldvein Intelligence Reports
	169764, -- Worldvein Intelligence Reports
	169665, -- Cleansed Remains
	169610, -- S.P.A.R.E. Crate
	169334, -- Strange Oceanic Sediment
	169333, -- Strange Volcanic Rock
	169332, -- Strange Mineralized Water
	169295, -- Dormant Vision Stone
	169293, -- Coalescing Visions
	169106, -- Thin Jelly
	168832, -- Galvanic Oscillator
	168828, -- Royal Jelly
	168825, -- Rich Jelly
	168822, -- Thin Jelly
	168802, -- Nazjatar Battle Commendation
	168630, -- Chitterspine Meat
	168327, -- Chain Ignitercoil
	168160, -- Jeweled Scarab Figurine
	168152, -- Miniaturized Power Core
	168142, -- Coagulated Miasma
	168139, -- Long Regal Sinew
	168138, -- Spirit of the Bested
	168135, -- Titan's Blood
	168134, -- Fine Azerite Powder
	168127, -- Lingering Drust Essence
	167730, -- Inconspicuous Catfish
	167729, -- Deceptive Maw
	167728, -- Queen's Delight
	167727, -- Deadeye Wally
	167726, -- Quiet Floater
	167725, -- Spiritual Salmon
	167724, -- Tortollan Tank Dweller
	167723, -- Thunderous Flounder
	167722, -- Prisoner Fish
	167721, -- Invisible Smelt
	167720, -- Very Tiny Whale
	167719, -- Golden Sunsoaker
	167718, -- Collectable Saltfin
	167717, -- Camouflaged Snark
	167716, -- Unseen Mimmic
	167715, -- Elusive Moonfish
	167714, -- Travelling Goby
	167713, -- Veiled Ghost
	167712, -- Rotted Blood Cod
	167711, -- Dead Fel Bone
	167710, -- Barbed Fjord Fin
	167709, -- Drowned Goldfish
	167708, -- Ancient Mana Fin
	167707, -- Kirin Tor Clown
	167706, -- Jade Story Fish
	167705, -- Mechanized Mackerel
	167562, -- Ionized Minnow
	167062, -- Armored Vaultbot Key
	166971, -- Empty Energy Cell
	166970, -- Energy Cell
	166885, -- Mark of Azshara
	166846, -- Spare Parts
	165835, -- Pristine Gizmo
	164942, -- Shadowscrawled Tome
	163205, -- Ghostly Pet Biscuit
	163036, -- Polished Pet Charm
	162029, -- Mark of the Humble Flyer
	162027, -- Mark of the Tideskipper
	162022, -- Mark of the Dolphin
	160744, -- Pristine Blowgun of the Sethrak
	160743, -- Blowgun of the Sethra
	160438, -- Seafarer's Dubloon
	158931, -- Ecto-dimensional Proton Beam
	158906, -- Shimmerfin Flesh
	157781, -- Extra-Chunky Dino Food
	157780, -- Free-Range Dino Chow
	157779, -- Infant Dino Kibble
	155011, -- REUSE ME (DNT)
	155010, -- REUSE ME (DNT)
	154935, -- Pristine Bwonsamdi Voodoo Mask
	154933, -- Pristine Rezan Idol
	154930, -- Pristine Ritual Fetish
	154929, -- Pristine Jagged Blade of the Drust
	154927, -- Pristine Ancient Runebound Tome
	154926, -- Pristine Ceremonial Bonesaw
	154925, -- Ritual Fetish
	154924, -- Jagged Blade of the Drust
	154923, -- Disembowling Sickle
	154922, -- Ancient Runebound Tome
	154916, -- High Apothecary's Hood
	154915, -- Rezan Idol
	154914, -- Urn of Passage
	153647, -- Tome of the Quiet Mind
	153006, -- Grimoire of Lost Knowledge
	152999, -- Imp Meat
	152097, -- Lightforged Bulwark
	152096, -- Void-Purged Krokul
	152095, -- Krokul Ridgestalker
	151760, -- Spelled Poster of Devlynn Styx
	151758, -- Metal Plate Portrait of Cage Head
	151756, -- Foil Blighthead Fan Club Card
	151755, -- Pair of Signed Drumsticks
	151754, -- Gold Plated Cage Head Key
	151481, -- Cage Head Key
	151479, -- Signed Blight Boar Poster
	151478, -- Blight Boar Statue
	151473, -- Blighthead Fan Club Membership Card
	151383, -- Fiddlesticks Signed Drumstick
	151382, -- Autographed Portrait of Cage Head
	151381, -- Framed Photo of Jon Graves
	151380, -- Autographed Poster of Devlyn Styx
	151191, -- Old Bottle Cap
	151165, -- Verbellin Tourbillon Chronometer
	151164, -- Sparkling Sin'dorei Signet
	151163, -- Locket of Magical Memories
	151162, -- Glitzy Mana-Chain
	151161, -- Subtle Chronometer
	151160, -- Elegant Manabraid
	151159, -- Managraphic Card
	151158, -- Manaforged Worry-Chain
	151157, -- Flashy Chronometer
	151156, -- Manaweft Bracelet
	151155, -- Mana-Etched Signet
	151154, -- Managleam Pendant
	151153, -- Glinting Manaseal
	151152, -- Star-Etched Ring
	151151, -- Tacky Chronometer
	151150, -- Charmed Bracelet
	151149, -- Charmed Ring
	151148, -- Charmed Choker
	151147, -- Charmed Pendant
	151146, -- Charmed Band
	151115, -- Mana-Cloaked Choker
	146963, -- Desecrated Seaweed
	146962, -- Golden Minnow
	146961, -- Shiny Bauble
	146960, -- Ancient Totem Fragment
	146959, -- Corrupted Globule
	146848, -- Fragmented Enchantment
	143852, -- Lucky Rabbit's Foot
	143850, -- Summon Grimtotem Warrior
	143849, -- Summon Royal Guard
	143785, -- Tome of the Tranquil Mind
	143780, -- Tome of the Tranquil Mind
	143605, -- Strange Ball of Energy
	143326, -- Stone of Jordan
	142366, -- Regurgitated Leaf
	142364, -- Bag of Twigs
	142262, -- Electrified Key
	142209, -- Dinner Invitation
	141640, -- Tome of the Clear Mind
	141446, -- Tome of the Tranquil Mind
	141028, -- Grimoire of Knowledge
	141022, -- Legion Ammunition
	140933, -- Runed Aspirant's Band
	140931, -- Bandit Wanted Poster
	140930, -- Acolyte's Vows
	140929, -- Squire's Oath
	140927, -- Water Globe
	140926, -- Bowmen's Orders
	140925, -- Enchanted Bark
	140924, -- Ashtongue Beacon
	140923, -- Ghoul Tombstone
	140922, -- Imp Pact
	140767, -- Pile of Bits and Bones
	140760, -- Libram of Truth
	140749, -- Horn of Winter
	140630, -- Mark of the Doe
	140397, -- G'Hanir's Blossom
	140394, -- Thornstalk Barbs
	140199, -- Nightshard
	140156, -- Blessing of the Order
	139785, -- Tales of the Broken Isles
	139783, -- Weathered Relic
	139428, -- A Master Plan
	139420, -- Wild Mushroom
	139419, -- Golden Banana
	139418, -- Healing Stream Totem
	139389, -- Charred Locket
	139376, -- Healing Well
	139177, -- Shattered Soul
	138883, -- Meryl's Conjured Refreshment
	138777, -- Drowned Mana
	138412, -- Iresoul's Healthstone
	138410, -- Summoning Portal
	138116, -- Throwing Torch
	138114, -- Gloaming Frenzy
	138099, -- Skyfire Stone
	137642, -- Mark of Honor
	137604, -- Unstable Riftstone
	134860, -- Peddlefeet's Buffing Creme
	132982, -- Sonic Environment Enhancer
	130920, -- Houndstooth Hauberk
	130919, -- Orb of Inner Chaos
	130918, -- Malformed Abyssal
	130917, -- Flayed-Skin Chronicle
	130916, -- Imp's Cup
	130915, -- Stonewood Bow
	130914, -- Drogbar Gem-Roller
	130913, -- Hand-Smoothed Pyrestone
	130912, -- Moosebone Fish-Hook
	130911, -- Trailhead Drum
	130910, -- Nobleman's Letter Opener
	130909, -- Pre-War Highborne Tapestry
	130908, -- Quietwine Vial
	130907, -- Inert Leystone Charm
	130906, -- Violetglass Vessel
	129742, -- Badge of Timewalking Justice
	129734, -- Potion of Cowardly Flight
	129021, -- Mark of the Sentinel
	128659, -- Merry Supplies
	128658, -- Spooky Supplies
	128379, -- Piece of Meat
	128373, -- Rush Order: Shipyard
	128368, -- Dripping Fangs of Goremaw
	127409, -- Sculpted Memorial Urn
	127407, -- Lava Prism Ring
	127406, -- Lovingly Polished Nose Ring
	127404, -- Limited-Edition Choker
	127402, -- Limited-Edition Choker
	127400, -- Wax-Daubed Signet
	127398, -- Locket of Precious Memories
	127115, -- Tome of Chaos
	127009, -- Fragment of Frostmourne
	124099, -- Blackfang Claw
	122618, -- Misprinted Draenic Coin
	122606, -- Explorer's Notebook
	122595, -- Rush Order: The Forge
	122594, -- Rush Order: Tailoring Emporium
	122593, -- Rush Order: Scribe's Quarters
	122592, -- Rush Order: Gem Boutique
	122591, -- Rush Order: Engineering Works
	122584, -- Winning with Wildlings
	122583, -- Grease Monkey Guide
	122582, -- Guide to Arakkoa Relations
	122580, -- Ogre Buddy Handbook
	122576, -- Rush Order: Alchemy Lab
	122514, -- Mission Completion Orders
	122502, -- Rush Order: Mine Shipment
	122501, -- Rush Order: Goblin Workshop
	122500, -- Rush Order: Gnomish Gearworks
	122491, -- Rush Order: War Mill
	122490, -- Rush Order: Dwarven Bunker
	122487, -- Rush Order: Gladiator's Sanctum
	122398, -- Garrison Scout Report
	122307, -- Rush Order: Barn
	122274, -- Tome of Knowledge
	122273, -- Follower Trait Retraining Guide
	122272, -- Follower Ability Retraining Manual
	120172, -- Vileclaw's Claw
	119819, -- Caged Mighty Clefthoof
	119817, -- Caged Mighty Riverbeast
	119815, -- Caged Mighty Wolf
	119814, -- Leathery Caged Beast
	119813, -- Furry Caged Beast
	119810, -- Meaty Caged Beast
	119185, -- Expired Receipt
	119102, -- Partial Receipt: True Iron Door Handles
	119101, -- Partial Receipt: Invisible Dust
	119100, -- Partial Receipt: Pickled Red Herring
	119099, -- Partial Receipt: Chainmail Socks
	119098, -- Partial Receipt: Druidskin Rug
	119097, -- Partial Receipt: Gently-Used Bandages
	119096, -- Partial Receipt: Book of Troll Poetry
	119095, -- Partial Receipt: Tailored Underwear
	119094, -- Partial Receipt: Flask of Funk
	118698, -- Wings of the Outcasts
	118661, -- Xelganak's Stinger
	118660, -- Thek'talon's Talon
	118659, -- Mu'gra's Head
	118658, -- Gagrog's Skull
	118657, -- Direhoof's Hide
	118656, -- Dekorhan's Tusk
	118655, -- Bergruu's Horn
	118654, -- Aogexon's Fang
	118592, -- Partial Receipt: Gizmothingies
	118474, -- Supreme Manual of Dance
	118354, -- Follower Retraining Certificate
	118100, -- Highmaul Relic
	118099, -- Gorian Artifact Fragment
	118067, -- Bartering Chip
	118043, -- Broken Bones
	117491, -- Ogre Waystone
	117397, -- Nat's Lucky Coin
	117390, -- Draenor Archaeologist's Map
	117389, -- Draenor Archaeologist's Lodestone
	117008, -- Voodoo Doctor's Hovel
	117007, -- Ornate Horde Tent
	117006, -- Ornate Alliance Tent
	117005, -- Distressingly Furry Tent
	117004, -- Simple Tent
	117003, -- Orgrimmar's Reach
	117002, -- Elune's Retreat
	117000, -- Deathweaver's Hovel
	116998, -- High Elven Tent
	116997, -- Blood Elven Tent
	116996, -- Crusader's Tent
	116995, -- Sturdy Tent
	116994, -- Brute's Tent
	116993, -- Archmage's Tent
	116992, -- Savage Leather Tent
	116991, -- Enchanter's Tent
	116990, -- Outcast's Tent
	116989, -- Ironskin Tent
	116988, -- Fine Blue and Green Tent
	116986, -- Fine Blue and Gold Tent
	116452, -- Spring-loaded Spike Trap
	116415, -- Shiny Pet Charm
	116392, -- Big Bag of Booty
	116172, -- Perky Blaster
	116158, -- Lunarfall Carp
	116141, -- Warspear Prison Key
	116140, -- Stormshield Prison Key
	116122, -- Burning Legion Missive
	115981, -- Abrogator Stone Cluster
	115346, -- Horde Supply Chest Key
	115345, -- Alliance Supply Chest Key
	115280, -- Abrogator Stone
	114207, -- Beakbreaker of Terokk
	114206, -- Apexis Scroll
	114205, -- Apexis Hieroglyph
	114204, -- Apexis Crystal
	114203, -- Outcast Dreamcatcher
	114202, -- Talonpriest Mask
	114201, -- Sundial
	114200, -- Solar Orb
	114199, -- Decree Scrolls
	114198, -- Burial Urn
	114197, -- Dreamcatcher
	114196, -- Warmaul of the Warmaul Chieftain
	114194, -- Imperial Decree Stele
	114193, -- Rylak Riding Harness
	114192, -- Stone Dentures
	114191, -- Eye of Har'gunn the Blind
	114190, -- Mortar and Pestle
	114189, -- Gladiator's Shield
	114187, -- Pictogram Carving
	114185, -- Ogre Figurine
	114183, -- Stone Manacles
	114181, -- Stonemaul Succession Stone
	114179, -- Headdress of the First Shaman
	114177, -- Doomsday Prophecy
	114175, -- Gronn-Tooth Necklace
	114173, -- Flask of Blazegrease
	114171, -- Ancestral Talisman
	114169, -- Cracked Ivory Idol
	114167, -- Ceremonial Tattoo Needles
	114163, -- Barbed Fishing Hook
	114161, -- Hooked Dagger
	114159, -- Weighted Chopping Axe
	114157, -- Blackrock Razor
	114155, -- Elemental Bellows
	114153, -- Metalworker's Hammer
	114151, -- Warsong Ceremonial Pike
	114149, -- Screaming Bullroarer
	114147, -- Warsinger's Drums
	114145, -- Wolfskin Snowshoes
	114141, -- Fang-Scarred Frostwolf Axe
	113499, -- Notes of Natural Cures
	113495, -- Venom Extraction Kit
	113483, -- Lightweight Medic Vest
	113478, -- Abandoned Medic Kit
	113471, -- Busted Alarm Bot
	113468, -- Faulty Grenade
	113465, -- Broken Hunting Scope
	113452, -- Trampled Survey Bot
	113429, -- Cracked Hand Drum
	113423, -- Scorched Leather Cap
	113420, -- Desiccated Leather Cloak
	113417, -- Torn Knapsack
	113411, -- Bloodstained Mage Robe
	113394, -- Headless Figurine
	113384, -- Crushed Locket
	113381, -- Crumbling Statue
	113376, -- Faintly Magical Vellum
	113371, -- Torn Card
	113367, -- Waterlogged Book
	113365, -- Ruined Painting
	113361, -- Tattered Scroll
	113358, -- Felled Totem
	113336, -- Gnarled, Splintering Staff
	113332, -- Cracked Wand
	113329, -- Ripped Lace Kerchief
	113324, -- Ritual Mask Shards
	113321, -- Battered Shield
	113316, -- Mangled Long Sword
	113313, -- Unorganized Alchemist Notes
	113310, -- Unstable Elixir
	113307, -- Impotent Healing Potion
	113295, -- Cracked Potion Vial
	113245, -- Shredded Greaves
	113244, -- Soleless Treads
	113203, -- Punctured Breastplate
	113008, -- Glowing Ancestral Idol
	113007, -- Magma-Infused War Beads
	113006, -- Choker of Nightmares
	113005, -- Chain of Hopes
	113004, -- Locket of Dreams
	113003, -- Opal Amulet
	113002, -- Ruby Amulet
	113001, -- Sparkling Amulet
	113000, -- Oozing Amulet
	112999, -- Sapphire Ring
	112998, -- Diamond Ring
	112997, -- Emerald Ring
	112996, -- Glistening Ring
	112995, -- Slimy Ring
	112633, -- Frostdeep Minnow
	112322, -- Complicated Wood
	109739, -- Star Chart
	108882, -- Bloodmaul Blasting Charge
	107645, -- Iron Horde Weapon Cache
	104346, -- Golden Glider
	104336, -- Bubbling Pi'jiu Brew
	104335, -- Thick Pi'jiu Brew
	104334, -- Misty Pi'jiu Brew
	104297, -- Blazing Sigil of Ordos
	104293, -- Scuttler's Shell
	104286, -- Quivering Firestorm Egg
	103797, -- Big Pink Bow
	103684, -- Scroll of Challenge
	103683, -- Mask of Anger
	103682, -- Mask of Violence
	103681, -- Mask of Doubt
	103680, -- Mask of Hatred
	103679, -- Mask of Fear
	103533, -- Vicious Saddle
	102464, -- Black Ash
	101538, -- Kukuru's Cache Key
	101529, -- Celestial Coin
	97268, -- Tome of Valor
	95623, -- Sunreaver Bounty
	95622, -- Arcane Trove
	95497, -- Burial Trove Key
	95491, -- Tattered Historical Parchments
	95382, -- Kypari Sap Container
	95381, -- Pollen Collector
	95380, -- Mantid Lamp
	95379, -- Remains of a Paragon
	95378, -- Inert Sound Beacon
	95377, -- The Praying Mantid
	95376, -- Ancient Sap Feeder
	95375, -- Banner of the Mantid Empire
	94594, -- Titan Runestone
	94593, -- Secrets of the Empire
	94536, -- Intact Direhorn Hide
	94222, -- Key to the Palace of Lei Shen
	93738, -- Rusty Prison Key
	92750, -- Jungle Hops
	92743, -- Krasari Iron
	92739, -- Misplaced Keg
	92625, -- Theldren's Rusted Runeblade
	92624, -- Theldren's Rusted Runeblade
	92623, -- Ancient Orcish Shield
	92622, -- Ancient Orcish Shield
	92620, -- Elysia's Bindings
	92619, -- Ornate Portrait
	92618, -- Ornate Portrait
	92617, -- Golden Fruit Bowl
	92616, -- Golden Fruit Bowl
	92615, -- Taric's Family Jewels
	92613, -- Zena's Ridiculously Rich Yarnball
	92611, -- Golden Platter
	92610, -- Golden Platter
	92608, -- Golden Potion
	92604, -- Golden Goblet
	92603, -- Large Pile of Gold Coins
	92602, -- Large Pile of Gold Coins
	92600, -- Small Pile of Gold Coins
	92599, -- Gold Ring
	92598, -- Gold Ring
	92597, -- Ruby Ring
	92596, -- Ruby Ring
	92595, -- Diamond Ring
	92594, -- Diamond Ring
	92593, -- Spellstone Necklace
	92592, -- Spellstone Necklace
	92591, -- Ruby Necklace
	92590, -- Ruby Necklace
	92589, -- Jade Kitten Figurine
	92588, -- Jade Kitten Figurine
	92587, -- Sparkling Sapphire
	92586, -- Sparkling Sapphire
	92585, -- Expensive Ruby
	92584, -- Expensive Ruby
	92583, -- Cheap Cologne
	92581, -- Fragrant Perfume
	92580, -- Fragrant Perfume
	92538, -- Unexploded Cannonball
	92470, -- Snake Oil
	92444, -- Meaty Haunch
	91971, -- Battle Rations
	90544, -- Sixth Place Valorous Commendation
	90543, -- Fifth Place Valorous Commendation
	90541, -- Fourth Place Valorous Commendation
	90540, -- Third Place Valorous Commendation
	90539, -- Second Place Valorous Commendation
	90538, -- First Place Valorous Commendation
	90048, -- Exquisite Murloc Leash
	89868, -- Mark of the Cheetah
	89639, -- Desecrated Herb
	89209, -- Pristine Monument Ledger
	89185, -- Pristine Standard of Niuzao
	89184, -- Pristine Pearl of Yu'lon
	89183, -- Pristine Apothecary Tins
	89182, -- Pristine Gold-Inlaid Figurine
	89181, -- Pristine Carved Bronze Mirror
	89180, -- Pristine Empty Keg
	89179, -- Pristine Walking Cane
	89178, -- Pristine Twin Stein Set
	89176, -- Pristine Branding Iron
	89175, -- Pristine Iron Amulet
	89174, -- Pristine Edicts of the Thunder King
	89173, -- Pristine Thunder King Insignia
	89172, -- Pristine Petrified Bone Whip
	89171, -- Pristine Terracotta Arm
	89170, -- Pristine Mogu Runestone
	89155, -- Onyx Egg
	87898, -- Charred Glyph
	87828, -- Tigersblood Pigment
	87821, -- Coagulated Tiger's Blood
	87806, -- Ancient Mogu Key
	87779, -- Ancient Guo-Lai Cache Key
	87549, -- Lorewalker's Map
	87548, -- Lorewalker's Lodestone
	87399, -- Restored Artifact
	87209, -- Sigil of Wisdom
	87208, -- Sigil of Power
	86547, -- Skyshard
	85689, -- Charred Glyph
	85558, -- Pristine Game Board
	85557, -- Pristine Pandaren Tea Set
	85477, -- Pristine Mogu Coin
	81055, -- Darkmoon Ride Ticket
	80546, -- Tap Tool
	79917, -- Worn Monument Ledger
	79916, -- Mogu Coin
	79915, -- Warlord's Branding Iron
	79914, -- Iron Amulet
	79913, -- Edicts of the Thunder King
	79912, -- Thunder King Insignia
	79911, -- Petrified Bone Whip
	79910, -- Terracotta Arm
	79909, -- Cracked Mogu Runestone
	79908, -- Manacles of Rebellion
	79907, -- Spear of Xuen
	79906, -- Umbrella of Chi-Ji
	79905, -- Standard of Niuzao
	79904, -- Pearl of Yu'lon
	79903, -- Apothecary Tins
	79902, -- Gold-Inlaid Figurine
	79901, -- Carved Bronze Mirror
	79900, -- Empty Keg
	79899, -- Walking Cane
	79898, -- Twin Stein Set
	79897, -- Pandaren Game Board
	79896, -- Pandaren Tea Set
	79268, -- Marsh Lily
	79267, -- Lovely Apple
	79266, -- Jade Cat
	79265, -- Blue Feather
	79264, -- Ruby Shard
	78891, -- Elementium-Coated Geode
	78890, -- Crystalline Geode
	76402, -- Greater Scarab Coffer Key
	76401, -- Scarab Coffer Key
	74622, -- Dead Fire Spirit
	71000, -- Emberstone Fragment
	70999, -- Obsidian-Flecked Chitin Fragment
	70997, -- Rhyolite Fragment
	70994, -- Pyreshell Fragment
	66058, -- Fine Bloodscalp Dinnerware
	66056, -- Shard of Petrified Wood
	64658, -- Sketch of a Desert Palace
	64656, -- Engraved Scimitar Hilt
	64655, -- Tiny Oasis Mosaic
	64654, -- Soapstone Scarab Necklace
	64653, -- Cat Statue with Emerald Eyes
	64652, -- Castle of Sand
	64650, -- Umbra Crescent
	64648, -- Silver Scroll Case
	64487, -- Scepter of Bronzebeard
	64486, -- Word of Empress Zoe
	64485, -- Spiked Gauntlets of Anvilrage
	64483, -- Silver Kris of Korl
	64479, -- Ewer of Jormungar Blood
	64477, -- Gruesome Heart Box
	64475, -- Scepter of Nezar'Azret
	64473, -- Imprint of a Kraken Tentacle
	64468, -- Proto-Drake Skeleton
	64464, -- Fanged Cloak Pin
	64462, -- Flint Striker
	64461, -- Scramseax
	64459, -- Intricate Treasure Chest Key
	64458, -- Plated Elekk Goad
	64455, -- Dignified Portrait
	64454, -- Fine Crystal Candelabra
	64453, -- Baroque Sword Scabbard
	64444, -- Scepter of the Nathrezim
	64443, -- Strange Silver Paperweight
	64442, -- Carved Harp of Exotic Wood
	64440, -- Anklet with Golden Bells
	64438, -- Skull Drinking Cup
	64437, -- Tile of Glazed Clay
	64421, -- Fierce Wolf Figurine
	64420, -- Scepter of Nekros Skullcrusher
	64419, -- Rusted Steak Knife
	64418, -- Gray Candle Stub
	64417, -- Maul of Stone Guard Mur'og
	64389, -- Tiny Bronze Scorpion
	64387, -- Vicious Ancient Fish
	64385, -- Feathered Raptor Arm
	64382, -- Scepter of Xavius
	64381, -- Cracked Crystal Vial
	64379, -- Chest of Tiny Glass Animals
	64378, -- String of Small Pink Pearls
	64375, -- Drakkari Sacrificial Knife
	64374, -- Tooth with Gold Filling
	64371, -- Skull Staff of Shadowforge
	64368, -- Mithril Chain of Angerforge
	64367, -- Scepter of Charlga Razorflank
	64366, -- Scorched Staff of Shadow Priest Anund
	64362, -- Dented Shield of Horuz Killcrow
	64357, -- Delicate Music Box
	64356, -- Hairpin of Silver and Malachite
	64355, -- Ancient Shark Jaws
	64350, -- Insect in Amber
	64348, -- Atal'ai Scepter
	64347, -- Gahz'rilla Figurine
	64346, -- Bracelet of Jade and Coins
	64345, -- Skull-Shaped Planter
	64344, -- Ironstar's Petrified Shield
	64343, -- Winged Helm of Corehammer
	64342, -- Golden Chamber Pot
	64340, -- Boot Heel with Scrollwork
	64339, -- Bodacious Door Knocker
	64337, -- Notched Sword of Tunadil the Redeemer
	63528, -- Green Dragon Ring
	63527, -- Twisted Ammonite Shell
	63524, -- Cinnabar Bijou
	63523, -- Eerie Smolderthorn Idol
	63518, -- Hellscream's Reach Commendation
	63414, -- Moltenfist's Jeweled Goblet
	63413, -- Feathered Gold Earring
	63412, -- Jade Asp with Ruby Eyes
	63411, -- Silver Neck Torc
	63410, -- Stone Gryphon
	63409, -- Ceramic Funeral Urn
	63408, -- Pewter Drinking Cup
	63407, -- Cloak Clasp with Antlers
	63131, -- Scandalous Silk Nightgown
	63130, -- Inlaid Ivory Comb
	63129, -- Highborne Pyxis
	63121, -- Beautiful Preserved Fern
	63120, -- Fetish of Hir'eek
	63118, -- Lizard Foot Charm
	63115, -- Zandalari Voodoo Doll
	63113, -- Belt Buckle with Anvilmar Crest
	63112, -- Bone Gaming Dice
	63111, -- Wooden Whistle
	63110, -- Worn Hunting Knife
	63109, -- Black Trilobite
	57757, -- Orgrimmar Cooking Award
	57142, -- Stormwind Cooking Award
	49884, -- Kaja'Cola
	46114, -- Champion's Writ
	43641, -- Anduin Wrynn's Gold Coin
	43640, -- Archimonde's Gold Coin
	43639, -- Arthas' Gold Coin
	43638, -- Arugal's Gold Coin
	43637, -- Brann Bronzebeard's Gold Coin
	43636, -- Chromie's Gold Coin
	43635, -- Kel'Thuzad's Gold Coin
	43634, -- Lady Katrana Prestor's Gold Coin
	43633, -- Prince Kael'thas Sunstrider's Gold Coin
	43632, -- Sylvanas Windrunner's Gold Coin
	43631, -- Teron's Gold Coin
	43630, -- Tirion Fordring's Gold Coin
	43629, -- Uther Lightbringer's Gold Coin
	43628, -- Lady Jaina Proudmoore's Gold Coin
	43627, -- Thrall's Gold Coin
	43392, -- Charred Glyph
	42954, -- Charred Glyph
	42742, -- Faded Glyph
	41106, -- Charred Glyph
	40919, -- Mark of the Orca
	40916, -- Charred Glyph
	37372, -- Harpoon
	34497, -- Paper Flying Machine
	33784, -- Darkrune Fragment
	32897, -- Mark of the Illidari
	32773, -- Bash'ir's Skeleton Key
	32713, -- Bloodstained Fortune
	32712, -- Bloodstained Fortune
	32711, -- Bloodstained Fortune
	32710, -- Bloodstained Fortune
	32709, -- Bloodstained Fortune
	32708, -- Bloodstained Fortune
	32707, -- Bloodstained Fortune
	32706, -- Bloodstained Fortune
	32705, -- Bloodstained Fortune
	32704, -- Bloodstained Fortune
	32703, -- Bloodstained Fortune
	32702, -- Bloodstained Fortune
	32701, -- Bloodstained Fortune
	32700, -- Bloodstained Fortune
	32693, -- Bloodstained Fortune
	32692, -- Bloodstained Fortune
	32691, -- Bloodstained Fortune
	32690, -- Bloodstained Fortune
	32689, -- Bloodstained Fortune
	32688, -- Bloodstained Fortune
	32684, -- Insidion's Ebony Scale
	32683, -- Jet Scale of Furywing
	32682, -- Obsidia Scale
	32681, -- Onyx Scale of Rivendark
	32578, -- Charged Crystal Focus
	32572, -- Apexis Crystal
	32079, -- Shaffar's Stasis Chamber Key
	30426, -- Coilskar Chest Key
	29750, -- Ethereum Stasis Chamber Key
	26045, -- Halaa Battle Token
	26044, -- Halaa Research Token
	23501, -- Bloodthistle Petal
	22524, -- Insignia of the Crusade
	22523, -- Insignia of the Dawn
	22484, -- Necrotic Rune
	21438, -- Horde Commendation Signet
	21436, -- Alliance Commendation Signet
	20620, -- Holy Mightstone
	20086, -- Broken Dusksteel Throwing Knife
	15327, -- Broken Wicked Throwing Dagger
	15326, -- Broken Gleaming Throwing Axe
	13173, -- Broken Flightblade Throwing Axe
	12973, -- Scarlet Cannonball
	11078, -- Relic Coffer Key
	10575, -- Black Dragonflight Molt
	6712, -- Clockwork Box
	5373, -- Lucky Charm
	3463, -- Broken Silver Star
	3137, -- Broken Deadly Throwing Axe
	3135, -- Broken Sharp Throwing Axe
	3131, -- Broken Weighted Throwing Axe
	3111, -- Broken Crude Throwing Axe
	3108, -- Broken Heavy Throwing Dagger
	3107, -- Broken Keen Throwing Knife
	2947, -- Broken Small Throwing Knife
	2946, -- Broken Balanced Throwing Dagger
	2460, -- Elixir of Tongues
	1703, -- Crystal Basilisk Spine
}
items.world_events = {
	21100, -- Coin of Ancestry, Lunar Festiva
	23247, -- Burning Blossom, Midsummer Fire Festiva
	33226, -- Tricky Treat, Hallow's End
	37829, -- Brewfest Prize Token
	44791, -- Noblegarden Chocolate
	49927, -- Love Token, Love is in the Air
}
items.pvp = {
	20559, -- Arathi Basin Mark of Honor
	20558, -- Warsong Gulch Mark of Honor
	20560, -- Alterac Valley Mark of Honor
	137642, -- Mark of Honor
	103533, -- Vicious Saddle
	26045, -- HALAA_BATTLE_TOKEN 
	26044, -- HALAA_RESEARCH_TOKEN 
}
items.elemental = {
	-- Shadowland
	187707, -- Progenitor Essentia
	186017, -- Korthite Crystal
	178787, -- Orboreal Shard
	-- BfA
	165703, -- Breath of Bwonsamdi
	165948, -- Tidalcore
	162461, -- Sanguicell
	162460, -- Hydrocore
	163203, -- Hypersensitive Azeritometer Sensor
	152668, -- Expulsom
	-- Legion
	151568, -- Primal Sargerite, added in patch 7.3.0.24484
	124124, -- Blood of Sargeras
	124123, -- Demonfire
	124112, -- Leyfire
	-- WoD
	113261, -- Sorcerous Fire
	113262, -- Sorcerous Water
	113263, -- Sorcerous Earth
	113264, -- Sorcerous Air
	120945, -- Primal Spirit
	-- MoP
	89112, -- Mote of Harmony
	76061, -- Spirit of Harmony
	-- Cataclysm
	54464, -- Random Volatile Element
	52329, -- Volatile Life
	52328, -- Volatile Air
	52327, -- Volatile Earth
	52326, -- Volatile Water
	52325, -- Volatile Fire
	-- WolTK
	37705, -- Crystallized Water
	37704, -- Crystallized Life
	37703, -- Crystallized Shadow
	37702, -- Crystallized Fire
	37701, -- Crystallized Earth
	37700, -- Crystallized Air
	36860, -- Eternal Fire
	35627, -- Eternal Shadow
	35625, -- Eternal Life
	35624, -- Eternal Earth
	35623, -- Eternal Air
	35622, -- Eternal Water
	-- BC
	30183, -- Nether Vortex
	23572, -- Primal Nether
	23571, -- Primal Might
	22578, -- Mote of Water
	22577, -- Mote of Shadow
	22576, -- Mote of Mana
	22575, -- Mote of Life
	22574, -- Mote of Fire
	22573, -- Mote of Earth
	22572, -- Mote of Air
	22457, -- Primal Mana
	22456, -- Primal Shadow
	22452, -- Primal Earth
	22451, -- Primal Air
	21886, -- Primal Life
	21885, -- Primal Water
	21884, -- Primal Fire
	-- Classic
	12808, -- Essence of Undeath
	12803, -- Living Essence
	10286, -- Heart of the Wild
	7972, -- Ichor of Undeath
	7082, -- Essence of Air
	7081, -- Breath of Wind
	7080, -- Essence of Water
	7079, -- Globe of Water
	7078, -- Essence of Fire
	7077, -- Heart of Fire
	7076, -- Essence of Earth
	7075, -- Core of Earth
	7070, -- Elemental Water
	7069, -- Elemental Air
	7068, -- Elemental Fire
	7067, -- Elemental Earth
}
items.meat = {
	-- 9.x.x
	187812, -- Empty Kettle
	187704, -- Protoflesh
	187702, -- Precursor Placoderm
	179315, -- Shadowy Shank
	179314, -- Creeping Crawler Meat
	178786, -- Lusterwheat Flour
	175111, -- Marrow Larva
	173037, -- Elysian Thade
	173036, -- Spinefin Piranha
	173035, -- Pocked Bonefish
	173034, -- Silvergill Pike
	173033, -- Iridescent Amberjack
	173032, -- Lost Sole
	172059, -- Rich Grazer Milk
	172058, -- Smuggled Azerothian Produce
	172057, -- Inconceivably Aged Vinegar
	172056, -- Medley of Transplanar Spices
	172055, -- Phantasmal Haunch
	172054, -- Raw Seraphic Wing
	172053, -- Tenebrous Ribs
	172052, -- Aethereal Meat
	-- 8.x.x
	174353, -- Questionable Meat
	174328, -- Aberrant Voidfin
	174327, -- Malformed Gnasher
	168646, -- Mauve Stinger
	168645, -- Moist Fillet
	168303, -- Rubbery Flank
	168302, -- Viper Fish
	166741, -- Nomi's Grocery Tote
	163782, -- Cursed Haunch
	160712, -- Powdered Sugar
	160711, -- Aromatic Fish Oil
	160710, -- Wild Berries
	160709, -- Fresh Potato
	160400, -- Foosaka
	160399, -- Wild Flour
	160398, -- Choral Honey
	154899, -- Thick Paleo Steak
	154898, -- Meaty Haunch
	154897, -- Stringy Loins
	152631, -- Briny Flesh
	152549, -- Redtail Loach
	152548, -- Tiragarde Perch
	152547, -- Great Sea Catfish
	152546, -- Lane Snapper
	152545, -- Frenzied Fangtooth
	152544, -- Slimy Mackerel
	152543, -- Sand Shifter
	-- 7.x.x
	146757, -- Prepared Ingredients
	142336, -- Falcosaur Egg
	139669, -- Ancient Black Barracuda
	139668, -- Seabottom Squid
	139667, -- Axefish
	139666, -- Tainted Runescale Koi
	139665, -- Seerspine Puffer
	139664, -- Magic-Eater Frog
	139663, -- Thundering Stormray
	139662, -- Graybelly Lobster
	139661, -- Oodelfjisk
	139660, -- Ancient Highmountain Salmon
	139659, -- Coldriver Carp
	139658, -- Mountain Puffer
	139657, -- Ancient Mossgill
	139656, -- Thorned Flounder
	139655, -- Terrorfin
	139654, -- Ghostly Queenfish
	139653, -- Nar'thalas Hermit
	139652, -- Leyshimmer Blenny
	138967, -- Big Fountain Goldfish
	135512, -- Thick Slab of Bacon
	133742, -- Ancient Black Barracuda
	133741, -- Seabottom Squid
	133740, -- Axefish
	133739, -- Tainted Runescale Koi
	133738, -- Seerspine Puffer
	133737, -- Magic-Eater Frog
	133736, -- Thundering Stormray
	133735, -- Graybelly Lobster
	133734, -- Oodelfjisk
	133733, -- Ancient Highmountain Salmon
	133732, -- Coldriver Carp
	133731, -- Mountain Puffer
	133730, -- Ancient Mossgill
	133729, -- Thorned Flounder
	133728, -- Terrorfin
	133727, -- Ghostly Queenfish
	133726, -- Nar'thalas Hermit
	133725, -- Leyshimmer Blenny
	133680, -- Slice of Bacon
	133607, -- Silver Mackerel
	133593, -- Royal Olive
	133592, -- Stonedark Snail
	133591, -- River Onion
	133590, -- Muskenbutter
	133589, -- Dalapeño Pepper
	133588, -- Flaked Sea Salt
	124121, -- Wildfowl Egg
	124120, -- Leyblood
	124119, -- Big Gamy Ribs
	124118, -- Fatty Bearsteak
	124117, -- Lean Shank
	124112, -- Black Barracuda
	124111, -- Runescale Koi
	124110, -- Stormray
	124109, -- Highmountain Salmon
	124108, -- Mossgill Perch
	124107, -- Cursed Queenfish
	-- 6.x.x
	128500, -- Fel Ham
	128499, -- Fel Egg
	127994, -- Felmouth Frenzy Lunker
	127991, -- Felmouth Frenzy
	124669, -- Darkmoon Daggermaw
	122696, -- Sea Scorpion Lunker
	118565, -- Savage Piranha
	116822, -- Jawless Skulker Lunker
	116821, -- Fat Sleeper Lunker
	116820, -- Blind Lake Lunker
	116819, -- Fire Ammonite Lunker
	116818, -- Abyssal Gulper Lunker
	116817, -- Blackwater Whiptail Lunker
	111676, -- Enormous Jawless Skulker
	111675, -- Enormous Fat Sleeper
	111674, -- Enormous Blind Lake Sturgeon
	111673, -- Enormous Fire Ammonite
	111672, -- Enormous Sea Scorpion
	111671, -- Enormous Abyssal Gulper Eel
	111670, -- Enormous Blackwater Whiptail
	111669, -- Jawless Skulker
	111668, -- Fat Sleeper
	111667, -- Blind Lake Sturgeon
	111666, -- Fire Ammonite
	111665, -- Sea Scorpion
	111664, -- Abyssal Gulper Eel
	111663, -- Blackwater Whiptail
	111662, -- Small Blackwater Whiptail
	111659, -- Small Abyssal Gulper Eel
	111658, -- Small Sea Scorpion
	111656, -- Small Fire Ammonite
	111652, -- Small Blind Lake Sturgeon
	111651, -- Small Fat Sleeper
	111650, -- Small Jawless Skulker
	111601, -- Enormous Crescent Saberfish
	111595, -- Crescent Saberfish
	111589, -- Small Crescent Saberfish
	109144, -- Blackwater Whiptail Flesh
	109143, -- Abyssal Gulper Eel Flesh
	109142, -- Sea Scorpion Segment
	109141, -- Fire Ammonite Tentacle
	109140, -- Blind Lake Sturgeon Flesh
	109139, -- Fat Sleeper Flesh
	109138, -- Jawless Skulker Flesh
	109137, -- Crescent Saberfish Flesh
	109136, -- Raw Boar Meat
	109135, -- Raw Riverbeast Meat
	109134, -- Raw Elekk Meat
	109133, -- Rylak Egg
	109132, -- Raw Talbuk Meat
	109131, -- Raw Clefthoof Meat
	-- 5.x.x
	102543, -- Aged Mogu'shan Cheese
	102542, -- Ancient Pandaren Spices
	102541, -- Aged Balsamic Vinegar
	102540, -- Fresh Mangos
	102539, -- Fresh Strawberries
	102538, -- Fresh Shao-Tien Rice
	102537, -- Fresh Silkfeather Hawk Eggs
	102536, -- Fresh Lushroom
	85585, -- Red Beans
	85584, -- Silkworm Pupa
	85583, -- Needle Mushrooms
	85506, -- Viseclaw Meat
	79250, -- Fresh Pomfruit
	79246, -- Delicate Blossom Petals
	75014, -- Raw Crocolisk Belly
	74866, -- Golden Carp
	74865, -- Krasarang Paddlefish
	74864, -- Reef Octopus
	74863, -- Jewel Danio
	74861, -- Tiger Gourami
	74860, -- Redbelly Mandarin
	74859, -- Emperor Salmon
	74857, -- Giant Mantis Shrimp
	74856, -- Jade Lungfish
	74854, -- Instant Noodles
	74853, -- 100 Year Soy Sauce
	74852, -- Yak Milk
	74851, -- Rice
	74850, -- White Turnip
	74849, -- Pink Turnip
	74848, -- Striped Melon
	74847, -- Jade Squash
	74846, -- Witchberries
	74845, -- Ginseng
	74844, -- Red Blossom Leek
	74843, -- Scallions
	74842, -- Mogu Pumpkin
	74841, -- Juicycrunch Carrot
	74840, -- Green Cabbage
	74839, -- Wildfowl Breast
	74838, -- Raw Crab Meat
	74837, -- Raw Turtle Meat
	74834, -- Mushan Ribs
	74833, -- Raw Tiger Steak
	74832, -- Barley
	74662, -- Rice Flour
	74661, -- Black Pepper
	74660, -- Pandaren Peach
	74659, -- Farm Chicken
	-- 4.x.x
	67229, -- Stag Flank
	62791, -- Blood Shrimp
	62785, -- Delicate Wing
	62784, -- Crocolisk Tail
	62783, -- Basilisk
	62782, -- Dragon Flank
	62781, -- Giant Turtle Tongue
	62780, -- Snake Eye
	62779, -- Monstrous Claw
	62778, -- Toughened Flesh
	53072, -- Deepsea Sagefish
	53071, -- Algaefin Rockfish
	53070, -- Fathom Eel
	53069, -- Murglesnout
	53068, -- Lavascale Catfish
	53067, -- Striped Lurker
	53066, -- Blackbelly Mudfish
	53065, -- Albino Cavefish
	53064, -- Highland Guppy
	53063, -- Mountain Trout
	53062, -- Sharptooth
	-- 3.x.x
	44834, -- Wild Turkey
	43652, -- Slippery Eel
	43647, -- Shimmering Minnow
	43646, -- Fountain Goldfish
	43572, -- Magic Eater
	43571, -- Sewer Carp
	43501, -- Northern Egg
	43013, -- Chilled Meat
	43012, -- Rhino Meat
	43011, -- Worg Haunch
	43010, -- Worm Meat
	43009, -- Shoveltusk Flank
	41814, -- Glassfin Minnow
	41813, -- Nettlefish
	41812, -- Barrelhead Goby
	41810, -- Fangtooth Herring
	41809, -- Glacial Salmon
	41808, -- Bonescale Snapper
	41807, -- Dragonfin Angelfish
	41806, -- Musselback Sculpin
	41805, -- Borean Man O' War
	41803, -- Rockfin Grouper
	41802, -- Imperial Manta Ray
	41801, -- Moonglow Cuttlefish
	41800, -- Deep Sea Monsterbelly
	36782, -- Succulent Clam Meat
	35794, -- Silvercoat Stag Meat
	34736, -- Chunk o' Mammoth
	-- 2.x.x
	37588, -- Mostly Digested Fish
	35562, -- Bear Flank
	35285, -- Giant Sunfish
	33824, -- Crescent-Tail Skullfish
	33823, -- Bloodfin Catfish
	31671, -- Serpent Flesh
	31670, -- Raptor Ribs
	27682, -- Talbuk Venison
	27681, -- Warped Flesh
	27678, -- Clefthoof Meat
	27677, -- Chunk o' Basilisk
	27674, -- Ravager Flesh
	27671, -- Buzzard Meat
	27669, -- Bat Flesh
	27668, -- Lynx Meat
	27439, -- Furious Crawdad
	27438, -- Golden Darter
	27437, -- Icefin Bluefish
	27435, -- Figluster's Mudfish
	27429, -- Zangarian Sporefish
	27425, -- Spotted Feltail
	27422, -- Barbed Gill Trout
	24477, -- Jaggal Clam Meat
	23676, -- Moongraze Stag Tenderloin
	22644, -- Crunchy Spider Leg
	-- 1.x.x
	21153, --  Raw Greater Sagefish
	21071, --  Raw Sagefish
	21024, --  Chimaerok Tenderloin
	20424, --  Sandworm Meat
	13889, --  Raw Whitescale Salmon
	13888, --  Darkclaw Lobster
	13760, --  Raw Sunscale Salmon
	13759, --  Raw Nightfin Snapper
	13758, --  Raw Redgill
	13756, --  Raw Summer Bass
	13754, --  Raw Glossy Mightfish
	12223, --  Meaty Bat Wing
	12208, --  Tender Wolf Meat
	12207, --  Giant Egg
	12206, --  Tender Crab Meat
	12205, --  White Spider Meat
	12204, --  Heavy Kodo Meat
	12203, --  Red Wolf Meat
	12202, --  Tiger Meat
	12184, --  Raptor Flesh
	12037, --  Mystery Meat
	8959, --  Raw Spinefin Halibut
	8365, --  Raw Mithril Head Trout
	7974, --  Zesty Clam Meat
	6889, --  Small Egg
	6362, --  Raw Rockscale Cod
	6361, --  Raw Rainbow Fin Albacore
	6317, --  Raw Loch Frenzy
	6308, --  Raw Bristle Whisker Catfish
	6303, --  Raw Slitherskin Mackerel
	6291, --  Raw Brilliant Smallfish
	6289, --  Raw Longjaw Mud Snapper
	5504, --  Tangy Clam Meat
	5503, --  Clam Meat
	5471, --  Stag Meat
	5470, --  Thunder Lizard Tail
	5469, --  Strider Meat
	5468, --  Soft Frenzy Flesh
	5467, --  Kodo Meat
	5466, --  Scorpid Stinger
	5465, --  Small Spider Leg
	4655, --  Giant Clam Meat
	4603, --  Raw Spotted Yellowtail
	3731, --  Lion Meat
	3730, --  Big Bear Meat
	3712, --  Turtle Meat
	3685, --  Raptor Egg
	3667, --  Tender Crocolisk Meat
	3404, --  Buzzard Wing
	3174, --  Spider Ichor
	3173, --  Bear Meat
	3172, --  Boar Intestines
	2924, --  Crocolisk Meat
	2886, --  Crag Boar Rib
	2677, --  Boar Ribs
	2675, --  Crawler Claw
	2674, --  Crawler Meat
	2673, --  Coyote Meat
	2672, --  Stringy Wolf Meat
	2665, --  Stormwind Seasoning Herbs
	2251, --  Gooey Spider Leg
	1468, --  Murloc Fin
	1080, --  Tough Condor Meat
	1015, --  Lean Wolf Flank
	769, --  Chunk of Boar Meat
	731, --  Goretusk Snout
	730, --  Murloc Eye
	729, --  Stringy Vulture Meat
	723, --  Goretusk Liver
}
items.quest = { -- quest item which is stable
	22892, -- Dim Necrotic Stone
	22529, -- Savage Frond
	22528, -- Dark Iron Scraps
	22527, -- Core of Elements
	22526, -- Bone Fragments
	22525, -- Crypt Fiend Parts
	22444, -- Putrid Vine
	22435, -- Gorishi Sting
	22434, -- Bloodcap
	22432, -- Devilsaur Barb
	22381, -- Silithus Venom Sample
	22338, -- Volcanic Ash
	22258, -- Love Potion
	22138, -- Blackrock Bracer
	22094, -- Bloodkelp
	21982, -- Ogre Warbeads
	21937, -- Scorched Ectoplasm
	21936, -- Frozen Ectoplasm
	21935, -- Stable Ectoplasm
	21928, -- Winterspring Blood Sample
	21515, -- Mark of Remulos
	21508, -- Mark of Cenarius
	21383, -- Winterfall Spirit Beads
	21377, -- Deadwood Headdress Feather
	21229, -- Qiraji Lord's Insignia
	21100, -- Coin of Ancestry
	20890, -- Qiraji Ornate Hilt
	20889, -- Qiraji Regal Drape
	20888, -- Qiraji Ceremonial Ring
	20886, -- Qiraji Spiked Hilt
	20885, -- Qiraji Martial Drape
	20884, -- Qiraji Magisterial Ring
	20882, -- Idol of War
	20881, -- Idol of Strife
	20879, -- Idol of Life
	20878, -- Idol of Rebirth
	20877, -- Idol of the Sage
	20876, -- Idol of Death
	20875, -- Idol of Night
	20874, -- Idol of the Sun
	20873, -- Alabaster Idol
	20872, -- Vermillion Idol
	20871, -- Obsidian Idol
	20870, -- Jasper Idol
	20869, -- Amber Idol
	20868, -- Lambent Idol
	20867, -- Onyx Idol
	20866, -- Azure Idol
	20865, -- Ivory Scarab
	20864, -- Bone Scarab
	20863, -- Clay Scarab
	20862, -- Crystal Scarab
	20861, -- Bronze Scarab
	20860, -- Silver Scarab
	20859, -- Gold Scarab
	20858, -- Stone Scarab
	20802, -- Cenarion Combat Badge
	20801, -- Cenarion Tactical Badge
	20800, -- Cenarion Logistics Badge
	20737, -- Singed Corestone
	20614, -- Bloodvenom Essence
	20613, -- Rotting Wood
	20612, -- Inert Scourgestone
	20611, -- Thick Black Claw
	20610, -- Bloodshot Spider Eye
	20609, -- Voodoo Feathers
	20608, -- Green Voodoo Feather
	20607, -- Blue Voodoo Feather
	20606, -- Amber Voodoo Feather
	20519, -- Southsea Pirate Hat
	20515, -- Abyssal Scepter
	20514, -- Abyssal Signet
	20513, -- Abyssal Crest
	20404, -- Encrypted Twilight Text
	20384, -- Silithid Carapace Fragment
	20378, -- Twilight Tablet Fragment
	20377, -- Rock Stalker Fang
	20376, -- Sand Skitterer Fang
	20375, -- Stonelash Flayer Stinger
	20374, -- Stonelash Pincer Stinger
	20373, -- Stonelash Scorpid Stinger
	20256, -- Warsong Gulch Ribbon of Sacrifice
	20087, -- Wavethrasher Scales
	20029, -- Enchanted Coral
	20028, -- Glittering Dust
	20027, -- Healthy Courser Gland
	20026, -- Rotting Flesh
	20024, -- Putrid Bile Duct
	20023, -- Encoded Fragment
	20021, -- Gold Pirate Earring
	20018, -- Angerclaw Grizzly Hide
	20017, -- Perfect Courser Antler
	19933, -- Glowing Scorpid Blood
	19911, -- Whipweed Heart
	19882, -- The Hexxer's Head
	19881, -- Channeler's Head
	19858, -- Zandalar Honor Token
	19807, -- Speckled Tastyfish
	19806, -- Dezian Queenfish
	19805, -- Keefer's Angelfish
	19803, -- Brownell's Blue Striped Racer
	19725, -- Arathi Resource Crate
	19706, -- Bloodscalp Coin
	19705, -- Skullsplitter Coin
	19704, -- Sandfury Coin
	19703, -- Witherbark Coin
	19702, -- Vilebranch Coin
	19701, -- Gurubashi Coin
	19700, -- Hakkari Coin
	19699, -- Razzashi Coin
	19698, -- Zulian Coin
	19482, -- LeCraft Rabbit Pelt
	19322, -- Warsong Mark of Honor
	19213, -- Silverwing Talisman of Merit
	19071, -- Vessel of Tainted Blood
	18961, -- Zukk'ash Carapace
	18958, -- Water Elemental Core
	18956, -- Miniaturization Residue
	18947, -- Rage Scar Yeti Hide
	18945, -- Dark Iron Residue
	18944, -- Incendosaur Scale
	18943, -- Dark Iron Pillow
	18604, -- Tears of the Hederine
	18603, -- Satyr Blood
	18590, -- Raging Beast's Blood
	18335, -- Pristine Black Diamond
	17756, -- Shadowshard Fragment
	17684, -- Theradric Crystal Carving
	17643, -- Frostwolf Hide
	17642, -- Alterac Ram Hide
	17542, -- Coldtooth Supplies
	17522, -- Irondeep Supplies
	17504, -- Frostwolf Commander's Medal
	17503, -- Frostwolf Lieutenant's Medal
	17502, -- Frostwolf Soldier's Medal
	17423, -- Storm Crystal
	17422, -- Armor Scraps
	17345, -- Silithid Goo
	17328, -- Stormpike Commander's Flesh
	17327, -- Stormpike Lieutenant's Flesh
	17326, -- Stormpike Soldier's Flesh
	17309, -- Discordant Bracers
	17306, -- Stormpike Soldier's Blood
	17124, -- Syndicate Emblem
	16786, -- Black Dragonspawn Eye
	16784, -- Sapphire of Aku'Mai
	16783, -- Bundle of Reports
	16746, -- Warsong Report
	16744, -- Warsong Oil
	16743, -- Logging Rope
	16602, -- Troll Charm
	16581, -- Resonite Crystal
	16312, -- Incendrites
	16205, -- Gaea Seed
	15924, -- Soft-shelled Clam Meat
	15852, -- Kodo Horn
	15851, -- Lunar Fungus
	15849, -- Ghost-o-plasm
	15586, -- Fast-growing Flower
	15043, -- Plagueland Termites
	14619, -- Skeletal Fragments
	13872, -- Bundle of Wood
	13853, -- Slab of Carrion Worm Meat
	13702, -- Doom Weed
	13545, -- Shellfish
	13357, -- Osseous Agitator
	13356, -- Somatic Intensifier
	13354, -- Ectoplasmic Resonator
	13180, -- Stratholme Holy Water
	13174, -- Plagued Flesh Sample
	13157, -- Fetid Skull
	12938, -- Blood of Heroes
	12844, -- Argent Dawn Valor Token
	12843, -- Corruptor's Scourgestone
	12841, -- Invader's Scourgestone
	12840, -- Minion's Scourgestone
	12822, -- Toxic Horror Droplet
	12753, -- Skin of Shadow
	12737, -- Gloom Weed
	12736, -- Frostwhisper's Embalming Fluid
	12735, -- Frayed Abomination Stitching
	12734, -- Enchanted Scarlet Thread
	12732, -- Incendia Agave
	12638, -- Andorhal Watch
	12623, -- Chillwind Meat
	12622, -- Shardtooth Meat
	12607, -- Brilliant Chromatic Scale
	12530, -- Spire Spider Egg
	12444, -- Uncracked Chillwind Horn
	12436, -- Frostmaul E'ko
	12435, -- Ice Thistle E'ko
	12434, -- Chillwind E'ko
	12433, -- Wildkin E'ko
	12432, -- Shardtooth E'ko
	12431, -- Winterfall E'ko
	12430, -- Frostsaber E'ko
	12383, -- Moontouched Feather
	12367, -- Pristine Yeti Horn
	12366, -- Thick Yeti Fur
	12356, -- Highperch Wyvern Egg
	12334, -- Frostmaul Shards
	12283, -- Broodling Essence
	12241, -- Collected Dragon Egg
	12237, -- Fine Crab Chunks
	12236, -- Pure Un'Goro Sample
	12235, -- Un'Goro Slime Sample
	12234, -- Corrupted Felwood Sample
	12230, -- Felwood Slime Sample
	12220, -- Intact Elemental Bracer
	11954, -- Filled Pure Sample Jar
	11949, -- Filled Tainted Ooze Jar
	11947, -- Filled Cursed Ooze Jar
	11834, -- Super Sticky Tar
	11831, -- Webbed Pterrordax Scale
	11830, -- Webbed Diemetradon Scale
	11829, -- Un'Goro Ash
	11754, -- Black Diamond
	11752, -- Black Blood of the Tormented
	11751, -- Burning Essence
	11725, -- Solid Crystal Leg Shaft
	11674, -- Jadefire Felbind
	11583, -- Cactus Apple
	11567, -- Crystal Spire
	11564, -- Crystal Ward
	11563, -- Crystal Force
	11562, -- Crystal Restore
	11516, -- Cenarion Plant Salve
	11515, -- Corrupted Soul Shard
	11514, -- Fel Creep
	11513, -- Tainted Vitriol
	11512, -- Patch of Tainted Skin
	11509, -- Ravasaur Pheromone Gland
	11507, -- Spotted Hyena Pelt
	11503, -- Blood Amber
	11480, -- Un'Goro Thunderer Pelt
	11479, -- Un'Goro Stomper Pelt
	11478, -- Un'Goro Gorilla Pelt
	11477, -- White Ravasaur Claw
	11472, -- Silvermane Stalker Flank
	11468, -- Dark Iron Fanny Pack
	11467, -- Blackrock Medallion
	11407, -- Torn Bear Pelt
	11404, -- Evil Bat Eye
	11318, -- Atal'ai Haze
	11316, -- Bloodpetal
	11315, -- Bloodpetal Sprout
	11269, -- Intact Elemental Core
	11266, -- Fractured Elemental Shard
	11243, -- Videre Elixir
	11188, -- Yellow Power Crystal
	11186, -- Red Power Crystal
	11185, -- Green Power Crystal
	11184, -- Blue Power Crystal
	11172, -- Silvery Claws
	11171, -- Fel Iron
	11143, -- Nugget Slug
	11129, -- Essence of the Elements
	11127, -- Scavenged Goods
	11119, -- Milly's Harvest
	11114, -- Dinosaur Bone
	11018, -- Un'Goro Soil
	10819, -- Wildkin Feather
	10714, -- Crystallized Azsharite
	10650, -- Plague-Infested Quilboar Mane
	10641, -- Moonpetal Lily
	10640, -- Webwood Ichor
	10639, -- Hyacinth Mushroom
	10593, -- Imperfect Draenethyst Fragment
	10551, -- Thorium Plated Dagger
	10511, -- Golem Oil
	10509, -- Heart of Flame
	10450, -- Undamaged Hippogryph Feather
	9741, -- Gem of Serpentis
	9740, -- Gem of Pythas
	9739, -- Gem of Anacondra
	9738, -- Gem of Cobrahn
	9597, -- Mountain Giant Muisek
	9596, -- Faerie Dragon Muisek
	9595, -- Hippogryph Muisek
	9594, -- Wildkin Muisek
	9593, -- Treant Muisek
	9592, -- Metallic Fragments
	9591, -- Resilient Sinew
	9590, -- Splintered Log
	9589, -- Encrusted Minerals
	9523, -- Troll Temper
	9463, -- Gordunni Cobalt
	9460, -- Grimtotem Horn
	9442, -- Untested Scorpid Sample
	9441, -- Acceptable Hyena Sample
	9440, -- Acceptable Basilisk Sample
	9439, -- Untested Hyena Sample
	9438, -- Acceptable Scorpid Sample
	9437, -- Untested Basilisk Sample
	9369, -- Iridescent Sprite Darter Wing
	9322, -- Undamaged Venom Sac
	9320, -- Witherbark Skull
	9309, -- Robo-mechanical Guts
	9308, -- Grime-Encrusted Object
	9278, -- Essential Artificial
	9259, -- Troll Tribal Necklace
	9247, -- Hatecrest Naga Scale
	9238, -- Uncracked Scarab Shell
	9237, -- Woodpaw Gnoll Mane
	8973, -- Thick Yeti Hide
	8684, -- Hinterlands Honey Ripple
	8683, -- Clara's Fresh Apple
	8587, -- Centipaar Insect Parts
	8483, -- Wastewander Water Pouch
	8443, -- Gahz'ridian Ornament
	8396, -- Vulture Gizzard
	8394, -- Basilisk Brain
	8393, -- Scorpok Pincer
	8392, -- Blasted Boar Lung
	8391, -- Snickerfang Jowl
	8244, -- Flawless Draenethyst Sphere
	8052, -- An'Alleum Power Stone
	8047, -- Magenta Fungus Cap
	8009, -- Dentrium Power Stone
	7867, -- Vessel of Dragon's Blood
	7848, -- Rock Elemental Shard
	7847, -- Buzzard Gizzard
	7846, -- Crag Coyote Fang
	7681, -- Obsidian Golem Shard
	7680, -- Jadespine Basilisk Scale
	7679, -- Shrike Bat Fang
	7293, -- Dalaran Mana Gem
	7292, -- Filled Containment Coffer
	7273, -- Witherbark Totem Stick
	7271, -- Flawless Ivory Tusk
	7270, -- Laughing Sister's Hair
	7267, -- Pristine Spider Silk
	7249, -- Charged Rift Gem
	7134, -- Sturdy Dragonmaw Shinbone
	7131, -- Dragonmaw Shinbone
	7128, -- Uncloven Satyr Hoof
	7126, -- Smoky Iron Ingot
	6991, -- Smoldering Coal
	6989, -- Vial of Hatefury Blood
	6952, -- Thick Bear Fur
	6930, -- Rod of Channeling
	6914, -- Soran'ruk Fragment
	6850, -- Bloodscalp Scalp
	6849, -- Sunscorched Shell
	6848, -- Searing Coral
	6845, -- Burning Rock
	6844, -- Burning Blood
	6840, -- Galvanized Horn
	6839, -- Charred Horn
	6838, -- Scorched Spider Fang
	6808, -- Elunite Ore
	6800, -- Umbral Ore
	6753, -- Feather Charm
	6718, -- Electropeller
	6717, -- Gaffer Jack
	6640, -- Felstalker Hoof
	6634, -- Ritual Salve
	6487, -- Vile Familiar Head
	6443, -- Deviate Hide
	6435, -- Infused Burning Gem
	6288, -- Atal'ai Tablet
	6281, -- Rattlecage Skull
	6259, -- Groddoc Liver
	6258, -- Ironfur Liver
	6257, -- Roc Gizzard
	6252, -- Doomwarder Blood
	6251, -- Nether Wing
	6250, -- Felhound Brain
	6249, -- Aged Kodo Hide
	6248, -- Scorpashi Venom
	6247, -- Hatefury Horn
	6246, -- Hatefury Claw
	6184, -- Monstrous Crawler Leg
	6181, -- Fetish of Hakkar
	6175, -- Atal'ai Artifact
	6169, -- Unprepared Sawtooth Flank
	6168, -- Sawtooth Snapper Claw
	6166, -- Coyote Jawbone
	6146, -- Sundried Driftwood
	6083, -- Broken Tears
	6080, -- Shadow Panther Heart
	6079, -- Crude Charm
	6071, -- Draenethyst Crystal
	6069, -- Crudely Dried Meat
	6067, -- Centaur Ear
	5959, -- Acidic Venom Sac
	5952, -- Corrupted Brain Stem
	5938, -- Pristine Crawler Leg
	5884, -- Unpopped Darkmist Eye
	5883, -- Forked Mudrock Tongue
	5879, -- Twilight Pendant
	5876, -- Blueleaf Tuber
	5855, -- Silithid Heart
	5854, -- Silithid Talon
	5853, -- Intact Silithid Carapace
	5848, -- Hollow Vulture Bone
	5847, -- Mirefin Head
	5841, -- Searing Heart
	5840, -- Searing Tongue
	5809, -- Highperch Venom Sac
	5808, -- Pridewing Venom Sac
	5805, -- Heart of Zeal
	5803, -- Speck of Dream Dust
	5801, -- Kraul Guano
	5798, -- Rocket Car Parts
	5797, -- Indurium Flake
	5796, -- Encrusted Tail Fin
	5795, -- Hardened Tortoise Shell
	5794, -- Salty Scorpid Venom
	5675, -- Crystalized Scales
	5664, -- Corroded Shrapnel
	5659, -- Smoldering Embers
	5620, -- Vial of Innocent Blood
	5585, -- Courser Eye
	5584, -- Twilight Whisker
	5583, -- Fey Dragon Scale
	5582, -- Stonetalon Sap
	5570, -- Deepmoss Egg
	5494, -- Handful of Stardust
	5490, -- Wrathtail Head
	5481, -- Satyr Horns
	5438, -- OLDPlague Vials
	5437, -- Bathran's Hair
	5414, -- Grizzled Scalp
	5413, -- Moonstalker Fang
	5412, -- Thresher Eye
	5386, -- Fine Moonstalker Pelt
	5385, -- Crawler Leg
	5360, -- Highborne Relic
	5348, -- Worn Parchment
	5339, -- Serpentbloom
	5336, -- Grell Earring
	5330, -- Elven Cup Relic
	5273, -- Mathystra Relic
	5271, -- Scaber Stalk
	5270, -- Death Cap
	5220, -- Gnarlpine Fang
	5204, -- Bloodfeather Belt
	5203, -- Flatland Prowler Claw
	5170, -- Mossy Tumor
	5169, -- Timberling Sprout
	5168, -- Timberling Seed
	5167, -- Webwood Egg
	5166, -- Webwood Venom Sac
	5165, -- Sunscale Feather
	5143, -- Thunder Lizard Blood
	5134, -- Small Furry Paw
	5117, -- Vibrant Plume
	5098, -- Altered Snapjaw Shell
	5096, -- Prowler Claws
	5087, -- Plainstrider Beak
	5086, -- Zhevra Hooves
	5085, -- Bristleback Quilboar Tusk
	5080, -- Gazlowe's Ledger
	5078, -- Theramore Medal
	5077, -- Telescopic Lens
	5076, -- Shipment of Boots
	5075, -- Blood Shard
	5065, -- Harpy Lieutenant Ring
	5064, -- Witchwing Talon
	5062, -- Raptor Head
	5061, -- Stolen Silver
	5058, -- Silithid Egg
	5056, -- Root Sample
	5055, -- Intact Raptor Horn
	5051, -- Dig Rat
	5030, -- Centaur Bracers
	5019, -- Sodium Nitrate
	5018, -- Wood Pulp
	5017, -- Nitroglycerin
	5012, -- Fungal Spores
	4918, -- Sack of Supplies
	4904, -- Venomtail Antidote
	4898, -- Lightning Gland
	4897, -- Thunderhawk Saliva Gland
	4896, -- Kodo Liver
	4894, -- Plainstrider Kidney
	4893, -- Savannah Lion Tusk
	4892, -- Durotar Tiger Fur
	4890, -- Taillasher Egg
	4888, -- Crawler Mucus
	4887, -- Intact Makrura Eye
	4886, -- Venomtail Poison Sac
	4871, -- Searing Collar
	4870, -- Canvas Scraps
	4864, -- Minshina's Skull
	4863, -- Gnomish Tools
	4862, -- Scorpid Worker Tail
	4849, -- Battleboar Flank
	4848, -- Battleboar Snout
	4809, -- Ambercorn
	4808, -- Well Stone
	4803, -- Prairie Alpha Tooth
	4802, -- Cougar Claws
	4801, -- Stalker Claws
	4770, -- Bristleback Belt
	4769, -- Trophy Swoop Quill
	4759, -- Plainstrider Talon
	4758, -- Prairie Wolf Paw
	4753, -- Bronze Feather
	4752, -- Azure Feather
	4751, -- Windfury Talon
	4742, -- Mountain Cougar Pelt
	4740, -- Plainstrider Feather
	4739, -- Plainstrider Meat
	4703, -- Broken Tools
	4702, -- Prospector's Pick
	4630, -- Scrap Metal
	4629, -- Supply Crate
	4628, -- Bracers of Rock Binding
	4627, -- Large Stone Slab
	4626, -- Small Stone Shard
	4612, -- Black Drake's Heart
	4610, -- Carved Stone Urn
	4589, -- Long Elegant Feather
	4582, -- Soft Bushy Tail
	4522, -- Witherbark Medicine Pouch
	4521, -- Alterac Granite
	4513, -- Raptor Heart
	4512, -- Highland Raptor Eye
	4506, -- Stromgarde Badge
	4503, -- Witherbark Tusk
	4495, -- Bloodstone Amulet
	4492, -- Elven Gem
	4450, -- Sigil Fragment
	4435, -- Mote of Myzrael
	4278, -- Lesser Bloodstone Ore
	4106, -- Tumbled Crystal
	4105, -- Elder Crocolisk Skin
	4104, -- Snapjaw Crocolisk Skin
	4053, -- Large River Crocolisk Skin
	4029, -- Akiris Reed
	4016, -- Zanzil's Mixture
	3923, -- Water Elemental Bracers
	3919, -- Mistvale Giblets
	3918, -- Singing Crystal Shard
	3917, -- Singing Blue Crystal
	3916, -- Split Bone Necklace
	3915, -- Bloody Bone Necklace
	3911, -- Pulsing Blue Shard
	3910, -- Snuff
	3908, -- Zul'Mamwe Trophy
	3907, -- Ziata'jai Trophy
	3906, -- Balia'mah Trophy
	3901, -- Bloodscalp Tusk
	3900, -- Pupellyverbos Port
	3863, -- Jungle Stalker Feather
	3838, -- Shadowmaw Claw
	3720, -- Yeti Fur
	3716, -- Murloc Head
	3715, -- Bracers of Earth Binding
	3714, -- Worn Stone Token
	3692, -- Hillsbrad Human Skull
	3658, -- Recovered Tome
	3510, -- Torn Fin Eye
	3509, -- Daggerspine Scale
	3505, -- Alterac Signet Ring
	3502, -- Mudsnout Blossoms
	3496, -- Mountain Lion Blood
	3476, -- Gray Bear Tongue
	3418, -- Fel Cone
	3412, -- Webwood Spider Silk
	3411, -- Strigid Owl Feather
	3409, -- Nightsaber Fang
	3397, -- Young Crocolisk Skin
	3354, -- Dalaran Pendant
	3348, -- Giant Crocolisk Skin
	3337, -- Dragonmaw War Banner
	3297, -- Fel Moss
	3266, -- Scarlet Armband
	3265, -- Scavenger Paw
	3264, -- Duskbat Wing
	3257, -- Lake Creeper Moss
	3256, -- Lake Skulker Moss
	3254, -- Skittering Blood
	3253, -- Grizzled Bear Heart
	3236, -- Rot Hide Ichor
	3218, -- Pyrewood Shackle
	3163, -- Blackened Skull
	3162, -- Notched Rib
	3157, -- Darksoul Shackle
	3156, -- Glutton Shackle
	3110, -- Tunnel Rat Ear
	3084, -- Gyromechanic Gear
	3083, -- Restabilization Cog
	3014, -- Battleworn Axe
	2925, -- Crocolisk Skin
	2909, -- Red Wool Bandana
	2876, -- Duskbat Pelt
	2875, -- Scarlet Insignia Ring
	2872, -- Vicious Night Web Spider Venom
	2859, -- Vile Fin Scale
	2858, -- Darkhound Blood
	2856, -- Iron Pike
	2855, -- Putrid Claw
	2846, -- Tirisfal Pumpkin
	2843, -- Dirty Knucklebones
	2834, -- Embalming Ichor
	2799, -- Gorilla Fang
	2798, -- Rethban Ore
	2751, -- Green Hills of Stranglethorn - Page 27
	2750, -- Green Hills of Stranglethorn - Page 26
	2749, -- Green Hills of Stranglethorn - Page 25
	2748, -- Green Hills of Stranglethorn - Page 24
	2745, -- Green Hills of Stranglethorn - Page 21
	2744, -- Green Hills of Stranglethorn - Page 20
	2742, -- Green Hills of Stranglethorn - Page 18
	2740, -- Green Hills of Stranglethorn - Page 16
	2738, -- Green Hills of Stranglethorn - Page 14
	2735, -- Green Hills of Stranglethorn - Page 11
	2734, -- Green Hills of Stranglethorn - Page 10
	2732, -- Green Hills of Stranglethorn - Page 8
	2730, -- Green Hills of Stranglethorn - Page 6
	2728, -- Green Hills of Stranglethorn - Page 4
	2725, -- Green Hills of Stranglethorn - Page 1
	2702, -- Lightforge Ingot
	2676, -- Shimmerweed
	2671, -- Wendigo Mane
	2669, -- Threshadon Claw
	2668, -- Threshadon Tooth
	2640, -- Miners' Gear
	2636, -- Carved Stone Idol
	2611, -- Crude Flint
	2536, -- Trogg Stone Tooth
	2477, -- Ravager's Skull
	2476, -- Chilled Basilisk Haunch
	2466, -- Skullsplitter Fetish
	2378, -- Skeleton Finger
	1894, -- Miners' Union Card
	1598, -- Rot Blossom
	1532, -- Shrunken Head
	1528, -- Handful of Oats
	1524, -- Skullsplitter Tusk
	1519, -- Bloodscalp Ear
	1467, -- Spotted Sunfish
	1356, -- Commendation - Elwynn Forest
	1261, -- Midnight Orb
	1256, -- Crystal Kelp Frond
	1221, -- Underbelly Whelp Scale
	1130, -- Vial of Spider Venom
	1129, -- Ghoul Fang
	1075, -- Shadowhide Pendant
	1019, -- Red Linen Bandana
	1013, -- Iron Rivet
	915, -- Red Silk Bandana
	896, -- Worgen Fang
	895, -- Worgen Skull
	884, -- Ghoul Rib
	829, -- Red Leather Bandana
	782, -- Painted Gnoll Armband
	780, -- Torn Murloc Fin
	773, -- Gold Dust
	772, -- Large Candle
	752, -- Red Burlap Bandana
	750, -- Tough Wolf Meat
	740, -- Sack of Rye
	739, -- Sack of Corn
	738, -- Sack of Barley
	725, -- Gnoll Paw
}

