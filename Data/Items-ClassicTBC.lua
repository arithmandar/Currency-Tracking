local _G = getfenv(0)
local _, private = ...

-- Determine WoW client family
local GetBuildInfo = _G.GetBuildInfo
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

if not isAnniversaryTBC then return end

local items = {}
private.items = items

-- Criteria: Reagent for Tailoring & stacks up to > 1
items.Tailoring = {
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;10:1:2;0:1:0
    [2] = { -- Burning Crusade
        34664, -- Sunmote
        32428, -- Heart of Darkness
        30183, -- Nether Vortex
        24272, -- Shadowcloth
        24271, -- Spellcloth
        23572, -- Primal Nether
        23571, -- Primal Might
        22794, -- Fel Lotus
        22457, -- Primal Mana
        22456, -- Primal Shadow
        22452, -- Primal Earth
        22451, -- Primal Air
        22450, -- Void Crystal
        22446, -- Greater Planar Essence
        22445, -- Arcane Dust
        21887, -- Knothide Leather
        21886, -- Primal Life
        21885, -- Primal Water
        21884, -- Primal Fire
        21882, -- Soul Essence
        21881, -- Netherweb Spider Silk
        21877, -- Netherweave Cloth
        21845, -- Primal Mooncloth
        21844, -- Bolt of Soulcloth
        21842, -- Bolt of Imbued Netherweave
        21840, -- Bolt of Netherweave
    },
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;10:1:1;0:1:0
    [1] = { -- Vanilla
        22682, -- Frozen Rune
        20520, -- Dark Rune
        19726, -- Bloodvine
        18240, -- Ogre Tannin
        17012, -- Core Leather
        17011, -- Lava Core
        17010, -- Fiery Core
        16203, -- Greater Eternal Essence
        14344, -- Large Brilliant Shard
        14342, -- Mooncloth
        14341, -- Rune Thread
        14256, -- Felcloth
        14227, -- Ironweb Spider Silk
        14048, -- Bolt of Runecloth
        14047, -- Runecloth
        13926, -- Golden Pearl
        13468, -- Black Lotus
        12811, -- Righteous Orb
        12810, -- Enchanted Leather
        12809, -- Guardian Stone
        12808, -- Essence of Undeath
        12804, -- Powerful Mojo
        12803, -- Living Essence
        12800, -- Azerothian Diamond
        12662, -- Demonic Rune
        12364, -- Huge Emerald
        12360, -- Arcanite Bar
        11176, -- Dream Dust
        11137, -- Vision Dust
        11040, -- Morrowgrain
        10290, -- Pink Dye
        10286, -- Heart of the Wild
        10285, -- Shadow Silk
        9210, -- Ghost Dye
        8831, -- Purple Lotus
        8343, -- Heavy Silken Thread
        8170, -- Rugged Leather
        8153, -- Wildvine
        7972, -- Ichor of Undeath
        7971, -- Black Pearl
        7910, -- Star Ruby
        7082, -- Essence of Air
        7080, -- Essence of Water
        7079, -- Globe of Water
        7078, -- Essence of Fire
        7077, -- Heart of Fire
        7076, -- Essence of Earth
        7072, -- Naga Scale
        7071, -- Iron Buckle
        7070, -- Elemental Water
        7069, -- Elemental Air
        7068, -- Elemental Fire
        7067, -- Elemental Earth
        6371, -- Fire Oil
        6261, -- Orange Dye
        6260, -- Blue Dye
        6048, -- Shadow Protection Potion
        6037, -- Truesilver Bar
        5500, -- Iridescent Pearl
        5498, -- Small Lustrous Pearl
        4625, -- Firebloom
        4589, -- Long Elegant Feather
        4342, -- Purple Dye
        4341, -- Yellow Dye
        4340, -- Gray Dye
        4339, -- Bolt of Mageweave
        4338, -- Mageweave Cloth
        4337, -- Thick Spider's Silk
        4306, -- Silk Cloth
        4305, -- Bolt of Silk Cloth
        4304, -- Thick Leather
        4291, -- Silken Thread
        4234, -- Heavy Leather
        3864, -- Citrine
        3829, -- Frost Oil
        3827, -- Mana Potion
        3824, -- Shadow Oil
        3577, -- Gold Bar
        3383, -- Elixir of Wisdom
        3182, -- Spider's Silk
        2997, -- Bolt of Woolen Cloth
        2996, -- Bolt of Linen Cloth
        2605, -- Green Dye
        2604, -- Red Dye
        2592, -- Wool Cloth
        2589, -- Linen Cloth
        2325, -- Black Dye
        2324, -- Bleach
        2321, -- Fine Thread
        2320, -- Coarse Thread
        2319, -- Medium Leather
        2318, -- Light Leather
        1529, -- Jade
        929, -- Healing Potion
    },
}

