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
local PROJECT_FOREVER = WOW_PROJECT_CAMELOT

-- Beta-only fallback:
-- Replace these bounds with values verified from the actual Forever client.
local isForeverBeta = projectID == PROJECT_FOREVER and interfaceVersion >= 10000 and interfaceVersion < 20000

local isRetail = projectID == PROJECT_MAINLINE and not isForeverBeta
local isClassicEra = projectID == PROJECT_CLASSIC
local isAnniversaryTBC = PROJECT_TBC ~= nil and projectID == PROJECT_TBC
local isCataclysmClassic = PROJECT_CATA ~= nil and projectID == PROJECT_CATA
local isMistsClassic = PROJECT_MISTS ~= nil and projectID == PROJECT_MISTS
local isProgressionClassic = isCataclysmClassic or isMistsClassic
local isClassicForever = isForeverBeta or projectID == PROJECT_FOREVER

if not isClassicEra then return end

local items = {}
private.items = items

-- Criteria: Reagent for Tailoring & stacks up to > 1
items.Tailoring = {
    -- https://www.wowhead.com/classic/items?filter=87:194;10:1;0:1
    [1] = { -- Vanilla
        236656, -- Frozen Rune
        234009, -- Bolt of Qiraji Silk
        234008, -- Qiraji Silk
        234007, -- Spiked Silithid Chitin
        221021, -- Nightmare Seed
        213379, -- Hyperconductive Arcano-Filament
        213378, -- Unstable Microfilament
        213372, -- Insulating Gniodine
        213369, -- Faintly Glowing Leather
        22682, -- Frozen Rune
        20520, -- Dark Rune
        20381, -- Dreamscale
        19726, -- Bloodvine
        18240, -- Ogre Tannin
        17012, -- Core Leather
        17011, -- Lava Core
        17010, -- Fiery Core
        16203, -- Greater Eternal Essence
        15407, -- Cured Rugged Hide
        14344, -- Large Brilliant Shard
        14342, -- Mooncloth
        14341, -- Rune Thread
        14256, -- Felcloth
        14227, -- Ironweb Spider Silk
        14048, -- Bolt of Runecloth
        14047, -- Runecloth
        13926, -- Golden Pearl
        13468, -- Black Lotus
        12938, -- Blood of Heroes
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
        1210, -- Shadowgem
        929, -- Healing Potion
        814, -- Flask of Oil
    },
}

