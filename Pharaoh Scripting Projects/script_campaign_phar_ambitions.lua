out("Loading phar_ambitions.lua")

ambitions = {}

-- Helpers are defined in the phar_ambition_helpers.lua file
ambitions.helper = {
     pool_event = {},
     pool_condition = {},
     condition = {},
     objective = {},
     payload = {},
     scripted_payload = {},
}

require "phar_ambition_helpers"

ambitions.shared_states = {
     is_presented_with_ambitions = "is_presented_with_ambitions",
}

-- How many times the ambition choice screen can appear per turn. In other words how many ambitions can be accepted per turn.
ambitions.max_ambition_choices_per_turn = 1

ambitions.defaults = {
     ambition_expiration = 15,
     level = 1,
     rarity = "common",
     tag_weight_bonus = 1,
     faction_starting_tag_weight_bonus = 1,

     -- Corresponds to "Medium" weight, single-tag Ambition
     weight = 5,

     -- If set to true, all helper functions that check adjacent regions and are called without region option
     -- check_horde_regions will behave as if called with option check_horde_regions = true
     check_horde_regions = true,
}

-- The likeliness an ambition will be picked out of the pool. Higher is likelier
-- Warning: Setting this to 0 will make an ambition never be picked
-- Warning: Setting this to a negative number will have bad consequences
ambitions.weights = {
     -- Guidelines: 0/1/2 tags corresponds to +3/2/1 weight
     -- + base weight: v.low/low/medium(default)/high/v.high = 1/2/3/4/5 ; Faction-exclusive missions: +1
     -- More valuable/unique/rare/desirable mission = -1 weight
     -- Very contextual to specific circumstances = +1 weight
     phar_main_ambition_completeprovince = 4,
     phar_main_ambition_conquernearbyenemyprovincecapital = 5,
     phar_main_ambition_conquernearbyfoodsettlement = 5,
     phar_main_ambition_conquernearbywoodsettlement = 5,
     phar_main_ambition_conquernearbystonesettlement = 4,
     phar_main_ambition_conquernearbybronzesettlement = 3,
     phar_main_ambition_conquernearbygoldsettlement = 3,
     phar_main_ambition_colonizenearbyregion = 5,
     phar_main_ambition_conquernearbysel = 5,
     phar_main_ambition_conquernearbyshl = 5,
     phar_map_ambition_conquernearbysal = 5,
     phar_map_ambition_conquernearbysml = 5,
     phar_main_ambition_conquernearbypoi = 5,
     phar_main_ambition_reachterritorysize_1 = 5,
     phar_main_ambition_reachterritorysize_2 = 5,
     phar_main_ambition_reachterritorysize_3 = 5,
     phar_main_ambition_reachterritorysize_4 = 5,
     phar_main_ambition_reachterritorysize_5 = 5,
     phar_main_ambition_reachterritorysize_6 = 5,
     phar_main_ambition_reachtotalunits_1 = 5,
     phar_main_ambition_reachtotalunits_2 = 5,
     phar_main_ambition_reachtotalunits_3 = 5,
     phar_main_ambition_reachtotalunits_4 = 5,
     phar_main_ambition_reachtotalunits_5 = 5,
     phar_main_ambition_havetotalforeignnativeunitsofx = 9,
     phar_main_ambition_havetotallocalnativeunitsofegypt = 5,
     phar_main_ambition_havetotallocalnativeunitsofcanaan = 5,
     phar_main_ambition_havetotallocalnativeunitsofhatti = 5,
     phar_map_ambition_havetotallocalnativeunitsofmesopotamia = 5,
     phar_map_ambition_havetotallocalnativeunitsofaegea = 5,
     phar_main_ambition_havetotalchariotunitsegypt = 5,
     phar_main_ambition_havetotalchariotunitscanaan = 5,
     phar_main_ambition_havetotalchariotunitshatti = 5,
     phar_map_ambition_havetotalchariotunitsmesopotamia = 5,
     phar_map_ambition_havetotalchariotunitsaegea = 5,
     phar_main_ambition_havetotalrangedunitsegypt = 5,
     phar_main_ambition_havetotalrangedunitscanaan = 5,
     phar_main_ambition_havetotalrangedunitshatti = 5,
     phar_map_ambition_havetotalrangedunitsmesopotamia = 5,
     phar_map_ambition_havetotalrangedunitsaegea = 5,
     phar_main_ambition_havetotaleliteunitsofx = 3,
     phar_main_ambition_havetotalimperialunitspharaoh = 3,
     phar_main_ambition_havetotalimperialunitsgreatking = 3,
     phar_map_ambition_havetotalimperialunitswanax = 3,
     phar_map_ambition_havetotalimperialunitskingoftheuniverse = 3,
     phar_main_ambition_recruitgeneral = 8,
     phar_main_ambition_winbattles_1 = 5,
     phar_main_ambition_winbattles_2 = 5,
     phar_main_ambition_winbattles_3 = 5,
     phar_main_ambition_winbattles_4 = 5,
     phar_main_ambition_winbattles_5 = 5,
     phar_main_ambition_sacksettlements = 6,
     phar_main_ambition_destroyfaction_1 = 4,
     phar_main_ambition_destroyfaction_2 = 4,
     phar_main_ambition_destroyfaction_3 = 4,
     phar_main_ambition_getnetpositivefoodincome = 6,
     phar_map_ambition_politicalmarriage = 6,
     phar_map_ambition_scionincourt = 6,
     phar_map_ambition_scionconqueror = 6,
     phar_map_ambition_adoptintodynasty = 6,
     phar_map_ambition_getadoptedintodynasty = 6,
     phar_main_ambition_netfoodincome_1 = 4,
     phar_main_ambition_netfoodincome_2 = 4,
     phar_main_ambition_netfoodincome_3 = 4,
     phar_main_ambition_halfrations = 6,
     phar_main_ambition_buildfoodbuilding = 4,
     phar_main_ambition_buildwoodbuilding = 4,
     phar_main_ambition_buildstonebuilding = 3,
     phar_main_ambition_buildbronzebuilding = 2,
     phar_main_ambition_buildgoldbuilding = 2,
     phar_main_ambition_goldstock_1 = 5,
     phar_main_ambition_goldstock_2 = 5,
     phar_main_ambition_goldstock_3 = 5,
     phar_main_ambition_goldstock_4 = 5,
     phar_main_ambition_positiverealmhappiness = 7,
     phar_main_ambition_increasegrowthinsettlement = 5,
     phar_main_ambition_makebarteragreement = 5,
     phar_main_ambition_bronzeeffort = 6,
     phar_main_ambition_goldeffort = 6,
     phar_main_ambition_stoneeffort = 6,
     phar_main_ambition_helptoeliteunits = 7,
     phar_main_ambition_helptoforeignveteranunits = 7,
     phar_main_ambition_helptomasstactics = 7,
     phar_main_ambition_helptouseyourgeneral = 7,
     phar_main_ambition_raidnearbyenemy = 6,
     phar_main_ambition_chapter1_firstexpansion = 5,
     phar_main_ambition_chapter1_firstchallenge = 5,
     phar_main_ambition_chapter2_legitimacybuildingeffort = 6,
     --	phar_main_ambition_chapter2_goldmakesright = 6 ,
     phar_main_ambition_chapter4_conqueror = 6,
     phar_main_ambition_chapter4_masterofgold = 5,
     phar_main_ambition_chapter5_legionsofdestruction = 5,
     phar_main_ambition_chapter5_survivor = 6,
     phar_main_ambition_ramesseshairlock = 9999999, -- Special
     phar_main_ambition_ramessessuccession = 10,
     phar_main_ambition_confederatetausret = 7,
     phar_main_ambition_confederateseti = 7,
     -- SEA ambitions:
     phar_sea_ambition_become_agriculturalists_tribe = 14,
     phar_sea_ambition_become_artisans_tribe = 14,
     phar_sea_ambition_become_craftsmen_tribe = 14,
     phar_sea_ambition_become_farmers_tribe = 14,
     phar_sea_ambition_become_herdsmen_tribe = 14,
     phar_sea_ambition_become_raiders_tribe = 14,
     phar_sea_ambition_become_ravagers_tribe = 14,
     phar_sea_ambition_become_shepherds_tribe = 14,
     phar_sea_ambition_coastal_champion = 9999999, -- Special: SEA faction initial choice
     phar_sea_ambition_commander_of_the_people = 14,
     phar_sea_ambition_devoted_to_isul = 9999999, -- Special: SEA faction initial choice
     phar_sea_ambition_father_of_the_people = 14,
     phar_sea_ambition_fearsome_conqueror = 14,
     phar_sea_ambition_fire_raiser_of_the_sea_mountains = 9999999, -- Special: SEA faction initial choice
     phar_sea_ambition_follower_of_isul = 9999999,             -- Special: SEA faction initial choice
     phar_sea_ambition_herald_of_collapse = 8,
     phar_sea_ambition_herald_of_crisis = 8,
     phar_sea_ambition_horde_chariot_champion = 8,
     phar_sea_ambition_horde_hunters_champion = 6,
     phar_sea_ambition_horde_melee_champion = 6,
     phar_sea_ambition_horrific_conqueror = 6,
     phar_sea_ambition_inland_pioneer = 9999999,            -- Special: SEA faction initial choice
     phar_sea_ambition_leader_of_the_people = 8,
     phar_sea_ambition_master_of_the_coast_lands = 9999999, -- Special: SEA faction initial choice
     phar_sea_ambition_monstrous_conqueror = 8,
     phar_sea_ambition_protector_of_the_new_lands = 9999999, -- Special: SEA faction initial choice
     phar_sea_ambition_ravager_of_the_inner_kingdoms = 9999999, -- Special: SEA faction initial choice
     phar_sea_ambition_sea_builder = 6,
     phar_sea_ambition_sea_conflagration = 6,
     phar_sea_ambition_sea_plague = 6,
     phar_sea_ambition_son_of_isul = 9999999, -- Special: SEA faction initial choice
}

-- Default tag weights
ambitions.tag_weight_bonus = {
     conqueror = 1,
     strategist = 1,
     warlike = 1,
     raider = 1,
     builder = 1,
     overseer = 1,
     scribe = 1,
     diplomat = 1,
}

-- Bonus weight each tag gives for each faction start
-- Each faction starts with slightly different Tag values, determined by their faction leader profile & identity

ambitions.faction_starting_tag_weight_bonus = {
     ["phar_main_ramesses"] = { conqueror = 4, strategist = 3, warlike = 3, raider = 1, builder = 3, overseer = 1, scribe = 1, diplomat = 2 },
     ["phar_main_seti"] = { conqueror = 3, strategist = 1, warlike = 4, raider = 3, builder = 1, overseer = 1, scribe = 1, diplomat = 1 },
     ["phar_main_amenmesse"] = { conqueror = 1, strategist = 3, warlike = 2, raider = 1, builder = 1, overseer = 4, scribe = 1, diplomat = 3 },
     ["phar_main_tausret"] = { conqueror = 1, strategist = 2, warlike = 1, raider = 1, builder = 3, overseer = 3, scribe = 3, diplomat = 3 },
     ["phar_main_suppiluliuma"] = { conqueror = 1, strategist = 3, warlike = 3, raider = 1, builder = 2, overseer = 1, scribe = 2, diplomat = 2 },
     ["phar_main_kurunta"] = { conqueror = 1, strategist = 1, warlike = 3, raider = 3, builder = 1, overseer = 1, scribe = 2, diplomat = 1 },
     ["phar_main_bay"] = { conqueror = 1, strategist = 2, warlike = 1, raider = 1, builder = 2, overseer = 2, scribe = 4, diplomat = 4 },
     ["phar_main_irsu"] = { conqueror = 2, strategist = 1, warlike = 4, raider = 4, builder = 1, overseer = 1, scribe = 1, diplomat = 1 },
     ["phar_sea_sherden"] = { conqueror = 1, strategist = 3, warlike = 4, raider = 4, builder = 1, overseer = 1, scribe = 1, diplomat = 1 },
     ["phar_sea_peleset"] = { conqueror = 3, strategist = 4, warlike = 3, raider = 3, builder = 1, overseer = 1, scribe = 1, diplomat = 1 },
     ["phar_map_babylon"] = { conqueror = 1, strategist = 3, warlike = 1, raider = 1, builder = 4, overseer = 2, scribe = 3, diplomat = 3 },
     ["phar_map_ninurta"] = { conqueror = 3, strategist = 3, warlike = 4, raider = 2, builder = 1, overseer = 2, scribe = 1, diplomat = 2 },
     ["troy_main_dan_mycenae"] = { conqueror = 4, strategist = 2, warlike = 3, raider = 2, builder = 1, overseer = 2, scribe = 1, diplomat = 1 },
     ["troy_main_trj_troy"] = { conqueror = 1, strategist = 2, warlike = 1, raider = 1, builder = 3, overseer = 2, scribe = 3, diplomat = 4 },
}

--	Ambition Tag names and descriptions
ambitions.tags = {
     conqueror = {
          localised_name_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_conqueror_title",
          localised_description_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_conqueror_desc"
     },
     strategist = {
          localised_name_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_strategist_title",
          localised_description_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_strategist_desc"
     },
     warlike = {
          localised_name_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_warlike_title",
          localised_description_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_warlike_desc"
     },
     raider = {
          localised_name_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_raider_title",
          localised_description_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_raider_desc"
     },
     builder = {
          localised_name_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_builder_title",
          localised_description_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_builder_desc"
     },
     overseer = {
          localised_name_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_overseer_title",
          localised_description_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_overseer_desc"
     },
     scribe = { -- deprecated category DO NOT USE
          localised_name_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_scribe_title",
          localised_description_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_scribe_desc"
     },
     diplomat = { -- deprecated category DO NOT USE
          localised_name_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_diplomat_title",
          localised_description_key = "ui_text_replacements_localised_text_phar_main_ambition_tags_diplomat_desc"
     },
}

-- List of functions that will be checked at the start of a faction's turn
ambitions.defaults.max_ambitions_increase_conditions = {
     --[[
	function(faction_key)
		return cm:turn_number() > 5
	end,
	--]]
}

-- List of functions that will be checked at the start of a faction's turn, faction specific
ambitions.max_ambitions_increase_conditions = {
     --[[
	faction_key = {
		function(faction_key)
			return cm:turn_number() > 5
		end,
	},
--]]
}

local pool_events = ambitions.helper.pool_event
local pool_conditions = ambitions.helper.pool_condition
local conditions = ambitions.helper.condition
local objectives = ambitions.helper.objective
local payloads = ambitions.helper.payload
local scripted_payloads = ambitions.helper.scripted_payload

-- Whitelists the selected ambitions, which in the process blacklists every other one
-- Used for debugging purposes
ambitions.enable_whitelist = false
ambitions.whitelist = {
     -- ambition_key = true
}