-- Criteria: Reagent for Leatherworking & stacks up to > 1
items.Leatherworking = {
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;8:1:2;0:1:0
    [2] = { -- Burning Crusade
        34664, -- Sunmote
        32428, -- Heart of Darkness
        30183, -- Nether Vortex
        29548, -- Nether Dragonscales
        29547, -- Wind Scales
        29539, -- Cobra Scales
        25719, -- Arakkoa Feather
        25708, -- Thick Clefthoof Leather
        25707, -- Fel Hide
        25700, -- Fel Scales
        25699, -- Crystal Infused Leather
        25649, -- Knothide Leather Scraps
        23793, -- Heavy Knothide Leather
        23572, -- Primal Nether
        23571, -- Primal Might
        22457, -- Primal Mana
        22456, -- Primal Shadow
        22452, -- Primal Earth
        22451, -- Primal Air
        22450, -- Void Crystal
        22448, -- Small Prismatic Shard
        22445, -- Arcane Dust
        21887, -- Knothide Leather
        21886, -- Primal Life
        21885, -- Primal Water
        21884, -- Primal Fire
        21844, -- Bolt of Soulcloth
    },
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;8:1:1;0:1:0
    [1] = { -- Vanilla
        22682, -- Frozen Rune
        20501, -- Heavy Silithid Carapace
        20500, -- Light Silithid Carapace
        20498, -- Silithid Chitin
        20381, -- Dreamscale
        19768, -- Primal Tiger Leather
        19767, -- Primal Bat Leather
        19726, -- Bloodvine
        18512, -- Larval Acid
        18240, -- Ogre Tannin
        17056, -- Light Feather
        17012, -- Core Leather
        17011, -- Lava Core
        17010, -- Fiery Core
        15423, -- Chimera Leather
        15422, -- Frostsaber Leather
        15420, -- Ironfeather
        15419, -- Warbear Leather
        15417, -- Devilsaur Leather
        15416, -- Black Dragonscale
        15415, -- Blue Dragonscale
        15414, -- Red Dragonscale
        15412, -- Green Dragonscale
        15410, -- Scale of Onyxia
        15409, -- Refined Deeprock Salt
        15408, -- Heavy Scorpid Scale
        15407, -- Cured Rugged Hide
        14342, -- Mooncloth
        14341, -- Rune Thread
        14256, -- Felcloth
        14227, -- Ironweb Spider Silk
        14048, -- Bolt of Runecloth
        14047, -- Runecloth
        12810, -- Enchanted Leather
        12809, -- Guardian Stone
        12804, -- Powerful Mojo
        12803, -- Living Essence
        12753, -- Skin of Shadow
        12607, -- Brilliant Chromatic Scale
        11754, -- Black Diamond
        8951, -- Elixir of Greater Defense
        8949, -- Elixir of Agility
        8368, -- Thick Wolfhide
        8343, -- Heavy Silken Thread
        8172, -- Cured Thick Hide
        8171, -- Rugged Hide
        8170, -- Rugged Leather
        8169, -- Thick Hide
        8168, -- Jet Black Feather
        8167, -- Turtle Scale
        8165, -- Worn Dragonscale
        8154, -- Scorpid Scale
        8153, -- Wildvine
        8152, -- Flask of Big Mojo
        8151, -- Flask of Mojo
        8150, -- Deeprock Salt
        8146, -- Wicked Claw
        7971, -- Black Pearl
        7428, -- Shadowcat Hide
        7392, -- Green Whelp Scale
        7287, -- Red Whelp Scale
        7286, -- Black Whelp Scale
        7082, -- Essence of Air
        7081, -- Breath of Wind
        7080, -- Essence of Water
        7079, -- Globe of Water
        7078, -- Essence of Fire
        7077, -- Heart of Fire
        7076, -- Essence of Earth
        7075, -- Core of Earth
        7071, -- Iron Buckle
        7070, -- Elemental Water
        7067, -- Elemental Earth
        6471, -- Perfect Deviate Scale
        6470, -- Deviate Scale
        5785, -- Thick Murloc Scale
        5784, -- Slimy Murloc Scale
        5637, -- Large Fang
        5633, -- Great Rage Potion
        5500, -- Iridescent Pearl
        5498, -- Small Lustrous Pearl
        5373, -- Lucky Charm
        5116, -- Long Tail Feather
        5082, -- Thin Kodo Leather
        4461, -- Raptor Hide
        4342, -- Purple Dye
        4340, -- Gray Dye
        4338, -- Mageweave Cloth
        4337, -- Thick Spider's Silk
        4305, -- Bolt of Silk Cloth
        4304, -- Thick Leather
        4291, -- Silken Thread
        4289, -- Salt
        4236, -- Cured Heavy Hide
        4235, -- Heavy Hide
        4234, -- Heavy Leather
        4233, -- Cured Medium Hide
        4232, -- Medium Hide
        4231, -- Cured Light Hide
        4096, -- Coarse Gorilla Hair
        3864, -- Citrine
        3824, -- Shadow Oil
        3390, -- Elixir of Lesser Agility
        3389, -- Elixir of Defense
        3383, -- Elixir of Wisdom
        3356, -- Kingsblood
        3182, -- Spider's Silk
        2997, -- Bolt of Woolen Cloth
        2934, -- Ruined Leather Scraps
        2840, -- Copper Bar
        2605, -- Green Dye
        2604, -- Red Dye
        2459, -- Swiftness Potion
        2457, -- Elixir of Minor Agility
        2325, -- Black Dye
        2324, -- Bleach
        2321, -- Fine Thread
        2320, -- Coarse Thread
        2319, -- Medium Leather
        2318, -- Light Leather
        1529, -- Jade
        1210, -- Shadowgem
        1206, -- Moss Agate
        783, -- Light Hide
    },
}