-- Criteria: Reagent for Leatherworking & stacks up to > 1
items.Leatherworking = {
    -- https://www.wowhead.com/classic/items?filter=87:194;8:1;0:1
    [1] = { -- Vanilla
        236656, -- Frozen Rune
        234009, -- Bolt of Qiraji Silk
        234007, -- Spiked Silithid Chitin
        221021, -- Nightmare Seed
        213379, -- Hyperconductive Arcano-Filament
        213376, -- Low-Background Truesilver Plates
        213372, -- Insulating Gniodine
        213370, -- Irradiated Leather Scraps
        213369, -- Faintly Glowing Leather
        22682, -- Frozen Rune
        20501, -- Heavy Silithid Carapace
        20500, -- Light Silithid Carapace
        20498, -- Silithid Chitin
        20381, -- Dreamscale
        19768, -- Primal Tiger Leather
        19767, -- Primal Bat Leather
        19726, -- Bloodvine
        18512, -- Larval Acid
        18251, -- Core Armor Kit
        18240, -- Ogre Tannin
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
        12938, -- Blood of Heroes
        12811, -- Righteous Orb
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
        2605, -- Green Dye
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
    -- https://www.wowhead.com/classic/items?filter=87:194;3:1;0:1
    [1] = { -- Vanilla
        239017, -- Exquisite Spices
        239016, -- Holy Salts
        227813, -- Drinkable Stratholme Holy Water
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
        2452, -- Swiftthistle
        2251, -- Gooey Spider Leg
        1468, -- Murloc Fin
        1179, -- Ice Cold Milk
        1081, -- Crisp Spider Meat
        1080, -- Tough Condor Meat
        1015, -- Lean Wolf Flank
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
    -- https://www.wowhead.com/classic/items?filter=87:194;1:1;0:1
    [1] = { -- Vanilla
        241652, -- Discolored Beast Heart
        234012, -- Hive Thistle
        234011, -- Qiraji Stalker Venom
        234010, -- Ancient Sandworm Bile
        234006, -- Monstrous Silithid Chitin
        221312, -- Flask of Atal'ai Mojo
        221021, -- Nightmare Seed
        215430, -- Gnomeregan Fallout
        213371, -- Crate of Tainted Gniodine Solution
        19943, -- Massive Mojo
        18256, -- Imbued Vial
        16203, -- Greater Eternal Essence
        13513, -- Flask of Chromatic Resistance
        13512, -- Flask of Supreme Power
        13511, -- Flask of Distilled Wisdom
        13510, -- Flask of the Titans
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
        11083, -- Soul Dust
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
        2456, -- Minor Rejuvenation Potion
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
    -- https://www.wowhead.com/classic/items?filter=87:194;4:1;0:1
    [1] = { -- Vanilla
        234012, -- Hive Thistle
        234011, -- Qiraji Stalker Venom
        234010, -- Ancient Sandworm Bile
        234008, -- Qiraji Silk
        234007, -- Spiked Silithid Chitin
        234006, -- Monstrous Silithid Chitin
        234005, -- Obsidian Blasting Powder
        234004, -- Obsidian Grinding Stone
        234003, -- Obsidian-Infused Thorium Bar
        20725, -- Nexus Crystal
        18512, -- Larval Acid
        18256, -- Imbued Vial
        17035, -- Stranglethorn Seed
        17034, -- Maple Seed
        16204, -- Illusion Dust
        16203, -- Greater Eternal Essence
        16202, -- Lesser Eternal Essence
        14344, -- Large Brilliant Shard
        14343, -- Small Brilliant Shard
        14047, -- Runecloth
        13926, -- Golden Pearl
        13468, -- Black Lotus
        13467, -- Icecap
        13458, -- Greater Nature Protection Potion
        13180, -- Stratholme Holy Water
        12938, -- Blood of Heroes
        12811, -- Righteous Orb
        12810, -- Enchanted Leather
        12809, -- Guardian Stone
        12808, -- Essence of Undeath
        12803, -- Living Essence
        12753, -- Skin of Shadow
        12735, -- Frayed Abomination Stitching
        12359, -- Thorium Bar
        11754, -- Black Diamond
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
        8152, -- Flask of Big Mojo
        8151, -- Flask of Mojo
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
        2459, -- Swiftness Potion
        2452, -- Swiftthistle
        1210, -- Shadowgem
    },
}

-- Criteria: Reagent for Engineering & stacks up to > 1
items.Engineering = {
    -- https://www.wowhead.com/classic/items?filter=87:194;5:1;0:1
    [1] = { -- Vanilla
        238737, -- Tinkerbox
        234012, -- Hive Thistle
        234011, -- Qiraji Stalker Venom
        234010, -- Ancient Sandworm Bile
        234009, -- Bolt of Qiraji Silk
        234008, -- Qiraji Silk
        234007, -- Spiked Silithid Chitin
        234005, -- Obsidian Blasting Powder
        234003, -- Obsidian-Infused Thorium Bar
        221021, -- Nightmare Seed
        215430, -- Gnomeregan Fallout
        213383, -- Polished Truesilver Gears
        213381, -- Pile of Tarnished Gears
        213379, -- Hyperconductive Arcano-Filament
        213376, -- Low-Background Truesilver Plates
        213369, -- Faintly Glowing Leather
        22202, -- Small Obsidian Shard
        20881, -- Idol of Strife
        20870, -- Jasper Idol
        20868, -- Lambent Idol
        20725, -- Nexus Crystal
        19774, -- Souldarite
        19726, -- Bloodvine
        18631, -- Truesilver Transformer
        17202, -- Snowball
        17011, -- Lava Core
        17010, -- Fiery Core
        16583, -- Demonic Figurine
        16006, -- Delicate Arcanite Converter
        16000, -- Thorium Tube
        15994, -- Thorium Widget
        15992, -- Dense Blasting Powder
        15407, -- Cured Rugged Hide
        14227, -- Ironweb Spider Silk
        14047, -- Runecloth
        13467, -- Icecap
        12811, -- Righteous Orb
        12810, -- Enchanted Leather
        12808, -- Essence of Undeath
        12804, -- Powerful Mojo
        12803, -- Living Essence
        12800, -- Azerothian Diamond
        12799, -- Large Opal
        12655, -- Enchanted Thorium Bar
        12365, -- Dense Stone
        12364, -- Huge Emerald
        12363, -- Arcane Crystal
        12361, -- Blue Sapphire
        12360, -- Arcanite Bar
        12359, -- Thorium Bar
        11371, -- Dark Iron Bar
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
        9262, -- Black Vitriol
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
    -- https://www.wowhead.com/classic/items?filter=87:194;2:1;0:1
    [1] = { -- Vanilla
        236656, -- Frozen Rune
        234006, -- Monstrous Silithid Chitin
        234004, -- Obsidian Grinding Stone
        234003, -- Obsidian-Infused Thorium Bar
        221021, -- Nightmare Seed
        213383, -- Polished Truesilver Gears
        213379, -- Hyperconductive Arcano-Filament
        213376, -- Low-Background Truesilver Plates
        213373, -- Reflective Scrapmetal
        213369, -- Faintly Glowing Leather
        22682, -- Frozen Rune
        22203, -- Large Obsidian Shard
        22202, -- Small Obsidian Shard
        20882, -- Idol of War
        20879, -- Idol of Life
        20878, -- Idol of Rebirth
        20877, -- Idol of the Sage
        20876, -- Idol of Death
        20875, -- Idol of Night
        20874, -- Idol of the Sun
        20873, -- Alabaster Idol
        20872, -- Vermillion Idol
        20871, -- Obsidian Idol
        20867, -- Onyx Idol
        20725, -- Nexus Crystal
        20520, -- Dark Rune
        20381, -- Dreamscale
        19774, -- Souldarite
        19726, -- Bloodvine
        18262, -- Elemental Sharpening Stone
        17203, -- Sulfuron Ingot
        17012, -- Core Leather
        17011, -- Lava Core
        17010, -- Fiery Core
        15417, -- Devilsaur Leather
        14047, -- Runecloth
        13512, -- Flask of Supreme Power
        13510, -- Flask of the Titans
        12938, -- Blood of Heroes
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
        10938, -- Lesser Magic Essence
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
        2863, -- Coarse Sharpening Stone
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
    -- https://www.wowhead.com/classic/items/trade-goods/elemental?filter=194;1;1
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
    -- https://www.wowhead.com/classic/items?filter=86:194;9:1;0:1
    -- https://www.wowhead.com/classic/items?filter=87:194;9:1;0:1
    -- https://www.wowhead.com/classic/items?filter=73:194;1:1;0:1
    [1] = { -- Vanilla
        234003, -- Obsidian-Infused Thorium Bar
        219515, -- Greater Moonstone
        219486, -- Starsilver Ore
        219445, -- Fool's Gold Dust
        219401, -- Cold Iron Ore
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
        12655, -- Enchanted Thorium Bar
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
        7068, -- Elemental Fire
        7067, -- Elemental Earth
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
    -- https://www.wowhead.com/classic/items?filter=70:194;1:1;0:1
    [1] = { -- Vanilla
        234012, -- Hive Thistle
        219514, -- Moonroot
        219454, -- Star Lotus
        219444, -- Dreamroot
        219399, -- Nightmare Moss
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
        7070, -- Elemental Water
        7068, -- Elemental Fire
        7067, -- Elemental Earth
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
