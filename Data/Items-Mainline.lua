-- $Id$
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

if not isRetail then return end

local items = {}
private.items = items

-- Criteria: Reagent for Tailoring & stacks up to > 1
items.Tailoring = {
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:12;0:1:0
    [12] = { -- Midnight
        274781, -- Cursebound Globe
        274777, -- Neutralized Venom Clot
        251691, -- Embroidery Floss
        251665, -- Silverleaf Thread
        251285, -- Petrified Root
        251283, -- Tormented Tantalum
        245345, -- Fused Vitality
        243602, -- Radiant Shard
        243599, -- Eversinging Dust
        239702, -- Imbued Bright Linen Bolt
        239700, -- Bright Linen Bolt
        239201, -- Sunfire Silk Bolt
        239198, -- Arcanoweave Bolt
        238525, -- Fantastic Fur
        238523, -- Carving Canine
        238522, -- Peerless Plumage
        237018, -- Arcanoweave
        237015, -- Sunfire Silk
        236963, -- Bright Linen
        236952, -- Mote of Pure Void
        236951, -- Mote of Wild Magic
        236950, -- Mote of Primal Energy
        236949, -- Mote of Light
    },
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:11;0:1:0
    [11] = { -- The War Within
        256963, -- Thalassian Lumber
        251773, -- Dragonpine Lumber
        251772, -- Arden Lumber
        251768, -- Darkpine Lumber
        251767, -- Fel-Touched Lumber
        251766, -- Shadowmoon Lumber
        251764, -- Ashwood Lumber
        251763, -- Bamboo Lumber
        251762, -- Coldwind Lumber
        248012, -- Dornic Fir Lumber
        245586, -- Ironwood Lumber
        242691, -- Olemba Lumber
        228930, -- Adorning Ribbon
        224832, -- Exquisite Weavercloth Bolt
        224828, -- Weavercloth
        224824, -- Duskweave
        224764, -- Mosswool Thread
        222804, -- Weavercloth Bolt
        222801, -- Dawnweave Bolt
        222798, -- Duskweave Bolt
        222795, -- Spool of Weaverthread
        222792, -- Spool of Dawnthread
        222789, -- Spool of Duskthread
        222615, -- Apricate Ink
        222609, -- Shadow Ink
        222423, -- Sanctified Alloy
        221865, -- Chaos Circuit
        221862, -- Safety Switch
        219952, -- Refulgent Crystal
        219949, -- Gleaming Shard
        219946, -- Storm Dust
        213759, -- Inverted Prism
        213613, -- Leyline Residue
        213611, -- Writhing Sample
        213197, -- Null Lotus
        212674, -- Sunless Carapace
        212670, -- Thunderous Hide
        212563, -- Harmonious Horticulture
        210939, -- Null Stone
        210814, -- Artisan's Acuity
    },
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:10;0:1:0
    [10] = { -- Dragonflight
        208212, -- Dreaming Essence
        207702, -- Wartorn Scrap
        204460, -- Zaralek Glowspores
        203406, -- Torn Morqut Kite
        201405, -- Tuft of Primal Wool
        201404, -- Tallstrider Sinew
        201401, -- Iridescent Plume
        200113, -- Resonant Crystal
        198397, -- Rainbow Pearl
        194751, -- Blazing Ink
        194727, -- Fiery Spirit
        194124, -- Vibrant Shard
        194123, -- Chromatic Dust
        194014, -- Temporal Spellthread
        194011, -- Frozen Spellthread
        194008, -- Vibrant Spellthread
        193938, -- Azureweave Bolt
        193935, -- Chronocloth Bolt
        193932, -- Infurious Wildercloth Bolt
        193929, -- Vibrant Wildercloth Bolt
        193926, -- Wildercloth Bolt
        193922, -- Wildercloth
        193921, -- Airy Soul
        193919, -- Frosty Soul
        193368, -- Silken Gemdust
        193360, -- Centaur's Trophy Necklace
        193216, -- Dense Hide
        193053, -- Contoured Fowlfeather
        192887, -- Elemental Harmony
        192872, -- Fractured Glass
        192095, -- Spool of Wilderthread
        191496, -- Omnium Draconis
        191460, -- Hochenblume
        190456, -- Artisan's Mettle
        190450, -- Awakened Ire
        190395, -- Serevite Ore
        190331, -- Awakened Decay
        190329, -- Awakened Frost
        190327, -- Awakened Air
        190324, -- Awakened Order
        190321, -- Awakened Fire
    },
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:9;0:1:0
    [9] = { -- Shadowlands
        187707, -- Progenitor Essentia
        187703, -- Silken Protofiber
        186017, -- Korthite Crystal
        182117, -- Bleakcloth
        182116, -- Bolt of Bleakcloth
        182104, -- Gossamer Thread
        182103, -- Gossamer Cloth
        182102, -- Bolt of Woven Gossamer
        182052, -- Thread of Pride
        182051, -- Bolt of Prideweave
        182050, -- Prideweave Cloth
        182028, -- Bleakthread
        182006, -- Spool of Ardensilk
        182005, -- Ardensilk Cloth
        182004, -- Bolt of Ardensilk Cloth
        178787, -- Orboreal Shard
        177062, -- Penumbra Thread
        177061, -- Twilight Bark
        173204, -- Lightless Silk
        173202, -- Shrouded Cloth
        173173, -- Essence of Valor
        173170, -- Essence of Rebirth
        172439, -- Enchanted Lightless Silk
        171828, -- Laestrite Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:8;0:1:0
    [8] = { -- Battle for Azeroth
        170553, -- Void Focus Splinter
        168649, -- Dredged Leather
        167738, -- Gilded Seaweave
        165948, -- Tidalcore
        165703, -- Breath of Bwonsamdi
        162461, -- Sanguicell
        162460, -- Hydrocore
        159959, -- Nylon Thread
        158378, -- Embroidered Deep Sea Satin
        158188, -- Crimson Ink
        152668, -- Expulsom
        152577, -- Deep Sea Satin
        152576, -- Tidespray Linen
        152513, -- Platinum Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:7;0:1:0
    [7] = { -- Legion
        156930, -- Rich Illusion Dust
        151568, -- Primal Sargerite
        151567, -- Lightweave Cloth
        142335, -- Pristine Falcosaur Feather
        135538, -- Bear Fur
        130183, -- Shadowruby
        130175, -- Chaotic Spinel
        129032, -- Roseate Pigment
        127681, -- Sharp Spritethorn
        127382, -- Tanithria's Sharpened Spritethorn
        127372, -- Silkweave Bracer Lining
        127370, -- Silkweave Bracer: Outer Layer
        127368, -- Bolt of Brimstone-Soaked Silkweave
        127364, -- Silkweave Hood Lining
        127363, -- Silkweave Hood: Outer Layer
        127359, -- Basic Silkweave Robe
        127343, -- Lyndras' Runic Catgut
        127292, -- Tanithria's Green Dye
        127291, -- Tanithria's Red Dye
        127290, -- Tanithria's Blue Dye
        127289, -- Tanithria's Purple Dye
        127287, -- Tanithria's Thread
        127286, -- Tanithria's Silkweave
        127037, -- Runic Catgut
        127004, -- Imbued Silkweave
        124461, -- Demonsteel Bar
        124440, -- Arkhana
        124439, -- Unbroken Tooth
        124438, -- Unbroken Claw
        124437, -- Shal'dorei Silk
        124124, -- Blood of Sargeras
        124115, -- Stormscale
        124113, -- Stonehide Leather
        124106, -- Felwort
        123918, -- Leystone Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:6;0:1:0
    [6] = { -- Warlords of Draenor
        127759, -- Felblight
        120945, -- Primal Spirit
        118472, -- Savage Blood
        114931, -- Cerulean Pigment
        113588, -- Temporal Crystal
        113264, -- Sorcerous Air
        113263, -- Sorcerous Earth
        111557, -- Sumptuous Fur
        111556, -- Hexweave Cloth
        110609, -- Raw Beast Hide
        109219, -- Draenic Strength Potion
        109218, -- Draenic Intellect Potion
        109217, -- Draenic Agility Potion
        109126, -- Gorgrond Flytrap
        109119, -- True Iron Ore
        109118, -- Blackrock Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:5;0:1:0
    [5] = { -- Mists of Pandaria
        102218, -- Spirit of War
        98619, -- Celestial Cloth
        94289, -- Haunting Spirit
        82447, -- Imperial Silk
        82444, -- Greater Pearlescent Spellthread
        82441, -- Bolt of Windwool Cloth
        80433, -- Blood Spirit
        76061, -- Spirit of Harmony
        74866, -- Golden Carp
        72988, -- Windwool Cloth
    },
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:4;0:1:0
    [4] = { -- Cataclysm
        71998, -- Essence of Destruction
        69237, -- Living Ember
        61981, -- Inferno Ink
        54849, -- Obsidium Bar
        54450, -- Powerful Ghostly Spellthread
        54440, -- Dreamcloth
        53643, -- Bolt of Embersilk Cloth
        53050, -- Heavy Embersilk Bandage
        53010, -- Embersilk Cloth
        52555, -- Hypnotic Dust
        52329, -- Volatile Life
        52328, -- Volatile Air
        52327, -- Volatile Earth
        52326, -- Volatile Water
        52325, -- Volatile Fire
        52078, -- Chaos Orb
    },
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:3;0:1:0
    [3] = { -- Wrath of the Lich King
        49908, -- Primordial Saronite
        47556, -- Crusader Orb
        45087, -- Runed Orb
        43102, -- Frozen Orb
        42253, -- Iceweb Spider Silk
        41595, -- Spellweave
        41594, -- Moonshroud
        41593, -- Ebonweave
        41511, -- Bolt of Imbued Frostweave
        41510, -- Bolt of Frostweave
        38426, -- Eternium Thread
        38425, -- Heavy Borean Leather
        37704, -- Crystallized Life
        37702, -- Crystallized Fire
        37701, -- Crystallized Earth
        36934, -- Eye of Zul
        36930, -- Monarch Topaz
        36925, -- Majestic Zircon
        36922, -- King's Amber
        36919, -- Cardinal Ruby
        36908, -- Frost Lotus
        36860, -- Eternal Fire
        36784, -- Siren's Tear
        36783, -- Northsea Pearl
        35627, -- Eternal Shadow
        35625, -- Eternal Life
        35624, -- Eternal Earth
        35622, -- Eternal Water
        34055, -- Greater Cosmic Essence
        34054, -- Infinite Dust
        34052, -- Dream Shard
        33470, -- Frostweave Cloth
    },
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:2;0:1:0
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
    -- https://www.wowhead.com/items?filter=87:194:166;10:1:1;0:1:0
    [1] = { -- Vanilla
        22682, -- Frozen Rune
        20520, -- Dark Rune
        19768, -- Primal Tiger Leather
        19767, -- Primal Bat Leather
        18335, -- Pristine Black Diamond
        18240, -- Ogre Tannin
        17056, -- Light Feather
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
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:12;0:1:0
    [12] = { -- Midnight
        274781, -- Cursebound Globe
        274777, -- Neutralized Venom Clot
        274589, -- Ula'tek Snakehead
        251665, -- Silverleaf Thread
        251285, -- Petrified Root
        251283, -- Tormented Tantalum
        245345, -- Fused Vitality
        244636, -- Sin'dorei Armor Banding
        244635, -- Sin'dorei Armor Banding
        244634, -- Infused Scalewoven Hide
        244633, -- Infused Scalewoven Hide
        244631, -- Scalewoven Hide
        243737, -- Smuggler's Enchanted Edge
        243578, -- Aetherlume
        242788, -- Dusk-Shrouded Stone
        242620, -- Glimmering Gemdust
        241281, -- Composite Flora
        238530, -- Majestic Fin
        238529, -- Majestic Hide
        238528, -- Majestic Claw
        238525, -- Fantastic Fur
        238523, -- Carving Canine
        238522, -- Peerless Plumage
        238520, -- Void-Tempered Plating
        238518, -- Void-Tempered Hide
        238513, -- Void-Tempered Scales
        238511, -- Void-Tempered Leather
        238204, -- Sterling Alloy
        238202, -- Gloaming Alloy
        236952, -- Mote of Pure Void
        236951, -- Mote of Wild Magic
        236950, -- Mote of Primal Energy
        236949, -- Mote of Light
        236780, -- Nocturnal Lotus
        236761, -- Tranquility Bloom
    },
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:11;0:1:0
    [11] = { -- The War Within
        256963, -- Thalassian Lumber
        251773, -- Dragonpine Lumber
        251772, -- Arden Lumber
        251768, -- Darkpine Lumber
        251767, -- Fel-Touched Lumber
        251766, -- Shadowmoon Lumber
        251764, -- Ashwood Lumber
        251763, -- Bamboo Lumber
        251762, -- Coldwind Lumber
        248012, -- Dornic Fir Lumber
        245586, -- Ironwood Lumber
        242691, -- Olemba Lumber
        224764, -- Mosswool Thread
        221856, -- Whimsical Wiring
        221853, -- Handful of Bismuth Bolts
        221758, -- Profaned Tinderbox
        221757, -- Gloomfathom Hide
        221756, -- Vial of Kaheti Oils
        221754, -- Ringing Deeps Ingot
        219901, -- Storm-Touched Weapon Wrap
        219898, -- Chitin Armor Banding
        219892, -- Leyfused Hide
        219889, -- Sporecoated Hide
        219886, -- Writhing Hide
        219883, -- Crystalfused Hide
        219880, -- Carapace-Backed Hide
        219013, -- Superb Beast Fang
        218339, -- Burning Cinderbee Setae
        218338, -- Bottled Storm
        218337, -- Honed Bone Shards
        218336, -- Kaheti Swarm Chitin
        213613, -- Leyline Residue
        213612, -- Viridescent Spores
        213611, -- Writhing Sample
        213610, -- Crystalline Powder
        212674, -- Sunless Carapace
        212670, -- Thunderous Hide
        212667, -- Gloom Chitin
        212664, -- Stormcharged Leather
        212563, -- Harmonious Horticulture
        210814, -- Artisan's Acuity
        210796, -- Mycobloom
    },
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:10;0:1:0
    [10] = { -- Dragonflight
        210456, -- Dreaming Antler Fragment
        208212, -- Dreaming Essence
        207702, -- Wartorn Scrap
        205413, -- Obsidian Cobraskin
        204464, -- Shadowflame Essence
        204463, -- Dracothyst
        204460, -- Zaralek Glowspores
        203405, -- Pristine Pelt
        201405, -- Tuft of Primal Wool
        201404, -- Tallstrider Sinew
        201403, -- Mastodon Tusk
        201400, -- Aquatic Maw
        201399, -- Primal Bear Spine
        198615, -- Pentagold Seal
        194862, -- Runed Writhebark
        194727, -- Fiery Spirit
        194542, -- Prototype Explorer's Barding Framework
        194541, -- Prototype Regal Barding Framework
        193922, -- Wildercloth
        193362, -- Fiery Soul
        193360, -- Centaur's Trophy Necklace
        193259, -- Flawless Proto Dragon Scale
        193258, -- Fire-Infused Hide
        193256, -- Windsong Plumage
        193255, -- Pristine Vorquin Horn
        193254, -- Rockfang Leather
        193253, -- Cacophonous Thunderscale
        193252, -- Salamanther Scales
        193251, -- Crystalspine Fur
        193248, -- Infurious Scales
        193245, -- Frostbite Scales
        193242, -- Earthshine Scales
        193236, -- Infurious Hide
        193229, -- Mireslush Hide
        193226, -- Stonecrust Hide
        193222, -- Lustrous Scaled Hide
        193216, -- Dense Hide
        193213, -- Adamant Scales
        193208, -- Resilient Leather
        193053, -- Contoured Fowlfeather
        192869, -- Illimited Diamond
        191496, -- Omnium Draconis
        191460, -- Hochenblume
        190456, -- Artisan's Mettle
        190450, -- Awakened Ire
        190331, -- Awakened Decay
        190329, -- Awakened Frost
        190327, -- Awakened Air
        190321, -- Awakened Fire
        190316, -- Awakened Earth
        190312, -- Khaz'gorite Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:9;0:1:0
    [9] = { -- Shadowlands
        187707, -- Progenitor Essentia
        187701, -- Protogenic Pelt
        186017, -- Korthite Crystal
        183955, -- Curing Salt
        183951, -- Immortal Shard
        182290, -- Bottle of Leather Dye
        182194, -- Steelhide Sinew
        182193, -- Thick Steelhide Leather
        182055, -- Ragged Sinrunner Leather
        182054, -- Softened Leather
        182053, -- Tortured Sole
        182031, -- Unused Flesh
        182030, -- Cleaned Hide
        182029, -- Corpsestitch Thread
        182008, -- Steelhide Leather Strap
        182007, -- Steelhide Leather Belt
        182003, -- Runestag Leather
        182002, -- Dyed Runestag Leather
        182001, -- Runestag Leather Strap
        178787, -- Orboreal Shard
        177062, -- Penumbra Thread
        177061, -- Twilight Bark
        173204, -- Lightless Silk
        172438, -- Enchanted Heavy Callous Hide
        172097, -- Heavy Callous Hide
        172096, -- Heavy Desolate Leather
        172094, -- Callous Hide
        172092, -- Pallid Bone
        172089, -- Desolate Leather
        171830, -- Oxxein Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:8;0:1:0
    [8] = { -- Battle for Azeroth
        170553, -- Void Focus Splinter
        169456, -- Seabreeze Saddle Blanket
        168650, -- Cragscale
        168649, -- Dredged Leather
        168139, -- Long Regal Sinew
        168138, -- Spirit of the Bested
        167560, -- Cleaned Brilliant Scales
        167559, -- Supple Hides
        167558, -- Etched Bones
        165948, -- Tidalcore
        165703, -- Breath of Bwonsamdi
        162461, -- Sanguicell
        162460, -- Hydrocore
        160059, -- Amber Tanning Oil
        159959, -- Nylon Thread
        154722, -- Tempest Hide
        154166, -- Coarse Leather Barding
        154165, -- Calcified Bone
        154164, -- Blood-Stained Bone
        153051, -- Mistscale
        153050, -- Shimmerscale
        152668, -- Expulsom
        152579, -- Storm Silver Ore
        152542, -- Hardened Tempest Hide
        152541, -- Coarse Leather
        152513, -- Platinum Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:7;0:1:0
    [7] = { -- Legion
        151568, -- Primal Sargerite
        151567, -- Lightweave Cloth
        151566, -- Fiendish Leather
        136539, -- Tanned Stonehide Leather
        136538, -- Namha's Stonehide Leather
        130937, -- Fel Leather Cuff
        130892, -- Stalriss' Tanning Mixture
        130891, -- Namha's Tanning Mixture
        130880, -- Fel Leather Strap
        130879, -- Tanned Fel Leather
        130878, -- Shaved Felhide
        130877, -- Fresh Felhide
        130875, -- Stonehide Leather Strip
        130874, -- Stonehide Leather Toe Cap
        130873, -- Stonehide Boot Exterior
        130872, -- Stonehide Leather Lining
        130870, -- Tanned Stonehide Leather
        130869, -- Shaved Stonehide Pelt
        130868, -- Fresh Stonehide Pelt
        130182, -- Maelstrom Sapphire
        130180, -- Dawnlight
        124440, -- Arkhana
        124439, -- Unbroken Tooth
        124438, -- Unbroken Claw
        124437, -- Shal'dorei Silk
        124124, -- Blood of Sargeras
        124116, -- Felhide
        124115, -- Stormscale
        124113, -- Stonehide Leather
        123918, -- Leystone Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:6;0:1:0
    [6] = { -- Warlords of Draenor
        127759, -- Felblight
        120945, -- Primal Spirit
        118472, -- Savage Blood
        113264, -- Sorcerous Air
        113263, -- Sorcerous Earth
        112185, -- Wind Scale Fragment
        112184, -- Cobra Scale Fragment
        112183, -- Nether Dragonscale Fragment
        112182, -- Patch of Fel Hide
        112181, -- Fel Scale Fragment
        112180, -- Patch of Crystal-Infused Leather
        112179, -- Patch of Thick Clefthoof Leather
        112178, -- Jormungar Scale Fragment
        112177, -- Nerubian Chitin Fragment
        112158, -- Icy Dragonscale Fragment
        112157, -- Prismatic Scale Fragment
        112156, -- Blackened Dragonscale Fragment
        112155, -- Deepsea Scale Fragment
        111557, -- Sumptuous Fur
        110611, -- Burnished Leather
        110609, -- Raw Beast Hide
        109219, -- Draenic Strength Potion
        109218, -- Draenic Intellect Potion
        109217, -- Draenic Agility Potion
        109126, -- Gorgrond Flytrap
        109119, -- True Iron Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:5;0:1:0
    [5] = { -- Mists of Pandaria
        102218, -- Spirit of War
        98617, -- Hardened Magnificent Hide
        94289, -- Haunting Spirit
        80433, -- Blood Spirit
        79255, -- Starlight Ink
        79254, -- Ink of Dreams
        79101, -- Prismatic Scale
        76061, -- Spirit of Harmony
        72163, -- Magnificent Hide
        72162, -- Sha-Touched Leather
        72120, -- Mist-Touched Leather
    },
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:4;0:1:0
    [4] = { -- Cataclysm
        71998, -- Essence of Destruction
        69237, -- Living Ember
        61981, -- Inferno Ink
        56516, -- Heavy Savage Leather
        54849, -- Obsidium Bar
        52982, -- Deepsea Scale
        52980, -- Pristine Hide
        52979, -- Blackened Dragonscale
        52977, -- Savage Leather Scraps
        52976, -- Savage Leather
        52329, -- Volatile Life
        52328, -- Volatile Air
        52327, -- Volatile Earth
        52326, -- Volatile Water
        52325, -- Volatile Fire
        52190, -- Inferno Ruby
        52078, -- Chaos Orb
    },
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:3;0:1:0
    [3] = { -- Wrath of the Lich King
        49908, -- Primordial Saronite
        47556, -- Crusader Orb
        45087, -- Runed Orb
        44128, -- Arctic Fur
        43102, -- Frozen Orb
        38561, -- Jormungar Scale
        38558, -- Nerubian Chitin
        38557, -- Icy Dragonscale
        38426, -- Eternium Thread
        38425, -- Heavy Borean Leather
        37705, -- Crystallized Water
        37703, -- Crystallized Shadow
        37700, -- Crystallized Air
        36860, -- Eternal Fire
        35627, -- Eternal Shadow
        35625, -- Eternal Life
        35624, -- Eternal Earth
        35623, -- Eternal Air
        35622, -- Eternal Water
        34057, -- Abyss Crystal
        34055, -- Greater Cosmic Essence
        33568, -- Borean Leather
        33567, -- Borean Leather Scraps
    },
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:2;0:1:0
    [2] = { -- Burning Crusade
        34664, -- Sunmote
        32428, -- Heart of Darkness
        30183, -- Nether Vortex
        29548, -- Nether Dragonscales
        29547, -- Wind Scales
        29539, -- Cobra Scales
        25708, -- Thick Clefthoof Leather
        25707, -- Fel Hide
        25700, -- Fel Scales
        25699, -- Crystal-Infused Leather
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
    -- https://www.wowhead.com/items?filter=87:194:166;8:1:1;0:1:0
    [1] = { -- Vanilla
        22682, -- Frozen Rune
        20520, -- Dark Rune
        20381, -- Dreamscale
        20004, -- Mighty Troll's Blood Elixir
        20002, -- Greater Dreamless Sleep Potion
        19943, -- Massive Mojo
        19931, -- Gurubashi Mojo Madness
        19768, -- Primal Tiger Leather
        19767, -- Primal Bat Leather
        18240, -- Ogre Tannin
        17056, -- Light Feather
        17012, -- Core Leather
        17011, -- Lava Core
        17010, -- Fiery Core
        15419, -- Warbear Leather
        15417, -- Devilsaur Leather
        15416, -- Black Dragonscale
        15415, -- Blue Dragonscale
        15414, -- Red Dragonscale
        15412, -- Green Dragonscale
        15410, -- Scale of Onyxia
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
        12808, -- Essence of Undeath
        12804, -- Powerful Mojo
        12803, -- Living Essence
        12655, -- Enchanted Thorium Bar
        12607, -- Brilliant Chromatic Scale
        12364, -- Huge Emerald
        12361, -- Blue Sapphire
        12360, -- Arcanite Bar
        11754, -- Black Diamond
        11291, -- Star Wood
        10285, -- Shadow Silk
        8343, -- Heavy Silken Thread
        8172, -- Cured Thick Hide
        8171, -- Rugged Hide
        8170, -- Rugged Leather
        8169, -- Thick Hide
        8167, -- Turtle Scale
        8165, -- Worn Dragonscale
        8154, -- Scorpid Scale
        8153, -- Wildvine
        8150, -- Deeprock Salt
        7971, -- Black Pearl
        7910, -- Star Ruby
        7392, -- Green Whelp Scale
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
        6260, -- Blue Dye
        5785, -- Thick Murloc Scale
        5784, -- Slimy Murloc Scale
        5637, -- Large Fang
        5633, -- Great Rage Potion
        5500, -- Iridescent Pearl
        5498, -- Small Lustrous Pearl
        5373, -- Lucky Charm
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
        1206, -- Moss Agate
        783, -- Light Hide
    },
}

-- Criteria: Reagent for Cooking & stacks up to > 1
items.Cooking = {
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:12;0:1:0
    [12] = { -- Midnight
        274781, -- Cursebound Globe
        274777, -- Neutralized Venom Clot
        274594, -- Polluted Puffer
        274591, -- Coiled Stargorger
        274590, -- Sulfurous Sludgefish
        274589, -- Ula'tek Snakehead
        253403, -- Thalassian Fillet
        251285, -- Petrified Root
        242647, -- Tavern Fixings
        242646, -- Pouch of Spices
        242645, -- Ripened Vegetable Assortment
        242644, -- Mana-Wyrm Essence
        242643, -- A Big Ol' Stick of Butter
        242642, -- Thalassian Herbs
        242641, -- Cooking Spirits
        242640, -- Plant Protein
        242639, -- Practically Pork
        238384, -- Sunwell Fish
        238383, -- Eversong Trout
        238379, -- Warping Wise
        238378, -- Shimmersiren
        238377, -- Blood Hunter
        238376, -- Lucky Loa
        238374, -- Tender Lumifin
        238373, -- Ominous Octopus
        238372, -- Restored Songfish
        238371, -- Arcane Wyrmfish
        238369, -- Bloomtail Minnow
        238368, -- Twisted Tetra
        238367, -- Root Crab
        238366, -- Lynxfish
        236951, -- Mote of Wild Magic
        236950, -- Mote of Primal Energy
        236778, -- Mana Lily
        236776, -- Argentleaf
        236774, -- Azeroot
        236770, -- Sanguithorn
        236761, -- Tranquility Bloom
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:11;0:1:0
    [11] = { -- The War Within
        259894, -- Perfect Preservatives
        251773, -- Dragonpine Lumber
        251772, -- Arden Lumber
        251768, -- Darkpine Lumber
        251766, -- Shadowmoon Lumber
        251763, -- Bamboo Lumber
        248012, -- Dornic Fir Lumber
        235845, -- Undermine Clam Meat
        225912, -- Hot Honeycomb
        225883, -- Prepared Ghoulfish
        225876, -- Fine Egg Powder
        224762, -- Delver's Waterskin
        223977, -- Coagulated Yolk
        223971, -- Azj-Kahet Special
        223968, -- Spongey Scramble
        222741, -- Fresh Fillet
        222739, -- Spiced Meat Stock
        222738, -- Portioned Steak
        222737, -- Chopped Mycobloom
        222731, -- Outsider's Provisions
        222705, -- Roasted Mycobloom
        222703, -- Simple Stew
        222701, -- Clumped Flour
        222700, -- Granulated Spices
        222699, -- Khaz Algar Tomato
        222697, -- Coreway Dust
        222696, -- Crunchy Peppers
        222695, -- Twined Herbs
        221754, -- Ringing Deeps Ingot
        220153, -- Awoken Coelacanth
        220151, -- Queen's Lurefish
        220150, -- Spiked Sea Raven
        220149, -- Sanguine Dogfish
        220147, -- Kaheti Slum Shark
        220146, -- Regal Dottyback
        220145, -- Arathor Hammerfish
        220144, -- Roaring Anglerseeker
        220142, -- Quiet River Bass
        220138, -- Nibbling Minnow
        220137, -- Bismuth Bitterling
        220136, -- Crystalline Sturgeon
        220135, -- Bloody Perch
        220134, -- Dilly-Dally Dace
        212508, -- Stunning Sapphire
        210936, -- Ironclaw Ore
        210933, -- Aqirite
        210930, -- Bismuth
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:10;0:1:0
    [10] = { -- Dragonflight
        204793, -- Suja's Sweet Salt
        203400, -- Lackluster Spices
        202710, -- Grilled Southfury Salmon
        202709, -- Spicy Seared Talbuk Steak
        202708, -- Curried Coconut Crab
        202707, -- Un'goro Coconut
        202706, -- Zandali Piri Piri
        202031, -- Farahlon Fenugreek
        202030, -- Ground Gorgrond Pepper
        202029, -- Isle Lemon
        202028, -- Southfury Salmon
        202027, -- Fresh Talbuk Steak
        202026, -- Durotar Coast Crab
        202025, -- Keg of Ancestral Ale
        200953, -- Wild Dragon Fruit
        200061, -- Prismatic Leaper
        199344, -- Magma Thresher
        197790, -- Roast Duck Delight
        197789, -- Riverside Picnic
        197788, -- Braised Bruffalon Brisket
        197787, -- Great Cerulean Sea
        197786, -- Thousandbone Tongueslicer
        197785, -- Revenge, Served Cold
        197784, -- Sizzling Seafood Medley
        197783, -- Aromatic Seafood Platter
        197782, -- Feisty Fish Sticks
        197776, -- Thrice-Spiced Mammoth Kabob
        197774, -- Charred Hornswog Steaks
        197770, -- Zesty Water
        197768, -- Celebratory Cake
        197767, -- Blubbery Muffin
        197766, -- Snow in a Cone
        197764, -- Salad on the Side
        197757, -- Assorted Exotic Spices
        197756, -- Pebbled Rock Salts
        197755, -- Lava Beetle
        197754, -- Salt Deposit
        197753, -- Thaldraszian Cocoa Powder
        197752, -- Conveniently Packaged Ingredients
        197751, -- Pastry Packets
        197750, -- Three-Cheese Blend
        197749, -- Ohn'ahran Potato
        197748, -- Burly Bear Haunch
        197747, -- Mighty Mammoth Ribs
        197746, -- Bruffalon Flank
        197745, -- Basilisk Eggs
        197744, -- Hornswog Hunk
        197743, -- Waterfowl Filet
        197742, -- Ribbed Mollusk Meat
        197741, -- Maybe Meat
        194970, -- Islefin Dorado
        194969, -- Temporal Dragonhead
        194968, -- Cerulean Spinefish
        194967, -- Aileron Seamoth
        194966, -- Thousandbite Piranha
        194829, -- Fated Fortune Card
        194730, -- Scalebelly Mackerel
        194691, -- Artisanal Berry Juice
        194683, -- Buttermilk
        193368, -- Silken Gemdust
        191464, -- Saxifrage
        191460, -- Hochenblume
        190395, -- Serevite Ore
        190312, -- Khaz'gorite Ore
        189143, -- Draconium Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:9;0:1:0
    [9] = { -- Shadowlands
        187812, -- Empty Kettle
        182101, -- Oat Pie Crust
        182100, -- Fresh Mushrooms
        182099, -- Fresh Turnips
        182098, -- Fresh Carrots
        182096, -- Ember Chilis
        182070, -- Fresh Beast Steak
        182069, -- Seared Cutlets
        182068, -- Ember Sauce
        182046, -- Grave Dust
        182045, -- Thick Spider Legs
        182044, -- Thick Spider Meat
        182024, -- Grazer Bones
        182023, -- Grazer Bone Broth
        182022, -- Diced Vegetables
        181988, -- Sack of Arden Oats
        181987, -- Fresh Arden Apples
        181986, -- Sliced Arden Apples
        179315, -- Shadowy Shank
        179314, -- Creeping Crawler Meat
        178786, -- Lusterwheat Flour
        177061, -- Twilight Bark
        173037, -- Elysian Thade
        173036, -- Spinefin Piranha
        173035, -- Pocked Bonefish
        173034, -- Silvergill Pike
        173033, -- Iridescent Amberjack
        173032, -- Lost Sole
        172092, -- Pallid Bone
        172059, -- Rich Grazer Milk
        172058, -- Smuggled Azerothian Produce
        172057, -- Inconceivably Aged Vinegar
        172056, -- Medley of Transplanar Spices
        172055, -- Phantasmal Haunch
        172054, -- Raw Seraphic Wing
        172053, -- Tenebrous Ribs
        172052, -- Aethereal Meat
        172049, -- Iridescent Ravioli with Apple Sauce
        171841, -- Shaded Stone
        171840, -- Porous Stone
        171829, -- Solenium Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:8;0:1:0
    [8] = { -- Battle for Azeroth
        174353, -- Questionable Meat
        174328, -- Aberrant Voidfin
        174327, -- Malformed Gnasher
        169610, -- S.P.A.R.E. Crate
        168646, -- Mauve Stinger
        168645, -- Moist Fillet
        168303, -- Rubbery Flank
        168302, -- Viper Fish
        167562, -- Ionized Minnow
        166846, -- Spare Parts
        163782, -- Cursed Haunch
        162555, -- Zocalo Cheddar
        162515, -- Midnight Salmon
        162461, -- Sanguicell
        160712, -- Powdered Sugar
        160711, -- Aromatic Fish Oil
        160710, -- Wild Berries
        160709, -- Fresh Potato
        160705, -- Major's Frothy Coffee
        160400, -- Foosaka
        160399, -- Wild Flour
        160398, -- Choral Honey
        154899, -- Thick Paleo Steak
        154898, -- Meaty Haunch
        154897, -- Stringy Loins
        154886, -- Spiced Snapper
        154885, -- Mon'Dazi
        154881, -- Kul Tiramisu
        152631, -- Briny Flesh
        152579, -- Storm Silver Ore
        152549, -- Redtail Loach
        152548, -- Tiragarde Perch
        152547, -- Great Sea Catfish
        152546, -- Lane Snapper
        152545, -- Frenzied Fangtooth
        152544, -- Slimy Mackerel
        152543, -- Sand Shifter
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:7;0:1:0
    [7] = { -- Legion
        142336, -- Falcosaur Egg
        138979, -- Spicy Sharp Cheddar
        133680, -- Slice of Bacon
        133607, -- Silver Mackerel
        133593, -- Royal Olive
        133592, -- Stonedark Snail
        133591, -- River Onion
        133590, -- Muskenbutter
        133589, -- Dalapeño Pepper
        133588, -- Flaked Sea Salt
        133569, -- Drogbar-Style Salmon
        133568, -- Koi-Scented Stormray
        133567, -- Barracuda Mrglgagh
        133566, -- Suramar Surf and Turf
        133565, -- Leybeque Ribs
        133564, -- Spiced Rib Roast
        133563, -- Faronaar Fizz
        133562, -- Pickled Stormray
        133561, -- Deep-Fried Mossgill
        133557, -- Salt and Pepper Shank
        129100, -- Gem Chip
        128304, -- Yseralline Seed
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
        124105, -- Starlight Rose
        124104, -- Fjarnskaggl
        124103, -- Foxflower
        124102, -- Dreamleaf
        124101, -- Aethril
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:6;0:1:0
    [6] = { -- Warlords of Draenor
        128500, -- Fel Ham
        128499, -- Fel Egg
        124669, -- Darkmoon Daggermaw
        115352, -- Telmor-Aruuna Hard Cheese
        111449, -- Blackrock Barbecue
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
        109129, -- Talador Orchid
        109128, -- Nagrand Arrowbloom
        109127, -- Starflower
        109126, -- Gorgrond Flytrap
        109125, -- Fireweed
        109124, -- Frostweed
        109119, -- True Iron Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:5;0:1:0
    [5] = { -- Mists of Pandaria
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
        75038, -- Mad Brewer's Breakfast
        75037, -- Jade Witch Brew
        75026, -- Ginseng Tea
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
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:4;0:1:0
    [4] = { -- Cataclysm
        67229, -- Stag Flank
        62791, -- Blood Shrimp
        62786, -- Cocoa Beans
        62785, -- Delicate Wing
        62784, -- Crocolisk Tail
        62783, -- Basilisk "Liver"
        62782, -- Dragon Flank
        62781, -- Giant Turtle Tongue
        62780, -- Snake Eye
        62779, -- Monstrous Claw
        62778, -- Toughened Flesh
        60838, -- Mysterious Fortune Card
        58278, -- Tropical Sunfruit
        58265, -- Highland Pomegranate
        53072, -- Deepsea Sagefish
        53071, -- Algaefin Rockfish
        53070, -- Fathom Eel
        53069, -- Murglesnout
        53068, -- Lavascale Catfish
        53067, -- Striped Lurker
        53066, -- Blackbelly Mudfish
        53064, -- Highland Guppy
        53063, -- Mountain Trout
        53062, -- Sharptooth
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:3;0:1:0
    [3] = { -- Wrath of the Lich King
        46797, -- Mulgore Sweet Potato
        46796, -- Ripe Tirisfal Pumpkin
        46793, -- Tangy Southfury Cranberries
        46784, -- Ripe Elwynn Pumpkin
        44855, -- Teldrassil Sweet Potato
        44854, -- Tangy Wetland Cranberries
        44853, -- Honey
        44835, -- Autumnal Herbs
        44834, -- Wild Turkey
        43501, -- Northern Egg
        43013, -- Chilled Meat
        43012, -- Rhino Meat
        43011, -- Worg Haunch
        43010, -- Worm Meat
        43009, -- Shoveltusk Flank
        43007, -- Northern Spices
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
        35949, -- Tundra Berries
        35948, -- Savory Snowplum
        34736, -- Chunk o' Mammoth
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:2;0:1:0
    [2] = { -- Burning Crusade
        35562, -- Bear Flank
        34412, -- Sparkling Apple Cider
        33824, -- Crescent-Tail Skullfish
        33823, -- Bloodfin Catfish
        31671, -- Serpent Flesh
        31670, -- Raptor Ribs
        30817, -- Simple Flour
        30816, -- Spice Bread
        27682, -- Talbuk Venison
        27681, -- Warped Flesh
        27678, -- Clefthoof Meat
        27677, -- Chunk o' Basilisk
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
        22577, -- Mote of Shadow
    },
    -- https://www.wowhead.com/items?filter=87:194:166;3:1:1;0:1:0
    [1] = { -- Vanilla
        21153, -- Raw Greater Sagefish
        21071, -- Raw Sagefish
        21024, -- Chimaerok Tenderloin
        20424, -- Sandworm Meat
        18255, -- Runn Tum Tuber
        17202, -- Snowball
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
        12808, -- Essence of Undeath
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
        9260, -- Volatile Rum
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
        4537, -- Tel'Abim Banana
        4402, -- Small Flame Sac
        3927, -- Fine Aged Cheddar
        3821, -- Goldthorn
        3731, -- Lion Meat
        3730, -- Big Bear Meat
        3712, -- Turtle Meat
        3685, -- Raptor Egg
        3667, -- Tender Crocolisk Meat
        3577, -- Gold Bar
        3404, -- Buzzard Wing
        3173, -- Bear Meat
        2924, -- Crocolisk Meat
        2886, -- Crag Boar Rib
        2678, -- Mild Spices
        2677, -- Boar Ribs
        2675, -- Crawler Claw
        2674, -- Crawler Meat
        2673, -- Coyote Meat
        2672, -- Stringy Wolf Meat
        2596, -- Skin of Dwarven Stout
        2595, -- Jug of Badlands Bourbon
        2594, -- Flagon of Dwarven Mead
        2593, -- Flask of Stormwind Tawny
        2452, -- Swiftthistle
        2447, -- Peacebloom
        2251, -- Gooey Spider Leg
        1468, -- Murloc Fin
        1179, -- Ice Cold Milk
        1080, -- Tough Condor Meat
        1015, -- Lean Wolf Flank
        785, -- Mageroyal
        769, -- Chunk of Boar Meat
        723, -- Goretusk Liver
        159, -- Refreshing Spring Water
    },
}

-- Criteria: Reagent for Alchemy & stacks up to > 1
items.Alchemy = {
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:12;0:1:0
    [12] = { -- Midnight
        274781, -- Cursebound Globe
        274777, -- Neutralized Venom Clot
        251285, -- Petrified Root
        251283, -- Tormented Tantalum
        247811, -- Oil of Heartwood
        243602, -- Radiant Shard
        243599, -- Eversinging Dust
        242651, -- Stabilized Derivate
        241307, -- Refreshing Serum
        241305, -- Silvermoon Health Potion
        241283, -- Wondrous Synergist
        241281, -- Composite Flora
        240991, -- Sunglass Vial
        238525, -- Fantastic Fur
        238520, -- Void-Tempered Plating
        238518, -- Void-Tempered Hide
        238383, -- Eversong Trout
        238369, -- Bloomtail Minnow
        238365, -- Sin'dorei Swarmer
        236952, -- Mote of Pure Void
        236951, -- Mote of Wild Magic
        236950, -- Mote of Primal Energy
        236949, -- Mote of Light
        236780, -- Nocturnal Lotus
        236778, -- Mana Lily
        236776, -- Argentleaf
        236774, -- Azeroot
        236770, -- Sanguithorn
        236761, -- Tranquility Bloom
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:11;0:1:0
    [11] = { -- The War Within
        256963, -- Thalassian Lumber
        251773, -- Dragonpine Lumber
        251772, -- Arden Lumber
        251768, -- Darkpine Lumber
        251767, -- Fel-Touched Lumber
        251766, -- Shadowmoon Lumber
        251764, -- Ashwood Lumber
        251763, -- Bamboo Lumber
        251762, -- Coldwind Lumber
        248012, -- Dornic Fir Lumber
        245586, -- Ironwood Lumber
        242691, -- Olemba Lumber
        226205, -- Distilled Algari Freshwater
        221763, -- Viridian Charmcap
        221758, -- Profaned Tinderbox
        221756, -- Vial of Kaheti Oils
        213759, -- Inverted Prism
        213613, -- Leyline Residue
        213612, -- Viridescent Spores
        213611, -- Writhing Sample
        213610, -- Crystalline Powder
        213197, -- Null Lotus
        212754, -- Crystalforged Cauldron
        212563, -- Harmonious Horticulture
        212292, -- Vicious Flask of Honor
        212245, -- Slumbering Soul Serum
        211806, -- Gilded Vial
        211805, -- Gleaming Transmutagen
        211804, -- Volatile Transmutagen
        211803, -- Mercurial Transmutagen
        211802, -- Ominous Transmutagen
        210828, -- Dilution Solution
        210815, -- Coreway Catalyst
        210814, -- Artisan's Acuity
        210808, -- Arathor's Spear
        210805, -- Blessing Blossom
        210802, -- Orbinid
        210799, -- Luredrop
        210796, -- Mycobloom
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:10;0:1:0
    [10] = { -- Dragonflight
        204463, -- Dracothyst
        204460, -- Zaralek Glowspores
        203398, -- Dampening Powder
        201406, -- Glowing Titan Orb
        201405, -- Tuft of Primal Wool
        194727, -- Fiery Spirit
        193368, -- Silken Gemdust
        192883, -- Glossy Stone
        191570, -- Dragon's Alchemical Solution
        191496, -- Omnium Draconis
        191493, -- Primal Convergent
        191474, -- Draconic Vial
        191470, -- Writhebark
        191467, -- Bubble Poppy
        191464, -- Saxifrage
        191460, -- Hochenblume
        191387, -- Elemental Potion of Power
        191384, -- Aerated Mana Potion
        191378, -- Refreshing Healing Potion
        191369, -- Potion of Withering Vitality
        191363, -- Potion of Frozen Focus
        191357, -- Phial of Elemental Chaos
        191339, -- Phial of Tepid Versatility
        190456, -- Artisan's Mettle
        190331, -- Awakened Decay
        190330, -- Rousing Decay
        190329, -- Awakened Frost
        190328, -- Rousing Frost
        190327, -- Awakened Air
        190326, -- Rousing Air
        190324, -- Awakened Order
        190321, -- Awakened Fire
        190316, -- Awakened Earth
        190312, -- Khaz'gorite Ore
        189143, -- Draconium Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:9;0:1:0
    [9] = { -- Shadowland
        187707, -- Progenitor Essentia
        187699, -- First Flower
        183953, -- Sealing Wax
        183950, -- Distilled Death Extract
        182073, -- Fresh Bramblethorn Trimmings
        182072, -- Bramblethorn Juice
        182071, -- Refined Submission
        182049, -- Bones of Defeated Enemies
        182048, -- Crushed Bones
        182047, -- Brutal Oil
        182027, -- Fresh Breezebloom Trimmings
        182026, -- Pulverized Breezebloom
        182025, -- Distilled Resolve
        181985, -- Fresh Dreamroot Trimmings
        181984, -- Powdered Dreamroot
        181983, -- Liquid Sleep
        180732, -- Rune Etched Vial
        180457, -- Shadestone
        178787, -- Orboreal Shard
        177061, -- Twilight Bark
        173202, -- Shrouded Cloth
        173170, -- Essence of Rebirth
        171841, -- Shaded Stone
        171840, -- Porous Stone
        171292, -- Ground Nightshade
        171291, -- Ground Rising Glory
        171290, -- Ground Marrowroot
        171289, -- Ground Widowbloom
        171288, -- Ground Vigil's Torch
        171287, -- Ground Death Blossom
        171286, -- Embalmer's Oil
        171285, -- Shadowcore Oil
        171276, -- Spectral Flask of Power
        171268, -- Spiritual Mana Potion
        171267, -- Spiritual Healing Potion
        170554, -- Vigil's Torch
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:8;0:1:0
    [8] = { -- BfA
        171315, -- Nightshade
        170553, -- Void Focus Splinter
        169701, -- Death Blossom
        168654, -- Greater Flask of the Undertow
        168653, -- Greater Flask of the Vast Horizon
        168652, -- Greater Flask of Endless Fathoms
        168651, -- Greater Flask of the Currents
        168589, -- Marrowroot
        168586, -- Rising Glory
        168583, -- Widowbloom
        168487, -- Zin'anthid
        166374, -- Test Vial
        166373, -- Storm Silver Shards
        166372, -- Sand Shifter Scales
        166371, -- Dried Star Moss Leaves
        165948, -- Tidalcore
        165703, -- Breath of Bwonsamdi
        162519, -- Mystical Cauldron
        162461, -- Sanguicell
        162460, -- Hydrocore
        158186, -- Distilled Water
        154898, -- Meaty Haunch
        154897, -- Stringy Loins
        154164, -- Blood-Stained Bone
        152668, -- Expulsom
        152641, -- Flask of the Undertow
        152640, -- Flask of the Vast Horizon
        152639, -- Flask of Endless Fathoms
        152638, -- Flask of the Currents
        152579, -- Storm Silver Ore
        152577, -- Deep Sea Satin
        152576, -- Tidespray Linen
        152547, -- Great Sea Catfish
        152543, -- Sand Shifter
        152512, -- Monelite Ore
        152511, -- Sea Stalk
        152510, -- Anchor Weed
        152509, -- Siren's Pollen
        152508, -- Winter's Kiss
        152507, -- Akunda's Bite
        152506, -- Star Moss
        152505, -- Riverbud
        152495, -- Coastal Mana Potion
        152494, -- Coastal Healing Potion
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:7;0:1:0
    [7] = { -- Legion
        156930, -- Rich Illusion Dust
        151568, -- Primal Sargerite
        151565, -- Astral Glory
        137597, -- Oily Transmutagen
        137596, -- Black Transmutagen
        137595, -- Viscous Transmutagen
        133607, -- Silver Mackerel
        128304, -- Yseralline Seed
        127850, -- Flask of Ten Thousand Scars
        127849, -- Flask of the Countless Armies
        127848, -- Flask of the Seventh Demon
        127847, -- Flask of the Whispered Pact
        127838, -- Sylvan Elixir
        127836, -- Ancient Rejuvenation Potion
        127835, -- Ancient Mana Potion
        127834, -- Ancient Healing Potion
        124461, -- Demonsteel Bar
        124444, -- Infernal Brimstone
        124440, -- Arkhana
        124439, -- Unbroken Tooth
        124438, -- Unbroken Claw
        124437, -- Shal'dorei Silk
        124124, -- Blood of Sargeras
        124121, -- Wildfowl Egg
        124120, -- Leyblood
        124119, -- Big Gamy Ribs
        124118, -- Fatty Bearsteak
        124117, -- Lean Shank
        124115, -- Stormscale
        124113, -- Stonehide Leather
        124112, -- Black Barracuda
        124111, -- Runescale Koi
        124110, -- Stormray
        124109, -- Highmountain Salmon
        124108, -- Mossgill Perch
        124107, -- Cursed Queenfish
        124106, -- Felwort
        124105, -- Starlight Rose
        124104, -- Fjarnskaggl
        124103, -- Foxflower
        124102, -- Dreamleaf
        124101, -- Aethril
        123919, -- Felslate
        123918, -- Leystone Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:6;0:1:0
    [6] = { -- WoD
        127759, -- Felblight
        118472, -- Savage Blood
        117454, -- Gorgrond Grapes
        113264, -- Sorcerous Air
        113263, -- Sorcerous Earth
        113262, -- Sorcerous Water
        113261, -- Sorcerous Fire
        109223, -- Healing Tonic
        109222, -- Draenic Mana Potion
        109152, -- Draenic Stamina Flask
        109148, -- Draenic Strength Flask
        109147, -- Draenic Intellect Flask
        109145, -- Draenic Agility Flask
        109144, -- Blackwater Whiptail Flesh
        109143, -- Abyssal Gulper Eel Flesh
        109142, -- Sea Scorpion Segment
        109141, -- Fire Ammonite Tentacle
        109140, -- Blind Lake Sturgeon Flesh
        109139, -- Fat Sleeper Flesh
        109138, -- Jawless Skulker Flesh
        109137, -- Crescent Saberfish Flesh
        109129, -- Talador Orchid
        109128, -- Nagrand Arrowbloom
        109127, -- Starflower
        109126, -- Gorgrond Flytrap
        109125, -- Fireweed
        109124, -- Frostweed
        109123, -- Crescent Oil
        109119, -- True Iron Ore
        109118, -- Blackrock Ore
        108996, -- Alchemical Catalyst
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:5;0:1:0
    [5] = { -- MoP
        87872, -- Desecrated Oil
        83064, -- Spinefish
        79011, -- Fool's Cap
        79010, -- Snow Lily
        76141, -- Imperial Amethyst
        76140, -- Vermilion Onyx
        76139, -- Wild Jade
        76137, -- Alexandrite
        76136, -- Pandarian Garnet
        76135, -- Roguestone
        76134, -- Sunstone
        76133, -- Lapis Lazuli
        76130, -- Tiger Opal
        76098, -- Master Mana Potion
        76061, -- Spirit of Harmony
        72238, -- Golden Lotus
        72237, -- Rain Poppy
        72235, -- Silkweed
        72234, -- Green Tea Leaf
        72096, -- Ghost Iron Bar
        72095, -- Trillium Bar
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:4;0:1:0
    [4] = { -- Cataclysm
        69237, -- Living Ember
        65893, -- Sands of Time
        65892, -- Pyrium-Laced Crystalline Vial
        58480, -- Truegold
        58142, -- Deathblood Venom
        58088, -- Flask of Titanic Strength
        58087, -- Flask of the Winds
        58086, -- Flask of the Draconic Mind
        58085, -- Flask of Steelskin
        56850, -- Deepstone Oil
        54849, -- Obsidium Bar
        53065, -- Albino Cavefish
        52988, -- Whiptail
        52987, -- Twilight Jasmine
        52986, -- Heartblossom
        52985, -- Azshara's Veil
        52984, -- Stormvine
        52983, -- Cinderbloom
        52329, -- Volatile Life
        52328, -- Volatile Air
        52327, -- Volatile Earth
        52326, -- Volatile Water
        52325, -- Volatile Fire
        52186, -- Elementium Bar
        52182, -- Jasper
        52181, -- Hessonite
        52180, -- Nightstone
        52179, -- Alicite
        52178, -- Zephyrite
        52177, -- Carnelian
        51950, -- Pyrium Bar
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:3;0:1:0
    [3] = { -- WolTK
        44958, -- Ethereal Oil
        43102, -- Frozen Orb
        41814, -- Glassfin Minnow
        40199, -- Pygmy Suckerfish
        40195, -- Pygmy Oil
        40077, -- Crazy Alchemist's Potion
        37921, -- Deadnettle
        37705, -- Crystallized Water
        37704, -- Crystallized Life
        37703, -- Crystallized Shadow
        37702, -- Crystallized Fire
        37701, -- Crystallized Earth
        36933, -- Forest Emerald
        36932, -- Dark Jade
        36930, -- Monarch Topaz
        36929, -- Huge Citrine
        36927, -- Twilight Opal
        36924, -- Sky Sapphire
        36923, -- Chalcedony
        36921, -- Autumn's Glow
        36918, -- Scarlet Ruby
        36917, -- Bloodstone
        36913, -- Saronite Bar
        36908, -- Frost Lotus
        36907, -- Talandra's Rose
        36906, -- Icethorn
        36905, -- Lichbloom
        36904, -- Tiger Lily
        36903, -- Adder's Tongue
        36901, -- Goldclover
        36860, -- Eternal Fire
        35627, -- Eternal Shadow
        35625, -- Eternal Life
        35624, -- Eternal Earth
        35623, -- Eternal Air
        35622, -- Eternal Water
        33448, -- Runic Mana Potion
        33447, -- Runic Healing Potion
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:2;0:1:0
    [2] = { -- TBC
        34440, -- Mad Alchemist's Potion
        30183, -- Nether Vortex
        25868, -- Skyfire Diamond
        25867, -- Earthstorm Diamond
        23782, -- Fel Iron Casing
        23573, -- Hardened Adamantite Bar
        23571, -- Primal Might
        23449, -- Khorium Bar
        23117, -- Azure Moonstone
        23112, -- Golden Draenite
        23107, -- Shadow Draenite
        23079, -- Deep Peridot
        23077, -- Blood Garnet
        22861, -- Flask of Blinding Light
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
        21840, -- Bolt of Netherweave
    },
    -- https://www.wowhead.com/items?filter=87:194:166;1:1:1;0:1:0
    [1] = { -- Classic
        20520, -- Dark Rune
        19943, -- Massive Mojo
        19441, -- Huge Venom Sac
        13468, -- Black Lotus
        13467, -- Icecap
        13466, -- Sorrowmoss
        13465, -- Mountain Silversage
        13464, -- Golden Sansam
        13463, -- Dreamfoil
        13423, -- Stonescale Oil
        13422, -- Stonescale Eel
        12808, -- Essence of Undeath
        12804, -- Powerful Mojo
        12803, -- Living Essence
        12363, -- Arcane Crystal
        12360, -- Arcanite Bar
        12359, -- Thorium Bar
        10620, -- Thorium Ore
        10286, -- Heart of the Wild
        9262, -- Black Vitriol
        9260, -- Volatile Rum
        8846, -- Gromsblood
        8845, -- Ghost Mushroom
        8839, -- Blindweed
        8838, -- Sungrass
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
        3819, -- Dragon's Teeth
        3818, -- Fadeleaf
        3575, -- Iron Bar
        3371, -- Crystal Vial
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
        2325, -- Black Dye
        1475, -- Small Venom Sac
        1288, -- Large Venom Sac
        785, -- Mageroyal
        765, -- Silverleaf
        118, -- Minor Healing Potion
    },
}

-- Criteria: Reagent for Enchanting & stacks up to > 1
items.Enchanting = {
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:12;0:1:0
    [12] = { -- Midnight
        274781, -- Cursebound Globe
        274777, -- Neutralized Venom Clot
        251665, -- Silverleaf Thread
        251285, -- Petrified Root
        251283, -- Tormented Tantalum
        245882, -- Thalassian Songwater
        245881, -- Lexicologist's Vellum
        245805, -- Sienna Ink
        245801, -- Munsell Ink
        245345, -- Fused Vitality
        244637, -- Silvermoon Weapon Wrap
        243605, -- Dawn Crystal
        243602, -- Radiant Shard
        243599, -- Eversinging Dust
        243060, -- Luminant Flux
        242788, -- Dusk-Shrouded Stone
        242787, -- Crystalline Glass
        242612, -- Flawless Amani Lapis
        242611, -- Flawless Tenebrous Amethyst
        242610, -- Flawless Harandar Peridot
        240991, -- Sunglass Vial
        239201, -- Sunfire Silk Bolt
        239198, -- Arcanoweave Bolt
        238530, -- Majestic Fin
        238529, -- Majestic Hide
        238528, -- Majestic Claw
        238525, -- Fantastic Fur
        238523, -- Carving Canine
        238522, -- Peerless Plumage
        238383, -- Eversong Trout
        238204, -- Sterling Alloy
        238202, -- Gloaming Alloy
        238197, -- Refulgent Copper Ingot
        237366, -- Dazzling Thorium
        237364, -- Brilliant Silver Ore
        236952, -- Mote of Pure Void
        236951, -- Mote of Wild Magic
        236950, -- Mote of Primal Energy
        236949, -- Mote of Light
        236774, -- Azeroot
    },
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:11;0:1:0
    [11] = { -- The War Within
        256963, -- Thalassian Lumber
        251773, -- Dragonpine Lumber
        251772, -- Arden Lumber
        251768, -- Darkpine Lumber
        251767, -- Fel-Touched Lumber
        251766, -- Shadowmoon Lumber
        251764, -- Ashwood Lumber
        251763, -- Bamboo Lumber
        251762, -- Coldwind Lumber
        249218, -- Manaforged Instrument
        248012, -- Dornic Fir Lumber
        245586, -- Ironwood Lumber
        242691, -- Olemba Lumber
        224108, -- Oil of Beledar's Grace
        222555, -- Codified Greenwood
        222417, -- Core Alloy
        221859, -- Gyrating Gear
        221763, -- Viridian Charmcap
        221758, -- Profaned Tinderbox
        221756, -- Vial of Kaheti Oils
        221754, -- Ringing Deeps Ingot
        220790, -- Nascent Runed Harbinger Crest
        220789, -- Nascent Gilded Harbinger Crest
        220788, -- Nascent Weathered Harbinger Crest
        219952, -- Refulgent Crystal
        219949, -- Gleaming Shard
        219946, -- Storm Dust
        218338, -- Bottled Storm
        213613, -- Leyline Residue
        213612, -- Viridescent Spores
        213611, -- Writhing Sample
        213610, -- Crystalline Powder
        210939, -- Null Stone
        210814, -- Artisan's Acuity
    },
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:10;0:1:0
    [10] = { -- Dragonflight
        211523, -- Nascent Whelpling's Awakened Crest
        211522, -- Nascent Aspect's Awakened Crest
        211521, -- Nascent Wyrm's Awakened Crest
        208395, -- Nascent Whelpling's Dreaming Crest
        208394, -- Nascent Wyrm's Dreaming Crest
        208393, -- Nascent Aspect's Dreaming Crest
        208212, -- Dreaming Essence
        205263, -- Empowered Flightstone
        204464, -- Shadowflame Essence
        204463, -- Dracothyst
        204460, -- Zaralek Glowspores
        204196, -- Wyrm's Shadowflame Crest
        204194, -- Aspect's Shadowflame Crest
        204193, -- Whelpling's Shadowflame Crest
        203401, -- Dull Crystal
        201584, -- Serevite Rod
        201406, -- Glowing Titan Orb
        201401, -- Iridescent Plume
        200113, -- Resonant Crystal
        194862, -- Runed Writhebark
        194784, -- Glittering Parchment
        194727, -- Fiery Spirit
        194124, -- Vibrant Shard
        194123, -- Chromatic Dust
        193922, -- Wildercloth
        192869, -- Illimited Diamond
        191470, -- Writhebark
        190456, -- Artisan's Mettle
        190329, -- Awakened Frost
        190328, -- Rousing Frost
        190327, -- Awakened Air
        190326, -- Rousing Air
        190324, -- Awakened Order
        190322, -- Rousing Order
        190321, -- Awakened Fire
        190320, -- Rousing Fire
        190316, -- Awakened Earth
        190315, -- Rousing Earth
        190312, -- Khaz'gorite Ore
        189541, -- Primal Molten Alloy
        189143, -- Draconium Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:9;0:1:0
    [9] = { -- Shadowlands
        187703, -- Silken Protofiber
        187700, -- Progenium Ore
        183951, -- Immortal Shard
        182066, -- Sanguine Crystal
        182042, -- Necrotic Essence
        182020, -- Transcendent Dust
        181990, -- Twilight Dust
        177061, -- Twilight Bark
        173204, -- Lightless Silk
        172232, -- Eternal Crystal
        172231, -- Sacred Shard
        172230, -- Soul Dust
        172097, -- Heavy Callous Hide
        171833, -- Elethium Ore
        171832, -- Sinvyr Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:8;0:1:0
    [8] = { -- Battle for Azeroth
        168185, -- Osmenite Ore
        168127, -- Lingering Drust Essence
        165948, -- Tidalcore
        165703, -- Breath of Bwonsamdi
        162461, -- Sanguicell
        162460, -- Hydrocore
        158186, -- Distilled Water
        154165, -- Calcified Bone
        152877, -- Veiled Crystal
        152876, -- Umbra Shard
        152875, -- Gloom Dust
        152812, -- Monel-Hardened Hoofplates
        152668, -- Expulsom
        152541, -- Coarse Leather
    },
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:7;0:1:0
    [7] = { -- Legion
        156930, -- Rich Illusion Dust
        127835, -- Ancient Mana Potion
        124461, -- Demonsteel Bar
        124444, -- Infernal Brimstone
        124442, -- Chaos Crystal
        124441, -- Leylight Shard
        124440, -- Arkhana
        124124, -- Blood of Sargeras
        124116, -- Felhide
        124106, -- Felwort
    },
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:6;0:1:0
    [6] = { -- Warlords of Draenor
        120945, -- Primal Spirit
        118472, -- Savage Blood
        113588, -- Temporal Crystal
        113264, -- Sorcerous Air
        113263, -- Sorcerous Earth
        113262, -- Sorcerous Water
        113261, -- Sorcerous Fire
        111557, -- Sumptuous Fur
        111245, -- Luminous Shard
        109693, -- Draenic Dust
        109118, -- Blackrock Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:5;0:1:0
    [5] = { -- Mists of Pandaria
        94289, -- Haunting Spirit
        76142, -- Sun's Radiance
        76141, -- Imperial Amethyst
        76140, -- Vermilion Onyx
        76139, -- Wild Jade
        76138, -- River's Heart
        76131, -- Primordial Ruby
        76061, -- Spirit of Harmony
        74250, -- Mysterious Essence
        74249, -- Spirit Dust
        74248, -- Sha Crystal
        74247, -- Ethereal Shard
        72988, -- Windwool Cloth
    },
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:4;0:1:0
    [4] = { -- Cataclysm
        69237, -- Living Ember
        58094, -- Elixir of Impossible Accuracy
        53039, -- Hardened Elementium Bar
        52722, -- Maelstrom Crystal
        52721, -- Heavenly Shard
        52719, -- Greater Celestial Essence
        52718, -- Lesser Celestial Essence
        52555, -- Hypnotic Dust
        52329, -- Volatile Life
        52328, -- Volatile Air
        52327, -- Volatile Earth
        52326, -- Volatile Water
        52325, -- Volatile Fire
    },
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:3;0:1:0
    [3] = { -- Wrath of the Lich King
        44958, -- Ethereal Oil
        41510, -- Bolt of Frostweave
        41163, -- Titanium Bar
        39354, -- Light Parchment
        38682, -- Enchanting Vellum
        37705, -- Crystallized Water
        37663, -- Titansteel Bar
        36918, -- Scarlet Ruby
        36860, -- Eternal Fire
        35625, -- Eternal Life
        35624, -- Eternal Earth
        35623, -- Eternal Air
        35622, -- Eternal Water
        34057, -- Abyss Crystal
        34056, -- Lesser Cosmic Essence
        34055, -- Greater Cosmic Essence
        34054, -- Infinite Dust
        34052, -- Dream Shard
    },
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:2;0:1:0
    [2] = { -- Burning Crusade
        23571, -- Primal Might
        23427, -- Eternium Ore
        22824, -- Elixir of Major Strength
        22794, -- Fel Lotus
        22792, -- Nightmare Vine
        22791, -- Netherbloom
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
    -- https://www.wowhead.com/items?filter=87:194:166;4:1:1;0:1:0
    [1] = { -- Vanilla
        20520, -- Dark Rune
        20002, -- Greater Dreamless Sleep Potion
        19931, -- Gurubashi Mojo Madness
        17056, -- Light Feather
        17010, -- Fiery Core
        16204, -- Light Illusion Dust
        16203, -- Greater Eternal Essence
        16202, -- Lesser Eternal Essence
        14344, -- Large Brilliant Shard
        14343, -- Small Brilliant Shard
        14256, -- Felcloth
        13926, -- Golden Pearl
        13467, -- Icecap
        13446, -- Major Healing Potion
        13444, -- Major Mana Potion
        12811, -- Righteous Orb
        12808, -- Essence of Undeath
        12803, -- Living Essence
        12800, -- Azerothian Diamond
        12655, -- Enchanted Thorium Bar
        12365, -- Dense Stone
        12359, -- Thorium Bar
        11291, -- Star Wood
        10940, -- Strange Dust
        10939, -- Greater Magic Essence
        10938, -- Lesser Magic Essence
        9224, -- Elixir of Demonslaying
        8838, -- Sungrass
        8831, -- Purple Lotus
        8170, -- Rugged Leather
        8153, -- Wildvine
        7909, -- Aquamarine
        7392, -- Green Whelp Scale
        7082, -- Essence of Air
        7080, -- Essence of Water
        7078, -- Essence of Fire
        7076, -- Essence of Earth
        7067, -- Elemental Earth
        6370, -- Blackmouth Oil
        6037, -- Truesilver Bar
        5637, -- Large Fang
        4625, -- Firebloom
        4470, -- Simple Wood
        3857, -- Coal
        3819, -- Dragon's Teeth
        3371, -- Crystal Vial
        3356, -- Kingsblood
        2772, -- Iron Ore
    },
}

-- Criteria: Reagent for Engineering & stacks up to > 1
items.Engineering = {
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:12;0:1:0
    [12] = { -- Midnight
        274777, -- Neutralized Venom Clot
        253303, -- Pile of Junk
        253302, -- Malleable Wireframe
        251283, -- Tormented Tantalum
        245345, -- Fused Vitality
        243581, -- Evercore
        243578, -- Aetherlume
        243576, -- Soul Sprocket
        243574, -- Song Gear
        239702, -- Imbued Bright Linen Bolt
        238530, -- Majestic Fin
        238529, -- Majestic Hide
        238528, -- Majestic Claw
        238520, -- Void-Tempered Plating
        238518, -- Void-Tempered Hide
        237366, -- Dazzling Thorium
        237362, -- Umbral Tin Ore
        237359, -- Refulgent Copper Ore
        236952, -- Mote of Pure Void
        236951, -- Mote of Wild Magic
        236950, -- Mote of Primal Energy
        236949, -- Mote of Light
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:11;0:1:0
    [11] = { -- The War Within
        256963, -- Thalassian Lumber
        251773, -- Dragonpine Lumber
        251772, -- Arden Lumber
        251768, -- Darkpine Lumber
        251767, -- Fel-Touched Lumber
        251766, -- Shadowmoon Lumber
        251764, -- Ashwood Lumber
        251763, -- Bamboo Lumber
        251762, -- Coldwind Lumber
        248012, -- Dornic Fir Lumber
        245586, -- Ironwood Lumber
        242691, -- Olemba Lumber
        228956, -- Junk Bucket
        228414, -- Frayed Wiring
        227774, -- Pummel Permit
        227773, -- Pummel-Proof Plating
        227772, -- Cataclysmic Converter
        227771, -- Blinker Fluid
        227770, -- Assorted Whirligigs
        227769, -- Bountiful Bolts
        222801, -- Dawnweave Bolt
        222798, -- Duskweave Bolt
        222420, -- Charged Alloy
        222417, -- Core Alloy
        221868, -- Entropy Enhancer
        221865, -- Chaos Circuit
        221862, -- Safety Switch
        221859, -- Gyrating Gear
        221856, -- Whimsical Wiring
        221853, -- Handful of Bismuth Bolts
        221756, -- Vial of Kaheti Oils
        219892, -- Leyfused Hide
        219889, -- Sporecoated Hide
        219886, -- Writhing Hide
        219883, -- Crystalfused Hide
        219150, -- Pile of Rusted Scrap
        213753, -- Decorative Lens
        213613, -- Leyline Residue
        213611, -- Writhing Sample
        213610, -- Crystalline Powder
        213399, -- Glittering Glass
        212511, -- Ostentatious Onyx
        212508, -- Stunning Sapphire
        212505, -- Extravagant Emerald
        212498, -- Ambivalent Amber
        212495, -- Radiant Ruby
        212266, -- Potion of the Reborn Cheetah
        212263, -- Tempered Potion
        212242, -- Cavedweller's Delight
        211878, -- Algari Healing Potion
        211806, -- Gilded Vial
        210939, -- Null Stone
        210936, -- Ironclaw Ore
        210933, -- Aqirite
        210930, -- Bismuth
        210814, -- Artisan's Acuity
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:10;0:1:0
    [10] = { -- Dragonflight
        207702, -- Wartorn Scrap
        205260, -- Fleeting Glowspores
        205257, -- Temporal Vestigial
        204464, -- Shadowflame Essence
        204463, -- Dracothyst
        203402, -- Broken Gnomish Voicebox
        201832, -- Smudged Lens
        201406, -- Glowing Titan Orb
        198487, -- Iridescent Water
        198278, -- Primal Deconstruction Charge
        198228, -- Gravitational Displacer
        198201, -- Assorted Safety Fuses
        198198, -- Reinforced Machine Chassis
        198195, -- Arclight Capacitor
        198192, -- Greased-Up Gears
        198189, -- Everburning Blasting Powder
        198186, -- Shock-Spring Coil
        198183, -- Handful of Serevite Bolts
        197768, -- Celebratory Cake
        194727, -- Fiery Spirit
        193932, -- Infurious Wildercloth Bolt
        193929, -- Vibrant Wildercloth Bolt
        193922, -- Wildercloth
        193921, -- Airy Soul
        193920, -- Earthen Soul
        193919, -- Frosty Soul
        193362, -- Fiery Soul
        193248, -- Infurious Scales
        193245, -- Frostbite Scales
        193236, -- Infurious Hide
        193229, -- Mireslush Hide
        193226, -- Stonecrust Hide
        193222, -- Lustrous Scaled Hide
        193216, -- Dense Hide
        193213, -- Adamant Scales
        193208, -- Resilient Leather
        193053, -- Contoured Fowlfeather
        192887, -- Elemental Harmony
        192876, -- Frameless Lens
        192862, -- Neltharite
        192856, -- Malygite
        192849, -- Eternity Amber
        192846, -- Sundered Onyx
        192843, -- Vibrant Emerald
        192840, -- Mystic Sapphire
        192837, -- Queen's Ruby
        191496, -- Omnium Draconis
        191474, -- Draconic Vial
        191396, -- Potion of Gusts
        191393, -- Potion of the Hushed Zephyr
        191378, -- Refreshing Healing Potion
        190536, -- Infurious Alloy
        190533, -- Obsidian Seared Alloy
        190530, -- Frostfire Alloy
        190456, -- Artisan's Mettle
        190450, -- Awakened Ire
        190395, -- Serevite Ore
        190330, -- Rousing Decay
        190328, -- Rousing Frost
        190327, -- Awakened Air
        190326, -- Rousing Air
        190324, -- Awakened Order
        190321, -- Awakened Fire
        190320, -- Rousing Fire
        190316, -- Awakened Earth
        190315, -- Rousing Earth
        190312, -- Khaz'gorite Ore
        189143, -- Draconium Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:9;0:1:0
    [9] = { -- Shadowlands
        187707, -- Progenitor Essentia
        187703, -- Silken Protofiber
        187700, -- Progenium Ore
        183952, -- Machinist's Oil
        183951, -- Immortal Shard
        182064, -- Machined Sinvyr Bar
        182063, -- Sinvyr Trigger Mechanism
        182062, -- Sinvyr Barrel
        182040, -- Machined Oxxein Bar
        182039, -- Handful of Oxxein Bolts
        182038, -- Bone Reinforced Oxxein Tubing
        182018, -- Machined Solenium Bar
        182017, -- Hardened Bolts
        182016, -- Piston Assembly
        181994, -- Machined Phaedrum Bar
        181993, -- Energized Battery
        181992, -- Electro Cable
        180733, -- Luminous Flux
        178787, -- Orboreal Shard
        177062, -- Penumbra Thread
        177061, -- Twilight Bark
        173202, -- Shrouded Cloth
        173173, -- Essence of Valor
        173110, -- Umbryl
        173109, -- Angerseye
        173108, -- Oriblase
        172937, -- Wormfed Gear Assembly
        172936, -- Mortal Coiled Spring
        172935, -- Porous Polishing Abrasive
        172934, -- Handful of Laestrite Bolts
        172903, -- Nutcracker Grenade
        172231, -- Sacred Shard
        172230, -- Soul Dust
        172092, -- Pallid Bone
        172089, -- Desolate Leather
        171841, -- Shaded Stone
        171840, -- Porous Stone
        171833, -- Elethium Ore
        171832, -- Sinvyr Ore
        171831, -- Phaedrum Ore
        171830, -- Oxxein Ore
        171829, -- Solenium Ore
        171828, -- Laestrite Ore
        171441, -- Laestrite Skeleton Key
        171428, -- Shadowghast Ingot
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:8;0:1:0
    [8] = { -- Battle for Azeroth
        170553, -- Void Focus Splinter
        168185, -- Osmenite Ore
        168152, -- Miniaturized Power Core
        166970, -- Energy Cell
        165948, -- Tidalcore
        165703, -- Breath of Bwonsamdi
        163569, -- Insulated Wiring
        162461, -- Sanguicell
        162460, -- Hydrocore
        161137, -- Blast-Fired Electric Servomotor
        161136, -- Azerite Forged Protection Plating
        161132, -- Crush Resistant Stabilizer
        160502, -- Chemical Blasting Cap
        154124, -- Laribole
        154123, -- Amberblaze
        152668, -- Expulsom
        152579, -- Storm Silver Ore
        152513, -- Platinum Ore
        152512, -- Monelite Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:7;0:1:0
    [7] = { -- Legion
        151568, -- Primal Sargerite
        151564, -- Empyrium
        144329, -- Hardened Felglass
        140785, -- Hardened Circuitboard Plating
        140781, -- X-87 Battle Circuit
        137642, -- Mark of Honor
        136638, -- True Iron Barrel
        136637, -- Oversized Blasting Cap
        136636, -- Sniping Scope
        136633, -- Loose Trigger
        132523, -- Reaves Battery
        132515, -- Failure Detection Pylon
        132514, -- Auto-Hammer
        130183, -- Shadowruby
        130178, -- Furystone
        127004, -- Imbued Silkweave
        124461, -- Demonsteel Bar
        124444, -- Infernal Brimstone
        124437, -- Shal'dorei Silk
        124124, -- Blood of Sargeras
        124121, -- Wildfowl Egg
        124119, -- Big Gamy Ribs
        124116, -- Felhide
        124115, -- Stormscale
        124113, -- Stonehide Leather
        124112, -- Black Barracuda
        124109, -- Highmountain Salmon
        124106, -- Felwort
        123919, -- Felslate
        123918, -- Leystone Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:6;0:1:0
    [6] = { -- Warlords of Draenor
        127759, -- Felblight
        120945, -- Primal Spirit
        118472, -- Savage Blood
        114931, -- Cerulean Pigment
        113588, -- Temporal Crystal
        113264, -- Sorcerous Air
        111557, -- Sumptuous Fur
        111366, -- Gearspring Parts
        109128, -- Nagrand Arrowbloom
        109119, -- True Iron Ore
        109118, -- Blackrock Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:5;0:1:0
    [5] = { -- Mists of Pandaria
        94113, -- Jard's Peculiar Energy Source
        90146, -- Tinker's Kit
        87872, -- Desecrated Oil
        83092, -- Orb of Mystery
        77531, -- Mirror Scope
        77529, -- Lord Blastington's Scope of Doom
        77468, -- High-Explosive Gunpowder
        77467, -- Ghost Iron Bolts
        76142, -- Sun's Radiance
        76140, -- Vermilion Onyx
        76139, -- Wild Jade
        76138, -- River's Heart
        76133, -- Lapis Lazuli
        76132, -- Primal Diamond
        76131, -- Primordial Ruby
        76061, -- Spirit of Harmony
        72988, -- Windwool Cloth
        72104, -- Living Steel
        72096, -- Ghost Iron Bar
        72095, -- Trillium Bar
        72093, -- Kyparite
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:4;0:1:0
    [4] = { -- Cataclysm
        67749, -- Electrified Ether
        62778, -- Toughened Flesh
        62654, -- Lavascale Fillet
        60224, -- Handful of Obsidium Bolts
        58480, -- Truegold
        54849, -- Obsidium Bar
        53039, -- Hardened Elementium Bar
        53010, -- Embersilk Cloth
        52976, -- Savage Leather
        52328, -- Volatile Air
        52327, -- Volatile Earth
        52325, -- Volatile Fire
        52192, -- Dream Emerald
        52191, -- Ocean Sapphire
        52190, -- Inferno Ruby
        52186, -- Elementium Bar
        52182, -- Jasper
        52181, -- Hessonite
        52179, -- Alicite
        52078, -- Chaos Orb
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:3;0:1:0
    [3] = { -- Wrath of the Lich King
        44501, -- Goblin-Machined Piston
        44500, -- Elementium-Plated Exhaust Pipe
        44499, -- Salvaged Iron Golem Parts
        44128, -- Arctic Fur
        43102, -- Frozen Orb
        41163, -- Titanium Bar
        41146, -- Sun Scope
        40769, -- Scrapbot Construction Kit
        40533, -- Walnut Stock
        39690, -- Volatile Blasting Trigger
        39684, -- Hair Trigger
        39683, -- Froststeel Tube
        39682, -- Overcharged Capacitor
        39681, -- Handful of Cobalt Bolts
        39354, -- Light Parchment
        38425, -- Heavy Borean Leather
        37705, -- Crystallized Water
        37702, -- Crystallized Fire
        37701, -- Crystallized Earth
        37663, -- Titansteel Bar
        36933, -- Forest Emerald
        36930, -- Monarch Topaz
        36927, -- Twilight Opal
        36924, -- Sky Sapphire
        36922, -- King's Amber
        36921, -- Autumn's Glow
        36920, -- Sun Crystal
        36918, -- Scarlet Ruby
        36916, -- Cobalt Bar
        36913, -- Saronite Bar
        36860, -- Eternal Fire
        35627, -- Eternal Shadow
        35625, -- Eternal Life
        35624, -- Eternal Earth
        35623, -- Eternal Air
        35622, -- Eternal Water
        34052, -- Dream Shard
        33568, -- Borean Leather
        33470, -- Frostweave Cloth
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:2;0:1:0
    [2] = { -- Burning Crusade
        35128, -- Hardened Khorium
        34113, -- Field Repair Bot 110G
        32423, -- Icy Blasting Primers
        24272, -- Shadowcloth
        24271, -- Spellcloth
        23826, -- The Bigger One
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
    },
    -- https://www.wowhead.com/items?filter=87:194:166;5:1:1;0:1:0
    [1] = { -- Vanilla
        18631, -- Truesilver Transformer
        18232, -- Field Repair Bot 74A
        17202, -- Snowball
        17011, -- Lava Core
        17010, -- Fiery Core
        16006, -- Delicate Arcanite Converter
        16000, -- Thorium Tube
        15994, -- Thorium Widget
        15992, -- Dense Blasting Powder
        15407, -- Cured Rugged Hide
        14227, -- Ironweb Spider Silk
        14048, -- Bolt of Runecloth
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
        9318, -- Red Firework
        9313, -- Green Firework
        9312, -- Blue Firework
        9061, -- Goblin Rocket Fuel
        9060, -- Inlaid Mithril Cylinder
        8170, -- Rugged Leather
        8153, -- Wildvine
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
        4406, -- Standard Scope
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
        3857, -- Coal
        3829, -- Frost Oil
        3577, -- Gold Bar
        3575, -- Iron Bar
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
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:12;0:1:0
    [12] = { -- Midnight
        274781, -- Cursebound Globe
        274777, -- Neutralized Venom Clot
        251285, -- Petrified Root
        251283, -- Tormented Tantalum
        245345, -- Fused Vitality
        244637, -- Silvermoon Weapon Wrap
        244635, -- Sin'dorei Armor Banding
        243060, -- Luminant Flux
        242788, -- Dusk-Shrouded Stone
        238530, -- Majestic Fin
        238529, -- Majestic Hide
        238528, -- Majestic Claw
        238204, -- Sterling Alloy
        238202, -- Gloaming Alloy
        238197, -- Refulgent Copper Ingot
        237366, -- Dazzling Thorium
        237364, -- Brilliant Silver Ore
        237362, -- Umbral Tin Ore
        237359, -- Refulgent Copper Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:11;0:1:0
    [11] = { -- The War Within
        256963, -- Thalassian Lumber
        251773, -- Dragonpine Lumber
        251772, -- Arden Lumber
        251768, -- Darkpine Lumber
        251767, -- Fel-Touched Lumber
        251766, -- Shadowmoon Lumber
        251764, -- Ashwood Lumber
        251763, -- Bamboo Lumber
        251762, -- Coldwind Lumber
        248012, -- Dornic Fir Lumber
        245586, -- Ironwood Lumber
        242691, -- Olemba Lumber
        226202, -- Echoing Flux
        222523, -- Coreforged Skeleton Key
        222426, -- Ironclaw Alloy
        222423, -- Sanctified Alloy
        222420, -- Charged Alloy
        222417, -- Core Alloy
        221856, -- Whimsical Wiring
        221853, -- Handful of Bismuth Bolts
        221758, -- Profaned Tinderbox
        221757, -- Gloomfathom Hide
        221756, -- Vial of Kaheti Oils
        221754, -- Ringing Deeps Ingot
        219901, -- Storm-Touched Weapon Wrap
        219013, -- Superb Beast Fang
        213610, -- Crystalline Powder
        210939, -- Null Stone
        210936, -- Ironclaw Ore
        210933, -- Aqirite
        210930, -- Bismuth
        210814, -- Artisan's Acuity
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:10;0:1:0
    [10] = { -- Dragonflight
        207702, -- Wartorn Scrap
        205413, -- Obsidian Cobraskin
        205257, -- Temporal Vestigial
        204995, -- Shadowed Alloy
        204857, -- Ancient Elementium Fragment
        204464, -- Shadowflame Essence
        203865, -- Brilliant Wizard Oil
        203862, -- Brilliant Mana Oil
        203399, -- Damaged Trident
        201406, -- Glowing Titan Orb
        201403, -- Mastodon Tusk
        201402, -- Large Sturdy Femur
        201400, -- Aquatic Maw
        201399, -- Primal Bear Spine
        194727, -- Fiery Spirit
        193922, -- Wildercloth
        193920, -- Earthen Soul
        193919, -- Frosty Soul
        193368, -- Silken Gemdust
        193362, -- Fiery Soul
        193360, -- Centaur's Trophy Necklace
        192883, -- Glossy Stone
        192849, -- Eternity Amber
        192846, -- Sundered Onyx
        192843, -- Vibrant Emerald
        192840, -- Mystic Sapphire
        192837, -- Queen's Ruby
        191363, -- Potion of Frozen Focus
        190536, -- Infurious Alloy
        190533, -- Obsidian Seared Alloy
        190530, -- Frostfire Alloy
        190456, -- Artisan's Mettle
        190452, -- Primal Flux
        190450, -- Awakened Ire
        190395, -- Serevite Ore
        190329, -- Awakened Frost
        190324, -- Awakened Order
        190321, -- Awakened Fire
        190316, -- Awakened Earth
        190312, -- Khaz'gorite Ore
        189541, -- Primal Molten Alloy
        189143, -- Draconium Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:9;0:1:0
    [9] = { -- Shadowlands
        187707, -- Progenitor Essentia
        187700, -- Progenium Ore
        186017, -- Korthite Crystal
        182094, -- Borrowed Sinvyr Rod
        182093, -- Soft Manacle Chains
        182092, -- Tempered Manacle Chains
        182091, -- Borrowed Sinvyr Bar
        182090, -- Binding Cuffs
        182089, -- Enchanted Rivets
        182088, -- Borrowed Oxxein Ore
        182087, -- Soft Heavy Razor
        182086, -- Hardened Heavy Razor
        181860, -- Borrowed Twilight Bark
        181793, -- Shattered Kyrian Shield Fragment
        181792, -- Tarnished Kyrian Shield
        181790, -- Reforged Kyrian Shield
        181789, -- Wooden Arrowhead Mold
        181788, -- Unrefined Arrowheads
        181787, -- Molten Phaedrum
        181783, -- Borrowed Phaedrum Ore
        180733, -- Luminous Flux
        178787, -- Orboreal Shard
        173204, -- Lightless Silk
        173202, -- Shrouded Cloth
        173173, -- Essence of Valor
        173171, -- Essence of Torment
        173109, -- Angerseye
        173060, -- Aerated Water
        172437, -- Enchanted Elethium Bar
        171841, -- Shaded Stone
        171840, -- Porous Stone
        171833, -- Elethium Ore
        171832, -- Sinvyr Ore
        171831, -- Phaedrum Ore
        171830, -- Oxxein Ore
        171829, -- Solenium Ore
        171828, -- Laestrite Ore
        171428, -- Shadowghast Ingot
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:8;0:1:0
    [8] = { -- Battle for Azeroth
        170553, -- Void Focus Splinter
        169445, -- Dredged Leather Bladder
        168185, -- Osmenite Ore
        168135, -- Titan's Blood
        165948, -- Tidalcore
        165703, -- Breath of Bwonsamdi
        162461, -- Sanguicell
        162460, -- Hydrocore
        160298, -- Durable Flux
        154898, -- Meaty Haunch
        152812, -- Monel-Hardened Hoofplates
        152668, -- Expulsom
        152579, -- Storm Silver Ore
        152513, -- Platinum Ore
        152512, -- Monelite Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:7;0:1:0
    [7] = { -- Legion
        151923, -- Empyrial Rivet
        151568, -- Primal Sargerite
        151564, -- Empyrium
        133591, -- River Onion
        133589, -- Dalapeño Pepper
        133588, -- Flaked Sea Salt
        130179, -- Eye of Prophecy
        128777, -- Heated Leystone Bar
        124461, -- Demonsteel Bar
        124454, -- Brimstone-Crusted Armguards
        124453, -- Brimstone-Covered Armguards
        124451, -- Felsmith's Infernal Brimstone
        124450, -- Engraved Leystone Armguards
        124449, -- Felsmith's Leystone Armguards
        124444, -- Infernal Brimstone
        124441, -- Leylight Shard
        124440, -- Arkhana
        124439, -- Unbroken Tooth
        124438, -- Unbroken Claw
        124437, -- Shal'dorei Silk
        124436, -- Foxflower Flux
        124435, -- Leystone Neckplate
        124432, -- Leystone Dome
        124431, -- Leystone Faceguard
        124430, -- Leystone Soleplate
        124429, -- Leystone Footguard
        124428, -- Leystone Heelguard
        124427, -- Leystone Shinplate
        124425, -- Felsmith's Leystone Bar
        124423, -- Heated Hard Leystone Ingot
        124422, -- Hard Leystone Ingot
        124421, -- Lump of Leystone Slag
        124420, -- Leystone Shard
        124418, -- Leystone Slag
        124417, -- Shopkeeper's Leystone Ore
        124407, -- Large Heated Metal Scrap
        124406, -- Medium Heated Metal Scrap
        124405, -- Small Heated Metal Scrap
        124404, -- Large Metal Scrap
        124403, -- Medium Metal Scrap
        124402, -- Small Metal Scrap
        124396, -- Dull Hard Leystone Armguards
        124395, -- Heated Hard Leystone Bar
        124394, -- Hard Leystone Bar
        124393, -- Leystone Slag
        124392, -- Shopkeeper's Leystone Ore
        124124, -- Blood of Sargeras
        124116, -- Felhide
        124115, -- Stormscale
        124113, -- Stonehide Leather
        124109, -- Highmountain Salmon
        124010, -- Leystone Fingerguard
        124009, -- Leystone Cuffplate
        124007, -- Leystone Bar
        124005, -- Shopkeeper's Leystone Ore
        123919, -- Felslate
        123918, -- Leystone Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:6;0:1:0
    [6] = { -- Warlords of Draenor
        127759, -- Felblight
        120945, -- Primal Spirit
        118472, -- Savage Blood
        113261, -- Sorcerous Fire
        111557, -- Sumptuous Fur
        110609, -- Raw Beast Hide
        109119, -- True Iron Ore
        109118, -- Blackrock Ore
        108257, -- Truesteel Ingot
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:5;0:1:0
    [5] = { -- Mists of Pandaria
        102218, -- Spirit of War
        98717, -- Balanced Trillium Ingot
        94289, -- Haunting Spirit
        94111, -- Lightning Steel Ingot
        80433, -- Blood Spirit
        77468, -- High-Explosive Gunpowder
        77467, -- Ghost Iron Bolts
        76061, -- Spirit of Harmony
        72104, -- Living Steel
        72096, -- Ghost Iron Bar
        72095, -- Trillium Bar
        72093, -- Kyparite
        72092, -- Ghost Iron Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:4;0:1:0
    [4] = { -- Cataclysm
        71998, -- Essence of Destruction
        69237, -- Living Ember
        65365, -- Folded Obsidium
        58480, -- Truegold
        56516, -- Heavy Savage Leather
        54849, -- Obsidium Bar
        53039, -- Hardened Elementium Bar
        53038, -- Obsidium Ore
        52329, -- Volatile Life
        52327, -- Volatile Earth
        52326, -- Volatile Water
        52325, -- Volatile Fire
        52193, -- Ember Topaz
        52191, -- Ocean Sapphire
        52190, -- Inferno Ruby
        52186, -- Elementium Bar
        52185, -- Elementium Ore
        52182, -- Jasper
        52178, -- Zephyrite
        52078, -- Chaos Orb
        51950, -- Pyrium Bar
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:3;0:1:0
    [3] = { -- Wrath of the Lich King
        49908, -- Primordial Saronite
        47556, -- Crusader Orb
        45087, -- Runed Orb
        43102, -- Frozen Orb
        41163, -- Titanium Bar
        37705, -- Crystallized Water
        37703, -- Crystallized Shadow
        37702, -- Crystallized Fire
        37701, -- Crystallized Earth
        37700, -- Crystallized Air
        37663, -- Titansteel Bar
        36925, -- Majestic Zircon
        36916, -- Cobalt Bar
        36913, -- Saronite Bar
        36912, -- Saronite Ore
        36909, -- Cobalt Ore
        36860, -- Eternal Fire
        35627, -- Eternal Shadow
        35625, -- Eternal Life
        35624, -- Eternal Earth
        35623, -- Eternal Air
        35622, -- Eternal Water
        34054, -- Infinite Dust
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:2;0:1:0
    [2] = { -- Burning Crusade
        35128, -- Hardened Khorium
        34664, -- Sunmote
        32428, -- Heart of Darkness
        30183, -- Nether Vortex
        27503, -- Scroll of Strength V
        25868, -- Skyfire Diamond
        23573, -- Hardened Adamantite Bar
        23572, -- Primal Nether
        23571, -- Primal Might
        23449, -- Khorium Bar
        23448, -- Felsteel Bar
        23447, -- Eternium Bar
        23446, -- Adamantite Bar
        23445, -- Fel Iron Bar
        23424, -- Fel Iron Ore
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
        21845, -- Primal Mooncloth
    },
    -- https://www.wowhead.com/items?filter=87:194:166;2:1:1;0:1:0
    [1] = { -- Vanilla
        22682, -- Frozen Rune
        22203, -- Large Obsidian Shard
        22202, -- Small Obsidian Shard
        20520, -- Dark Rune
        20007, -- Mageblood Elixir
        20004, -- Mighty Troll's Blood Elixir
        19943, -- Massive Mojo
        19931, -- Gurubashi Mojo Madness
        19441, -- Huge Venom Sac
        18567, -- Elemental Flux
        18335, -- Pristine Black Diamond
        17203, -- Sulfuron Ingot
        17012, -- Core Leather
        17011, -- Lava Core
        17010, -- Fiery Core
        15417, -- Devilsaur Leather
        14344, -- Large Brilliant Shard
        14256, -- Felcloth
        14047, -- Runecloth
        13926, -- Golden Pearl
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
        10620, -- Thorium Ore
        9210, -- Ghost Dye
        8170, -- Rugged Leather
        8153, -- Wildvine
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
        6041, -- Steel Weapon Chain
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
        3858, -- Mithril Ore
        3857, -- Coal
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
        2772, -- Iron Ore
        2771, -- Tin Ore
        2770, -- Copper Ore
        2605, -- Green Dye
        2604, -- Red Dye
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

-- Criteria: Reagent for Jewelcrafting & stacks up to > 1
items.Jewelcrafting = {
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:12;0:1:0
    [12] = { -- Midnight
        274781, -- Cursebound Globe
        274777, -- Neutralized Venom Clot
        253307, -- Infused Heliotrope
        251665, -- Silverleaf Thread
        251285, -- Petrified Root
        251283, -- Tormented Tantalum
        245345, -- Fused Vitality
        244637, -- Silvermoon Weapon Wrap
        244633, -- Infused Scalewoven Hide
        243605, -- Dawn Crystal
        242788, -- Dusk-Shrouded Stone
        242787, -- Crystalline Glass
        242620, -- Glimmering Gemdust
        242613, -- Flawless Sanguine Garnet
        242612, -- Flawless Amani Lapis
        242611, -- Flawless Tenebrous Amethyst
        242610, -- Flawless Harandar Peridot
        242608, -- Eversong Diamond
        242607, -- Harandar Peridot
        242606, -- Tenebrous Amethyst
        242554, -- Amani Lapis
        242553, -- Sanguine Garnet
        240974, -- Kaleidoscopic Prism
        240972, -- Sin'dorei Lens
        238529, -- Majestic Hide
        238518, -- Void-Tempered Hide
        237362, -- Umbral Tin Ore
        237359, -- Refulgent Copper Ore
        236952, -- Mote of Pure Void
        236951, -- Mote of Wild Magic
        236950, -- Mote of Primal Energy
        236949, -- Mote of Light
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:11;0:1:0
    [11] = { -- The War Within
        256963, -- Thalassian Lumber
        251773, -- Dragonpine Lumber
        251772, -- Arden Lumber
        251768, -- Darkpine Lumber
        251767, -- Fel-Touched Lumber
        251766, -- Shadowmoon Lumber
        251764, -- Ashwood Lumber
        251763, -- Bamboo Lumber
        251762, -- Coldwind Lumber
        248012, -- Dornic Fir Lumber
        245586, -- Ironwood Lumber
        242691, -- Olemba Lumber
        239107, -- Black Blood Infused Bar
        239106, -- Shadow-Infused Onyx
        222417, -- Core Alloy
        221754, -- Ringing Deeps Ingot
        219949, -- Gleaming Shard
        215236, -- Vicious Bloodstone
        213759, -- Inverted Prism
        213756, -- Marbled Stone
        213753, -- Decorative Lens
        213750, -- Engraved Gemcutter
        213399, -- Glittering Glass
        213398, -- Handful of Pebbles
        213219, -- Crushed Gemstones
        212514, -- Blasphemite
        212511, -- Ostentatious Onyx
        212508, -- Stunning Sapphire
        212505, -- Extravagant Emerald
        212498, -- Ambivalent Amber
        212495, -- Radiant Ruby
        210939, -- Null Stone
        210936, -- Ironclaw Ore
        210933, -- Aqirite
        210930, -- Bismuth
        210814, -- Artisan's Acuity
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:10;0:1:0
    [10] = { -- Dragonflight
        210456, -- Dreaming Antler Fragment
        208212, -- Dreaming Essence
        207702, -- Wartorn Scrap
        205258, -- Everburning Shadowflame
        205257, -- Temporal Vestigial
        204463, -- Dracothyst
        204215, -- Dormant Primordial Fragment
        203404, -- Crystal Fork
        201406, -- Glowing Titan Orb
        201405, -- Tuft of Primal Wool
        200867, -- Glimmering Neltharite Cluster
        200866, -- Glimmering Malygite Cluster
        200865, -- Glimmering Ysemerald Cluster
        200864, -- Glimmering Alexstraszite Cluster
        200863, -- Glimmering Nozdorite Cluster
        200860, -- Draconic Stopper
        200113, -- Resonant Crystal
        194730, -- Scalebelly Mackerel
        194727, -- Fiery Spirit
        194124, -- Vibrant Shard
        194123, -- Chromatic Dust
        193929, -- Vibrant Wildercloth Bolt
        193922, -- Wildercloth
        193921, -- Airy Soul
        193920, -- Earthen Soul
        193919, -- Frosty Soul
        193368, -- Silken Gemdust
        193362, -- Fiery Soul
        193053, -- Contoured Fowlfeather
        193029, -- Projection Prism
        192887, -- Elemental Harmony
        192883, -- Glossy Stone
        192880, -- Crumbled Stone
        192876, -- Frameless Lens
        192872, -- Fractured Glass
        192869, -- Illimited Diamond
        192866, -- Nozdorite
        192862, -- Neltharite
        192859, -- Ysemerald
        192856, -- Malygite
        192852, -- Alexstraszite
        192849, -- Eternity Amber
        192846, -- Sundered Onyx
        192843, -- Vibrant Emerald
        192840, -- Mystic Sapphire
        192837, -- Queen's Ruby
        192834, -- Shimmering Clasp
        192833, -- Misshapen Filigree
        191493, -- Primal Convergent
        190456, -- Artisan's Mettle
        190451, -- Rousing Ire
        190450, -- Awakened Ire
        190395, -- Serevite Ore
        190329, -- Awakened Frost
        190328, -- Rousing Frost
        190327, -- Awakened Air
        190326, -- Rousing Air
        190324, -- Awakened Order
        190321, -- Awakened Fire
        190320, -- Rousing Fire
        190316, -- Awakened Earth
        190315, -- Rousing Earth
        190312, -- Khaz'gorite Ore
        189143, -- Draconium Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:9;0:1:0
    [9] = { -- Shadowlands
        187707, -- Progenitor Essentia
        187700, -- Progenium Ore
        186017, -- Korthite Crystal
        183954, -- Malleable Wire
        182308, -- Garnet Shard
        182289, -- Handful of Glimmering Gemstones
        182197, -- Borrowed Kyranite
        182058, -- Polished Sinvyr Bar
        182057, -- Fine Sinvyr Chain
        182056, -- Brilliant Bauble
        182034, -- Jagged Necrotic Crystal
        182033, -- Faceted Crystal
        182032, -- Hollowed Crystal
        182012, -- Borrowed Solenium Nugget
        182011, -- Solenium Wire
        182010, -- Kyranite Dangle
        182000, -- Polished Phedrum Rod
        181999, -- Polished Gemstones
        181998, -- Engraved Phaedrum Band
        178787, -- Orboreal Shard
        173173, -- Essence of Valor
        173172, -- Essence of Servitude
        173171, -- Essence of Torment
        173170, -- Essence of Rebirth
        173168, -- Laestrite Setting
        173130, -- Masterful Jewel Cluster
        173129, -- Versatile Jewel Cluster
        173128, -- Quick Jewel Cluster
        173127, -- Deadly Jewel Cluster
        173124, -- Masterful Jewel Doublet
        173123, -- Versatile Jewel Doublet
        173122, -- Quick Jewel Doublet
        173121, -- Deadly Jewel Doublet
        173110, -- Umbryl
        173109, -- Angerseye
        173108, -- Oriblase
        172232, -- Eternal Crystal
        172230, -- Soul Dust
        171841, -- Shaded Stone
        171840, -- Porous Stone
        171833, -- Elethium Ore
        171832, -- Sinvyr Ore
        171831, -- Phaedrum Ore
        171830, -- Oxxein Ore
        171829, -- Solenium Ore
        171828, -- Laestrite Ore
        171428, -- Shadowghast Ingot
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:8;0:1:0
    [8] = { -- Battle for Azeroth
        170553, -- Void Focus Splinter
        168635, -- Leviathan's Eye
        168193, -- Azsharine
        168192, -- Sand Spinel
        168191, -- Sea Currant
        168190, -- Lava Lazuli
        168189, -- Dark Opal
        168188, -- Sage Agate
        168185, -- Osmenite Ore
        168134, -- Fine Azerite Powder
        165948, -- Tidalcore
        165703, -- Breath of Bwonsamdi
        162461, -- Sanguicell
        162460, -- Hydrocore
        158187, -- Ultramarine Ink
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
        152668, -- Expulsom
        152579, -- Storm Silver Ore
        152513, -- Platinum Ore
        152512, -- Monelite Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:7;0:1:0
    [7] = { -- Legion
        151933, -- Empyrial Florid Malachite Setting
        151932, -- Empyrial Hesselian Setting
        151722, -- Florid Malachite
        151721, -- Hesselian
        151720, -- Chemirine
        151719, -- Lightsphene
        151718, -- Argulite
        151579, -- Labradorite
        151568, -- Primal Sargerite
        151564, -- Empyrium
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
        127004, -- Imbued Silkweave
        124461, -- Demonsteel Bar
        124444, -- Infernal Brimstone
        124124, -- Blood of Sargeras
        124106, -- Felwort
        123919, -- Felslate
        123918, -- Leystone Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:6;0:1:0
    [6] = { -- Warlords of Draenor
        127759, -- Felblight
        120945, -- Primal Spirit
        115815, -- Greater Stamina Taladite
        115814, -- Greater Versatility Taladite
        115812, -- Greater Mastery Taladite
        115811, -- Greater Haste Taladite
        115809, -- Greater Critical Strike Taladite
        115808, -- Stamina Taladite
        115807, -- Versatility Taladite
        115805, -- Mastery Taladite
        115804, -- Haste Taladite
        115803, -- Critical Strike Taladite
        115524, -- Taladite Crystal
        113264, -- Sorcerous Air
        113263, -- Sorcerous Earth
        113262, -- Sorcerous Water
        113261, -- Sorcerous Fire
        111557, -- Sumptuous Fur
        109129, -- Talador Orchid
        109127, -- Starflower
        109126, -- Gorgrond Flytrap
        109125, -- Fireweed
        109124, -- Frostweed
        109119, -- True Iron Ore
        109118, -- Blackrock Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:5;0:1:0
    [5] = { -- Mists of Pandaria
        83092, -- Orb of Mystery
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
        76061, -- Spirit of Harmony
        72104, -- Living Steel
        72096, -- Ghost Iron Bar
        72095, -- Trillium Bar
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:4;0:1:0
    [4] = { -- Cataclysm
        71810, -- Elven Peridot
        71809, -- Shadow Spinel
        71808, -- Lava Coral
        71807, -- Deepholm Iolite
        71806, -- Lightstone
        71805, -- Queen's Garnet
        58480, -- Truegold
        54849, -- Obsidium Bar
        53010, -- Embersilk Cloth
        52555, -- Hypnotic Dust
        52329, -- Volatile Life
        52328, -- Volatile Air
        52327, -- Volatile Earth
        52326, -- Volatile Water
        52325, -- Volatile Fire
        52303, -- Shadowspirit Diamond
        52196, -- Chimera's Eye
        52195, -- Amberjewel
        52194, -- Demonseye
        52193, -- Ember Topaz
        52192, -- Dream Emerald
        52191, -- Ocean Sapphire
        52190, -- Inferno Ruby
        52188, -- Jeweler's Setting
        52186, -- Elementium Bar
        52182, -- Jasper
        52181, -- Hessonite
        52180, -- Nightstone
        52179, -- Alicite
        52178, -- Zephyrite
        52177, -- Carnelian
        52078, -- Chaos Orb
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:3;0:1:0
    [3] = { -- Wrath of the Lich King
        43102, -- Frozen Orb
        42225, -- Dragon's Eye
        41334, -- Earthsiege Diamond
        41266, -- Skyflare Diamond
        41163, -- Titanium Bar
        37701, -- Crystallized Earth
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
        36916, -- Cobalt Bar
        36860, -- Eternal Fire
        36784, -- Siren's Tear
        36783, -- Northsea Pearl
        35627, -- Eternal Shadow
        35625, -- Eternal Life
        35624, -- Eternal Earth
        35623, -- Eternal Air
        35622, -- Eternal Water
        34054, -- Infinite Dust
        34052, -- Dream Shard
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:2;0:1:0
    [2] = { -- Burning Crusade
        35128, -- Hardened Khorium
        34664, -- Sunmote
        32249, -- Seaspray Emerald
        32231, -- Pyrestone
        32230, -- Shadowsong Amethyst
        32229, -- Lionseye
        32228, -- Empyrean Sapphire
        32227, -- Crimson Spinel
        31079, -- Mercurial Adamantite
        27860, -- Purified Draenic Water
        25868, -- Skyfire Diamond
        25867, -- Earthstorm Diamond
        24479, -- Shadow Pearl
        24478, -- Jaggal Pearl
        24243, -- Adamantite Powder
        23573, -- Hardened Adamantite Bar
        23572, -- Primal Nether
        23571, -- Primal Might
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
        23117, -- Azure Moonstone
        23112, -- Golden Draenite
        23107, -- Shadow Draenite
        23079, -- Deep Peridot
        23077, -- Blood Garnet
        22578, -- Mote of Water
        22457, -- Primal Mana
        22456, -- Primal Shadow
        22452, -- Primal Earth
        22451, -- Primal Air
        21929, -- Flame Spessarite
        21886, -- Primal Life
        21885, -- Primal Water
        21884, -- Primal Fire
        21752, -- Thorium Setting
        20963, -- Mithril Filigree
        20817, -- Bronze Setting
        20816, -- Delicate Copper Wire
    },
    -- https://www.wowhead.com/items?filter=87:194:166;7:1:1;0:1:0
    [1] = { -- Vanilla
        22682, -- Frozen Rune
        19943, -- Massive Mojo
        18335, -- Pristine Black Diamond
        17011, -- Lava Core
        16204, -- Light Illusion Dust
        14344, -- Large Brilliant Shard
        12808, -- Essence of Undeath
        12804, -- Powerful Mojo
        12803, -- Living Essence
        12800, -- Azerothian Diamond
        12799, -- Large Opal
        12662, -- Demonic Rune
        12365, -- Dense Stone
        12364, -- Huge Emerald
        12363, -- Arcane Crystal
        12361, -- Blue Sapphire
        12360, -- Arcanite Bar
        12359, -- Thorium Bar
        11754, -- Black Diamond
        11371, -- Dark Iron Bar
        10286, -- Heart of the Wild
        9210, -- Ghost Dye
        7971, -- Black Pearl
        7912, -- Solid Stone
        7910, -- Star Ruby
        7909, -- Aquamarine
        7081, -- Breath of Wind
        7079, -- Globe of Water
        7078, -- Essence of Fire
        7077, -- Heart of Fire
        7076, -- Essence of Earth
        7075, -- Core of Earth
        7070, -- Elemental Water
        7067, -- Elemental Earth
        6149, -- Greater Mana Potion
        6037, -- Truesilver Bar
        5637, -- Large Fang
        5498, -- Small Lustrous Pearl
        3864, -- Citrine
        3860, -- Mithril Bar
        3827, -- Mana Potion
        3824, -- Shadow Oil
        3577, -- Gold Bar
        3575, -- Iron Bar
        3391, -- Elixir of Ogre's Strength
        2842, -- Silver Bar
        2841, -- Bronze Bar
        2840, -- Copper Bar
        2838, -- Heavy Stone
        2836, -- Coarse Stone
        2835, -- Rough Stone
        1705, -- Lesser Moonstone
        1529, -- Jade
        1210, -- Shadowgem
        1206, -- Moss Agate
        818, -- Tigerseye
        774, -- Malachite
    },
}

-- Criteria: Reagent for Inscription & stacks up to > 1
items.Inscription = {
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:12;0:1:0
    [12] = { -- Midnight
        274781, -- Cursebound Globe
        274777, -- Neutralized Venom Clot
        251923, -- Thalassian Essence of the Faire
        251285, -- Petrified Root
        251283, -- Tormented Tantalum
        245882, -- Thalassian Songwater
        245881, -- Lexicologist's Vellum
        245879, -- Vantus Rune: Radiant
        245867, -- Mana Lily Pigment
        245865, -- Sanguithorn Pigment
        245807, -- Powder Pigment
        245805, -- Sienna Ink
        245803, -- Argentleaf Pigment
        245801, -- Munsell Ink
        245766, -- Soul Cipher
        245764, -- Codified Azeroot
        245345, -- Fused Vitality
        242788, -- Dusk-Shrouded Stone
        238530, -- Majestic Fin
        238529, -- Majestic Hide
        238528, -- Majestic Claw
        236952, -- Mote of Pure Void
        236951, -- Mote of Wild Magic
        236950, -- Mote of Primal Energy
        236949, -- Mote of Light
        236774, -- Azeroot
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:11;0:1:0
    [11] = { -- The War Within
        256963, -- Thalassian Lumber
        251773, -- Dragonpine Lumber
        251772, -- Arden Lumber
        251768, -- Darkpine Lumber
        251767, -- Fel-Touched Lumber
        251766, -- Shadowmoon Lumber
        251764, -- Ashwood Lumber
        251763, -- Bamboo Lumber
        251762, -- Coldwind Lumber
        249218, -- Manaforged Instrument
        248012, -- Dornic Fir Lumber
        245586, -- Ironwood Lumber
        242691, -- Olemba Lumber
        226205, -- Distilled Algari Freshwater
        226204, -- Fresh Parchment
        224805, -- Blossom Pigment
        224802, -- Orbinid Pigment
        222618, -- Nacreous Pigment
        222615, -- Apricate Ink
        222612, -- Luredrop Pigment
        222609, -- Shadow Ink
        222558, -- Boundless Cipher
        222555, -- Codified Greenwood
        222523, -- Coreforged Skeleton Key
        222417, -- Core Alloy
        221754, -- Ringing Deeps Ingot
        213613, -- Leyline Residue
        213612, -- Viridescent Spores
        213611, -- Writhing Sample
        213610, -- Crystalline Powder
        212664, -- Stormcharged Leather
        212508, -- Stunning Sapphire
        210814, -- Artisan's Acuity
        210808, -- Arathor's Spear
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:10;0:1:0
    [10] = { -- Dragonflight
        204464, -- Shadowflame Essence
        204460, -- Zaralek Glowspores
        204092, -- Auric Fleece
        203865, -- Brilliant Wizard Oil
        203403, -- Hastily Scrawled Rune
        198615, -- Pentagold Seal
        198487, -- Iridescent Water
        198421, -- Shimmering Pigment
        198418, -- Blazing Pigment
        198415, -- Flourishing Pigment
        198412, -- Serene Pigment
        197736, -- Finished Prototype Regal Barding
        197735, -- Finished Prototype Explorer's Barding
        194862, -- Runed Writhebark
        194859, -- Chilled Rune
        194856, -- Serene Ink
        194850, -- Flourishing Ink
        194784, -- Glittering Parchment
        194760, -- Burnished Ink
        194754, -- Cosmic Ink
        194751, -- Blazing Ink
        194727, -- Fiery Spirit
        193922, -- Wildercloth
        193259, -- Flawless Proto Dragon Scale
        193254, -- Rockfang Leather
        193053, -- Contoured Fowlfeather
        192872, -- Fractured Glass
        191474, -- Draconic Vial
        191470, -- Writhebark
        190456, -- Artisan's Mettle
        190450, -- Awakened Ire
        190395, -- Serevite Ore
        190331, -- Awakened Decay
        190329, -- Awakened Frost
        190328, -- Rousing Frost
        190327, -- Awakened Air
        190326, -- Rousing Air
        190324, -- Awakened Order
        190321, -- Awakened Fire
        190316, -- Awakened Earth
        190315, -- Rousing Earth
        190312, -- Khaz'gorite Ore
        189143, -- Draconium Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:9;0:1:0
    [9] = { -- Shadowlands
        187701, -- Protogenic Pelt
        187699, -- First Flower
        183953, -- Sealing Wax
        182309, -- Rigid Vellum
        182297, -- Flayed Flesh
        182286, -- Twilight Parchment
        182202, -- Borrowed Parchment
        182061, -- Prideful Pigment
        182060, -- Prideful Ink
        182059, -- Scroll of Castigation
        182037, -- Necrotic Pigment
        182036, -- Necrotic Ink
        182035, -- Scroll of Unyielding Strength
        182015, -- Opalescent Pigment
        182014, -- Opalescent Ink
        182013, -- Poem on Duty
        181997, -- Ardenberry Pigment
        181996, -- Ardenberry Ink
        181995, -- Scroll of Calming Lyrics
        180732, -- Rune Etched Vial
        177843, -- Blank Card of Putrescence
        177842, -- Blank Card of Repose
        177841, -- Blank Card of Voracity
        177840, -- Blank Card of the Indomitable
        177061, -- Twilight Bark
        175970, -- Tranquil Ink
        175886, -- Dark Parchment
        175788, -- Tranquil Pigment
        173204, -- Lightless Silk
        173202, -- Shrouded Cloth
        173172, -- Essence of Servitude
        173170, -- Essence of Rebirth
        173126, -- Straddling Jewel Doublet
        173110, -- Umbryl
        173060, -- Aerated Water
        173059, -- Luminous Ink
        173058, -- Umbral Ink
        173057, -- Luminous Pigment
        173056, -- Umbral Pigment
        172230, -- Soul Dust
        172092, -- Pallid Bone
        171832, -- Sinvyr Ore
        171829, -- Solenium Ore
        171828, -- Laestrite Ore
        170554, -- Vigil's Torch
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:8;0:1:0
    [8] = { -- Battle for Azeroth
        171315, -- Nightshade
        169701, -- Death Blossom
        168663, -- Maroon Ink
        168662, -- Maroon Pigment
        168589, -- Marrowroot
        168586, -- Rising Glory
        168583, -- Widowbloom
        168487, -- Zin'anthid
        168142, -- Coagulated Miasma
        165948, -- Tidalcore
        165703, -- Breath of Bwonsamdi
        162460, -- Hydrocore
        160712, -- Powdered Sugar
        160711, -- Aromatic Fish Oil
        160398, -- Choral Honey
        158205, -- Acacia Powder
        158189, -- Viridescent Ink
        158188, -- Crimson Ink
        158187, -- Ultramarine Ink
        158186, -- Distilled Water
        153669, -- Viridescent Pigment
        153636, -- Crimson Pigment
        153635, -- Ultramarine Pigment
        152668, -- Expulsom
        152576, -- Tidespray Linen
        152512, -- Monelite Ore
        152511, -- Sea Stalk
        152510, -- Anchor Weed
        152509, -- Siren's Pollen
        152508, -- Winter's Kiss
        152507, -- Akunda's Bite
        152506, -- Star Moss
        152505, -- Riverbud
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:7;0:1:0
    [7] = { -- Legion
        151565, -- Astral Glory
        129100, -- Gem Chip
        129034, -- Sallow Pigment
        129032, -- Roseate Pigment
        128304, -- Yseralline Seed
        127004, -- Imbued Silkweave
        124461, -- Demonsteel Bar
        124437, -- Shal'dorei Silk
        124124, -- Blood of Sargeras
        124106, -- Felwort
        124105, -- Starlight Rose
        124104, -- Fjarnskaggl
        124103, -- Foxflower
        124102, -- Dreamleaf
        124101, -- Aethril
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:6;0:1:0
    [6] = { -- Warlords of Draenor
        127759, -- Felblight
        120945, -- Primal Spirit
        118472, -- Savage Blood
        114931, -- Cerulean Pigment
        113509, -- Conjured Mana Bun
        113263, -- Sorcerous Earth
        113261, -- Sorcerous Fire
        113111, -- Warbinder's Ink
        112377, -- War Paints
        111557, -- Sumptuous Fur
        109129, -- Talador Orchid
        109128, -- Nagrand Arrowbloom
        109127, -- Starflower
        109126, -- Gorgrond Flytrap
        109125, -- Fireweed
        109124, -- Frostweed
        109119, -- True Iron Ore
        109118, -- Blackrock Ore
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:5;0:1:0
    [5] = { -- Mists of Pandaria
        87872, -- Desecrated Oil
        82441, -- Bolt of Windwool Cloth
        79731, -- Scroll of Wisdom
        79255, -- Starlight Ink
        79254, -- Ink of Dreams
        79253, -- Misty Pigment
        79251, -- Shadow Pigment
        76061, -- Spirit of Harmony
        72237, -- Rain Poppy
        72104, -- Living Steel
        72096, -- Ghost Iron Bar
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:4;0:1:0
    [4] = { -- Cataclysm
        67335, -- Silver Charm Bracelet
        67319, -- Preserved Ogre Eye
        62323, -- Deathwing Scale Fragment
        61981, -- Inferno Ink
        61980, -- Burning Embers
        61979, -- Ashen Pigment
        61978, -- Blackfallow Ink
        56850, -- Deepstone Oil
        55053, -- Obsidium Skeleton Key
        54849, -- Obsidium Bar
        52329, -- Volatile Life
        52328, -- Volatile Air
        52327, -- Volatile Earth
        52326, -- Volatile Water
        52325, -- Volatile Fire
        52186, -- Elementium Bar
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:3;0:1:0
    [3] = { -- Wrath of the Lich King
        43127, -- Snowfall Ink
        43126, -- Ink of the Sea
        43125, -- Darkflame Ink
        43124, -- Ethereal Ink
        43123, -- Ink of the Sky
        43122, -- Shimmering Ink
        43121, -- Fiery Ink
        43120, -- Celestial Ink
        43119, -- Royal Ink
        43118, -- Jadefire Ink
        43117, -- Dawnstar Ink
        43116, -- Lion's Ink
        43115, -- Hunter's Ink
        43109, -- Icy Pigment
        43108, -- Ebon Pigment
        43107, -- Sapphire Pigment
        43106, -- Ruby Pigment
        43105, -- Indigo Pigment
        43104, -- Burnt Pigment
        43103, -- Verdant Pigment
        43102, -- Frozen Orb
        41163, -- Titanium Bar
        39774, -- Midnight Ink
        39469, -- Moonglow Ink
        39354, -- Light Parchment
        39343, -- Azure Pigment
        39342, -- Nether Pigment
        39341, -- Silvery Pigment
        39340, -- Violet Pigment
        39339, -- Emerald Pigment
        39338, -- Golden Pigment
        39334, -- Dusky Pigment
        39151, -- Alabaster Pigment
        37663, -- Titansteel Bar
        36931, -- Ametrine
        36916, -- Cobalt Bar
        35627, -- Eternal Shadow
        35625, -- Eternal Life
        33458, -- Scroll of Intellect VI
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:2;0:1:0
    [2] = { -- Burning Crusade
        23793, -- Heavy Knothide Leather
        23449, -- Khorium Bar
        22457, -- Primal Mana
        22452, -- Primal Earth
        22446, -- Greater Planar Essence
        21886, -- Primal Life
        20963, -- Mithril Filigree
    },
    -- https://www.wowhead.com/items?filter=87:194:166;15:1:1;0:1:0
    [1] = { -- Vanilla
        22682, -- Frozen Rune
        20520, -- Dark Rune
        20002, -- Greater Dreamless Sleep Potion
        19943, -- Massive Mojo
        19931, -- Gurubashi Mojo Madness
        19767, -- Primal Bat Leather
        18335, -- Pristine Black Diamond
        14344, -- Large Brilliant Shard
        13512, -- Flask of Supreme Power
        12811, -- Righteous Orb
        12810, -- Enchanted Leather
        12808, -- Essence of Undeath
        12804, -- Powerful Mojo
        12800, -- Azerothian Diamond
        12799, -- Large Opal
        12365, -- Dense Stone
        12364, -- Huge Emerald
        12361, -- Blue Sapphire
        12360, -- Arcanite Bar
        12359, -- Thorium Bar
        10308, -- Scroll of Intellect IV
        7076, -- Essence of Earth
        6037, -- Truesilver Bar
        4470, -- Simple Wood
        3577, -- Gold Bar
        3371, -- Crystal Vial
        2841, -- Bronze Bar
    },
}

-- Now, trading goods
items.Elemental = {
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;12;0
    [12] = { -- Midnight
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;11;0
    [11] = { -- The War Within
        231757, -- Fractured Spark of Starlight
        230905, -- Fractured Spark of Fortunes
        211297, -- Fractured Spark of Omens
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;10;0
    [10] = { -- Dragonflight
        211515, -- Splintered Spark of Awakening
        208396, -- Splintered Spark of Dreams
        205259, -- Order Soul
        204717, -- Splintered Spark of Shadowflame
        194729, -- Fiery Spirit
        194728, -- Fiery Spirit
        194727, -- Fiery Spirit
        193921, -- Airy Soul
        193920, -- Earthen Soul
        193919, -- Frosty Soul
        193379, -- Elemental Harmony
        193378, -- Elemental Harmony
        193362, -- Fiery Soul
        192887, -- Elemental Harmony
        191784, -- Dragon Shard of Knowledge
        190451, -- Rousing Ire
        190450, -- Awakened Ire
        190331, -- Awakened Decay
        190330, -- Rousing Decay
        190329, -- Awakened Frost
        190328, -- Rousing Frost
        190327, -- Awakened Air
        190326, -- Rousing Air
        190324, -- Awakened Order
        190322, -- Rousing Order
        190321, -- Awakened Fire
        190320, -- Rousing Fire
        190319, -- Resourceful!
        190318, -- Perception!
        190316, -- Awakened Earth
        190315, -- Rousing Earth
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;9;0
    [9] = { -- Shadowlands
        187707, -- Progenitor Essentia
        186017, -- Korthite Crystal
        178787, -- Orboreal Shard
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;8;0
    [8] = { -- Battle for Azeroth
        174097, -- [DNT] Corruptium
        165948, -- Tidalcore
        165703, -- Breath of Bwonsamdi
        163203, -- Hypersensitive Azeritometer Sensor
        162461, -- Sanguicell
        162460, -- Hydrocore
        152668, -- Expulsom
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;7;0
    [7] = { -- Legion
        151568, -- Primal Sargerite
        141323, -- Wild Transmutation
        124124, -- Blood of Sargeras
        124123, -- Demonfire
        124122, -- Leyfire
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;6;0
    [6] = { -- Warlords of Draenor
        120945, -- Primal Spirit
        113264, -- Sorcerous Air
        113263, -- Sorcerous Earth
        113262, -- Sorcerous Water
        113261, -- Sorcerous Fire
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;5;0
    [5] = { -- Mists of Pandaria
        89112, -- Mote of Harmony
        76061, -- Spirit of Harmony
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;4;0
    [4] = { -- Cataclysm
        54464, -- Random Volatile Element
        52329, -- Volatile Life
        52328, -- Volatile Air
        52327, -- Volatile Earth
        52326, -- Volatile Water
        52325, -- Volatile Fire
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;3;0
    [3] = { -- Wrath of the Lich King
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
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;2;0
    [2] = { -- Burning Crusade
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
    },
    -- https://www.wowhead.com/items/trade-goods/elemental?filter=166;1;0
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
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:12;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:12:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:12;0:1:0:0
    [12] = { -- Midnight
        274781, -- Cursebound Globe
        237366, -- Dazzling Thorium
        237365, -- Brilliant Silver Ore
        237364, -- Brilliant Silver Ore
        237363, -- Umbral Tin Ore
        237362, -- Umbral Tin Ore
        237361, -- Refulgent Copper Ore
        237359, -- Refulgent Copper Ore
        236952, -- Mote of Pure Void
        236951, -- Mote of Wild Magic
        236950, -- Mote of Primal Energy
        236949, -- Mote of Light
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:11;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:11:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:11;0:1:0:0
    [11] = { -- The War Within
        240216, -- K'areshi Resonating Stone
        238213, -- Desolate Talus
        238212, -- Desolate Talus
        238201, -- Desolate Talus
        224828, -- Weavercloth
        219150, -- Pile of Rusted Scrap
        217707, -- Imperfect Null Stone
        213611, -- Writhing Sample
        213610, -- Crystalline Powder
        210939, -- Null Stone
        210938, -- Ironclaw Ore
        210937, -- Ironclaw Ore
        210936, -- Ironclaw Ore
        210935, -- Aqirite
        210934, -- Aqirite
        210933, -- Aqirite
        210932, -- Bismuth
        210931, -- Bismuth
        210930, -- Bismuth
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:10;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:10:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:10;0:1:0:0
    [10] = { -- Dragonflight
        204460, -- Zaralek Glowspores
        197754, -- Salt Deposit
        194727, -- Fiery Spirit
        192871, -- Illimited Diamond
        192870, -- Illimited Diamond
        192869, -- Illimited Diamond
        192868, -- Nozdorite
        192867, -- Nozdorite
        192866, -- Nozdorite
        192865, -- Neltharite
        192863, -- Neltharite
        192862, -- Neltharite
        192861, -- Ysemerald
        192860, -- Ysemerald
        192859, -- Ysemerald
        192858, -- Malygite
        192857, -- Malygite
        192856, -- Malygite
        192855, -- Alexstraszite
        192853, -- Alexstraszite
        192852, -- Alexstraszite
        192851, -- Eternity Amber
        192850, -- Eternity Amber
        192849, -- Eternity Amber
        192848, -- Sundered Onyx
        192847, -- Sundered Onyx
        192846, -- Sundered Onyx
        192845, -- Vibrant Emerald
        192844, -- Vibrant Emerald
        192843, -- Vibrant Emerald
        192842, -- Mystic Sapphire
        192841, -- Mystic Sapphire
        192840, -- Mystic Sapphire
        192839, -- Queen's Ruby
        192838, -- Queen's Ruby
        192837, -- Queen's Ruby
        190451, -- Rousing Ire
        190396, -- Serevite Ore
        190395, -- Serevite Ore
        190394, -- Serevite Ore
        190328, -- Rousing Frost
        190326, -- Rousing Air
        190322, -- Rousing Order
        190320, -- Rousing Fire
        190315, -- Rousing Earth
        190314, -- Khaz'gorite Ore
        190313, -- Khaz'gorite Ore
        190312, -- Khaz'gorite Ore
        190311, -- Draconium Ore
        189143, -- Draconium Ore
        188658, -- Draconium Ore
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:9;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:9:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:9;0:1:0:0
    [9] = { -- Shadowlands
        187707, -- Progenitor Essentia
        187700, -- Progenium Ore
        177061, -- Twilight Bark
        171841, -- Shaded Stone
        171840, -- Porous Stone
        171833, -- Elethium Ore
        171832, -- Sinvyr Ore
        171831, -- Phaedrum Ore
        171830, -- Oxxein Ore
        171829, -- Solenium Ore
        171828, -- Laestrite Ore
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:8;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:8:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:8;0:1:0:0
    [8] = { -- Battle for Azeroth
        168185, -- Osmenite Ore
        163630, -- Ductile Platinum
        163629, -- Dense Storm Silver
        163628, -- Hardened Monelite
        163627, -- Smooth Platinum
        163626, -- Coarse Storm Silver
        163625, -- Rough Monelite
        163624, -- Burnished Platinum
        163623, -- Gleaming Storm Silver
        163609, -- Luminous Monelite
        152579, -- Storm Silver Ore
        152513, -- Platinum Ore
        152512, -- Monelite Ore
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:7;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:7:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:7;0:1:0:0
    [7] = { -- Legion
        156930, -- Rich Illusion Dust
        151720, -- Chemirine
        151719, -- Lightsphene
        151568, -- Primal Sargerite
        151564, -- Empyrium
        124444, -- Infernal Brimstone
        124124, -- Blood of Sargeras
        123919, -- Felslate
        123918, -- Leystone Ore
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:6;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:6:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:6;0:1:0:0
    [6] = { -- Warlords of Draenor
        127759, -- Felblight
        120945, -- Primal Spirit
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
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:5;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:5:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:5;0:1:0:0
    [5] = { -- Mists of Pandaria
        97546, -- Kyparite Fragment
        97512, -- Ghost Iron Nugget
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
        76131, -- Primordial Ruby
        76130, -- Tiger Opal
        72103, -- White Trillium Ore
        72096, -- Ghost Iron Bar
        72095, -- Trillium Bar
        72094, -- Black Trillium Ore
        72093, -- Kyparite
        72092, -- Ghost Iron Ore
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:4;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:4:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:4;0:1:0:0
    [4] = { -- Cataclysm
        54849, -- Obsidium Bar
        53039, -- Hardened Elementium Bar
        53038, -- Obsidium Ore
        52328, -- Volatile Air
        52327, -- Volatile Earth
        52326, -- Volatile Water
        52325, -- Volatile Fire
        52195, -- Amberjewel
        52194, -- Demonseye
        52193, -- Ember Topaz
        52192, -- Dream Emerald
        52191, -- Ocean Sapphire
        52190, -- Inferno Ruby
        52186, -- Elementium Bar
        52185, -- Elementium Ore
        52183, -- Pyrite Ore
        52182, -- Jasper
        52181, -- Hessonite
        52180, -- Nightstone
        52179, -- Alicite
        52178, -- Zephyrite
        52177, -- Carnelian
        51950, -- Pyrium Bar
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:3;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:3:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:3;0:1:0:0
    [3] = { -- Wrath of the Lich King
        41163, -- Titanium Bar
        37705, -- Crystallized Water
        37703, -- Crystallized Shadow
        37702, -- Crystallized Fire
        37701, -- Crystallized Earth
        37700, -- Crystallized Air
        37663, -- Titansteel Bar
        36933, -- Forest Emerald
        36932, -- Dark Jade
        36930, -- Monarch Topaz
        36929, -- Huge Citrine
        36927, -- Twilight Opal
        36926, -- Shadow Crystal
        36924, -- Sky Sapphire
        36923, -- Chalcedony
        36921, -- Autumn's Glow
        36920, -- Sun Crystal
        36918, -- Scarlet Ruby
        36917, -- Bloodstone
        36916, -- Cobalt Bar
        36913, -- Saronite Bar
        36912, -- Saronite Ore
        36910, -- Titanium Ore
        36909, -- Cobalt Ore
        36860, -- Eternal Fire
        35627, -- Eternal Shadow
        35624, -- Eternal Earth
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:2;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:2:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:2;0:1:0:0
    [2] = { -- Burning Crusade
        35128, -- Hardened Khorium
        32249, -- Seaspray Emerald
        32231, -- Pyrestone
        32230, -- Shadowsong Amethyst
        32229, -- Lionseye
        32228, -- Empyrean Sapphire
        32227, -- Crimson Spinel
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
        22574, -- Mote of Fire
        22573, -- Mote of Earth
        22452, -- Primal Earth
        21929, -- Flame Spessarite
        21884, -- Primal Fire
    },
    -- https://www.wowhead.com/items?filter=86:194:166;9:1:1;0:1:0
    -- https://www.wowhead.com/items?filter=87:166:194;9:1:1;0:0:1
    -- https://www.wowhead.com/items?filter=73:194:217:166;1:1:1:1;0:1:0:0
    [1] = { -- Vanilla
        22203, -- Large Obsidian Shard
        22202, -- Small Obsidian Shard
        18567, -- Elemental Flux
        18562, -- Elementium Ingot
        17771, -- Enchanted Elementium Bar
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
        11754, -- Black Diamond
        11382, -- Blood of the Mountain
        11371, -- Dark Iron Bar
        11370, -- Dark Iron Ore
        10620, -- Thorium Ore
        9262, -- Black Vitriol
        8150, -- Deeprock Salt
        7912, -- Solid Stone
        7911, -- Truesilver Ore
        7910, -- Star Ruby
        7909, -- Aquamarine
        7076, -- Essence of Earth
        6037, -- Truesilver Bar
        5469, -- Strider Meat
        5466, -- Scorpid Stinger
        3864, -- Citrine
        3860, -- Mithril Bar
        3859, -- Steel Bar
        3858, -- Mithril Ore
        3857, -- Coal
        3577, -- Gold Bar
        3576, -- Tin Bar
        3575, -- Iron Bar
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
        1705, -- Lesser Moonstone
        1529, -- Jade
        1468, -- Murloc Fin
        1210, -- Shadowgem
        1206, -- Moss Agate
        818, -- Tigerseye
        774, -- Malachite
    },
}
-- For Herbalism, below collected only those gathered via the profession
items.Herbalism = {
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:12;0:1:0:0
    [12] = { -- Midnight
        274781, -- Cursebound Globe
        242640, -- Plant Protein
        236952, -- Mote of Pure Void
        236951, -- Mote of Wild Magic
        236950, -- Mote of Primal Energy
        236949, -- Mote of Light
        236780, -- Nocturnal Lotus
        236779, -- Mana Lily
        236778, -- Mana Lily
        236777, -- Argentleaf
        236776, -- Argentleaf
        236775, -- Azeroot
        236774, -- Azeroot
        236771, -- Sanguithorn
        236770, -- Sanguithorn
        236767, -- Tranquility Bloom
        236761, -- Tranquility Bloom
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:11;0:1:0:0
    [11] = { -- The War Within
        240194, -- K'areshi Lotus
        239692, -- Phantom Bloom
        239691, -- Phantom Bloom
        239690, -- Phantom Bloom
        213613, -- Leyline Residue
        213612, -- Viridescent Spores
        213611, -- Writhing Sample
        213610, -- Crystalline Powder
        213197, -- Null Lotus
        210810, -- Arathor's Spear
        210809, -- Arathor's Spear
        210808, -- Arathor's Spear
        210807, -- Blessing Blossom
        210806, -- Blessing Blossom
        210805, -- Blessing Blossom
        210804, -- Orbinid
        210803, -- Orbinid
        210802, -- Orbinid
        210801, -- Luredrop
        210800, -- Luredrop
        210799, -- Luredrop
        210798, -- Mycobloom
        210797, -- Mycobloom
        210796, -- Mycobloom
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:10;0:1:0:0
    [10] = { -- Dragonflight
        204460, -- Zaralek Glowspores
        197755, -- Lava Beetle
        191472, -- Writhebark
        191471, -- Writhebark
        191470, -- Writhebark
        191469, -- Bubble Poppy
        191468, -- Bubble Poppy
        191467, -- Bubble Poppy
        191466, -- Saxifrage
        191465, -- Saxifrage
        191464, -- Saxifrage
        191462, -- Hochenblume
        191461, -- Hochenblume
        191460, -- Hochenblume
        190451, -- Rousing Ire
        190330, -- Rousing Decay
        190328, -- Rousing Frost
        190326, -- Rousing Air
        190322, -- Rousing Order
        190315, -- Rousing Earth
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:9;0:1:0:0
    [9] = { -- Shadowlands
        187707, -- Progenitor Essentia
        187699, -- First Flower
        170554, -- Vigil's Torch
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:8;0:1:0:0
    [8] = { -- Battle for Azeroth
        171315, -- Nightshade
        169701, -- Death Blossom
        169697, -- Nightshade Petal
        168589, -- Marrowroot
        168586, -- Rising Glory
        168583, -- Widowbloom
        168487, -- Zin'anthid
        163601, -- Overgrown Anchor Weed
        163595, -- Flourishing Riverbud
        163588, -- Flourishing Sea Stalk
        152511, -- Sea Stalk
        152510, -- Anchor Weed
        152509, -- Siren's Pollen
        152508, -- Winter's Kiss
        152507, -- Akunda's Bite
        152506, -- Star Moss
        152505, -- Riverbud
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:7;0:1:0:0
    [7] = { -- Legion
        151568, -- Primal Sargerite
        151565, -- Astral Glory
        135500, -- Singed Fjarnskaggl
        129289, -- Felwort Seed
        129288, -- Starlight Rose Seed
        129287, -- Fjarnskaggl Seed
        129286, -- Foxflower Seed
        129285, -- Dreamleaf Seed
        129284, -- Aethril Seed
        128304, -- Yseralline Seed
        124124, -- Blood of Sargeras
        124106, -- Felwort
        124105, -- Starlight Rose
        124104, -- Fjarnskaggl
        124103, -- Foxflower
        124102, -- Dreamleaf
        124101, -- Aethril
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:6;0:1:0:0
    [6] = { -- Warlords of Draenor
        127759, -- Felblight
        120945, -- Primal Spirit
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
        108363, -- Heartblossom Petal
        108361, -- Stormvine Stalk
        108360, -- Cinderbloom Petal
        108359, -- Fire Leaf Bramble
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
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:5;0:1:0:0
    [5] = { -- Mists of Pandaria
        97624, -- Desecrated Herb Pod
        97623, -- Fool's Cap Spores
        97622, -- Snow Lily Petal
        97621, -- Silkweed Stem
        97620, -- Rain Poppy Petal
        97619, -- Torn Green Tea Leaf
        89639, -- Desecrated Herb
        79011, -- Fool's Cap
        79010, -- Snow Lily
        72238, -- Golden Lotus
        72237, -- Rain Poppy
        72235, -- Silkweed
        72234, -- Green Tea Leaf
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:4;0:1:0:0
    [4] = { -- Cataclysm
        52988, -- Whiptail
        52987, -- Twilight Jasmine
        52986, -- Heartblossom
        52985, -- Azshara's Veil
        52984, -- Stormvine
        52983, -- Cinderbloom
        52329, -- Volatile Life
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:3;0:1:0:0
    [3] = { -- Wrath of the Lich King
        39970, -- Fire Leaf
        37921, -- Deadnettle
        37704, -- Crystallized Life
        36908, -- Frost Lotus
        36907, -- Talandra's Rose
        36906, -- Icethorn
        36905, -- Lichbloom
        36904, -- Tiger Lily
        36903, -- Adder's Tongue
        36901, -- Goldclover
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:2;0:1:0:0
    [2] = { -- Burning Crusade
        22794, -- Fel Lotus
        22793, -- Mana Thistle
        22792, -- Nightmare Vine
        22791, -- Netherbloom
        22790, -- Ancient Lichen
        22789, -- Terocone
        22787, -- Ragveil
        22786, -- Dreaming Glory
        22785, -- Felweed
        22576, -- Mote of Mana
        22575, -- Mote of Life
    },
    -- https://www.wowhead.com/items?filter=70:194:217:166;1:1:1:1;0:1:0:0
    [1] = { -- Vanilla
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
        818, -- Tigerseye
        785, -- Mageroyal
        774, -- Malachite
        765, -- Silverleaf
    },
}

--[[ Although I have collected the potions via the profession, this list may not be exhaustive 
items.Potion = {
    -- https://www.wowhead.com/items/consumables/potions?filter=166;12;0
    [12] = { -- Midnight
        241286, -- Light's Preservation
        241287, -- Light's Preservation
        241288, -- Potion of Recklessness
        241289, -- Potion of Recklessness
        241292, -- Draught of Rampant Abandon
        241293, -- Draught of Rampant Abandon
        241294, -- Potion of Devoured Dreams
        241295, -- Potion of Devoured Dreams
        241296, -- Potion of Zealotry
        241297, -- Potion of Zealotry
        241298, -- Amani Extract
        241299, -- Amani Extract
        241300, -- Lightfused Mana Potion
        241301, -- Lightfused Mana Potion
        241302, -- Void-Shrouded Tincture
        241303, -- Void-Shrouded Tincture
        241304, -- Silvermoon Health Potion
        241305, -- Silvermoon Health Potion
        241306, -- Refreshing Serum
        241307, -- Refreshing Serum
        241308, -- Light's Potential
        241309, -- Light's Potential
        241338, -- Enlightenment Tonic
        241339, -- Enlightenment Tonic
        245897, -- Fleeting Light's Potential
        245898, -- Fleeting Light's Potential
        245900, -- Fleeting Potion of Zealotry
        245901, -- Fleeting Potion of Zealotry
        245902, -- Fleeting Potion of Recklessness
        245903, -- Fleeting Potion of Recklessness
        245904, -- Fleeting Potion of Devoured Dreams
        245905, -- Fleeting Potion of Devoured Dreams
        245910, -- Fleeting Draught of Rampant Abandon
        245911, -- Fleeting Draught of Rampant Abandon
        245916, -- Fleeting Lightfused Mana Potion
        245917, -- Fleeting Lightfused Mana Potion
        245918, -- Fleeting Silvermoon Health Potion
        245919, -- Fleeting Silvermoon Health Potion
        258138, -- Potent Healing Potion
        259092, -- Void-Tinged Free Action Potion
        259245, -- Void Phase Potion
        268954, -- Entropic Extract
        268955, -- Entropic Extract
        271883, -- Concentrated Silvermoon Health Potion
        271884, -- Concentrated Silvermoon Health Potion
        271886, -- Liquid Luster
        271887, -- Liquid Luster
        271889, -- Alluring Nostrum
        271890, -- Alluring Nostrum
        274763, -- Fleeting Liquid Luster
        274764, -- Fleeting Liquid Luster
        274765, -- Fleeting Alluring Nostrum
        274766, -- Fleeting Alluring Nostrum
        274774, -- Frost-Injected Vapor
        274775, -- Void Hungerer's Vapor
        274780, -- Fungal Spore Vapor
        274782, -- Tether-Severing Vapor
        274793, -- Mana Barrier Projector
        274794, -- Shockwave Amplifier
        278035, -- Ornate Healing Potion
        279550, -- Potion of Venomous Return
        280409, -- Potion of Liquid Undeath
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;11;0
    [11] = { -- The War Within
        211878, -- Algari Healing Potion
        211879, -- Algari Healing Potion
        211880, -- Algari Healing Potion
        212239, -- Algari Mana Potion
        212240, -- Algari Mana Potion
        212241, -- Algari Mana Potion
        212242, -- Cavedweller's Delight
        212243, -- Cavedweller's Delight
        212244, -- Cavedweller's Delight
        212245, -- Slumbering Soul Serum
        212246, -- Slumbering Soul Serum
        212247, -- Slumbering Soul Serum
        212248, -- Draught of Silent Footfalls
        212249, -- Draught of Silent Footfalls
        212250, -- Draught of Silent Footfalls
        212251, -- Draught of Shocking Revelations
        212252, -- Draught of Shocking Revelations
        212253, -- Draught of Shocking Revelations
        212254, -- Grotesque Vial
        212255, -- Grotesque Vial
        212256, -- Grotesque Vial
        212257, -- Potion of Unwavering Focus
        212258, -- Potion of Unwavering Focus
        212259, -- Potion of Unwavering Focus
        212260, -- Frontline Potion
        212261, -- Frontline Potion
        212262, -- Frontline Potion
        212263, -- Tempered Potion
        212264, -- Tempered Potion
        212265, -- Tempered Potion
        212266, -- Potion of the Reborn Cheetah
        212267, -- Potion of the Reborn Cheetah
        212268, -- Potion of the Reborn Cheetah
        212318, -- QA Algari Healing Potion
        212319, -- QA Algari Mana Potion
        212320, -- QA Cavedweller's Delight
        212321, -- QA Slumbering Soul Serum
        212322, -- QA Draught of Silent Footfalls
        212323, -- QA Draught of Shocking Revelations
        212324, -- QA Grotesque Vial
        212325, -- QA Potion of Unwavering Focus
        212326, -- QA Frontline Potion
        212327, -- QA Tempered Potion
        212328, -- QA Potion of the Reborn Cheetah
        212781, -- Formulated Courage
        212942, -- Fleeting Algari Healing Potion
        212943, -- Fleeting Algari Healing Potion
        212944, -- Fleeting Algari Healing Potion
        212945, -- Fleeting Algari Mana Potion
        212946, -- Fleeting Algari Mana Potion
        212947, -- Fleeting Algari Mana Potion
        212948, -- Fleeting Cavedweller's Delight
        212949, -- Fleeting Cavedweller's Delight
        212950, -- Fleeting Cavedweller's Delight
        212951, -- Fleeting Slumbering Soul Serum
        212952, -- Fleeting Slumbering Soul Serum
        212953, -- Fleeting Slumbering Soul Serum
        212954, -- Fleeting Draught of Silent Footfalls
        212955, -- Fleeting Draught of Silent Footfalls
        212956, -- Fleeting Draught of Silent Footfalls
        212957, -- Fleeting Draught of Shocking Revelations
        212958, -- Fleeting Draught of Shocking Revelations
        212959, -- Fleeting Draught of Shocking Revelations
        212960, -- Fleeting Grotesque Vial
        212961, -- Fleeting Grotesque Vial
        212962, -- Fleeting Grotesque Vial
        212963, -- Fleeting Potion of Unwavering Focus
        212964, -- Fleeting Potion of Unwavering Focus
        212965, -- Fleeting Potion of Unwavering Focus
        212966, -- Fleeting Frontline Potion
        212967, -- Fleeting Frontline Potion
        212968, -- Fleeting Frontline Potion
        212969, -- Fleeting Tempered Potion
        212970, -- Fleeting Tempered Potion
        212971, -- Fleeting Tempered Potion
        212972, -- Fleeting Potion of the Reborn Cheetah
        212973, -- Fleeting Potion of the Reborn Cheetah
        212974, -- Fleeting Potion of the Reborn Cheetah
        218107, -- Sparkbug Jar
        220756, -- Flickering Torch
        223287, -- Atomized Salien Slime
        224811, -- Sugar Shrooms
        224813, -- Big Cat Whistle
        224815, -- Charm of the Flame
        225770, -- Algari Anglerthread
        225771, -- Algari Seekerthread
        225784, -- Potion of Polymorphic Translation: Nerubian
        228756, -- Bonus Snuffling Experience
        228913, -- Dubious Vial of Vigor
        233205, -- Go-Go Juice
        236412, -- "Fireproof" Punch
        236413, -- "Shockproof" Soda
        238726, -- Drake Treat
        239142, -- Bottle of Mysterious Wisdom
        239247, -- Bonus Experience
        242371, -- Untethered Xy'bucha
        242529, -- Shadowtrade Imports
        243147, -- Ethereal Defense Pylon
        243219, -- Phased Ethereal Bow
        244835, -- Invigorating Healing Potion
        244838, -- Invigorating Healing Potion
        244839, -- Invigorating Healing Potion
        244849, -- Fleeting Invigorating Healing Potion
        248331, -- Umbral Essentia
        248585, -- Umbral Essentia
        248586, -- Umbral Essentia
        251562, -- Tome of Combat Training
        251631, -- Bottled Time
        253011, -- Brawler's Healing Brute Punch
        253014, -- Brawler's Fight Tonic of Strength
        253015, -- Brawler's Fight Tonic of Agility
        253016, -- Brawler's Fight Tonic of Intellect
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;10;0
    [10] = { -- Dragonflight
        191351, -- Potion of Frozen Fatality
        191352, -- Potion of Frozen Fatality
        191353, -- Potion of Frozen Fatality
        191360, -- Bottled Putrescence
        191361, -- Bottled Putrescence
        191362, -- Bottled Putrescence
        191363, -- Potion of Frozen Focus
        191364, -- Potion of Frozen Focus
        191365, -- Potion of Frozen Focus
        191366, -- Potion of Chilled Clarity
        191367, -- Potion of Chilled Clarity
        191368, -- Potion of Chilled Clarity
        191369, -- Potion of Withering Vitality
        191370, -- Potion of Withering Vitality
        191371, -- Potion of Withering Vitality
        191372, -- Residual Neural Channeling Agent
        191373, -- Residual Neural Channeling Agent
        191374, -- Residual Neural Channeling Agent
        191375, -- Delicate Suspension of Spores
        191376, -- Delicate Suspension of Spores
        191377, -- Delicate Suspension of Spores
        191378, -- Refreshing Healing Potion
        191379, -- Refreshing Healing Potion
        191380, -- Refreshing Healing Potion
        191381, -- Elemental Potion of Ultimate Power
        191382, -- Elemental Potion of Ultimate Power
        191383, -- Elemental Potion of Ultimate Power
        191384, -- Aerated Mana Potion
        191385, -- Aerated Mana Potion
        191386, -- Aerated Mana Potion
        191387, -- Elemental Potion of Power
        191388, -- Elemental Potion of Power
        191389, -- Elemental Potion of Power
        191393, -- Potion of the Hushed Zephyr
        191394, -- Potion of the Hushed Zephyr
        191395, -- Potion of the Hushed Zephyr
        191396, -- Potion of Gusts
        191397, -- Potion of Gusts
        191398, -- Potion of Gusts
        191399, -- Potion of Shocking Disclosure
        191400, -- Potion of Shocking Disclosure
        191401, -- Potion of Shocking Disclosure
        191905, -- Fleeting Elemental Potion of Power
        191906, -- Fleeting Elemental Potion of Power
        191907, -- Fleeting Elemental Potion of Power
        191912, -- Fleeting Elemental Potion of Ultimate Power
        191913, -- Fleeting Elemental Potion of Ultimate Power
        191914, -- Fleeting Elemental Potion of Ultimate Power
        194337, -- Liquid Courage
        200121, -- Potion of Beginner's Luck
        201427, -- Fleeting Sands
        201428, -- Quicksilver Sands
        201436, -- Temporally-Locked Sands
        201438, -- Weary Sands
        203657, -- Toxin Antidote
        204370, -- Stinky Bright Potion
        207021, -- Dreamwalker's Healing Potion
        207022, -- Dreamwalker's Healing Potion
        207023, -- Dreamwalker's Healing Potion
        207039, -- Potion of Withering Dreams
        207040, -- Potion of Withering Dreams
        207041, -- Potion of Withering Dreams
        210988, -- Thread of Regeneration
        217904, -- Timerunner's Draught of Power
        217905, -- Timerunner's Draught of Health
        217906, -- Drake Treat
        217925, -- Bottle of Bees
        217926, -- Bottle of Dead Bees
        219220, -- Catch Up Thread
        220763, -- Bonus Experience
        220764, -- Bonus Experience
        224021, -- Survivalist's Healing Potion
        224022, -- Survivalist's Mana Potion
        224407, -- Bonus Experience
        224408, -- Bonus Experience
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;9;0
    [9] = { -- Shadowland
        168207, -- Plundered Anima Cell
        170540, -- Ravenous Anima Cell
        171263, -- Potion of Soul Purity
        171264, -- Potion of Shaded Sight
        171265, -- REUSE ME
        171266, -- Potion of the Hidden Spirit
        171267, -- Spiritual Healing Potion
        171268, -- Spiritual Mana Potion
        171269, -- Spiritual Rejuvenation Potion
        171270, -- Potion of Spectral Agility
        171271, -- Potion of Hardened Shadows
        171272, -- Potion of Spiritual Clarity
        171273, -- Potion of Spectral Intellect
        171274, -- Potion of Spectral Stamina
        171275, -- Potion of Spectral Strength
        171349, -- Potion of Phantom Fire
        171350, -- Potion of Divine Awakening
        171351, -- Potion of Deathly Fixation
        171352, -- Potion of Empowered Exorcisms
        171370, -- Potion of Specter Swiftness
        174042, -- Pinch of Faerie Dust
        175241, -- Expedition Healing Potion
        176331, -- Obscuring Essence Potion
        176409, -- Rejuvenating Siphoned Essence
        176442, -- Ratwhisker Brew
        176443, -- Fleeting Frenzy Potion
        176811, -- Potion of Sacrificial Anima
        177278, -- Phial of Serenity
--        179000, -- [PH] Potency Conduit - Death Knight - Blood - Potency Trait 1
--        179027, -- [PH] Potency Conduit - Death Knight - Blood - Potency Trait 2
--        179028, -- [PH] Flex Conduit - Death Knight - Blood - Flex Trait 1
--        179029, -- [PH] Flex Conduit - Death Knight - Blood - Flex Trait 2
--        179030, -- [PH] Potency Conduit - Death Knight - All - Potency Trait - Covenant
--        179031, -- [PH] Endurance Conduit - Death Knight - All - Endurance Trait 1
--        179032, -- [PH] Endurance Conduit - Death Knight - All - Endurance Trait 2
--        179033, -- [PH] Endurance Conduit - Death Knight - All - Endurance Trait 3
--        179034, -- [PH] Finesse Conduit - Death Knight - All - Finesse Trait 1
--        179035, -- [PH] Finesse Conduit - Death Knight - All - Finesse Trait 2
--        179036, -- [PH] Finesse Conduit - Death Knight - All - Finesse Trait 3
--        179037, -- [PH] Finesse Conduit - Death Knight - All - Finesse Trait 4
--        179038, -- [PH] Potency Conduit - Death Knight - Frost - Potency Trait 1
--        179039, -- [PH] Potency Conduit - Death Knight - Frost - Potency Trait 2
--        179040, -- [PH] Flex Conduit - Death Knight - Frost - Flex Trait 1
--        179041, -- [PH] Flex Conduit - Death Knight - Frost - Flex Trait 2
--        179042, -- [PH] Potency Conduit - Death Knight - Unholy - Potency Trait 1
--        179043, -- [PH] Potency Conduit - Death Knight - Unholy - Potency Trait 2
--        179044, -- [PH] Flex Conduit - Death Knight - Unholy - Flex Trait 1
--        179045, -- [PH] Flex Conduit - Death Knight - Unholy - Flex Trait 2
--        179046, -- [PH] Potency Conduit - Demon Hunter - Vengeance - Potency Trait 1
--        179047, -- [PH] Potency Conduit - Demon Hunter - Vengeance - Potency Trait 2
--        179048, -- [PH] Flex Conduit - Demon Hunter - Vengeance - Flex Trait 1
--        179049, -- [PH] Flex Conduit - Demon Hunter - Vengeance - Flex Trait 2
--        179050, -- [PH] Potency Conduit - Demon Hunter - All - Potency Trait - Covenant
--        179051, -- [PH] Endurance Conduit - Demon Hunter - All - Endurance Trait 1
--        179052, -- [PH] Endurance Conduit - Demon Hunter - All - Endurance Trait 2
--        179053, -- [PH] Endurance Conduit - Demon Hunter - All - Endurance Trait 3
--        179054, -- [PH] Finesse Conduit - Demon Hunter - All - Finesse Trait 1
--        179055, -- [PH] Finesse Conduit - Demon Hunter - All - Finesse Trait 2
--        179056, -- [PH] Finesse Conduit - Demon Hunter - All - Finesse Trait 3
--        179057, -- [PH] Finesse Conduit - Demon Hunter - All - Finesse Trait 4
--        179058, -- [PH] Potency Conduit - Demon Hunter - Havoc - Potency Trait 1
--        179059, -- [PH] Potency Conduit - Demon Hunter - Havoc - Potency Trait 2
--        179060, -- [PH] Flex Conduit - Demon Hunter - Havoc - Flex Trait 1
--        179061, -- [PH] Flex Conduit - Demon Hunter - Havoc - Flex Trait 2
--        179062, -- [PH] Potency Conduit - Druid - Balance - Potency Trait 1
--        179063, -- [PH] Potency Conduit - Druid - Balance - Potency Trait 2
--        179064, -- [PH] Flex Conduit - Druid - Balance - Flex Trait 1
--        179065, -- [PH] Flex Conduit - Druid - Balance - Flex Trait 2
--        179066, -- [PH] Potency Conduit - Druid - All - Potency Trait - Covenant
--        179067, -- [PH] Endurance Conduit - Druid - All - Endurance Trait 1
--        179068, -- [PH] Endurance Conduit - Druid - All - Endurance Trait 2
--        179069, -- [PH] Endurance Conduit - Druid - All - Endurance Trait 3
--        179070, -- [PH] Finesse Conduit - Druid - All - Finesse Trait 1
--        179071, -- [PH] Finesse Conduit - Druid - All - Finesse Trait 2
--        179072, -- [PH] Finesse Conduit - Druid - All - Finesse Trait 3
--        179073, -- [PH] Finesse Conduit - Druid - All - Finesse Trait 4
--        179074, -- [PH] Potency Conduit - Druid - Feral - Potency Trait 1
--        179075, -- [PH] Potency Conduit - Druid - Feral - Potency Trait 2
--        179076, -- [PH] Flex Conduit - Druid - Feral - Flex Trait 1
--        179077, -- [PH] Flex Conduit - Druid - Feral - Flex Trait 2
--        179078, -- [PH] Potency Conduit - Druid - Guardian - Potency Trait 1
--        179079, -- [PH] Potency Conduit - Druid - Guardian - Potency Trait 2
--        179080, -- [PH] Flex Conduit - Druid - Guardian - Flex Trait 1
--        179081, -- [PH] Flex Conduit - Druid - Guardian - Flex Trait 2
--        179082, -- [PH] Potency Conduit - Druid - Restoration - Potency Trait 1
--        179083, -- [PH] Potency Conduit - Druid - Restoration - Potency Trait 2
--        179084, -- [PH] Flex Conduit - Druid - Restoration - Flex Trait 1
--        179085, -- [PH] Flex Conduit - Druid - Restoration - Flex Trait 2
--        179086, -- [PH] Potency Conduit - Hunter - Beast Mastery - Potency Trait 1
--        179087, -- [PH] Potency Conduit - Hunter - Beast Mastery - Potency Trait 2
--        179088, -- [PH] Flex Conduit - Hunter - Beast Mastery - Flex Trait 1
--        179089, -- [PH] Flex Conduit - Hunter - Beast Mastery - Flex Trait 2
--        179090, -- [PH] Potency Conduit - Hunter - All - Potency Trait - Covenant
--        179091, -- [PH] Endurance Conduit - Hunter - All - Endurance Trait 1
--        179092, -- [PH] Endurance Conduit - Hunter - All - Endurance Trait 2
--        179093, -- [PH] Endurance Conduit - Hunter - All - Endurance Trait 3
--        179094, -- [PH] Finesse Conduit - Hunter - All - Finesse Trait 1
--        179095, -- [PH] Finesse Conduit - Hunter - All - Finesse Trait 2
--        179096, -- [PH] Finesse Conduit - Hunter - All - Finesse Trait 3
--        179097, -- [PH] Finesse Conduit - Hunter - All - Finesse Trait 4
--        179098, -- [PH] Potency Conduit - Hunter - Marksmanship - Potency Trait 1
--        179099, -- [PH] Potency Conduit - Hunter - Marksmanship - Potency Trait 2
--        179100, -- [PH] Flex Conduit - Hunter - Marksmanship - Flex Trait 1
--        179101, -- [PH] Flex Conduit - Hunter - Marksmanship - Flex Trait 2
--        179102, -- [PH] Potency Conduit - Hunter - Survival - Potency Trait 1
--        179103, -- [PH] Potency Conduit - Hunter - Survival - Potency Trait 2
--        179104, -- [PH] Flex Conduit - Hunter - Survival - Flex Trait 1
--        179105, -- [PH] Flex Conduit - Hunter - Survival - Flex Trait 2
--        179106, -- [PH] Potency Conduit - Mage - Arcane - Potency Trait 1
--        179107, -- [PH] Potency Conduit - Mage - Arcane - Potency Trait 2
--        179108, -- [PH] Flex Conduit - Mage - Arcane - Flex Trait 1
--        179109, -- [PH] Flex Conduit - Mage - Arcane - Flex Trait 2
--        179110, -- [PH] Potency Conduit - Mage - All - Potency Trait - Covenant
--        179111, -- [PH] Endurance Conduit - Mage - All - Endurance Trait 1
--        179112, -- [PH] Endurance Conduit - Mage - All - Endurance Trait 2
--        179113, -- [PH] Endurance Conduit - Mage - All - Endurance Trait 3
--        179114, -- [PH] Finesse Conduit - Mage - All - Finesse Trait 1
--        179115, -- [PH] Finesse Conduit - Mage - All - Finesse Trait 2
--        179116, -- [PH] Finesse Conduit - Mage - All - Finesse Trait 3
--        179117, -- [PH] Finesse Conduit - Mage - All - Finesse Trait 4
--        179118, -- [PH] Potency Conduit - Mage - Fire - Potency Trait 1
--        179119, -- [PH] Potency Conduit - Mage - Fire - Potency Trait 2
--        179120, -- [PH] Flex Conduit - Mage - Fire - Flex Trait 1
--        179121, -- [PH] Flex Conduit - Mage - Fire - Flex Trait 2
--        179122, -- [PH] Potency Conduit - Mage - Frost - Potency Trait 1
--        179123, -- [PH] Potency Conduit - Mage - Frost - Potency Trait 2
--        179124, -- [PH] Flex Conduit - Mage - Frost - Flex Trait 1
--        179125, -- [PH] Flex Conduit - Mage - Frost - Flex Trait 2
--        179126, -- [PH] Potency Conduit - Monk - Brewmaster - Potency Trait 1
--        179127, -- [PH] Potency Conduit - Monk - Brewmaster - Potency Trait 2
--        179128, -- [PH] Flex Conduit - Monk - Brewmaster - Flex Trait 1
--        179129, -- [PH] Flex Conduit - Monk - Brewmaster - Flex Trait 2
--        179130, -- [PH] Potency Conduit - Monk - All - Potency Trait - Covenant
--        179131, -- [PH] Endurance Conduit - Monk - All - Endurance Trait 1
--        179132, -- [PH] Endurance Conduit - Monk - All - Endurance Trait 2
--        179133, -- [PH] Endurance Conduit - Monk - All - Endurance Trait 3
--        179134, -- [PH] Finesse Conduit - Monk - All - Finesse Trait 1
--        179135, -- [PH] Finesse Conduit - Monk - All - Finesse Trait 2
--        179136, -- [PH] Finesse Conduit - Monk - All - Finesse Trait 3
--        179137, -- [PH] Finesse Conduit - Monk - All - Finesse Trait 4
--        179138, -- [PH] Potency Conduit - Monk - Mistweaver - Potency Trait 1
--        179139, -- [PH] Potency Conduit - Monk - Mistweaver - Potency Trait 2
--        179140, -- [PH] Flex Conduit - Monk - Mistweaver - Flex Trait 1
--        179141, -- [PH] Flex Conduit - Monk - Mistweaver - Flex Trait 2
--        179142, -- [PH] Potency Conduit - Monk - Windwalker - Potency Trait 1
--        179143, -- [PH] Potency Conduit - Monk - Windwalker - Potency Trait 2
--        179144, -- [PH] Flex Conduit - Monk - Windwalker - Flex Trait 1
--        179145, -- [PH] Flex Conduit - Monk - Windwalker - Flex Trait 2
--        179146, -- [PH] Potency Conduit - Paladin - Holy - Potency Trait 1
--        179147, -- [PH] Potency Conduit - Paladin - Holy - Potency Trait 2
--        179148, -- [PH] Flex Conduit - Paladin - Holy - Flex Trait 1
--        179149, -- [PH] Flex Conduit - Paladin - Holy - Flex Trait 2
--        179150, -- [PH] Potency Conduit - Paladin - All - Potency Trait - Covenant
--        179151, -- [PH] Endurance Conduit - Paladin - All - Endurance Trait 1
--        179152, -- [PH] Endurance Conduit - Paladin - All - Endurance Trait 2
--        179153, -- [PH] Endurance Conduit - Paladin - All - Endurance Trait 3
--        179154, -- [PH] Finesse Conduit - Paladin - All - Finesse Trait 1
--        179155, -- [PH] Finesse Conduit - Paladin - All - Finesse Trait 2
--        179156, -- [PH] Finesse Conduit - Paladin - All - Finesse Trait 3
--        179157, -- [PH] Finesse Conduit - Paladin - All - Finesse Trait 4
--        179158, -- [PH] Potency Conduit - Paladin - Protection - Potency Trait 1
--        179159, -- [PH] Potency Conduit - Paladin - Protection - Potency Trait 2
--        179160, -- [PH] Flex Conduit - Paladin - Protection - Flex Trait 1
--        179161, -- [PH] Flex Conduit - Paladin - Protection - Flex Trait 2
--        179162, -- [PH] Potency Conduit - Paladin - Retribution - Potency Trait 1
--        179163, -- [PH] Potency Conduit - Paladin - Retribution - Potency Trait 2
--        179164, -- [PH] Flex Conduit - Paladin - Retribution - Flex Trait 1
--        179165, -- [PH] Flex Conduit - Paladin - Retribution - Flex Trait 2
--        179167, -- [PH] Potency Conduit - Priest - Discipline - Potency Trait 1
--        179168, -- [PH] Potency Conduit - Priest - Discipline - Potency Trait 2
--        179169, -- [PH] Flex Conduit - Priest - Discipline - Flex Trait 1
--        179170, -- [PH] Flex Conduit - Priest - Discipline - Flex Trait 2
--        179171, -- [PH] Potency Conduit - Priest - All - Potency Trait - Covenant
--        179172, -- [PH] Endurance Conduit - Priest - All - Endurance Trait 1
--        179173, -- [PH] Endurance Conduit - Priest - All - Endurance Trait 2
--        179174, -- [PH] Endurance Conduit - Priest - All - Endurance Trait 3
--        179175, -- [PH] Finesse Conduit - Priest - All - Finesse Trait 1
--        179176, -- [PH] Finesse Conduit - Priest - All - Finesse Trait 2
--        179177, -- [PH] Finesse Conduit - Priest - All - Finesse Trait 3
--        179178, -- [PH] Finesse Conduit - Priest - All - Finesse Trait 4
--        179179, -- [PH] Potency Conduit - Priest - Holy - Potency Trait 1
--        179180, -- [PH] Potency Conduit - Priest - Holy - Potency Trait 2
--        179181, -- [PH] Flex Conduit - Priest - Holy - Flex Trait 1
--        179182, -- [PH] Flex Conduit - Priest - Holy - Flex Trait 2
--        179183, -- [PH] Potency Conduit - Priest - Shadow - Potency Trait 1
--        179184, -- [PH] Potency Conduit - Priest - Shadow - Potency Trait 2
--        179185, -- [PH] Flex Conduit - Priest - Shadow - Flex Trait 1
--        179186, -- [PH] Flex Conduit - Priest - Shadow - Flex Trait 2
--        179187, -- [PH] Potency Conduit - Rogue - Assassination - Potency Trait 1
--        179188, -- [PH] Potency Conduit - Rogue - Assassination - Potency Trait 2
--        179189, -- [PH] Flex Conduit - Rogue - Assassination - Flex Trait 1
--        179190, -- [PH] Flex Conduit - Rogue - Assassination - Flex Trait 2
--        179191, -- [PH] Potency Conduit - Rogue - All - Potency Trait - Covenant
--        179192, -- [PH] Endurance Conduit - Rogue - All - Endurance Trait 1
--        179193, -- [PH] Endurance Conduit - Rogue - All - Endurance Trait 2
--        179194, -- [PH] Endurance Conduit - Rogue - All - Endurance Trait 3
--        179195, -- [PH] Finesse Conduit - Rogue - All - Finesse Trait 1
--        179196, -- [PH] Finesse Conduit - Rogue - All - Finesse Trait 2
--        179197, -- [PH] Finesse Conduit - Rogue - All - Finesse Trait 3
--        179198, -- [PH] Finesse Conduit - Rogue - All - Finesse Trait 4
--        179199, -- [PH] Potency Conduit - Rogue - Outlaw - Potency Trait 1
--        179200, -- [PH] Potency Conduit - Rogue - Outlaw - Potency Trait 2
--        179202, -- [PH] Flex Conduit - Rogue - Outlaw - Flex Trait 2
--        179203, -- [PH] Potency Conduit - Rogue - Subtlety - Potency Trait 1
--        179204, -- [PH] Potency Conduit - Rogue - Subtlety - Potency Trait 2
--        179205, -- [PH] Flex Conduit - Rogue - Subtlety - Flex Trait 1
--        179206, -- [PH] Flex Conduit - Rogue - Subtlety - Flex Trait 2
--        179207, -- [PH] Potency Conduit - Shaman - Elemental - Potency Trait 1
--        179208, -- [PH] Potency Conduit - Shaman - Elemental - Potency Trait 2
--        179209, -- [PH] Flex Conduit - Shaman - Elemental - Flex Trait 1
--        179210, -- [PH] Flex Conduit - Shaman - Elemental - Flex Trait 2
--        179211, -- [PH] Potency Conduit - Shaman - All - Potency Trait - Covenant
--        179212, -- [PH] Endurance Conduit - Shaman - All - Endurance Trait 1
--        179213, -- [PH] Endurance Conduit - Shaman - All - Endurance Trait 2
--        179214, -- [PH] Endurance Conduit - Shaman - All - Endurance Trait 3
--        179215, -- [PH] Finesse Conduit - Shaman - All - Finesse Trait 1
--        179216, -- [PH] Finesse Conduit - Shaman - All - Finesse Trait 2
--        179217, -- [PH] Finesse Conduit - Shaman - All - Finesse Trait 3
--        179218, -- [PH] Finesse Conduit - Shaman - All - Finesse Trait 4
--        179219, -- [PH] Potency Conduit - Shaman - Enhancement - Potency Trait 1
--        179220, -- [PH] Potency Conduit - Shaman - Enhancement - Potency Trait 2
--        179221, -- [PH] Flex Conduit - Shaman - Enhancement - Flex Trait 1
--        179222, -- [PH] Flex Conduit - Shaman - Enhancement - Flex Trait 2
--        179223, -- [PH] Potency Conduit - Shaman - Restoration - Potency Trait 1
--        179224, -- [PH] Potency Conduit - Shaman - Restoration - Potency Trait 2
--        179225, -- [PH] Flex Conduit - Shaman - Restoration - Flex Trait 1
--        179226, -- [PH] Flex Conduit - Shaman - Restoration - Flex Trait 2
--        179227, -- [PH] Potency Conduit - Warrior - Arms - Potency Trait 1
--        179228, -- [PH] Potency Conduit - Warrior - Arms - Potency Trait 2
--        179229, -- [PH] Flex Conduit - Warrior - Arms - Flex Trait 1
--        179230, -- [PH] Flex Conduit - Warrior - Arms - Flex Trait 2
--        179231, -- [PH] Potency Conduit - Warrior - All - Potency Trait - Covenant
--        179232, -- [PH] Endurance Conduit - Warrior - All - Endurance Trait 1
--        179233, -- [PH] Endurance Conduit - Warrior - All - Endurance Trait 2
--        179234, -- [PH] Endurance Conduit - Warrior - All - Endurance Trait 3
--        179235, -- [PH] Finesse Conduit - Warrior - All - Finesse Trait 1
--        179236, -- [PH] Finesse Conduit - Warrior - All - Finesse Trait 2
--        179237, -- [PH] Finesse Conduit - Warrior - All - Finesse Trait 3
--        179238, -- [PH] Finesse Conduit - Warrior - All - Finesse Trait 4
--        179239, -- [PH] Potency Conduit - Warrior - Fury - Potency Trait 1
--        179240, -- [PH] Potency Conduit - Warrior - Fury - Potency Trait 2
--        179241, -- [PH] Flex Conduit - Warrior - Fury - Flex Trait 1
--        179242, -- [PH] Flex Conduit - Warrior - Fury - Flex Trait 2
--        179243, -- [PH] Potency Conduit - Warrior - Protection - Potency Trait 1
--        179244, -- [PH] Potency Conduit - Warrior - Protection - Potency Trait 2
--        179245, -- [PH] Flex Conduit - Warrior - Protection - Flex Trait 1
--        179246, -- [PH] Flex Conduit - Warrior - Protection - Flex Trait 2
--        179247, -- [PH] Potency Conduit - Warlock - Affliction - Potency Trait 1
--        179248, -- [PH] Potency Conduit - Warlock - Affliction - Potency Trait 2
--        179249, -- [PH] Flex Conduit - Warlock - Affliction - Flex Trait 1
--        179250, -- [PH] Flex Conduit - Warlock - Affliction - Flex Trait 2
--        179251, -- [PH] Potency Conduit - Warlock - All - Potency Trait - Covenant
--        179252, -- [PH] Endurance Conduit - Warlock - All - Endurance Trait 1
--        179253, -- [PH] Endurance Conduit - Warlock - All - Endurance Trait 2
--        179254, -- [PH] Endurance Conduit - Warlock - All - Endurance Trait 3
--        179255, -- [PH] Finesse Conduit - Warlock - All - Finesse Trait 1
--        179256, -- [PH] Finesse Conduit - Warlock - All - Finesse Trait 2
--        179257, -- [PH] Finesse Conduit - Warlock - All - Finesse Trait 3
--        179258, -- [PH] Finesse Conduit - Warlock - All - Finesse Trait 4
--        179259, -- [PH] Potency Conduit - Warlock - Demonology - Potency Trait 1
--        179260, -- [PH] Potency Conduit - Warlock - Demonology - Potency Trait 2
--        179261, -- [PH] Flex Conduit - Warlock - Demonology - Flex Trait 1
--        179262, -- [PH] Flex Conduit - Warlock - Demonology - Flex Trait 2
--        179263, -- [PH] Potency Conduit - Warlock - Destruction - Potency Trait 1
--        179264, -- [PH] Potency Conduit - Warlock - Destruction - Potency Trait 2
--        179265, -- [PH] Flex Conduit - Warlock - Destruction - Flex Trait 1
--        179266, -- [PH] Flex Conduit - Warlock - Destruction - Flex Trait 2
        180317, -- Soulful Healing Potion
        180318, -- Soulful Mana Potion
        180404, -- Embertone Lotion
        180467, -- Potency Conduit
        180468, -- Finesse Conduit
        180469, -- Endurance Conduit
        180771, -- Potion of Unusual Strength
        181620, -- Hard Boiled Gorm Egg
        182163, -- Strength of Blood
        182298, -- Kaja'Extreme
        182382, -- Flask of Vile Resistance
        183823, -- Potion of Unhindered Passing
        183857, -- Strength of Fire
        184090, -- Potion of the Psychopomp's Speed
        184227, -- Angelic Feather
        184662, -- Requisitioned Anima Cell
        186043, -- Torghast Portal Manipulator
        186614, -- Soul Jar
        186615, -- Mirror of the Conjured Twin
        186636, -- Cage of Mawrats
        186678, -- Mawforged Weapons Cache
        186679, -- Scroll of Domination
        187802, -- Cosmic Healing Potion
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;8;0
    [8] = { -- BfA
        152494, -- Coastal Healing Potion
        152495, -- Coastal Mana Potion
        152497, -- Lightfoot Potion
        152503, -- Potion of Concealment
        152550, -- Sea Mist Potion
        152557, -- Steelskin Potion
        152559, -- Potion of Rising Death
        152560, -- Potion of Bursting Blood
        152561, -- Potion of Replenishment
        155821, -- Vial of Viscous Goo
        155822, -- Sedative Quill
        156627, -- M.O.J.O.
        156634, -- Silas' Vial of Continuous Curing
        156646, -- Bottled Azerite
        157798, -- Bilewing "Honey"
        163082, -- Coastal Rejuvenation Potion
        163222, -- Battle Potion of Intellect
        163223, -- Battle Potion of Agility
        163224, -- Battle Potion of Strength
        163225, -- Battle Potion of Stamina
        166750, -- Draught of Ten Lands
        166751, -- Draught of Ten Lands
        167917, -- Brawler's Coastal Healing Potion
        167918, -- Brawler's Battle Potion of Strength
        167919, -- Brawler's Battle Potion of Agility
        167920, -- Brawler's Battle Potion of Intellect
        168489, -- Superior Battle Potion of Agility
        168498, -- Superior Battle Potion of Intellect
        168499, -- Superior Battle Potion of Stamina
        168500, -- Superior Battle Potion of Strength
        168501, -- Superior Steelskin Potion
        168502, -- Potion of Reconstitution
        168506, -- Potion of Focused Resolve
        168529, -- Potion of Empowered Proximity
        169299, -- Potion of Unbridled Fury
        169300, -- Potion of Wild Mending
        169451, -- Abyssal Healing Potion
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;7;0
    [7] = { -- Legion
        127834, -- Ancient Healing Potion
        127835, -- Ancient Mana Potion
        127836, -- Ancient Rejuvenation Potion
        127843, -- Potion of Deadly Grace
        127844, -- Potion of the Old War
        127845, -- Unbending Potion
        127846, -- Leytorrent Potion
        128814, -- Potion of Cowardly Flight
        129192, -- Inquisitor's Menacing Eye
        129196, -- Legion Healthstone
        130258, -- Pocket Friend
        131729, -- Zanzil's Slow Poison
        136569, -- Aged Health Potion
        138486, -- "Third Wind" Potion
        138488, -- Saltwater Potion
        138727, -- Potion of Defiance
        138728, -- Potion of Trivial Invisibility
        138729, -- Potion of Heightened Senses
        140347, -- Spirit Berries
        140351, -- Sunfruit
        142117, -- Potion of Prolonged Power
        142325, -- Brawler's Ancient Healing Potion
        142326, -- Brawler's Potion of Prolonged Power
        143542, -- Crown Co. "Kure-Everything" Tonic
        143660, -- Mrgrglhjorn
        144228, -- Dino Mojo
        144396, -- Valorous Healing Potion
        144397, -- Valorous Potion of Armor
        144398, -- Valorous Rage Potion
        147445, -- Ancient Draught of Regeneration
        147707, -- Repurposed Fel Focuser
        152615, -- Astral Healing Potion
        152619, -- Astral Mana Potion
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;6;0
    [6] = { -- WoD
        107640, -- Potion of Slow Fall
        109217, -- Draenic Agility Potion
        109218, -- Draenic Intellect Potion
        109219, -- Draenic Strength Potion
        109220, -- Draenic Versatility Potion
        109221, -- Draenic Channeled Mana Potion
        109222, -- Draenic Mana Potion
        109223, -- Healing Tonic
        109226, -- Draenic Rejuvenation Potion
        113585, -- Iron Horde Rejuvenation Potion
        114124, -- Phantom Potion
        115498, -- Ashran Healing Tonic
        115531, -- Swirling Ashran Potion
        116266, -- Draenic Swiftness Potion
        116267, -- Free Action Potion
        116268, -- Draenic Invisibility Potion
        116275, -- Mighty Rage Potion
        116276, -- Draenic Living Action Potion
        116277, -- Potion of Petrification
        116925, -- Vintage Free Action Potion
        117415, -- Smuggled Tonic
        118006, -- Shieldtronic Shield
        118262, -- Brilliant Dreampetal
        118278, -- Pale Vision Potion
        118704, -- Pure Rage Potion
        118910, -- Brawler's Draenic Agility Potion
        118911, -- Brawler's Draenic Intellect Potion
        118912, -- Brawler's Draenic Strength Potion
        118913, -- Brawler's Bottomless Draenic Agility Potion
        118914, -- Brawler's Bottomless Draenic Intellect Potion
        118915, -- Brawler's Bottomless Draenic Strength Potion
        118916, -- Brawler's Healing Tonic
        118917, -- Brawler's Bottomless Healing Tonic
        118922, -- Oralius' Whispering Crystal
        122451, -- Commander's Draenic Invisibility Potion
        122452, -- Commander's Draenic Swiftness Potion
        122453, -- Commander's Draenic Agility Potion
        122454, -- Commander's Draenic Intellect Potion
        122455, -- Commander's Draenic Strength Potion
        122456, -- Commander's Draenic Versatility Potion
        124660, -- Darkmoon Healing Tonic
        124661, -- Gladiator's Healing Potion
        124671, -- Darkmoon Firewater
        128647, -- Fizzy Apple Cider
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;5;0
    [5] = { -- MoP
        76089, -- Virmen's Bite
        76090, -- Potion of the Mountains
        76091, -- Greater Potion of Luck
        76092, -- Potion of Focus
        76093, -- Potion of the Jade Serpent
        76094, -- Alchemist's Rejuvenation
        76095, -- Potion of Mogu Power
        76096, -- Darkwater Potion
        76097, -- Master Healing Potion
        76098, -- Master Mana Potion
        86569, -- Crystal of Insanity
        92941, -- Potion of Brawler's Might
        92942, -- Potion of Brawler's Cunning
        92943, -- Potion of Brawler's Deftness
        92954, -- Brawler's Healing Potion
        93351, -- Potion of Luck
        93742, -- Healing Potion
        95054, -- Potion of Light Steps
        95055, -- Frost Rune Trap
        97156, -- Frost Rune Trap
        97157, -- Potion of Light Steps
        98061, -- Bottomless Potion of Brawler's Deftness
        98062, -- Bottomless Potion of Brawler's Cunning
        98063, -- Bottomless Potion of Brawler's Might
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;4;0
    [4] = { -- Cataclysm
        54213, -- Molotov Cocktail
        57099, -- Mysterious Potion
        57191, -- Mythical Healing Potion
        57192, -- Mythical Mana Potion
        57193, -- Mighty Rejuvenation Potion
        57194, -- Potion of Concentration
        58090, -- Earthen Potion
        58091, -- Volcanic Potion
        58145, -- Potion of the Tol'vir
        58146, -- Golemblood Potion
        58487, -- Potion of Deepholm
        58488, -- Potion of Treasure Finding
        58489, -- Potion of Illusion
        63144, -- Baradin's Wardens Healing Potion
        63145, -- Baradin's Wardens Mana Potion
        63300, -- Rogue's Draught
        64993, -- Hellscream's Reach Mana Potion
        64994, -- Hellscream's Reach Healing Potion
        67415, -- Draught of War
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;3;0
    [3] = { -- WolTK
        33447, -- Runic Healing Potion
        33448, -- Runic Mana Potion
        36770, -- Zort's Protective Elixir
        38351, -- Murliver Oil
        39327, -- Noth's Special Brew
        39671, -- Resurgent Healing Potion
        40067, -- Icy Mana Potion
        40077, -- Crazy Alchemist's Potion
        40081, -- Potion of Nightmares
        40087, -- Powerful Rejuvenation Potion
        40093, -- Indestructible Potion
        40211, -- Potion of Speed
        40212, -- Potion of Wild Magic
        40213, -- Mighty Arcane Protection Potion
        40214, -- Mighty Fire Protection Potion
        40215, -- Mighty Frost Protection Potion
        40216, -- Mighty Nature Protection Potion
        40217, -- Mighty Shadow Protection Potion
        41166, -- Runic Healing Injector
        42545, -- Runic Mana Injector
        43530, -- Argent Mana Potion
        43531, -- Argent Healing Potion
        43569, -- Endless Healing Potion
        43570, -- Endless Mana Potion
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;2;0
    [2] = { -- TBC
        22826, -- Sneaking Potion
        22828, -- Insane Strength Potion
        22829, -- Super Healing Potion
        22832, -- Super Mana Potion
        22836, -- Major Dreamless Sleep Potion
        22837, -- Heroic Potion
        22838, -- Haste Potion
        22839, -- Destruction Potion
        22841, -- Major Fire Protection Potion
        22842, -- Major Frost Protection Potion
        22844, -- Major Nature Protection Potion
        22845, -- Major Arcane Protection Potion
        22846, -- Major Shadow Protection Potion
        22847, -- Major Holy Protection Potion
        22849, -- Ironshield Potion
        22850, -- Super Rejuvenation Potion
        22871, -- Shrouding Potion
        23822, -- Healing Potion Injector
        23823, -- Mana Potion Injector
        28100, -- Volatile Healing Potion
        28101, -- Unstable Mana Potion
        31676, -- Fel Regeneration Potion
        31677, -- Fel Mana Potion
        31838, -- Major Combat Healing Potion
        31839, -- Major Combat Healing Potion
        31840, -- Major Combat Mana Potion
        31841, -- Major Combat Mana Potion
        31852, -- Major Combat Healing Potion
        31853, -- Major Combat Healing Potion
        31854, -- Major Combat Mana Potion
        31855, -- Major Combat Mana Potion
        32783, -- Blue Ogre Brew
        32784, -- Red Ogre Brew
        32840, -- Major Arcane Protection Potion
        32844, -- Major Nature Protection Potion
        32845, -- Major Shadow Protection Potion
        32846, -- Major Fire Protection Potion
        32847, -- Major Frost Protection Potion
        32902, -- Bottled Nethergon Energy
        32903, -- Cenarion Mana Salve
        32904, -- Cenarion Healing Salve
        32905, -- Bottled Nethergon Vapor
        32909, -- Blue Ogre Brew Special
        32910, -- Red Ogre Brew Special
        32947, -- Auchenai Healing Potion
        32948, -- Auchenai Mana Potion
        33092, -- Healing Potion Injector
        33093, -- Mana Potion Injector
        33934, -- Crystal Healing Potion
        33935, -- Crystal Mana Potion
        34440, -- Mad Alchemist's Potion
        35287, -- Luminous Bluetail
    },
    -- https://www.wowhead.com/items/consumables/potions?filter=166;1;0
    [1] = { -- Classic
        118, -- Minor Healing Potion
        858, -- Lesser Healing Potion
        929, -- Healing Potion
        1710, -- Greater Healing Potion
        2455, -- Minor Mana Potion
        2456, -- Minor Rejuvenation Potion
        2459, -- Swiftness Potion
        3087, -- Mug of Shimmer Stout
        3385, -- Lesser Mana Potion
        3386, -- Potion of Curing
        3387, -- Limited Invulnerability Potion
        3823, -- Lesser Invisibility Potion
        3827, -- Mana Potion
        3928, -- Superior Healing Potion
        4596, -- Discolored Healing Potion
        4623, -- Lesser Stoneshield Potion
        5631, -- Rage Potion
        5633, -- Great Rage Potion
        5634, -- Free Action Potion
        5816, -- Light of Elune
        6048, -- Shadow Protection Potion
        6049, -- Fire Protection Potion
        6050, -- Frost Protection Potion
        6051, -- Holy Protection Potion
        6052, -- Nature Protection Potion
        6149, -- Greater Mana Potion
        6372, -- Swim Speed Potion
        9030, -- Restorative Potion
        9144, -- Wildvine Potion
        9172, -- Invisibility Potion
        12190, -- Dreamless Sleep Potion
        13442, -- Mighty Rage Potion
        13443, -- Superior Mana Potion
        13444, -- Major Mana Potion
        13446, -- Major Healing Potion
        13455, -- Greater Stoneshield Potion
        13456, -- Greater Frost Protection Potion
        13457, -- Greater Fire Protection Potion
        13458, -- Greater Nature Protection Potion
        13459, -- Greater Shadow Protection Potion
        13460, -- Greater Holy Protection Potion
        13461, -- Greater Arcane Protection Potion
        13462, -- Purification Potion
        13506, -- Potion of Petrification
        17348, -- Major Healing Draught
        17349, -- Superior Healing Draught
        17351, -- Major Mana Draught
        17352, -- Superior Mana Draught
        18253, -- Major Rejuvenation Potion
        18839, -- Combat Healing Potion
        18841, -- Combat Mana Potion
        20002, -- Greater Dreamless Sleep Potion
        20008, -- Living Action Potion
    },
}
]]

--[[ Do we really need the items gathered via the Fishing profession? 
items.Fishing = {
	[10] = { -- Dragonflight
		199340, -- Gold Coin of the Isles
		199338, -- Copper Coin of the Isles
		210470, -- Echoed Ephemera
	},
	[9] = { -- Shadowland
		187712,	 -- Precursor Placoderm Bait
		187707,	 -- Progenitor Essentia
		187702,	 -- Precursor Placoderm
		184485,	 -- Mawforged Key
		184393,	 -- Everburning Mange
		184286,	 -- Extinguished Soul Anima
		182601,	 -- Sludgefist's Head
		181956,	 -- Bloodthroated Grouper
		181955,	 -- Skeletal Mudskipper
		181954,	 -- Glorious Shimmerfin
		181387,	 -- Speckled Flametail
		180168,	 -- Oribobber
		178133,	 -- Tendrils of Ectoplasm
		177028,	 -- Rusty Chain
		177026,	 -- Lost Earring
		177025,	 -- Partially Eaten Fish
		176876,	 -- Collapsed Psyche
		176868,	 -- Sliver of Entropy
		173204,	 -- Lightless Silk
		173202,	 -- Shrouded Cloth
		173192,	 -- Shrouded Cloth Bandage
		173043,	 -- Elysian Thade Bait
		173042,	 -- Spinefin Piranha Bait
		173041,	 -- Pocked Bonefish Bait
		173040,	 -- Silvergill Pike Bait
		173039,	 -- Iridescent Amberjack Bait
		173038,	 -- Lost Sole Bait
		173037,	 -- Elysian Thade
		173036,	 -- Spinefin Piranha
		173035,	 -- Pocked Bonefish
		173034,	 -- Silvergill Pike
		173033,	 -- Iridescent Amberjack
		173032,	 -- Lost Sole
		171441,	 -- Laestrite Skeleton Key
	},
	[8] = { -- BfA
		174758,	 -- Voidwarped Relic Fragment
		174328,	 -- Aberrant Voidfin
		174327,	 -- Malformed Gnasher
		168646,	 -- Mauve Stinger
		168302,	 -- Viper Fish
		168262,	 -- Sentry Fish
		167562,	 -- Ionized Minnow
		166971,	 -- Empty Energy Cell
		166970,	 -- Energy Cell
		166846,	 -- Spare Parts
		166287,	 -- Silver Dawning Salvage
		164973,	 -- Severed Azurefin Head
		164972,	 -- Severed Crimsonscale Head
		162517,	 -- U'taka
		162516,	 -- Rasboralus
		162515,	 -- Midnight Salmon
		158771,	 -- Spirit Ichor
		157844,	 -- Iridescent Speck
		155609,	 -- Springy Eyeball
		152549,	 -- Redtail Loach
		152548,	 -- Tiragarde Perch
		152547,	 -- Great Sea Catfish
		152546,	 -- Lane Snapper
		152545,	 -- Frenzied Fangtooth
		152544,	 -- Slimy Mackerel
		152543,	 -- Sand Shifter
		152511,	 -- Sea Stalk
		152506,	 -- Star Moss
		152505,	 -- Riverbud
	},
	[7] = { 	-- Legion
		151555,	 -- Crystallized Memory
		146969,	 -- Faintly Pulsing Felstone
		146968,	 -- Glowing Fish Scale
		146967,	 -- White Sparkly Bauble
		146966,	 -- Water Totem Figurine
		146965,	 -- Disgusting Ooze
		146964,	 -- Hatecoil Spearhead
		146963,	 -- Desecrated Seaweed
		146962,	 -- Golden Minnow
		146961,	 -- Shiny Bauble
		146960,	 -- Ancient Totem Fragment
		146959,	 -- Corrupted Globule
		146848,	 -- Fragmented Enchantment
		144238,	 -- Ancient Bones
		144079,	 -- Glob of Oil
		144077,	 -- Submarine Tar
		141975,	 -- Mark of Aquaos
		140753,	 -- Half Eaten Candy Bar
		139279,	 -- Albino Barracuda
		138967,	 -- Big Fountain Goldfish
		138948,	 -- Li Li's Coin
		138947,	 -- Gallywix's Coin-on-a-String
		138946,	 -- Queen Azshara's Royal Seal
		138945,	 -- Illidan's Coin
		138944,	 -- Lunara's Coin
		138943,	 -- Lady Liadrin's Coin
		138942,	 -- Blingtron's Botcoin
		138941,	 -- The Coin
		138940,	 -- Kor'vas Bloodthorn's Coin
		138939,	 -- Kayn Sunfury's Coin
		138938,	 -- Jace Darkweaver's Coin
		138937,	 -- Izal Whitemoon's Coin
		138936,	 -- Falara Nightsong's Coin
		138935,	 -- Cyana Nightglaive's Coin
		138934,	 -- Altruis the Sufferer's Coin
		138933,	 -- Allari the Souleater's Coin
		138932,	 -- Yowlon's Mark
		138931,	 -- Gul'dan's Coin
		138930,	 -- Advisor Vandros' Coin
		138929,	 -- Pearlhunter Phin's Soggy Coin
		138928,	 -- Ly'leth Lunastre's Family Crest
		138927,	 -- Oculeth's Vanishing Coin
		138926,	 -- Magistrix Elisande's Coin
		138925,	 -- First Arcanist Thalyssra's Coin
		138924,	 -- Rax Sixtrigger's Gold-Painted Copper Coin
		138923,	 -- Vydhar's Wooden Nickel
		138922,	 -- Havi's Coin
		138921,	 -- Sir Finley Mrrgglton's Coin
		138920,	 -- Helya's Coin
		138919,	 -- Nathanos Blightcaller's Coin
		138918,	 -- Genn Greymane's Coin
		138917,	 -- God-King Skovald's Fel-Tainted Coin
		138916,	 -- Torok Bloodtotem's Coin
		138915,	 -- The Candleking's Candlecoin
		138914,	 -- Boomboom Brullingsworth's Coin
		138913,	 -- Addie Fizzlebog's Coin
		138912,	 -- Spiritwalker Ebonhorn's Coin
		138911,	 -- Murky's Coin
		138910,	 -- Hemet Nesingwary's Bullet
		138909,	 -- King Mrgl-Mrgl's Coin
		138908,	 -- Koda's Sigil
		138907,	 -- Elothir's Golden Leaf
		138906,	 -- Remulos' Sigil
		138905,	 -- Penelope Heathrow's Allowance
		138904,	 -- Jarod Shadowsong's Coin
		138903,	 -- Kur'talos Ravencrest's Spectral Coin
		138902,	 -- Malfurion's Coin
		138901,	 -- Tyrande's Coin
		138899,	 -- Daglop's Infernal Copper Coin
		138898,	 -- Coin of Golk the Rumble
		138897,	 -- Ooker's Dookat
		138896,	 -- Okuna Longtusk's Doubloon
		138895,	 -- Senegos' Ancient Coin
		138894,	 -- Stellagosa's Silver Coin
		138893,	 -- Runas' Last Copper
		138892,	 -- Prince Farondis's Royal Seal
		138777,	 -- Drowned Mana
		138114,	 -- Gloaming Frenzy
		134574,	 -- Huge Runescale Koi
		134573,	 -- Lively Runescale Koi
		134571,	 -- Huge Stormray
		134570,	 -- Lively Stormray
		134568,	 -- Huge Mossgill Perch
		134567,	 -- Lively Mossgill Perch
		134566,	 -- Blue Barracuda
		134565,	 -- Huge Cursed Queenfish
		134564,	 -- Lively Cursed Queenfish
		134547,	 -- Wild Northern Barracuda
		134400,	 -- Lively Highmountain Salmon
		134399,	 -- Huge Highmountain Salmon
		133742,	 -- Ancient Black Barracuda
		133740,	 -- Axefish
		133739,	 -- Tainted Runescale Koi
		133737,	 -- Magic-Eater Frog
		133736,	 -- Thundering Stormray
		133735,	 -- Graybelly Lobster
		133734,	 -- Oodelfjisk
		133733,	 -- Ancient Highmountain Salmon
		133732,	 -- Coldriver Carp
		133731,	 -- Mountain Puffer
		133730,	 -- Ancient Mossgill
		133729,	 -- Thorned Flounder
		133728,	 -- Terrorfin
		133727,	 -- Ghostly Queenfish
		133726,	 -- Nar'thalas Hermit
		133725,	 -- Leyshimmer Blenny
		133607,	 -- Silver Mackerel
		132204,	 -- Sticky Volatile Substance
		132184,	 -- Intact Shimmering Scale
		129100,	 -- Gem Chip
		124437,	 -- Shal'dorei Silk
		124124,	 -- Blood of Sargeras
		124112,	 -- Black Barracuda
		124111,	 -- Runescale Koi
		124110,	 -- Stormray
		124109,	 -- Highmountain Salmon
		124108,	 -- Mossgill Perch
		124107,	 -- Cursed Queenfish
	},
	[6] = { 	-- WoD
		133688,	 -- Tugboat Bobber
		127994,	 -- Felmouth Frenzy Lunker
		127991,	 -- Felmouth Frenzy
		127759,	 -- Felblight
		124671,	 -- Darkmoon Firewater
		124669,	 -- Darkmoon Daggermaw
		122742,	 -- Bladebone Hook
		122696,	 -- Sea Scorpion Lunker
		118566,	 -- Enormous Savage Piranha
		118565,	 -- Savage Piranha
		118564,	 -- Small Savage Piranha
		118424,	 -- Blind Palefish
		118415,	 -- Grieferfish
		118414,	 -- Awesomefish
		118392,	 -- Burnt Clump
		118391,	 -- Worm Supreme
		118280,	 -- Succulent Offshoot
		118046,	 -- Rubber Duck
		118041,	 -- Arcane Trout
		117397,	 -- Nat's Lucky Coin
		116822,	 -- Jawless Skulker Lunker
		116821,	 -- Fat Sleeper Lunker
		116820,	 -- Blind Lake Lunker
		116819,	 -- Fire Ammonite Lunker
		116818,	 -- Abyssal Gulper Lunker
		116817,	 -- Blackwater Whiptail Lunker
		116754,	 -- Molten Catfish
		116753,	 -- Fat Sleeper Lunker
		116752,	 -- Jawless Skulker Lunker
		116751,	 -- Abyssal Gulper Lunker
		116750,	 -- Blind Lake Sturgeon Lunker
		116749,	 -- Blackwater Whiptail Lunker
		116748,	 -- Fire Ammonite Lunker
		116411,	 -- Scroll of Protection
		116158,	 -- Lunarfall Carp
		114876,	 -- Shadow Sturgeon
		114845,	 -- Tome of Blink
		114625,	 -- Zangar Eel
		112684,	 -- Damaged Weaponry
		112633,	 -- Frostdeep Minnow
		112463,	 -- Battered Armor Fragments
		112111,	 -- Construction Debris
		111676,	 -- Enormous Jawless Skulker
		111675,	 -- Enormous Fat Sleeper
		111674,	 -- Enormous Blind Lake Sturgeon
		111673,	 -- Enormous Fire Ammonite
		111672,	 -- Enormous Sea Scorpion
		111671,	 -- Enormous Abyssal Gulper Eel
		111670,	 -- Enormous Blackwater Whiptail
		111669,	 -- Jawless Skulker
		111668,	 -- Fat Sleeper
		111667,	 -- Blind Lake Sturgeon
		111666,	 -- Fire Ammonite
		111665,	 -- Sea Scorpion
		111664,	 -- Abyssal Gulper Eel
		111663,	 -- Blackwater Whiptail
		111662,	 -- Small Blackwater Whiptail
		111659,	 -- Small Abyssal Gulper Eel
		111658,	 -- Small Sea Scorpion
		111656,	 -- Small Fire Ammonite
		111652,	 -- Small Blind Lake Sturgeon
		111651,	 -- Small Fat Sleeper
		111650,	 -- Small Jawless Skulker
		111601,	 -- Enormous Crescent Saberfish
		111595,	 -- Crescent Saberfish
		111589,	 -- Small Crescent Saberfish
		109226,	 -- Draenic Rejuvenation Potion
		109223,	 -- Healing Tonic
		109222,	 -- Draenic Mana Potion
	},
	[5] = { 	-- MoP
		103643,	 -- Dew of Eternal Morning
		103642,	 -- Book of the Ages
		103641,	 -- Singing Crystal
		93738,	 -- Rusty Prison Key
		90558,	 -- Extreme Back Scratcher
		90058,	 -- Well-Loved Toy
		90048,	 -- Exquisite Murloc Leash
		90047,	 -- Sack of Expired Pet Food
		90043,	 -- Rusty Pet Cage
		89740,	 -- Complicated Samophlange
		89739,	 -- Stripped Gear
		89112,	 -- Mote of Harmony
		88155,	 -- Nail Pick
		83065,	 -- Desecrated Carcass
		83064,	 -- Spinefish
		81122,	 -- Wolf Piranha
		80830,	 -- Rusty Shipwreck Debris
		80310,	 -- Silver Goby
		80260,	 -- Dojani Eel
		79046,	 -- Sugar Minnow
		76097,	 -- Master Healing Potion
		74866,	 -- Golden Carp
		74865,	 -- Krasarang Paddlefish
		74864,	 -- Reef Octopus
		74863,	 -- Jewel Danio
		74861,	 -- Tiger Gourami
		74860,	 -- Redbelly Mandarin
		74859,	 -- Emperor Salmon
		74857,	 -- Giant Mantis Shrimp
		74856,	 -- Jade Lungfish
		72988,	 -- Windwool Cloth
	},
	[4] = { 	-- Cataclysm
		78883,	 -- Darkmoon Firewater
		73269,	 -- Great Sea Herring
		69987,	 -- Kaldorei Herring
		69977,	 -- Stonebull Crayfish
		69967,	 -- Amorous Mud Snapper
		69964,	 -- Randy Smallfish
		69956,	 -- Blind Cavefish
		69934,	 -- Azshara Snakehead
		69933,	 -- Blind Minnow
		69931,	 -- Arctic Char
		69914,	 -- Giant Catfish
		69912,	 -- Lake Whitefish
		69911,	 -- Squirming Slime Mold
		69909,	 -- Corpse-Fed Pike
		69905,	 -- Giant Flesh-Eating Tadpole
		69901,	 -- Severed Abomination Head
		68198,	 -- Ruined Embersilk Scraps
		68197,	 -- Scavenged Animal Parts
		67509,	 -- Sundered Carapace
		67407,	 -- Tangled Bronze Hooks
		67403,	 -- Ivory Fisherman's Pipe
		67401,	 -- Swatch of Netting
		67399,	 -- Stripped Drilling Gears
		67397,	 -- Chipped Hair Brush
		67310,	 -- Demon Hair
		67306,	 -- Rusted Key
		67305,	 -- Broken Key
		67304,	 -- Lost Key
		63309,	 -- Warden's Keys
		62778,	 -- Toughened Flesh
		62772,	 -- Drop of Slime
		62770,	 -- Infested Feather
		62525,	 -- Cloudy Crocolisk Eye
		62514,	 -- Cracked Pincer
		62512,	 -- Small Animal Bone
		62391,	 -- Cat Hair
		62328,	 -- Shed Fur
		61979,	 -- Ashen Pigment
		60576,	 -- Rending Fang
		58951,	 -- Giant Furious Pike
		58946,	 -- Sandy Carp
		58945,	 -- Toxic Puddlefish
		58899,	 -- Violet Perch
		58866,	 -- Set of Rusty Keys
		58865,	 -- Slimy Ring
		58856,	 -- Royal Monkfish
		58787,	 -- Crystal Bass
		58503,	 -- Hardened Walleye
		58258,	 -- Smoked String Cheese
		57544,	 -- Leftover Boar Meat
		57543,	 -- Stormhammer Stout
		57245,	 -- Gigantic Catfish
		57071,	 -- Bistabilization Device
		57070,	 -- Multistable Perceiver
		57069,	 -- Monocular Pattern Alternator
		57068,	 -- Dancing Spinner
		57067,	 -- Pinrose Tribar
		57066,	 -- Three-Pronged Blivet
		57065,	 -- Irrational Cube
		57064,	 -- Rational Cube
		57063,	 -- Small Dingbat
		57062,	 -- Intact Spurwheel
		57061,	 -- Pre-Owned Pinion
		57060,	 -- Cracked Cogwheel
		57059,	 -- Decoupled Coupling
		57058,	 -- Fractured Gear Tooth
		55983,	 -- Inert Elemental Scintilla
		55973,	 -- Inert Elemental Speck
		54632,	 -- Torn Flipper
		54624,	 -- Defective Gear
		54623,	 -- Flimsy Sprocket
		53072,	 -- Deepsea Sagefish
		53071,	 -- Algaefin Rockfish
		53070,	 -- Fathom Eel
		53069,	 -- Murglesnout
		53068,	 -- Lavascale Catfish
		53067,	 -- Striped Lurker
		53066,	 -- Blackbelly Mudfish
		53065,	 -- Albino Cavefish
		53064,	 -- Highland Guppy
		53063,	 -- Mountain Trout
		53062,	 -- Sharptooth
		53010,	 -- Embersilk Cloth
		52985,	 -- Azshara's Veil
		52326,	 -- Volatile Water
		52325,	 -- Volatile Fire
		50438,	 -- Damaged Naga Hide
		49751,	 -- Priceless Rockjaw Artifact
		46703,	 -- Brass Button
		46391,	 -- Broken Timepiece
		46390,	 -- Corroded Keys
		44580,	 -- Potion Goo
	},
	[3] = { 	-- WolTK
		49908,	 -- Primordial Saronite
		46368,	 -- Shredded Parchment
		46003,	 -- Worthless Piece of Orange Glass
		46002,	 -- Worthless Piece of Violet Glass
		46001,	 -- Worthless Piece of Green Glass
		46000,	 -- Worthless Piece of Red Glass
		45999,	 -- Worthless Piece of White Glass
		45981,	 -- New Age Painting
		45980,	 -- Whale Statue
		45979,	 -- Tower Key
		45978,	 -- Solid Gold Coin
		45977,	 -- Porcelain Bell
		45909,	 -- Giant Darkwater Clam
		45907,	 -- Mostly-Eaten Bonescale Snapper
		45905,	 -- Bloodtooth Frenzy
		45904,	 -- Terrorfish
		45903,	 -- Corroded Jewelry
		45902,	 -- Phantom Ghostfish
		45202,	 -- Water Snail
		45201,	 -- Rock
		45200,	 -- Sickly Fish
		45199,	 -- Old Boot
		45198,	 -- Weeds
		45197,	 -- Tree Branch
		45196,	 -- Tattered Cloth
		45195,	 -- Empty Rum Bottle
		45194,	 -- Tangled Fishing Line
		45191,	 -- Empty Clam
		45190,	 -- Driftwood
		45189,	 -- Torn Sail
		45188,	 -- Withered Kelp
		44778,	 -- Hefty Barrel
		44771,	 -- Spiked Leg
		44756,	 -- Coagulated Slime
		43852,	 -- Thick Fur Clothing Scraps
		43851,	 -- Fur Clothing Scraps
		43723,	 -- Vargoth's Copper Coin
		43722,	 -- Vereesa's Copper Coin
		43721,	 -- Stalvan's Copper Coin
		43720,	 -- Squire Rowe's Copper Coin
		43719,	 -- Salandria's Shiny Copper Coin
		43718,	 -- Private Marcus Jonathan's Copper Coin
		43717,	 -- Princess Calia Menethil's Copper Coin
		43716,	 -- Murky's Copper Coin
		43715,	 -- Molok's Copper Coin
		43714,	 -- Landro Longshot's Copper Coin
		43713,	 -- Kryll's Copper Coin
		43712,	 -- Krasus' Copper Coin
		43711,	 -- Inigo's Copper Coin
		43710,	 -- Genn's Copper Coin
		43709,	 -- Falstad Wildhammer's Copper Coin
		43708,	 -- Elling Trias' Copper Coin
		43707,	 -- Eitrigg's Copper Coin
		43706,	 -- Dornaa's Shiny Copper Coin
		43705,	 -- Danath's Copper Coin
		43704,	 -- Attumen's Copper Coin
		43703,	 -- Ansirem's Copper Coin
		43702,	 -- Alonsus Faol's Copper Coin
		43701,	 -- A Footman's Copper Coin
		43696,	 -- Half Empty Bottle of Prison Moonshine
		43695,	 -- Half Full Bottle of Prison Moonshine
		43694,	 -- Drowned Rat
		43687,	 -- Aegwynn's Silver Coin
		43686,	 -- Alleria's Silver Coin
		43685,	 -- Maiev Shadowsong's Silver Coin
		43684,	 -- Medivh's Silver Coin
		43683,	 -- Khadgar's Silver Coin
		43682,	 -- King Anasterian Sunstrider's Silver Coin
		43681,	 -- King Terenas Menethil's Silver Coin
		43680,	 -- King Varian Wrynn's Silver Coin
		43679,	 -- Muradin Bronzebeard's Silver Coin
		43678,	 -- Antonidas' Silver Coin
		43677,	 -- High Tinker Mekkatorque's Silver Coin
		43676,	 -- Arcanist Doan's Silver Coin
		43675,	 -- Fandral Staghelm's Silver Coin
		43658,	 -- Partially Rusted File
		43653,	 -- Partially Eaten Fish
		43652,	 -- Slippery Eel
		43647,	 -- Shimmering Minnow
		43646,	 -- Fountain Goldfish
		43645,	 -- Bent Fishing Hook
		43644,	 -- A Peasant's Silver Coin
		43643,	 -- Prince Magni Bronzebeard's Silver Coin
		43641,	 -- Anduin Wrynn's Gold Coin
		43640,	 -- Archimonde's Gold Coin
		43639,	 -- Arthas' Gold Coin
		43638,	 -- Arugal's Gold Coin
		43637,	 -- Brann Bronzebeard's Gold Coin
		43636,	 -- Chromie's Gold Coin
		43635,	 -- Kel'Thuzad's Gold Coin
		43634,	 -- Lady Katrana Prestor's Gold Coin
		43633,	 -- Prince Kael'thas Sunstrider's Gold Coin
		43632,	 -- Sylvanas Windrunner's Gold Coin
		43631,	 -- Teron's Gold Coin
		43630,	 -- Tirion Fordring's Gold Coin
		43629,	 -- Uther Lightbringer's Gold Coin
		43628,	 -- Lady Jaina Proudmoore's Gold Coin
		43627,	 -- Thrall's Gold Coin
		43572,	 -- Magic Eater
		43571,	 -- Sewer Carp
		43522,	 -- Slimming Ankle Bracelet
		43521,	 -- Stylish Toe Ring
		43333,	 -- Empty Hippogryph Harness
		43330,	 -- Broken U.L.O.S.E Button
		43329,	 -- Pigtail Holder
		43326,	 -- Tusk Warmer
		43012,	 -- Rhino Meat
		42931,	 -- Toothless Gear
		42930,	 -- Crooked Cog
		42640,	 -- Viscous Oil
		41814,	 -- Glassfin Minnow
		41813,	 -- Nettlefish
		41812,	 -- Barrelhead Goby
		41810,	 -- Fangtooth Herring
		41809,	 -- Glacial Salmon
		41808,	 -- Bonescale Snapper
		41807,	 -- Dragonfin Angelfish
		41806,	 -- Musselback Sculpin
		41805,	 -- Borean Man O' War
		41803,	 -- Rockfin Grouper
		41802,	 -- Imperial Manta Ray
		41801,	 -- Moonglow Cuttlefish
		41800,	 -- Deep Sea Monsterbelly
		41338,	 -- Sprung Whirlygig
		41337,	 -- Whizzed-Out Gizmo
		40411,	 -- Shattered Vial
		40199,	 -- Pygmy Suckerfish
		39552,	 -- Dissolved Skull
		39551,	 -- Stewing Ichor
		38520,	 -- Diving Log
		38269,	 -- Soggy Handkerchief
		38261,	 -- Bent House Key
		37705,	 -- Crystallized Water
		37704,	 -- Crystallized Life
		37091,	 -- Scroll of Intellect VII
		36794,	 -- Scoured Fishbones
		36788,	 -- Matted Fur
		36781,	 -- Darkwater Clam
		35947,	 -- Sparkling Frostcap
		33632,	 -- Icicle Fang
		33631,	 -- Frosted Claw
		33567,	 -- Borean Leather Scraps
		33470,	 -- Frostweave Cloth
		33447,	 -- Runic Healing Potion
		33445,	 -- Honeymint Tea
		33443,	 -- Sour Goat Cheese
	},
	[2] = { 	-- BC
		37588,	 -- Mostly Digested Fish
		35691,	 -- Ruined Metal Parts
		35314,	 -- Partially Digested Weeds
		35285,	 -- Giant Sunfish
		34866,	 -- Giant Freshwater Shrimp
		34861,	 -- Sharpened Fish Hook
		34860,	 -- Rusted Lock
		34843,	 -- Giant Shark Tooth
		34841,	 -- Salvaged Scrap Metal
		34839,	 -- Piece of Polished Driftwood
		33824,	 -- Crescent-Tail Skullfish
		33823,	 -- Bloodfin Catfish
		32905,	 -- Bottled Nethergon Vapor
		32902,	 -- Bottled Nethergon Energy
		32714,	 -- Splintered Spider Fang
		30810,	 -- Sunfury Signet
		30809,	 -- Mark of Sargeras
		29799,	 -- Lifeless Tendril
		29570,	 -- A Gnome Effigy
		29460,	 -- Ethereum Prison Key
		28116,	 -- Zeppelin Debris
		27857,	 -- Garadar Sharp
		27668,	 -- Lynx Meat
		27516,	 -- Enormous Barbed Gill Trout
		27515,	 -- Huge Spotted Feltail
		27443,	 -- Steam Pump Debris
		27442,	 -- Goldenscale Vendorfish
		27441,	 -- Felblood Snapper
		27439,	 -- Furious Crawdad
		27438,	 -- Golden Darter
		27437,	 -- Icefin Bluefish
		27435,	 -- Figluster's Mudfish
		27429,	 -- Zangarian Sporefish
		27425,	 -- Spotted Feltail
		27422,	 -- Barbed Gill Trout
		25467,	 -- Torn Moth Wing
		25466,	 -- Broken Antenna
		25447,	 -- Broken Skull
		25431,	 -- Ripped Fin
		25430,	 -- Glimmering Scale
		25418,	 -- Razor Sharp Fang
		24508,	 -- Elemental Fragment
		24476,	 -- Jaggal Clam
		23801,	 -- Bristlelimb Key
		23676,	 -- Moongraze Stag Tenderloin
		23614,	 -- Red Snapper
		23572,	 -- Primal Nether
		23384,	 -- Dimly Glowing Eye
		23380,	 -- Broken Power Core
		23353,	 -- Mana Residue
		23333,	 -- Shattered Power Core
		23332,	 -- Withered Lasher Root
		23331,	 -- Broken Vine
		23329,	 -- Enriched Lasher Root
		22644,	 -- Crunchy Spider Leg
		22578,	 -- Mote of Water
		21877,	 -- Netherweave Cloth
		20848,	 -- Sparkling Dust
		20847,	 -- Wraith Fragment
		20842,	 -- Frayed Tender Vine
		20813,	 -- Lynx Tooth
		20812,	 -- Tattered Pelt
	},
	[1] = { 	-- Classic
		24232,	 -- Shabby Knot
		21227,	 -- Ancient Hero's Skull
		21224,	 -- Ancient Armor Fragment
		21153,	 -- Raw Greater Sagefish
		21151,	 -- Rumsey Rum Black Label
		21114,	 -- Rumsey Rum Dark
		21071,	 -- Raw Sagefish
		20709,	 -- Rumsey Rum Light
		19807,	 -- Speckled Tastyfish
		19806,	 -- Dezian Queenfish
		19805,	 -- Keefer's Angelfish
		19803,	 -- Brownell's Blue Striped Racer
		18256,	 -- Melted Vial
		17056,	 -- Light Feather
		16747,	 -- Broken Lock
		13893,	 -- Large Raw Mightfish
		13890,	 -- Plated Armorfish
		13889,	 -- Raw Whitescale Salmon
		13888,	 -- Darkclaw Lobster
		13760,	 -- Raw Sunscale Salmon
		13759,	 -- Raw Nightfin Snapper
		13758,	 -- Raw Redgill
		13757,	 -- Lightning Eel
		13756,	 -- Raw Summer Bass
		13755,	 -- Winter Squid
		13754,	 -- Raw Glossy Mightfish
		13446,	 -- Major Healing Potion
		13443,	 -- Superior Mana Potion
		13422,	 -- Stonescale Eel
		12238,	 -- Darkshore Grouper
		12223,	 -- Meaty Bat Wing
		9357,	 -- A Parrot Skeleton
		9356,	 -- A Wooden Leg
		9355,	 -- Hoop Earring
		9334,	 -- Cracked Pottery
		8952,	 -- Roasted Quail
		8925,	 -- Tainted Vial
		8766,	 -- Morning Glory Dew
		8365,	 -- Raw Mithril Head Trout
		7973,	 -- Big-Mouth Clam
		7909,	 -- Aquamarine
		7307,	 -- Flesh Eating Worm
		7101,	 -- Bug Eye
		7097,	 -- Leg Meat
		7096,	 -- Plucked Feather
		7080,	 -- Essence of Water
		7079,	 -- Globe of Water
		7078,	 -- Essence of Fire
		7074,	 -- Chipped Claw
		7070,	 -- Elemental Water
		6889,	 -- Small Egg
		6718,	 -- Electropeller
		6717,	 -- Gaffer Jack
		6529,	 -- Shiny Bauble
		6522,	 -- Deviate Fish
		6470,	 -- Deviate Scale
		6458,	 -- Oil Covered Fish
		6457,	 -- Rusted Engineering Parts
		6456,	 -- Acidic Slime
		6455,	 -- Old Wagonwheel
		6362,	 -- Raw Rockscale Cod
		6361,	 -- Raw Rainbow Fin Albacore
		6359,	 -- Firefin Snapper
		6358,	 -- Oily Blackmouth
		6317,	 -- Raw Loch Frenzy
		6308,	 -- Raw Bristle Whisker Catfish
		6303,	 -- Raw Slitherskin Mackerel
		6299,	 -- Sickly Looking Fish
		6297,	 -- Old Skull
		6291,	 -- Raw Brilliant Smallfish
		6289,	 -- Raw Longjaw Mud Snapper
		6149,	 -- Greater Mana Potion
		5567,	 -- Silver Hook
		5566,	 -- Broken Antler
		5523,	 -- Small Barnacled Clam
		5469,	 -- Strider Meat
		5466,	 -- Scorpid Stinger
		5465,	 -- Small Spider Leg
		5435,	 -- Shiny Dinglehopper
		5431,	 -- Empty Hip Flask
		5376,	 -- Broken Mirror
		5370,	 -- Bent Spoon
		5369,	 -- Gnawed Bone
		5368,	 -- Empty Wallet
		5136,	 -- Torn Furry Ear
		5115,	 -- Broken Wishbone
		5114,	 -- Severed Talon
		4875,	 -- Slimy Bone
		4874,	 -- Clean Fishbones
		4872,	 -- Dry Scorpid Eye
		4814,	 -- Discolored Fang
		4813,	 -- Small Leather Collar
		4801,	 -- Stalker Claws
		4776,	 -- Ruffled Feather
		4775,	 -- Cracked Bill
		4757,	 -- Cracked Egg Shells
		4604,	 -- Forest Mushroom Cap
		4603,	 -- Raw Spotted Yellowtail
		4558,	 -- Empty Barrel
		4540,	 -- Tough Hunk of Bread
		4536,	 -- Shiny Red Apple
		4382,	 -- Bronze Framework
		4377,	 -- Heavy Blasting Powder
		4371,	 -- Bronze Tube
		4364,	 -- Coarse Blasting Powder
		4363,	 -- Broken Modulator
		4359,	 -- Handful of Copper Bolts
		4339,	 -- Bolt of Mageweave
		4338,	 -- Mageweave Cloth
		4305,	 -- Bolt of Silk Cloth
		3928,	 -- Superior Healing Potion
		3864,	 -- Citrine
		3857,	 -- Coal
		3827,	 -- Mana Potion
		3820,	 -- Stranglekelp
		3769,	 -- Broken Wand
		3674,	 -- Decomposed Boot
		3673,	 -- Broken Arrow
		3671,	 -- Lifeless Skull
		3670,	 -- Large Slimy Bone
		3385,	 -- Lesser Mana Potion
		3372,	 -- Cracked Vial
		3371,	 -- Crystal Vial
		3299,	 -- Fractured Canine
		3173,	 -- Bear Meat
		2997,	 -- Bolt of Woolen Cloth
		2996,	 -- Bolt of Linen Cloth
		2924,	 -- Crocolisk Meat
		2886,	 -- Crag Boar Rib
		2677,	 -- Boar Ribs
		2675,	 -- Crawler Claw
		2674,	 -- Crawler Meat
		2672,	 -- Stringy Wolf Meat
		2591,	 -- Dirty Trogg Cloth
		2589,	 -- Linen Cloth
		2455,	 -- Minor Mana Potion
		2449,	 -- Earthroot
		2290,	 -- Scroll of Intellect II
		2070,	 -- Darnassian Bleu
		1710,	 -- Greater Healing Potion
		1705,	 -- Lesser Moonstone
		1630,	 -- Broken Electro-Lantern
		1529,	 -- Jade
		1468,	 -- Murloc Fin
		1210,	 -- Shadowgem
		1175,	 -- A Gold Tooth
		1015,	 -- Lean Wolf Flank
		929,	 -- Healing Potion
		858,	 -- Lesser Healing Potion
		818,	 -- Tigerseye
		779,	 -- Shiny Seashell
		774,	 -- Malachite
		769,	 -- Chunk of Boar Meat
		159,	 -- Refreshing Spring Water
		118,	 -- Minor Healing Potion
		117,	 -- Tough Jerky
	},
}
]]
--[[
items.Relics = {
	[10] = { -- Dragonflight
	},
	[9] = { -- Shadowland
		190189,	 -- Sandworn Relic
		187996,	 -- Sacred Relic
		187944,	 -- Progenitor Relic
		187487,	 -- Ancient Relic Expositor
		187350,	 -- Displaced Relic
		186685,	 -- Relic Fragment
		180341,	 -- Nathrezim Relic
		180060,	 -- Relic of the Past V
		180059,	 -- Relic of the Past IV
		180058,	 -- Relic of the Past III
		180057,	 -- Relic of the Past II
		180055,	 -- Relic of the Past I
	},
	[8] = { -- BfA
		174764,	 -- Tol'vir Relic Fragment
		174760,	 -- Mantid Relic Fragment
		174759,	 -- Mogu Relic Fragment
		174758,	 -- Voidwarped Relic Fragment
		174756,	 -- Aqir Relic Fragment
		169490,	 -- Relic of the Black Empire
		168224,	 -- Tortollan Relics
		168187,	 -- Highborne Relic
		168186,	 -- Highborne Relic
		166252,	 -- Looted Titan Relic
		166246,	 -- Highborne Relic
		162630,	 -- Sandy Ornate Relic
		159350,	 -- Ashenwood Relic
		153546,	 -- Sethrak Relic
		153349,	 -- Drust Relic
		152994,	 -- Stolen Tortollan Relic
		152787,	 -- Relic of the Keepers
		152704,	 -- "Relic of the Makers"
		152685,	 -- Is it a Rock? How to Identify Relics
		151202,	 -- Ancient Titan Relics
	},
	[7] = { 	-- Legion
		147561,	 -- Relic of Demonic Influence
		139878,	 -- Relic of the Ebon Blade
		139836,	 -- Shadow Relic
		139783,	 -- Weathered Relic
		138151,	 -- Crate of Ancient Relics
		136822,	 -- Stolen Nar'thalas Relic
	},
	[6] = { 	-- WoD
		118100, -- Highmaul Relic
		117492, -- Relic of Rukhmar
	},
	[5] = { 	-- MoP
		90816,	 -- Relic of the Thunder King
		90815,	 -- Relic of Guo-Lai
		82867,	 -- Mantid Relic
		80294,	 -- Mogu Relic
		79049,	 -- Serpentrider Relic
	},
	[4] = { 	-- Cataclysm
		64675,	 -- Starfall Relic
		63081,	 -- Relic of the Sun King
		55971,	 -- Eldre'thar Relic
		44830,	 -- Highborne Relic
	},
	[3] = { 	-- WolTK
		42780,	 -- Relic of Ulduar
		38677,	 -- Har'koan Relic
		38266,	 -- Rotund Relic
		34814,	 -- Tuskarr Relic
	},
	[2] = { 	-- BC
		32509,	 -- Netherwing Relic
		23779,	 -- Ancient Relic
		23642,	 -- Sha'naar Relic
	},
	[1] = { 	-- Classic
		11078,	 -- Relic Coffer Key
		5360,	 -- Highborne Relic
		5273,	 -- Mathystra Relic
	},
}
items.others = {
	[10] = { -- Dragonflight
		187617, -- Tempered Djaradin Steel
		187621, -- Writ of Construction
		190340, -- Plainshunter's Supplies
		191211, -- Wurmling Bones
		191251, -- Key Fragments
		191552, -- Expedition Metal Detector
		191667, -- Aged Key
		191848, -- Draconium Angle Iron
		191849, -- Serevite Angle Iron
		191850, -- Broken Serevite Blade Tip
		191851, -- Dull Draconium Weapon Head
		192055, -- Dragon Isles Artifact
		193201, -- Key Framing
		193476, -- Gnoll Tent
		193478, -- Tuskarr Beanbag
		194040, -- Slateskin Hide
		194066, -- Frigid Frostfur Pelt
		194067, -- Festering Carcass
		194068, -- Progenitor Scales
		194076, -- Exotic Resilient Leather
		194077, -- Pristine Adamant Scales
		194097, -- Hunter's Fabulous Treasure
		194122, -- Sour Apple
		194696, -- Recycled Crawler Mine
		194731, -- Illusion Parchment: Magma Missile
		194732, -- Illusion Parchment: Love Charm
		194733, -- Illusion Parchment: Aqua Torrent
		194734, -- Illusion Parchment: Whirling Breeze
		194735, -- Illusion Parchment: Arcane Burst
		194736, -- Illusion Parchment: Chilling Wind
		194737, -- Illusion Parchment: Spell Shield
		194738, -- Illusion Parchment: Shadow Orb
		195884, -- Crystalline Petals
		197708, -- Unstable Matrix Core
		197733, -- Unsustainable Containment Core
		198436, -- Hunting Horseshoe
		198437, -- Caravan Horseshoe
		198563, -- Arcane Spark
		198603, -- Arcane Rune
		198604, -- Arcane Gem
		198651, -- Piece of Scrap
		--198653, -- PH Profession Drop
		198657, -- Forgotten Jewelry Box
		198666, -- Milky Snapflower
		198668, -- Blooming Shallowlily
		198727, -- Expedition Explosives
		198837, -- Curious Hide Scraps
		198841, -- Large Sample of Curious Hide
		199128, -- Skinning Field Notes
		199211, -- Primeval Essence
		199216, -- A Box of Rocks
		199338, -- Copper Coin of the Isles
		199339, -- Silver Coin of the Isles
		199340, -- Gold Coin of the Isles
		199646, -- Imbu Tuskarr Bandages
		199906, -- Titan Relic
		200071, -- Sacred Tuskarr Totem
		200093, -- Centaur Hunting Trophy
		200295, -- Makko's Complete Journal
		200443, -- Dragon Isles Artifact
		200447, -- Centaur Hunting Trophy
		200449, -- Sacred Tuskarr Totem
		200450, -- Titan Relic
		200636, -- Primal Invocation Quintessence
		200640, -- Obsidian Egg Clutch
		200944, -- Djaradin's Trophy Mask
		200951, -- Valdrakken Critter Snacks
		201023, -- Draconic Treatise on Skinning
		201411, -- Ancient Vault Artifact
		201412, -- Ancient Vault Artifact
		201418, -- Orb of the Obsidian Scale
		201421, -- Tuskarr Jerky
		201437, -- Slumbering Dream Fragment
		201714, -- Notebook of Crafting Knowledge
		201718, -- Notebook of Crafting Knowledge
		201729, -- Spiked Horseshoe
		201836, -- Aspects' Token of Merit
		202016, -- Saturated Bone
		202034, -- Flame of Remembrance
		202062, -- Ash Feather
		202072, -- Frigid Floe Fish
		202073, -- Calamitous Carp
		202074, -- Kingfin, the Wise Whiskerfish
		202105, -- Rusted Coin of the Isles
		202107, -- Shadowscrawled Coin
		202173, -- Magmote
		210014, -- Mysterious Ageless Seeds
		210791, -- Fragment of Emberscar
		210792, -- Fragment of Emberscar
		210793, -- Fragment of Emberscar
	},
	[9] = { -- Shadowland
		191031,	 -- Packaged Soul Cinders
		190740,	 -- Automa Integration
		190739,	 -- Provis Wax
		190189,	 -- Sandworn Relic
		190182,	 -- Lovely Regal Pocopoc
		190129,	 -- Serene Pigment
		190128,	 -- Wayward Essence
		190098,	 -- Pepepec
		190096,	 -- Pocobold
		190062,	 -- Wicked Pocopoc
		190061,	 -- Admiral Pocopoc
		190060,	 -- Adventurous Pocopoc
		190059,	 -- Pirate Pocopoc
		190058,	 -- Peaceful Pocopoc
		189865,	 -- Anima Matrix
		189864,	 -- Anima Gossamer
		189544,	 -- Anima Webbing
		189451,	 -- Chef Pocopoc
		188957,	 -- Genesis Mote
		188673,	 -- Timebound Ruminations
		188657,	 -- Mind-Expanding Prism
		188656,	 -- Fractal Thoughtbinder
		188655,	 -- Crystalline Memory Repository
		188654,	 -- Grimoire of Knowledge
		188653,	 -- Grimoire of Knowledge
		188652,	 -- Grimoire of Knowledge
		188651,	 -- Grimoire of Knowledge
		188650,	 -- Grimoire of Knowledge
		188198,	 -- Traveler's Anima Cache
		--188168,	 -- zzOld Traveler's Anima Cache
		188005,	 -- Anima-Bathed Blade
		188004,	 -- Crate of Anima-Infused Parts
		188003,	 -- Crate of Revendreth Reserve
		188000,	 -- Grovetender's Pack
		187936,	 -- Mark of the Sable Ardenmoth
		187934,	 -- Mark of the Midnight Runestag
		187933,	 -- Mark of the Duskwing Raven
		187931,	 -- Mark of the Regal Dredbat
		187909,	 -- Unstable Containment Trap
		187908,	 -- Firim's Spare Forge-Tap
		187894,	 -- Energized Firmament
		187893,	 -- Volatile Precursor
		187892,	 -- Incorporeal Sand
		187891,	 -- Empyrean Essence
		187890,	 -- Anima-Charged Yolk
		187889,	 -- Unstable Agitant
		187888,	 -- Mark of the Shimmering Ardenmoth
		187887,	 -- Mark of the Gloomstalker Dredbat
		187885,	 -- Honeycombed Lattice
		187884,	 -- Mark of the Twilight Runestag
		187879,	 -- Pollinated Extraction
		187833,	 -- Dapper Pocopoc
		187822,	 -- A Defector's Request
		187791,	 -- Kismetric Circlet
		187790,	 -- Trace Enigmet
		187789,	 -- Eidolic Particles
		187728,	 -- Ephemera Strands
		187517,	 -- Animaswell Prism
		187478,	 -- White Razorwing Talon
		187467,	 -- Perplexing Rune-Cube
		187466,	 -- Korthian Cypher Book
		187465,	 -- Complicated Organism Harmonizer
		187463,	 -- Enigmatic Map Fragments
		187462,	 -- Scroll of Shadowlands Fables
		187460,	 -- Strangely Intricate Key
		187459,	 -- Vial of Mysterious Liquid
		187458,	 -- Unearthed Teleporter Sigil
		187457,	 -- Engraved Glass Pane
		187434,	 -- Lightseed Sapling
		187433,	 -- Windcrystal Chimes
		187432,	 -- Magifocus Heartwood
		187421,	 -- Ashen Liniment
		187415,	 -- Mind-Expanding Prism
		187414,	 -- Fractal Thoughtbinder
		187413,	 -- Crystalline Memory Repository
		187350,	 -- Displaced Relic
		187349,	 -- Anima Laden Egg
		187347,	 -- Concentrated Anima
		187336,	 -- Forbidden Weapon Schematics
		187335,	 -- Maldraxxus Larva Shell
		187334,	 -- Shattered Void Tablet
		187333,	 -- Core of an Unknown Titan
		187332,	 -- Recovered Page of Voices
		187331,	 -- Tattered Fae Designs
		187330,	 -- Naaru Shard Fragment
		187329,	 -- Old God Specimen Jar
		187328,	 -- Ripped Cosmology Chart
		187327,	 -- Encrypted Korthian Journal
		187326,	 -- Half-Completed Runeforge Pattern
		187325,	 -- Faded Razorwing Anatomy Illustration
		187324,	 -- Gnawed Ancient Idol
		187323,	 -- Runic Diagram
		187322,	 -- Crumbling Stone Tablet
		187311,	 -- Azgoth's Tattered Maps
		187219,	 -- Attendant's Token of Merit
		187175,	 -- Runekeeper's Ingot
		187153,	 -- Tasty Mawshroom
		--187112,	 -- Packaged Soul Ash (DNT)
		187077,	 -- Packaged Soul Ash
		187054,	 -- Lost Razorwing Egg
		186731,	 -- Repaired Riftkey
		186718,	 -- Teleporter Repair Kit
		186685,	 -- Relic Fragment
		186599,	 -- Stygian Ember
		186519,	 -- Compressed Anima Bubble
		186206,	 -- Vault Emberstone
		186205,	 -- Scholarly Attendant's Bangle
		186204,	 -- Anima-Stained Glass Shards
		186203,	 -- Glowing Devourer Stomach
		186202,	 -- Wafting Koricone
		186201,	 -- Ancient Anima Vessel
		186200,	 -- Infused Dendrite
		185974,	 -- Bahmeht Chain Link
		184777,	 -- Gravedredger's Shovel
		184776,	 -- Urn of Arena Soil
		184775,	 -- Necromancy for the Practical Ritualist
		184774,	 -- Juvenile Sporespindle
		184773,	 -- Battle-Tested Armor Component
		184772,	 -- Ritual Maldracite Crystal
		184771,	 -- Remembrance Parchment Ash
		184770,	 -- Roster of the Forgotten
		184769,	 -- Pressed Torchlily Blossom
		184768,	 -- Censer of Dried Gracepetals
		184767,	 -- Handheld Soul Mirror
		184766,	 -- Chronicles of the Paragons
		184765,	 -- Vesper Strikehammer
		184764,	 -- Colossus Actuator
		184763,	 -- Mnemis Neural Network
		184762,	 -- Fragmented Sorrow
		184761,	 -- Purified Misery
		184760,	 -- Quiescent Orb
		184688,	 -- Grimoire of Knowledge
		184687,	 -- Grimoire of Knowledge
		184686,	 -- Grimoire of Knowledge
		184685,	 -- Grimoire of Knowledge
		184684,	 -- Grimoire of Knowledge
		184519,	 -- Totem of Stolen Mojo
		184485,	 -- Mawforged Key
		184389,	 -- Slumbering Starseed
		184388,	 -- Plump Glitterroot
		184387,	 -- Misty Shimmerleaf
		184386,	 -- Nascent Sporepod
		184385,	 -- Fossilized Heartwood
		184384,	 -- Hibernal Sproutling
		184383,	 -- Duskfall Tuber
		184382,	 -- Luminous Sylberry
		184381,	 -- Astral Sapwood
		184380,	 -- Starblossom Nectar
		184379,	 -- Queen's Frozen Tear
		184378,	 -- Faeweald Amber
		184374,	 -- Cartel Exchange Vessel
		184373,	 -- Small Anima Globe
		184371,	 -- Vivacity of Collaboration
		184363,	 -- Considerations on Courage
		184362,	 -- Reflections on Purity
		184360,	 -- Musings on Repetition
		184354,	 -- Soul Harvester Key
		184315,	 -- Multi-Modal Anima Container
		184307,	 -- Maldraxxi Armor Scraps
		184306,	 -- Soulcatching Sludge
		184305,	 -- Maldraxxi Champion's Armaments
		184294,	 -- Ethereal Ambrosia
		184293,	 -- Sanctified Skylight Leaf
		184286,	 -- Extinguished Soul Anima
		184169,	 -- Vault Chain Pull
		184152,	 -- Bottle of Diluted Anima-Wine
		184151,	 -- Counterfeit Ruby Brooch
		184150,	 -- Bonded Tallow Candles
		184149,	 -- Widowbloom-Infused Fragrance
		184148,	 -- Concealed Sinvyr Flask
		184147,	 -- Agony Enrichment Device
		184146,	 -- Singed Soul Shackles
		184051,	 -- Stitched Lich Effigy
		184050,	 -- Malleable Mesh
		184049,	 -- Counterfeit Luckydo
		184043,	 -- Lost Scroll
		183987,	 -- Prisoner Cage Key
		183939,	 -- Carefully Bottled Holy Water
		183873,	 -- Otherworldy Tea Set
		183804,	 -- Great Luckydo
		183790,	 -- Platter Master Stue
		183744,	 -- Superior Parts
		183734,	 -- Mysteriously Thrumming Orb
		183727,	 -- Resonance of Conflict
		183723,	 -- Brimming Anima Orb
		183596,	 -- Broken Artifact
		183519,	 -- Necromantic Oil
		183475,	 -- Indomitable Hide
		183200,	 -- Pitch Black Scourgestone
		182654,	 -- Bonescript Dispatches
		182599,	 -- Bucket of Clean Water
		182597,	 -- Comfortable Saddle Blanket
		182595,	 -- Sturdy Horseshoe
		182581,	 -- Handful of Oats
		182212,	 -- Magical Curio
		182211,	 -- Stone Brick
		182186,	 -- Stolen Memento
		181745,	 -- Forgesmith's Coal
		181744,	 -- Forgelite Ember
		181743,	 -- Plume of the Archon
		181650,	 -- Spellwarded Dissertation
		181649,	 -- Preserved Preternatural Braincase
		181648,	 -- Ziggurat Focusing Crystal
		181647,	 -- Stabilized Plague Strain
		181646,	 -- Bound Failsafe Phylactery
		181645,	 -- Engorged Monstrosity's Heart
		181644,	 -- Unlabeled Culture Jars
		181643,	 -- Weeping Corpseshroom
		181642,	 -- Novice Principles of Plaguistry
		181552,	 -- Collected Tithe
		181551,	 -- Depleted Stoneborn Heart
		181550,	 -- Hopebreaker's Field Injector
		181549,	 -- Timeworn Sinstone
		181548,	 -- Darkhaven Soul Lantern
		181547,	 -- Noble's Draught
		181546,	 -- Mature Cryptbloom
		181545,	 -- Bloodbound Globule
		181544,	 -- Confessions of Misdeed
		181541,	 -- Celestial Acorn
		181540,	 -- Animaflower Bud
		181479,	 -- Starlight Catcher
		181478,	 -- Cornucopia of the Winter Court
		181477,	 -- Ardendew Pearl
		181377,	 -- Illustrated Combat Meditation Aid
		181371,	 -- Spare Head
		181368,	 -- Centurion Power Core
		181166,	 -- Sigil of Haunting Memories
		180852,	 -- Granule of Stygia
		180834,	 -- Renathal's Journal Pages
		180720,	 -- Darkened Scourgestone
		180595,	 -- Nightforged Steel
		180594,	 -- Calloused Bone
		--180531,	 -- [PH] Twisted Dust
		--180483,	 -- [PH] Legendary Dust
		180478,	 -- Champion's Pelt
		180477,	 -- Elysian Feathers
		180470,	 -- Wild Fungus
		180451,	 -- Grand Inquisitor's Sinstone Fragment
		180296,	 -- Shrouded Necromancer Head
		179939,	 -- Wriggling Spider Sac
		179928,	 -- Cell Chain Pull
		179295,	 -- Squeaky Bat
		178594,	 -- Anima-bound Wraps
		178061,	 -- Malleable Flesh
		177764,	 -- Mirror Fragment
		177665,	 -- Spectral Handkerchief
		176804,	 -- Temp
		175752,	 -- Mirror Fragment
		172965,	 -- Sinstone Fragments
		171206,	 -- Forgotten Weapon
	},
	[8] = { -- BfA
		175056,	 -- Waterborne Veterans Contract
		175054,	 -- Melee Veterans Contract
		175053,	 -- Ranged Veterans Contract
		175052,	 -- Mounted Veterans Contract
		175019,	 -- Holy Statuette
		175018,	 -- Shadowy Rune
		175017,	 -- Volatile Ember
		174971,	 -- Ripe Juicycrunch
		174970,	 -- Easeflower
		174891,	 -- Veteran Rajani Sparkcallers Contract
		174890,	 -- Veteran Ramkahen Lancers Contract
		174867,	 -- Shard of Corruption
		174858,	 -- Gersahl Greens
		174764,	 -- Tol'vir Relic Fragment
		174760,	 -- Mantid Relic Fragment
		174759,	 -- Mogu Relic Fragment
		174758,	 -- Voidwarped Relic Fragment
		174360,	 -- Shadowy Gem
		174049,	 -- Orb of Darkest Madness
		174048,	 -- Orb of Madness
		174047,	 -- Orb of Darkest Visions
		174046,	 -- Orb of Visions
		174045,	 -- Orb of Dark Portents
		171372,	 -- Alterac Valley Mark of Honor
		171347,	 -- Corrupted Bone Fragment
		171334,	 -- Void-Touched Cloth
		170500,	 -- Energy Cell
		170491,	 -- Burnt Journal Page
		170379,	 -- Sunwarmed Sand
		170193,	 -- Sea Totem
		170174,	 -- Muck Slime
		170170,	 -- Fermented Deviate Fish
		169898,	 -- Well Lurker
		169897,	 -- Thin Air Flounder
		169884,	 -- Green Roughy
		169870,	 -- Displaced Scrapfin
		169765,	 -- Worldvein Intelligence Reports
		169764,	 -- Worldvein Intelligence Reports
		169680,	 -- Coalescing Blood of the Vanquished
		169665,	 -- Cleansed Remains
		169610,	 -- S.P.A.R.E. Crate
		169334,	 -- Strange Oceanic Sediment
		169333,	 -- Strange Volcanic Rock
		169332,	 -- Strange Mineralized Water
		169295,	 -- Dormant Vision Stone
		169293,	 -- Coalescing Visions
		169106,	 -- Thin Jelly
		168832,	 -- Galvanic Oscillator
		168828,	 -- Royal Jelly
		168825,	 -- Rich Jelly
		168822,	 -- Thin Jelly
		168802,	 -- Nazjatar Battle Commendation
		168630,	 -- Chitterspine Meat
		168327,	 -- Chain Ignitercoil
		168160,	 -- Jeweled Scarab Figurine
		168152,	 -- Miniaturized Power Core
		168142,	 -- Coagulated Miasma
		168139,	 -- Long Regal Sinew
		168138,	 -- Spirit of the Bested
		168135,	 -- Titan's Blood
		168134,	 -- Fine Azerite Powder
		168127,	 -- Lingering Drust Essence
		167730,	 -- Inconspicuous Catfish
		167729,	 -- Deceptive Maw
		167728,	 -- Queen's Delight
		167727,	 -- Deadeye Wally
		167726,	 -- Quiet Floater
		167725,	 -- Spiritual Salmon
		167724,	 -- Tortollan Tank Dweller
		167723,	 -- Thunderous Flounder
		167722,	 -- Prisoner Fish
		167721,	 -- Invisible Smelt
		167720,	 -- Very Tiny Whale
		167719,	 -- Golden Sunsoaker
		167718,	 -- Collectable Saltfin
		167717,	 -- Camouflaged Snark
		167716,	 -- Unseen Mimmic
		167715,	 -- Elusive Moonfish
		167714,	 -- Travelling Goby
		167713,	 -- Veiled Ghost
		167712,	 -- Rotted Blood Cod
		167711,	 -- Dead Fel Bone
		167710,	 -- Barbed Fjord Fin
		167709,	 -- Drowned Goldfish
		167708,	 -- Ancient Mana Fin
		167707,	 -- Kirin Tor Clown
		167706,	 -- Jade Story Fish
		167705,	 -- Mechanized Mackerel
		167562,	 -- Ionized Minnow
		167062,	 -- Armored Vaultbot Key
		166971,	 -- Empty Energy Cell
		166970,	 -- Energy Cell
		166885,	 -- Mark of Azshara
		166846,	 -- Spare Parts
		165835,	 -- Pristine Gizmo
		164942,	 -- Shadowscrawled Tome
		163205,	 -- Ghostly Pet Biscuit
		163036,	 -- Polished Pet Charm
		162126,	 -- River Clam Meat
		162029,	 -- Mark of the Humble Flyer
		162027,	 -- Mark of the Tideskipper
		162022,	 -- Mark of the Dolphin
		160744,	 -- Pristine Blowgun of the Sethrak
		160743,	 -- Blowgun of the Sethra
		160742,	 -- Pristine Soul Coffer
		160741,	 -- Soul Coffer
		160438,	 -- Seafarer's Dubloon
		158931,	 -- Ecto-dimensional Proton Beam
		158906,	 -- Shimmerfin Flesh
		157781,	 -- Extra-Chunky Dino Food
		157780,	 -- Free-Range Dino Chow
		157779,	 -- Infant Dino Kibble
		--155012,	 -- REUSE ME (DNT)
		--155011,	 -- REUSE ME (DNT)
		--155010,	 -- REUSE ME (DNT)
		154935,	 -- Pristine Bwonsamdi Voodoo Mask
		154934,	 -- Pristine High Apothecary's Hood
		154933,	 -- Pristine Rezan Idol
		154932,	 -- Pristine Urn of Passage
		154931,	 -- Pristine Akun'Jar Vase
		154930,	 -- Pristine Ritual Fetish
		154929,	 -- Pristine Jagged Blade of the Drust
		154928,	 -- Pristine Disembowling Sickle
		154927,	 -- Pristine Ancient Runebound Tome
		154926,	 -- Pristine Ceremonial Bonesaw
		154925,	 -- Ritual Fetish
		154924,	 -- Jagged Blade of the Drust
		154923,	 -- Disembowling Sickle
		154922,	 -- Ancient Runebound Tome
		154921,	 -- Ceremonial Bonesaw
		154917,	 -- Bwonsamdi Voodoo Mask
		154916,	 -- High Apothecary's Hood
		154915,	 -- Rezan Idol
		154914,	 -- Urn of Passage
		154913,	 -- Akun'Jar Vase
		153647,	 -- Tome of the Quiet Mind
	},
	[7] = { 	-- Legion
		153006,	 -- Grimoire of Lost Knowledge
		152999,	 -- Imp Meat
		152097,	 -- Lightforged Bulwark
		152096,	 -- Void-Purged Krokul
		152095,	 -- Krokul Ridgestalker
		151760,	 -- Spelled Poster of Devlynn Styx
		151759,	 -- Signed Photo of Jon Graves
		151758,	 -- Metal Plate Portrait of Cage Head
		151757,	 -- Limited Run Blight Boar Poster
		151756,	 -- Foil Blighthead Fan Club Card
		151755,	 -- Pair of Signed Drumsticks
		151754,	 -- Gold Plated Cage Head Key
		151753,	 -- Perpetually Glowing Blight Boar Statue
		151481,	 -- Cage Head Key
		151479,	 -- Signed Blight Boar Poster
		151478,	 -- Blight Boar Statue
		151473,	 -- Blighthead Fan Club Membership Card
		151383,	 -- Fiddlesticks Signed Drumstick
		151382,	 -- Autographed Portrait of Cage Head
		151381,	 -- Framed Photo of Jon Graves
		151380,	 -- Autographed Poster of Devlyn Styx
		151191,	 -- Old Bottle Cap
		151165,	 -- Verbellin Tourbillon Chronometer
		151164,	 -- Sparkling Sin'dorei Signet
		151163,	 -- Locket of Magical Memories
		151162,	 -- Glitzy Mana-Chain
		151161,	 -- Subtle Chronometer
		151160,	 -- Elegant Manabraid
		151159,	 -- Managraphic Card
		151158,	 -- Manaforged Worry-Chain
		151157,	 -- Flashy Chronometer
		151156,	 -- Manaweft Bracelet
		151155,	 -- Mana-Etched Signet
		151154,	 -- Managleam Pendant
		151153,	 -- Glinting Manaseal
		151152,	 -- Star-Etched Ring
		151151,	 -- Tacky Chronometer
		151150,	 -- Charmed Bracelet
		151149,	 -- Charmed Ring
		151148,	 -- Charmed Choker
		151147,	 -- Charmed Pendant
		151146,	 -- Charmed Band
		151115,	 -- Mana-Cloaked Choker
		146963,	 -- Desecrated Seaweed
		146962,	 -- Golden Minnow
		146961,	 -- Shiny Bauble
		146960,	 -- Ancient Totem Fragment
		146959,	 -- Corrupted Globule
		146848,	 -- Fragmented Enchantment
		143852,	 -- Lucky Rabbit's Foot
		143850,	 -- Summon Grimtotem Warrior
		143849,	 -- Summon Royal Guard
		143785,	 -- Tome of the Tranquil Mind
		143780,	 -- Tome of the Tranquil Mind
		143605,	 -- Strange Ball of Energy
		143326,	 -- Stone of Jordan
		142366,	 -- Regurgitated Leaf
		142364,	 -- Bag of Twigs
		142262,	 -- Electrified Key
		142209,	 -- Dinner Invitation
		141640,	 -- Tome of the Clear Mind
		141446,	 -- Tome of the Tranquil Mind
		141028,	 -- Grimoire of Knowledge
		141022,	 -- Legion Ammunition
		141005,	 -- Vial of Hippogryph Pheromones
		140933,	 -- Runed Aspirant's Band
		140932,	 -- Earthen Mark
		140931,	 -- Bandit Wanted Poster
		140930,	 -- Acolyte's Vows
		140929,	 -- Squire's Oath
		140928,	 -- Ox Initiate's Pledge
		140927,	 -- Water Globe
		140926,	 -- Bowmen's Orders
		140925,	 -- Enchanted Bark
		140924,	 -- Ashtongue Beacon
		140923,	 -- Ghoul Tombstone
		140922,	 -- Imp Pact
		140767,	 -- Pile of Bits and Bones
		140760,	 -- Libram of Truth
		140749,	 -- Horn of Winter
		140630,	 -- Mark of the Doe
		140397,	 -- G'Hanir's Blossom
		140394,	 -- Thornstalk Barbs
		140199,	 -- Nightshard
		140156,	 -- Blessing of the Order
		139785,	 -- Tales of the Broken Isles
		139783,	 -- Weathered Relic
		139670,	 -- Scream of the Dead
		139428,	 -- A Master Plan
		139420,	 -- Wild Mushroom
		139419,	 -- Golden Banana
		139418,	 -- Healing Stream Totem
		139389,	 -- Charred Locket
		139376,	 -- Healing Well
		139177,	 -- Shattered Soul
		138883,	 -- Meryl's Conjured Refreshment
		138777,	 -- Drowned Mana
		138412,	 -- Iresoul's Healthstone
		138410,	 -- Summoning Portal
		138116,	 -- Throwing Torch
		138114,	 -- Gloaming Frenzy
		138099,	 -- Skyfire Stone
		137642,	 -- Mark of Honor
		137617,	 -- Researcher's Notes
		137604,	 -- Unstable Riftstone
		134860,	 -- Peddlefeet's Buffing Creme
		134824,	 -- "Sir Pugsington" Costume
		132982,	 -- Sonic Environment Enhancer
		130920,	 -- Houndstooth Hauberk
		130919,	 -- Orb of Inner Chaos
		130918,	 -- Malformed Abyssal
		130917,	 -- Flayed-Skin Chronicle
		130916,	 -- Imp's Cup
		130915,	 -- Stonewood Bow
		130914,	 -- Drogbar Gem-Roller
		130913,	 -- Hand-Smoothed Pyrestone
		130912,	 -- Moosebone Fish-Hook
		130911,	 -- Trailhead Drum
		130910,	 -- Nobleman's Letter Opener
		130909,	 -- Pre-War Highborne Tapestry
		130908,	 -- Quietwine Vial
		130907,	 -- Inert Leystone Charm
		130906,	 -- Violetglass Vessel
		129742,	 -- Badge of Timewalking Justice
		129734,	 -- Potion of Cowardly Flight
		129021,	 -- Mark of the Sentinel
		128379,	 -- Piece of Meat
		128368,	 -- Dripping Fangs of Goremaw
		127009,	 -- Fragment of Frostmourne
	},
	[6] = { 	-- WoD
		128659,	 -- Merry Supplies
		128658,	 -- Spooky Supplies
		128650,	 -- "Merry Munchkin" Costume
		128373,	 -- Rush Order: Shipyard
		127409,	 -- Sculpted Memorial Urn
		127407,	 -- Lava Prism Ring
		127406,	 -- Lovingly Polished Nose Ring
		127404,	 -- Limited-Edition Choker
		127402,	 -- Limited-Edition Choker
		127400,	 -- Wax-Daubed Signet
		127398,	 -- Locket of Precious Memories
		127272,	 -- Rickety Glider
		127115,	 -- Tome of Chaos
		124099,	 -- Blackfang Claw
		122618,	 -- Misprinted Draenic Coin
		122606,	 -- Explorer's Notebook
		122596,	 -- Rush Order: The Tannery
		122595,	 -- Rush Order: The Forge
		122594,	 -- Rush Order: Tailoring Emporium
		122593,	 -- Rush Order: Scribe's Quarters
		122592,	 -- Rush Order: Gem Boutique
		122591,	 -- Rush Order: Engineering Works
		122590,	 -- Rush Order: Enchanter's Study
		122584,	 -- Winning with Wildlings
		122583,	 -- Grease Monkey Guide
		122582,	 -- Guide to Arakkoa Relations
		122580,	 -- Ogre Buddy Handbook
		122576,	 -- Rush Order: Alchemy Lab
		122514,	 -- Mission Completion Orders
		122503,	 -- Rush Order: Mine Shipment
		122502,	 -- Rush Order: Mine Shipment
		122501,	 -- Rush Order: Goblin Workshop
		122500,	 -- Rush Order: Gnomish Gearworks
		122497,	 -- Rush Order: Garden Shipment
		122496,	 -- Rush Order: Garden Shipment
		122491,	 -- Rush Order: War Mill
		122490,	 -- Rush Order: Dwarven Bunker
		122487,	 -- Rush Order: Gladiator's Sanctum
		122398,	 -- Garrison Scout Report
		122307,	 -- Rush Order: Barn
		122274,	 -- Tome of Knowledge
		122273,	 -- Follower Trait Retraining Guide
		122272,	 -- Follower Ability Retraining Manual
		120172,	 -- Vileclaw's Claw
		119819,	 -- Caged Mighty Clefthoof
		119817,	 -- Caged Mighty Riverbeast
		119815,	 -- Caged Mighty Wolf
		119814,	 -- Leathery Caged Beast
		119813,	 -- Furry Caged Beast
		119810,	 -- Meaty Caged Beast
		119185,	 -- Expired Receipt
		119102,	 -- Partial Receipt: True Iron Door Handles
		119101,	 -- Partial Receipt: Invisible Dust
		119100,	 -- Partial Receipt: Pickled Red Herring
		119099,	 -- Partial Receipt: Chainmail Socks
		119098,	 -- Partial Receipt: Druidskin Rug
		119097,	 -- Partial Receipt: Gently-Used Bandages
		119096,	 -- Partial Receipt: Book of Troll Poetry
		119095,	 -- Partial Receipt: Tailored Underwear
		119094,	 -- Partial Receipt: Flask of Funk
		118698,	 -- Wings of the Outcasts
		118661,	 -- Xelganak's Stinger
		118660,	 -- Thek'talon's Talon
		118659,	 -- Mu'gra's Head
		118658,	 -- Gagrog's Skull
		118657,	 -- Direhoof's Hide
		118656,	 -- Dekorhan's Tusk
		118655,	 -- Bergruu's Horn
		118654,	 -- Aogexon's Fang
		118593,	 -- Merchant Card
		118592,	 -- Partial Receipt: Gizmothingies
		118474,	 -- Supreme Manual of Dance
		118354,	 -- Follower Retraining Certificate
		118100,	 -- Highmaul Relic
		118099,	 -- Gorian Artifact Fragment
		118067,	 -- Bartering Chip
		118043,	 -- Broken Bones
		117491,	 -- Ogre Waystone
		117397,	 -- Nat's Lucky Coin
		117390,	 -- Draenor Archaeologist's Map
		117389,	 -- Draenor Archaeologist's Lodestone
		117009,	 -- Nomad's Spiked Tent
		117008,	 -- Voodoo Doctor's Hovel
		117007,	 -- Ornate Horde Tent
		117006,	 -- Ornate Alliance Tent
		117005,	 -- Distressingly Furry Tent
		117004,	 -- Simple Tent
		117003,	 -- Orgrimmar's Reach
		117002,	 -- Elune's Retreat
		117001,	 -- Patchwork Hut
		117000,	 -- Deathweaver's Hovel
		116998,	 -- High Elven Tent
		116997,	 -- Blood Elven Tent
		116996,	 -- Crusader's Tent
		116995,	 -- Sturdy Tent
		116994,	 -- Brute's Tent
		116993,	 -- Archmage's Tent
		116992,	 -- Savage Leather Tent
		116991,	 -- Enchanter's Tent
		116990,	 -- Outcast's Tent
		116989,	 -- Ironskin Tent
		116988,	 -- Fine Blue and Green Tent
		116987,	 -- Fine Blue and Purple Tent
		116986,	 -- Fine Blue and Gold Tent
		116452,	 -- Spring-loaded Spike Trap
		116441,	 -- Highly Enriched Blixtherium Shells
		116415,	 -- Shiny Pet Charm
		116392,	 -- Big Bag of Booty
		116172,	 -- Perky Blaster
		116158,	 -- Lunarfall Carp
		116141,	 -- Warspear Prison Key
		116140,	 -- Stormshield Prison Key
		116122,	 -- Burning Legion Missive
		115981,	 -- Abrogator Stone Cluster
		115346,	 -- Horde Supply Chest Key
		115345,	 -- Alliance Supply Chest Key
		115280,	 -- Abrogator Stone
		114207,	 -- Beakbreaker of Terokk
		114206,	 -- Apexis Scroll
		114205,	 -- Apexis Hieroglyph
		114204,	 -- Apexis Crystal
		114203,	 -- Outcast Dreamcatcher
		114202,	 -- Talonpriest Mask
		114201,	 -- Sundial
		114200,	 -- Solar Orb
		114199,	 -- Decree Scrolls
		114198,	 -- Burial Urn
		114197,	 -- Dreamcatcher
		114196,	 -- Warmaul of the Warmaul Chieftain
		114195,	 -- Sorcerer-King Toe Ring
		114194,	 -- Imperial Decree Stele
		114193,	 -- Rylak Riding Harness
		114192,	 -- Stone Dentures
		114191,	 -- Eye of Har'gunn the Blind
		114190,	 -- Mortar and Pestle
		114189,	 -- Gladiator's Shield
		114187,	 -- Pictogram Carving
		114185,	 -- Ogre Figurine
		114183,	 -- Stone Manacles
		114181,	 -- Stonemaul Succession Stone
		114179,	 -- Headdress of the First Shaman
		114177,	 -- Doomsday Prophecy
		114175,	 -- Gronn-Tooth Necklace
		114173,	 -- Flask of Blazegrease
		114171,	 -- Ancestral Talisman
		114169,	 -- Cracked Ivory Idol
		114167,	 -- Ceremonial Tattoo Needles
		114165,	 -- Calcified Eye In a Jar
		114163,	 -- Barbed Fishing Hook
		114161,	 -- Hooked Dagger
		114159,	 -- Weighted Chopping Axe
		114157,	 -- Blackrock Razor
		114155,	 -- Elemental Bellows
		114153,	 -- Metalworker's Hammer
		114151,	 -- Warsong Ceremonial Pike
		114149,	 -- Screaming Bullroarer
		114147,	 -- Warsinger's Drums
		114145,	 -- Wolfskin Snowshoes
		114143,	 -- Frostwolf Ancestry Scrimshaw
		114141,	 -- Fang-Scarred Frostwolf Axe
		113499,	 -- Notes of Natural Cures
		113495,	 -- Venom Extraction Kit
		113483,	 -- Lightweight Medic Vest
		113478,	 -- Abandoned Medic Kit
		113471,	 -- Busted Alarm Bot
		113468,	 -- Faulty Grenade
		113465,	 -- Broken Hunting Scope
		113452,	 -- Trampled Survey Bot
		113429,	 -- Cracked Hand Drum
		113426,	 -- Mangled Saddle Bag
		113423,	 -- Scorched Leather Cap
		113420,	 -- Desiccated Leather Cloak
		113417,	 -- Torn Knapsack
		113411,	 -- Bloodstained Mage Robe
		113394,	 -- Headless Figurine
		113391,	 -- Crystal Shards
		113387,	 -- Cracked Band
		113384,	 -- Crushed Locket
		113381,	 -- Crumbling Statue
		113376,	 -- Faintly Magical Vellum
		113371,	 -- Torn Card
		113367,	 -- Waterlogged Book
		113365,	 -- Ruined Painting
		113361,	 -- Tattered Scroll
		113358,	 -- Felled Totem
		113336,	 -- Gnarled, Splintering Staff
		113332,	 -- Cracked Wand
		113329,	 -- Ripped Lace Kerchief
		113328,	 -- Torn Voodoo Doll
		113327,	 -- Weathered Bedroll
		113324,	 -- Ritual Mask Shards
		113321,	 -- Battered Shield
		113316,	 -- Mangled Long Sword
		113313,	 -- Unorganized Alchemist Notes
		113310,	 -- Unstable Elixir
		113307,	 -- Impotent Healing Potion
		113295,	 -- Cracked Potion Vial
		113245,	 -- Shredded Greaves
		113244,	 -- Soleless Treads
		113203,	 -- Punctured Breastplate
		113008,	 -- Glowing Ancestral Idol
		113007,	 -- Magma-Infused War Beads
		113006,	 -- Choker of Nightmares
		113005,	 -- Chain of Hopes
		113004,	 -- Locket of Dreams
		113003,	 -- Opal Amulet
		113002,	 -- Ruby Amulet
		113001,	 -- Sparkling Amulet
		113000,	 -- Oozing Amulet
		112999,	 -- Sapphire Ring
		112998,	 -- Diamond Ring
		112997,	 -- Emerald Ring
		112996,	 -- Glistening Ring
		112995,	 -- Slimy Ring
		112633,	 -- Frostdeep Minnow
		112376,	 -- Target Practice Axe
		112322,	 -- Complicated Wood
		109739,	 -- Star Chart
		108882,	 -- Bloodmaul Blasting Charge
		107645,	 -- Iron Horde Weapon Cache
	},
	[5] = { 	-- MoP
		97268,	 -- Tome of Valor
		95623,	 -- Sunreaver Bounty
		95622,	 -- Arcane Trove
		95497,	 -- Burial Trove Key
		95491,	 -- Tattered Historical Parchments
		95382,	 -- Kypari Sap Container
		95381,	 -- Pollen Collector
		95380,	 -- Mantid Lamp
		95379,	 -- Remains of a Paragon
		95378,	 -- Inert Sound Beacon
		95377,	 -- The Praying Mantid
		95376,	 -- Ancient Sap Feeder
		95375,	 -- Banner of the Mantid Empire
		94594,	 -- Titan Runestone
		94593,	 -- Secrets of the Empire
		94536,	 -- Intact Direhorn Hide
		94222,	 -- Key to the Palace of Lei Shen
		93738,	 -- Rusty Prison Key
		92750,	 -- Jungle Hops
		92745,	 -- Liquid Fire
		92743,	 -- Krasari Iron
		92739,	 -- Misplaced Keg
		92625,	 -- Theldren's Rusted Runeblade
		92624,	 -- Theldren's Rusted Runeblade
		92623,	 -- Ancient Orcish Shield
		92622,	 -- Ancient Orcish Shield
		92620,	 -- Elysia's Bindings
		92619,	 -- Ornate Portrait
		92618,	 -- Ornate Portrait
		92617,	 -- Golden Fruit Bowl
		92616,	 -- Golden Fruit Bowl
		92615,	 -- Taric's Family Jewels
		92614,	 -- Taric's Family Jewels
		92613,	 -- Zena's Ridiculously Rich Yarnball
		92612,	 -- Zena's Ridiculously Rich Yarnball
		92611,	 -- Golden Platter
		92610,	 -- Golden Platter
		92609,	 -- Golden Potion
		92608,	 -- Golden Potion
		92607,	 -- Golden High Elf Statuette
		92606,	 -- Golden High Elf Statuette
		92605,	 -- Golden Goblet
		92604,	 -- Golden Goblet
		92603,	 -- Large Pile of Gold Coins
		92602,	 -- Large Pile of Gold Coins
		92601,	 -- Small Pile of Gold Coins
		92600,	 -- Small Pile of Gold Coins
		92599,	 -- Gold Ring
		92598,	 -- Gold Ring
		92597,	 -- Ruby Ring
		92596,	 -- Ruby Ring
		92595,	 -- Diamond Ring
		92594,	 -- Diamond Ring
		92593,	 -- Spellstone Necklace
		92592,	 -- Spellstone Necklace
		92591,	 -- Ruby Necklace
		92590,	 -- Ruby Necklace
		92589,	 -- Jade Kitten Figurine
		92588,	 -- Jade Kitten Figurine
		92587,	 -- Sparkling Sapphire
		92586,	 -- Sparkling Sapphire
		92585,	 -- Expensive Ruby
		92584,	 -- Expensive Ruby
		92583,	 -- Cheap Cologne
		92582,	 -- Cheap Cologne
		92581,	 -- Fragrant Perfume
		92580,	 -- Fragrant Perfume
		92538,	 -- Unexploded Cannonball
		92470,	 -- Snake Oil
		92444,	 -- Meaty Haunch
		91971,	 -- Battle Rations
		91906,	 -- Brittle Root
		90544,	 -- Sixth Place Valorous Commendation
		90543,	 -- Fifth Place Valorous Commendation
		90541,	 -- Fourth Place Valorous Commendation
		90540,	 -- Third Place Valorous Commendation
		90539,	 -- Second Place Valorous Commendation
		90538,	 -- First Place Valorous Commendation
		90048,	 -- Exquisite Murloc Leash
		89868,	 -- Mark of the Cheetah
		89639,	 -- Desecrated Herb
		89209,	 -- Pristine Monument Ledger
		89185,	 -- Pristine Standard of Niuzao
		89184,	 -- Pristine Pearl of Yu'lon
		89183,	 -- Pristine Apothecary Tins
		89182,	 -- Pristine Gold-Inlaid Figurine
		89181,	 -- Pristine Carved Bronze Mirror
		89180,	 -- Pristine Empty Keg
		89179,	 -- Pristine Walking Cane
		89178,	 -- Pristine Twin Stein Set
		89176,	 -- Pristine Branding Iron
		89175,	 -- Pristine Iron Amulet
		89174,	 -- Pristine Edicts of the Thunder King
		89173,	 -- Pristine Thunder King Insignia
		89172,	 -- Pristine Petrified Bone Whip
		89171,	 -- Pristine Terracotta Arm
		89170,	 -- Pristine Mogu Runestone
		89155,	 -- Onyx Egg
		87898,	 -- Charred Glyph
		87828,	 -- Tigersblood Pigment
		87821,	 -- Coagulated Tiger's Blood
		87806,	 -- Ancient Mogu Key
		87779,	 -- Ancient Guo-Lai Cache Key
		87549,	 -- Lorewalker's Map
		87548,	 -- Lorewalker's Lodestone
		87399,	 -- Restored Artifact
		87209,	 -- Sigil of Wisdom
		87208,	 -- Sigil of Power
		86547,	 -- Skyshard
		85689,	 -- Charred Glyph
		85558,	 -- Pristine Game Board
		85557,	 -- Pristine Pandaren Tea Set
		85477,	 -- Pristine Mogu Coin
		81055,	 -- Darkmoon Ride Ticket
		80546,	 -- Tap Tool
		79917,	 -- Worn Monument Ledger
		79916,	 -- Mogu Coin
		79915,	 -- Warlord's Branding Iron
		79914,	 -- Iron Amulet
		79913,	 -- Edicts of the Thunder King
		79912,	 -- Thunder King Insignia
		79911,	 -- Petrified Bone Whip
		79910,	 -- Terracotta Arm
		79909,	 -- Cracked Mogu Runestone
		79908,	 -- Manacles of Rebellion
		79907,	 -- Spear of Xuen
		79906,	 -- Umbrella of Chi-Ji
		79905,	 -- Standard of Niuzao
		79904,	 -- Pearl of Yu'lon
		79903,	 -- Apothecary Tins
		79902,	 -- Gold-Inlaid Figurine
		79901,	 -- Carved Bronze Mirror
		79900,	 -- Empty Keg
		79899,	 -- Walking Cane
		79898,	 -- Twin Stein Set
		79897,	 -- Pandaren Game Board
		79896,	 -- Pandaren Tea Set
		79268,	 -- Marsh Lily
		79267,	 -- Lovely Apple
		79266,	 -- Jade Cat
		79265,	 -- Blue Feather
		79264,	 -- Ruby Shard
		74622,	 -- Dead Fire Spirit
		104346,	 -- Golden Glider
		104336,	 -- Bubbling Pi'jiu Brew
		104335,	 -- Thick Pi'jiu Brew
		104334,	 -- Misty Pi'jiu Brew
		104297,	 -- Blazing Sigil of Ordos
		104293,	 -- Scuttler's Shell
		104286,	 -- Quivering Firestorm Egg
		103797,	 -- Big Pink Bow
		103795,	 -- "Dread Pirate" Costume
		103789,	 -- "Little Princess" Costume
		103786,	 -- "Dapper Gentleman" Costume
		103684,	 -- Scroll of Challenge
		103683,	 -- Mask of Anger
		103682,	 -- Mask of Violence
		103681,	 -- Mask of Doubt
		103680,	 -- Mask of Hatred
		103679,	 -- Mask of Fear
		103533,	 -- Vicious Saddle
		102464,	 -- Black Ash
		101538,	 -- Kukuru's Cache Key
		101529,	 -- Celestial Coin
	},
	[4] = { 	-- Cataclysm
		78891,	 -- Elementium-Coated Geode
		78890,	 -- Crystalline Geode
		76402,	 -- Greater Scarab Coffer Key
		76401,	 -- Scarab Coffer Key
		71000,	 -- Emberstone Fragment
		70999,	 -- Obsidian-Flecked Chitin Fragment
		70997,	 -- Rhyolite Fragment
		70994,	 -- Pyreshell Fragment
		66058,	 -- Fine Bloodscalp Dinnerware
		66057,	 -- Strange Velvet Worm
		66056,	 -- Shard of Petrified Wood
		66055,	 -- Necklace with Elune Pendant
		66054,	 -- Dwarven Baby Socks
		64659,	 -- Pipe of Franclorn Forgewright
		64658,	 -- Sketch of a Desert Palace
		64656,	 -- Engraved Scimitar Hilt
		64655,	 -- Tiny Oasis Mosaic
		64654,	 -- Soapstone Scarab Necklace
		64653,	 -- Cat Statue with Emerald Eyes
		64652,	 -- Castle of Sand
		64650,	 -- Umbra Crescent
		64648,	 -- Silver Scroll Case
		64647,	 -- Carcanet of the Hundred Magi
		64487,	 -- Scepter of Bronzebeard
		64486,	 -- Word of Empress Zoe
		64485,	 -- Spiked Gauntlets of Anvilrage
		64484,	 -- Warmaul of Burningeye
		64483,	 -- Silver Kris of Korl
		64480,	 -- Vizier's Scrawled Streamer
		64479,	 -- Ewer of Jormungar Blood
		64478,	 -- Six-Clawed Cornice
		64477,	 -- Gruesome Heart Box
		64476,	 -- Infested Ruby Ring
		64475,	 -- Scepter of Nezar'Azret
		64474,	 -- Spidery Sundial
		64473,	 -- Imprint of a Kraken Tentacle
		64468,	 -- Proto-Drake Skeleton
		64467,	 -- Thorned Necklace
		64464,	 -- Fanged Cloak Pin
		64462,	 -- Flint Striker
		64461,	 -- Scramseax
		64459,	 -- Intricate Treasure Chest Key
		64458,	 -- Plated Elekk Goad
		64455,	 -- Dignified Portrait
		64454,	 -- Fine Crystal Candelabra
		64453,	 -- Baroque Sword Scabbard
		64444,	 -- Scepter of the Nathrezim
		64443,	 -- Strange Silver Paperweight
		64442,	 -- Carved Harp of Exotic Wood
		64440,	 -- Anklet with Golden Bells
		64438,	 -- Skull Drinking Cup
		64437,	 -- Tile of Glazed Clay
		64436,	 -- Fiendish Whip
		64421,	 -- Fierce Wolf Figurine
		64420,	 -- Scepter of Nekros Skullcrusher
		64419,	 -- Rusted Steak Knife
		64418,	 -- Gray Candle Stub
		64417,	 -- Maul of Stone Guard Mur'og
		64389,	 -- Tiny Bronze Scorpion
		64387,	 -- Vicious Ancient Fish
		64385,	 -- Feathered Raptor Arm
		64382,	 -- Scepter of Xavius
		64381,	 -- Cracked Crystal Vial
		64379,	 -- Chest of Tiny Glass Animals
		64378,	 -- String of Small Pink Pearls
		64375,	 -- Drakkari Sacrificial Knife
		64374,	 -- Tooth with Gold Filling
		64371,	 -- Skull Staff of Shadowforge
		64368,	 -- Mithril Chain of Angerforge
		64367,	 -- Scepter of Charlga Razorflank
		64366,	 -- Scorched Staff of Shadow Priest Anund
		64362,	 -- Dented Shield of Horuz Killcrow
		64357,	 -- Delicate Music Box
		64356,	 -- Hairpin of Silver and Malachite
		64355,	 -- Ancient Shark Jaws
		64354,	 -- Kaldorei Amphora
		64350,	 -- Insect in Amber
		64349,	 -- Devilsaur Tooth
		64348,	 -- Atal'ai Scepter
		64347,	 -- Gahz'rilla Figurine
		64346,	 -- Bracelet of Jade and Coins
		64345,	 -- Skull-Shaped Planter
		64344,	 -- Ironstar's Petrified Shield
		64343,	 -- Winged Helm of Corehammer
		64342,	 -- Golden Chamber Pot
		64340,	 -- Boot Heel with Scrollwork
		64339,	 -- Bodacious Door Knocker
		64337,	 -- Notched Sword of Tunadil the Redeemer
		63528,	 -- Green Dragon Ring
		63527,	 -- Twisted Ammonite Shell
		63526,	 -- Shattered Glaive
		63525,	 -- Coin from Eldre'Thalas
		63524,	 -- Cinnabar Bijou
		63523,	 -- Eerie Smolderthorn Idol
		63518,	 -- Hellscream's Reach Commendation
		63414,	 -- Moltenfist's Jeweled Goblet
		63413,	 -- Feathered Gold Earring
		63412,	 -- Jade Asp with Ruby Eyes
		63411,	 -- Silver Neck Torc
		63410,	 -- Stone Gryphon
		63409,	 -- Ceramic Funeral Urn
		63408,	 -- Pewter Drinking Cup
		63407,	 -- Cloak Clasp with Antlers
		63131,	 -- Scandalous Silk Nightgown
		63130,	 -- Inlaid Ivory Comb
		63129,	 -- Highborne Pyxis
		63121,	 -- Beautiful Preserved Fern
		63120,	 -- Fetish of Hir'eek
		63118,	 -- Lizard Foot Charm
		63115,	 -- Zandalari Voodoo Doll
		63113,	 -- Belt Buckle with Anvilmar Crest
		63112,	 -- Bone Gaming Dice
		63111,	 -- Wooden Whistle
		63110,	 -- Worn Hunting Knife
		63109,	 -- Black Trilobite
		57757,	 -- Orgrimmar Cooking Award
		49884,	 -- Kaja'Cola
	},
	[3] = { 	-- WolTK
		57142,	 -- Stormwind Cooking Award
		46114,	 -- Champion's Writ
		43641,	 -- Anduin Wrynn's Gold Coin
		43640,	 -- Archimonde's Gold Coin
		43639,	 -- Arthas' Gold Coin
		43638,	 -- Arugal's Gold Coin
		43637,	 -- Brann Bronzebeard's Gold Coin
		43636,	 -- Chromie's Gold Coin
		43635,	 -- Kel'Thuzad's Gold Coin
		43634,	 -- Lady Katrana Prestor's Gold Coin
		43633,	 -- Prince Kael'thas Sunstrider's Gold Coin
		43632,	 -- Sylvanas Windrunner's Gold Coin
		43631,	 -- Teron's Gold Coin
		43630,	 -- Tirion Fordring's Gold Coin
		43629,	 -- Uther Lightbringer's Gold Coin
		43628,	 -- Lady Jaina Proudmoore's Gold Coin
		43627,	 -- Thrall's Gold Coin
		43392,	 -- Charred Glyph
		42954,	 -- Charred Glyph
		42742,	 -- Faded Glyph
		41106,	 -- Charred Glyph
		40919,	 -- Mark of the Orca
		40916,	 -- Charred Glyph
		37372,	 -- Harpoon
		43016, 	 -- Dalaran Cooking Award
		41596,	 -- Dalaran Jewelcrafter's Token
	},
	[2] = { 	-- BC
		34497,	 -- Paper Flying Machine
		33784,	 -- Darkrune Fragment
		32897,	 -- Mark of the Illidari
		32773,	 -- Bash'ir's Skeleton Key
		32713,	 -- Bloodstained Fortune
		32712,	 -- Bloodstained Fortune
		32711,	 -- Bloodstained Fortune
		32710,	 -- Bloodstained Fortune
		32709,	 -- Bloodstained Fortune
		32708,	 -- Bloodstained Fortune
		32707,	 -- Bloodstained Fortune
		32706,	 -- Bloodstained Fortune
		32705,	 -- Bloodstained Fortune
		32704,	 -- Bloodstained Fortune
		32703,	 -- Bloodstained Fortune
		32702,	 -- Bloodstained Fortune
		32701,	 -- Bloodstained Fortune
		32700,	 -- Bloodstained Fortune
		32693,	 -- Bloodstained Fortune
		32692,	 -- Bloodstained Fortune
		32691,	 -- Bloodstained Fortune
		32690,	 -- Bloodstained Fortune
		32689,	 -- Bloodstained Fortune
		32688,	 -- Bloodstained Fortune
		32684,	 -- Insidion's Ebony Scale
		32683,	 -- Jet Scale of Furywing
		32682,	 -- Obsidia Scale
		32681,	 -- Onyx Scale of Rivendark
		32578,	 -- Charged Crystal Focus
		32572,	 -- Apexis Crystal
		32079,	 -- Shaffar's Stasis Chamber Key
		30426,	 -- Coilskar Chest Key
		29750,	 -- Ethereum Stasis Chamber Key
		26045,	 -- Halaa Battle Token
		26044,	 -- Halaa Research Token
		23501,	 -- Bloodthistle Petal
	},
	[1] = { 	-- Classic
		22524,	 -- Insignia of the Crusade
		22523,	 -- Insignia of the Dawn
		22484,	 -- Necrotic Rune
		21438,	 -- Horde Commendation Signet
		21436,	 -- Alliance Commendation Signet
		20620,	 -- Holy Mightstone
		12973,	 -- Scarlet Cannonball
		11078,	 -- Relic Coffer Key
		10575,	 -- Black Dragonflight Molt
		6712,	 -- Clockwork Box
		5373,	 -- Lucky Charm
		2460,	 -- Elixir of Tongues
		1703,	 -- Crystal Basilisk Spine
	},

}

items.world_events = {
	[10] = { -- Dragonflight
		199211, -- Primeval Essence
		201423, -- Hallowed Helm
		202162, -- Rumble Coin
		202395, -- Rumble Foil
		202398, -- Gold Rumble Foil
		203683, -- Ward of Fyrakk
		203430, -- Ward of Igira
		203710, -- Everburning Key
	},
	[9] = { -- Shadowland
	},
	[8] = { -- BfA
		167552, -- Luminescent Research Notes
		168607, -- Bottle of Voidwine
		169397, -- Admiralty Ale
		169436, -- Fireblood Stout
		169439, -- Dark Iron Ale
		169441, -- Azuremyst Mead
		169442, -- Exodar Martini
		169443, -- Shadowmoon Schnapps
		169458, -- Vol'dunshine
		169459, -- Saurid Sipper
		169460, -- Really Really Really Old Fashioned
		169462, -- Boxed Nightwine
		169463, -- Nightwine Cooler
		169464, -- Sparkling Suramar Spritz
		169466, -- Everbloom IPA
		169467, -- Doomlager
		169468, -- Ancestral Ale
		169469, -- Mag'helada
		169521, -- Butterhoof Milk Stout
		169527, -- Thunder Stumbler
		169599, -- Chowdown Champion Token
		170202, -- Shwayderbrau
		172219, -- Wild Holly
		165657, -- Free T-Shirt
		155823, -- Icy Snowball
	},
	[7] = { 	-- Legion
		138414, -- Emergency Pirate Outfit
		138867, -- Shimmer Stout
		138868, -- Mannoroth's Blood Red Ale
		138869, -- Gordok Bock
		138870, -- Spirit Spirits
		138871, -- Storming Saison
		139277, -- Historian's Badge
		143855, -- Twilight Cultist Robe
		143857, -- Twilight Cultist Mantle
		143858, -- Twilight Cultist Cowl
		143865, -- Abyssal Crest
		143866, -- Twilight Cultist Ring of Lordship
		143867, -- Twilight Cultist Medallion of Station
		144073, -- Ship Mast
		144074, -- Mainsail
		144075, -- Waxy Reeds
		144076, -- Rigging Rope
		144077, -- Submarine Tar
		144228, -- Dino Mojo
		144261, -- Sporeggium
		144262, -- Fungal Lifestalk
		144263, -- Pungent Truffle
		144264, -- Pungent Truffle
		144265, -- Rimecap
		144276, -- Sack of Healing Spores
		147374, -- Wooden Toy Shield
		147377, -- Wooden Toy Shield
		150735, -- Moonberry
		151599, -- Blighthead Slack-Jaw Mask
		151600, -- Blighthead Mohawk Mask
		151601, -- Blighthead Romero Mask
		151602, -- Blighthead Electric Beehive Mask
		151603, -- Blighthead Grim Smile Mask
		151604, -- Blighthead Bitter Wounds Mask
		151605, -- Devlynn Styx Mask

		139036, -- Ominous Pet Treat
	},
	[6] = { 	-- WoD
		128648,	 -- Yellow Snowball
		128632,	 -- Savage Snowball
		116812,	 -- "Yipp-Saron" Costume
		116811,	 -- "Lil' Starlet" Costume
		116810,	 -- "Mad Alchemist" Costume
		116445,	 -- Anxious Spiritshard
		116444,	 -- Forlorn Spiritshard
		116443,	 -- Peaceful Spiritshard
		116442,	 -- Vengeful Spiritshard
	},
	[5] = { 	-- MoP
	},
	[4] = { 	-- Cataclysm
	},
	[3] = { 	-- WolTK
		49927, -- Love Token, Love is in the Air
		44791, -- Noblegarden Chocolate
	},
	[2] = { 	-- BC
		37829, -- Brewfest Prize Token
		37816,	 -- Preserved Brewfest Hops
		35557,	 -- Huge Snowball
		33226, -- Tricky Treat, Hallow's End
		34684,	 -- Handful of Summer Petals
		34191,	 -- Handful of Snowflakes
		22140,	 -- Sentinel's Card
		22120,	 -- Pledge of Loyalty: Darnassus
		21960,	 -- Handmade Woodcraft
		21591,	 -- Large Purple Rocket
		21560,	 -- Small Purple Rocket
		
	},
	[1] = { 	-- Classic
		23247, 	 -- Burning Blossom, Midsummer Fire Festiva
		22261,	 -- Love Fool
		22218,	 -- Handful of Rose Petals
		22177,	 -- Freshly Picked Flowers
		22176,	 -- Homemade Bread
		22175,	 -- Freshly Baked Pie
		22174,	 -- Romantic Poem
		22173,	 -- Dwarven Homebrew
		22145,	 -- Guardian's Moldy Card
		22144,	 -- Bluffwatcher's Card
		22143,	 -- Stormwind Guard's Card
		22142,	 -- Grunt's Card
		22141,	 -- Ironforge Guard's Card
		22123,	 -- Pledge of Loyalty: Orgrimmar
		22122,	 -- Pledge of Loyalty: Thunder Bluff
		22121,	 -- Pledge of Loyalty: Undercity
		22119,	 -- Pledge of Loyalty: Ironforge
		22117,	 -- Pledge of Loyalty: Stormwind
		21830,	 -- Empty Wrapper
		21823,	 -- Heart Candy
		21822,	 -- Heart Candy
		21821,	 -- Heart Candy
		21820,	 -- Heart Candy
		21819,	 -- Heart Candy
		21818,	 -- Heart Candy
		21817,	 -- Heart Candy
		21816,	 -- Heart Candy
		21747,	 -- Festival Firecracker
		21718,	 -- Large Red Rocket Cluster
		21716,	 -- Large Green Rocket Cluster
		21714,	 -- Large Blue Rocket Cluster
		21595,	 -- Large Yellow Rocket
		21593,	 -- Large White Rocket
		21592,	 -- Large Red Rocket
		21590,	 -- Large Green Rocket
		21589,	 -- Large Blue Rocket
		21576,	 -- Red Rocket Cluster
		21574,	 -- Green Rocket Cluster
		21571,	 -- Blue Rocket Cluster
		21570,	 -- Cluster Launcher
		21569,	 -- Firework Launcher
		21562,	 -- Small Yellow Rocket
		21561,	 -- Small White Rocket
		21559,	 -- Small Green Rocket
		21558,	 -- Small Blue Rocket
		21557,	 -- Small Red Rocket
		21536,	 -- Elune Stone
		21519,	 -- Mistletoe
		21213,	 -- Preserved Holly
		21100, 	 -- Coin of Ancestry, Lunar Festiva
		17405,	 -- Green Garden Tea
		17202,	 -- Snowball
		17195,	 -- Fake Mistletoe
		17194,	 -- Holiday Spices
	},
}

items.pvp = {
	[10] = { -- Dragonflight
		201836, -- Aspects' Token of Merit
		202184, -- Trophy of Strife
	},
	[9] = { -- Shadowland
	},
	[8] = { -- BfA
	},
	[7] = { 	-- Legion
		137642, -- Mark of Honor
	},
	[6] = { 	-- WoD
		115978,	 -- Enchant Weapon - Glory of the Frostwolf
		115977,	 -- Enchant Weapon - Glory of the Warsong
		115976,	 -- Enchant Weapon - Glory of the Blackrock
		115975,	 -- Enchant Weapon - Glory of the Shadowmoon
		115973,	 -- Enchant Weapon - Glory of the Thunderlord
	},
	[5] = { 	-- MoP
		103533, -- Vicious Saddle
		95349,	 -- Enchant Weapon - Glorious Tyranny
		89112,	 -- Mote of Harmony
		76061,	 -- Spirit of Harmony
	},
	[4] = { 	-- Cataclysm
		77154,	 -- Radiant Elven Peridot
		77144,	 -- Willful Lava Coral
		77143,	 -- Vivid Elven Peridot
		77142,	 -- Turbid Elven Peridot
		77141,	 -- Tenuous Lava Coral
		77140,	 -- Stormy Deepholm Iolite
		77139,	 -- Steady Elven Peridot
		77138,	 -- Splendid Lava Coral
		77137,	 -- Shattered Elven Peridot
		77136,	 -- Resplendent Lava Coral
		77134,	 -- Mystic Lightstone
		77133,	 -- Mysterious Shadow Spinel
		77132,	 -- Lucent Lava Coral
		77131,	 -- Infused Elven Peridot
		77130,	 -- Balanced Elven Peridot
	},
	[3] = { 	-- WolTK
		49426,	 -- Emblem of Frost
		47395,	 -- Isle of Conquest Mark of Honor
		47241,	 -- Emblem of Triumph
		45624,	 -- Emblem of Conquest
		44990,	 -- Champion's Seal
		43589,	 -- Wintergrasp Mark of Honor, only available in WOLTKC
		43228, 	 -- Stone Keeper's Shard
		43308,	 -- Honor Points
		42425,	 -- Strand of the Ancients Mark of Honor
		40753, 	 -- Emblem of Valor, only available in WOLTKC
		40752, 	 -- Emblem of Heroism, only available in WOLTKC
		37836,	 -- Venture Coin
	},
	[2] = { 	-- BC
		29024,	 -- Eye of the Storm Mark of Honor
		27679, -- Mystic Dawnstone
		26045, -- HALAA_BATTLE_TOKEN 
		26044, -- HALAA_RESEARCH_TOKEN 
		29434,	 -- Badge of Justice
	},
	[1] = { 	-- Classic
		20559, -- Arathi Basin Mark of Honor
		20558, -- Warsong Gulch Mark of Honor
		20560, -- Alterac Valley Mark of Honor
	},
}
]]

--[[ Do we really need items for meat? I think most were covered by cooking.
items.meat = {
	[10] = { -- Dragonflight
		194730, -- Scalebelly Mackerel
		194966, -- Thousandbite Piranha
		194967, -- Aileron Seamoth
		194968, -- Cerulean Spinefish
		194969, -- Temporal Dragonhead
		194970, -- Islefin Dorado
		197741, -- Maybe Meat
		197742, -- Ribbed Mollusk Meat
		197743, -- Waterfowl Filet
		197744, -- Hornswog Hunk
		197745, -- Basilisk Eggs
		197746, -- Bruffalon Flank
		197747, -- Mighty Mammoth Ribs
		197748, -- Burly Bear Haunch
		197749, -- Ohn'ahran Potato
		197750, -- Three-Cheese Blend
		197751, -- Pastry Packets
		197752, -- Conveniently Packaged Ingredients
		197753, -- Thaldraszian Cocoa Powder
		197754, -- Salt Deposit
		197755, -- Lava Beetle
		197756, -- Pebbled Rock Salts
		197757, -- Assorted Exotic Spices
		199063, -- Salted Fish Scraps
		199100, -- Peppersmelt
		199101, -- Dried Wyldermane Kelp
		199102, -- Hunk o' Blubber
		199103, -- Nappa's Famous Tea
		199104, -- Piping-Hot Orca Milk
		199105, -- Ancheevy
		199106, -- Tiny Leviathan Bone
		199205, -- Manasucker
		199207, -- Iceback Sculpin
		199208, -- Grungle
		199212, -- Clubfish
		199213, -- Lakkamuk Blenny
		199344, -- Magma Thresher
		199346, -- Rotten Rimefin Tuna
		199832, -- Smoked Seaviper
		199833, -- Dragonhead Eel
		199834, -- Pulpy Seagrass
		199835, -- Torga's Braid
		200061, -- Prismatic Leaper
		200074, -- Frosted Rimefin Tuna
	},
	[9] = { -- Shadowland
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
	},
	[8] = { -- BfA
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
	},
	[7] = { 	-- Legion
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
	},
	[6] = { 	-- WoD
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
	},
	[5] = { 	-- MoP
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
	},
	[4] = { 	-- Cataclysm
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
	},
	[3] = { 	-- WolTK
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
	},
	[2] = { 	-- BC
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
	},
	[1] = { 	-- Classic
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
	},
}
]]

--[[
items.quest = { -- quest item which is stable
	[10] = { -- Dragonflight
	},
	[9] = { -- Shadowland
	},
	[8] = { -- BfA
	},
	[7] = { 	-- Legion
	},
	[6] = { 	-- WoD
	},
	[5] = { 	-- MoP
	},
	[4] = { 	-- Cataclysm
	},
	[3] = { 	-- WolTK
	},
	[2] = { 	-- BC
	},
	[1] = { 	-- Classic
	},
}
]]