-- Criteria: Reagent for Cooking & stacks up to > 1
items.Cooking = {
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;3:1:2;0:1:0
    [2] = { -- Burning Crusade
        35562, -- Bear Flank
        34412, -- Sparkling Apple Cider
        33824, -- Crescent-Tail Skullfish
        33823, -- Bloodfin Catfish
        31671, -- Serpent Flesh
        31670, -- Raptor Ribs
        30817, -- Simple Flour
        27682, -- Talbuk Venison
        27681, -- Warped Flesh
        27678, -- Clefthoof Meat
        27677, -- Chunk o' Basilisk
        27676, -- Strange Spores
        27674, -- Ravager Flesh
        27671, -- Buzzard Meat
        27669, -- Bat Flesh
        27668, -- Lynx Meat
        27516, -- Enormous Barbed Gill Trout
        27515, -- Huge Spotted Feltail
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
    },
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;3:1:1;0:1:0
    [1] = { -- Vanilla
        21153, -- Raw Greater Sagefish
        21071, -- Raw Sagefish
        21024, -- Chimaerok Tenderloin
        20424, -- Sandworm Meat
        18255, -- Runn Tum Tuber
        17196, -- Holiday Spirits
        17194, -- Holiday Spices
        13893, -- Large Raw Mightfish
        13889, -- Raw Whitescale Salmon
        13888, -- Darkclaw Lobster
        13760, -- Raw Sunscale Salmon
        13759, -- Raw Nightfin Snapper
        13758, -- Raw Redgill
        13757, -- Lightning Eel
        13756, -- Raw Summer Bass
        13755, -- Winter Squid
        13754, -- Raw Glossy Mightfish
        12223, -- Meaty Bat Wing
        12208, -- Tender Wolf Meat
        12207, -- Giant Egg
        12206, -- Tender Crab Meat
        12205, -- White Spider Meat
        12204, -- Heavy Kodo Meat
        12203, -- Red Wolf Meat
        12202, -- Tiger Meat
        12184, -- Raptor Flesh
        12037, -- Mystery Meat
        9061, -- Goblin Rocket Fuel
        8365, -- Raw Mithril Head Trout
        8150, -- Deeprock Salt
        7974, -- Zesty Clam Meat
        6889, -- Small Egg
        6522, -- Deviate Fish
        6362, -- Raw Rockscale Cod
        6361, -- Raw Rainbow Fin Albacore
        6317, -- Raw Loch Frenzy
        6308, -- Raw Bristle Whisker Catfish
        6303, -- Raw Slitherskin Mackerel
        6291, -- Raw Brilliant Smallfish
        6289, -- Raw Longjaw Mud Snapper
        5504, -- Tangy Clam Meat
        5503, -- Clam Meat
        5471, -- Stag Meat
        5470, -- Thunder Lizard Tail
        5469, -- Strider Meat
        5468, -- Soft Frenzy Flesh
        5467, -- Kodo Meat
        5466, -- Scorpid Stinger
        5465, -- Small Spider Leg
        5051, -- Dig Rat
        4655, -- Giant Clam Meat
        4603, -- Raw Spotted Yellowtail
        4539, -- Goldenbark Apple
        4536, -- Shiny Red Apple
        4470, -- Simple Wood
        4402, -- Small Flame Sac
        3821, -- Goldthorn
        3731, -- Lion Meat
        3730, -- Big Bear Meat
        3713, -- Soothing Spices
        3712, -- Turtle Meat
        3685, -- Raptor Egg
        3667, -- Tender Crocolisk Meat
        3404, -- Buzzard Wing
        3174, -- Spider Ichor
        3173, -- Bear Meat
        3172, -- Boar Intestines
        2924, -- Crocolisk Meat
        2894, -- Rhapsody Malt
        2886, -- Crag Boar Rib
        2692, -- Hot Spices
        2678, -- Mild Spices
        2677, -- Boar Ribs
        2675, -- Crawler Claw
        2674, -- Crawler Meat
        2673, -- Coyote Meat
        2672, -- Stringy Wolf Meat
        2665, -- Stormwind Seasoning Herbs
        2596, -- Skin of Dwarven Stout
        2594, -- Flagon of Dwarven Honeymead
        2593, -- Flask of Stormwind Tawny
        2452, -- Swiftthistle
        2251, -- Gooey Spider Leg
        1468, -- Murloc Fin
        1179, -- Ice Cold Milk
        1081, -- Crisp Spider Meat
        1080, -- Tough Condor Meat
        1015, -- Lean Wolf Flank
        785, -- Mageroyal
        769, -- Chunk of Boar Meat
        731, -- Goretusk Snout
        730, -- Murloc Eye
        729, -- Stringy Vulture Meat
        723, -- Goretusk Liver
        159, -- Refreshing Spring Water
    },
}