-- Ambitions for all factions
ambitions.pools = {
     --[[
	{
		-- The name of the pool
		name = "pool1",

		-- The type of the pool, currently can only be "event_based" or "cooldown_based"
		type = "event_based" or "cooldown_based",

		-- How many ambitions to show to the player to choose
		max_pending_ambitions = 3,

		-- How many ambitions can be active from this pool at any given time
		max_active_ambitions = 1,

		-- You can add bonus ambition slots from technologies using this table.
		-- It takes a table of tables consisting of technology key and the number of addditional slots it provides
		max_pending_ambitions_additional_technology_table = {{"phar_main_tech_civil_17_pillars_points", 1}},

		-- On which turn this pool should start showing ambitions. Only works for "cooldown_based" pools
		start_turn = 5,

		-- This is only used if it's a cooldown_based pool
		-- This is the number of turns that will be waited between ambitions.
		-- Note: the cooldown starts after the last ambition was failed or completed.
		-- Note: cam be overwritten for individual ambitions by adding cooldown_override (see below)
		cooldown = 1,

		-- This is only used if it's an "event_based" pool
		events = {
			{
				event = "FactionTurnStart",
				condition = function(context, faction_key, pool_metadata) end,
				callback = function(context, faction_key, pool_metadata) end,
				persistent = true,
			},
		},

		-- Conditions to see if the pool is valid at all. For instance if we want to enable a
		-- pool only for the tutorial campaign
		conditions = {
			function()
				return cm:get_campaign_name() == "phar_main"
			end,
		},

		-- Conditions that are added to every ambition in this pool. This is different from "conditions" by
		-- not completely disabling the pool for the entire playthrough and instead checking these on every turn.
		additional_ambition_conditions = {
		},

		ambitions = {
			{
				-- Key from the "missions" dave table
				-- Required
				ambition_key = "",

				-- Ambition tags. Used to calculate the weight of the ambition
				-- Choosing ambitions of specific tags makes it more likely to have
				-- ambitions of the same tag to pop up in the future
				tags = { "tag1", "tag2" },

				-- Which factions to not give the ambition to
				-- Optional
				exclude_factions = {	"phar_main_ramesses", "phar_main_seti", "phar_main_amenmesse", "phar_main_tausret",
										"phar_main_bay", "phar_main_irsu", "phar_main_suppiluliuma", "phar_main_kurunta"	},

				-- In how many turns should the ambition expire
				-- Optional. Will use the set up default if missing
				-- A negative number (e.g. "-1") indicates that the ambition will not expire
				expiration = 10,

				-- Optional. Will use the default if not provided
				level = 5,

				-- This should match the states in the UI. Currently they are: common, rare and epic
				-- Optional. Will use the default if not provided
				rarity = "common",

				-- What is needed for the ambition to be added to the pool of ambitions.
				-- Function or list of functions need to be added.
				-- The function will receive the faction script interface as an argument
				-- Optional
				-- e.g. condition = function(faction) return cm:turn_number() > 5 end
				condition = <function> or table,

				-- What is needed for the ambition to be completed.
				-- Table of objectives should be given, similar to objectives in troy_event_chains.lua
				-- Required
				objectives = {table},

				-- Rewards payloads.
				-- Table of payloads should be given, similar to payloads in troy_event_chains.lua
				-- Optional
				reward_payloads = {table},

				-- Scripted reward. Just a lua function
				-- Optional
				reward_scripted = <function>,

				-- Optional (currently mural pieces for ambitions aren't used)
				mural_piece_unlocked = "mural_piece_5",

				-- What the cooldown should be after completing/failing this ambition.
				-- If the ambition has this will ignore the cooldown setting of the pool
				-- Optional
				-- cooldown_override = 5,

				-- How many times this ambition can be selected in a playthrough.
				-- If this config option is missing then the ambition can be selected infinitely
				max_selections = 1,

				-- How many times this ambition can appear in a playthrough.
				-- If this config option is missing then the ambition can appear infinitely
				max_appearances = 1,
			},
		},

		-- This is auto generated and used for faster access to the ambitions
		paired_ambitions = {
			ambition_key = ambition_table,
		},
	}
--]]

     {
          name = "recurrent",
          type = "cooldown_based",
          max_pending_ambitions = 3,
          max_pending_ambitions_additional_technology_table = { { "phar_main_tech_economic_24_ambition_slot", 1 } },
          max_active_ambitions = 1,
          start_turn = 5,
          cooldown = 3,
          conditions = {
               pool_conditions.is_not_tutorial(),
          },
          ambitions = {
               {
                    ambition_key = "phar_main_ambition_completeprovince",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror", "overseer" },
                    exclude_factions = {},
                    condition = {
                         conditions.turn_number_at_most(100),
                         conditions.num_owned_regions_at_most(40),
                         conditions.player_has_province_capital_with_adjacent_enemy_region_in_same_province(),
                    },
                    objectives = {
                         objectives.hold_entirety_of_province_with_enemy(),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   2000},
                              { "troy_wood",   750 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_conquernearbyenemyprovincecapital",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.turn_number_at_most(100),
                         conditions.num_owned_regions_at_most(40),
                         conditions.bordering_regions_at_least(1, { is_province_capital = true, is_enemy = true }),
                    },
                    objectives = {
                         objectives.conquer_region(
                              "mission_text_text_phar_main_ambition_conquernearbyenemyprovincecapital_text_objectives",
                              { is_enemy = true, is_province_capital = true, have_own_region_in_province = true }
                         )
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones", 750 },
                              { "troy_gold",   300 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_conquernearbyfoodsettlement",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_income_at_most("troy_food", 500),
                         conditions.bordering_regions_at_least(1, {
                              production_type = {
                                   "phar_main_settlement_coastal",
                                   "phar_main_settlement_farm",
                                   "phar_main_settlement_nile",
                                   "troy_main_settlement_coastal",
                                   "troy_main_settlement_farm",
                                   "troy_main_settlement_mountain"
                              },
                              is_allied = false
                         }),
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_main_ambition_conquernearbyfoodsettlement_text_objectives", {
                              production_type = {
                                   "phar_main_settlement_coastal",
                                   "phar_main_settlement_farm",
                                   "phar_main_settlement_nile",
                                   "troy_main_settlement_coastal",
                                   "troy_main_settlement_farm",
                                   "troy_main_settlement_mountain"
                              },
                              is_allied = false,
                         })
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food", 2500 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_conquernearbywoodsettlement",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_income_at_most("troy_wood", 500),
                         conditions.bordering_regions_at_least(1, {
                              production_type = {
                                   "phar_main_settlement_lumber",
                                   "phar_main_settlement_nile",
                                   "troy_main_settlement_coastal",
                                   "troy_main_settlement_forest",
                                   "troy_main_settlement_mountain"
                              },
                              is_allied = false
                         }),
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_main_ambition_conquernearbywoodsettlement_text_objectives", {
                              production_type = {
                                   "phar_main_settlement_lumber",
                                   "phar_main_settlement_nile",
                                   "troy_main_settlement_coastal",
                                   "troy_main_settlement_forest",
                                   "troy_main_settlement_mountain"
                              },
                              is_allied = false,
                         })
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_wood", 1250 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_conquernearbystonesettlement",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_income_at_most("troy_stones", 250),
                         conditions.bordering_regions_at_least(1, {
                              production_type = {
                                   "phar_main_settlement_stone",
                                   "troy_main_settlement_stone"
                              },
                              is_allied = false
                         }),
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_main_ambition_conquernearbystonesettlement_text_objectives", {
                              production_type = {
                                   "phar_main_settlement_stone",
                                   "troy_main_settlement_stone"
                              },
                              is_allied = false,
                         })
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones", 1250 },
                         }),
                    }
               },

               {
                    ambition_key = "phar_main_ambition_conquernearbybronzesettlement",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_income_at_most("troy_bronze", 500),
                         conditions.bordering_regions_at_least(1, {
                              production_type = {
                                   "phar_main_settlement_bronze",
                                   "troy_main_settlement_bronze"
                              },
                              is_allied = false
                         }),
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_main_ambition_conquernearbybronzesettlement_text_objectives", {
                              production_type = {
                                   "phar_main_settlement_bronze",
                                   "troy_main_settlement_bronze"
                              },
                              is_allied = false,
                         }),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze", 1250 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_conquernearbygoldsettlement",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_income_at_most("troy_gold", 250),
                         conditions.bordering_regions_at_least(1, {
                              production_type = {
                                   "phar_main_settlement_gold",
                                   "troy_main_settlement_gold"
                              },
                              is_allied = false
                         }),
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_main_ambition_conquernearbygoldsettlement_text_objectives", {
                              production_type = {
                                   "phar_main_settlement_gold",
                                   "troy_main_settlement_gold"
                              },
                              is_allied = false,
                         })
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 625},
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_colonizenearbyregion",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.turn_number_at_most(100),
                         conditions.num_owned_regions_at_least(1),
                         conditions.num_owned_regions_at_most(40),
                         conditions.bordering_regions_at_least(1, { is_abandoned = true })
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_main_ambition_colonize_nearby_settlement_text_objectives",
                              { is_abandoned = true })
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_wood",   365 },
                              { "troy_stones", 180 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_conquernearbysel",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.turn_number_at_most(100),
                         conditions.num_owned_regions_at_most(40),
                         conditions.bordering_regions_at_least(1,
                              { is_subject = false, we_are_subject_of = false, is_allied = false, is_sacred_egyptian = true }),
                         conditions.chosen_legitimacy_path("egyptian"),
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_main_ambition_conquernearbysel_text_objectives",
                              { is_sacred_egyptian = true })
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   3000 },
                              { "troy_gold",   250 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_conquernearbyshl",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.turn_number_at_most(100),
                         conditions.num_owned_regions_at_most(40),
                         conditions.bordering_regions_at_least(1,
                              { is_subject = false, we_are_subject_of = false, is_allied = false, is_sacred_hittite = true }),
                         conditions.chosen_legitimacy_path("hittite"),
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_main_ambition_conquernearbyshl_text_objectives",
                              { is_sacred_hittite = true })
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   2500 },
                              { "troy_bronze", 375 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_conquernearbysal",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.turn_number_at_most(100),
                         conditions.num_owned_regions_at_most(40),
                         conditions.bordering_regions_at_least(1,
                              { is_subject = false, we_are_subject_of = false, is_allied = false, is_sacred_aegean = true }),
                         conditions.chosen_legitimacy_path("aegean"),
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_map_ambition_conquernearbysal_text_objectives",
                              { is_sacred_aegean = true })
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   2500 },
                              { "troy_stones", 375 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_conquernearbysml",
                    expiration = 10,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.turn_number_at_most(100),
                         conditions.num_owned_regions_at_most(40),
                         conditions.bordering_regions_at_least(1,
                              { is_subject = false, we_are_subject_of = false, is_allied = false, is_sacred_mesopotamian = true }),
                         conditions.chosen_legitimacy_path("mesopotamian"),
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_map_ambition_conquernearbysml_text_objectives",
                              { is_sacred_mesopotamian = true })
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   3000 },
                              { "troy_bronze", 325 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_conquernearbypoi",
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.bordering_regions_at_least(1,
                              { is_subject = false, we_are_subject_of = false, is_allied = false, has_POI = true })
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_main_ambition_conquernearbypoi_text_objectives", { has_POI = true })
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   1875 },
                              { "troy_wood",   625 },
                              { "troy_stones", 485 },
                              { "troy_bronze", 625 },
                              { "troy_gold",   245 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_reachterritorysize_1",
                    expiration = 12,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.num_owned_regions_between(3, 4),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_REGIONS_INCLUDING",
                              conditions = {
                                   "total 5"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",  1875 },
                              { "troy_wood",  265 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_reachterritorysize_2",
                    expiration = 15,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.num_owned_regions_between(5, 7),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_REGIONS_INCLUDING",
                              conditions = {
                                   "total 8"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   2650 },
                              { "troy_wood",   415 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_reachterritorysize_3",
                    expiration = 20,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.num_owned_regions_between(8, 10),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_REGIONS_INCLUDING",
                              conditions = {
                                   "total 12"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_wood",   1250 },
                              { "troy_stones", 625 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_reachterritorysize_4",
                    expiration = 20,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.num_owned_regions_between(12, 14),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_REGIONS_INCLUDING",
                              conditions = {
                                   "total 16"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones", 1750 },
                              { "troy_bronze", 1175 },
                         }),
                    },
               },
--bookmark
               {
                    ambition_key = "phar_main_ambition_reachterritorysize_5",
                    expiration = 20,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.num_owned_regions_between(16, 18),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_REGIONS_INCLUDING",
                              conditions = {
                                   "total 22"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones", 2150 },
                              { "troy_gold",   825 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_reachterritorysize_6",
                    expiration = 20,
                    rarity = "common",
                    tags = { "conqueror" },
                    condition = {
                         conditions.num_owned_regions_between(22, 172),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         objectives.own_N_more_regions(8),
                    },
                    reward_payloads = {
                         payloads.victory_points(1),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 1850 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(1),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_reachtotalunits_1",
                    expiration = 10,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.num_units_between(1, 10),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 15"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food", 2650 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_reachtotalunits_2",
                    expiration = 10,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.num_units_between(15, 20),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 25"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   2750 },
                              { "troy_bronze", 85 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_reachtotalunits_3",
                    expiration = 10,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.num_units_between(25, 30),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 40"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   3750 },
                              { "troy_bronze", 250 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_reachtotalunits_4",
                    expiration = 10,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.num_units_between(40, 45),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 55"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   4000 },
                              { "troy_bronze", 600 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_reachtotalunits_5",
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.num_units_at_least(55),
                    },
                    objectives = {
                         objectives.own_N_more_units(20),
                    },
                    reward_payloads = {
                         payloads.victory_points(1),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 1750 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(1),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotalforeignnativeunitsofx", -- Amenmesse Only
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = { -- Native Kush/Nubia & Libu units, any tier
                         conditions.is_target_faction("phar_main_amenmesse"),
                         conditions.num_units_at_most(5, { unit_set = { "phar_main_egypt_foreign_recruit_natives" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 8",
                                   "unit_set phar_main_egypt_foreign_recruit_natives",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_main_ambition_havetotalforeignnativeunitsofx_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalforeignnativeunitsofx_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                         "effect_bundle{ bundle_key phar_main_ambition_havetotalforeignnativeunitsofx_effect_bundle; turns 15; }",
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(6, {
                              { "phar_main_fac_amen_kushite_royal_guard",       2 },
                              { "phar_main_fac_amen_ta_seti_longbowmen",        6 },
                              { "phar_main_nat_nub_renowned_kushite_archers",   10 },
                              { "phar_main_nat_nub_renowned_nubian_longbowmen", 10 },
                         }, 2)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotallocalnativeunitsofegypt",
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.have_regions_in_realm_at_least(1, {
                              realms = {
                                   "egyptian_lower_egypt_realm",
                                   "egyptian_upper_egypt_realm",
                                   "egyptian_western_desert_realm",
                                   "egyptian_nubia_realm",
                                   "egyptian_kush_realm"
                              }
                         }),
                         conditions.num_units_at_most(5, { unit_set = { "phar_main_native_egypt" } })
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 8",
                                   "unit_set phar_main_native_egypt",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_main_ambition_havetotallocalnativeunitsofegypt_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotallocalnativeunitsofegypt_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(10, {
                              { "phar_main_nat_upp_upper_egyptian_khopesh_warriors",  3 },
                              { "phar_main_nat_upp_upper_egyptian_mace_axe_warriors", 3 },
                              { "phar_main_nat_upp_upper_egyptian_renowned_archers",  3 },
                              { "phar_main_nat_upp_egyptian_chariots",                1 },
                              { "phar_main_nat_upp_upper_egyptian_swordsmen",         8 },
                              { "phar_main_nat_upp_upper_egyptian_spearmen",          8 },
                              { "phar_main_nat_upp_upper_egyptian_javelin_throwers",  2 },
                              { "phar_main_nat_low_egyptian_chariots",                1 },
                              { "phar_main_nat_low_lower_egyptian_veteran_swordsmen", 3 },
                              { "phar_main_nat_low_lower_egyptian_veteran_spearmen",  3 },
                              { "phar_main_nat_low_armoured_lower_egyptian_archers",  3 },
                              { "phar_main_nat_low_egyptian_light_chariots",          3 },
                              { "phar_main_fac_taus_egyptian_axemen",                 8 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotallocalnativeunitsofcanaan",
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.have_regions_in_realm_at_least(1, {
                              realms = {
                                   "canaanite_yamhad_realm",
                                   "canaanite_retjenu_realm",
                                   "canaanite_fenkhu_realm",
                                   "canaanite_sinai_realm"
                              }
                         }),
                         conditions.num_units_at_most(5, { unit_set = { "phar_main_native_canaan" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 8",
                                   "unit_set phar_main_native_canaan",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_main_ambition_havetotallocalnativeunitsofcanaan_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotallocalnativeunitsofcanaan_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(10, {
                              { "phar_main_fac_bay_canaanite_spearmen",              8 },
                              { "phar_main_fac_bay_veteran_canaanite_warriors",      3 },
                              { "phar_main_fac_bay_veteran_canaanite_slingers",      4 },
                              { "phar_main_nat_fen_renowned_canaanite_swordsmen",    1 },
                              { "phar_main_nat_fen_veteran_canaanite_shieldbearers", 3 },
                              { "phar_main_nat_fen_armoured_syrian_archers",         3 },
                              { "phar_main_nat_fen_armoured_canaanite_chariots",     2 },
                              { "phar_main_nat_fen_veteran_canaanite_swordsmen",     3 },
                              { "phar_main_nat_fen_light_syrian_archers",            8 },
                              { "phar_main_fac_irsu_canaanite_chariots",             3 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotallocalnativeunitsofhatti",
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.have_regions_in_realm_at_least(1, {
                              realms = {
                                   "hittite_lowlands_realm",
                                   "hittite_highlands_realm",
                                   "hittite_isuwa_realm"
                              }
                         }),
                         conditions.num_units_at_most(5, { unit_set = { "phar_main_native_hittite" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 8",
                                   "unit_set phar_main_native_hittite",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_main_ambition_havetotallocalnativeunitsofhatti_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotallocalnativeunitsofhatti_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(10, {
                              { "phar_main_fac_sup_veteran_hittite_swordsmen",    5 },
                              { "phar_main_fac_sup_hittite_axemen",               5 },
                              { "phar_main_fac_kuru_hittite_spearmen",            4 },
                              { "phar_main_fac_sup_armored_hittite_archers",      3 },
                              { "phar_main_fac_kuru_hittite_chariots",            4 },
                              { "phar_main_nat_isu_armoured_anatolian_swordsmen", 5 },
                              { "phar_main_nat_hig_heavy_anatolian_chariots",     2 },
                              { "phar_main_nat_isu_armoured_hittite_skirmishers", 4 },
                              { "phar_main_nat_hig_armoured_anatolian_spears",    4 },
                              { "phar_main_nat_isu_hittite_archers",              8 },
                              { "phar_main_fac_kuru_hittite_chargers",            3 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_map_ambition_havetotallocalnativeunitsofmesopotamia",
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.have_regions_in_realm_at_least(1, {
                              realms = {
                                   "mesopotamia_haltamti_realm",
                                   "mesopotamia_mat_assur_realm",
                                   "mesopotamia_mat_tamti_realm",
                                   "mesopotamia_zagros_realm",
                                   "mesopotamia_aber_nahra_realm"
                              }
                         }),
                         conditions.num_units_at_most(5, { unit_set = { "phar_map_native_mesopotamia" } })
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 8",
                                   "unit_set phar_map_native_mesopotamia",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_map_ambition_havetotallocalnativeunitsofmesopotamia_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_map_ambition_havetotallocalnativeunitsofmesopotamia_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(10, {
                              { "phar_map_nat_aber_aramean_warriors",            4 },
                              { "phar_map_nat_aber_aramean_elite",               2 },
                              { "phar_map_nat_aber_aramean_skirmishers",         3 },
                              { "phar_map_nat_assur_akkadian_chargers",          2 },
                              { "phar_map_nat_assur_akkadian_defenders",         1 },
                              { "phar_map_nat_assur_akkadian_skirmishers",       8 },
                              { "phar_map_nat_halt_elamite_vanguard",            3 },
                              { "phar_map_nat_halt_elamite_veterans",            1 },
                              { "phar_map_nat_halt_elamite_veteran_slingers",    2 },
                              { "phar_map_nat_tamti_akkadian_axemen",            8 },
                              { "phar_map_nat_tamti_akkadian_armoured_archers",  1 },
                              { "phar_map_nat_zag_urartu_warriors",              8 },
                              { "phar_map_nat_zag_urartu_guard",                 1 },
                              { "phar_map_nat_zag_urartu_archers",               3 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_map_ambition_havetotallocalnativeunitsofaegea",
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.have_regions_in_realm_at_least(1, {
                              realms = {
                                   "aegean_assuwa_realm",
                                   "aegean_thrace_realm",
                                   "aegean_achaea_realm"
                              }
                         }),
                         conditions.num_units_at_most(5, { unit_set = { "phar_map_native_aegea" } })
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 8",
                                   "unit_set phar_map_native_aegea",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_map_ambition_havetotallocalnativeunitsofaegea_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_map_ambition_havetotallocalnativeunitsofaegea_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(10, {
                              { "phar_map_nat_ach_laconian_hillmen",            3 },
                              { "phar_map_nat_ach_aeginian_runners",            8 },
                              { "phar_map_nat_ach_shielded_spearmen",           1 },
                              { "phar_map_nat_ach_achaean_javelinmen",          4 },
                              { "phar_map_nat_ach_veteran_achaean_slingers",    3 },
                              { "phar_map_nat_thr_thracian_spearmen",           8 },
                              { "phar_map_nat_thr_thracian_guard",              3 },
                              { "phar_map_nat_thr_thracian_archers",            1 },
                              { "phar_map_nat_wil_heavy_shock_spears",          1 },
                              { "phar_map_nat_wil_heavy_trojan_spearmen",       2 },
                              { "phar_map_nat_wil_veteran_trojan_slingers",     4 },
                              { "phar_map_nat_wil_armoured_lycian_archers",     1 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotalchariotunitsegypt", -- Only Egyptians
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_main_ramesses"),
                              conditions.is_target_faction("phar_main_seti"),
                              conditions.is_target_faction("phar_main_amenmesse"),
                              conditions.is_target_faction("phar_main_tausret"),
                              conditions.is_target_faction("phar_main_merneptah"),
                              conditions.is_target_faction("phar_main_setnakhte"),
                              conditions.is_target_faction("phar_main_napata"),
                              conditions.is_target_faction("phar_main_dungul"),
                              conditions.is_target_faction("phar_main_bahariya"),
                         }),
                         conditions.num_units_between(1, 3, { unit_set = { "phar_main_chariots_all" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 6",
                                   "unit_set phar_main_chariots_all",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_main_ambition_havetotalchariotunitsegypt_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalchariotunitsegypt_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(5, {
                              { "phar_main_fac_irsu_canaanite_chariots",         1 },
                              { "phar_main_fac_irsu_maryannu_chariots",          1 },
                              { "phar_main_nat_fen_armoured_canaanite_chariots", 4 },
                              { "phar_main_fac_ram_seneni_chariots",             8 },
                              { "phar_main_fac_amen_nubian_chariots",            8 },
                              { "phar_main_fac_taus_seneni_light_chariots",      8 },
                              { "phar_main_fac_seti_egyptian_melee_chariots",    8 },
                              { "phar_main_fac_amen_kushite_chariots",           8 },
                              { "phar_main_fac_taus_elite_javelin_chariots",     8 },
                              { "phar_main_fac_taus_javelin_chariots",           10 },
                              { "phar_main_fac_ram_archer_chariots",             15 },
                              { "phar_main_nat_low_egyptian_chariots",           15 },
                              { "phar_main_nat_upp_egyptian_chariots",           15 },
                              { "phar_main_nat_low_light_egyptian_chariots",     20 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotalchariotunitscanaan", -- Only Canaanites
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_main_bay"),
                              conditions.is_target_faction("phar_main_irsu"),
                              conditions.is_target_faction("phar_main_ugarit"),
                              conditions.is_target_faction("phar_main_ashkelon"),
                              conditions.is_target_faction("phar_main_byblos"),
                              conditions.is_target_faction("phar_main_damascus"),
                              conditions.is_target_faction("phar_main_emar"),
                         }),
                         conditions.num_units_between(1, 3, { unit_set = { "phar_main_chariots_all" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 6",
                                   "unit_set phar_main_chariots_all",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_main_ambition_havetotalchariotunitscanaan_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalchariotunitscanaan_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(5, {
                              { "phar_main_fac_sup_reinforced_hittite_chariots",  1 },
                              { "phar_main_fac_irsu_maryannu_chariots",           6 },
                              { "phar_main_fac_kuru_armored_kaskian_chariots",    1 },
                              { "phar_main_fac_ram_seneni_chariots",              2 },
                              { "phar_main_fac_taus_seneni_light_chariots",       2 },
                              { "phar_main_fac_amen_kushite_chariots",            1 },
                              { "phar_main_fac_seti_egyptian_melee_chariots",     2 },
                              { "phar_main_nat_hig_heavy_anatolian_chariots",     3 },
                              { "phar_main_fac_kuru_hittite_chariots",            2 },
                              { "phar_main_fac_amen_nubian_chariots",             1 },
                              { "phar_main_nat_fen_armoured_canaanite_chariots",  8 },
                              { "phar_main_nat_low_egyptian_chariots",            8 },
                              { "phar_main_fac_irsu_canaanite_chariots",          15 },
                              { "phar_main_fac_kuru_skirmisher_kaskian_chariots", 4 },
                              { "phar_main_fac_taus_elite_javelin_chariots",      4 },
                              { "phar_main_fac_ram_archer_chariots",              8 },
                              { "phar_main_nat_low_light_egyptian_chariots",      10 },
                              { "phar_main_fac_taus_javelin_chariots",            5 },
                              { "phar_map_fac_ash_assur_chariots",                8 },
                              { "phar_map_fac_bab_babylonian_chariots",           3 },
                              { "phar_map_fac_bab_babylonian_nobles",             1 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotalchariotunitshatti", -- Only Hittites
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_main_suppiluliuma"),
                              conditions.is_target_faction("phar_main_kurunta"),
                              conditions.is_target_faction("phar_main_carchemish"),
                              conditions.is_target_faction("troy_amazons_trj_hippolyta"),
                              conditions.is_target_faction("phar_main_alashiya"),
                              conditions.is_target_faction("phar_main_malidiya"),
                              conditions.is_target_faction("phar_map_sangarian_phrygians"),
                         }),
                         conditions.num_units_between(1, 3, { unit_set = { "phar_main_chariots_all" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 6",
                                   "unit_set phar_main_chariots_all",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_main_ambition_havetotalchariotunitshatti_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalchariotunitshatti_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(5, {
                              { "phar_main_fac_sup_reinforced_hittite_chariots",  2 },
                              { "phar_main_fac_irsu_maryannu_chariots",           1 },
                              { "phar_main_fac_kuru_armored_kaskian_chariots",    2 },
                              { "phar_main_nat_hig_heavy_anatolian_chariots",     6 },
                              { "phar_main_fac_kuru_hittite_chariots",            20 },
                              { "phar_main_nat_fen_armoured_canaanite_chariots",  6 },
                              { "phar_main_fac_irsu_canaanite_chariots",          5 },
                              { "phar_main_fac_kuru_skirmisher_kaskian_chariots", 10 },
                              { "phar_map_fac_ash_assur_chariots",                8 },
                              { "phar_map_fac_bab_babylonian_chariots",           3 },
                              { "phar_map_fac_bab_babylonian_nobles",             1 },
                              { "phar_map_fac_myc_skirmish_chariots",             6 },
                              { "phar_map_fac_myc_heavy_reinforced_chariots",     3 },
                              { "phar_map_fac_troy_heavy_trojan_chariots",        6 },
                              { "phar_map_fac_troy_trojan_noble_chariots",        4 },
                              { "phar_map_nat_ach_achaean_chariots",              7 },
                              { "phar_map_nat_thr_thracian_light_chariots",       8 },
                              { "phar_map_nat_thr_thracian_chariots",             6 },
                              { "phar_map_nat_thr_thorns_of_thrace",              4 },
                              { "phar_map_nat_wil_trojan_chariots",               6 },
                              { "phar_map_nat_wil_archer_chariots",               4 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_map_ambition_havetotalchariotunitsmesopotamia", -- Only Mesopotamians
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_map_babylon"),
                              conditions.is_target_faction("phar_map_ninurta"),
                              conditions.is_target_faction("phar_map_assyria"),
                              conditions.is_target_faction("phar_map_igihalkid"),
                              conditions.is_target_faction("phar_map_lullubi"),
                              conditions.is_target_faction("phar_map_shubru"),
                              conditions.is_target_faction("phar_map_sutu"),
                         }),
                         conditions.num_units_between(1, 3, { unit_set = { "phar_main_chariots_all" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 6",
                                   "unit_set phar_main_chariots_all",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_map_ambition_havetotalchariotunitsmesopotamia_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_map_ambition_havetotalchariotunitsmesopotamia_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(5, {
                              { "phar_main_fac_irsu_canaanite_chariots",          5 },
                              { "phar_main_fac_irsu_maryannu_chariots",           1 },
                              { "phar_main_fac_kuru_skirmisher_kaskian_chariots", 5 },
                              { "phar_main_fac_kuru_hittite_chariots",            5 },
                              { "phar_main_fac_kuru_armored_kaskian_chariots",    1 },
                              { "phar_main_fac_sup_hittite_chariots",             5 },
                              { "phar_main_fac_sup_reinforced_hittite_chariots",  1 },
                              { "phar_map_fac_ash_assur_chariots",                10 },
                              { "phar_map_fac_ash_assur_horse_archers",           2 },
                              { "phar_map_fac_bab_babylonian_chariots",           10 },
                              { "phar_map_fac_bab_babylonian_nobles",             2 },
                              { "phar_main_nat_fen_armoured_canaanite_chariots",  5 },
                              { "phar_main_nat_hig_heavy_anatolian_chariots",     5 },
                              { "phar_main_nat_isu_heavy_anatolian_chariots",     5 },
                              { "phar_map_nat_aber_ahlamu_heavy_camelry",         5 },
                              { "phar_map_nat_assur_akkadian_horsemen",           7 },
                              { "phar_map_nat_tamti_akkadian_horsemen",           7 },
                              { "phar_map_nat_zag_cimmerian_mounted_warriors",    7 },
                              { "phar_map_nat_zag_cimmerian_elite",               3 },
                              { "phar_map_nat_zag_cimmerian_horse_archers",       7 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_map_ambition_havetotalchariotunitsaegea", -- Only Aegeans
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("troy_main_dan_mycenae"),
                              conditions.is_target_faction("troy_main_trj_troy"),
                              conditions.is_target_faction("troy_main_dan_achilles"),
                              conditions.is_target_faction("troy_main_dan_ithaca"),
                              conditions.is_target_faction("troy_main_trj_lycia"),
                              conditions.is_target_faction("troy_rem_trj_thrace"),
                              conditions.is_target_faction("troy_main_dan_boeotians"),
                         }),
                         conditions.num_units_between(1, 3, { unit_set = { "phar_main_chariots_all" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 6",
                                   "unit_set phar_main_chariots_all",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_map_ambition_havetotalchariotunitsaegea_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_map_ambition_havetotalchariotunitsaegea_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(5, {
                              { "phar_main_fac_sup_hittite_chariots",              5 },
                              { "phar_main_fac_sup_reinforced_hittite_chariots",   1 },
                              { "phar_main_fac_kuru_skirmisher_kaskian_chariots",  5 },
                              { "phar_main_fac_kuru_hittite_chariots",             5 },
                              { "phar_main_fac_kuru_armored_kaskian_chariots",     1 },
                              { "phar_map_fac_myc_skirmish_chariots",              7 },
                              { "phar_map_fac_myc_heavy_reinforced_chariots",      4 },
                              { "phar_map_fac_troy_heavy_trojan_chariots",         4 },
                              { "phar_map_fac_troy_trojan_noble_chariots",         2 },
                              { "phar_map_nat_ach_achaean_chariots",               8 },
                              { "phar_map_nat_thr_thracian_light_chariots",        10 },
                              { "phar_map_nat_thr_thracian_chariots",              8 },
                              { "phar_map_nat_thr_thorns_of_thrace",               5 },
                              { "phar_map_nat_wil_trojan_chariots",                8 },
                              { "phar_map_nat_wil_archer_chariots",                5 },
                              { "phar_main_nat_hig_heavy_anatolian_chariots",      5 },
                              { "phar_main_nat_isu_heavy_anatolian_chariots",      5 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotalrangedunitsegypt", -- Only Egyptians
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_main_ramesses"),
                              conditions.is_target_faction("phar_main_seti"),
                              conditions.is_target_faction("phar_main_amenmesse"),
                              conditions.is_target_faction("phar_main_tausret"),
                              conditions.is_target_faction("phar_main_merneptah"),
                              conditions.is_target_faction("phar_main_setnakhte"),
                              conditions.is_target_faction("phar_main_napata"),
                              conditions.is_target_faction("phar_main_dungul"),
                              conditions.is_target_faction("phar_main_bahariya"),
                         }),
                         conditions.num_units_at_most(5, { unit_set = { "phar_main_ranged_infantry" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 10",
                                   "unit_set phar_main_ranged_infantry",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_main_ambition_havetotalrangedunitsegypt_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalrangedunitsegypt_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(5, {
                              { "phar_main_nat_nub_renowned_kushite_archers",        1 },
                              { "phar_main_nat_upp_upper_egyptian_renowned_archers", 1 },
                              { "phar_main_nat_fen_armoured_syrian_archers",         2 },
                              { "phar_main_fac_bay_canaanite_ambushers",             1 },
                              { "phar_main_fac_bay_veteran_canaanite_slingers",      1 },
                              { "phar_main_nat_sin_renowned_habiru_slingers",        2 },
                              { "phar_main_nat_nub_renowned_nubian_longbowmen",      8 },
                              { "phar_main_nat_wes_libu_composite_bowmen",           8 },
                              { "phar_main_fac_seti_veteran_levy_javelinmen",        2 },
                              { "phar_main_nat_sin_habiru_skirmishers",              2 },
                              { "phar_main_fac_ram_elite_medjai_archers",            6 },
                              { "phar_main_fac_ram_sherden_raiders",                 3 },
                              { "phar_main_nat_fen_light_syrian_archers",            10 },
                              { "phar_main_nat_nub_nubian_longbowmen",               15 },
                              { "phar_main_fac_ram_medjai_archers",                  15 },
                              { "phar_main_nat_upp_upper_egyptian_javelin_throwers", 5 },
                              { "phar_main_nat_wes_libu_desert_skirmishers",         5 },
                              { "phar_main_nat_sin_shasu_archers",                   8 },
                              { "phar_main_fac_bay_canaanite_slingers",              5 },
                              { "phar_main_fac_seti_levy_bowmen",                    20 },
                              { "phar_main_fac_taus_egyptian_archers_axe",           10 },
                              { "phar_main_fac_taus_egyptian_archers_club",          10 },
                              { "phar_main_nat_nub_kushite_archers",                 20 },
                              { "phar_main_fac_irsu_canaanite_bowmen",               3 },
                              { "phar_main_fac_bay_canaanite_javelins",              5 },
                              { "phar_main_nat_wes_libu_hunters",                    10 },
                              { "phar_main_fac_seti_levy_javelinmen",                10 },
                              { "phar_main_nat_upp_upper_egyptian_archers",          25 },
                              { "phar_main_nat_fen_canaanite_skirmishers",           8 },
                              { "phar_main_nat_sin_habiru_archers",                  10 },
                              { "phar_main_nat_nub_nubian_bowmen",                   20 },
                              { "phar_main_nat_nub_nubian_hunters",                  8 },
                              { "phar_main_nat_fen_canaanite_rock_throwers",         8 },
                              { "phar_main_nat_upp_upper_egyptian_militia_slingers", 20 },
                              { "phar_main_nat_wes_libu_slingers",                   20 },
                              { "phar_main_sea_aegean_armoured_archers",             1 },
                              { "phar_main_sea_aegean_armoured_javelin_throwers",    2 },
                              { "phar_main_sea_marauder_slingers",                   2 },
                              { "phar_main_sea_aegean_light_archers",                4 },
                              { "phar_main_sea_seafaring_javelinmen",                4 },
                              { "phar_main_sea_seafaring_slings",                    8 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotalrangedunitscanaan", -- Only Canaanites
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_main_bay"),
                              conditions.is_target_faction("phar_main_irsu"),
                              conditions.is_target_faction("phar_main_ugarit"),
                              conditions.is_target_faction("phar_main_ashkelon"),
                              conditions.is_target_faction("phar_main_byblos"),
                              conditions.is_target_faction("phar_main_damascus"),
                              conditions.is_target_faction("phar_main_emar"),
                         }),
                         conditions.num_units_at_most(5, { unit_set = { "phar_main_ranged_infantry" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 10",
                                   "unit_set phar_main_ranged_infantry",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_main_ambition_havetotalrangedunitscanaan_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalrangedunitscanaan_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(5, {
                              { "phar_main_nat_nub_renowned_kushite_archers",           1 },
                              { "phar_main_nat_upp_upper_egyptian_renowned_archers",    3 },
                              { "phar_main_fac_amen_ta_seti_longbowmen",                5 },
                              { "phar_main_fac_amen_kushite_armored_archers",           5 },
                              { "phar_main_nat_fen_armoured_syrian_archers",            1 },
                              { "phar_main_nat_hig_renowned_phrygian_javelin_throwers", 3 },
                              { "phar_main_fac_bay_canaanite_ambushers",                5 },
                              { "phar_main_fac_bay_veteran_canaanite_slingers",         5 },
                              { "phar_main_nat_sin_renowned_habiru_slingers",           1 },
                              { "phar_main_nat_isu_armoured_hittite_skirmishers",       3 },
                              { "phar_main_nat_nub_renowned_nubian_longbowmen",         5 },
                              { "phar_main_nat_wes_libu_composite_bowmen",              5 },
                              { "phar_main_fac_sup_armored_hittite_archers",            1 },
                              { "phar_main_fac_seti_veteran_levy_javelinmen",           3 },
                              { "phar_main_nat_sin_habiru_skirmishers",                 5 },
                              { "phar_main_nat_isu_hittite_archers",                    5 },
                              { "phar_main_nat_low_armoured_lower_egyptian_archers",    1 },
                              { "phar_main_fac_ram_elite_medjai_archers",               3 },
                              { "phar_main_nat_hig_phrygian_skirmishers",               5 },
                              { "phar_main_fac_ram_sherden_raiders",                    5 },
                              { "phar_main_nat_fen_light_syrian_archers",               1 },
                              { "phar_main_nat_nub_nubian_longbowmen",                  3 },
                              { "phar_main_fac_ram_medjai_archers",                     5 },
                              { "phar_main_nat_upp_upper_egyptian_javelin_throwers",    5 },
                              { "phar_main_nat_wes_libu_desert_skirmishers",            1 },
                              { "phar_main_nat_sin_shasu_archers",                      3 },
                              { "phar_main_fac_amen_nubian_mercenary_bowmen",           5 },
                              { "phar_main_fac_bay_canaanite_slingers",                 5 },
                              { "phar_main_fac_seti_levy_bowmen",                       1 },
                              { "phar_main_fac_taus_egyptian_archers_axe",              3 },
                              { "phar_main_fac_taus_egyptian_archers_club",             5 },
                              { "phar_main_nat_nub_kushite_archers",                    5 },
                              { "phar_main_fac_amen_nubian_slingers",                   1 },
                              { "phar_main_fac_irsu_canaanite_bowmen",                  3 },
                              { "phar_main_fac_bay_canaanite_javelins",                 5 },
                              { "phar_main_nat_wes_libu_hunters",                       5 },
                              { "phar_main_fac_seti_levy_javelinmen",                   5 },
                              { "phar_main_nat_low_lower_egyptian_archers",             5 },
                              { "phar_main_nat_upp_upper_egyptian_archers",             5 },
                              { "phar_main_nat_fen_canaanite_skirmishers",              5 },
                              { "phar_main_fac_amen_kushite_archers",                   5 },
                              { "phar_main_fac_sup_hittite_archers",                    5 },
                              { "phar_main_fac_sup_hittite_slingers",                   5 },
                              { "phar_main_nat_sin_habiru_archers",                     5 },
                              { "phar_main_nat_nub_nubian_bowmen",                      5 },
                              { "phar_main_nat_hig_kaskian_javelin_throwers",           5 },
                              { "phar_main_nat_nub_nubian_hunters",                     5 },
                              { "phar_main_nat_fen_canaanite_rock_throwers",            5 },
                              { "phar_main_nat_isu_isuwan_slingers",                    5 },
                              { "phar_main_nat_low_lower_egyptian_militia_slingers",    5 },
                              { "phar_main_nat_upp_upper_egyptian_militia_slingers",    5 },
                              { "phar_main_nat_wes_libu_slingers",                      5 },
                              { "phar_main_sea_aegean_armoured_archers",                1 },
                              { "phar_main_sea_aegean_armoured_javelin_throwers",       2 },
                              { "phar_main_sea_marauder_slingers",                      2 },
                              { "phar_main_sea_aegean_light_archers",                   4 },
                              { "phar_main_sea_seafaring_javelinmen",                   4 },
                              { "phar_main_sea_seafaring_slings",                       8 },
                              { "phar_map_fac_ash_assur_levy_archers",                  5 },
                              { "phar_map_fac_ash_harran_archers",                      3 },
                              { "phar_map_fac_bab_siluhlu_slingers",                    5 },
                              { "phar_map_fac_bab_siraku_archers",                      3 },
                              { "phar_map_fac_bab_babylonian_archers",                  3 },
                              { "phar_map_nat_aber_ahlamu_archers",                     5 },
                              { "phar_map_nat_aber_aramean_skirmishers",                3 },
                              { "phar_map_nat_assur_akkadian_hunters",                  5 },
                              { "phar_map_nat_assur_akkadian_skirmishers",              3 },
                              { "phar_map_nat_halt_elamite_bowmen",                     5 },
                              { "phar_map_nat_halt_elamite_slingers",                   5 },
                              { "phar_map_nat_halt_elamite_veteran_archers",            3 },
                              { "phar_map_nat_halt_elamite_veteran_slingers",           3 },
                              { "phar_map_nat_tamti_akkadian_archers",                  5 },
                              { "phar_map_nat_tamti_akkadian_armoured_archers",         3 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotalrangedunitshatti", -- Only Hittites
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_main_suppiluliuma"),
                              conditions.is_target_faction("phar_main_kurunta"),
                              conditions.is_target_faction("phar_main_carchemish"),
                              conditions.is_target_faction("troy_amazons_trj_hippolyta"),
                              conditions.is_target_faction("phar_main_alashiya"),
                              conditions.is_target_faction("phar_main_malidiya"),
                              conditions.is_target_faction("phar_map_sangarian_phrygians"),
                         }),
                         conditions.num_units_at_most(5, { unit_set = { "phar_main_ranged_infantry" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 10",
                                   "unit_set phar_main_ranged_infantry",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_main_ambition_havetotalrangedunitshatti_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalrangedunitshatti_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                },
                    --bookmark
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(5, {
                              { "phar_main_nat_fen_armoured_syrian_archers",            1 },
                              { "phar_main_nat_hig_renowned_phrygian_javelin_throwers", 3 },
                              { "phar_main_fac_bay_canaanite_ambushers",                5 },
                              { "phar_main_fac_bay_veteran_canaanite_slingers",         5 },
                              { "phar_main_nat_sin_renowned_habiru_slingers",           1 },
                              { "phar_main_nat_isu_armoured_hittite_skirmishers",       3 },
                              { "phar_main_fac_sup_armored_hittite_archers",            5 },
                              { "phar_main_nat_sin_habiru_skirmishers",                 5 },
                              { "phar_main_nat_isu_hittite_archers",                    1 },
                              { "phar_main_nat_hig_phrygian_skirmishers",               3 },
                              { "phar_main_nat_fen_light_syrian_archers",               5 },
                              { "phar_main_nat_sin_shasu_archers",                      5 },
                              { "phar_main_fac_bay_canaanite_slingers",                 1 },
                              { "phar_main_fac_irsu_canaanite_bowmen",                  3 },
                              { "phar_main_fac_bay_canaanite_javelins",                 5 },
                              { "phar_main_nat_fen_canaanite_skirmishers",              5 },
                              { "phar_main_fac_sup_hittite_archers",                    1 },
                              { "phar_main_fac_sup_hittite_slingers",                   3 },
                              { "phar_main_nat_sin_habiru_archers",                     5 },
                              { "phar_main_nat_hig_kaskian_javelin_throwers",           5 },
                              { "phar_main_nat_fen_canaanite_rock_throwers",            1 },
                              { "phar_main_nat_isu_isuwan_slingers",                    3 },
                              { "phar_main_sea_aegean_armoured_archers",                1 },
                              { "phar_main_sea_aegean_armoured_javelin_throwers",       2 },
                              { "phar_main_sea_marauder_slingers",                      2 },
                              { "phar_main_sea_aegean_light_archers",                   4 },
                              { "phar_main_sea_seafaring_javelinmen",                   4 },
                              { "phar_main_sea_seafaring_slings",                       8 },
                              { "phar_map_fac_ash_assur_levy_archers",                  5 },
                              { "phar_map_fac_ash_harran_archers",                      3 },
                              { "phar_map_fac_bab_siluhlu_slingers",                    4 },
                              { "phar_map_fac_bab_siraku_archers",                      2 },
                              { "phar_map_fac_bab_babylonian_archers",                  2 },
                              { "phar_map_nat_aber_ahlamu_archers",                     5 },
                              { "phar_map_nat_aber_aramean_skirmishers",                3 },
                              { "phar_map_nat_assur_akkadian_hunters",                  4 },
                              { "phar_map_nat_assur_akkadian_skirmishers",              3 },
                              { "phar_map_nat_halt_elamite_bowmen",                     3 },
                              { "phar_map_nat_halt_elamite_slingers",                   3 },
                              { "phar_map_nat_halt_elamite_veteran_archers",            1 },
                              { "phar_map_nat_halt_elamite_veteran_slingers",           1 },
                              { "phar_map_nat_tamti_akkadian_archers",                  4 },
                              { "phar_map_nat_tamti_akkadian_armoured_archers",         2 },
                              { "phar_map_nat_ach_achaean_stoneslingers",               5 },
                              { "phar_map_nat_ach_achaean_bowmen",                      4 },
                              { "phar_map_nat_ach_achaean_javelinmen",                  3 },
                              { "phar_map_nat_ach_veteran_achaean_slingers",            1 },
                              { "phar_map_nat_thr_forest_skirmishers",                  5 },
                              { "phar_map_nat_thr_thracian_hunters",                    3 },
                              { "phar_map_nat_thr_thracian_archers",                    2 },
                              { "phar_map_fac_myc_heavy_islander_skirmishers",          4 },
                              { "phar_map_fac_myc_heavy_mycenaen_bowmen",               3 },
                              { "phar_map_fac_myc_islander_skirmishers",                1 },
                              { "phar_map_fac_troy_trojan_stoneslingers",               5 },
                              { "phar_map_fac_troy_veteran_trojan_archers",             4 },
                              { "phar_map_fac_troy_elite_trojan_slingers",              3 },
                              { "phar_map_fac_troy_par_trojan_nobles",                  1 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_map_ambition_havetotalrangedunitsmesopotamia", -- Only Mesopotamians
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_map_babylon"),
                              conditions.is_target_faction("phar_map_ninurta"),
                              conditions.is_target_faction("phar_map_assyria"),
                              conditions.is_target_faction("phar_map_igihalkid"),
                              conditions.is_target_faction("phar_map_lullubi"),
                              conditions.is_target_faction("phar_map_shubru"),
                              conditions.is_target_faction("phar_map_sutu"),
                         }),
                         conditions.num_units_at_most(5, { unit_set = { "phar_main_ranged_infantry" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 10",
                                   "unit_set phar_main_ranged_infantry",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_map_ambition_havetotalrangedunitsmesopotamia_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_map_ambition_havetotalrangedunitsmesopotamia_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(5, {
                              { "phar_main_fac_bay_canaanite_ambushers",                 4 },
                              { "phar_main_fac_bay_veteran_canaanite_slingers",          4 },
                              { "phar_main_fac_bay_canaanite_javelins",                  6 },
                              { "phar_main_fac_bay_canaanite_slingers",                  5 },
                              { "phar_main_fac_sup_armored_hittite_archers",             4 },
                              { "phar_main_fac_sup_hittite_archers",                     6 },
                              { "phar_main_fac_sup_hittite_slingers",                    6 },
                              { "phar_main_fac_irsu_canaanite_bowmen",                   6 },
                              { "phar_main_nat_hig_renowned_phrygian_javelin_throwers",  5 },
                              { "phar_main_nat_hig_phrygian_skirmishers",                6 },
                              { "phar_main_nat_hig_kaskian_javelin_throwers",            8 },
                              { "phar_main_nat_fen_armoured_syrian_archers",             5 },
                              { "phar_main_nat_fen_light_syrian_archers",                6 },
                              { "phar_main_nat_fen_canaanite_skirmishers",               7 },
                              { "phar_main_nat_fen_canaanite_rock_throwers",             8 },
                              { "phar_main_nat_isu_armoured_hittite_skirmishers",        6 },
                              { "phar_main_nat_isu_hittite_archers",                     6 },
                              { "phar_main_nat_isu_isuwan_slingers",                     8 },
                              { "phar_main_sea_aegean_armoured_archers",                 1 },
                              { "phar_main_sea_aegean_armoured_javelin_throwers",        2 },
                              { "phar_main_sea_marauder_slingers",                       2 },
                              { "phar_main_sea_aegean_light_archers",                    3 },
                              { "phar_main_sea_seafaring_javelinmen",                    3 },
                              { "phar_main_sea_seafaring_slings",                        3 },
                              { "phar_map_fac_ash_assur_levy_archers",                   7 },
                              { "phar_map_fac_ash_harran_archers",                       6 },
                              { "phar_map_fac_bab_siluhlu_slingers",                     10 },
                              { "phar_map_fac_bab_siraku_archers",                       7 },
                              { "phar_map_fac_bab_babylonian_archers",                   6 },
                              { "phar_map_nat_aber_ahlamu_archers",                      10 },
                              { "phar_map_nat_aber_aramean_skirmishers",                 8 },
                              { "phar_map_nat_assur_akkadian_hunters",                   10 },
                              { "phar_map_nat_assur_akkadian_skirmishers",               8 },
                              { "phar_map_nat_halt_elamite_bowmen",                      10 },
                              { "phar_map_nat_halt_elamite_slingers",                    10 },
                              { "phar_map_nat_halt_elamite_veteran_archers",             7 },
                              { "phar_map_nat_halt_elamite_veteran_slingers",            7 },
                              { "phar_map_nat_tamti_akkadian_archers",                   10 },
                              { "phar_map_nat_tamti_akkadian_armoured_archers",          7 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_map_ambition_havetotalrangedunitsaegea", -- Only Aegeans
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("troy_main_dan_mycenae"),
                              conditions.is_target_faction("troy_main_trj_troy"),
                              conditions.is_target_faction("troy_main_dan_achilles"),
                              conditions.is_target_faction("troy_main_dan_ithaca"),
                              conditions.is_target_faction("troy_main_trj_lycia"),
                              conditions.is_target_faction("troy_rem_trj_thrace"),
                              conditions.is_target_faction("troy_main_dan_boeotians"),
                         }),
                         conditions.num_units_at_most(5, { unit_set = { "phar_main_ranged_infantry" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 10",
                                   "unit_set phar_main_ranged_infantry",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_map_ambition_havetotalrangedunitsaegea_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_map_ambition_havetotalrangedunitsaegea_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(5, {
                              { "phar_main_fac_sup_armored_hittite_archers",             4 },
                              { "phar_main_fac_sup_hittite_archers",                     6 },
                              { "phar_main_fac_sup_hittite_slingers",                    6 },
                              { "phar_main_nat_hig_renowned_phrygian_javelin_throwers",  5 },
                              { "phar_main_nat_hig_phrygian_skirmishers",                6 },
                              { "phar_main_nat_hig_kaskian_javelin_throwers",            8 },
                              { "phar_main_sea_aegean_armoured_archers",                 3 },
                              { "phar_main_sea_aegean_armoured_javelin_throwers",        4 },
                              { "phar_main_sea_marauder_slingers",                       4 },
                              { "phar_main_sea_aegean_light_archers",                    5 },
                              { "phar_main_sea_seafaring_javelinmen",                    5 },
                              { "phar_main_sea_seafaring_slings",                        6 },
                              { "phar_main_nat_isu_armoured_hittite_skirmishers",        6 },
                              { "phar_main_nat_isu_hittite_archers",                     6 },
                              { "phar_main_nat_isu_isuwan_slingers",                     8 },
                              { "phar_map_nat_ach_achaean_stoneslingers",                10 },
                              { "phar_map_nat_ach_achaean_bowmen",                       9 },
                              { "phar_map_nat_ach_achaean_javelinmen",                   8 },
                              { "phar_map_nat_ach_veteran_achaean_slingers",             8 },
                              { "phar_map_nat_thr_forest_skirmishers",                   10 },
                              { "phar_map_nat_thr_thracian_hunters",                     9 },
                              { "phar_map_nat_thr_thracian_archers",                     6 },
                              { "phar_map_fac_myc_heavy_islander_skirmishers",           9 },
                              { "phar_map_fac_myc_heavy_mycenaen_bowmen",                7 },
                              { "phar_map_fac_myc_islander_skirmishers",                 7 },
                              { "phar_map_fac_troy_trojan_stoneslingers",                9 },
                              { "phar_map_fac_troy_veteran_trojan_archers",              8 },
                              { "phar_map_fac_troy_elite_trojan_slingers",               7 },
                              { "phar_map_fac_troy_par_trojan_nobles",                   6 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotaleliteunitsofx", -- Only Ramesses
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.is_target_faction("phar_main_ramesses"),
                         conditions.num_units_between(1, 4, { unit_set = { "phar_main_high_tier_units" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 8",
                                   "unit_set phar_main_high_tier_units",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_main_ambition_havetotaleliteunitsofx_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotaleliteunitsofx_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(6, {
                              { "phar_main_fac_ram_elite_medjai_archers",             10 },
                              { "phar_main_fac_ram_elite_medjai_warriors",            10 },
                              { "phar_main_fac_ram_elite_medjai_warriors_axe",        10 },
                              { "phar_main_fac_seti_elite_axemen",                    5 },
                              { "phar_main_fac_seti_elite_clubmen",                   5 },
                              { "phar_main_fac_taus_seneni_chariots",                 1 },
                              { "phar_main_fac_amen_ta_seti_longbowmen",              3 },
                              { "phar_main_fac_amen_kushite_armored_archers",         1 },
                              { "phar_main_fac_taus_seneni_light_chariots",           1 },
                              { "phar_main_fac_amen_kushite_chariots",                1 },
                              { "phar_main_fac_amen_kushite_royal_guard",             1 },
                              { "phar_main_fac_amen_nubian_chariots",                 1 },
                              { "phar_main_fac_seti_egyptian_melee_chariots",         1 },
                              { "phar_main_fac_seti_veteran_levy_fighters",           1 },
                              { "phar_main_nat_low_egyptian_chariots",                1 },
                              { "phar_main_nat_nub_renowned_kushite_archers",         3 },
                              { "phar_main_nat_nub_renowned_nubian_longbowmen",       3 },
                              { "phar_main_nat_sin_armoured_canaanite_chariots",      1 },
                              { "phar_main_nat_sin_habiru_mercenaries",               2 },
                              { "phar_main_nat_sin_renowned_habiru_slingers",         1 },
                              { "phar_main_nat_upp_egyptian_chariots",                3 },
                              { "phar_main_nat_upp_upper_egyptian_khopesh_warriors",  3 },
                              { "phar_main_nat_upp_upper_egyptian_mace_axe_warriors", 3 },
                              { "phar_main_nat_upp_upper_egyptian_renowned_archers",  3 },
                              { "phar_main_nat_wes_libu_composite_bowmen",            2 },
                              { "phar_main_nat_wes_libu_desert_swords",               2 },
                              { "phar_main_sea_aegean_armoured_archers",              2 },
                              { "phar_main_sea_aegean_panoply_spearmen",              2 },
                              { "phar_main_sea_islander_raiders",                     2 },
                              { "phar_main_sea_renowned_seafaring_raiders",           2 },
                              { "phar_main_sea_aegean_armoured_javelin_throwers",     4 },
                              { "phar_main_sea_aegean_armoured_raiders",              4 },
                              { "phar_main_sea_marauder_slingers",                    4 },
                              { "phar_main_sea_marauding_axe_chargers",               4 },
                              { "phar_main_sea_roving_khopesh_warriors",              4 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotalimperialunitspharaoh",
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.is_pharaoh(),
                         conditions.num_units_at_most(2, { unit_set = { "phar_main_tier_6" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 4",
                                   "unit_set phar_main_tier_6",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_main_ambition_havetotalimperialunitspharaoh_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalimperialunitspharaoh_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(2, {
                              { "phar_main_pharaoh_elite_pharaoh_guard",            1 },
                              { "phar_main_pharaoh_elite_royal_khopesh_guards",     1 },
                              { "phar_main_pharaoh_elite_braves_of_the_king",       1 },
                              { "phar_main_pharaoh_elite_royal_chariot_companions", 1 },
                              { "phar_main_pharaoh_elite_royal_archers",            1 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_havetotalimperialunitsgreatking",
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.is_great_king(),
                         conditions.num_units_at_most(2, { unit_set = { "phar_main_tier_6" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 4",
                                   "unit_set phar_main_tier_6",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_main_ambition_havetotalimperialunitsgreatking_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalimperialunitsgreatking_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(2, {
                              { "phar_main_great_king_elite_golden_spearmen",        1 },
                              { "phar_main_great_king_elite_mesedi",                 1 },
                              { "phar_main_great_king_elite_royal_hittite_chargers", 1 },
                              { "phar_main_great_king_elite_royal_hittite_chariots", 1 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_map_ambition_havetotalimperialunitswanax",
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.is_sitting_ruler_of_legitimacy_path("aegean"),
                         conditions.num_units_at_most(2, { unit_set = { "phar_main_tier_6" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 4",
                                   "unit_set phar_main_tier_6",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_main_ambition_havetotalimperialunitsgreatking_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalimperialunitsgreatking_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(2, {
                              { "phar_map_achaean_elite_temple_warriors",        1 },
                              { "phar_map_achaean_elite_myrmidon_swordsmen",     1 },
                              { "phar_map_achaean_elite_stalker_skirmishers",    1 },
                              { "phar_map_wilusan_elite_champions_of_troy",      1 },
                              { "phar_map_wilusan_elite_dardanian_defenders",    1 },
                              { "phar_map_wilusan_elite_trojan_nobles",          1 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_map_ambition_havetotalimperialunitskingoftheuniverse",
                    expiration = 12,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.is_sitting_ruler_of_legitimacy_path("mesopotamian"),
                         conditions.num_units_at_most(2, { unit_set = { "phar_main_tier_6" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 4",
                                   "unit_set phar_main_tier_6",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.text_display(
                              "dummy_phar_main_ambition_havetotalimperialunitsgreatking_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_havetotalimperialunitsgreatking_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(2, {
                              { "phar_map_meso_elite_babylonian_specialists",     1 },
                              { "phar_map_meso_elite_elamite_royal_chargers",     1 },
                              { "phar_map_meso_elite_royal_marya",                1 },
                              { "phar_map_meso_elite_assur_noblemen",             1 },
                              { "phar_map_meso_elite_euphrats_tigers_chariots",   1 },
                         }, 1)
                    },
               },

               {
                    ambition_key = "phar_main_ambition_recruitgeneral",
                    expiration = 5,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.num_generals_between(0, 1),
                         conditions.turn_number_between(1, 40),
                         conditions.resource_value_at_least("troy_food", 500),
                         conditions.resource_income_at_least("troy_food", 0),
                    },
                    objectives = {
                         {
                              objective = "RAISE_FORCE",
                              conditions = {
                              }
                         },
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   1000 },
                              { "troy_wood",   150 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_winbattles_1",
                    expiration = 10,
                    rarity = "common",
                    tags = { "warlike" },
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(1, 2,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         {
                              objective = "DEFEAT_N_ARMIES_OF_FACTION",
                              conditions = {
                                   "total 1",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",     1000 },
                              { "troy_bronze",   50 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_winbattles_2",
                    expiration = 10,
                    rarity = "common",
                    tags = { "warlike" },
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(2, 3,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         {
                              objective = "DEFEAT_N_ARMIES_OF_FACTION",
                              conditions = {
                                   "total 2",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   1500 },
                              { "troy_bronze", 150 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_winbattles_3",
                    expiration = 12,
                    rarity = "common",
                    tags = { "warlike" },
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(3, 4,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         {
                              objective = "DEFEAT_N_ARMIES_OF_FACTION",
                              conditions = {
                                   "total 3",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   2000 },
                              { "troy_bronze", 300 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_winbattles_4",
                    expiration = 15,
                    rarity = "common",
                    tags = { "warlike" },
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(4, 5,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         {
                              objective = "DEFEAT_N_ARMIES_OF_FACTION",
                              conditions = {
                                   "total 4",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze", 750 },
                              { "troy_gold",   300 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_winbattles_5",
                    expiration = 20,
                    rarity = "common",
                    tags = { "warlike" },
                    condition = {
                         conditions.num_armies_of_bordering_factions_at_least(6, { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         {
                              objective = "DEFEAT_N_ARMIES_OF_FACTION",
                              conditions = {
                                   "total 8",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(2),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 200 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(2),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_sacksettlements",
                    rarity = "common",
                    tags = { "raider" },
                    condition = {
                         conditions.OR({
                              conditions.AND({
                                   conditions.resource_value_between("troy_food", 0, 1000),
                                   conditions.bordering_regions_at_least(1,
                                        { is_enemy = true, is_different_subculture = true, production_type = { "phar_main_settlement_farm", "phar_main_settlement_nile", "phar_main_settlement_coastal" } }),
                              }),
                              conditions.AND({
                                   conditions.resource_value_between("troy_bronze", 0, 1000),
                                   conditions.bordering_regions_at_least(1,
                                        { is_enemy = true, is_different_subculture = true, production_type = { "phar_main_settlement_bronze" } }),
                              }),
                              conditions.AND({
                                   conditions.resource_value_between("troy_gold", 0, 100),
                                   conditions.bordering_regions_at_least(1,
                                        { is_enemy = true, is_different_subculture = true, production_type = { "phar_main_settlement_gold" } }),
                              }),
                         }),
                    },
                    objectives = {
                         objectives.raze_or_sack_regions_from_metadata(1)
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   1500 },
                              { "troy_wood",   50 },
                              { "troy_stones", 100 },
                              { "troy_bronze", 300 },
                              { "troy_gold",   100 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_destroyfaction_1",
                    expiration = 10,
                    rarity = "common",
                    tags = { "warlike", "raider" },
                    condition = {
                         conditions.bordering_regions_at_least(1, { is_enemy = true, owner_max_regions = 2 }),
                    },
                    objectives = {
                         objectives.destroy_bordering_faction_with_num_regions_at_most(2)
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_wood",   1500 },
                              { "troy_stones", 1000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_destroyfaction_2",
                    expiration = 15,
                    rarity = "common",
                    tags = { "warlike", "raider" },
                    condition = {
                         conditions.bordering_regions_at_least(1,
                              { is_enemy = true, owner_min_regions = 3, owner_max_regions = 4 }),
                    },
                    objectives = {
                         objectives.destroy_bordering_faction_with_num_regions_between(3, 4)
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones", 2000 },
                              { "troy_gold",   750 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_destroyfaction_3",
                    expiration = 30,
                    rarity = "common",
                    tags = { "warlike", "raider" },
                    condition = {
                         conditions.bordering_regions_at_least(1, { is_enemy = true, owner_min_regions = 5 }),
                    },
                    objectives = {
                         objectives.destroy_bordering_faction_with_num_regions_at_least(5)
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 1000 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_getnetpositivefoodincome",
                    expiration = 15,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.resource_value_at_most("troy_food", 500),
                         conditions.resource_income_at_most("troy_food", 0),
                    },
                    objectives = {
                         objectives.get_resource_income("troy_food", 1000,
                              "mission_text_text_phar_main_ambition_getnetpositivefoodincome_text_objectives"),
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_getnetpositivefoodincome_effect_bundle; turns 15; }",
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food", 2000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_netfoodincome_1",
                    expiration = 10,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.resource_income_at_most("troy_food", 250),
                         conditions.resource_value_at_most("troy_food", 500),
                    },
                    objectives = {
                         objectives.get_resource_income("troy_food", 500,
                              "mission_text_text_phar_main_ambition_netfoodincome_1_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food", 2000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_netfoodincome_2",
                    expiration = 12,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.resource_income_between("troy_food", 250, 1000),
                         conditions.resource_value_at_most("troy_food", 5000),
                    },
                    objectives = {
                         objectives.get_resource_income("troy_food", 2000,
                              "mission_text_text_phar_main_ambition_netfoodincome_2_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   3500 },
                              { "troy_wood",   1000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_netfoodincome_3",
                    expiration = 15,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.resource_income_between("troy_food", 2000, 3500),
                         conditions.resource_value_at_most("troy_food", 20000),
                    },
                    objectives = {
                         objectives.get_resource_income("troy_food", 5000,
                              "mission_text_text_phar_main_ambition_netfoodincome_3_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   5000 },
                              { "troy_gold",   500 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_halfrations",
                    expiration = 10,
                    rarity = "common",
                    tags = { "overseer", "strategist" },
                    condition = {
                         conditions.NOT(conditions.at_war()),
                         conditions.resource_income_at_most("troy_food", 0),
                         conditions.resource_value_at_most("troy_food", 1000),
                    },
                    objectives = {
                         objectives.check_all_armies_stances("MILITARY_FORCE_ACTIVE_STANCE_TYPE_SET_CAMP",
                              "mission_text_text_phar_main_ambition_halfrations_text_objectives")
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_halfrations_effect_bundle; turns 10; }",
                    },
               },

               {
                    ambition_key = "phar_map_ambition_politicalmarriage",
                    expiration = 10,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.has_dynasty(),
                         conditions.at_least_N_non_aggression_pacts(1, { factions_share_legitimacy_path = true })
                    },
                    objectives = {
                         objectives.political_marriage_through_diplomacy(
                         "mission_text_text_phar_map_ambition_politicalmarriage_text_objectives")
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze",   750 },
                              { "troy_gold",     250 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_scionincourt",
                    expiration = 12,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.is_sitting_ruler_of_legitimacy_path("any"),
                         conditions.has_heir(),
                         conditions.NOT(conditions.heir_has_court_position()),
                    },
                    objectives = {
                         objectives.assign_court_position_to_heir(
                         "mission_text_text_phar_map_ambition_scionincourt_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",   2000 },
                              { "troy_gold",     250 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_scionconqueror",
                    expiration = 12,
                    rarity = "common",
                    tags = { "conqueror", "warlike" },
                    condition = {
                         conditions.faction_heir_is_in_region_neighbouring_enemy_region(),
                    },
                    objectives = {
                         objectives.faction_heir_capture_neighbouring_enemy_region(
                         "mission_text_text_phar_map_ambition_scionconqueror_text_objectives")
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",     3000 },
                              { "troy_stones",   1000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_adoptintodynasty",
                    expiration = 6,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.is_dynasty_ruler(),
                         conditions.has_subject_with_no_dynasty(),
                    },
                    objectives = {
                         objectives.adopt_faction_in_own_dynasty(
                         "mission_text_text_phar_map_ambition_adoptintodynasty_text_objectives", { is_forced = false }),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   2000 },
                              { "troy_wood",   600 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_getadoptedintodynasty",
                    expiration = 15,
                    rarity = "common",
                    tags = { "overseer", "strategist" },
                    condition = {
                         conditions.turn_number_at_least(13),
                         conditions.NOT(conditions.has_dynasty()),
                    },
                    objectives = {
                         objectives.own_faction_is_adopted_in_dynasty(
                         "mission_text_text_phar_map_ambition_getadoptedintodynasty_text_objectives",
                              { ignore_forced = true }),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",   1500 },
                              { "troy_gold",     500 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_buildfoodbuilding",
                    expiration = 10,
                    rarity = "common",
                    tags = { "builder", "overseer" },
                    condition = {
                         conditions.resource_income_at_most("troy_food", 500),
                         conditions.resource_value_at_least("troy_wood", 500),
                         conditions.resource_value_at_least("troy_stones", 100),
                         conditions.num_region_slots_between(1, 99, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(1, {
                                   "phar_main_all_resource_production_food_cattle_canaan_1",
                                   "phar_main_all_resource_production_food_cattle_canaan_2",
                                   "phar_main_all_resource_production_food_cattle_hattusa_1",
                                   "phar_main_all_resource_production_food_cattle_hattusa_2",
                                   "phar_main_all_resource_production_food_farm_type_a_canaan_1",
                                   "phar_main_all_resource_production_food_farm_type_a_canaan_2",
                                   "phar_main_all_resource_production_food_farm_type_a_canaan_derivative_1",
                                   "phar_main_all_resource_production_food_farm_type_a_hattusa_1",
                                   "phar_main_all_resource_production_food_farm_type_a_hattusa_2",
                                   "phar_main_all_resource_production_food_farm_type_a_hattusa_derivative_1",
                                   "phar_main_all_resource_production_food_farm_type_a_nile_1",
                                   "phar_main_all_resource_production_food_farm_type_a_nile_2",
                                   "phar_main_all_resource_production_food_farm_type_b_nile_1",
                                   "phar_main_all_resource_production_food_farm_type_b_nile_2",
                                   "phar_main_all_resource_production_food_farm_type_c_nile_1",
                                   "phar_main_all_resource_production_food_fishery_nile_1",
                                   "phar_main_all_resource_production_food_fishery_nile_2",
                                   "phar_main_all_resource_production_fruit_oasis_1",
                                   "phar_main_all_resource_production_fruit_oasis_2",
                                   "phar_main_all_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_all_resource_production_port_coast_1",
                                   "phar_main_all_resource_production_port_coast_2",
                                   "phar_main_all_resource_production_port_coast_derivative_type_a_1",
                                   "phar_main_all_resource_production_wood_nile_1",
                                   "phar_main_all_resource_production_wood_nile_2",
                                   "phar_main_bay_resource_production_port_coast_derivative_type_a_1",
                                   "phar_main_bay_resource_production_port_coast_derivative_type_a_2",
                                   "phar_main_irsu_resource_production_food_cattle_1",
                                   "phar_main_irsu_resource_production_food_farm_1",
                                   "phar_main_irsu_resource_production_food_farm_derivative_1",
                                   "phar_main_irsu_resource_production_food_farm_nile_type_a_1",
                                   "phar_main_irsu_resource_production_food_farm_nile_type_b_1",
                                   "phar_main_irsu_resource_production_food_farm_nile_type_c_1",
                                   "phar_main_irsu_resource_production_food_fishery_nile_1",
                                   "phar_main_irsu_resource_production_fruit_oasis_1",
                                   "phar_main_irsu_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_irsu_resource_production_port_coast_derivative_type_a_1",
                                   "phar_map_all_resource_production_food_cattle_mesopotamia_1",
                                   "phar_map_all_resource_production_food_cattle_mesopotamia_2",
                                   "phar_map_all_resource_production_food_farm_type_a_mesopotamia_1",
                                   "phar_map_all_resource_production_food_farm_type_a_mesopotamia_2",
                                   "phar_map_all_resource_production_food_farm_type_a_mesopotamia_derivative_1",
                                   "phar_map_all_resource_production_food_farm_type_b_mesopotamia_1",
                                   "phar_map_all_resource_production_food_farm_type_b_mesopotamia_2",
                                   "phar_map_all_resource_production_food_farm_type_b_mesopotamia_derivative_1",
                                   "phar_map_all_resource_production_food_fishery_tigris_euphrates_1",
                                   "phar_map_all_resource_production_food_fishery_tigris_euphrates_2",
                                   "phar_map_myc_resource_production_food_farm_minor_1",
                                   "phar_map_myc_resource_production_food_farm_minor_2",
                                   "phar_map_farm_achaea_derivative_1",
                                   "phar_map_farm_assuwa_derivative_1",
                                   "phar_map_farm_thrace_derivative_1",
                                   "phar_map_food_cattle_aegean_1",
                                   "phar_map_food_cattle_aegean_2",
                                   "phar_map_food_farm_aegean_1",
                                   "phar_map_food_farm_aegean_2"
                              }, {}, {}, true,
                              "mission_text_text_phar_main_ambition_buildfoodbuilding_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food", 2000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_buildwoodbuilding",
                    expiration = 10,
                    rarity = "common",
                    tags = { "builder", "overseer" },
                    condition = {
                         conditions.resource_income_at_most("troy_wood", 500),
                         conditions.resource_value_at_least("troy_wood", 500),
                         conditions.resource_value_at_least("troy_stones", 100),
                         conditions.num_region_slots_between(1, 99, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(1, {
                                   "phar_main_all_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_all_resource_production_wood_canaan_type_a_1",
                                   "phar_main_all_resource_production_wood_canaan_type_a_2",
                                   "phar_main_all_resource_production_wood_canaan_type_a_derivative_1",
                                   "phar_main_all_resource_production_wood_canaan_type_b_1",
                                   "phar_main_all_resource_production_wood_canaan_type_b_2",
                                   "phar_main_all_resource_production_wood_hatti_1",
                                   "phar_main_all_resource_production_wood_hatti_2",
                                   "phar_main_all_resource_production_wood_hatti_derivative_1",
                                   "phar_main_all_resource_production_wood_hatti_derivative_2",
                                   "phar_main_all_resource_production_wood_nile_1",
                                   "phar_main_all_resource_production_wood_nile_2",
                                   "phar_main_all_resource_production_wood_oasis_1",
                                   "phar_main_all_resource_production_wood_oasis_2",
                                   "phar_main_all_resource_production_wood_port_nile_1",
                                   "phar_main_all_resource_production_wood_port_nile_2",
                                   "phar_main_bay_resource_production_port_coast_derivative_type_a_1",
                                   "phar_main_bay_resource_production_port_coast_derivative_type_a_2",
                                   "phar_main_irsu_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_irsu_resource_production_wood_canaan_type_b_1",
                                   "phar_main_irsu_resource_production_wood_oasis_1",
                                   "phar_main_irsu_resource_production_wood_port_nile_1",
                                   "phar_main_irsu_resource_production_wood_type_a_1",
                                   "phar_map_all_resource_production_wood_mesopotamia_type_a_1",
                                   "phar_map_all_resource_production_wood_mesopotamia_type_a_2",
                                   "phar_map_all_resource_production_wood_mesopotamia_type_a_derivative_1",
                                   "phar_map_all_resource_production_wood_port_tigris_euphrates_1",
                                   "phar_map_all_resource_production_wood_port_tigris_euphrates_2",
                                   "phar_map_myc_resource_production_wood_minor_1",
                                   "phar_map_myc_resource_production_wood_minor_2",
                                   "phar_map_wood_production_achaea_1",
                                   "phar_map_wood_production_achaea_2",
                                   "phar_map_wood_production_aegean_derivative_1",
                                   "phar_map_wood_production_assuwa_1",
                                   "phar_map_wood_production_assuwa_2",
                                   "phar_map_wood_production_assuwa_derivative_1",
                                   "phar_map_wood_production_thrace_1",
                                   "phar_map_wood_production_thrace_2",
                                   "phar_map_wood_production_thrace_derivative_1"
                              }, {}, {}, true,
                              "mission_text_text_phar_main_ambition_buildwoodbuilding_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_wood", 1000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_buildstonebuilding",
                    expiration = 10,
                    rarity = "common",
                    tags = { "builder", "overseer" },
                    condition = {
                         conditions.resource_income_at_most("troy_stones", 500),
                         conditions.resource_value_at_least("troy_wood", 500),
                         conditions.resource_value_at_least("troy_stones", 100),
                         conditions.num_region_slots_between(1, 99, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(1, {
                                   "phar_main_all_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_all_resource_production_stone_mine_1",
                                   "phar_main_all_resource_production_stone_mine_2",
                                   "phar_main_all_resource_production_stone_mine_derivative_type_a_1",
                                   "phar_main_all_resource_production_stone_mine_derivative_type_b_1",
                                   "phar_main_all_resource_production_stone_mine_nile_1",
                                   "phar_main_all_resource_production_stone_mine_nile_2",
                                   "phar_main_irsu_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_irsu_resource_production_stone_mine_1",
                                   "phar_main_irsu_resource_production_stone_mine_derivative_type_a_1",
                                   "phar_map_myc_resource_production_stone_mine_minor_1",
                                   "phar_map_myc_resource_production_stone_mine_minor_2"
                              }, {}, {}, true,
                              "mission_text_text_phar_main_ambition_buildstonebuilding_text_objectives"
                         ),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones", 500 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_buildbronzebuilding",
                    expiration = 10,
                    rarity = "common",
                    tags = { "builder", "overseer" },
                    condition = {
                         conditions.resource_income_at_most("troy_bronze", 500),
                         conditions.resource_value_at_least("troy_wood", 500),
                         conditions.resource_value_at_least("troy_stones", 100),
                         conditions.num_region_slots_between(1, 99, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(1, {
                                   "phar_main_all_resource_production_bronze_mine_1",
                                   "phar_main_all_resource_production_bronze_mine_2",
                                   "phar_main_all_resource_production_bronze_mine_3",
                                   "phar_main_all_resource_production_bronze_mine_derivative_type_a_1",
                                   "phar_main_all_resource_production_bronze_mine_derivative_type_a_2",
                                   "phar_main_all_resource_production_bronze_mine_nile_1",
                                   "phar_main_all_resource_production_bronze_mine_nile_2",
                                   "phar_main_all_resource_production_bronze_mine_type_b_1",
                                   "phar_main_all_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_irsu_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_map_myc_resource_production_bronze_minor_1",
                                   "phar_map_myc_resource_production_bronze_minor_2"
                              }, {}, {}, true,
                              "mission_text_text_phar_main_ambition_buildbronzebuilding_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze", 1000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_buildgoldbuilding",
                    expiration = 10,
                    rarity = "common",
                    tags = { "builder", "overseer" },
                    condition = {
                         conditions.resource_income_at_most("troy_gold", 500),
                         conditions.resource_value_at_least("troy_wood", 500),
                         conditions.resource_value_at_least("troy_stones", 100),
                         conditions.num_region_slots_between(1, 99, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(1, {
                                   "phar_main_all_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_all_resource_production_gold_mine_1",
                                   "phar_main_all_resource_production_gold_mine_2",
                                   "phar_main_all_resource_production_gold_mine_3",
                                   "phar_main_all_resource_production_gold_mine_derivative_type_b_1",
                                   "phar_main_all_resource_production_gold_mine_nile_1",
                                   "phar_main_all_resource_production_gold_mine_nile_2",
                                   "phar_main_amenmesse_resource_production_gold_mine_1",
                                   "phar_main_amenmesse_resource_production_gold_mine_2",
                                   "phar_main_irsu_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_irsu_resource_production_gold_mine_1",
                                   "phar_main_irsu_resource_production_gold_mine_2",
                                   "phar_main_irsu_resource_production_gold_mine_derivative_type_b_1",
                                   "phar_map_myc_resource_production_gold_mine_minor_1",
                                   "phar_map_myc_resource_production_gold_mine_minor_2"
                              }, {}, {}, true,
                              "mission_text_text_phar_main_ambition_buildgoldbuilding_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 300 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_goldstock_1",
                    expiration = 10,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.resource_income_between("troy_gold", 1, 50),
                         conditions.resource_value_at_most("troy_gold", 500),
                    },
                    objectives = {
                         {
                              objective = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
                              conditions = {
                                   "pooled_resource troy_gold",
                                   "total 1000",
                              }
                         }
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_goldstock_1_effect_bundle; turns 15; }",
                    },
               },

               {
                    ambition_key = "phar_main_ambition_goldstock_2",
                    expiration = 12,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.resource_income_between("troy_gold", 50, 150),
                         conditions.resource_value_at_most("troy_gold", 1000),
                    },
                    objectives = {
                         {
                              objective = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
                              conditions = {
                                   "pooled_resource troy_gold",
                                   "total 2000",
                              }
                         }
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_goldstock_2_effect_bundle; turns 15; }",
                    },
               },

               {
                    ambition_key = "phar_main_ambition_goldstock_3",
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.resource_income_between("troy_gold", 150, 1000),
                         conditions.resource_value_at_most("troy_gold", 2500),
                    },
                    objectives = {
                         {
                              objective = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
                              conditions = {
                                   "pooled_resource troy_gold",
                                   "total 10000",
                              }
                         },
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_goldstock_3_effect_bundle; turns 15; }",
                    },
               },

               {
                    ambition_key = "phar_main_ambition_goldstock_4",
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.resource_income_at_least("troy_gold", 1000),
                         conditions.resource_value_at_least("troy_gold", 10000),
                    },
                    objectives = {
                         objectives.have_X_times_your_pooled_resource_value(2, "troy_gold"),
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_goldstock_4_effect_bundle; turns 15; }",
                         payloads.victory_points(2),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(2),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_positiverealmhappiness",
                    expiration = 15,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.num_owned_regions_at_least(10),
                         conditions.num_owned_regions_at_least(0.3, { max_happiness = 0 }),
                    },
                    objectives = {
                         objectives.have_regions_at_least(0.95, { min_happiness = 0 },
                              "mission_text_text_phar_main_ambition_positiverealmhappiness_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   2000 },
                              { "troy_gold",   200 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_increasegrowthinsettlement",
                    expiration = 15,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.num_owned_regions_at_most(30),
                         conditions.num_owned_regions_at_least(1, { max_growth = 10 }),
                    },
                    objectives = {
                         objectives.have_regions_at_least(0.95, { min_growth = 10 },
                              "mission_text_text_phar_main_ambition_increasegrowthinsettlement_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_wood",   3000 },
                              { "troy_stones", 1500 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_makebarteragreement",
                    expiration = 10,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.turn_number_at_most(50),
                         conditions.num_barter_agreements_at_most(0),
                         conditions.OR({
                              conditions.resource_income_at_most("troy_food", -1),
                              conditions.resource_income_at_most("troy_wood", -1),
                              conditions.resource_income_at_most("troy_bronze", -1),
                              conditions.resource_income_at_most("troy_stones", -1),
                              conditions.resource_income_at_most("troy_gold", -1),
                         }),
                         conditions.num_met_factions_at_least(1, { min_attitude = 10 }),
                    },
                    objectives = {
                         {
                              objective = "MAKE_BARTER_AGREEMENT",
                              conditions = {
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",   2000 },
                              { "troy_gold",   300 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_bronzeeffort",
                    expiration = 10,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.NOT(conditions.at_war()),
                         conditions.resource_income_between("troy_bronze", 0, 200),
                         conditions.resource_value_at_most("troy_bronze", 1500),
                         conditions.num_region_slots_between(1, 99, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(1, {
                                   "phar_main_all_resource_production_bronze_mine_1",
                                   "phar_main_all_resource_production_bronze_mine_2",
                                   "phar_main_all_resource_production_bronze_mine_3",
                                   "phar_main_all_resource_production_bronze_mine_derivative_type_a_1",
                                   "phar_main_all_resource_production_bronze_mine_derivative_type_a_2",
                                   "phar_main_all_resource_production_bronze_mine_nile_1",
                                   "phar_main_all_resource_production_bronze_mine_nile_2",
                                   "phar_main_all_resource_production_bronze_mine_type_b_1",
                                   "phar_main_all_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_irsu_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_map_myc_resource_production_bronze_minor_1",
                                   "phar_map_myc_resource_production_bronze_minor_2"
                              }, {}, {}, true,
                              "mission_text_text_phar_main_ambition_bronzeeffort_text_objectives"),
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_bronzeeffort_effect_bundle; turns 10; }",
                    },
               },

               {
                    ambition_key = "phar_main_ambition_goldeffort",
                    expiration = 10,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.NOT(conditions.at_war()),
                         conditions.resource_income_between("troy_gold", 0, 100),
                         conditions.resource_value_at_most("troy_gold", 1500),
                         conditions.num_region_slots_between(1, 99, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(1, {
                                   "phar_main_all_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_all_resource_production_gold_mine_1",
                                   "phar_main_all_resource_production_gold_mine_2",
                                   "phar_main_all_resource_production_gold_mine_3",
                                   "phar_main_all_resource_production_gold_mine_derivative_type_b_1",
                                   "phar_main_all_resource_production_gold_mine_nile_1",
                                   "phar_main_all_resource_production_gold_mine_nile_2",
                                   "phar_main_amenmesse_resource_production_gold_mine_1",
                                   "phar_main_amenmesse_resource_production_gold_mine_2",
                                   "phar_main_irsu_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_irsu_resource_production_gold_mine_1",
                                   "phar_main_irsu_resource_production_gold_mine_2",
                                   "phar_main_irsu_resource_production_gold_mine_derivative_type_b_1",
                                   "phar_map_myc_resource_production_gold_mine_minor_1",
                                   "phar_map_myc_resource_production_gold_mine_minor_2"
                              }, {}, {}, true,
                              "mission_text_text_phar_main_ambition_goldeffort_text_objectives"),
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_goldeffort_effect_bundle; turns 10; }",
                    },
               },

               {
                    ambition_key = "phar_main_ambition_stoneeffort",
                    expiration = 10,
                    rarity = "common",
                    tags = { "overseer" },
                    condition = {
                         conditions.NOT(conditions.at_war()),
                         conditions.resource_income_between("troy_stones", 0, 100),
                         conditions.resource_value_at_most("troy_stones", 1500),
                         conditions.num_region_slots_between(1, 99, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(1, {
                                   "phar_main_all_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_all_resource_production_stone_mine_1",
                                   "phar_main_all_resource_production_stone_mine_2",
                                   "phar_main_all_resource_production_stone_mine_derivative_type_a_1",
                                   "phar_main_all_resource_production_stone_mine_derivative_type_b_1",
                                   "phar_main_all_resource_production_stone_mine_nile_1",
                                   "phar_main_all_resource_production_stone_mine_nile_2",
                                   "phar_main_irsu_resource_production_fruit_oasis_derivative_type_a_1",
                                   "phar_main_irsu_resource_production_stone_mine_1",
                                   "phar_main_irsu_resource_production_stone_mine_derivative_type_a_1",
                                   "phar_map_myc_resource_production_stone_mine_minor_1",
                                   "phar_map_myc_resource_production_stone_mine_minor_2"
                              }, {}, {}, true,
                              "mission_text_text_phar_main_ambition_stoneeffort_text_objectives"),
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_stoneeffort_effect_bundle; turns 10; }",
                    },
               },

               {
                    ambition_key = "phar_main_ambition_helptoeliteunits", -- Only Ramesses
                    expiration = 10,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.is_target_faction("phar_main_ramesses"),
                         conditions.num_units_between(1, 6, { unit_set = { "phar_main_high_tier_units" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 10",
                                   "unit_set phar_main_high_tier_units",
                              }
                         }
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_helptoeliteunits_effect_bundle; turns 12; }",
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze", 1000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_helptoforeignveteranunits", -- Only Amenmesse
                    expiration = 10,
                    rarity = "common",
                    tags = { "strategist" },
                    condition = {
                         conditions.is_target_faction("phar_main_amenmesse"),
                         conditions.num_units_at_most(4, { unit_set = { "phar_main_egypt_foreign_veteran_natives" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 6",
                                   "unit_set phar_main_egypt_foreign_veteran_natives",
                              }
                         }
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_helptoforeignveteranunits_effect_bundle; turns 10; }",
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze", 800 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_helptomasstactics", -- Only Seti
                    expiration = 15,
                    rarity = "common",
                    tags = { "strategist", "raider" },
                    condition = {
                         conditions.is_target_faction("phar_main_seti"),
                         conditions.num_units_between(10, 20, { unit_set = { "phar_main_low_tier_units" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 30",
                                   "unit_set phar_main_low_tier_units",
                              }
                         }
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_helptomasstactics_effect_bundle; turns 12; }",
                    },
               },

               {
                    ambition_key = "phar_main_ambition_helptouseyourgeneral", -- All except Bay & Tausret
                    expiration = 15,
                    rarity = "common",
                    tags = { "warlike" },
                    exclude_factions = {
                         "phar_main_bay", "phar_main_tausret"
                    },
                    condition = {
                         conditions.num_units_at_most(10),
                         conditions.bordering_regions_at_least(1, { is_enemy = true }),
                    },
                    objectives = {
                         {
                              objective = "DEFEAT_N_ARMIES_OF_FACTION",
                              conditions = {
                                   "total 2",
                              }
                         }
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_helptouseyourgeneral_effect_bundle; turns 15; }",
                    },
               },

               {
                    ambition_key = "phar_main_ambition_raidnearbyenemy",
                    expiration = 10,
                    rarity = "common",
                    tags = { "raider" },
                    condition = {
                         conditions.strength_of_bordering_factions_at_least("own",
                              { region_options = { is_enemy = true, is_different_subculture = true } }),
                    },
                    objectives = {
                         objectives.raid_bordering_stronger_faction(1,
                              { region_options = { is_enemy = true, is_different_subculture = true } }),
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_raidnearbyenemy_effect_bundle; turns 20; }",
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 250 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_ramesseshairlock", -- Only Ramesses
                    max_appearances = 1,
                    expiration = 20,
                    rarity = "epic",
                    tags = {},
                    condition = {
                         conditions.is_target_faction("phar_main_ramesses"),
                         conditions.OR({
                              conditions.is_pharaoh(),
                              conditions.is_great_king()
                         })
                    },
                    objectives = {
                         objectives.have_X_plus_your_pooled_resource_value(15, "legitimacy")
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.add_ancillary_to_faction_leader("phar_main_general_skin_ramesses_old")
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_ramessessuccession", -- Only Ramesses
                    expiration = 20,
                    rarity = "epic",
                    tags = { "overseer" },
                    condition = {
                         conditions.is_target_faction("phar_main_ramesses"),
                         conditions.bordering_regions_at_least(1,
                              { is_specific_faction = "phar_main_setnakhte", is_enemy = false }),
                         conditions.bordering_regions_at_least(1,
                              { faction_to_check = "phar_main_setnakhte", is_enemy = true }),
                         conditions.target_faction_num_regions_at_most("phar_main_setnakhte", 3),
                         conditions.target_faction_num_regions_at_least("phar_main_ramesses", 15),
                    },
                    objectives = {
                         objectives.destroy_bordering_faction_matching_options({ faction_to_check = "phar_main_setnakhte", is_enemy = true })
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_main_ambition_ramessessuccession_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_ramessessuccession_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_confederation.png"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                         function(faction_key)
                              cm:force_confederation("phar_main_ramesses", "phar_main_setnakhte")
                         end
                    },
               },

               {
                    ambition_key = "phar_main_ambition_confederatetausret", -- Only Seti
                    expiration = 20,
                    rarity = "epic",
                    tags = { "overseer" },
                    condition = {
                         conditions.is_target_faction("phar_main_seti"),
                         conditions.bordering_regions_at_least(1,
                              { is_specific_faction = "phar_main_tausret", is_allied = true }),
                         conditions.bordering_regions_at_least(1,
                              { faction_to_check = "phar_main_tausret", is_enemy = true }),
                         conditions.target_faction_num_regions_at_most("phar_main_tausret", 1),
                         conditions.target_faction_num_regions_at_least("phar_main_seti", 10),
                    },
                    objectives = {
                         objectives.destroy_bordering_faction_matching_options({ faction_to_check = "phar_main_tausret", is_enemy = true })
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_main_ambition_confederatetausret_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_confederatetausret_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_confederation.png"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                         function(faction_key)
                              cm:force_confederation("phar_main_seti", "phar_main_tausret")
                         end
                    },
               },

               {
                    ambition_key = "phar_main_ambition_confederateseti", -- Only Tausret
                    expiration = 20,
                    rarity = "epic",
                    tags = { "overseer" },
                    condition = {
                         conditions.is_target_faction("phar_main_tausret"),
                         conditions.bordering_regions_at_least(1,
                              { is_specific_faction = "phar_main_seti", is_allied = true }),
                         conditions.bordering_regions_at_least(1,
                              { faction_to_check = "phar_main_seti", is_enemy = true }),
                         conditions.target_faction_num_regions_at_most("phar_main_seti", 1),
                         conditions.target_faction_num_regions_at_least("phar_main_tausret", 10),
                    },
                    objectives = {
                         objectives.destroy_bordering_faction_matching_options({ faction_to_check = "phar_main_seti", is_enemy = true })
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_main_ambition_confederateseti_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_main_ambition_confederateseti_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_confederation.png"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                         function(faction_key)
                              cm:force_confederation("phar_main_tausret", "phar_main_seti")
                         end
                    },
               },

               {
                    ambition_key = "phar_main_ambition_chapter1_firstexpansion",
                    expiration = 10,
                    rarity = "rare",
                    tags = { "conqueror" },
                    condition = {
                         conditions.num_owned_regions_between(1, 5),
                         conditions.bordering_regions_at_least(1, { is_allied = false }),
                    },
                    objectives = {
                         {
                              objective = "CAPTURE_REGIONS",
                              conditions = {
                                   "total 1"
                              }
                         }
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_chapter1_firstexpansion_effect_bundle; turns 10; }",
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food", 1000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_chapter1_firstchallenge",
                    expiration = 10,
                    rarity = "rare",
                    tags = { "warlike" },
                    condition = {
                         conditions.num_owned_regions_between(1, 5),
                         conditions.bordering_regions_at_least(1, { is_enemy = true }),
                    },
                    objectives = {
                         {
                              objective = "DEFEAT_N_ARMIES_OF_FACTION",
                              conditions = {
                                   "total 1",
                              }
                         }
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_chapter1_firstchallenge_effect_bundle; turns 10; }",
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food", 1000 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_chapter2_legitimacybuildingeffort",
                    expiration = 10,
                    rarity = "rare", -- common, rare, epic
                    tags = { "builder" },
                    condition = {
                         conditions.turn_number_between(10, 100),
                         conditions.num_owned_regions_between(5, 30),
                         conditions.resource_value_at_least("troy_stones", 350),
                         conditions.chosen_legitimacy_path("any"),
                         conditions.num_region_slots_between(1, 99, { is_infrastructure = true, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(1, {
                              "phar_main_ers_monument_level_1_egyp",
                              "phar_main_ers_monument_level_1_hitt",
                              "phar_main_ers_monument_level_1_aeg",
                              "phar_main_ers_monument_level_1_meso",
                         }, {}, {}, true,
                              "mission_text_text_phar_main_ambition_chapter2_legitimacybuildingeffort_text_objectives"),
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_chapter2_legitimacybuildingeffort_effect_bundle; turns 20; }",
                    },
               },

               {
                    ambition_key = "phar_main_ambition_chapter4_conqueror",
                    expiration = 15,
                    rarity = "rare",
                    tags = { "conqueror" },
                    condition = {
                         conditions.turn_number_at_least(100),
                         conditions.num_owned_regions_at_least(40),
                         conditions.num_units_between(100, 200),
                         conditions.at_war(),
                    },
                    objectives = {
                         objectives.own_N_more_units(20),
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_chapter4_conqueror_effect_bundle; turns 30; }",
                         payloads.victory_points(1),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(1),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_chapter5_legionsofdestruction", -- Only Seti/Irsu/Kurunta
                    expiration = 20,
                    rarity = "rare",
                    tags = { "raider", "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_main_seti"),
                              conditions.is_target_faction("phar_main_irsu"),
                              conditions.is_target_faction("phar_main_kurunta"),
                         }),
                         conditions.bordering_regions_at_least(3, { is_enemy = true }),
                         conditions.turn_number_at_least(100),
                         conditions.num_owned_regions_at_least(30),
                         conditions.num_units_at_least(60),
                    },
                    objectives = {
                         {
                              objective = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
                              conditions = {
                                   "total 5"
                              }
                         }
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_chapter5_legionsofdestruction_effect_bundle; turns 20; }",
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               --- Doesn't work for some reason
               -- {
               -- 	ambition_key = "phar_main_ambition_chapter2_goldmakesright",
               --	expiration = 15,
               -- 	rarity = "rare",
               -- 	tags = { "overseer" },
               -- 	-- Only Amenmesse
               -- 	exclude_factions = {
               -- 		"phar_main_ramesses", "phar_main_seti", "phar_main_tausret",
               -- 		"phar_main_bay", "phar_main_irsu", "phar_main_suppiluliuma", "phar_main_kurunta"
               -- 	},
               -- 	condition = {
               -- 		--conditions.NOT(conditions.at_war()),
               -- 		--conditions.resource_value_at_most("troy_gold", 2000),
               -- 		--conditions.turn_number_at_most(50),
               -- 	},
               -- 	objectives = {
               -- 		-- Active ambition replaced with regular Ambition
               -- 		-- objectives.dummy_condition_for_active_ambitions("mission_text_text_phar_main_ambition_chapter2_goldmakesright_text_objectives"),
               -- 		objectives.get_resource_value("troy_gold", 6000)
               -- 	},
               -- 	reward_payloads = {
               -- 		--- Need to replace with more targeted effect: leader spreads effect locally to region/province
               -- 		"effect_bundle{ bundle_key phar_main_ambition_chapter2_goldmakesright_effect_bundle; turns 10; }",
               -- 		payloads.generate_ambition_resource_reward_payload({
               -- 			{ "troy_gold"  , 1000 },
               -- 		}),
               -- 	},
               -- 	cooldown_override = 10,	-- Overrides normal pool cooldown. Mostly used for "active" ambitions. Value roughly: effect_bundle duration
               -- },

               {
                    ambition_key = "phar_main_ambition_chapter5_survivor",
                    max_appearances = 1,
                    expiration = 35,
                    rarity = "rare",
                    tags = { "warlike", "strategist" },
                    condition = {
                         conditions.turn_number_between(105, 125),
                    },
                    objectives = {
                         objectives.reach_turn_number(140,
                              "mission_text_text_phar_main_ambition_chapter5_survivor_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.victory_points(5),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(5),
                    },
               },

               {
                    ambition_key = "phar_main_ambition_chapter4_masterofgold",
                    expiration = 20,
                    rarity = "rare",
                    tags = { "overseer" },
                    condition = {
                         conditions.NOT(conditions.at_war()),
                         conditions.turn_number_at_least(120),
                         conditions.resource_value_between("troy_gold", 20000, 100000),
                    },
                    objectives = {
                         objectives.get_resource_value("troy_gold", 200000),
                    },
                    reward_payloads = {
                         "effect_bundle{ bundle_key phar_main_ambition_chapter4_masterofgold_effect_bundle; turns 20; }",
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               ----------------------------------------------------
               -- SEA culture Faction-specific related ambitions --
               ----------------------------------------------------
               {
                    ambition_key = "phar_sea_ambition_master_of_the_coast_lands", -- Master of the Coast lands
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "warlike", "raider" },
                    condition = {
                         conditions.is_target_faction("phar_sea_sherden"),
                         conditions.faction_leader_located_in_provinces({ "phar_main_tarsus", "phar_main_kanesh" }),
                         conditions.is_faction_alive("phar_main_kizzuwatna"),
                    },
                    objectives = {
                         objectives.destroy_faction("phar_main_kizzuwatna")
                    },
                    reward_payloads = {
                         --[[
					payloads.text_display(	"dummy_phar_sea_ambition_master_of_the_coast_lands_text_rewards_title",
											"campaign_payload_ui_details_description_dummy_phar_sea_ambition_master_of_the_coast_lands_text_rewards_tooltip",
											"ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
					]]
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_9"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         function(faction_key)
                              --cm:force_add_ancillary(cm:char_lookup_str(cm:get_faction(faction_key):faction_leader()), "phar_sea_unique_9")
                              ambitions.misc_data[faction_key].num_faction_specific_ambitions_completed = ambitions
                              .misc_data[faction_key].num_faction_specific_ambitions_completed + 1
                         end,
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_ravager_of_the_inner_kingdoms", -- Ravager of the inner kingdoms
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "warlike", "raider" },
                    condition = {
                         conditions.is_target_faction("phar_sea_sherden"),
                         conditions.faction_leader_located_in_provinces({ "phar_main_tarsus", "phar_main_kanesh" }),
                         conditions.NOT(conditions.is_region_abandoned("phar_main_kanesh_kanesh")),
                         conditions.NOT(conditions.is_region_abandoned("phar_main_kanesh_kummanni")),
                         conditions.NOT(conditions.is_region_abandoned("phar_main_kanesh_saricha")),
                    },
                    objectives = {
                         objectives.raze_or_sack_regions_in_province("phar_main_kanesh")
                    },
                    reward_payloads = {
                         --[[
					payloads.text_display(	"dummy_phar_sea_ambition_ravager_of_the_inner_kingdoms_text_rewards_title",
											"campaign_payload_ui_details_description_dummy_phar_sea_ambition_ravager_of_the_inner_kingdoms_text_rewards_tooltip",
											"ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
					]]
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_10"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         function(faction_key)
                              --cm:force_add_ancillary(cm:char_lookup_str(cm:get_faction(faction_key):faction_leader()), "phar_sea_unique_10")
                              ambitions.misc_data[faction_key].num_faction_specific_ambitions_completed = ambitions
                              .misc_data[faction_key].num_faction_specific_ambitions_completed + 1
                         end,
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_fire_raiser_of_the_sea_mountains", -- Fire-raiser of the Sea Mountains
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "warlike", "raider" },
                    condition = {
                         conditions.is_target_faction("phar_sea_sherden"),
                         conditions.faction_leader_located_in_provinces({ "phar_main_tarsus", "phar_main_kanesh" }),
                         conditions.NOT(conditions.is_region_abandoned("phar_main_tuwana_cybistra")),
                         conditions.NOT(conditions.is_region_abandoned("phar_main_tuwana_hubishna")),
                         conditions.NOT(conditions.is_region_abandoned("phar_main_tuwana_kelenderis")),
                         conditions.NOT(conditions.is_region_abandoned("phar_main_tuwana_tuwana")),
                    },
                    objectives = {
                         objectives.raze_or_sack_regions_in_province("phar_main_tuwana")
                    },
                    reward_payloads = {
                         --[[
					payloads.text_display(	"dummy_phar_sea_ambition_fire_raiser_of_the_sea_mountains_text_rewards_title",
											"campaign_payload_ui_details_description_dummy_phar_sea_ambition_fire_raiser_of_the_sea_mountains_text_rewards_tooltip",
											"ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
					]]
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_11"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         function(faction_key)
                              --cm:force_add_ancillary(cm:char_lookup_str(cm:get_faction(faction_key):faction_leader()), "phar_sea_unique_11")
                              ambitions.misc_data[faction_key].num_faction_specific_ambitions_completed = ambitions
                              .misc_data[faction_key].num_faction_specific_ambitions_completed + 1
                         end,
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_protector_of_the_new_lands", -- Protector of the New Lands
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "warlike", "raider" },
                    condition = {
                         conditions.is_target_faction("phar_sea_peleset"),
                         conditions.faction_leader_located_in_provinces({ "phar_main_megiddo", "phar_main_ashkelon" }),
                         conditions.is_faction_alive("phar_main_megiddo"),
                    },
                    objectives = {
                         objectives.destroy_faction("phar_main_megiddo")
                    },
                    reward_payloads = {
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_3"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         function(faction_key)
                              ambitions.misc_data[faction_key].num_faction_specific_ambitions_completed = ambitions
                              .misc_data[faction_key].num_faction_specific_ambitions_completed + 1
                         end,
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_coastal_champion", -- Coastal Champion
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "warlike", "raider" },
                    condition = {
                         conditions.is_target_faction("phar_sea_peleset"),
                         conditions.faction_leader_located_in_provinces({ "phar_main_megiddo", "phar_main_ashkelon" }),
                         conditions.is_faction_alive("phar_main_ashkelon"),
                    },
                    objectives = {
                         objectives.destroy_faction("phar_main_ashkelon")
                    },
                    reward_payloads = {
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_4"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         function(faction_key)
                              ambitions.misc_data[faction_key].num_faction_specific_ambitions_completed = ambitions
                              .misc_data[faction_key].num_faction_specific_ambitions_completed + 1
                         end,
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_inland_pioneer", -- Inland Pioneer
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "warlike", "raider" },
                    condition = {
                         conditions.is_target_faction("phar_sea_peleset"),
                         conditions.faction_leader_located_in_provinces({ "phar_main_megiddo", "phar_main_ashkelon" }),
                         conditions.is_faction_alive("phar_main_urushalim"),
                    },
                    objectives = {
                         objectives.destroy_faction("phar_main_urushalim")
                    },
                    reward_payloads = {
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_5"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         function(faction_key)
                              ambitions.misc_data[faction_key].num_faction_specific_ambitions_completed = ambitions
                              .misc_data[faction_key].num_faction_specific_ambitions_completed + 1
                         end,
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_follower_of_isul", -- Follower of Isul
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "raider" },
                    condition = {
                         conditions.is_target_faction("phar_sea_sherden"),
                         conditions.has_completed_at_least_N_faction_specific_ambitions(1),
                         conditions.bordering_regions_between(1, 3, { is_enemy = true, is_allied = false }),
                         conditions.is_player_worshipping_specific_deity("isul"),
                    },
                    objectives = {
                         objectives.raze_or_sack_regions_from_metadata(1)
                    },
                    reward_payloads = {
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_12"),
                         payloads.victory_points(1),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(1),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_devoted_to_isul", -- Devoted to Isul
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "raider" },
                    condition = {
                         conditions.is_target_faction("phar_sea_sherden"),
                         conditions.has_completed_at_least_N_faction_specific_ambitions(1),
                         conditions.bordering_regions_between(4, 7, { is_enemy = true, is_allied = false }),
                         conditions.is_player_worshipping_specific_deity("isul"),
                    },
                    objectives = {
                         objectives.raze_or_sack_regions_from_metadata(4)
                    },
                    reward_payloads = {
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_13"),
                         payloads.victory_points(2),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(2),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_son_of_isul", -- Son of Isul
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "raider" },
                    condition = {
                         conditions.is_target_faction("phar_sea_sherden"),
                         conditions.has_completed_at_least_N_faction_specific_ambitions(1),
                         conditions.bordering_regions_at_least(8, { is_enemy = true, is_allied = false }),
                         conditions.is_player_worshipping_specific_deity("isul"),
                    },
                    objectives = {
                         objectives.raze_or_sack_regions_from_metadata(8)
                    },
                    reward_payloads = {
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_14"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_commander_of_the_people", -- Commander of the People
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "conqueror", "builder" },
                    condition = {
                         conditions.is_target_faction("phar_sea_peleset"),
                         conditions.has_completed_at_least_N_faction_specific_ambitions(1),
                         conditions.bordering_regions_between(1, 5,
                              { is_subject = false, we_are_subject_of = false, is_allied = false })
                    },
                    objectives = {
                         objectives.own_N_more_regions(3),
                    },
                    reward_payloads = {
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_6"),
                         payloads.victory_points(1),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(1),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_leader_of_the_people", -- Leader of the People
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "conqueror", "builder" },
                    condition = {
                         conditions.is_target_faction("phar_sea_peleset"),
                         conditions.has_completed_at_least_N_faction_specific_ambitions(1),
                         conditions.bordering_regions_between(6, 10,
                              { is_subject = false, we_are_subject_of = false, is_allied = false })
                    },
                    objectives = {
                         objectives.own_N_more_regions(6),
                    },
                    reward_payloads = {
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_7"),
                         payloads.victory_points(2),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(2),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_father_of_the_people", -- Father of the People
                    expiration = -1,
                    rarity = "epic",
                    max_appearances = 1,
                    tags = { "conqueror", "builder" },
                    condition = {
                         conditions.is_target_faction("phar_sea_peleset"),
                         conditions.has_completed_at_least_N_faction_specific_ambitions(1),
                         conditions.bordering_regions_at_least(11,
                              { is_subject = false, we_are_subject_of = false, is_allied = false })
                    },
                    objectives = {
                         objectives.own_N_more_regions(12),
                    },
                    reward_payloads = {
                         payloads.add_ancillary_to_faction_leader("phar_sea_unique_8"),
                         payloads.victory_points(3),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               -- SEA Army Units Ambitions
               {
                    ambition_key = "phar_sea_ambition_horde_chariot_champion", -- Horde Chariot Champion -- Only Sea People
                    rarity = "common",
                    expiration = 6,
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_sea_sherden"),
                              conditions.is_target_faction("phar_sea_peleset"),
                         }),
                         conditions.num_units_at_least(6,
                              { unit_set = { "phar_sea_tribes_blades_normal_horde_units", "phar_sea_tribes_blades_elite_horde_units" } }),
                         conditions.num_units_between(2, 10, { unit_set = { "phar_main_chariots_all" } }),
                    },
                    objectives = {
                         objectives.own_N_more_units(3, { unit_set = { "phar_main_chariots_all" } }),
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_sea_ambition_horde_chariot_champion_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_sea_ambition_horde_chariot_champion_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(3,
                              {
                                   { "phar_sea_fac_pel_oxen_chariots",       1 },
                                   { "phar_sea_fac_pel_philistian_chariots", 1 },
                              },
                              1)
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_horde_hunters_champion", -- Horde Hunters Champion -- Only Sea People
                    rarity = "common",
                    expiration = 6,
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_sea_sherden"),
                              conditions.is_target_faction("phar_sea_peleset"),
                         }),
                         conditions.num_units_at_least(5,
                              { unit_set = { "phar_sea_tribes_blades_normal_horde_units", "phar_sea_tribes_blades_elite_horde_units" } }),
                         conditions.num_units_between(4, 20, { unit_set = { "phar_main_ranged_infantry" } }),
                    },
                    objectives = {
                         objectives.own_N_more_units(5,
                              { unit_set = { "phar_sea_tribes_blades_normal_horde_units", "phar_sea_tribes_blades_elite_horde_units" }, is_ranged = true }),
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_sea_ambition_horde_hunters_champion_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_sea_ambition_horde_hunters_champion_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(4,
                              {
                                   { "phar_main_sea_aegean_armoured_archers",          1 },
                                   { "phar_sea_fac_pel_renowned_philistian_archers",   1 },
                                   { "phar_sea_fac_shr_seasoned_nuraghe_harpooneers",  1 },
                                   { "phar_sea_fac_shr_sherden_bowmen",                1 },
                                   { "phar_main_sea_aegean_armoured_javelin_throwers", 2 },
                                   { "phar_main_sea_marauder_slingers",                2 },
                                   { "phar_sea_fac_pel_peleset_skirmishers",           2 },
                                   { "phar_sea_fac_pel_philistian_javelinmen",         2 },
                                   { "phar_sea_fac_shr_sherden_ambushers",             2 },
                                   { "phar_main_sea_aegean_light_archers",             4 },
                                   { "phar_main_sea_seafaring_javelinmen",             4 },
                                   { "phar_sea_fac_pel_peleset_bowmen",                4 },
                                   { "phar_sea_fac_pel_philistian_archers",            4 },
                                   { "phar_sea_fac_shr_sherden_hunters",               4 },
                                   { "phar_main_sea_seafaring_slings",                 8 },
                                   { "phar_sea_fac_pel_philistian_slingers",           8 },
                                   { "phar_sea_fac_pel_peleset_slingers",              15 },
                                   { "phar_sea_fac_shr_sherden_javelinmen",            15 },
                              },
                              1)
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_horde_melee_champion", -- Horde Melee Champion -- Only Sea People
                    rarity = "common",
                    expiration = 6,
                    tags = { "strategist" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_sea_sherden"),
                              conditions.is_target_faction("phar_sea_peleset"),
                         }),
                         conditions.num_units_at_least(5,
                              { unit_set = { "phar_sea_tribes_blades_normal_horde_units", "phar_sea_tribes_blades_elite_horde_units" } }),
                         conditions.num_units_between(4, 20, { unit_set = { "phar_main_melee_infantry" } }),
                    },
                    objectives = {
                         objectives.own_N_more_units(5, { unit_set = { "phar_main_melee_infantry" } }),
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_sea_ambition_horde_melee_champion_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_sea_ambition_horde_melee_champion_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(4,
                              {
                                   { "phar_main_sea_aegean_panoply_spearmen",               1 },
                                   { "phar_main_sea_islander_raiders",                      1 },
                                   { "phar_main_sea_renowned_seafaring_raiders",            1 },
                                   { "phar_sea_fac_pel_oxen_chariots_infantry",             1 },
                                   { "phar_sea_fac_pel_renowned_peleset_marines",           1 },
                                   { "phar_sea_fac_pel_renowned_philistian_defenders",      1 },
                                   { "phar_sea_fac_pel_renowned_philistian_swordsmen",      1 },
                                   { "phar_sea_fac_shr_battle_hardened_nuraghe_warriors",   1 },
                                   { "phar_sea_fac_shr_sherden_warband",                    1 },
                                   { "phar_sea_fac_pel_peleset_outrunners",                 1 },
                                   { "phar_main_sea_aegean_armoured_raiders",               2 },
                                   { "phar_main_sea_marauding_axe_chargers",                2 },
                                   { "phar_main_sea_roving_khopesh_warriors",               2 },
                                   { "phar_sea_fac_pel_renowned_peleset_raiders",           2 },
                                   { "phar_sea_fac_pel_renowned_philistian_spear_chargers", 2 },
                                   { "phar_sea_fac_shr_nuraghe_axe_wielders",               2 },
                                   { "phar_main_sea_aegean_spear_chargers",                 4 },
                                   { "phar_main_sea_islander_heavy_axemen",                 4 },
                                   { "phar_main_sea_seafaring_raiders",                     4 },
                                   { "phar_sea_fac_pel_peleset_raiders",                    4 },
                                   { "phar_sea_fac_pel_philistian_defenders",               4 },
                                   { "phar_sea_fac_pel_philistian_swords",                  4 },
                                   { "phar_sea_fac_shr_nuraghe_warriors",                   4 },
                                   { "phar_sea_fac_shr_sherden_axemen",                     4 },
                                   { "phar_sea_fac_pel_peleset_scouts",                     4 },
                                   { "phar_main_sea_aegean_fameseekers",                    8 },
                                   { "phar_main_sea_islander_swordsmen",                    8 },
                                   { "phar_sea_fac_pel_peleset_marines",                    8 },
                                   { "phar_sea_fac_shr_sherden_swordsmen",                  8 },
                                   { "phar_sea_fac_pel_philistian_spear_chargers",          8 },
                                   { "phar_sea_fac_shr_sherden_looters",                    8 },
                                   { "phar_main_sea_islander_young_spears",                 15 },
                                   { "phar_main_sea_seafaring_clubmen",                     15 },
                                   { "phar_sea_fac_pel_aspiring_peleset_raiders",           15 },
                                   { "phar_sea_fac_pel_philistian_militia",                 15 },
                                   { "phar_sea_fac_shr_sherden_recruits",                   15 },
                                   { "phar_sea_fac_pel_aspiring_peleset_warriors",          15 },
                              },
                              1)
                    },
               },

               -- SEA ERS related ambitions
               {
                    ambition_key = "phar_sea_ambition_sea_builder", -- Sea Builder
                    rarity = "common",
                    expiration = 10,
                    tags = { "builder", "overseer" },
                    condition = {
                         conditions.own_between_N_nomad_outposts_in_own_territory(3, 6),
                    },
                    objectives = {
                         objectives.own_at_least_N_nomad_outposts_in_own_territory(7,
                              "mission_text_text_phar_sea_ambition_sea_builder_text_objectives"),
                    },
                    reward_payloads = {
                         payload.stone(2000)
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_sea_plague", -- Sea Plague
                    rarity = "common",
                    expiration = 10,
                    tags = { "builder", "conqueror" },
                    condition = {
                         conditions.own_between_N_nomad_outposts_in_foreign_territory(3, 6),
                    },
                    objectives = {
                         objectives.own_at_least_N_nomad_outposts_in_foreign_territory(7,
                              "mission_text_text_phar_sea_ambition_sea_plague_text_objectives"),
                    },
                    reward_payloads = {
                         payload.stone(3000)
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_sea_conflagration", -- Sea Conflagration
                    rarity = "common",
                    expiration = 10,
                    tags = { "builder", "raider" },
                    condition = {
                         conditions.own_between_N_nomad_outposts_in_razed_territory(3, 6),
                    },
                    objectives = {
                         objectives.own_at_least_N_nomad_outposts_in_razed_territory(7,
                              "mission_text_text_phar_sea_ambition_sea_conflagration_text_objectives"),
                    },
                    reward_payloads = {
                         payload.stone(4000)
                    },
               },

               -- SEA Tribes & Privileges related ambitions
               {
                    ambition_key = "phar_sea_ambition_become_raiders_tribe", -- Become Raiders Tribe
                    rarity = "common",
                    expiration = 10,
                    tags = { "raider" },
                    condition = {
                         conditions.has_tribe_cell_for_at_least_N_turns_except(5,
                              "phar_sea_effect_bundle_town_privileges_raiders"),
                    },
                    objectives = {
                         objectives.reach_tribe_cell("phar_sea_effect_bundle_town_privileges_raiders",
                              "mission_text_text_phar_sea_ambition_become_raiders_tribe_text_objectives"),
                    },
                    reward_payloads = {
                         payload.gold(500)
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_become_craftsmen_tribe", -- Become Craftsmen Tribe
                    rarity = "common",
                    expiration = 10,
                    tags = { "overseer" },
                    condition = {
                         conditions.has_tribe_cell_for_at_least_N_turns_except(5,
                              "phar_sea_effect_bundle_town_privileges_craftsmen"),
                    },
                    objectives = {
                         objectives.reach_tribe_cell("phar_sea_effect_bundle_town_privileges_craftsmen",
                              "mission_text_text_phar_sea_ambition_become_craftsmen_tribe_text_objectives"),
                    },
                    reward_payloads = {
                         payload.bronze(1500),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_become_farmers_tribe", -- Become Farmers Tribe
                    rarity = "common",
                    expiration = 10,
                    tags = { "overseer" },
                    condition = {
                         conditions.has_tribe_cell_for_at_least_N_turns_except(5,
                              "phar_sea_effect_bundle_town_privileges_farmers"),
                    },
                    objectives = {
                         objectives.reach_tribe_cell("phar_sea_effect_bundle_town_privileges_farmers",
                              "mission_text_text_phar_sea_ambition_become_farmers_tribe_text_objectives"),
                    },
                    reward_payloads = {
                         payload.food(4500)
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_become_herdsmen_tribe", -- Become Herdsmen Tribe
                    rarity = "common",
                    expiration = 10,
                    tags = { "overseer" },
                    condition = {
                         conditions.has_tribe_cell_for_at_least_N_turns_except(5,
                              "phar_sea_effect_bundle_town_privileges_herdsmen"),
                    },
                    objectives = {
                         objectives.reach_tribe_cell("phar_sea_effect_bundle_town_privileges_herdsmen",
                              "mission_text_text_phar_sea_ambition_become_herdsmen_tribe_text_objectives"),
                    },
                    reward_payloads = {
                         payload.wood(3000)
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_become_ravagers_tribe", -- Become Ravagers Tribe
                    rarity = "common",
                    expiration = 12,
                    tags = { "raider" },
                    condition = {
                         conditions.has_tribe_cell_for_at_least_N_turns_except(10,
                              "phar_sea_effect_bundle_town_privileges_ravagers"),
                    },
                    objectives = {
                         objectives.reach_tribe_cell("phar_sea_effect_bundle_town_privileges_ravagers",
                              "mission_text_text_phar_sea_ambition_become_ravagers_tribe_text_objectives"),
                    },
                    reward_payloads = {
                         payload.gold(2000)
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_become_artisans_tribe", -- Become Artisans Tribe
                    rarity = "common",
                    expiration = 12,
                    tags = { "overseer" },
                    condition = {
                         conditions.has_tribe_cell_for_at_least_N_turns_except(10,
                              "phar_sea_effect_bundle_town_privileges_artisans"),
                    },
                    objectives = {
                         objectives.reach_tribe_cell("phar_sea_effect_bundle_town_privileges_artisans",
                              "mission_text_text_phar_sea_ambition_become_artisans_tribe_text_objectives"),
                    },
                    reward_payloads = {
                         payload.bronze(5000)
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_become_shepherds_tribe", -- Become Shepherds Tribe
                    rarity = "common",
                    expiration = 12,
                    tags = { "overseer" },
                    condition = {
                         conditions.has_tribe_cell_for_at_least_N_turns_except(10,
                              "phar_sea_effect_bundle_town_privileges_shepherds"),
                    },
                    objectives = {
                         objectives.reach_tribe_cell("phar_sea_effect_bundle_town_privileges_shepherds",
                              "mission_text_text_phar_sea_ambition_become_shepherds_tribe_text_objectives"),
                    },
                    reward_payloads = {
                         payload.wood(5000)
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_become_agriculturalists_tribe", -- Become Agriculturalists Tribe
                    rarity = "common",
                    expiration = 12,
                    tags = { "overseer" },
                    condition = {
                         conditions.has_tribe_cell_for_at_least_N_turns_except(10,
                              "phar_sea_effect_bundle_town_privileges_agriculturalists"),
                    },
                    objectives = {
                         objectives.reach_tribe_cell("phar_sea_effect_bundle_town_privileges_agriculturalists",
                              "mission_text_text_phar_sea_ambition_become_agriculturalists_tribe_text_objectives"),
                    },
                    reward_payloads = {
                         payload.food(10000)
                    },
               },

               -- SEA Eminence Related ambitions
               {
                    ambition_key = "phar_sea_ambition_fearsome_conqueror", -- Fearsome Conqueror
                    rarity = "common",
                    expiration = 5,
                    tags = { "conqueror", "raider" },
                    condition = {
                         conditions.has_enough_eminence(100),
                    },
                    objectives = {
                         objectives.perform_obedience_raze({ "minor_settlement" },
                              "mission_text_text_phar_sea_ambition_eminence_obedience_minor"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 100 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_monstrous_conqueror", -- Monstrous Conqueror
                    rarity = "common",
                    expiration = 7,
                    tags = { "conqueror", "raider" },
                    condition = {
                         conditions.has_enough_eminence(150),
                    },
                    objectives = {
                         objectives.perform_obedience_raze({ "major_settlement", "cult_centre" },
                              "mission_text_text_phar_sea_ambition_eminence_obedience_major")
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 150 },
                         }),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_horrific_conqueror", -- Horrific Conqueror
                    rarity = "common",
                    expiration = 10,
                    tags = { "conqueror", "raider" },
                    condition = {
                         conditions.has_enough_eminence(200),
                    },
                    objectives = {
                         objectives.perform_obedience_raze({ "cult_centre" },
                              "mission_text_text_phar_sea_ambition_eminence_obedience_poc"),
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 200 },
                         }),
                    },
               },

               -- SEA Pillars of Civilization related ambitions
               {
                    ambition_key = "phar_sea_ambition_herald_of_crisis", -- Herald of Crisis -- Only Sea People
                    max_selections = 1,
                    rarity = "rare",
                    expiration = 15,
                    tags = { "raider" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_sea_sherden"),
                              conditions.is_target_faction("phar_sea_peleset"),
                         }),
                         conditions.is_desired_civilization("prosperity"),
                    },
                    objectives = {
                         objectives.reach_civilization_level("crisis",
                              "mission_text_text_phar_sea_ambition_herald_of_crisis_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_sea_ambition_herald_of_crisis_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_sea_ambition_herald_of_crisis_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                         payloads.victory_points(1),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(6,
                              {
                                   { "phar_main_sea_aegean_armoured_javelin_throwers",      2 },
                                   { "phar_main_sea_marauder_slingers",                     2 },
                                   { "phar_sea_fac_pel_peleset_skirmishers",                2 },
                                   { "phar_sea_fac_pel_philistian_javelinmen",              2 },
                                   { "phar_sea_fac_shr_sherden_ambushers",                  2 },
                                   { "phar_main_sea_aegean_light_archers",                  4 },
                                   { "phar_main_sea_seafaring_javelinmen",                  4 },
                                   { "phar_sea_fac_pel_peleset_bowmen",                     4 },
                                   { "phar_sea_fac_pel_philistian_archers",                 4 },
                                   { "phar_sea_fac_shr_sherden_hunters",                    4 },
                                   { "phar_main_sea_seafaring_slings",                      8 },
                                   { "phar_sea_fac_pel_philistian_slingers",                8 },
                                   { "phar_sea_fac_pel_peleset_slingers",                   15 },
                                   { "phar_sea_fac_shr_sherden_javelinmen",                 15 },
                                   { "phar_main_sea_aegean_armoured_raiders",               2 },
                                   { "phar_main_sea_marauding_axe_chargers",                2 },
                                   { "phar_main_sea_roving_khopesh_warriors",               2 },
                                   { "phar_sea_fac_pel_renowned_peleset_raiders",           2 },
                                   { "phar_sea_fac_pel_renowned_philistian_spear_chargers", 2 },
                                   { "phar_sea_fac_shr_nuraghe_axe_wielders",               2 },
                                   { "phar_main_sea_aegean_spear_chargers",                 4 },
                                   { "phar_main_sea_islander_heavy_axemen",                 4 },
                                   { "phar_main_sea_seafaring_raiders",                     4 },
                                   { "phar_sea_fac_pel_peleset_raiders",                    4 },
                                   { "phar_sea_fac_pel_philistian_defenders",               4 },
                                   { "phar_sea_fac_pel_philistian_swords",                  4 },
                                   { "phar_sea_fac_shr_nuraghe_warriors",                   4 },
                                   { "phar_sea_fac_shr_sherden_axemen",                     4 },
                                   { "phar_sea_fac_pel_peleset_scouts",                     4 },
                                   { "phar_main_sea_aegean_fameseekers",                    8 },
                                   { "phar_main_sea_islander_swordsmen",                    8 },
                                   { "phar_sea_fac_pel_peleset_marines",                    8 },
                                   { "phar_sea_fac_shr_sherden_swordsmen",                  8 },
                                   { "phar_sea_fac_pel_philistian_spear_chargers",          8 },
                                   { "phar_sea_fac_shr_sherden_looters",                    8 },
                                   { "phar_main_sea_islander_young_spears",                 15 },
                                   { "phar_main_sea_seafaring_clubmen",                     15 },
                                   { "phar_sea_fac_pel_aspiring_peleset_raiders",           15 },
                                   { "phar_sea_fac_pel_philistian_militia",                 15 },
                                   { "phar_sea_fac_shr_sherden_recruits",                   15 },
                                   { "phar_sea_fac_pel_aspiring_peleset_warriors",          15 },
                              },
                              1),
                         scripted_payloads.award_victory_points_to_other_players(1),
                    },
               },

               {
                    ambition_key = "phar_sea_ambition_herald_of_collapse", -- Herald of Collapse -- Only Sea People
                    max_selections = 1,
                    rarity = "rare",
                    expiration = -1,
                    tags = { "raider" },
                    condition = {
                         conditions.OR({
                              conditions.is_target_faction("phar_sea_sherden"),
                              conditions.is_target_faction("phar_sea_peleset"),
                         }),
                         conditions.is_desired_civilization("crisis"),
                    },
                    objectives = {
                         objectives.reach_civilization_level("collapse",
                              "mission_text_text_phar_sea_ambition_herald_of_collapse_text_objectives"),
                    },
                    reward_payloads = {
                         payloads.text_display("dummy_phar_sea_ambition_herald_of_collapse_text_rewards_title",
                              "campaign_payload_ui_details_description_dummy_phar_sea_ambition_herald_of_collapse_text_rewards_tooltip",
                              "ui/campaign ui/effect_bundles/icon_effect_enables_recruitment.png"),
                         payloads.victory_points(5),
                    },
                    reward_scripted = {
                         scripted_payloads.random_weighted_unit_reward(12,
                              {
                                   { "phar_main_sea_aegean_armoured_archers",               1 },
                                   { "phar_sea_fac_pel_renowned_philistian_archers",        1 },
                                   { "phar_sea_fac_shr_seasoned_nuraghe_harpooneers",       1 },
                                   { "phar_sea_fac_shr_sherden_bowmen",                     1 },
                                   { "phar_main_sea_aegean_armoured_javelin_throwers",      2 },
                                   { "phar_main_sea_marauder_slingers",                     2 },
                                   { "phar_sea_fac_pel_peleset_skirmishers",                2 },
                                   { "phar_sea_fac_pel_philistian_javelinmen",              2 },
                                   { "phar_sea_fac_shr_sherden_ambushers",                  2 },
                                   { "phar_main_sea_aegean_light_archers",                  4 },
                                   { "phar_main_sea_seafaring_javelinmen",                  4 },
                                   { "phar_sea_fac_pel_peleset_bowmen",                     4 },
                                   { "phar_sea_fac_pel_philistian_archers",                 4 },
                                   { "phar_sea_fac_shr_sherden_hunters",                    4 },
                                   { "phar_main_sea_seafaring_slings",                      8 },
                                   { "phar_sea_fac_pel_philistian_slingers",                8 },
                                   { "phar_sea_fac_pel_peleset_slingers",                   15 },
                                   { "phar_sea_fac_shr_sherden_javelinmen",                 15 },
                                   { "phar_main_sea_aegean_panoply_spearmen",               1 },
                                   { "phar_main_sea_islander_raiders",                      1 },
                                   { "phar_main_sea_renowned_seafaring_raiders",            1 },
                                   { "phar_sea_fac_pel_oxen_chariots_infantry",             1 },
                                   { "phar_sea_fac_pel_renowned_peleset_marines",           1 },
                                   { "phar_sea_fac_pel_renowned_philistian_defenders",      1 },
                                   { "phar_sea_fac_pel_renowned_philistian_swordsmen",      1 },
                                   { "phar_sea_fac_shr_battle_hardened_nuraghe_warriors",   1 },
                                   { "phar_sea_fac_shr_sherden_warband",                    1 },
                                   { "phar_sea_fac_pel_peleset_outrunners",                 1 },
                                   { "phar_main_sea_aegean_armoured_raiders",               2 },
                                   { "phar_main_sea_marauding_axe_chargers",                2 },
                                   { "phar_main_sea_roving_khopesh_warriors",               2 },
                                   { "phar_sea_fac_pel_renowned_peleset_raiders",           2 },
                                   { "phar_sea_fac_pel_renowned_philistian_spear_chargers", 2 },
                                   { "phar_sea_fac_shr_nuraghe_axe_wielders",               2 },
                                   { "phar_main_sea_aegean_spear_chargers",                 4 },
                                   { "phar_main_sea_islander_heavy_axemen",                 4 },
                                   { "phar_main_sea_seafaring_raiders",                     4 },
                                   { "phar_sea_fac_pel_peleset_raiders",                    4 },
                                   { "phar_sea_fac_pel_philistian_defenders",               4 },
                                   { "phar_sea_fac_pel_philistian_swords",                  4 },
                                   { "phar_sea_fac_shr_nuraghe_warriors",                   4 },
                                   { "phar_sea_fac_shr_sherden_axemen",                     4 },
                                   { "phar_sea_fac_pel_peleset_scouts",                     4 },
                                   { "phar_main_sea_aegean_fameseekers",                    8 },
                                   { "phar_main_sea_islander_swordsmen",                    8 },
                                   { "phar_sea_fac_pel_peleset_marines",                    8 },
                                   { "phar_sea_fac_shr_sherden_swordsmen",                  8 },
                                   { "phar_sea_fac_pel_philistian_spear_chargers",          8 },
                                   { "phar_sea_fac_shr_sherden_looters",                    8 },
                                   { "phar_main_sea_islander_young_spears",                 15 },
                                   { "phar_main_sea_seafaring_clubmen",                     15 },
                                   { "phar_sea_fac_pel_aspiring_peleset_raiders",           15 },
                                   { "phar_sea_fac_pel_philistian_militia",                 15 },
                                   { "phar_sea_fac_shr_sherden_recruits",                   15 },
                                   { "phar_sea_fac_pel_aspiring_peleset_warriors",          15 },
                              },
                              1),
                         scripted_payloads.award_victory_points_to_other_players(5),
                    },
               },
          } -- Recurrent Ambitions
     }, -- End of Recurrent Ambitions pool

     --TUTORIAL AMBITION POOL
     -- Ambition pool for the tutorial only!

     -- Note: ambitions in this pool are generated specifically by tutorial scripts calling ambitions.generate_specific_ambitions() so their condition
     -- functions (which would allow the ambition system to generate them automatically) return false
     {
          -- The name of the pool
          name = "tutorial_pool",

          -- The type of the pool, currently can only be "event_based" or "cooldown_based"
          type = "event_based",

          -- How many ambitions to show to the player to choose
          max_pending_ambitions = 1,

          -- This is only used if it's a cooldown_based pool
          -- This is the number of turns that will be waited between ambitions.
          -- Note: the cooldown starts after the last ambition was failed or completed.
          cooldown = 1,

          -- This is only used if it's an "event_based" pool
          events = {
               {
                    event = "FactionTurnStart",
                    condition = function(context, faction_key, pool_metadata) end,
                    callback = function(context, faction_key, pool_metadata) end,
                    persistent = true,
               },
          },

          -- Conditions to see if the pool is valid at all. For instance if we want to enable a
          -- pool only for the tutorial campaign
          conditions = {
               pool_conditions.is_tutorial(),
          },

          ambitions = {
               {
                    -- Key from the "missions" dave table
                    -- Required
                    ambition_key = "phar_tutorial_ambition_1_threat_elimination",

                    tags = {},

                    -- What is needed for the ambition to be added to the pool of ambitions.
                    -- Function or list of functions need to be added.
                    -- The function will receive the faction script interface as an argument
                    -- Optional
                    -- e.g. condition = function(faction) return cm:turn_number() > 5 end
                    condition = {
                         function(faction)
                              -- Never generate this ambition automatically - it can (and is) only generated by a call to generate_specific_ambitions()
                              return false
                         end,
                    },
                    objectives = {
                         ambitions.helper.objective.tutorial_1_defeat_a_particular_army()
                    },

                    reward_payloads = {
                         "faction_pooled_resource_transaction{	resource troy_food;		factor troy_resource_factor_faction;		amount 100;	}",
                    },

                    -- Scripted reward. Just a lua function
                    -- Optional
                    reward_scripted = {
                         function()
                              out("COMPLETING AMBITION 1 for the tutorial")
                         end,
                    },
                    -- Required???????????????????
                    ui_texts = {},
               },

               {
                    ambition_key = "phar_tutorial_ambition_2_capture_sukkot",
                    tags = {},
                    condition = {
                         function(faction)
                              -- Never generate this ambition automatically - it can (and is) only generated by a call to generate_specific_ambitions()
                              return false
                         end
                    },
                    objectives = {
                         ambitions.helper.objective.tutorial_2_conquer_a_particular_settlement()
                    },
                    reward_payloads = {
                         payload.stone(440),
                         payload.wood(280)
                    },
                    --Required
                    ui_texts = {},
               },

               {
                    ambition_key = "phar_tutorial_ambition_2_positive_happiness_in_one_settlement",
                    tags = {},
                    condition = {
                         function(faction)
                              -- Never generate this ambition automatically - it can (and is) only generated by a call to generate_specific_ambitions()
                              return false
                         end
                    },

                    objectives = {
                         objectives.have_regions_at_least(0.1, { min_happiness = 0 },
                              "mission_text_text_phar_tutorial_ambition_2_positive_happiness_in_one_settlement"),
                    },
                    reward_payloads = {
                         "faction_pooled_resource_transaction{	resource troy_food;	factor troy_resource_factor_faction;	amount 100;	}",
                    },
                    reward_scripted = {
                         function(faction_key, metadata)
                              out("COMPLETING AMBITION 2 for the tutorial")
                         end
                    },
                    ui_texts = {},
               },

               {
                    ambition_key = "phar_tutorial_ambition_3_colonize_neb_gehes",
                    tags = {},
                    condition = {
                         function(faction)
                              -- Never generate this ambition automatically - it can (and is) only generated by a call to generate_specific_ambitions()
                              return false
                         end
                    },
                    objectives = {
                         objectives.conquer_region("mission_text_text_phar_tutorial_ambition_3_colonize_neb_gehes",
                              { is_colonized = true })
                    },
                    reward_payloads = {
                         "faction_pooled_resource_transaction{	resource troy_wood;		factor troy_resource_factor_faction;		amount 100;	}",
                    },
                    reward_scripted = {
                         function(faction_key, metadata)
                              out("COMPLETING AMBITION 3 for the tutorial")
                         end,
                    },
               },

               {
                    ambition_key = "phar_tutorial_ambition_5_technology",
                    tags = {},
                    condition = {
                         function(faction)
                              -- Never generate this ambition automatically - it can (and is) only generated by a call to generate_specific_ambitions()
                              return false
                         end
                    },
                    objectives = {
                         {
                              objective = "RESEARCH_TECHNOLOGY",
                              conditions.OR(
                                   { "technology phar_main_tech_civil_1_happiness_capital",
                                        "technology phar_main_tech_military_1_xp_per_turn_all_units" }
                              )
                         }
                    },
                    reward_payloads = {
                         "faction_pooled_resource_transaction{	resource troy_bronze;	factor troy_resource_factor_faction;		amount 1000;	}",
                    },
               },

               {
                    ambition_key = "phar_tutorial_ambition_6_recruit_units",
                    tags = {},
                    condition = {
                         function(faction)
                              -- Never generate this ambition automatically - it can (and is) only generated by a call to generate_specific_ambitions()
                              return false
                         end
                    },
                    objectives = {
                         objectives.recruit_n_units_from(
                              6, -- number of units to recruit
                              nil -- whitelist of unit keys
                         )
                    },
                    reward_payloads = {
                         payload.wood(500),
                         payload.stone(500)
                    },
               },

               {
                    ambition_key = "phar_tutorial_ambition_6_research_technologies",
                    tags = {},
                    condition = {
                         function(faction)
                              -- Never generate this ambition automatically - it can (and is) only generated by a call to generate_specific_ambitions()
                              return false
                         end
                    },
                    objectives = {
                         objectives.research_n_techs_including(
                              3, -- number of techs to research
                              nil, -- whitelist of tech keys
                              false -- include existing techs (false by default)
                         )
                    },
                    reward_payloads = {
                         payload.food(500),
                         payload.wood(500)
                    },
               },

               {
                    ambition_key = "phar_tutorial_ambition_7_conquer_per_amun",
                    tags = {},
                    condition = {
                         function(faction)
                              -- Never generate this ambition automatically - it can (and is) only generated by a call to generate_specific_ambitions()
                              return false
                         end
                    },
                    objectives = {
                         ambitions.helper.objective.tutorial_7_conquer_a_particular_settlement()
                         --objectives.conquer_particular_region("missions_localized_title_phar_tutorial_ambition_7_conquer_per_amun")
                    },
                    reward_payloads = {
                         payload.bronze(1000),
                         payload.gold(100)
                    },
                    --Required
                    ui_texts = {},
               },

               {
                    ambition_key = "phar_tutorial_ambition_defeat_seaborne_assault",
                    tags = {},
                    condition = {
                         function(faction)
                              -- Never generate this ambition automatically - it can (and is) only generated by a call to generate_specific_ambitions()
                              return false
                         end,
                    },
                    objectives = {
                         -- Objective will be inserted as the ambition is triggered
                    },
                    reward_payloads = {
                         payload.wood(500),
                         payload.stone(500)
                    },
                    flavour_text_key = "mission_text_text_phar_tutorial_ambition_defeat_seaborne_assault"
               },
          }
     },

     {
          name = "sargon_grand_ambitions",
          type = "cooldown_based",
          max_pending_ambitions = 3,
          max_active_ambitions = 1,
          start_turn = 1,
          cooldown = 3,
          conditions = {
               pool_conditions.is_not_tutorial(),
          },
          additional_ambition_conditions = {
               conditions.sargon_grand_ambitions_unlocked(),
          },
          ambitions = {
               -- ---------------------------------------------------------------
               -- -- Conqueror - Grand Ambitions
               -- ---------------------------------------------------------------

               {
                    ambition_key = "phar_map_ambition_grand_conqueror_entire_realm_low",
                    expiration = 25,
                    rarity = "epic",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.have_regions_in_realm_at_least(5, {
                              realms = {
                                   "egyptian_kush_realm",
                                   "egyptian_nubia_realm",
                                   "canaanite_yamhad_realm",
                                   "canaanite_retjenu_realm",
                                   "canaanite_fenkhu_realm",
                                   "canaanite_sinai_realm",
                                   "aegean_thrace_realm",
                                   "mesopotamia_aber_nahra_realm",
                              },
                              as_percentage = true,
                         }),
                    },
                    objectives = {
                         objectives.conquer_realm("mission_text_text_phar_map_ambition_grand_conquer_realm", {
                              "egyptian_kush_realm",
                              "egyptian_nubia_realm",
                              "canaanite_yamhad_realm",
                              "canaanite_retjenu_realm",
                              "canaanite_fenkhu_realm",
                              "canaanite_sinai_realm",
                              "aegean_thrace_realm",
                              "mesopotamia_aber_nahra_realm",
                         })
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",  2400 },
                              { "troy_gold",  450 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_conqueror_entire_realm_mid",
                    expiration = 25,
                    rarity = "epic",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.have_regions_in_realm_between(30, 50, {
                              realms = {
                                   "egyptian_western_desert_realm",
                                   "egyptian_lower_egypt_realm",
                                   "hittite_highlands_realm",
                                   "egyptian_upper_egypt_realm",
                                   "mesopotamia_zagros_realm",
                                   "mesopotamia_mat_assur_realm",
                                   "hittite_isuwa_realm",
                                   "mesopotamia_mat_tamti_realm",
                                   "hittite_lowlands_realm",
                              },
                              as_percentage = true,
                         }),
                    },
                    objectives = {
                         objectives.conquer_realm("mission_text_text_phar_map_ambition_grand_conquer_realm", {
                              "egyptian_western_desert_realm",
                              "egyptian_lower_egypt_realm",
                              "hittite_highlands_realm",
                              "egyptian_upper_egypt_realm",
                              "mesopotamia_zagros_realm",
                              "mesopotamia_mat_assur_realm",
                              "hittite_isuwa_realm",
                              "mesopotamia_mat_tamti_realm",
                              "hittite_lowlands_realm",
                         })
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",  3400 },
                              { "troy_gold",  650 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_conqueror_entire_realm_high",
                    expiration = 25,
                    rarity = "epic",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.have_regions_in_realm_between(50, 70, {
                              realms = {
                                   "aegean_assuwa_realm",
                                   "aegean_achaea_realm",
                              },
                              as_percentage = true,
                         }),
                    },
                    objectives = {
                         objectives.conquer_realm("mission_text_text_phar_map_ambition_grand_conquer_realm", {
                              "aegean_assuwa_realm",
                              "aegean_achaea_realm",
                         })
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",  4000 },
                              { "troy_gold",  750 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_conqueror_reach_territory_size_low",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_owned_regions_between(20, 24),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_REGIONS_INCLUDING",
                              conditions = {
                                   "total 28"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze",  900 },
                              { "troy_gold",    400 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_conqueror_reach_territory_size_mid",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_owned_regions_between(30, 34),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_REGIONS_INCLUDING",
                              conditions = {
                                   "total 40"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze",  1300 },
                              { "troy_gold",    600 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_conqueror_reach_territory_size_high",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_owned_regions_between(40, 45),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_REGIONS_INCLUDING",
                              conditions = {
                                   "total 52"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze",  1500 },
                              { "troy_gold",    700 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_conqueror_own_more_regions_low",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_owned_regions_between(15, 40),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         objectives.own_N_more_regions(10),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",    2400 },
                              { "troy_bronze",  900 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_conqueror_own_more_regions_mid",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_owned_regions_between(41, 80),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         objectives.own_N_more_regions(12),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",    3400 },
                              { "troy_bronze",  1300 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_conqueror_own_more_regions_high",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_owned_regions_at_least(81),
                         conditions.bordering_regions_at_least(1,
                              { is_allied = false, is_subject = false, we_are_subject_of = false }),
                    },
                    objectives = {
                         objectives.own_N_more_regions(14),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",    4000 },
                              { "troy_bronze",  1500 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_conqueror_own_poc_settlements",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "conqueror" },
                    exclude_factions = {},
                    condition = {
                         conditions.turn_number_at_most(100),
                    },
                    objectives = {
                         objectives.conquer_region(
                         "mission_text_text_phar_main_ambition_conquernearbypoi_text_objectives", { has_POI = true })
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 750 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               ---------------------------------------------------------------
               -- Builder - Grand Ambitions
               ---------------------------------------------------------------
               {
                    ambition_key = "phar_map_ambition_grand_builder_have_buildings_tier_low_1",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_region_slots_between(20, 25, { tier = 3 }),
                         conditions.resource_value_at_least("troy_wood", 300),
                         conditions.resource_value_at_least("troy_stones", 300),
                    },
                    objectives = {
                         objectives.num_region_slots_at_least(30, { tier = 3 },
                              "mission_text_text_phar_map_ambition_grand_builder_have_at_least_tier_3"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  1250 },
                              { "troy_gold",    200 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_builder_have_buildings_tier_low_2",
                    expiration = 25,
                    rarity = "epic",
                    tags = { "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_region_slots_between(30, 35, { tier = 3 }),
                         conditions.resource_value_at_least("troy_wood", 300),
                         conditions.resource_value_at_least("troy_stones", 300),
                    },
                    objectives = {
                         objectives.num_region_slots_at_least(45, { tier = 3 },
                              "mission_text_text_phar_map_ambition_grand_builder_have_at_least_tier_3"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  1500 },
                              { "troy_gold",    400 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_builder_have_buildings_tier_low_3",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_region_slots_between(45, 50, { tier = 3 }),
                         conditions.resource_value_at_least("troy_wood", 300),
                         conditions.resource_value_at_least("troy_stones", 300),
                    },
                    objectives = {
                         objectives.num_region_slots_at_least(65, { tier = 3 },
                              "mission_text_text_phar_map_ambition_grand_builder_have_at_least_tier_3"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  1700 },
                              { "troy_gold",    600 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_builder_have_buildings_tier_low_4",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_region_slots_between(65, 75, { tier = 3 }),
                         conditions.resource_value_at_least("troy_wood", 300),
                         conditions.resource_value_at_least("troy_stones", 300),
                    },
                    objectives = {
                         objectives.num_region_slots_at_least(85, { tier = 3 },
                              "mission_text_text_phar_map_ambition_grand_builder_have_at_least_tier_3"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  2500 },
                              { "troy_gold",    750 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_builder_have_buildings_tier_high_1",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_region_slots_between(14, 18, { tier = 4 }),
                         conditions.resource_value_at_least("troy_wood", 300),
                         conditions.resource_value_at_least("troy_stones", 300),
                    },
                    objectives = {
                         objectives.num_region_slots_at_least(22, { tier = 4 },
                              "mission_text_text_phar_map_ambition_grand_builder_have_at_least_tier_4"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  1500 },
                              { "troy_gold",    400 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_builder_have_buildings_tier_high_2",
                    expiration = 25,
                    rarity = "epic",
                    tags = { "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_region_slots_between(30, 36, { tier = 4 }),
                         conditions.resource_value_at_least("troy_wood", 300),
                         conditions.resource_value_at_least("troy_stones", 300),
                    },
                    objectives = {
                         objectives.num_region_slots_at_least(40, { tier = 4 },
                              "mission_text_text_phar_map_ambition_grand_builder_have_at_least_tier_4"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  1700 },
                              { "troy_gold",    600 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_builder_have_buildings_tier_high_3",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_region_slots_between(50, 58, { tier = 4 }),
                         conditions.resource_value_at_least("troy_wood", 300),
                         conditions.resource_value_at_least("troy_stones", 300),
                    },
                    objectives = {
                         objectives.num_region_slots_at_least(64, { tier = 4 },
                              "mission_text_text_phar_map_ambition_grand_builder_have_at_least_tier_4"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  2500 },
                              { "troy_gold",    750 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_builder_build_administration",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_value_at_least("troy_wood", 200),
                         conditions.resource_value_at_least("troy_stones", 200),
                         conditions.num_region_slots_between(8, 200, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(8, {}, {}, { "phar_main_municipal_complex", }, true,
                              "mission_text_text_phar_map_ambition_grand_builder_build_administration"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  2150 },
                              { "troy_gold",    650 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_builder_build_recruitment_production",
                    expiration = 25,
                    rarity = "epic",
                    tags = { "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_value_at_least("troy_wood", 200),
                         conditions.resource_value_at_least("troy_stones", 200),
                         conditions.num_region_slots_between(20, 200, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(20, {}, {}, { "phar_main_military_recruit", }, true,
                              "mission_text_text_phar_map_ambition_grand_builder_build_recruitment"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 1250 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_builder_build_management",
                    expiration = 25,
                    rarity = "epic",
                    tags = { "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_value_at_least("troy_wood", 200),
                         conditions.resource_value_at_least("troy_stones", 200),
                         conditions.num_region_slots_between(20, 200, { is_infrastructure = false, has_building = false }),
                    },
                    objectives = {
                         objectives.construct_N_buildings_from(20, {}, {}, { "phar_main_province_management", }, true,
                              "mission_text_text_phar_map_ambition_grand_builder_build_management"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 1250 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               ---------------------------------------------------------------
               -- Strategist - Grand Ambitions
               ---------------------------------------------------------------

               {
                    ambition_key = "phar_map_ambition_grand_strategist_own_units_high_tier_low",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "strategist", "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_units_between(1, 10, { unit_set = { "phar_main_high_tier_units" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 15",
                                   "unit_set phar_main_high_tier_units",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  1750 },
                              { "troy_wood",    1050 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_strategist_own_units_high_tier_med",
                    expiration = 25,
                    rarity = "epic",
                    tags = { "strategist", "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_units_between(20, 30, { unit_set = { "phar_main_high_tier_units" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 35",
                                   "unit_set phar_main_high_tier_units",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  2000 },
                              { "troy_wood",    1250 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_strategist_own_units_high_tier_high",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "strategist", "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_units_between(40, 50, { unit_set = { "phar_main_high_tier_units" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 60",
                                   "unit_set phar_main_high_tier_units",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  2500 },
                              { "troy_wood",    1500 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_strategist_train_units_elite",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "strategist", "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.OR({
                              conditions.is_pharaoh(),
                              conditions.is_great_king(),
                              conditions.is_sitting_ruler_of_legitimacy_path("aegean"),
                              conditions.is_sitting_ruler_of_legitimacy_path("mesopotamian"),
                         }),
                         conditions.num_units_at_most(2, { unit_set = { "phar_main_elite_units" } }),
                    },
                    objectives = {
                         {
                              objective = "OWN_N_UNITS",
                              conditions = {
                                   "total 10",
                                   "unit_set phar_main_elite_units",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  2000 },
                              { "troy_wood",    1500 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_strategist_own_more_units_low",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "strategist", "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_units_at_most(40),
                    },
                    objectives = {
                         objectives.own_N_more_units(20),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_wood",  600 },
                              { "troy_gold",  450 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_strategist_own_more_units_mid",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "strategist", "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_units_at_most(60),
                    },
                    objectives = {
                         objectives.own_N_more_units(25),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_wood",  850 },
                              { "troy_gold",  650 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_strategist_own_more_units_high",
                    expiration = 25,
                    rarity = "epic",
                    tags = { "strategist", "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_units_at_least(80),
                    },
                    objectives = {
                         objectives.own_N_more_units(30),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_wood",  1000 },
                              { "troy_gold",  750 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               ---------------------------------------------------------------
               -- Overseer - Grand Ambitions
               ---------------------------------------------------------------

               {
                    ambition_key = "phar_map_ambition_grand_overseer_have_outposts_low",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "overseer", "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_value_at_least("troy_wood", 200),
                         conditions.resource_value_at_least("troy_stones", 200),
                         conditions.num_region_slots_between(1, 5, { is_ERS = true, has_building = true }),
                    },
                    objectives = {
                         objectives.num_region_slots_at_least(10, { is_ERS = true, has_building = true },
                              "mission_text_text_phar_map_ambition_grand_overseer_have_ers_buildings")
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",    3200 },
                              { "troy_bronze",  1200 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_overseer_have_outposts_high",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "overseer", "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_value_at_least("troy_wood", 200),
                         conditions.resource_value_at_least("troy_stones", 200),
                         conditions.num_region_slots_at_least(20, { is_ERS = true, has_building = true }),
                    },
                    objectives = {
                         objectives.num_region_slots_at_least(40, { is_ERS = true, has_building = true },
                              "mission_text_text_phar_map_ambition_grand_overseer_have_ers_buildings")
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",    4000 },
                              { "troy_bronze",  1500 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_overseer_idle_workforce_province_low",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "overseer", "strategist" },
                    exclude_factions = {},
                    condition = {
                         conditions.control_at_least_X_provinces(3),
                    },
                    objectives = {
                         objectives.control_X_provinces_with_more_than_Y_idle_workforce(2, 5,
                              "mission_text_text_phar_map_ambition_grand_overseer_have_idle_workforce"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  1750 },
                              { "troy_wood",    1750 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_overseer_idle_workforce_province_high",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "overseer", "strategist" },
                    exclude_factions = {},
                    condition = {
                         conditions.control_at_least_X_provinces(6),
                    },
                    objectives = {
                         objectives.control_X_provinces_with_more_than_Y_idle_workforce(4, 7,
                              "mission_text_text_phar_map_ambition_grand_overseer_have_idle_workforce"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  1400 },
                              { "troy_wood",    1400 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_overseer_resource_income_low",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "overseer", "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_income_at_most("troy_food", 2000),
                    },
                    objectives = {
                         objectives.get_resource_income("troy_food", 3000,
                              "mission_text_text_phar_map_ambition_grand_overseer_income_food_low"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  1200 },
                              { "troy_bronze",  900 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_overseer_resource_income_mid",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "overseer", "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_income_between("troy_food", 2000, 4000),
                    },
                    objectives = {
                         objectives.get_resource_income("troy_food", 4500,
                              "mission_text_text_phar_map_ambition_grand_overseer_income_food_mid"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  1700 },
                              { "troy_bronze",  1300 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_overseer_resource_income_high",
                    expiration = 25,
                    rarity = "epic",
                    tags = { "overseer", "builder" },
                    exclude_factions = {},
                    condition = {
                         conditions.resource_income_between("troy_food", 4000, 6000),
                    },
                    objectives = {
                         objectives.get_resource_income("troy_food", 7000,
                              "mission_text_text_phar_map_ambition_grand_overseer_income_food_high"),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_stones",  2000 },
                              { "troy_bronze",  1500 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_diplomat_have_number_treaties",
                    expiration = 30,
                    rarity = "epic",
                    tags = { "overseer", "strategist" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_met_factions_at_least(12, { min_attitude = 0 })
                    },
                    objectives = {
                         objectives.have_X_amount_positive_treaties(6, {
                                   is_non_aggression_pact = true,
                                   is_defensive_alliance = true,
                                   is_military_alliance = true,
                                   is_vassalage = true,
                              },
                              "mission_text_text_phar_map_ambition_grand_strategist_treaties")
                    },
                    reward_payloads = {
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 1000 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(1),
                    },
               },

               ---------------------------------------------------------------
               -- Raider - Grand Ambitions
               ---------------------------------------------------------------
               {
                    ambition_key = "phar_map_ambition_grand_raider_resource_from_raiding_food_bronze_low",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "raider", "strategist" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(1, 2,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         objectives.collect_N_resources_from_raiding({ "troy_food", "troy_bronze" }, 4600)
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",    3200 },
                              { "troy_stones",  2000 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_raider_resource_from_raiding_food_bronze_high",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "raider", "strategist" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(4, 8,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         objectives.collect_N_resources_from_raiding({ "troy_food", "troy_bronze" }, 6800)
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",    4000 },
                              { "troy_stones",  2500 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_raider_resource_from_raiding_stone_wood_low",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "raider", "strategist" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(1, 2,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         objectives.collect_N_resources_from_raiding({ "troy_stones", "troy_wood" }, 2300)
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze",  1200 },
                              { "troy_wood",    800 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_raider_resource_from_raiding_stone_wood_high",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "raider", "strategist" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(4, 8,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         objectives.collect_N_resources_from_raiding({ "troy_stones", "troy_wood" }, 3950)
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze",  1500 },
                              { "troy_wood",    1000 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_raider_raid_nearby_enemy",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "raider" },
                    exclude_factions = {},
                    condition = {
                         conditions.strength_of_bordering_factions_at_least("own",
                              { region_options = { is_enemy = true, is_different_subculture = true } }),
                    },
                    objectives = {
                         objectives.raid_bordering_stronger_faction(4,
                              { region_options = { is_enemy = true, is_different_subculture = true } }),
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",  4000 },
                              { "troy_wood",  1000 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_raider_attack_settlements",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "raider" },
                    exclude_factions = {},
                    condition = {
                         conditions.bordering_regions_at_least(3, { is_enemy = true }),
                         conditions.num_owned_regions_at_least(20),
                    },
                    objectives = {
                         {
                              objective = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
                              conditions = {
                                   "total 10"
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 1000 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               ---------------------------------------------------------------
               -- Warrior - Grand Ambitions
               ---------------------------------------------------------------

               {
                    ambition_key = "phar_map_ambition_grand_warlike_kill_ruler",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.chosen_legitimacy_path("any"),
                         conditions.NOT(conditions.is_sitting_ruler_of_legitimacy_path("any")),
                    },
                    objectives = {
                         objectives.destroy_legitimacy_ruler("", { players_legitimacy_path = true })
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_food",  4250 },
                              { "troy_gold",  650 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_warlike_destroy_faction",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.bordering_regions_at_least(1, { is_enemy = true, owner_min_regions = 8 }),
                    },
                    objectives = {
                         objectives.destroy_bordering_faction_with_num_regions_at_least(8)
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_bronze",  1300 },
                              { "troy_gold",    600 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_warlike_kill_troops_low",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(3, 5,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         {
                              objective = "DEFEAT_N_ARMIES_OF_FACTION",
                              conditions = {
                                   "total 4",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 500 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_warlike_kill_troops_mid",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(6, 10,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         {
                              objective = "DEFEAT_N_ARMIES_OF_FACTION",
                              conditions = {
                                   "total 8",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 1000 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

               {
                    ambition_key = "phar_map_ambition_grand_warlike_kill_troops_high",
                    expiration = 20,
                    rarity = "epic",
                    tags = { "warlike" },
                    exclude_factions = {},
                    condition = {
                         conditions.num_armies_of_bordering_factions_between(10, 14,
                              { region_options = { is_enemy = true } }),
                    },
                    objectives = {
                         {
                              objective = "DEFEAT_N_ARMIES_OF_FACTION",
                              conditions = {
                                   "total 12",
                              }
                         }
                    },
                    reward_payloads = {
                         payloads.victory_points(3),
                         payloads.generate_ambition_resource_reward_payload({
                              { "troy_gold", 1500 },
                         }),
                    },
                    reward_scripted = {
                         scripted_payloads.award_victory_points_to_other_players(3),
                    },
               },

          },
     },
}

---------------------------------------------------------------
-- Working data, no need to modify this if you're a designer --
---------------------------------------------------------------

ambitions.initialized_pool_listeners = false
ambitions.re_initialize_after_load = false
ambitions.ui = {}
local ui = ambitions.ui

-- Generated at runtime
ambitions.ambitions_pool = {
     --[[
	faction_key = {
		pool = {
			{
				ambition_key = "key",
			}
		}
	}
]] --
}

-- Metadata for different factions
ambitions.faction_data = {
     --[[
	faction_key = {
		-- If true will open the ambitions dialogue on turn start.
		should_open_ambitions_panel = false,

		-- Which ambitions are currently active
		active_ambitions = {
			{ ambition_key = "asdasd", start_turn = 1, pool_name = pool_name },
		}

		-- Which ambition we've seen last from each pool
		last_seen_ambition_from_pool = {
			pool_name = ambition_key,
		},

		-- Metadata for each ambition that gets passed to the objective, condition
		-- and other callbacks in the ambition configuration
		ambition_metadata = {
			ambition_key = {},
		},

		-- Metadata for event based pools. Used in their events.
		pool_metadata = {
			pool = {},
		},

		-- Tracking which non-persistent events are completed and should not be restarted when loading
		-- We track this using indexes
		pool_completed_events = {
			pool = { 4, 5, 7 }
		},

		-- How many times each tag has been chosen before
		tag_num_times_chosen = {
			tag = 5,
		}

		-- Which pool is next in line to have an ambition selection screen created for it
		next_ambition_pool_queue = {
		}

		-- How many ambitions has this faction chosen this turn
		ambition_choices_this_turn = 0,

		-- How many times an ambition has been selected in the playthrough
		-- Only keeps tracks of ambitions that have the "max_selections" config option
		ambition_selections = {
			ambition_key = 5,
		},

		-- How many times an ambition has appeared in the playthrough
		-- Only keeps tracks of ambitions that have the "max_appearances" config option
		ambition_appearances = {
			ambition_key = 5,
		},
	},
	--]]
}

ambitions.misc_data = {
     --[[
	faction_key = {
		num_faction_specific_ambitions_completed = 0,
	},
	--]]
}

for _, pool in ipairs(ambitions.pools) do
     pool.paired_ambitions = {}

     for _, ambition in ipairs(pool.ambitions) do
          pool.paired_ambitions[ambition.ambition_key] = ambition
     end
end

ambitions.add_ambition_to_factions_pool = function(faction_key, pool, ambition_table)
     if not ambitions.ambitions_pool[faction_key] then
          ambitions.ambitions_pool[faction_key] = {}
     end

     if not ambitions.ambitions_pool[faction_key][pool] then
          ambitions.ambitions_pool[faction_key][pool] = {}
     end

     table.insert(
          ambitions.ambitions_pool[faction_key][pool],
          {
               ambition_key = ambition_table.ambition_key,
          }
     )
end

ambitions.new_game_initialization = function()
     if ambitions.initialized_pool_listeners then
          return
     end

     local player_factions = cm:get_human_factions()
     ambitions.initialized_pool_listeners = true
     ambitions.re_initialize_after_load = false

     local pool_metadata = {}

     -- setup ambitions pool
     for _, pool in ipairs(ambitions.pools) do
          if ambitions.check_pool_conditions(pool) then
               pool_metadata[pool.name] = {}
          end
     end

     ambitions.initialize_ambition_pools()

     for _, faction_key in ipairs(player_factions) do
          ambitions.faction_start_pool_listeners(faction_key)

          ambitions.faction_data[faction_key] = {
               should_open_ambitions_panel = false,
               active_ambitions = {},
               last_seen_ambition_from_pool = {},
               ambition_metadata = {},
               pool_metadata = pool_metadata,
               pool_completed_events = {},
               tag_num_times_chosen = {},
               next_ambition_pool_queue = {},
               ambition_choices_this_turn = 0,
               ambition_selections = {},
               ambition_appearances = {},
          }
     end

     ambitions.debug_check_for_duplications()
end

ambitions.check_pool_conditions = function(pool)
     for _, condition in ipairs(pool.conditions) do
          if is_boolean(condition) and not condition then
               return false
          end

          if is_function(condition) and not condition() then
               return false
          end
     end

     return true
end

ambitions.initialize_ambition_pools = function()
     if ambitions.initialized_faction_pools then
          return
     end

     local player_factions = cm:get_human_factions()

     for _, pool in ipairs(ambitions.pools) do
          if ambitions.check_pool_conditions(pool) then
               for _, ambition in ipairs(pool.ambitions) do
                    local ambition_key = ambition.ambition_key
                    cm:set_script_state(ambition_key .. "_rarity", ambitions.get_ambition_rarity(ambition))

                    for _, faction_key in ipairs(player_factions) do
                         if not ambitions.ambition_excluded_for_faction(ambition, faction_key) then
                              ambitions.add_ambition_to_factions_pool(faction_key, pool.name, ambition)
                         end
                    end
               end
          end
     end

     ambitions.initialized_faction_pools = true
end

ambitions.add_listeners = function()
     ambitions.start_pool_listeners()

     for index, listener in ipairs(ambitions.listeners) do
          core:add_listener(
               "ambitions_" .. listener.event .. "_" .. index,
               listener.event,
               listener.filter,
               listener.body,
               true
          )
     end
end

ambitions.ambition_success_callback = function(faction_key, ambition, metadata)
     return function()
          ambitions.remove_active_ambition(faction_key, ambition.ambition_key)

          for _, scripted_reward in ipairs(ambition.reward_scripted or {}) do
               scripted_reward(faction_key, metadata)
          end

          local faction = cm:get_faction(faction_key)
          local _, pool_data = ambitions.get_ambition_table(ambition.ambition_key)
          local pool_name = pool_data.name or ""
          core:trigger_event("ScriptEventAmbitionSuccessful", faction,
               { ambition_key = ambition.ambition_key, pool_name = pool_name })

          if cm:get_local_faction_name(true) == faction_key then
               cm:notify_ambition_status_changed(faction_key, ambition.ambition_key, "completed")
          end

          ambitions.try_to_generate_ambitions(faction_key)
     end
end

ambitions.ambition_cancelled_callback = function(faction_key, ambition)
     return function()
          ambitions.remove_active_ambition(faction_key, ambition.ambition_key)

          local faction = cm:get_faction(faction_key)
          core:trigger_event("ScriptEventAmbitionCancelled", faction, ambition.ambition_key)

          if cm:get_local_faction_name(true) == faction_key then
               cm:notify_ambition_status_changed(faction_key, ambition.ambition_key, "cancelled")
          end

          ambitions.try_to_generate_ambitions(faction_key)
     end
end

ambitions.ambition_failure_callback = function(faction_key, ambition)
     return function()
          local faction = cm:get_faction(faction_key)
          if ambitions.ambition_expired(faction_key, ambition.ambition_key) then
               core:trigger_event("ScriptEventAmbitionExpired", faction, ambition.ambition_key)

               if cm:get_local_faction_name(true) == faction_key then
                    cm:notify_ambition_status_changed(faction_key, ambition.ambition_key, "expired")
               end
          else
               core:trigger_event("ScriptEventAmbitionFailed", faction, ambition.ambition_key)

               if cm:get_local_faction_name(true) == faction_key then
                    cm:notify_ambition_status_changed(faction_key, ambition.ambition_key, "failed")
               end
          end
          ambitions.remove_active_ambition(faction_key, ambition.ambition_key)

          ambitions.try_to_generate_ambitions(faction_key)
     end
end

ambitions.setup_ambition_objectives = function(ambition, mm, dismiss_callbacks, faction_key, metadata)
     for index, objective in ipairs(ambition.objectives) do
          local script_key = ambition.ambition_key .. "_" .. index
          if is_function(objective) then
               objective = objective(faction_key, metadata, script_key)
          end

          if not objective then
               return false
          end
          if objective.objective == "SCRIPTED" then
               local check = objective.check
               if is_function(check) then
                    check = function(context, _faction_key) return objective.check(context, _faction_key, metadata,
                              script_key) end
               end

               if objective.should_complete_check and type(objective.should_complete_check) == "function" then
                    table.insert(dismiss_callbacks, function()
                         local should_complete = objective.should_complete_check()
                         if should_complete then
                              mm:force_scripted_objective_success(script_key)
                         end
                    end)
                    mm:add_new_scripted_objective(objective.display_text or "", objective.event or "", check, script_key,
                         objective.primary, objective.check_is_persistent)
               else
                    mm:add_new_scripted_objective(objective.display_text or "", objective.event or "", check, script_key,
                         objective.primary, objective.check_is_persistent)
               end
          else
               mm:add_new_objective(objective.objective, objective.primary)
               if type(objective.conditions) == "table" then
                    for _, condition in ipairs(objective.conditions) do
                         mm:add_condition(fix_up_start_pos_id(condition))
                    end
               end
          end

          if objective.auto_complete_condition and is_function(objective.auto_complete_condition) then
               if objective.display_text or objective.event or objective.check then
                    mm:add_scripted_objective_success_condition("FactionTurnStart", objective.auto_complete_condition,
                         script_key, objective.check_is_persistent)
               end
          end
          return true
     end
end

ambitions.setup_pending_ambition_objectives = function(ambition, mm, faction_key, metadata)
     for index, objective in ipairs(ambition.objectives) do
          if is_function(objective) then
               objective = objective(faction_key, metadata)
          end

          local script_key = ambition.ambition_key .. "_" .. index
          if objective.objective == "SCRIPTED" then
               mm:add_new_non_persistent_scripted_objective(objective.display_text or "", script_key, objective.primary)
          else
               mm:add_new_objective(objective.objective, objective.primary)
               if type(objective.conditions) == "table" then
                    for _, condition in ipairs(objective.conditions) do
                         mm:add_condition(fix_up_start_pos_id(condition))
                    end
               end
          end
     end
end

ambitions.setup_ambition_payloads = function(ambition, mm, faction_key, metadata)
     for _, payload in ipairs(ambition.reward_payloads or {}) do
          if is_function(payload) then
               local payload_ret, error_string = payload(faction_key, metadata)
               payload = payload_ret

               if is_string(error_string) then
                    script_error("Error while setting up a payload for ambition \"" ..
                    ambition.ambition_key .. "\": " .. error_string)
               end
          end
          if payload ~= "" then
               mm:add_payload(fix_up_start_pos_id(payload))
          end
     end

     local additional_resources_payload = {} -- pass reference so any event handler may add resources that should be awarded with this ambition
     local ambition_tags = ambition.tags and table.copy(ambition.tags) or {}
     core:trigger_event("ScriptEventAmbitionPayloadsAboutToBeCreated", {
          faction_key = faction_key,
          additional_resources_payload = additional_resources_payload,
          ambition_tags = ambition_tags
     })

     if #additional_resources_payload > 0 then
          local payload = payloads.generate_ambition_resource_reward_payload(additional_resources_payload)
          mm:add_payload(fix_up_start_pos_id(payload))
     end
end

ambitions.try_to_generate_ambitions = function(faction_key)
     local excluded_pools = {}
     local faction_data = ambitions.faction_data[faction_key]

     if faction_data.should_open_ambitions_panel then
          -- Already have some ambitions generated, don't try to generate new ones
          return
     end

     local pool = nil
     local num_generated_ambitions = 0

     local scribes = {} -- pass reference so any event handler may add scribes that we can use when generating the ambition
     core:trigger_event("ScriptEventAttemptingToGenerateAmbitions", { faction_key = faction_key, scribes = scribes })

     repeat
          pool = ambitions.get_next_ready_pool(faction_key, excluded_pools)
          if pool then
               num_generated_ambitions = ambitions.generate_ambitions(faction_key, pool, scribes)
               if num_generated_ambitions == 0 then
                    table.insert(excluded_pools, pool.name)
               end
          end
     until pool == nil or num_generated_ambitions > 0

     if num_generated_ambitions > 0 then
          faction_data.should_open_ambitions_panel = true
          local faction = cm:get_faction(faction_key)
          cm:set_script_state(faction, ambitions.shared_states.is_presented_with_ambitions, true)
     end

     if faction_data.should_open_ambitions_panel and cm:get_local_faction_name(true) == faction_key then
          ui.open_panel_asap_with_intervention()
     end
end

-- Scribes are from the Ancient Legacy Sargon mechanic. Please look at that mechanic for more info
ambitions.generate_ambitions = function(faction_key, pool, optional_scribes)
     local faction = cm:get_faction(faction_key)
     cm:clear_pending_missions(faction)
     local random_ambitions = ambitions.weighted_pick_ambitions_from_pool(faction_key, pool, optional_scribes)

     local comma_separated_ambition_keys = ""
     for _, ambition_key in ipairs(random_ambitions) do
          ambitions.create_pending_mission_for_ambition(faction_key, ambition_key)
          comma_separated_ambition_keys = comma_separated_ambition_keys .. ambition_key .. ","
     end

     if cm:get_local_faction_name(true) == faction_key then
          cm:notify_ambition_list_displayed(faction_key, comma_separated_ambition_keys)
     end

     return #random_ambitions
end

local function generate_specific_ambitions_impl(faction_key, ambitions_list)
     local faction_data = ambitions.faction_data[faction_key]
     faction_data.should_open_ambitions_panel = true
     local faction = cm:get_faction(faction_key)
     cm:set_script_state(faction, ambitions.shared_states.is_presented_with_ambitions, true)

     for _, ambition_key in ipairs(ambitions_list) do
          ambitions.create_pending_mission_for_ambition(faction_key, ambition_key)
     end
end

ambitions.generate_specific_ambitions = function(faction_key, ambitions_list)
     if not is_table(ambitions_list) or #ambitions_list == 0 then
          return
     end

     generate_specific_ambitions_impl(faction_key, ambitions_list)

     if cm:get_local_faction_name(true) == faction_key then
          ui.open_panel_asap()
     end
end

ambitions.generate_specific_ambitions_with_intervention = function(faction_key, ambitions_list)
     if not is_table(ambitions_list) or #ambitions_list == 0 then
          return
     end

     generate_specific_ambitions_impl(faction_key, ambitions_list)

     if cm:get_local_faction_name(true) == faction_key then
          ui.open_panel_asap_with_intervention()
     end
end

ambitions.ambition_condition_is_met = function(faction_key, ambition)
     local condition = ambition.condition
     local ambition_key = ambition.ambition_key
     local faction_data = ambitions.faction_data[faction_key]
     -- We reset the metadata here in case there is some leftover from before
     faction_data.ambition_metadata[ambition_key] = {}
     local metadata = faction_data.ambition_metadata[ambition_key]

     if is_table(condition) then
          for _, sub_condition in ipairs(condition) do
               if is_function(sub_condition) and not sub_condition(faction_key, metadata) then
                    return false
               end

               if is_boolean(sub_condition) and not sub_condition then
                    return false
               end
          end
     end

     if is_function(condition) and not condition(faction_key, metadata) then
          return false
     end

     if is_boolean(condition) and not condition then
          return false
     end

     return true
end

ambitions.num_faction_additional_ambition_slots = function(faction_key, pool)
     local additional_ambition_slots = 0
     local faction = cm:get_faction(faction_key)
     local technology_table = pool.max_pending_ambitions_additional_technology_table
     if technology_table then
          for i = 1, #technology_table do
               local technology_key = technology_table[i][1]
               local number_of_additional_slot = technology_table[i][2]
               if faction:has_technology(technology_key) then
                    additional_ambition_slots = additional_ambition_slots + number_of_additional_slot
               end
          end
     end

     return additional_ambition_slots
end

-- Pick a random ambition from an ambition pool. Returns ambition key
ambitions.weighted_pick_ambitions_from_pool = function(faction_key, pool, optional_scribes)
     local faction_data = ambitions.faction_data[faction_key]
     local faction_pool = ambitions.ambitions_pool[faction_key][pool.name]

     local weighted_ambitions = weighted_list:new()

     -- Scribes force certain ambitions to show up.
     -- E.g. a scribe can force at least 1 ambition with the conqueror tag to show up.
     -- To do this we create a weighted list for each scribe and add possible ambitions into that scribe's list.
     -- After that we first pull from the scribe weighted lists and then the regular one
     local weighted_scribes_ambitions = {}
     for i = 1, #(optional_scribes or {}) do
          weighted_scribes_ambitions[i] = weighted_list:new()
     end

     -- Go through all ambitions and check their conditions. If all is fine then add them to the weighted lists
     for _, ambition in ipairs(faction_pool) do
          local ambition_key = ambition.ambition_key

          if (not ambitions.enable_whitelist or ambitions.whitelist[ambition_key])
              and not table_find(faction_data.active_ambitions, function(element) return element.ambition_key ==
                   ambition_key end)
          then
               ambition, _ = ambitions.get_ambition_table(ambition_key)
               if (faction_data.ambition_selections[ambition_key] or 0) < (ambition.max_selections or 9999999)
                   and (faction_data.ambition_appearances[ambition_key] or 0) < (ambition.max_appearances or 9999999)
                   and faction_data.last_seen_ambition_from_pool[pool.name] ~= ambition_key
                   and ambitions.ambition_condition_is_met(faction_key, ambition)
               then
                    local ambition_weight = ambitions.get_ambition_weight(faction_key, ambition)
                    weighted_ambitions:add_item(ambition, ambition_weight)

                    for i, scribe in ipairs(optional_scribes or {}) do
                         if ancient_legacies_sargon.scribe_type_matches_ambition(scribe, ambition) then
                              weighted_scribes_ambitions[i]:add_item(ambition, ambition_weight)
                         end
                    end
               end
          end
     end

     local additional_ambition_slots = ambitions.num_faction_additional_ambition_slots(faction_key, pool)
     local num_ambitions_to_pick = pool.max_pending_ambitions + additional_ambition_slots

     local picked_ambitions = {}

     -- Helper function to check if an ambition we're picking has already been picked and to increase that ambition's appearances
     local ambition_picked = function(weighted_list, picked_ambition, index)
          weighted_list:remove_item(index)
          if not table_contains(picked_ambitions, picked_ambition.ambition_key) then
               table.insert(picked_ambitions, picked_ambition.ambition_key)
               num_ambitions_to_pick = num_ambitions_to_pick - 1

               if picked_ambition.max_appearances then
                    faction_data.ambition_appearances[picked_ambition.ambition_key] = (faction_data.ambition_appearances[ambition_key] or 0) +
                    1
               end
               return true
          end
          return false
     end

     -- First we add scribe ambitions to the picked ambitions list
     for i, scribe in ipairs(optional_scribes or {}) do
          local number_of_forced_missions_for_scribe = ancient_legacies_sargon.get_number_of_forced_missions_for_scribe(
          scribe)
          local num_to_pick = math.min(num_ambitions_to_pick, number_of_forced_missions_for_scribe)
          while num_to_pick > 0 do
               local picked_ambition, index = weighted_scribes_ambitions[i]:weighted_select()
               if picked_ambition then
                    if ambition_picked(weighted_scribes_ambitions[i], picked_ambition, index) then
                         num_to_pick = num_to_pick - 1
                    end
               else
                    break
               end
          end
     end

     -- Then we add regular ambitions if we have pending ambition slots left
     while num_ambitions_to_pick > 0 do
          local picked_ambition, index = weighted_ambitions:weighted_select()
          if picked_ambition then
               ambition_picked(weighted_ambitions, picked_ambition, index)
          else
               break
          end
     end

     return picked_ambitions
end

ambitions.get_pool_metadata = function(faction_key, pool_name)
     local faction_data = ambitions.faction_data[faction_key]

     if not faction_data then
          script_error("Trying to get pool metadata for pool=" ..
          pool_name ..
          " and faction=" .. faction_key .. " but that faction has no ambition faction data. Something is wrong.")
          return
     end

     return faction_data.pool_metadata[pool_name]
end

-- Returns the ambitions design table
ambitions.get_ambition_table = function(ambition_key, pool_name, skip_error)
     for _, pool in ipairs(ambitions.pools) do
          if not pool_name or (pool.name == pool_name) then
               local ambition = pool.paired_ambitions[ambition_key]
               if ambition then
                    return ambition, pool
               end
          end
     end

     if not to_bool(skip_error) then
          script_error("Phar Ambitions: Could not find the table for ambition: " .. ambition_key)
     end
end

-- Sets the data table of the specified ambition to be an empty table. Use with caution, as certain data keys are used by the ambition system on startup so clearing them
-- while the system is running will have adverse affects. Only data tables that are solely used to generate the ambition/mission should be cleared, and they should really only
-- be cleared (and then presumably repopulated with ambitions.inject_data) immediately prior to the ambition being triggered.
ambitions.clear_data_table_for_key = function(pool_name, ambition_key, data_key)
     local ambition_table = ambitions.get_ambition_table(ambition_key, pool_name)
     if ambition_table then
          ambition_table[data_key] = {}
     else
          script_error("ERROR: ambitions.clear_data_for_key() could not find an ambition in pool [" ..
          tostring(pool_name) .. "] with key [" .. ambition_key .. "]")
     end
end

ambitions.clear_objectives = function(pool_name, ambition_key)
     ambitions.clear_data_table_for_key(pool_name, ambition_key, "objectives")
end

ambitions.clear_reward_payloads = function(pool_name, ambition_key)
     ambitions.clear_data_table_for_key(pool_name, ambition_key, "reward_payloads")
end

ambitions.clear_reward_scripted = function(pool_name, ambition_key)
     ambitions.clear_data_table_for_key(pool_name, ambition_key, "reward_scripted")
end

-- Injects data at the specified key of the specified ambition. Use with caution, as certain data keys are used by the ambition system on startup so modifying them while
-- the system is running will have adverse affects. Only data tables that are solely used to generate the ambition/mission should be modified with these functions, and the
-- intention is that such modifications are only made immediately prior to the ambition being triggered. This allows the ambition data to be dynamic rather that static (e.g.
-- "recruit n many units", where n is dependent on the size of an approaching enemy, or defeat force x which has just invaded the player's territory).
ambitions.inject_data = function(pool_name, ambition_key, data_key, data, force_table_data_type)
     local ambition_table = ambitions.get_ambition_table(ambition_key, pool_name)
     if ambition_table then
          if is_table(ambition_table[data_key]) then
               -- The data at the supplied key already exists as a table (e.g. ambition.objectives) so add the data to the table
               table.insert(ambition_table[data_key], data)
          elseif force_table_data_type then
               -- The data at the supplied key is not a table, but we're being forced to create a table if one does not already exist
               ambition_table[data_key] = { data }
          else
               -- The data at the supplied key is not a table (e.g. ambition.rarity) and we're not being forced to create one, so overwrite the existing data
               ambition_table[data_key] = data
          end
     else
          script_error("ERROR: ambitions.inject_data() could not find an ambition in pool [" ..
          tostring(pool_name) .. "] with key [" .. ambition_key .. "]")
     end
end;

ambitions.inject_objective = function(pool_name, ambition_key, objective)
     return ambitions.inject_data(pool_name, ambition_key, "objectives", objective, true)
end

ambitions.inject_reward_payloads = function(pool_name, ambition_key, reward_payload)
     return ambitions.inject_data(pool_name, ambition_key, "reward_payloads", reward_payload, true)
end

ambitions.inject_reward_scripted = function(pool_name, ambition_key, reward_scripted)
     return ambitions.inject_data(pool_name, ambition_key, "reward_scripted", reward_scripted, true)
end

ambitions.start_pool_listeners = function()
     if ambitions.initialized_pool_listeners then
          return
     end

     ambitions.initialized_pool_listeners = true

     local player_factions = cm:get_human_factions()

     if player_factions then
          for _, faction_key in ipairs(player_factions) do
               local faction_data = ambitions.faction_data[faction_key]
               if faction_data then
                    ambitions.faction_start_pool_listeners(faction_key)
               end
          end
     end
end

ambitions.faction_start_pool_listeners = function(faction_key)
     local create_pool_listener = function(event_data, pool_name, event_index)
          core:add_listener(
               "AmbitionPoolEvent_" .. faction_key .. pool_name .. tostring(event_index),
               event_data.event,
               function(context)
                    local pool_metadata = ambitions.get_pool_metadata(faction_key, pool_name)
                    return event_data.condition(context, faction_key, pool_metadata, pool_name)
               end,
               function(context)
                    local pool_metadata = ambitions.get_pool_metadata(faction_key, pool_name)
                    event_data.callback(context, faction_key, pool_metadata, pool_name)
               end,
               event_data.persistent or false
          )
     end

     for _, pool in ipairs(ambitions.pools) do
          local faction_pool = ambitions.ambitions_pool[faction_key][pool.name]
          if faction_pool then
               local events = (pool.type == "event_based" and pool.events) or {}
               for event_index, event in ipairs(events) do
                    create_pool_listener(event, pool.name, event_index)
               end
          end
     end
end

ambitions.start_ambition = function(faction_key, ambition_key, loading_a_save, custom_id)
     local current_turn = cm:turn_number()

     if not loading_a_save then
          custom_id = faction_key .. "_" .. ambition_key .. "_" .. tostring(current_turn)
     end

     local ambition, pool = ambitions.get_ambition_table(ambition_key)
     local faction_data = ambitions.faction_data[faction_key]
     local metadata = faction_data.ambition_metadata[ambition_key]
     metadata.ambition_key = ambition_key
     metadata.custom_id = custom_id

     local mm = mission_manager:new(
          faction_key,
          ambition_key,
          ambitions.ambition_success_callback(faction_key, ambition, metadata),
          ambitions.ambition_failure_callback(faction_key, ambition),
          ambitions.ambition_cancelled_callback(faction_key, ambition),
          nil, -- nearing expiry callback
          custom_id
     )

     if not mm then
          script_error("ERROR: ambitions.start_ambition() failed to generate a mission managher for faction [" ..
          faction_key ..
          "] and ambition [" .. tostring(ambition_key) .. "], there may be a more descriptive error before this one")
          return false;
     end;

     local faction = cm:get_faction(faction_key)
     cm:clear_pending_missions(faction)

     if not loading_a_save then
          if ambition.max_selections then
               faction_data.ambition_selections[ambition_key] = 1 + (faction_data.ambition_selections[ambition_key] or 0)
          end

          local active_ambition = {
               ambition_key = ambition_key,
               start_turn = current_turn,
               custom_id = custom_id,
               pool_name = pool.name,
          }
          table.insert(faction_data.active_ambitions, active_ambition)

          faction_data.last_seen_ambition_from_pool[pool.name] = ambition_key

          for _, tag in ipairs(ambition.tags) do
               faction_data.tag_num_times_chosen[tag] = 1 + (faction_data.tag_num_times_chosen[tag] or 0)
          end
     end

     dismiss_callbacks = {}

     ambitions.setup_ambition_objectives(ambition, mm, dismiss_callbacks, faction_key, metadata)
     ambitions.setup_ambition_payloads(ambition, mm, faction_key, metadata)

     local ambition_expiry = ambitions.get_ambition_expiration(ambition)
     if is_number(ambition_expiry) and ambition_expiry >= 0 then
          mm:set_turn_limit(ambition_expiry)
     end
     mm:suppress_on_abort_event_message(true)
     mm:suppress_on_issued_event_message(true)

     if not loading_a_save then
          if #dismiss_callbacks > 0 then
               mm:trigger(
                    function()
                         for _, v in ipairs(dismiss_callbacks) do
                              v()
                         end
                    end,
                    0
               )
          else
               mm:trigger()
          end

          for index, objective in ipairs(ambition.objectives) do
               local script_key = ambition.ambition_key .. "_" .. index
               if is_function(objective) then
                    objective = objective(faction_key, metadata, script_key)
               end

               if objective.create_initial_custom_display_text then
                    local display_text, str_param1, str_param2, str_param3 = objective
                    .create_initial_custom_display_text(faction_key, metadata, script_key, true)
                    str_param1 = str_param1 or ""
                    str_param2 = str_param2 or ""
                    str_param3 = str_param3 or ""
                    if display_text and #display_text > 0 then
                         cm:set_scripted_mission_text(ambition.ambition_key, script_key, display_text, str_param1,
                              str_param2, str_param3);
                    end
               end
          end
     end

     faction_data.should_open_ambitions_panel = false
     cm:set_script_state(faction, ambitions.shared_states.is_presented_with_ambitions, false)

     if not loading_a_save then
          if cm:get_local_faction_name(true) == faction_key then
               cm:notify_ambition_status_changed(faction_key, ambition_key, "picked")
          end

          core:trigger_event("ScriptEventAmbitionStarted", faction, ambition_key)
     end
end

ambitions.create_pending_mission_for_ambition = function(faction_key, ambition_key)
     local ambition, _ = ambitions.get_ambition_table(ambition_key)
     local mm = mission_manager:new(faction_key, ambition_key)
     local faction_data = ambitions.faction_data[faction_key]

     if not faction_data.ambition_metadata[ambition_key] then
          faction_data.ambition_metadata[ambition_key] = {}
     end

     local metadata = faction_data.ambition_metadata[ambition_key]

     ambitions.setup_pending_ambition_objectives(ambition, mm, faction_key, metadata)
     ambitions.setup_ambition_payloads(ambition, mm, faction_key, metadata)

     -- This does not do anything for pending missions but is
     -- needed to properly display the mission expiry when selecting an ambition
     local ambition_expiry = ambitions.get_ambition_expiration(ambition)
     if is_number(ambition_expiry) and ambition_expiry >= 0 then
          mm:set_turn_limit(ambition_expiry)
     end
     mm:suppress_on_abort_event_message(true)
     mm:suppress_on_issued_event_message(true)

     local faction = cm:get_faction(faction_key)
     local mission_string = mm:get_mission_string()

     cm:add_custom_pending_mission_from_string(faction, faction, mission_string)

     for index, objective in ipairs(ambition.objectives) do
          local script_key = ambition_key .. "_" .. index
          if is_function(objective) then
               objective = objective(faction_key, metadata, script_key)
          end

          if objective.create_initial_custom_display_text then
               local display_text, str_param1, str_param2, str_param3 = objective.create_initial_custom_display_text(
               faction_key, metadata, script_key, false)
               str_param1 = str_param1 or ""
               str_param2 = str_param2 or ""
               str_param3 = str_param3 or ""
               if display_text and #display_text > 0 then
                    cm:set_scripted_mission_text(ambition.ambition_key, script_key, display_text, str_param1, str_param2,
                         str_param3);
               end
          end
     end
end

ambitions.get_active_ambitions_for_faction = function(faction_key)
     local faction_data = ambitions.faction_data[faction_key]

     return (faction_data and faction_data.active_ambitions) or {}
end

ambitions.get_active_ambition_table = function(faction_key, ambition_key)
     local faction_data = ambitions.faction_data[faction_key]

     for _, active_ambition in ipairs(faction_data.active_ambitions) do
          if active_ambition.ambition_key == ambition_key then
               return active_ambition
          end
     end

     return nil
end

ambitions.setup_pool_cooldown = function(faction_key, pool_name, cooldown_override)
     local faction_data = ambitions.faction_data[faction_key]
     local pool = ambitions.get_pool_from_name(pool_name)

     if not pool then
          script_error("Ambitions: pool with key '" .. pool_name .. "' not found!")
     end

     local cooldown = cooldown_override or pool.cooldown
     if cooldown then
          local pool_metadata = faction_data.pool_metadata[pool_name]

          if not pool_metadata then
               out("Pool metadata was not found for pool " ..
               tostring(pool_name) ..
               ". This usually means that this pool was not initialized at the start of a new game, which is usually because of wrong conditions for that pool. Lua will crash now.")
          end

          pool_metadata.cooldown = cooldown
     end
end

-- Does not stop already-running ambitions, only removes it from the faction-data
ambitions.remove_active_ambition = function(faction_key, ambition_key)
     local faction_data = ambitions.faction_data[faction_key]

     for idx, active_ambition in ipairs(faction_data.active_ambitions) do
          if active_ambition.ambition_key == ambition_key then
               if active_ambition.pool_name then -- to guard against ambitions in older saves which didn't have the `pool_name` member
                    local ambition_table = ambitions.get_ambition_table(ambition_key)
                    ambitions.setup_pool_cooldown(faction_key, active_ambition.pool_name,
                         ambition_table.cooldown_override)
               end

               table.remove(faction_data.active_ambitions, idx)
               break
          end
     end
end

ambitions.active_ambitions_from_pool = function(faction_key, pool_name)
     local faction_data = ambitions.faction_data[faction_key]
     local num_active_ambitions = 0

     for idx, active_ambition in ipairs(faction_data.active_ambitions) do
          if active_ambition.pool_name == pool_name then
               num_active_ambitions = 1 + num_active_ambitions
          end
     end

     return num_active_ambitions
end

-- Adds a pool to the pool queue for a faction. This is only for event_based pools.
-- Will cause the pool to fire up its ambitions once all other pools in the queue are done with.
ambitions.add_pool_to_queue = function(faction_key, pool_name)
     local faction_data = ambitions.faction_data[faction_key]

     if not faction_data then
          script_error("Trying to add pool=" ..
          pool_name .. " to faction=" .. faction_key .. "'s queue, but they have no action data. Something is wrong.")
          return
     end

     if not table_contains(faction_data.next_ambition_pool_queue, pool_name) then
          table.insert(faction_data.next_ambition_pool_queue, pool_name)
     end
end

ambitions.get_pool_from_name = function(pool_name)
     for _, pool in ipairs(ambitions.pools) do
          if pool.name == pool_name then
               return pool
          end
     end

     return nil
end

ambitions.check_pool_additional_conditions = function(faction_key, pool, metadata)
     for _, condition in ipairs(pool.additional_ambition_conditions or {}) do
          if condition == false or is_nil(condition) then
               return false
          end

          if is_function(condition) and not condition(faction_key, metadata) then
               return false
          end
     end

     return true
end

-- Returns the next pool that is ready to have an ambition displayed
ambitions.get_next_ready_pool = function(faction_key, excluded_pools)
     local faction_data = ambitions.faction_data[faction_key]

     if faction_data.ambition_choices_this_turn >= ambitions.max_ambition_choices_per_turn then
          return
     end

     if #faction_data.next_ambition_pool_queue > 0 then
          local pool_name = faction_data.next_ambition_pool_queue[1]

          if not excluded_pools[pool_name] then
               local pool = ambitions.get_pool_from_name(pool_name)
               local num_pool_active_ambitions = ambitions.active_ambitions_from_pool(faction_key, pool.name)

               if not is_number(pool.max_active_ambitions) or num_pool_active_ambitions < pool.max_active_ambitions then
                    table.remove(faction_data.next_ambition_pool_queue, 1)
                    faction_data.ambition_choices_this_turn = 1 + faction_data.ambition_choices_this_turn
                    return ambitions.get_pool_from_name(pool_name)
               end
          end
     end

     local faction_pools = ambitions.ambitions_pool[faction_key]

     if faction_pools then
          local current_turn = cm:turn_number()

          for _, pool in ipairs(ambitions.pools) do
               if pool.type == "cooldown_based"
                   and faction_pools[pool.name]
                   and (not pool.start_turn or current_turn >= pool.start_turn)
                   and not excluded_pools[pool.name]
               then
                    local metadata = faction_data.pool_metadata[pool.name]
                    local num_pool_active_ambitions = ambitions.active_ambitions_from_pool(faction_key, pool.name)

                    if (metadata.cooldown or 0) <= 0
                        and (not is_number(pool.max_active_ambitions)
                             or num_pool_active_ambitions < pool.max_active_ambitions)
                        and ambitions.check_pool_additional_conditions(faction_key, pool, metadata)
                    then
                         faction_data.ambition_choices_this_turn = 1 + faction_data.ambition_choices_this_turn
                         return pool
                    end
               end
          end
     end
end

ambitions.get_ambition_expiration = function(ambition)
     return ambition.expiration or ambitions.defaults.ambition_expiration
end

ambitions.ambition_expired = function(faction_key, ambition_key)
     local active_ambition = ambitions.get_active_ambition_table(faction_key, ambition_key)
     if active_ambition then
          local ambition, _ = ambitions.get_ambition_table(ambition_key)
          local ambition_expiration = ambitions.get_ambition_expiration(ambition)
          if ambition_expiration < 0 then
               return false
          end

          local current_turn = cm:turn_number()
          if current_turn - active_ambition.start_turn >= ambition_expiration then
               return true
          end
     end

     return false
end

ambitions.debug_check_for_duplications = function()
     local cur_ambitions = {}

     local crash_lua = function(ambition_key)
          script_error("Ambitions: " .. ambition_key .. " is the ambition key for 2 separate ambitions.")
          -- crashing game
          local res = nil .. "forced_crash"
     end

     for _, pool in pairs(ambitions.pools) do
          for _, ambition in ipairs(pool.ambitions) do
               if cur_ambitions[ambition.ambition_key] then
                    crash_lua(ambition.ambition_key)
               end
               cur_ambitions[ambition.ambition_key] = true
          end
     end
end

ambitions.get_ambitions_increase_conditions = function(faction_key)
     local conditions = {}

     for _, func in ipairs(ambitions.defaults.max_ambitions_increase_conditions) do
          table.insert(conditions, func)
     end

     for _, func in ipairs(ambitions.max_ambitions_increase_conditions[faction_key] or {}) do
          table.insert(conditions, func)
     end

     return conditions
end

ambitions.get_ambition_rarity = function(ambition)
     return ambition.rarity or ambitions.defaults.rarity
end

ambitions.get_ambition_max_selections = function(ambition)
     return ambition.max_selections or ambitions.defaults.max_selections
end

ambitions.get_ambition_weight = function(faction_key, ambition)
     local faction_data = ambitions.faction_data[faction_key]
     local weight = ambitions.weights[ambition.ambition_key] or ambitions.defaults.weight
     for _, tag in ipairs(ambition.tags) do
          local faction_bonus = (ambitions.faction_starting_tag_weight_bonus[faction_key] and ambitions.faction_starting_tag_weight_bonus[faction_key][tag]) or
          0
          local tag_bonus = (faction_data.tag_num_times_chosen[tag] or 0) *
          (ambitions.tag_weight_bonus[tag] or ambitions.defaults.tag_weight_bonus)
          weight = weight + faction_bonus + tag_bonus
     end
     return weight
end

ambitions.ambition_excluded_for_faction = function(ambition, faction_key)
     return to_bool(table_find(ambition.exclude_factions or {}, faction_key))
end

ambitions.get_pool_metadata = function(faction_key, pool_name)
     return ambitions.faction_data[faction_key].pool_metadata[pool_name]
end

ambitions.get_pool_from_name = function(pool_name)
     for _, pool in ipairs(ambitions.pools) do
          if pool.name == pool_name then
               return pool
          end
     end

     return nil
end

ambitions.tick_down_pool_cooldowns = function(faction_key)
     local faction_data = ambitions.faction_data[faction_key]

     for _, pool in ipairs(ambitions.pools) do
          local metadata = faction_data.pool_metadata[pool.name]
          if metadata and pool.type == "cooldown_based" and (metadata.cooldown or 0) > 0 then
               metadata.cooldown = metadata.cooldown - 1
          end
     end
end

ambitions.debug_helpers = {
     print_all_condition_results = function(faction_key)
          if not faction_key then
               faction_key = cm:get_local_faction_name(true)
          end
          local ambitions_pool = ambitions.ambitions_pool[faction_key]
          local num_col_chars = 16

          out("----------------------------------------------------------------------------------")
          out("---- Ambitions debug helpers: Checking all ambition conditions for faction " ..
          tostring(faction_key) .. " ----")
          out("----------------------------------------------------------------------------------")

          if not ambitions_pool then
               out("----------------------------------------------------------------------------------")
               out("---- There are no ambitions for the faction " .. tostring(faction_key) .. " ----")
               out("----------------------------------------------------------------------------------")
               return
          end

          for pool, ambitions_list in pairs(ambitions_pool) do
               out("-----------------------------------------------")
               out("---------- Pool: " .. tostring(pool) .. " ----------")
               out("-----------------------------------------------")

               for _, ambition in ipairs(ambitions_list) do
                    local ambition_key = ambition.ambition_key
                    ambition, _ = ambitions.get_ambition_table(ambition_key)
                    local condition_result = ambitions.ambition_condition_is_met(faction_key, ambition)
                    local out_str = tostring(ambition.ambition_key)

                    if string.len(out_str) < num_col_chars then
                         out_str = out_str .. string.rep(" ", num_col_chars - string.len(out_str))
                    end

                    out_str = out_str .. " = " .. tostring(condition_result)

                    out(out_str)
               end
          end

          out("----------------------------------------------------------------------------------")
          out("--------- Ambitions debug helpers: Done checking for ambition conditions ---------")
          out("----------------------------------------------------------------------------------")
     end
}

-----------------------
------ UI Stuff -------
-----------------------

ui.panel = nil
ui.panel_id = "ambitions"
ui.panel_path = "UI/Campaign UI/ambitions"
ui.faction_key = nil
ui.ui_trigger_event = "ambition_selected"
ui.accept_button_id = "button_accept"
ui.ambitions_list_id = "ambitions_list"
ui.intervention_object = nil

-- Creates an intervention in singleplayer mode, and when that starts then the panel is created. This ensures that
-- this panel will not show up during dilemmas, character replacement screen or other things that lock up the UI
ui.open_panel_asap_with_intervention = function()
     if cm:is_multiplayer() then
          -- Hack: wait a short period in multiplayer to allow any start-of-turn dilemmas to become active
          cm:callback(
               function()
                    ui.open_panel_asap()
               end,
               0.5,
               "ui_open_panel_asap"
          );
     else
          cm:trigger_transient_intervention(
               "ambition_selection_intervention",
               function(intervention_object)
                    ui.intervention_object = intervention_object
                    local uic, created = core:get_or_create_component(ui.panel_id, ui.panel_path)
                    if created then
                         ui.panel_opened(uic)
                    end
               end,
               false,
               function(config_ti)
                    config_ti:set_wait_for_dilemma(true);
                    config_ti:set_wait_for_fullscreen_panel_dismissed(true);
               end
          )
     end
end

ui.open_panel_asap = function()
     -- Guard against a dilemma being active
     local has_queued_intervention = is_table(final_intervention_list) and #final_intervention_list > 0
     if cm:model():has_pending_action() or has_queued_intervention then
          cm:callback(
               function()
                    ui.open_panel_asap()
               end,
               0.5,
               "ui_open_panel_asap"
          )
          return
     end

     local uic, created = core:get_or_create_component(ui.panel_id, ui.panel_path)
     if created then
          ui.panel_opened(uic)
     end
end

ui.panel_opened = function(uic)
     for index, listener in ipairs(ui.listeners) do
          core:add_listener(
               "ambitions_ui_" .. listener.event .. "_" .. index,
               listener.event,
               listener.filter,
               listener.body,
               true
          )
     end

     -- Prevent the player from opening other UI elements
     -- or using hotkeys during the ambition selection
     uic:LockPriority()

     ui.panel = uic
     ui.faction_key = cm:get_local_faction_name(true)

     local select_ambition_button = uic:SequentialFind("button_select_ambition")
     if select_ambition_button then
          select_ambition_button:SetState("inactive")
     end

     CampaignUI.TriggerPanelEvent("ambitions", true)
end

ui.panel_closed = function()
     out("Ambitions panel closed, deleting listeners")

     for index, listener in ipairs(ui.listeners) do
          core:remove_listener("ambitions_ui_" .. listener.event .. "_" .. index)
     end

     ui.panel = nil
     ui.faction_key = nil
end

ui.get_ambition_parent = function(uic)
     local parent = UIComponent(uic:Parent())

     while parent:Id() ~= ui.ambitions_list_id do
          uic = parent
          parent = uic:Parent()

          if not parent then
               return nil
          end

          parent = UIComponent(parent)
     end

     return uic
end

ui.select_ambition = function(selected_ambition, ambitions_list)
     for i = 0, ambitions_list:ChildCount() - 1 do
          local deselected_ambition = UIComponent(ambitions_list:Find(i))
          if deselected_ambition:Id() ~= selected_ambition:Id() then
               local ambition_cco = deselected_ambition:GetContextObject("CcoCampaignMission")
               local ambition_key = ambition_cco and ambition_cco:Call("MissionRecordContext().Key()")
               local ambition, _ = ambition_key and ambitions.get_ambition_table(ambition_key)

               if ambition then
                    deselected_ambition:SetState(ui.get_ambition_default_state(ambition))
               end
          end
     end

     local selected_ambition_cco = selected_ambition:GetContextObject("CcoCampaignMission")
     local selected_ambition_key = selected_ambition_cco and selected_ambition_cco:Call("MissionRecordContext().Key()")
     local selected_ambition_table, _ = selected_ambition_key and ambitions.get_ambition_table(selected_ambition_key)

     if selected_ambition_table then
          selected_ambition:SetState(ui.get_ambition_selected_state(selected_ambition_table))
     end
end

ui.initialize_tags_icons = function(ambition_uic, ambition_key, scribes)
     local tag_icon_template = ambition_uic:SequentialFind("type_template")
     if not tag_icon_template then
          return
     end

     local icons_list = UIComponent(tag_icon_template:Parent())
     local ambition, _ = ambitions.get_ambition_table(ambition_key)

     -- The following and/or "ternary operator" is intentional and used to prevent the game from crashing if the ambition is not found.
     for _, tag in ipairs(ambition and ambition.tags or {}) do
          local icon = UIComponent(icons_list:CreateFromComponent(tag_icon_template:Address(), tag))
          icon:SetState(tag)
          icon:SetTooltipWithTitle(
               ambitions.tags[tag] and ambitions.tags[tag].localised_name_key or
               string.format("missing string in Lua for tag <%s>", tag),
               ambitions.tags[tag] and ambitions.tags[tag].localised_description_key or
               string.format("missing string in Lua for tag <%s>", tag),
               true)

          local is_scribe_ambition = false
          for _, scribe_config in ipairs(scribes) do
               if table_contains(scribe_config.domains, tag) then
                    is_scribe_ambition = true
                    break
               end
          end

          local scribe_glow_icon = icon:SequentialFind("scribe_active_glow")
          if scribe_glow_icon then
               scribe_glow_icon:SetVisible(is_scribe_ambition)
          end
     end

     tag_icon_template:SetVisible(false)
end

ui.get_ambition_default_state = function(ambition)
     return ambitions.get_ambition_rarity(ambition)
end

ui.get_ambition_hover_state = function(ambition)
     return ambitions.get_ambition_rarity(ambition) .. "_hover"
end

ui.get_ambition_selected_state = function(ambition)
     return ambitions.get_ambition_rarity(ambition) .. "_selected"
end

-----------------------
----- Listeners -------
-----------------------

ambitions.listeners = {
     --[[
	{
		event = "",
		filter = function(context) end,
		body = function(context) end
	},
	--]]

     {
          event = "FactionTurnStart",
          filter = function(context)
               return to_bool(ambitions.faction_data[context:faction():name()])
          end,
          body = function(context)
               local faction_key = context:faction():name()

               ambitions.tick_down_pool_cooldowns(faction_key)

               local faction_data = ambitions.faction_data[faction_key]
               faction_data.ambition_choices_this_turn = 0

               ambitions.try_to_generate_ambitions(faction_key)
          end
     },

     {
          event = "UITriggerScriptEvent",
          filter = function(context)
               return context:trigger():split(":")[1] == ui.ui_trigger_event
          end,
          body = function(context)
               local splits = context:trigger():split(":")

               local ambition_key = splits[2]

               local faction_cqi = context:faction_cqi()
               local faction = cm:model():faction_for_command_queue_index(faction_cqi)
               local faction_key = faction:name()

               ambitions.start_ambition(faction_key, ambition_key)

               if ui.intervention_object then
                    ui.intervention_object:complete()
                    ui.intervention_object = nil
               end
          end
     },

     {
          event = "ContextTriggerEvent",
          filter = function(context)
               return string.starts_with(context.string, "ambition_card_mission_cco_set")
          end,
          body = function(context)
               local splits = context.string:split(":")
               local ambition_uic_id = splits[2]

               local ambition_uic = nil
               if context.component then
                    ambition_uic = UIComponent(context.component)
               else
                    ambition_uic = core:get_ui_root():SequentialFind(ambition_uic_id)
               end

               if ambition_uic then
                    local ambition_cco = ambition_uic:GetContextObject("CcoCampaignMission")

                    if ambition_cco then
                         local ambition_key = ambition_cco:Call("MissionRecordContext().Key()")
                         local ambition, _ = ambitions.get_ambition_table(ambition_key)

                         if ambition then
                              ambition_uic:SetState(ui.get_ambition_default_state(ambition))
                         end

                         local scribes = {} -- pass reference so any event handler may add scribes that we can use when displaying tags
                         local faction_key = cm:get_local_faction_name(true)
                         core:trigger_event("UIScriptEventDisplayAmbitionTags",
                              { faction_key = faction_key, scribes = scribes })

                         ui.initialize_tags_icons(ambition_uic, ambition_key, scribes)
                    end
               end
          end,
     },
}

ui.listeners = {
     --[[
	{
		event = "",
		filter = function(context) end,
		body = function(context) end
	},
	--]]

     -- Currently only used to close the panel as it is opened in a hacky way.
     -- This will probably be removed in the future
     {
          event = "ComponentLClickUp",
          filter = function(context)
               return ui.panel and uicomponent_descended_from(UIComponent(context.component), ui.panel_id)
          end,
          body = function(context)
               local clicked_string = context.string

               local close_panel = function()
                    CampaignUI.TriggerPanelEvent("ambitions", false)
                    ui.panel:Destroy()
                    ui.panel_closed()
               end

               if clicked_string == "button_select_ambition" then
                    close_panel()
                    return
               end

               local uic = UIComponent(context.component)
               local parent = UIComponent(uic:Parent())

               if parent:Id() == "ambitions_list" then
                    ui.select_ambition(uic, parent)
               end
          end
     },
}

cm:add_saving_game_callback(
     function(context)
          local SAVE_VERSION = 3
          cm:save_named_value("PHAR_AMBITIONS_SAVE_VERSION", SAVE_VERSION, context)
          cm:save_named_value("PHAR_AMBITIONS_FACTION_DATA", ambitions.faction_data, context)
          cm:save_named_value("PHAR_AMBITIONS_MISC_DATA", ambitions.misc_data, context)
     end
)

cm:add_loading_game_callback(
     function(context)
          local SAVE_VERSION = cm:load_named_value("PHAR_AMBITIONS_SAVE_VERSION", 0, context)

          if SAVE_VERSION >= 1 then
               ambitions.faction_data = cm:load_named_value("PHAR_AMBITIONS_FACTION_DATA", {}, context)
               ambitions.misc_data = cm:load_named_value("PHAR_AMBITIONS_MISC_DATA", {}, context)

               for _, faction_data in pairs(ambitions.faction_data) do
                    if not faction_data.ambition_selections then
                         faction_data.ambition_selections = {}
                    end

                    if not faction_data.ambition_appearances then
                         faction_data.ambition_appearances = {}
                    end
               end

               for _, faction_key in ipairs(sea_peoples_playable_faction_keys) do -- can't check for a human faction or for cm:get_faction() at this point of initialization
                    local misc_data = ambitions.misc_data[faction_key]
                    if not misc_data then
                         ambitions.misc_data[faction_key] = {}
                         ambitions.misc_data[faction_key].num_faction_specific_ambitions_completed = 0
                    end
               end

               if SAVE_VERSION < 3 then
                    -- "ambition_appearances" got renamed to "ambition_selections"
                    -- re-introduced "ambition_appearances" with slightly different functionality
                    for _, faction_data in pairs(ambitions.faction_data) do
                         local temp = faction_data.ambition_selections
                         faction_data.ambition_selections = faction_data.ambition_appearances
                         faction_data.ambition_appearances = temp
                    end
               end
          else
               -- if this is old save data just re-initialize because it's difficult or impossible to reuse the older data
               ambitions.re_initialize_after_load = true
          end
     end
)

cm:add_first_tick_callback_new(
     function()
          if cm:is_benchmark_mode() then
               return
          end

          ambitions.new_game_initialization()
     end
)

cm:add_first_tick_callback(
     function()
          if cm:is_benchmark_mode() then
               return
          end

          if ambitions.re_initialize_after_load then
               ambitions.new_game_initialization()
          end

          ambitions.initialize_ambition_pools()

          ambitions.add_listeners()

          local human_factions = cm:get_human_factions()

          for _, faction_key in ipairs(human_factions) do
               local faction_data = ambitions.faction_data[faction_key]
               if faction_data then
                    for _, ambition_data in ipairs(faction_data.active_ambitions) do
                         ambitions.start_ambition(faction_key, ambition_data.ambition_key, true, ambition_data.custom_id)
                    end
               end
          end

          -- Check if the ambitions panel should be opened. This is needed when loading a save file
          -- made while the player is chosing the next active ambition
          local local_faction = cm:get_local_faction_name(true)
          -- this prevents errors during autoruns, where no local faction exists
          if local_faction and ambitions.faction_data[local_faction].should_open_ambitions_panel then
               ui.open_panel_asap_with_intervention()
          end
     end
)

function fix_up_start_pos_id(entry)
     return entry
end
