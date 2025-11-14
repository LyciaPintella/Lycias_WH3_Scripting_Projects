out("Loading phar_sea_peoples_invasion.lua")

--[[
FACTIONS KEY LIST
In order of appearence in the documentation
https://confluence.creative-assembly.com/display/CAS/COMB+-+Invasions+Overhaul

phar_sea_ekwesh
phar_sea_tjeker
phar_sea_shekelesh
phar_main_phrygian_invaders
phar_sea_denyen
phar_main_kaska
phar_sea_teresh
phar_sea_lukka
phar_sea_weshesh
phar_main_libu_invaders
phar_map_urartu_invaders
phar_map_ahlamu_invaders
phar_map_elamite_invaders
]]

local function output(str)
     if str then
          out("*** _SEA INVASION_ ***: " .. str)
     end
end

invasion_setup_helpers = {
     -- Invasion faction key to a bundles to be added after it's spawned.
     factions_to_bundles_upon_spawn = {
          ["phar_sea_weshesh"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_sea_shekelesh"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_sea_lukka"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_sea_teresh"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_sea_denyen"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_sea_ekwesh"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_sea_tjeker"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_main_libu_invaders"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_main_kaska"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_main_phrygian_invaders"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_map_ahlamu_invaders"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_map_elamite_invaders"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
          ["phar_map_urartu_invaders"] = {
               [1] = "phar_main_effect_bundle_invasion_background_resources"
          },
     },

     bundles_upon_spawn_when_player_is_specific_faction = {
          ["phar_sea_peleset"] = {
               [1] = "phar_sea_invasion_debuff_bundle_1",
          },
          ["phar_sea_sherden"] = {
               [1] = "phar_sea_invasion_debuff_bundle_1",
          }
     }
}

-- Theatres are a bunch of positions where each faction is allowed to spawn.
-- Those theatres are made to be used and exchanged easily between faction if its needed.
invasions_theatres =
{
     theatre_aegean =
     {
          ekwesh = { { 32, 1423 }, { 73, 1322 }, { 142, 1279 }, },
          tjekker = { { 181, 1263 }, { 265, 1329 }, { 315, 1231 }, },
          shekelesh = { { 303, 1388 }, { 227, 1466 }, { 392, 1479 }, },
          phrygian = { { 580, 1410 }, { 717, 1468 }, { 702, 1376 }, },
     },
     theatre_anatolian =
     {
          denyen = { { 468, 1252 }, { 761, 1264 }, { 1023, 1253 }, },
          kaska = { { 825, 1555 }, { 968, 1583 }, { 1143, 1504 }, },
     },
     theatre_canaan =
     {
          teresh = { { 1080, 1164 }, { 1005, 1055 }, { 935, 970 }, },
     },
     theatre_egyptian =
     {
          weshesh = { { 529, 984 }, { 377, 1000 }, { 244, 1036 }, },
          lukka = { { 864, 1140 }, { 847, 990 }, { 678, 983 }, },
          libu = { { 594, 253 }, { 523, 515 }, { 474, 841 }, },
     },
     theatre_mesopotamian =
     {
          urartu = { { 1487, 1405 }, { 1715, 1278 }, { 1757, 1212 }, },
          ahlamu = { { 1235, 1052 }, { 1327, 1104 }, { 1521, 1107 }, },
          elamite = { { 1810, 918 }, { 1852, 954 }, { 1912, 986 }, },
     },
}

-- Set the fefault setting for each invasions waves here.
-- Those tables are mandatory for the wave to spawn.
-- This is mainly a failsafe for designers modders that may forget to override some waves.
-- Yes all the waves are meant to be overrided by the designers.
invasions_waves_default_settings =
{
     -- Wave 1
     {
          wave_number = 1,

          wave_budget = 5000,
          wave_budget_variance = 1000,

          wave_unit_count = 8,
          wave_unit_count_variance = 1,

          wave_spawn_at_turn = 35,
          wave_spawn_at_turn_variance = 5,

          wave_army_count = 2,
     },
     -- Wave 2
     {
          wave_number = 2,

          wave_budget = 7000,
          wave_budget_variance = 1500,

          wave_unit_count = 12,
          wave_unit_count_variance = 2,

          wave_spawn_at_turn = 65,
          wave_spawn_at_turn_variance = 5,

          wave_army_count = 2,
     },
     -- Wave 3
     {
          wave_number = 3,

          wave_budget = 9000,
          wave_budget_variance = 2000,

          wave_unit_count = 15,
          wave_unit_count_variance = 2,

          wave_spawn_at_turn = 100,
          wave_spawn_at_turn_variance = 5,

          wave_army_count = 2,
     },
     -- Wave 4
     {
          wave_number = 4,

          wave_budget = 12000,
          wave_budget_variance = 2000,

          wave_unit_count = 17,
          wave_unit_count_variance = 2,

          wave_spawn_at_turn = 135,
          wave_spawn_at_turn_variance = 5,

          wave_army_count = 2,
     },
}

-- Most of the work for Balancing is done here
-- Each faction is a table, that contains capital informations, including, personality key, waves overrides and theatre.
invasions_factions =
{
     --[[
		INVASION_FACTION_TEMPLATE =
		{
			faction_key = "",
			faction_theatre = invasions_theatres.,  -- Theatre is a bunch of possible positions stored into tables
			cai_personality_key = "",

			wave_overrides =
			{
				-- Wave 1 override
				{
					wave_number = 1,

					wave_budget = 10000,
					wave_budget_variance = 2500,

					wave_unit_count = 8,
					wave_unit_count_variance = 2,

					wave_spawn_at_turn = 2,
					wave_spawn_at_turn_variance = 0,

					wave_army_count = 2,
				},
			},
		},
	]]

     --------------------
     -- THEATRE AEGEAN
     --------------------
     ekwesh_faction =
     {
          faction_key = "phar_sea_ekwesh",
          faction_theatre = invasions_theatres.theatre_aegean.ekwesh,
          cai_personality_key = "phar_sea_unique_peleset_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },
     tjeker_faction =
     {
          faction_key = "phar_sea_tjeker",
          faction_theatre = invasions_theatres.theatre_aegean.tjekker,
          cai_personality_key = "phar_sea_unique_peleset_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },
     shekelesh_faction =
     {
          faction_key = "phar_sea_shekelesh",
          faction_theatre = invasions_theatres.theatre_aegean.shekelesh,
          cai_personality_key = "phar_sea_unique_peleset_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },
     phrygian_faction =
     {
          faction_key = "phar_main_phrygian_invaders",
          faction_theatre = invasions_theatres.theatre_aegean.phrygian,
          cai_personality_key = "phar_sea_unique_peleset_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },

     --------------------
     -- THEATRE ANATOLIAN
     --------------------
     denyen_faction =
     {
          faction_key = "phar_sea_denyen",
          faction_theatre = invasions_theatres.theatre_anatolian.denyen,
          cai_personality_key = "phar_sea_unique_sherden_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },
     kaska_faction =
     {
          faction_key = "phar_main_kaska",
          faction_theatre = invasions_theatres.theatre_anatolian.kaska,
          cai_personality_key = "phar_sea_unique_peleset_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },

     --------------------
     -- THEATRE CANAAN
     --------------------
     teresh_faction =
     {
          faction_key = "phar_sea_teresh",
          faction_theatre = invasions_theatres.theatre_canaan.teresh,
          cai_personality_key = "phar_sea_unique_sherden_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },

     --------------------
     -- THEATRE EGYPTIAN
     --------------------
     lukka_faction =
     {
          faction_key = "phar_sea_lukka",
          faction_theatre = invasions_theatres.theatre_egyptian.lukka,
          cai_personality_key = "phar_sea_unique_sherden_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },
     weshesh_faction =
     {
          faction_key = "phar_sea_weshesh",
          faction_theatre = invasions_theatres.theatre_egyptian.weshesh,
          cai_personality_key = "phar_sea_unique_sherden_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },
     libu_faction =
     {
          faction_key = "phar_main_libu_invaders",
          faction_theatre = invasions_theatres.theatre_egyptian.libu,
          cai_personality_key = "phar_sea_unique_peleset_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },

     -----------------------
     -- THEATRE MESOPOTAMIAN
     -----------------------
     urartu_faction =
     {
          faction_key = "phar_map_urartu_invaders",
          faction_theatre = invasions_theatres.theatre_mesopotamian.urartu,
          cai_personality_key = "phar_sea_unique_sherden_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },
     ahlamu_faction =
     {
          faction_key = "phar_map_ahlamu_invaders",
          faction_theatre = invasions_theatres.theatre_mesopotamian.ahlamu,
          cai_personality_key = "phar_sea_unique_sherden_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },
     elamite_faction =
     {
          faction_key = "phar_map_elamite_invaders",
          faction_theatre = invasions_theatres.theatre_mesopotamian.elamite,
          cai_personality_key = "phar_sea_unique_sherden_hard",

          wave_overrides =
          {
               -- Wave 1 override
               {
                    wave_number = 1,

                    wave_budget = 15000,
                    wave_budget_variance = 1000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 1,

                    wave_spawn_at_turn = 35,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 5,
               },

               -- Wave 2 override
               {
                    wave_number = 2,

                    wave_budget = 17000,
                    wave_budget_variance = 1500,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 70,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 9,
               },

               -- Wave 3 override
               {
                    wave_number = 3,

                    wave_budget = 19000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 100,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 14,
               },

               -- Wave 4 override
               {
                    wave_number = 4,

                    wave_budget = 22000,
                    wave_budget_variance = 2000,

                    wave_unit_count = 20,
                    wave_unit_count_variance = 2,

                    wave_spawn_at_turn = 135,
                    wave_spawn_at_turn_variance = 5,

                    wave_army_count = 20,
               },
          },
     },
}

sea_invasion = {
     config = {
          invasion_start_movie_path = "phar_main_sea_people_invasion_start.ca_vp8",
          invasion_end_movie_path = "phar_main_sea_people_invasion_end.ca_vp8",
          attrition_immunity_bundle_key = "phar_main_effect_bundle_pillars_civilization_sea_peoples_attrition",
          survive_sea_peoples_invasion_turn_number = 140, -- used to set on which turn does the achievement and movie are played for surviving the invasions.

          --TODO: THIS IS A TEST, PLEASE DONT FORGET TO CHANGE FOR RELEASE
          --auto_release_invasions = true,
          --first_invasion_spawned_event_info = {
          --	title = "event_feed_strings_text_phar_event_feed_string_sea_peoples_first_invasion_wave_spawned_title",
          --	primary_detail = "event_feed_strings_text_phar_event_feed_string_sea_peoples_first_invasion_wave_spawned_primary_detail",
          --	secondary_detail = "",
          --	index = 5610,
          --},
          --first_invasion_spawned_event_info_sea_faction = {
          --	title = "event_feed_strings_text_phar_event_feed_string_sea_peoples_first_invasion_wave_spawned_as_sea_faction_title",
          --	primary_detail = "event_feed_strings_text_phar_event_feed_string_sea_peoples_first_invasion_wave_spawned_as_sea_faction_primary_detail",
          --	secondary_detail = "",
          --	index = 5612,
          --},
          --last_invasion_spawned_event_info = {
          --	title = "event_feed_strings_text_phar_event_feed_string_sea_peoples_last_invasion_wave_spawned_title",
          --	primary_detail = "event_feed_strings_text_phar_event_feed_string_sea_peoples_last_invasion_wave_spawned_primary_detail",
          --	secondary_detail = "",
          --	index = 5611,
          --},
     },

     persistent = {
          played_great_wave_invasion_start_movie = false,
          played_great_wave_invasion_end_movie = false,
          has_first_invasion_spawned = false,
          has_last_invasion_spawned = false,
          last_invasion_turn = 0,

          -- This stores all the factions waves once they have been generated.
          invasion_instance = {}
     },

     on_saving_game = function(context)
          if not sea_invasion.persistent or not is_table(sea_invasion.persistent) then
               script_error("persistent table is invalid!")
          end

          cm:save_named_value("sea_invasion", sea_invasion.persistent, context)
     end,

     on_loading_game = function(context)
          if not sea_invasion.persistent or not is_table(sea_invasion.persistent) then
               script_error("persistent table is invalid!")
          end

          sea_invasion.persistent = cm:load_named_value("sea_invasion", sea_invasion.persistent, context)
          sea_invasion.persistent.has_first_invasion_spawned = sea_invasion.persistent.has_first_invasion_spawned or
              false
          sea_invasion.persistent.has_last_invasion_spawned = sea_invasion.persistent.has_last_invasion_spawned or false
          sea_invasion.persistent.invasion_instance = sea_invasion.persistent.invasion_instance or {}

          common.set_context_value("sea_people_invasion_config", sea_invasion.config)
     end,

     -- Apply amy needed bundles to the invasions factions
     apply_bundles_to_invasions = function(faction_key)
          if invasion_setup_helpers.factions_to_bundles_upon_spawn[faction_key] then
               for _, bundle in ipairs(invasion_setup_helpers.factions_to_bundles_upon_spawn[faction_key]) do
                    cm:apply_effect_bundle(bundle, faction_key, 0)
               end
          end

          local human_factions = cm:get_human_factions()

          for _, faction_key in ipairs(human_factions) do
               if invasion_setup_helpers.bundles_upon_spawn_when_player_is_specific_faction[faction_key] then
                    for _, bundle in ipairs(invasion_setup_helpers.bundles_upon_spawn_when_player_is_specific_faction[faction_key]) do
                         cm:apply_effect_bundle(bundle, faction_key, 0)
                    end
               end
          end
     end,

     -- @function force_created
     -- @desc Called when the invasion is spawned successfully through the call of cm:create_force_with_budget()
     -- @p number : gen_cqi the cqi of the generated force
     -- @p table : wave the wave instance table
     force_created = function(gen_cqi, wave)
          local general_cqi = gen_cqi
          local general_lookup = "character_cqi:" .. general_cqi;
          cm:cai_enable_movement_for_character(general_lookup);
          cm:enable_movement_for_character(general_lookup);

          cm:force_change_cai_faction_personality(wave.faction_key, wave.cai_personality_key)

          wave.has_spawned = true
          --out("\tEnabling movement for invasion general ["..general_lookup.."]");
          -- local_faction == target_faction or
          -- or local_faction:is_ally_vassal_subject_or_client_state_of(target_faction)
          --if local_faction and not local_faction:is_null_interface() then
          --	local player_faction_is_involved = local_faction == invading_faction or
          --										local_faction:is_ally_vassal_subject_or_client_state_of(invading_faction)

          --	-- scroll the camera to the invastion if the local player is involved and has vision of the invasion location
          --	if player_faction_is_involved and local_faction:is_character_position_visible_to_shroud(force_leader) then
          --cm:scroll_camera_from_current(false, 6, {force_leader:display_position_x(), force_leader:display_position_y(), 14.768, 0.0, 12.0});
          --	end
          --end
     end,

     -- @fucntion initialize_invasions
     -- @desc Called on game creation, it creates all the faction and waves instances needed for the invasions to spawn
     initialize_invasions = function(self)
          for _, faction in pairs(invasions_factions) do
               self.create_wave_instance(faction, self.persistent.invasion_instance)
          end

          for i = 1, #self.persistent.invasion_instance do
               self.persistent.invasion_instance[i].faction_wave_instances = self.randomize_wave_data(self.persistent
                    .invasion_instance[i])
          end

          self.config.survive_sea_peoples_invasion_turn_number = self.get_last_wave_turn()
     end,

     --- @function spawn_invasions
     --- @desc spawns invasions for this turn, if they match the difficulty
     --- @p table waves contains the waves to spawn for this turn
     spawn_invasions = function(waves)
          if waves == nil or waves == {} then
               return
          end

          local allow_spawn = mdm.state["sea_people_invasions"].value

          if allow_spawn == true or allow_spawn == 1 then
               for _, wave in pairs(waves) do
                    -- We have several armies to spawn in each wave of each factions
                    for i = 0, wave.wave_army_count - 1 do
                         -- We want to spawn the i > 0 armies in the vincinity of the randomly selected position
                         if i ~= 0 then
                              wave.spawn_location = sea_invasion.get_pos_in_vincinity(wave.faction_key,
                                   wave.spawn_location)
                         end
                         local is_valid_position = invasion_manager.is_valid_position(wave.spawn_location.x,
                              wave.spawn_location.y)

                         -- Actually spawn the invasion
                         if is_valid_position == true then
                              local temp_region = cm:model():world():region_manager():region_list():item_at(0):name();
                              cm:create_force_with_budget(wave.faction_key, temp_region, wave.final_budget,
                                   wave.final_unit_count, true, wave.spawn_location.x, wave.spawn_location.y,
                                   function(cqi) sea_invasion.force_created(cqi, wave) end)
                         else
                              out("Could not find valid position for this wave. Not spawning anything")
                         end
                    end

                    -- Apply any bundles necessary
                    cm:apply_effect_bundle(sea_invasion.config.attrition_immunity_bundle_key, wave.faction_key, 0)
                    sea_invasion.apply_bundles_to_invasions(wave.faction_key)
               end
          end

          --Trigger invasion movie if first invasion ever is spawned
          if sea_invasion.persistent.played_great_wave_invasion_start_movie == false then
               if is_string(sea_invasion.config.invasion_start_movie_path) and not sea_invasion.config.invasion_start_movie_path ~= "" then
                    cm:register_instant_movie(sea_invasion.config.invasion_start_movie_path)
               end
               sea_invasion.persistent.played_great_wave_invasion_start_movie = true
          end
     end,

     -- @function create_wave_instance
     -- @desc create wave instances and fill the persistent.invasion_instance table with it
     -- @p table : the faction template from invasions_factions
     -- @p table : the persistent table that will be saved
     create_wave_instance = function(faction, table_to_fill)
          local temp = {} -- temp id is always 1
          local id = 1

          -- Creates a new table with the faction details and put it in the wave_data
          temp = sea_invasion.create_faction_instance(faction)

          -- for each overrided waves
          if #faction.wave_overrides > 0 then
               for _, override in pairs(faction.wave_overrides) do
                    table.insert(temp.faction_wave_instances, override)
               end
          end

          -- Complete the remaining waves instances with default settings
          if #temp.faction_wave_instances < #invasions_waves_default_settings then
               -- If no overrides at all, just shove all the default settings into the instance.
               if #temp.faction_wave_instances == 0 then
                    for _, default_wave in pairs(invasions_waves_default_settings) do
                         table.insert(temp.faction_wave_instances, default_wave)
                    end
                    -- Else, it means that some waves are overrided, but not all, so put the default ones where they need to be
               else
                    for _, default_wave in pairs(invasions_waves_default_settings) do
                         if sea_invasion.is_wave_overrided(temp.faction_wave_instances, default_wave) == false then
                              table.insert(temp.faction_wave_instances, default_wave)
                         end
                    end
               end
          end

          table_to_fill[#table_to_fill + 1] = temp
     end,

     -- @function create_faction_instance
     -- @desc Creates and return a new faction instance to be saved
     -- @p table : faction the faction template
     create_faction_instance = function(faction)
          local current_faction =
          {
               faction_key = faction.faction_key,
               faction_theatre = faction.faction_theatre,
               cai_personality_key = faction.cai_personality_key,
               faction_wave_instances = {}
          }
          return current_faction
     end,

     -- @function remove_faction_instance
     -- @desc removes a faction instance from the persistent data, this function is only used when loading the game.
     -- @desc after checking if a faction is missing from the script data, this function may be called to remove it.
     -- @p table : faction the faction that need to be removed
     remove_faction_instance = function(faction)
          local id = 1
          for _, faction in pairs(sea_invasion.persistent.invasion_instance) do
               if faction.faction_key == faction.faction_key then
                    table.remove(sea_invasion.persistent.invasion_instance, id)
               end
               id = id + 1
          end
     end,

     --@function is_wave_overrided
     --@ desc Checks wether a wave is overrided in the faction template or not, return true or false
     --@p table : faction_wave_overrides table of overrides, coming from the faction template
     --@p table : default_wave_settings the whole table of default settings
     is_wave_overrided = function(faction_wave_overrides, default_wave_settings)
          local is_overrided = false
          for _, wave in pairs(faction_wave_overrides) do
               if default_wave_settings.wave_number == wave.wave_number then
                    is_overrided = true
                    break
               end
          end
          return is_overrided
     end,

     --@function randomize_wave_data
     --@desc Randomize the data in the wave, depending on the variance variables contained in the template.
     --@p table : faction the faction template from which we are going to randomize values
     randomize_wave_data = function(faction)
          --for key, wave in pairs(faction.faction_wave_instances) do
          local temp = {}
          for i = 1, #faction.faction_wave_instances do
               local curr = faction.faction_wave_instances[i]
               local wave = {}

               wave.wave_number = curr.wave_number
               wave.wave_army_count = curr.wave_army_count
               wave.faction_key = faction.faction_key
               wave.cai_personality_key = faction.cai_personality_key
               wave.final_budget = cm:model():random_int(curr.wave_budget - curr.wave_budget_variance,
                    curr.wave_budget + curr.wave_budget_variance)
               wave.final_spawn_on_turn = cm:model():random_int(
                    curr.wave_spawn_at_turn - curr.wave_spawn_at_turn_variance,
                    curr.wave_spawn_at_turn + curr.wave_spawn_at_turn_variance)
               wave.final_unit_count = cm:model():random_int(curr.wave_unit_count - curr.wave_unit_count_variance,
                    curr.wave_unit_count + curr.wave_unit_count_variance)

               local raw_spawn_location = faction.faction_theatre[cm:model():random_int(1, #faction.faction_theatre)]
               wave.spawn_location = {
                    x = raw_spawn_location.x or raw_spawn_location[1],
                    y = raw_spawn_location.y or
                        raw_spawn_location[2]
               };

               if wave.final_unit_count > 19 then
                    wave.final_unit_count = 19
               end

               wave.has_spawned = false
               temp[i] = wave
          end
          return temp
     end,

     --@function get_next_wave_to_spawn
     --@desc Get the waves to spawn at this current turn, return a table filled with those waves.
     --@p number : current_turn the current turn, the one that is, like, right now.
     get_next_wave_to_spawn = function(current_turn)
          local next_turn_wave = {}

          for _, faction in pairs(sea_invasion.persistent.invasion_instance) do
               out.invasions("INVASION FACTION : [" .. faction.faction_key .. "]")
               for _, wave in pairs(faction.faction_wave_instances) do
                    out.invasions("Wave number   < " ..
                         wave.wave_number ..
                         " >   will spawn on turn > " ..
                         wave.final_spawn_on_turn ..
                         "< \t at location : [" .. wave.spawn_location.x .. "/" .. wave.spawn_location.y .. "]")
                    if wave.final_spawn_on_turn == current_turn and wave.has_spawned == false then
                         table.insert(next_turn_wave, wave)
                    end
               end
               out.invasions("***********************")
          end

          if #next_turn_wave <= 0 then
               return {}
          else
               return next_turn_wave
          end
     end,

     --@function get_last_wave_turn
     --@desc Get last invasion wave turn, for achievements / movies to showcase, returns a number
     get_last_wave_turn = function()
          local turn_of_last_wave = 0
          for _, faction in pairs(sea_invasion.persistent.invasion_instance) do
               for _, wave in pairs(faction.faction_wave_instances) do
                    if wave.final_spawn_on_turn >= turn_of_last_wave then
                         turn_of_last_wave = wave.final_spawn_on_turn
                    end
               end
          end
          return turn_of_last_wave
     end,

     --@function get_pos_in_vincinity
     --@desc Get a position in the vincinity of another position, returns a new table with x,y coordinates in the vincinity around the input pos.
     --@p table : pos the base position we are going to use
     get_pos_in_vincinity = function(faction_key, pos)
          local generate_random_number_callback = function(min, max)
               return cm:model():random_int(min, max)
          end
          local nearby_pos_x, nearby_pos_y = cm:find_valid_spawn_location_for_character_from_position(faction_key, pos.x,
               pos.y, true, 2)
          local parsed_pos = { x = nearby_pos_x, y = nearby_pos_y };
          return parsed_pos
     end,

     --@function get_default_settings_for_wave
     --@desc Get a default settings for a wave
     --@p number : wave_number is the number of the wave, it cannot be <0 or greater then the length of the invasions_waves_default_settings table.
     get_default_settings_for_wave = function(wave_number)
          -- In case a wrong number is given, return the first wave default settings
          if wave_number <= 0 or wave_number > #invasions_waves_default_settings then
               wave_number = 1
          end

          return invasions_waves_default_settings[wave_number]
     end,

     --@function check_for_invasion_changes
     --@desc Compares the scripts data with the persistent one.
     --@desc If a Designer/Modder changes the data, we need to be able to re-shuffle and/or reset everything that has beem changed/updated, in order not to break any saves.
     check_for_invasion_changes = function()
          local save = sea_invasion.persistent.invasion_instance

          -- First check if any faction has been added
          for _, faction in pairs(invasions_factions) do
               if sea_invasion.is_faction_present_in_save(faction.faction_key) == false then
                    -- Create the faction and wave instance, put it in the save
                    table.insert(save, sea_invasion.create_wave_instance(faction, save))
                    -- Immediatly shuffle all the data
                    sea_invasion.randomize_wave_data(faction)
               end
          end

          -- The check if any faction has been removed from the script
          for _, faction in pairs(save) do
               if sea_invasion.is_faction_present_in_script(faction.faction_key) == false then
                    sea_invasion.remove_faction_instance(faction)
               end
          end

          -- From now on we can proceed with checking each and every variable of the instances, with the scripts ones.
          -- If there's a difference somewhere, we must do something about it.
          for _, faction_instance in pairs(save) do
               for _, script_faction in pairs(invasions_factions) do
                    if script_faction.faction_key == faction_instance.faction_key then
                         for _, wave_instance in pairs(faction_instance.faction_wave_instances) do
                              -- Check overrided waves coming from the scripted data
                              for _, wave_overrided in pairs(script_faction.wave_overrides) do
                                   if wave_instance.wave_number == wave_overrided.wave_number then
                                        sea_invasion.check_for_wave_data_differences(wave_instance, wave_overrided)
                                   end
                              end
                              -- Check remaining waves with the default settings one
                              for _, default_wave_settings in pairs(invasions_waves_default_settings) do
                                   if wave_instance.wave_number == default_wave_settings.wave_number and wave_instance.checked == nil then
                                        sea_invasion.check_for_wave_data_differences(wave_instance, default_wave_settings)
                                   end
                              end
                         end
                    end
               end
          end
     end,

     --@function is_faction_present_in_save
     --@desc Is the faction present in the save ? returns true / false
     --@p string : faction_key
     is_faction_present_in_save = function(faction_key)
          local is_present = false

          for _, saved_faction in pairs(sea_invasion.persistent.invasion_instance) do
               if saved_faction.faction_key == faction_key then
                    is_present = true
                    break
               end
          end

          return is_present
     end,

     --@function is_faction_present_in_script
     --@desc Is the faction present in the script data (invasions_factions) ? returns true / false
     --@p string : faction_key
     is_faction_present_in_script = function(faction_key)
          local is_present = false

          for _, script_faction in pairs(invasions_factions) do
               if script_faction.faction_key == faction_key then
                    is_present = true
                    break
               end
          end

          return is_present
     end,

     --@function check_for_wave_data_differences
     --@desc Check for wave data differences, and randomize it again if there's any.
     --@p table : savedwave is the current wave instance we're checking
     --@p table : newWave is the current wave instance we're checking
     check_for_wave_data_differences = function(savedWave, newWave)
          -- Handle any budget update
          local has_budget_changed = false

          if savedWave.wave_budget ~= newWave.wave_budget then
               savedWave.wave_budget = newWave.wave_budget
               has_budget_changed = true
          end
          if savedWave.wave_budget_variance ~= newWave.wave_budget_variance then
               savedWave.wave_budget_variance = newWave.wave_budget_variance
               has_budget_changed = true
          end
          if has_budget_changed == true then
               savedWave.final_budget = cm:model():random_int(savedWave.wave_budget - savedWave.wave_budget_variance,
                    savedWave.wave_budget + savedWave.wave_budget_variance)
          end

          -- Handle any unit count update
          local has_unit_count_changed = false

          if savedWave.wave_unit_count ~= newWave.wave_unit_count then
               savedWave.wave_unit_count = newWave.wave_unit_count
               has_unit_count_changed = true
          end
          if savedWave.wave_unit_count_variance ~= newWave.wave_unit_count_variance then
               savedWave.wave_unit_count_variance = newWave.wave_unit_count_variance
               has_unit_count_changed = true
          end
          if has_unit_count_changed == true then
               savedWave.final_unit_count = cm:model():random_int(
                    savedWave.wave_unit_count - savedWave.wave_unit_count_variance,
                    savedWave.wave_unit_count + savedWave.wave_unit_count_variance)
          end

          -- Handle turn spawn update
          local has_spawn_turn_changed = false

          if savedWave.wave_spawn_at_turn ~= newWave.wave_spawn_at_turn then
               savedWave.wave_spawn_at_turn = newWave.wave_spawn_at_turn
               has_spawn_turn_changed = true
          end
          if savedWave.wave_spawn_at_turn_variance ~= newWave.wave_spawn_at_turn_variance then
               savedWave.wave_spawn_at_turn_variance = newWave.wave_spawn_at_turn_variance
               has_spawn_turn_changed = true
          end
          if has_spawn_turn_changed == true then
               savedWave.final_spawn_on_turn = cm:model():random_int(
                    savedWave.wave_spawn_at_turn - savedWave.wave_spawn_at_turn_variance,
                    savedWave.wave_spawn_at_turn + savedWave.wave_spawn_at_turn_variance)
          end

          -- Handle army count and difficulty changes
          if savedWave.wave_army_count ~= newWave.wave_army_count then
               savedWave.wave_army_count = newWave.wave_army_count
          end

          -- Adds a flag
          savedWave.checked = true
     end,
}

cm:add_saving_game_callback(function(context) sea_invasion.on_saving_game(context) end)
cm:add_loading_game_callback(function(context) sea_invasion.on_loading_game(context) end)

-- event : RoundStart
-- Checks wether theres a wave to spawn, and if theres any, spawns it
core:add_listener(
     "sea_invasion_RoundStart",
     "RoundStart",
     true,
     function(context)
          local model = cm:model()
          local current_turn = model:turn_number()

          output("sea_invasion_roundStart")

          local upcoming_invasions = sea_invasion.get_next_wave_to_spawn(current_turn)

          if #upcoming_invasions <= 0 then
               return
          end

          sea_invasion.spawn_invasions(upcoming_invasions)

          common.set_context_value("sea_people_invasion_config", sea_invasion.config)
     end,
     true
)

-- event : FactionTurnStart
-- Used for achievements and movies that happens after the player has eradicated every invasions.
core:add_listener(
     "sea_invasion_FactionTurnStart",
     "FactionTurnStart",
     function(context)
          return context:faction():is_human() and
              cm:turn_number() >= sea_invasion.config.survive_sea_peoples_invasion_turn_number
     end,
     function(context)
          core:trigger_event("SeaPeopleInvasionEnded", {})
          achievements.sea_peoples_invasion.func_survive_sea_peoples_invasion_completed(context:faction())

          -- when all sea peoples waves have been eradicated play the sea peoples invasion-end movie
          if sea_invasion.persistent.played_great_wave_invasion_start_movie == true
              and sea_invasion.persistent.played_great_wave_invasion_end_movie == false
          then
               if is_string(sea_invasion.config.invasion_end_movie_path) and sea_invasion.config.invasion_end_movie_path ~= "" then
                    cm:register_instant_movie(sea_invasion.config.invasion_end_movie_path)
                    local movie_key = string.gsub(sea_invasion.config.invasion_end_movie_path, ".ca_vp8", "")
                    core:svr_save_registry_bool(movie_key, true)
               end
               sea_invasion.persistent.played_great_wave_invasion_end_movie = true
          end
     end,
     true
)

-- event : FactionAboutToEndTurn
--
--core:add_listener(
--	"sea_invasion_FactionAboutToEndTurn",
--	"FactionAboutToEndTurn",
--	true,
--	function(context)
--
--	end,
--	true
--)

-- event : FirstTickAfterWorldCreated
-- Whenever the world is created, this event is called and initialize the invasions, or checks for any changes in the data.
core:add_listener(
     "SeaPeopleInvasions_FirstTick",
     "FirstTickAfterWorldCreated",
     true,
     function(context)
          -- Do we have already saved invasions ? if not, initialize the invasions
          if #sea_invasion.persistent.invasion_instance <= 0 then
               sea_invasion:initialize_invasions()
          else
               sea_invasion.check_for_invasion_changes()
          end
     end,
     true
)