-- Criteria: Reagent for Alchemy & stacks up to > 1
items.Alchemy = {
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;1:1:2;0:1:0
    [2] = { -- Burning Crusade
        30183, -- Nether Vortex
        25868, -- Skyfire Diamond
        25867, -- Earthstorm Diamond
        23782, -- Fel Iron Casing
        23571, -- Primal Might
        23117, -- Azure Moonstone
        23112, -- Golden Draenite
        23107, -- Shadow Draenite
        23079, -- Deep Peridot
        23077, -- Blood Garnet
        22794, -- Fel Lotus
        22793, -- Mana Thistle
        22792, -- Nightmare Vine
        22791, -- Netherbloom
        22790, -- Ancient Lichen
        22789, -- Terocone
        22787, -- Ragveil
        22786, -- Dreaming Glory
        22785, -- Felweed
        22578, -- Mote of Water
        22574, -- Mote of Fire
        22573, -- Mote of Earth
        22457, -- Primal Mana
        22456, -- Primal Shadow
        22452, -- Primal Earth
        22451, -- Primal Air
        21929, -- Flame Spessarite
        21886, -- Primal Life
        21885, -- Primal Water
        21884, -- Primal Fire
    },
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;1:1:1;0:1:0
    [1] = { -- Vanilla
        19943, -- Massive Mojo
        18256, -- Imbued Vial
        13468, -- Black Lotus
        13467, -- Icecap
        13466, -- Plaguebloom
        13465, -- Mountain Silversage
        13464, -- Golden Sansam
        13463, -- Dreamfoil
        13423, -- Stonescale Oil
        13422, -- Stonescale Eel
        12938, -- Blood of Heroes
        12808, -- Essence of Undeath
        12804, -- Powerful Mojo
        12803, -- Living Essence
        12363, -- Arcane Crystal
        12359, -- Thorium Bar
        11176, -- Dream Dust
        10620, -- Thorium Ore
        10286, -- Heart of the Wild
        9262, -- Black Vitriol
        9260, -- Volatile Rum
        8925, -- Crystal Vial
        8846, -- Gromsblood
        8845, -- Ghost Mushroom
        8839, -- Blindweed
        8838, -- Sungrass
        8836, -- Arthas' Tears
        8831, -- Purple Lotus
        8153, -- Wildvine
        7972, -- Ichor of Undeath
        7082, -- Essence of Air
        7080, -- Essence of Water
        7078, -- Essence of Fire
        7077, -- Heart of Fire
        7076, -- Essence of Earth
        7070, -- Elemental Water
        7068, -- Elemental Fire
        7067, -- Elemental Earth
        6522, -- Deviate Fish
        6371, -- Fire Oil
        6370, -- Blackmouth Oil
        6359, -- Firefin Snapper
        6358, -- Oily Blackmouth
        5637, -- Large Fang
        5635, -- Sharp Claw
        4625, -- Firebloom
        4402, -- Small Flame Sac
        4342, -- Purple Dye
        3860, -- Mithril Bar
        3858, -- Mithril Ore
        3824, -- Shadow Oil
        3821, -- Goldthorn
        3820, -- Stranglekelp
        3819, -- Wintersbite
        3818, -- Fadeleaf
        3575, -- Iron Bar
        3372, -- Leaded Vial
        3371, -- Empty Vial
        3369, -- Grave Moss
        3358, -- Khadgar's Whisker
        3357, -- Liferoot
        3356, -- Kingsblood
        3355, -- Wild Steelbloom
        3164, -- Discolored Worg Heart
        2453, -- Bruiseweed
        2452, -- Swiftthistle
        2450, -- Briarthorn
        2449, -- Earthroot
        2447, -- Peacebloom
        1288, -- Large Venom Sac
        785, -- Mageroyal
        765, -- Silverleaf
        118, -- Minor Healing Potion
    },
}

-- Criteria: Reagent for Enchanting & stacks up to > 1
items.Enchanting = {
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;4:1:2;0:1:0
    [2] = { -- Burning Crusade
        23572, -- Primal Nether
        23571, -- Primal Might
        23427, -- Eternium Ore
        22824, -- Elixir of Major Strength
        22794, -- Fel Lotus
        22792, -- Nightmare Vine
        22791, -- Netherbloom
        22578, -- Mote of Water
        22574, -- Mote of Fire
        22573, -- Mote of Earth
        22572, -- Mote of Air
        22457, -- Primal Mana
        22456, -- Primal Shadow
        22452, -- Primal Earth
        22451, -- Primal Air
        22450, -- Void Crystal
        22449, -- Large Prismatic Shard
        22448, -- Small Prismatic Shard
        22447, -- Lesser Planar Essence
        22446, -- Greater Planar Essence
        22445, -- Arcane Dust
        21886, -- Primal Life
        21885, -- Primal Water
        21884, -- Primal Fire
    },
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;4:1:1;0:1:0
    [1] = { -- Vanilla
        20725, -- Nexus Crystal
        18256, -- Imbued Vial
        17035, -- Stranglethorn Seed
        17034, -- Maple Seed
        16204, -- Illusion Dust
        16203, -- Greater Eternal Essence
        16202, -- Lesser Eternal Essence
        14344, -- Large Brilliant Shard
        14343, -- Small Brilliant Shard
        13926, -- Golden Pearl
        13467, -- Icecap
        13446, -- Major Healing Potion
        13444, -- Major Mana Potion
        12811, -- Righteous Orb
        12808, -- Essence of Undeath
        12803, -- Living Essence
        12359, -- Thorium Bar
        11382, -- Blood of the Mountain
        11291, -- Star Wood
        11178, -- Large Radiant Shard
        11177, -- Small Radiant Shard
        11176, -- Dream Dust
        11175, -- Greater Nether Essence
        11174, -- Lesser Nether Essence
        11139, -- Large Glowing Shard
        11138, -- Small Glowing Shard
        11137, -- Vision Dust
        11135, -- Greater Mystic Essence
        11134, -- Lesser Mystic Essence
        11084, -- Large Glimmering Shard
        11083, -- Soul Dust
        11082, -- Greater Astral Essence
        10998, -- Lesser Astral Essence
        10978, -- Small Glimmering Shard
        10940, -- Strange Dust
        10939, -- Greater Magic Essence
        10938, -- Lesser Magic Essence
        9224, -- Elixir of Demonslaying
        8925, -- Crystal Vial
        8838, -- Sungrass
        8831, -- Purple Lotus
        8170, -- Rugged Leather
        8153, -- Wildvine
        7972, -- Ichor of Undeath
        7971, -- Black Pearl
        7909, -- Aquamarine
        7392, -- Green Whelp Scale
        7082, -- Essence of Air
        7081, -- Breath of Wind
        7080, -- Essence of Water
        7079, -- Globe of Water
        7078, -- Essence of Fire
        7077, -- Heart of Fire
        7076, -- Essence of Earth
        7075, -- Core of Earth
        7068, -- Elemental Fire
        7067, -- Elemental Earth
        6371, -- Fire Oil
        6370, -- Blackmouth Oil
        6048, -- Shadow Protection Potion
        6037, -- Truesilver Bar
        5637, -- Large Fang
        5500, -- Iridescent Pearl
        4625, -- Firebloom
        4470, -- Simple Wood
        3829, -- Frost Oil
        3819, -- Wintersbite
        3372, -- Leaded Vial
        3371, -- Empty Vial
        3356, -- Kingsblood
        2772, -- Iron Ore
    },
}

-- Criteria: Reagent for Engineering & stacks up to > 1
items.Engineering = {
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;5:1:2;0:1:0
    [2] = { -- Burning Crusade
        35128, -- Hardened Khorium
        32423, -- Icy Blasting Primers
        24272, -- Shadowcloth
        24271, -- Spellcloth
        23826, -- The Bigger One
        23819, -- Elemental Seaforium Charge
        23793, -- Heavy Knothide Leather
        23787, -- Felsteel Stabilizer
        23786, -- Khorium Power Core
        23785, -- Hardened Adamantite Tube
        23784, -- Adamantite Frame
        23783, -- Handful of Fel Iron Bolts
        23782, -- Fel Iron Casing
        23781, -- Elemental Blasting Powder
        23573, -- Hardened Adamantite Bar
        23572, -- Primal Nether
        23571, -- Primal Might
        23449, -- Khorium Bar
        23448, -- Felsteel Bar
        23446, -- Adamantite Bar
        23445, -- Fel Iron Bar
        23441, -- Nightseye
        23440, -- Dawnstone
        23439, -- Noble Topaz
        23438, -- Star of Elune
        23437, -- Talasite
        23436, -- Living Ruby
        23112, -- Golden Draenite
        23079, -- Deep Peridot
        23077, -- Blood Garnet
        22832, -- Super Mana Potion
        22829, -- Super Healing Potion
        22574, -- Mote of Fire
        22573, -- Mote of Earth
        22457, -- Primal Mana
        22456, -- Primal Shadow
        22452, -- Primal Earth
        22451, -- Primal Air
        22449, -- Large Prismatic Shard
        22448, -- Small Prismatic Shard
        22445, -- Arcane Dust
        21929, -- Flame Spessarite
        21887, -- Knothide Leather
        21886, -- Primal Life
        21885, -- Primal Water
        21884, -- Primal Fire
        21877, -- Netherweave Cloth
        21840, -- Bolt of Netherweave
        20816, -- Delicate Copper Wire
    },
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;5:1:1;0:1:0
    [1] = { -- Vanilla
        19774, -- Souldarite
        19726, -- Bloodvine
        18631, -- Truesilver Transformer
        17202, -- Snowball
        17020, -- Arcane Powder
        17011, -- Lava Core
        17010, -- Fiery Core
        16006, -- Delicate Arcanite Converter
        16000, -- Thorium Tube
        15994, -- Thorium Widget
        15992, -- Dense Blasting Powder
        15407, -- Cured Rugged Hide
        14227, -- Ironweb Spider Silk
        14047, -- Runecloth
        13467, -- Icecap
        12810, -- Enchanted Leather
        12808, -- Essence of Undeath
        12804, -- Powerful Mojo
        12803, -- Living Essence
        12800, -- Azerothian Diamond
        12799, -- Large Opal
        12655, -- Enchanted Thorium Bar
        12365, -- Dense Stone
        12364, -- Huge Emerald
        12361, -- Blue Sapphire
        12360, -- Arcanite Bar
        12359, -- Thorium Bar
        11371, -- Dark Iron Bar
        11291, -- Star Wood
        10648, -- Blank Parchment
        10647, -- Engineer's Ink
        10592, -- Catseye Elixir
        10586, -- The Big One
        10561, -- Mithril Casing
        10560, -- Unstable Trigger
        10559, -- Mithril Tube
        10558, -- Gold Power Core
        10546, -- Deadly Scope
        10507, -- Solid Dynamite
        10505, -- Solid Blasting Powder
        10286, -- Heart of the Wild
        10285, -- Shadow Silk
        9061, -- Goblin Rocket Fuel
        9060, -- Inlaid Mithril Cylinder
        8170, -- Rugged Leather
        8153, -- Wildvine
        8151, -- Flask of Mojo
        8150, -- Deeprock Salt
        7972, -- Ichor of Undeath
        7912, -- Solid Stone
        7910, -- Star Ruby
        7909, -- Aquamarine
        7191, -- Fused Wiring
        7082, -- Essence of Air
        7080, -- Essence of Water
        7079, -- Globe of Water
        7078, -- Essence of Fire
        7077, -- Heart of Fire
        7076, -- Essence of Earth
        7075, -- Core of Earth
        7069, -- Elemental Air
        7068, -- Elemental Fire
        7067, -- Elemental Earth
        6530, -- Nightcrawlers
        6037, -- Truesilver Bar
        4611, -- Blue Pearl
        4470, -- Simple Wood
        4407, -- Accurate Scope
        4404, -- Silver Contact
        4402, -- Small Flame Sac
        4400, -- Heavy Stock
        4399, -- Wooden Stock
        4394, -- Big Iron Bomb
        4389, -- Gyrochronatom
        4387, -- Iron Strut
        4382, -- Bronze Framework
        4377, -- Heavy Blasting Powder
        4375, -- Whirring Bronze Gizmo
        4371, -- Bronze Tube
        4364, -- Coarse Blasting Powder
        4363, -- Copper Modulator
        4361, -- Copper Tube
        4359, -- Handful of Copper Bolts
        4357, -- Rough Blasting Powder
        4342, -- Purple Dye
        4339, -- Bolt of Mageweave
        4338, -- Mageweave Cloth
        4337, -- Thick Spider's Silk
        4306, -- Silk Cloth
        4304, -- Thick Leather
        4234, -- Heavy Leather
        3864, -- Citrine
        3860, -- Mithril Bar
        3859, -- Steel Bar
        3829, -- Frost Oil
        3577, -- Gold Bar
        3575, -- Iron Bar
        2880, -- Weak Flux
        2842, -- Silver Bar
        2841, -- Bronze Bar
        2840, -- Copper Bar
        2838, -- Heavy Stone
        2836, -- Coarse Stone
        2835, -- Rough Stone
        2605, -- Green Dye
        2592, -- Wool Cloth
        2589, -- Linen Cloth
        2319, -- Medium Leather
        2318, -- Light Leather
        1705, -- Lesser Moonstone
        1529, -- Jade
        1210, -- Shadowgem
        1206, -- Moss Agate
        818, -- Tigerseye
        814, -- Flask of Oil
        774, -- Malachite
        159, -- Refreshing Spring Water
    },
}

-- Criteria: Reagent for Blacksmithing & stacks up to > 1
items.Blacksmithing = {
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;2:1:2;0:1:0
    [2] = { -- Burning Crusade
        35128, -- Hardened Khorium
        34664, -- Sunmote
        32428, -- Heart of Darkness
        30183, -- Nether Vortex
        27503, -- Scroll of Strength V
        23793, -- Heavy Knothide Leather
        23573, -- Hardened Adamantite Bar
        23572, -- Primal Nether
        23571, -- Primal Might
        23449, -- Khorium Bar
        23448, -- Felsteel Bar
        23447, -- Eternium Bar
        23446, -- Adamantite Bar
        23445, -- Fel Iron Bar
        22831, -- Elixir of Major Agility
        22824, -- Elixir of Major Strength
        22573, -- Mote of Earth
        22457, -- Primal Mana
        22456, -- Primal Shadow
        22452, -- Primal Earth
        22451, -- Primal Air
        22450, -- Void Crystal
        22449, -- Large Prismatic Shard
        22445, -- Arcane Dust
        21887, -- Knothide Leather
        21886, -- Primal Life
        21885, -- Primal Water
        21884, -- Primal Fire
        21877, -- Netherweave Cloth
    },
    -- https://www.wowhead.com/tbc/items?filter=87:194:166;2:1:1;0:1:0
    [1] = { -- Vanilla
        22682, -- Frozen Rune
        22203, -- Large Obsidian Shard
        22202, -- Small Obsidian Shard
        20725, -- Nexus Crystal
        20520, -- Dark Rune
        19774, -- Souldarite
        19726, -- Bloodvine
        17203, -- Sulfuron Ingot
        17012, -- Core Leather
        17011, -- Lava Core
        17010, -- Fiery Core
        15417, -- Devilsaur Leather
        14047, -- Runecloth
        13512, -- Flask of Supreme Power
        13510, -- Flask of the Titans
        12811, -- Righteous Orb
        12810, -- Enchanted Leather
        12809, -- Guardian Stone
        12808, -- Essence of Undeath
        12804, -- Powerful Mojo
        12803, -- Living Essence
        12800, -- Azerothian Diamond
        12799, -- Large Opal
        12753, -- Skin of Shadow
        12662, -- Demonic Rune
        12655, -- Enchanted Thorium Bar
        12644, -- Dense Grinding Stone
        12365, -- Dense Stone
        12364, -- Huge Emerald
        12361, -- Blue Sapphire
        12360, -- Arcanite Bar
        12359, -- Thorium Bar
        11754, -- Black Diamond
        11382, -- Blood of the Mountain
        11371, -- Dark Iron Bar
        11188, -- Yellow Power Crystal
        11186, -- Red Power Crystal
        11185, -- Green Power Crystal
        11184, -- Blue Power Crystal
        8170, -- Rugged Leather
        8168, -- Jet Black Feather
        8153, -- Wildvine
        8146, -- Wicked Claw
        7972, -- Ichor of Undeath
        7971, -- Black Pearl
        7966, -- Solid Grinding Stone
        7912, -- Solid Stone
        7910, -- Star Ruby
        7909, -- Aquamarine
        7081, -- Breath of Wind
        7080, -- Essence of Water
        7078, -- Essence of Fire
        7077, -- Heart of Fire
        7076, -- Essence of Earth
        7075, -- Core of Earth
        7070, -- Elemental Water
        7069, -- Elemental Air
        7068, -- Elemental Fire
        7067, -- Elemental Earth
        6037, -- Truesilver Bar
        5637, -- Large Fang
        5635, -- Sharp Claw
        5500, -- Iridescent Pearl
        5498, -- Small Lustrous Pearl
        4338, -- Mageweave Cloth
        4306, -- Silk Cloth
        4304, -- Thick Leather
        4234, -- Heavy Leather
        3864, -- Citrine
        3860, -- Mithril Bar
        3859, -- Steel Bar
        3829, -- Frost Oil
        3824, -- Shadow Oil
        3823, -- Lesser Invisibility Potion
        3577, -- Gold Bar
        3575, -- Iron Bar
        3486, -- Heavy Grinding Stone
        3478, -- Coarse Grinding Stone
        3470, -- Rough Grinding Stone
        3466, -- Strong Flux
        3391, -- Elixir of Ogre's Strength
        2880, -- Weak Flux
        2842, -- Silver Bar
        2841, -- Bronze Bar
        2840, -- Copper Bar
        2838, -- Heavy Stone
        2836, -- Coarse Stone
        2835, -- Rough Stone
        2605, -- Green Dye
        2592, -- Wool Cloth
        2589, -- Linen Cloth
        2459, -- Swiftness Potion
        2321, -- Fine Thread
        2319, -- Medium Leather
        2318, -- Light Leather
        1705, -- Lesser Moonstone
        1529, -- Jade
        1210, -- Shadowgem
        1206, -- Moss Agate
        818, -- Tigerseye
        774, -- Malachite
    },
}

-- Now, trading goods
items.Elemental = {
    -- https://www.wowhead.com/tbc/items/trade-goods/elemental?filter=166:194;2:1;0:1
    [2] = { -- Burning Crusade
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
    },
    -- https://www.wowhead.com/tbc/items/trade-goods/elemental?filter=166:194;1:1;0:1
    [1] = { -- Vanilla
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
    },
}
-- For mining, below filters the gathered, crafted, and used by mining profession items.
items.Mining = {
    -- https://www.wowhead.com/tbc/items?filter=86:194:166;9:1:2;0:1:0
    -- https://www.wowhead.com/tbc/items?filter=87:166:194;9:2:1;0:0:1
    -- https://www.wowhead.com/tbc/items?filter=73:194:166;1:1:2;0:1:0
    [2] = { -- Burning Crusade
        35229, -- Nether Residue
        35128, -- Hardened Khorium
        34907, -- Shattered Gem Fragments
        32506, -- Netherwing Egg
        32464, -- Nethercite Ore
        32249, -- Seaspray Emerald
        32231, -- Pyrestone
        32230, -- Shadowsong Amethyst
        32229, -- Lionseye
        32228, -- Empyrean Sapphire
        32227, -- Crimson Spinel
        24189, -- Crystalline Fragments
        23573, -- Hardened Adamantite Bar
        23449, -- Khorium Bar
        23448, -- Felsteel Bar
        23447, -- Eternium Bar
        23446, -- Adamantite Bar
        23445, -- Fel Iron Bar
        23441, -- Nightseye
        23440, -- Dawnstone
        23439, -- Noble Topaz
        23438, -- Star of Elune
        23437, -- Talasite
        23436, -- Living Ruby
        23427, -- Eternium Ore
        23426, -- Khorium Ore
        23425, -- Adamantite Ore
        23424, -- Fel Iron Ore
        23117, -- Azure Moonstone
        23112, -- Golden Draenite
        23107, -- Shadow Draenite
        23079, -- Deep Peridot
        23077, -- Blood Garnet
        22634, -- Underlight Ore
        22574, -- Mote of Fire
        22573, -- Mote of Earth
        22452, -- Primal Earth
        21929, -- Flame Spessarite
        21884, -- Primal Fire
    },
    -- https://www.wowhead.com/tbc/items?filter=86:194:166;9:1:1;0:1:0
    -- https://www.wowhead.com/tbc/items?filter=87:166:194;9:1:1;0:0:1
    -- https://www.wowhead.com/tbc/items?filter=73:194:166;1:1:1;0:1:0
    [1] = { -- Vanilla
        22203, -- Large Obsidian Shard
        22202, -- Small Obsidian Shard
        19774, -- Souldarite
        18567, -- Elemental Flux
        18562, -- Elementium Ore
        17771, -- Elementium Bar
        17056, -- Light Feather
        17010, -- Fiery Core
        12800, -- Azerothian Diamond
        12799, -- Large Opal
        12365, -- Dense Stone
        12364, -- Huge Emerald
        12363, -- Arcane Crystal
        12361, -- Blue Sapphire
        12360, -- Arcanite Bar
        12359, -- Thorium Bar
        12223, -- Meaty Bat Wing
        11754, -- Black Diamond
        11513, -- Tainted Vitriol
        11382, -- Blood of the Mountain
        11371, -- Dark Iron Bar
        11370, -- Dark Iron Ore
        10620, -- Thorium Ore
        9262, -- Black Vitriol
        7912, -- Solid Stone
        7911, -- Truesilver Ore
        7910, -- Star Ruby
        7909, -- Aquamarine
        7101, -- Bug Eye
        7100, -- Sticky Ichor
        7098, -- Splintered Tusk
        7096, -- Plucked Feather
        7076, -- Essence of Earth
        7074, -- Chipped Claw
        7073, -- Broken Fang
        6303, -- Raw Slitherskin Mackerel
        6037, -- Truesilver Bar
        5833, -- Indurium Ore
        5364, -- Dry Salt Lick
        5362, -- Chew Toy
        5075, -- Blood Shard
        4874, -- Clean Fishbones
        4873, -- Dry Hardened Barnacle
        4872, -- Dry Scorpid Eye
        4870, -- Canvas Scraps
        4867, -- Broken Scorpid Leg
        4865, -- Ruined Pelt
        4776, -- Ruffled Feather
        4775, -- Cracked Bill
        4757, -- Cracked Egg Shells
        4702, -- Prospector's Pick
        4604, -- Forest Mushroom Cap
        4536, -- Shiny Red Apple
        4278, -- Lesser Bloodstone Ore
        3864, -- Citrine
        3860, -- Mithril Bar
        3859, -- Steel Bar
        3858, -- Mithril Ore
        3857, -- Coal
        3577, -- Gold Bar
        3576, -- Tin Bar
        3575, -- Iron Bar
        3340, -- Incendicite Ore
        3299, -- Fractured Canine
        3171, -- Broken Boar Tusk
        3170, -- Large Bear Tooth
        3169, -- Chipped Bear Tooth
        2842, -- Silver Bar
        2841, -- Bronze Bar
        2840, -- Copper Bar
        2838, -- Heavy Stone
        2836, -- Coarse Stone
        2835, -- Rough Stone
        2798, -- Rethban Ore
        2776, -- Gold Ore
        2775, -- Silver Ore
        2772, -- Iron Ore
        2771, -- Tin Ore
        2770, -- Copper Ore
        2672, -- Stringy Wolf Meat
        2590, -- Forest Spider Webbing
        2589, -- Linen Cloth
        2070, -- Darnassian Bleu
        1705, -- Lesser Moonstone
        1529, -- Jade
        1476, -- Snapped Spider Limb
        1210, -- Shadowgem
        1206, -- Moss Agate
        1181, -- Scroll of Spirit
        818, -- Tigerseye
        779, -- Shiny Seashell
        774, -- Malachite
        771, -- Chipped Boar Tusk
        755, -- Melted Candle
        159, -- Refreshing Spring Water
        118, -- Minor Healing Potion
        117, -- Tough Jerky
    },
}

-- For Herbalism, below collected only those gathered via the profession
items.Herbalism = {
    -- https://www.wowhead.com/tbc/items?filter=70:194:166;1:1:2;0:1:0
    [2] = { -- Burning Crusade
        35229, -- Nether Residue
        32506, -- Netherwing Egg
        32468, -- Netherdust Pollen
        29453, -- Sporeggar Mushroom
        27859, -- Zangar Caps
        25813, -- Small Mushroom
        24401, -- Unidentified Plant Parts
        22797, -- Nightmare Seed
        22795, -- Fel Blossom
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
        22576, -- Mote of Mana
        22575, -- Mote of Life
    },
    -- https://www.wowhead.com/tbc/items?filter=70:194:166;1:1:1;0:1:0
    [1] = { -- Vanilla
        19726, -- Bloodvine
        13468, -- Black Lotus
        13467, -- Icecap
        13466, -- Plaguebloom
        13465, -- Mountain Silversage
        13464, -- Golden Sansam
        13463, -- Dreamfoil
        11514, -- Fel Creep
        8846, -- Gromsblood
        8845, -- Ghost Mushroom
        8839, -- Blindweed
        8838, -- Sungrass
        8836, -- Arthas' Tears
        8831, -- Purple Lotus
        8153, -- Wildvine
        5056, -- Root Sample
        4625, -- Firebloom
        3821, -- Goldthorn
        3820, -- Stranglekelp
        3819, -- Wintersbite
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
}

items.PvP = {
    [1] = { -- Vanilla
		20559, -- Arathi Basin Mark of Honor
		20558, -- Warsong Gulch Mark of Honor
		20560, -- Alterac Valley Mark of Honor
    }
}
