--Begin Pharaoh Dynasties new traits mod script

-- UNUSED IN CODE! This is for db naming consistency only. Can safely be deleted/commented out once mod is finished.
local TRAITS_REFERENCE_LIST = {
     "hcp_trait_degenerate",
     "hcp_trait_scout",
     "hcp_trait_attacking_victory",
     "hcp_trait_attacking_defeat",
     "hcp_trait_defending_defeat",
     "hcp_trait_defending_victory",
     "hcp_trait_siege_victory",
     "hcp_trait_siege_defeat",
     "hcp_trait_siege_defense_victory",
     "hcp_trait_wins_against_canaan",
     "hcp_trait_wins_against_hatti",
     "hcp_trait_wins_against_egypt",
     "hcp_trait_wins_against_sea_peoples",
     "hcp_trait_wins_against_mesopotamian",
     "hcp_trait_wins_against_danaans",
     "hcp_trait_wins_against_trojans",
     "hcp_trait_defeats_against_canaan",
     "hcp_trait_defeats_against_hatti",
     "hcp_trait_defeats_against_egypt",
     "hcp_trait_defeats_against_sea_peoples",
     "hcp_trait_defeats_against_mesopotamian",
     "hcp_trait_defeats_against_danaans",
     "hcp_trait_defeats_against_trojans",
     "hcp_trait_disciplinarian",
     "hcp_trait_bad_disciplinarian",
     "hcp_trait_sober",
     "hcp_trait_drink",
     "hcp_trait_girls",
     "hcp_trait_arse",
     "hcp_trait_gambler",
     "hcp_trait_bloody",
     "hcp_trait_inbred",
     "hcp_trait_popular",
     "hcp_trait_unpopular",
     "hcp_trait_lucky",
     "hcp_trait_unlucky",
     "hcp_trait_farmer_good",
     "hcp_trait_farmer_bad",
     "hcp_trait_bereaved",
     "hcp_trait_mad",
     "hcp_trait_healthy",
     "hcp_trait_blighted",
     "hcp_trait_sea_legs",
     "hcp_trait_feck",
     "hcp_trait_survivor",
     "hcp_trait_admin_good",
     "hcp_trait_admin_bad",
     "hcp_trait_miner",
     "hcp_trait_military_admin_good",
     "hcp_trait_military_admin_bad",
     "hcp_trait_warmonger",
     "hcp_trait_pacifist",
     "hcp_trait_cuckold",
     "hcp_trait_corrupt",
     "hcp_trait_factionkiller",
     "hcp_trait_noctophilia",
     "hcp_trait_noctophobia",
     "hcp_trait_slothful",
     "hcp_trait_energetic",
     "hcp_trait_charismatic",
     "hcp_trait_boring",
     "hcp_trait_trusting",
     "hcp_trait_paranoia",
     "hcp_trait_pragmatic",
     "hcp_trait_superstitious",
     "hcp_trait_anger",
     "hcp_trait_attractive",
     "hcp_trait_ugly",
     "hcp_trait_prophetic",
     "hcp_trait_authoritarian",
     "hcp_trait_liberal",
     "hcp_trait_fertile",
     "hcp_trait_barren",
     "hcp_trait_scarred",
     "hcp_trait_criminal",
     "hcp_trait_blind",
     "hcp_trait_heretic",
}

-- local LEGENDARY_LORD_DEFEAT_TRAIT = {
--     ["phar_hero_can_bay_bay"] = "hcp_trait_defeated_bay",
--     ["phar_hero_can_irs_irsu"] = "hcp_trait_defeated_irsu",
--     ["phar_hero_egy_ame_amenmesse"] = "hcp_trait_defeated_amenmesse",
--     ["phar_hero_egy_mer_merneptah"] = "hcp_trait_defeated_merneptah",
--     ["phar_hero_egy_ram_ramesses"] = "hcp_trait_defeated_ramesses",
--     ["phar_hero_egy_set_seti"] = "hcp_trait_defeated_seti",
--     ["phar_hero_egy_setn_setnakhte"] = "hcp_trait_defeated_setnakhte",
--     ["phar_hero_egy_tau_tausret"] = "hcp_trait_defeated_tausret",
--     ["phar_hero_hit_hat_suppiluliuma"] = "hcp_trait_defeated_suppiluliuma",
--     ["phar_hero_hit_tarh_kurunta"] = "hcp_trait_defeated_kurunta",
--     ["phar_map_hero_ach_achilles"] = "hcp_trait_defeated_achilles",
--     ["phar_map_hero_ach_agamemnon"] = "hcp_trait_defeated_agamemnon",
--     ["phar_map_hero_ach_ajax"] = "hcp_trait_defeated_ajax",
--     ["phar_map_hero_ach_diomedes"] = "hcp_trait_defeated_diomedes",
--     ["phar_map_hero_ach_menelaus"] = "hcp_trait_defeated_menelaus",
--     ["phar_map_hero_ach_odysseus"] = "hcp_trait_defeated_odysseus",
--     ["phar_map_hero_ash_ninurta"] = "hcp_trait_defeated_ninurta",
--     ["phar_map_hero_bab_adad"] = "hcp_trait_defeated_adad",
--     ["phar_map_hero_egy_memnon"] = "hcp_trait_defeated_memnon",
--     ["phar_map_hero_thr_rhesus"] = "hcp_trait_defeated_rhesus",
--     ["phar_map_hero_tro_aeneas"] = "hcp_trait_defeated_aeneas",
--     ["phar_map_hero_tro_hector"] = "hcp_trait_defeated_hector",
--     ["phar_map_hero_tro_paris"] = "hcp_trait_defeated_paris",
--     ["phar_map_hero_tro_priam"] = "hcp_trait_defeated_priam",
--     ["phar_map_hero_tro_sarpedon"] = "hcp_trait_defeated_sarpedon",
--     ["phar_sea_hero_iol_iolaos"] = "hcp_trait_defeated_iolaos",
--     ["phar_sea_hero_wal_walwetes"] = "hcp_trait_defeated_walwetes"
-- }

local SELF_PERPETUATING_TRAITS = {
     "hcp_trait_mad",
     "hcp_trait_degenerate",
     "hcp_trait_sober",
     "hcp_trait_drink",
     "hcp_trait_girls",
     "hcp_trait_arse",
     "hcp_trait_gambler",
     "hcp_trait_feck",
     "hcp_trait_corrupt",
     "hcp_trait_blighted",
     "hcp_trait_cuckold",
     "hcp_trait_slothful",
     "hcp_trait_boring",
     "hcp_trait_trusting",
     "hcp_trait_paranoia",
     "hcp_trait_superstitious",
     "hcp_trait_prophetic",
     "hcp_trait_anger",
     -- "phar_main_trait_respectful",
     -- "phar_main_trait_irreverent",
     -- "hcp_trait_authoritarian",
     -- "hcp_trait_liberal",
     "hcp_trait_fertile",
     "hcp_trait_barren",
     "hcp_trait_blind",
}
-- Traits allowed to trigger for any character on any given turn
local RANDOM_TRAITS_LIST = {
     "hcp_trait_degenerate",
}

local CULTURES_TRAIT_LIST = {
     ["phar_main_clt_canaan"] = "canaan",
     ["phar_main_clt_hatti"] = "hatti",
     ["phar_main_clt_kemet"] = "egypt",
     ["phar_main_clt_sea_peoples"] = "sea_peoples",
     ["phar_map_clt_mesopotamian"] = "mesopotamian",
     ["troy_main_clt_danaans"] = "danaans",
     ["troy_main_clt_trojans"] = "trojans",
}

local CHARACTER_CREATED_TRAITS = {
     "phar_main_trait_ambitious",
     "phar_main_trait_barbaric",
     "phar_main_trait_blunt",
     "phar_main_trait_brave",
     "phar_main_trait_cautious",
     "phar_main_trait_confident",
     "phar_main_trait_content",
     "phar_main_trait_cooperative",
     "phar_main_trait_cowardly",
     "phar_main_trait_cruel",
     "phar_main_trait_cultured",
     "phar_main_trait_hesitant",
     "phar_main_trait_individualistic",
     "phar_main_trait_irreverent",
     "phar_main_trait_materialistic",
     "phar_main_trait_merciful",
     "phar_main_trait_reckless",
     "phar_main_trait_respectful",
     "phar_main_trait_spiritual",
     "phar_main_trait_underhanded",
     "hcp_trait_degenerate",
     "hcp_trait_scout",
     "hcp_trait_attacking_victory",
     "hcp_trait_attacking_defeat",
     "hcp_trait_defending_defeat",
     "hcp_trait_defending_victory",
     "hcp_trait_siege_victory",
     "hcp_trait_siege_defeat",
     "hcp_trait_siege_defense_victory",
     "hcp_trait_sober",
     "hcp_trait_drink",
     "hcp_trait_girls",
     "hcp_trait_arse",
     "hcp_trait_gambler",
     "hcp_trait_bloody",
     "hcp_trait_inbred",
     "hcp_trait_popular",
     "hcp_trait_unpopular",
     "hcp_trait_lucky",
     "hcp_trait_unlucky",
     "hcp_trait_farmer_good",
     "hcp_trait_farmer_bad",
     "hcp_trait_bereaved",
     "hcp_trait_mad",
     "hcp_trait_healthy",
     "hcp_trait_blighted",
     "hcp_trait_sea_legs",
     "hcp_trait_feck",
     "hcp_trait_survivor",
     "hcp_trait_admin_good",
     "hcp_trait_admin_bad",
     "hcp_trait_miner",
     "hcp_trait_military_admin_good",
     "hcp_trait_military_admin_bad",
     "hcp_trait_warmonger",
     "hcp_trait_pacifist",
     "hcp_trait_corrupt",
     "hcp_trait_noctophilia",
     "hcp_trait_noctophobia",
     "hcp_trait_slothful",
     "hcp_trait_energetic",
     "hcp_trait_charismatic",
     "hcp_trait_boring",
     "hcp_trait_trusting",
     "hcp_trait_paranoia",
     "hcp_trait_pragmatic",
     "hcp_trait_superstitious",
     "hcp_trait_anger",
     "hcp_trait_attractive",
     "hcp_trait_ugly",
     "hcp_trait_prophetic",
     "hcp_trait_authoritarian",
     "hcp_trait_liberal",
     "hcp_trait_fertile",
     "hcp_trait_barren",
     "hcp_trait_scarred",
     "hcp_trait_criminal",
     "hcp_trait_blind",
}

-- Traits allowed to trigger when character comes of age
local chance = 4 -- You can set this to any value you need

local COMING_OF_AGE_TRAITS = {
     ["phar_main_trait_ambitious"] = chance,
     ["phar_main_trait_barbaric"] = chance,
     ["phar_main_trait_blunt"] = chance,
     ["phar_main_trait_brave"] = chance,
     ["phar_main_trait_cautious"] = chance,
     ["phar_main_trait_confident"] = chance,
     ["phar_main_trait_content"] = chance,
     ["phar_main_trait_cooperative"] = chance,
     ["phar_main_trait_cowardly"] = chance,
     ["phar_main_trait_cruel"] = chance,
     ["phar_main_trait_cultured"] = chance,
     ["phar_main_trait_hesitant"] = chance,
     ["phar_main_trait_individualistic"] = chance,
     ["phar_main_trait_irreverent"] = chance,
     ["phar_main_trait_materialistic"] = chance,
     ["phar_main_trait_merciful"] = chance,
     ["phar_main_trait_reckless"] = chance,
     ["phar_main_trait_respectful"] = chance,
     ["phar_main_trait_spiritual"] = chance,
     ["phar_main_trait_underhanded"] = chance,
     ["hcp_trait_degenerate"] = chance,
     ["hcp_trait_scout"] = chance,
     ["hcp_trait_attacking_victory"] = chance,
     ["hcp_trait_attacking_defeat"] = chance,
     ["hcp_trait_defending_defeat"] = chance,
     ["hcp_trait_defending_victory"] = chance,
     ["hcp_trait_siege_victory"] = chance,
     ["hcp_trait_siege_defeat"] = chance,
     ["hcp_trait_siege_defense_victory"] = chance,
     ["hcp_trait_sober"] = chance,
     ["hcp_trait_drink"] = chance,
     ["hcp_trait_girls"] = chance,
     ["hcp_trait_arse"] = chance,
     ["hcp_trait_gambler"] = chance,
     ["hcp_trait_bloody"] = chance,
     ["hcp_trait_inbred"] = chance,
     ["hcp_trait_popular"] = chance,
     ["hcp_trait_unpopular"] = chance,
     ["hcp_trait_lucky"] = chance,
     ["hcp_trait_unlucky"] = chance,
     ["hcp_trait_farmer_good"] = chance,
     ["hcp_trait_farmer_bad"] = chance,
     ["hcp_trait_mad"] = chance,
     ["hcp_trait_healthy"] = chance,
     ["hcp_trait_blighted"] = chance,
     ["hcp_trait_sea_legs"] = chance,
     ["hcp_trait_feck"] = chance,
     ["hcp_trait_survivor"] = chance,
     ["hcp_trait_admin_good"] = chance,
     ["hcp_trait_admin_bad"] = chance,
     ["hcp_trait_miner"] = chance,
     ["hcp_trait_military_admin_good"] = chance,
     ["hcp_trait_military_admin_bad"] = chance,
     ["hcp_trait_warmonger"] = chance,
     ["hcp_trait_pacifist"] = chance,
     ["hcp_trait_corrupt"] = chance,
     ["hcp_trait_noctophilia"] = chance,
     ["hcp_trait_noctophobia"] = chance,
     ["hcp_trait_slothful"] = chance,
     ["hcp_trait_energetic"] = chance,
     ["hcp_trait_charismatic"] = chance,
     ["hcp_trait_boring"] = chance,
     ["hcp_trait_trusting"] = chance,
     ["hcp_trait_paranoia"] = chance,
     ["hcp_trait_pragmatic"] = chance,
     ["hcp_trait_superstitious"] = chance,
     ["hcp_trait_anger"] = chance,
     ["hcp_trait_attractive"] = chance,
     ["hcp_trait_ugly"] = chance,
     ["hcp_trait_prophetic"] = chance,
     ["hcp_trait_authoritarian"] = chance,
     ["hcp_trait_liberal"] = chance,
     ["hcp_trait_fertile"] = chance,
     ["hcp_trait_barren"] = chance,
     ["hcp_trait_scarred"] = chance,
     ["hcp_trait_criminal"] = chance,
     ["hcp_trait_blind"] = chance,
     ["hcp_trait_wins_against_canaan"] = 0,
     ["hcp_trait_wins_against_danaans"] = 0,
     ["hcp_trait_wins_against_egypt"] = 0,
     ["hcp_trait_wins_against_hatti"] = 0,
     ["hcp_trait_wins_against_mesopotamian"] = 0,
     ["hcp_trait_wins_against_sea_peoples"] = 0,
     ["hcp_trait_wins_against_trojans"] = 0,
     ["hcp_trait_defeats_against_canaan"] = 0,
     ["hcp_trait_defeats_against_danaans"] = 0,
     ["hcp_trait_defeats_against_egypt"] = 0,
     ["hcp_trait_defeats_against_hatti"] = 0,
     ["hcp_trait_defeats_against_mesopotamian"] = 0,
     ["hcp_trait_defeats_against_sea_peoples"] = 0,
     ["hcp_trait_defeats_against_trojans"] = 0
}

-- Define the list of food-related building superchains
local FOOD_SUPERCHAINS_SET = {
     ["phar_main_farm_type_a_hattusa_derivative"] = true,
     ["phar_main_farm_type_a_canaan"] = true,
     ["phar_main_farm_type_a_canaan_derivative"] = true,
     ["phar_main_farm_type_a_hattusa"] = true,
     ["phar_main_farm_type_a_nile"] = true,
     ["phar_main_farm_type_b_nile"] = true,
     ["phar_main_farm_type_c_nile"] = true,
     ["phar_main_irsu_resource_production_food_farm"] = true,
     ["phar_main_irsu_resource_production_food_farm_derivative"] = true,
     ["phar_main_irsu_resource_production_food_farm_nile_type_a"] = true,
     ["phar_main_irsu_resource_production_food_farm_nile_type_b"] = true,
     ["phar_main_irsu_resource_production_food_farm_nile_type_c"] = true,
     ["phar_map_all_resource_production_food_farm_type_a_mesopotamia"] = true,
     ["phar_map_all_resource_production_food_farm_type_a_mesopotamia_derivative"] = true,
     ["phar_map_all_resource_production_food_farm_type_b_mesopotamia"] = true,
     ["phar_map_all_resource_production_food_farm_type_b_mesopotamia_derivative"] = true,
     ["phar_map_farm_achaea_derivative"] = true,
     ["phar_map_farm_assuwa_derivative"] = true,
     ["phar_map_farm_thrace_derivative"] = true,
     ["phar_map_food_farm_aegean"] = true,
     ["phar_map_myc_resource_production_food_farm_minor"] = true,
     ["troy_main_ody_settlements_farm_myth_harpies"] = true,
     ["troy_main_ody_settlement_farm_myth_giants"] = true,
     ["troy_main_ody_settlement_farm_myth_sirens"] = true,
     ["troy_main_farm_bull"] = true,
     ["troy_main_settlement_farm"] = true,
     ["troy_main_settlement_farm_sea"] = true,
     ["phar_main_food_cattle_canaan"] = true,
     ["phar_main_food_cattle_hattusa"] = true,
     ["phar_main_irsu_resource_production_food_cattle"] = true,
     ["phar_map_all_resource_production_food_cattle_mesopotamia"] = true,
     ["phar_map_food_cattle_aegean"] = true,
}

local MINE_SUPERCHAINS_SET = {
     ["phar_main_all_resource_production_bronze_mine_nile"] = true,
     ["phar_main_all_resource_production_gold_mine_nile"] = true,
     ["phar_main_all_resource_production_stone_mine_nile"] = true,
     ["phar_main_amenmesse_resource_production_gold_mine"] = true,
     ["phar_main_bronze_mine"] = true,
     ["phar_main_bronze_mine_derivative_type_a"] = true,
     ["phar_main_bronze_mine_type_b"] = true,
     ["phar_main_gold_mine"] = true,
     ["phar_main_gold_mine_derivative_type_b"] = true,
     ["phar_main_irsu_resource_production_gold_mine"] = true,
     ["phar_main_irsu_resource_production_gold_mine_derivative_type_b"] = true,
     ["phar_main_irsu_resource_production_stone_mine"] = true,
     ["phar_main_irsu_resource_production_stone_mine_derivative_type_a"] = true,
     ["phar_main_stone_mine"] = true,
     ["phar_main_stone_mine_derivative_type_a"] = true,
     ["phar_main_stone_mine_derivative_type_b"] = true,
     ["phar_map_myc_resource_production_gold_mine_minor"] = true,
     ["phar_map_myc_resource_production_stone_mine_minor"] = true
}

local GOLD_SUPERCHAINS_SET = {
     ["phar_main_all_resource_production_gold_mine_nile"] = true,
     ["phar_main_amenmesse_resource_production_gold_mine"] = true,
     ["phar_main_gold_mine"] = true,
     ["phar_main_gold_mine_derivative_type_b"] = true,
     ["phar_main_irsu_resource_production_gold_mine"] = true,
     ["phar_main_irsu_resource_production_gold_mine_derivative_type_b"] = true,
     ["phar_map_myc_resource_production_gold_mine_minor"] = true
}


local MILITARY_ADMIN_BUILDINGS_SET = {
     ["phar_main_all_military_administration_cost_mod"] = true,
     ["phar_main_military_administration_unit_training_type_a"] = true,
     ["phar_main_military_administration_unit_training_type_b"] = true,
     ["phar_main_kuru_military_administration_army_debuff"] = true,
     ["phar_main_kuru_military_administration_unit_training_type_a"] = true,
     ["phar_main_kuru_military_administration_unit_training_type_b"] = true,
     ["phar_main_ram_military_administration_hero_training"] = true,
     ["phar_main_seti_military_administration_cost_mod_recruit_slot_type_a"] = true,
     ["phar_main_seti_military_administration_cost_mod_recruit_slot_type_b"] = true,
     ["phar_main_suppi_military_administration_army_buff"] = true,
     ["phar_main_suppi_military_administration_garrison_type_a"] = true,
     ["phar_main_suppi_military_administration_garrison_type_b"] = true,
     ["phar_main_military_garrison_type_b"] = true,
     ["phar_main_all_military_administration_hero_training"] = true,
     ["phar_map_military_administration_unit_training_type_b_wilusa_province"] = true,
     ["phar_sea_administration_commandment_modifier"] = true,
     ["phar_sea_administration_factionwide_production"] = true,
     ["phar_sea_administration_happiness_influence"] = true,
     ["phar_sea_military_administration_hero_training_unit_cost_mod_native_settled"] = true,
     ["phar_sea_military_administration_unit_training_settled_native"] = true,
     ["phar_sea_peleset_military_administration_weapon_damage_armour"] = true,
     ["phar_sea_sherden_military_administration_charge_melee_attack_native"] = true
}

local DRINK_BUILDING_SET = {
     ["phar_main_happiness_type_b"] = true,
     ["phar_map_bab_province_management_happiness_growth_type_a"] = true,
}

local MANAGEMENT_BUILDING_SUPERCHAINS_SET = {
     ["phar_main_all_province_management_influence_type_b"] = true,
     ["phar_main_amenmesse_province_management_main_building_production_boost_growth"] = true,
     ["phar_main_bay_province_management_happiness"] = true,
     ["phar_main_bay_province_management_main_building_diplomatic_relations"] = true,
     ["phar_main_bay_province_management_production_boost_overall"] = true,
     ["phar_main_irsu_province_management_main_building_loot_boost"] = true,
     ["phar_main_irsu_province_management_main_building_production_boost"] = true,
     ["phar_main_irsu_province_management_production_boost"] = true,
     ["phar_main_ram_province_management_influence_happiness"] = true,
     ["phar_main_ram_province_management_production_boost_happiness"] = true,
     ["phar_main_seti_province_management_main_building_legitimacy_influence_boost"] = true,
     ["phar_main_seti_province_management_main_building_production_boost_overall"] = true,
     ["phar_main_suppi_province_management_growth"] = true,
     ["phar_map_all_province_management_main_building_minor_halt"] = true,
     ["phar_map_bab_province_management_gold_diplomacy"] = true,
     ["phar_map_bab_province_management_happiness_growth_type_a"] = true,
     ["phar_map_bab_province_management_happiness_influence_type_b"] = true,
     ["phar_map_bab_province_management_influence_roads_type_a"] = true,
     ["phar_map_bab_province_management_main_building_poc_production_influence"] = true,
     ["phar_map_bab_province_management_main_building_production_influence"] = true,
     ["phar_map_bab_province_management_workforce_build_time"] = true,
     ["phar_sea_peleset_province_management_influence_xp_per_turn_native_settled"] = true,
     ["phar_sea_peleset_province_management_movement_production_boost"] = true,
     ["phar_sea_sherden_province_management_growth_production_adjacent"] = true,
     ["phar_main_all_landmark_production_boost_emar"] = true,
     ["phar_main_all_landmark_production_boost_tarsus"] = true,
     ["phar_main_all_landmark_production_boost_thebes"] = true,
     ["phar_main_all_landmark_legitimacy_influence_megiddo"] = true,
     ["phar_main_all_landmark_legitimacy_influence_amarna"] = true,
     ["phar_main_major_main_building_poc_production_boost_overall"] = true,
     ["phar_main_major_main_building_production_boost_overall"] = true,
     ["phar_main_major_main_building_legitimacy_influence_boost"] = true,
     ["phar_main_major_poc_main_building_legitimacy_influence_boost"] = true,
     ["phar_map_major_poc_main_building_happiness_boost"] = true,
     ["phar_map_wil_major_main_building_happiness_boost"] = true
}


--------------------------------------------------
---- BEGIN MODIFYING PHAR_CAMPAIGN_TRAITS.LUA ----
--------------------------------------------------

--Ensures script runs after the vanilla script has executed. Modifying the max_num_traits from phar_campaign_traits.lua. The goal is to ultimately eliminate the need to directly edit the vanilla script.
cm:add_first_tick_callback(function()
     -- Check if the config table exists to avoid any potential errors
     if campaign_traits and campaign_traits.config then
          campaign_traits.config.max_num_traits = 50
          out("HCP_max_num_traits has been set to " .. campaign_traits.config.max_num_traits)
     else
          out("HCP_Mod: Failed to find campaign_traits.config")
     end

     --Injects my custom traits into the vanilla civilian_traits table so I don't need to worry about giving traits to them.
     if campaign_traits and campaign_traits.config.civilian_traits then
          for i = 1, #RANDOM_TRAITS_LIST do
               table.insert(campaign_traits.config.civilian_traits, RANDOM_TRAITS_LIST[i])
          end
     end

     --Making changes to the vanilla traits and their triggers. For now, many are left alone, but others are given new listeners and triggers. This may eventually change.
     if campaign_traits and campaign_traits.config.traits_per_events then
          campaign_traits.config.traits_per_events = {
               --character_recruited_1h_melee_unit_spears = {
               --[1] = {trait = "phar_main_trait_cautious", points = 2},
               --},
               -- character_bodyguard_suffered_casualties_low = {
               --     [1] = { trait = "phar_main_trait_cautious", points = 4 },
               --     -- [2] = {trait = "phar_main_trait_brave", points = 2},
               -- },
               -- character_sacks_or_razes_ers_shrine = {
               --     [1] = { trait = "phar_main_trait_underhanded", points = 2 },
               --     [2] = { trait = "phar_main_trait_barbaric", points = 2 },
               --     [3] = { trait = "phar_main_trait_irreverent", points = 2 },
               -- },

               -- character_spent_turns_in_encamp_stance = {
               --     [1] = { trait = "phar_main_trait_content", points = 2 },
               -- },
               -- character_suffered_attrition = {
               --     [1] = { trait = "phar_main_trait_ambitious", points = 2 },
               -- },

               -- character_interacted_with_non_shrine_ers = {
               --     [1] = { trait = "phar_main_trait_materialistic", points = 2 },
               -- },
               -- character_ends_turn_in_region_with_construction_shrine_building = {
               --     [1] = { trait = "phar_main_trait_spiritual", points = 1 },
               -- },
               -- character_prayed_at_ers = {
               --     [1] = { trait = "phar_main_trait_spiritual", points = 2 },
               -- },

               -- character_fought_alone = {
               --     [1] = { trait = "phar_main_trait_individualistic", points = 4 },
               -- },

               -- character_bodyguard_suffered_casualties_high = {
               --     [1] = { trait = "phar_main_trait_reckless", points = 4 },

               -- },
               --character_recruited_2h_melee_unit_infantry = {
               --[1] = {trait = "phar_main_trait_reckless", points = 2},
               --},

               -- character_post_battle_release_generic = {
               --     [1] = { trait = "phar_main_trait_merciful", points = 4 },
               -- },

               -- character_sacked_settlement = {
               --     [1] = { trait = "phar_main_trait_barbaric", points = 5 },
               --     [2] = { trait = "phar_main_trait_irreverent", points = 4 },
               -- },

               -- character_being_lazy_in_owned_settlement_high_public_order = {
               --     [1] = { trait = "phar_main_trait_content", points = 1 },
               -- },

               -- character_being_lazy_in_owned_settlement_low_public_order = {
               --     [1] = { trait = "phar_main_trait_irreverent", points = 1 },
               -- },

               -- character_present_for_construction = {
               --     [1] = { trait = "phar_main_trait_cultured", points = 1 },
               -- },

               -- character_won_battle_cadmean_victory = {
               --     [1] = { trait = "phar_main_trait_blunt", points = 5 },
               -- },


               -- character_spent_turn_in_ambush_stance = {
               --     -- [1] = {trait = "phar_main_trait_cowardly", points = 2},
               --     [1] = { trait = "phar_main_trait_underhanded", points = 2 },
               -- },

               -- character_spent_turns_in_march_stance = {
               --     [1] = { trait = "phar_main_trait_ambitious", points = 2 },
               -- },

               -- character_razed_settlement = {
               --     [1] = { trait = "phar_main_trait_barbaric", points = 10 },
               --     [2] = { trait = "phar_main_trait_irreverent", points = 4 },
               -- },

               -- character_executed_captives = {
               --     [1] = { trait = "phar_main_trait_cruel", points = 4 },
               -- },

               -- character_fought_battle_far_from_capital = {
               --     [1] = { trait = "phar_main_trait_individualistic", points = 2 },
               -- },

               -- character_reinforces_other_armies = {
               --     [1] = { trait = "phar_main_trait_cooperative", points = 4 },
               -- },
               -- character_beeing_reinforced = {
               --     [1] = { trait = "phar_main_trait_cooperative", points = 4 },
               -- },

               -- character_spent_turn_in_enemy_region = {
               --     [1] = { trait = "phar_main_trait_confident", points = 2 },
               -- },

               -- character_spent_turns_in_raiding_stance = {
               --     [1] = { trait = "phar_main_trait_blunt", points = 2 },
               -- },

               -- character_won_defensive_battle = {
               --     [1] = { trait = "phar_main_trait_hesitant", points = 2 },
               -- },

               character_did_not_fight_battles = {
                [1] = {trait = "phar_main_trait_hesitant", points = 2},
            },
               --character_recruited_khopeshi={
               --[1] = {trait = "phar_main_trait_brave", points = 2},
               --},

               --character_recruited_swordmen = {
               --[1] = {trait = "phar_main_trait_brave", points = 2},
               --},


               character_won_battle = {
                    [1] = { trait = "phar_main_trait_amenmesse", points = 0 },
                    [2] = { trait = "phar_main_trait_ramesses", points = 0 },
                    [3] = { trait = "phar_main_trait_tausret", points = 0 },
                    [4] = { trait = "phar_main_trait_bay", points = 0 },
                    [5] = { trait = "phar_main_trait_kurunta", points = 0 },
                    [6] = { trait = "phar_main_trait_irsu", points = 0 },
                    [7] = { trait = "phar_main_trait_suppiluliuma", points = 0 },
                    [8] = { trait = "phar_main_trait_seti", points = 0 },
                    [9] = { trait = "phar_sea_trait_iolas", points = 0 },
                    [10] = { trait = "phar_sea_trait_walwetes", points = 0 },
               },

               character_won_battle_sea = {
                    [1] = { trait = "phar_sea_special_sea_wolf", points = 2 },
               },
               character_sacks_or_razes_port_settlement = {
                    [1] = { trait = "phar_sea_special_colonizer", points = 2 },
                    [2] = { trait = "phar_sea_special_coastal_predator", points = 2 },

               },
               character_won_battle_sea_region_ports = {
                    [1] = { trait = "phar_sea_special_coastal_ambusher", points = 2 },
               },



               character_battle_completed_lost_siege_battle = {
                [1] = {trait = "phar_main_trait_respectful", points = 2},
                [1] = {trait = "phar_main_trait_hesitant", points = 2},
            },

            character_ends_turn_in_region_with_construction_primary_slot = {
                [1] = {trait = "phar_main_trait_respectful", points = 2},
                [3] = {trait = "phar_main_trait_cultured", points = 2},
            },

            character_ends_turn_in_region_with_construction_economy_building = {
                [1] = {trait = "phar_main_trait_materialistic", points = 2},
                [2] = {trait = "phar_main_trait_amenmesse", points = 0},
            },

            character_ends_turn_in_region_with_construction_military_building = {
                [1] = {trait = "phar_main_trait_cautious", points = 2},
                [2] = {trait = "phar_main_trait_ambitious", points = 2},
            },



            character_suffered_high_casualties_in_battle = {
                [1] = {trait = "phar_main_trait_ambitious", points = 2},
                [2] = {trait = "phar_main_trait_reckless", points = 2},
                [3] = {trait = "phar_main_trait_irreverent", points = 2},
            },

                character_routed_in_battle = {
                    [3] = {trait = "phar_main_trait_cowardly", points = 2},
                },

               character_won_battle_decisive_victory = {
                [1] = {trait = "phar_main_trait_brave", points = 2},
                [2] = {trait = "phar_main_trait_confident", points = 2},
                [3] = {trait = "phar_main_trait_ramesses", points = 0},
            },

                character_post_battle_enslave_generic = {
                    [1] = { trait = "phar_main_trait_materialistic", points = 4 },
                },


          }
     end

     --Removes the original listener(s) and then re-adds some so I can play with them without direct edits to phar_campaign_traits.
     core:remove_listener("phar_personality_traits_character_recruited_2h_melee_unit_infantry")                      --reckless
     core:remove_listener("phar_personality_traits_character_recruited_1h_melee_unit_spears")                        --cautious
     core:remove_listener("phar_personality_traits_character_recruited_khopeshi")                                    --brave
     core:remove_listener("phar_personality_traits_character_recruited_swordmen")                                    --brave
     core:remove_listener("phar_personality_traits_character_spent_turn_in_enemy_region")                            --confident
     core:remove_listener("phar_personality_traits_character_won_defensive_battle")                                  --hesitant
     core:remove_listener("phar_personality_traits_character_being_lazy_in_owned_settlement_high_public_order")      --respectful
     core:remove_listener("phar_personality_traits_character_being_lazy_in_owned_settlement_low_public_order")       --irreverent
     core:remove_listener("phar_personality_traits_character_suffered_high_casualties_in_battle")                    --unused in vanilla
     core:remove_listener("phar_personality_traits_character_routed_in_battle")                                      --unused in vanilla
     core:remove_listener("phar_personality_traits_character_post_battle_release_generic")                           --merciful
     core:remove_listener("phar_personality_traits_character_post_battle_enslave_generic")                           --unused in vanilla
     core:remove_listener("phar_personality_traits_character_executed_captives")                                     --cruel
     core:remove_listener("phar_personality_traits_character_bodyguard_suffered_casualties")                         --reckless and cautious
     core:remove_listener("phar_personality_traits_character_prayed_at_ers")                                         --spiritual
     core:remove_listener("phar_personality_traits_character_interacted_with_non_shrine_ers")                        --materialistic
     core:remove_listener("phar_personality_traits_character_spent_turns_in_raiding_stance")                         --blunt
     core:remove_listener("phar_personality_traits_character_spent_turn_in_ambush_stance")                           --underhanded
     core:remove_listener("phar_personality_traits_character_spent_turns_in_march_stance")                           --ambitious
     core:remove_listener("phar_personality_traits_character_spent_turn_recruiting")                                 --unused in vanilla
     core:remove_listener("phar_personality_traits_character_spent_turns_in_encamp_stance")                          --content
     core:remove_listener("phar_personality_traits_character_sacked_settlement")                                     --barbaric
     core:remove_listener("phar_personality_traits_character_razed_settlement")                                      --barbaric
     core:remove_listener("phar_personality_traits_character_ends_turn_in_region_with_construction_shrine_building") --spiritual
     core:remove_listener("phar_personality_traits_character_present_for_construction")                              --cultured
     core:remove_listener("phar_personality_traits_character_fought_alone")                                          --individualistic
     core:remove_listener("phar_personality_traits_character_reinforces_other_armies")                               --cooperative
     core:remove_listener("phar_personality_traits_character_beeing_reinforced")                                     --cooperative
     core:remove_listener("phar_personality_traits_character_fought_battle_far_from_capital")                        --individualistic
     core:remove_listener("phar_personality_traits_character_sacks_or_razes_ers_shrine")                             --barbaric and underhanded
     core:remove_listener("phar_personality_traits_character_suffered_attrition")                                    --ambitious
end
)
------------------------------------------------
---- END MODIFYING PHAR_CAMPAIGN_TRAITS.LUA ----
------------------------------------------------

-----------------------------
---- MAIN TRAIT FUNCTION ----
-----------------------------
function hcp_main_give_trait(character, trait, _points, _chance)
     local chance = _chance or 100
     local points = _points or 1
     local char_str = cm:char_lookup_str(character:command_queue_index())
     local show_message = false

     if character == nil then
          out("HCP_TRAIT ERROR: Tried to give trait to a character that was not specified!")
          return false
     end

     if character:is_null_interface() then
          out("HCP_TRAIT ERROR: Tried to give trait to a character that was a null interface!")
          return false
     end

     if character:character_type("colonel") then
          out("HCP_TRAIT ERROR: Tried to give trait to a character who is a colonel!")
          return false
     end

     if not cm:model():random_percent(chance) then
          return false
     end

     if cm:char_is_general_with_army(character) then
          show_message = true
     end

     ---@diagnostic disable-next-line: redundant-parameter
     cm:force_add_trait(char_str, trait, show_message, points)
     out("HCP_MAIN_TRAIT_FUNCTION_APPLYING_" .. tostring(trait) .. "_to_" .. character:onscreen_name())

     return true
end

--------------------------------------------------
---- AKHENATEN ANCIENT LEGACY TRAIT (HERETIC) ----
--------------------------------------------------
---checks for akhenaten ancient legacy and applies heretic trait if found.
local is_legacy_claimed = 0

function hcp_new_character_traits()
     if is_legacy_claimed == 0 then
          local all_legacies = {
               "phar_ancient_legacy_khufu",
               "phar_ancient_legacy_akhenaten",
               "phar_ancient_legacy_hatshepsut",
               "phar_ancient_legacy_thutmose",
               "phar_ancient_legacy_tudhaliya",
               "phar_ancient_legacy_muwatalli",
               "phar_ancient_legacy_perseus",
               "phar_ancient_legacy_atreus",
               "phar_ancient_legacy_hammurabi",
               "phar_ancient_legacy_sargon"
          }
          local human_factions = cm:get_human_factions()

          for i = 1, #human_factions do
               local faction_name = human_factions[i]
               out("HCP_ANCIENT_LEGACY_LISTENER_ADDED_FOR_" .. faction_name)

               cm:add_faction_turn_start_listener_by_name(
                    "hcp_ancient_legacy_listener",
                    faction_name,
                    function(context)
                         local faction = context:faction()

                         -- Apply Heretic trait if Akhenaten legacy is claimed
                         if ancient_legacy_common:faction_has_claimed_legacy(faction:name(), "phar_ancient_legacy_akhenaten") then
                              out("HCP_ANCIENT_LEGACY_AKHENATEN_CLAIMED")

                              hcp_main_give_trait(faction:faction_leader(), "hcp_trait_heretic", 20)

                              --add Heretic to the list of self-perpetuating traits
                              SELF_PERPETUATING_TRAITS[#SELF_PERPETUATING_TRAITS + 1] = "hcp_trait_heretic"
                              cm:remove_faction_turn_start_listener_by_name("hcp_ancient_legacy_listener")

                              is_legacy_claimed = 1
                              return
                         end

                         -- Check if any legacy is claimed, and remove the listener
                         for j = 1, #all_legacies do
                              if ancient_legacy_common:faction_has_claimed_legacy(faction:name(), all_legacies[j]) then
                                   out("HCP_ANCIENT_LEGACY_CLAIMED_FOR_" .. faction_name .. "_REMOVING_LISTENER")
                                   cm:remove_faction_turn_start_listener_by_name("hcp_ancient_legacy_listener")
                                   is_legacy_claimed = 1
                                   return
                              end
                         end
                         out("HCP_ANCIENT_NO_LEGACY_CLAIMED_THIS_TURN")
                    end,
                    true
               )
          end
     else
          out("HCP_ANCIENT_LEGACY_CLAIMED_IS_" .. is_legacy_claimed)
     end
end

--Gives heretic to new faction leaders.
core:add_listener(
     "hcp_apply_heretic_to_new_faction_leader",
     "CharacterBecomesFactionLeader",
     function(context)
          context:character():faction():is_human()
          return true
     end,
     function(context)
          local character = context:character()

          if ancient_legacy_common:faction_has_claimed_legacy(character:faction():name(), "phar_ancient_legacy_akhenaten") then
               -- local random_index = math.random(3)

               -- out("HCP_RANDOM_NUMBER_IS_" .. random_index)
               hcp_main_give_trait(character, "hcp_trait_heretic", 20)
          end
     end,
     true
)

-----------------------------------------------
---- FACTION LEADER DECLARES WAR AND PEACE ----
-----------------------------------------------
---NOTE TO SELF: for whatever reason, you cannot call proposer():faction_leader() or recipient():faction_leader() or character():name(). So don't bother trying.
core:add_listener(
     "hcp_faction_leader_declares_war",
     "NegativeDiplomaticEvent",
     true,
     function(context)
          if context:is_war() == true then
               out("HCP_WAR_DECLARATION Event Triggered")

               local proposer = context:proposer();
               local recipient = context:recipient();
               local character = context:character()

               if character:faction():name() == proposer:name() then
                    out("HCP_WAR_DECLARED! AGGRESSOR FACTION IS " .. tostring(character:faction():name()))
                    hcp_main_give_trait(character, "hcp_trait_warmonger", 20, 20)
               end
          end
     end,
     true
)


core:add_listener(
     "hcp_faction_leader_signs_peace_treaty",
     "PositiveDiplomaticEvent",
     true,
     function(context)
          if context:is_peace_treaty() == true then
               out("HCP_PEACE_DECLARATION_EVENT")

               local proposer = context:proposer();
               local recipient = context:recipient();
               local character = context:character()

               if character:faction():name() == proposer:name() then
                    out("HCP_PEACE_TREATY_SIGNED! PROPOSER FACTION IS " .. tostring(character:faction():name()))
                    hcp_main_give_trait(character, "hcp_trait_pacifist", 20, 20)
               elseif character:faction():name() == recipient:name() then
                    out("HCP_PEACE_TREATY_SIGNED! RECIPIENT FACTION IS " .. tostring(character:faction():name()))
                    hcp_main_give_trait(character, "hcp_trait_pacifist", 20, 20)
               end
          end
     end,
     true
)


------------------------------
---- DIRECT RELATIVE DIED ----
------------------------------
core:add_listener(
     "hcp_character_relative_killed",
     "FactionCharacterDiedOrWounded",
     function(context) return context:faction():is_human() end,
     function(context)
          local family_member = context:family_member()

          if not family_member or family_member:is_null_interface() then
               out("hcp_character_family_member_died_no_valid_family_member")
               return
          end

          local dead_family_member = family_member:character():command_queue_index()
          out("hcp_character_family_member_died " .. dead_family_member)

          if family_member:is_in_faction_leaders_family() then
               out("hcp_character_family_member_died_is_in_faction_leader_family")

               if family_member:has_father() then
                    local father = family_member:father():character()
                    if not father:is_null_interface() then
                         out("hcp_character_family_member_died_has_father_" .. father:command_queue_index())
                         hcp_main_give_trait(father, "hcp_trait_bereaved", 20, 10)
                    end
               end

               if family_member:has_mother() then
                    local mother = family_member:mother():character()
                    if not mother:is_null_interface() then
                         out("hcp_character_family_member_died_has_mother_" .. mother:command_queue_index())
                         hcp_main_give_trait(mother, "hcp_trait_bereaved", 20, 10)
                    end
               end

               if family_member:has_spouse() then
                    local spouse = family_member:spouse():character()
                    if not spouse:is_null_interface() then
                         out("hcp_character_family_member_died_has_spouse_" .. spouse:command_queue_index())
                         hcp_main_give_trait(spouse, "hcp_trait_bereaved", 20, 10)
                    end
               end

               for i = 0, family_member:all_children_in_marriage():num_items() - 1 do
                    local child = family_member:all_children_in_marriage():item_at(i):character()

                    if not child:is_null_interface() and child:age() >= 16 then
                         out("hcp_character_family_member_died_has_adult_child_" .. child:command_queue_index())
                         hcp_main_give_trait(child, "hcp_trait_bereaved", 20, 10)
                    end
               end
          end
     end,
     true
)


----------------------
---- RAZED SHRINE ----
----------------------
core:add_listener(
     "hcp_character_razed_shrine",
     "CharacterPerformsRegionSlotOccupationDecisionBeforeOutcomeApplication",
     true,
     function(context)
          if context:region_slot():building():is_null_interface() then
               out("HCP_character_razed_shrine_is_null_interface!")
               return
          end

          if (context:occupation_decision_option() == "occupation_decision_ers_raze_without_occupy" or context:occupation_decision_option() == "occupation_decision_ers_sack")
              and campaign_traits.check_if_region_slot_has_shrine(context:region_slot():building():chain()) then
               hcp_main_give_trait(context:character(), "phar_main_trait_barbaric", 20, 25)
               hcp_main_give_trait(context:character(), "phar_main_trait_underhanded", 20, 25)
               out("hcp_character_razed_shrine")
          end
     end,
     true
)


------------------------------------------
-- POST BATTLE RANSOM/ENSLAVE/EXECUTE ----
------------------------------------------
core:add_listener(
     "hcp_character_post_battle_release_generic",
     "CharacterPostBattleRelease",
     true,
     function(context)
          hcp_main_give_trait(context:character(), "phar_main_trait_merciful", 20, 20)
          out("HCP_post_battle_release")
     end,
     true
)

core:add_listener(
     "hcp_character_post_battle_enslave_generic",
     "CharacterPostBattleEnslave",
     true,
     function(context)
          hcp_main_give_trait(context:character(), "phar_main_trait_materialistic", 20, 20)
          out("HCP_post_battle_enslave")
     end,
     true
)

core:add_listener(
     "hcp_character_executed_captives",
     "CharacterPostBattleSlaughter",
     true,
     function(context)
          if context:character():in_settlement() then
               out("HCP_post_battle_slaughter_character_in_settlement")
               return
          else
               hcp_main_give_trait(context:character(), "phar_main_trait_cruel", 20, 25)
               out("HCP_post_battle_slaughter")
          end
     end,
     true
)


-----------------------------
---- CAPTURED SETTLEMENT ----
-----------------------------
core:add_listener(
     "hcp_character_looted_settlement",
     "CharacterLootedSettlement",
     true,
     function(context)
          if cm:char_is_general_with_army(context:character()) then
               hcp_main_give_trait(context:character(), "phar_main_trait_materialistic", 20, 35);
               hcp_main_give_trait(context:character(), "hcp_trait_authoritarian", 20, 35);
               out("hcp_character_looted_settlement")
          end
     end,
     true
)

core:add_listener(
     "hcp_character_sacked_settlement",
     "CharacterSackedSettlement",
     true,
     function(context)
          if cm:char_is_general_with_army(context:character()) then
               hcp_main_give_trait(context:character(), "phar_main_trait_barbaric", 20, 35);
               out("hcp_character_sacked_settlement")
          end
     end,
     true
)

core:add_listener(
     "hcp_character_razed_settlement",
     "CharacterRazedSettlement",
     true,
     function(context)
          if cm:char_is_general_with_army(context:character()) then
               hcp_main_give_trait(context:character(), "phar_main_trait_barbaric", 20, 50);
               hcp_main_give_trait(context:character(), "hcp_trait_authoritarian", 20, 3);
               out("hcp_character_razed_settlement")
          end
     end,
     true
)

core:add_listener(
     "hcp_character_occupied_settlement",
     "CharacterPerformsSettlementOccupationDecision",
     true,
     function(context)
          local post_battle_option = context:occupation_decision_option()

          if post_battle_option == "occupation_decision_occupy" then
               hcp_main_give_trait(context:character(), "hcp_trait_liberal", 20, 20);
               out("hcp_character_occupied_settlement")
          end
     end,
     true
)


----------------------------------------
---- PRAYED AT SHRINE OR NON-SHRINE ----
----------------------------------------
core:add_listener(
     "hcp_character_prayed_at_shrine",
     "CharacterPerformedSuccessfulAgentAction",
     true,
     function(context)
          local unique_id = context:unique_id()

          if string.find(unique_id, "phar_ers_interaction_shrine_pray") then
               hcp_main_give_trait(context:character(), "phar_main_trait_spiritual", 20, 15)
               out("hcp prayed at shrine")
          elseif string.find(unique_id, "phar_ers_interaction") then
               hcp_main_give_trait(context:character(), "phar_main_trait_materialistic", 20, 15)
               out("hcp prayed at non-shrine")
          end
     end,
     true
)


---------------------------------------------------
---- RANDOM TRAITS WHEN CHARACTER COMES OF AGE ----
---------------------------------------------------
core:add_listener(
     "hcp_character_comes_of_age",
     "CharacterComesOfAge",
     true,
     function(context)
          local character = context:character()
          local father = character:has_father() and character:father() or nil
          local mother = character:has_mother() and character:mother() or nil

          if father then
               out("hcp_character_comes_of_age_FATHER_IS_" .. tostring(father))
          else
               out("hcp_character_comes_of_age_NO_FATHER_FOUND!")
          end

          if mother then
               out("hcp_character_comes_of_age_MOTHER_IS_" .. tostring(mother))
          else
               out("hcp_character_comes_of_age_NO_MOTHER_FOUND!")
          end

          -- Create a temporary table to hold the adjusted chances for this specific character
          local temp_trait_chances = {}

          -- Initialize the temporary table with the default trait chances
          for trait, base_chance in pairs(COMING_OF_AGE_TRAITS) do
               temp_trait_chances[trait] = base_chance
          end

          -- Adjust trait chances based on parent's traits
          for trait, base_chance in pairs(COMING_OF_AGE_TRAITS) do
               if father and father:has_trait(trait) then
                    temp_trait_chances[trait] = 40
                    out("hcp_character_comes_of_age_FATHER_HAS_TRAIT_" ..
                         trait .. "_INCREASED_CHANCE_TO_" .. tostring(40))
               end
               if mother and mother:has_trait(trait) then
                    temp_trait_chances[trait] = 40
                    out("hcp_character_comes_of_age_MOTHER_HAS_TRAIT_" ..
                         trait .. "_INCREASED_CHANCE_TO_" .. tostring(40))
               end
          end

          -- Apply the traits with their respective chances for this character
          for trait, chance in pairs(temp_trait_chances) do
               hcp_main_give_trait(character, trait, 20, chance)
               out("hcp_character_comes_of_age_APPLIED_TRAIT_" .. trait .. "_WITH_CHANCE_" .. tostring(chance))
          end
     end,
     true
)


--------------------------------------------------
---- RANDOM TRAITS WHEN CHARACTER IS CREATED ----
--------------------------------------------------
core:add_listener(
     "hcp_character_created",
     "CharacterCreated",
     true,
     function(context)
          local character = context:character()
          out("hcp_character_created")

          if character:age() >= 16
              and cm:char_is_general_with_army(character)
              and not character:character_type("colonel") then
               for i = 1, #CHARACTER_CREATED_TRAITS do
                    hcp_main_give_trait(character, CHARACTER_CREATED_TRAITS[i], 20, 1)
                    out("hcp_character_created_IS_APPLYING_" .. tostring(CHARACTER_CREATED_TRAITS[i]))
               end
          end
     end,
     true
)


-----------------------------------------
---- MAIN CHARACTER COMPLETED BATTLE ----
-----------------------------------------
core:add_listener(
     "hcp_character_completed_battle_main",
     "CharacterCompletedBattle",
     true,
     function(context)
          out("HCP_CHARACTER_COMPLETED_BATTLE")
          local character = context:character()
          local battle = context:pending_battle()
          local attacker = battle:attacker()
          local defender = battle:defender()

          if attacker:is_null_interface() then
               out("HCP_attacker_is_null_interface!")
               return
          end

          if defender:is_null_interface() then
               out("HCP_defender_is_null_interface!")
               return
          end

          if character:character_type("colonel") then
               out("HCP_character_is_colonel!")
               return
          end

          -------------------------------
          ---- COWARDLY TRAIT ----
          -------------------------------
          if character:routed_in_battle() then
               hcp_main_give_trait(character, "phar_main_trait_cowardly", 20, 75)
               out("HCP_CHARACTER_COMPLETED_BATTLE_COWARD_ROUTED")
          end

          if character:fought_in_battle() == false then
               hcp_main_give_trait(character, "phar_main_trait_cowardly", 20, 5)
               out("HCP_CHARACTER_COMPLETED_BATTLE_COWARD_DID_NOT_FIGHT")
          end


          -------------------------
          ---- ENERGETIC TRAIT ----
          -------------------------
          if character:fought_in_battle() then
               hcp_main_give_trait(character, "hcp_trait_energetic", 20, 15)
               out("HCP_CHARACTER_COMPLETED_BATTLE_ENERGETIC")
          end


          -------------------------------
          ---- POPULAR/UNPOPULAR TRAIT ----
          -------------------------------
          if character:won_battle() then
               hcp_main_give_trait(character, "hcp_trait_popular", 20, 5)
               out("HCP_CHARACTER_COMPLETED_BATTLE_POPULAR")
          else
               hcp_main_give_trait(character, "hcp_trait_unpopular", 20, 5)
               out("HCP_CHARACTER_COMPLETED_BATTLE_UNPOPULAR")
          end


          ------------------------------
          ---- HIGH ARMY CASUALTIES ----
          ------------------------------
          local losses = character:percentage_of_own_alliance_killed()

          if losses >= 0.6 then
               hcp_main_give_trait(character, "hcp_trait_bloody", 20, 20)
               hcp_main_give_trait(character, "phar_main_trait_reckless", 20, 20)
               out("HCP_CHARACTER_COMPLETED_BATTLE_BLOODY")
          end


          ------------------------------
          ---- BODYGUARD CASUALTIES ----
          ------------------------------
          if not character:is_null_interface() and cm:char_is_general_with_army(character) then
               local unit_list = character:military_force():unit_list()
               for i = 0, unit_list:num_items() - 1 do
                    local unit = unit_list:item_at(i)
                    if unit:belongs_to_unit_set("phar_main_bodyguards") then
                         local casualties_percent = 100 - unit:percentage_proportion_of_full_strength()
                         local percent_loss_trigger_high = 30
                         local percent_loss_trigger_low = 30
                         if character:fought_in_battle() and casualties_percent > percent_loss_trigger_high then
                              hcp_main_give_trait(character, "phar_main_trait_brave", 20, 20)
                              hcp_main_give_trait(character, "hcp_trait_scarred", 20, 30)
                              out("HCP_high_bodyguard_casualties_applying_brave_and_scarred")
                         end
                         if casualties_percent < percent_loss_trigger_low then
                              hcp_main_give_trait(character, "phar_main_trait_cautious", 20, 5)
                              out("HCP_low_bodyguard_casualties")
                         end
                    end
               end
          end


          -------------------------------
          ---- BATTLES AGAINST CULTURES ----
          -------------------------------
          out("hcp_battle_fought_against_culture_FIRED")
          local battle = context:pending_battle()
          local character_faction = character:faction()
          local enemy_culture = ""

          -- Determine the culture of the enemy faction
          if character_faction:name() == battle:attacker():faction():name() then
               enemy_culture = battle:defender():faction():culture()
          else
               enemy_culture = battle:attacker():faction():culture()
          end

          out("HCP_ENEMY_CULTURE_IDENTIFIED_AS_" .. tostring(enemy_culture))

          -- Check if the cultures are different before applying the traits
          if enemy_culture ~= character_faction:culture() then
               if CULTURES_TRAIT_LIST[enemy_culture] ~= nil then
                    if character:won_battle() then
                         hcp_main_give_trait(character, "hcp_trait_wins_against_" .. CULTURES_TRAIT_LIST[enemy_culture],
                              20,
                              10)
                         out("HCP_BATTLE_WINS_AGAINST_" .. tostring(enemy_culture))
                    else
                         hcp_main_give_trait(character,
                              "hcp_trait_defeats_against_" .. CULTURES_TRAIT_LIST[enemy_culture], 20,
                              50)
                         out("HCP_BATTLE_DEFEATS_AGAINST_" .. tostring(enemy_culture))
                    end
               end
          else
               out("HCP_BATTLE_AGAINST_SAME_CULTURE_" .. tostring(enemy_culture) .. "_NO_TRAIT_APPLIED")
          end
     end,
     true
)


------------------------------
---- ATTACKING/DEFENDING ----
------------------------------
core:add_listener(
     "hcp_attacker_win_lose_traits",
     "BattleConflictFinished",
     true,
     function(context)
          local battle = context:pending_battle()
          local attacker = battle:attacker()
          local defender = battle:defender()

          out("HCP_BattleConflictFinished_triggered")

          if attacker:is_null_interface() then
               out("HCP_attacker_is_null_interface!")
               return
          end

          if defender:is_null_interface() then
               out("HCP_defender_is_null_interface!")
               return
          end

          if attacker:character_type("colonel") or defender:character_type("colonel") then
               out("HCP_character_is_colonel!")
               return
          end

          ------------------------------
          ---- SIEGE BATTLE ----
          ------------------------------
          if battle:siege_battle() then
               out("HCP_Siege_Battle_Detected")
               if attacker:won_battle() then
                    hcp_main_give_trait(attacker, "hcp_trait_siege_victory", 20, 20)
               else
                    hcp_main_give_trait(attacker, "hcp_trait_siege_defeat", 20, 50)
                    hcp_main_give_trait(defender, "hcp_trait_siege_defense_victory", 20, 50)
               end
               return
          end

          ------------------------------
          ---- AMBUSH BATTLE ----
          ------------------------------
          if battle:ambush_battle() then
               if attacker:won_battle() then
                    hcp_main_give_trait(attacker, "hcp_trait_lucky", 20, 20)
                    hcp_main_give_trait(attacker, "phar_main_trait_underhanded", 20, 20)
                    hcp_main_give_trait(defender, "hcp_trait_unlucky", 20, 20)
                    hcp_main_give_trait(defender, "hcp_trait_survivor", 20, 20)
                    hcp_main_give_trait(defender, "hcp_trait_military_admin_bad", 20, 10)
                    hcp_main_give_trait(defender, "hcp_trait_paranoia", 20, 5)
                    out("HCP_AMBUSH_BATTLE_DETECTED_ATTACKER_WON")
               else
                    hcp_main_give_trait(attacker, "hcp_trait_unlucky", 20, 50)
                    hcp_main_give_trait(defender, "hcp_trait_lucky", 20, 50)
                    hcp_main_give_trait(defender, "hcp_trait_survivor", 20, 20)
                    hcp_main_give_trait(defender, "hcp_trait_military_admin_bad", 20, 50)
                    hcp_main_give_trait(defender, "hcp_trait_paranoia", 20, 5)
                    out("HCP_AMBUSH_BATTLE_DETECTED_ATTACKER_LOST")
               end
          end

          ------------------------------
          ---- FAILED AMBUSH BATTLE ----
          ------------------------------
          if battle:failed_ambush_battle() then
               if attacker:won_battle() then
                    hcp_main_give_trait(attacker, "phar_main_trait_blunt", 20, 20)
                    hcp_main_give_trait(attacker, "hcp_trait_unlucky", 20, 20)
                    out("HCP_FAILED_AMBUSH_BATTLE_DETECTED_ATTACKER_WON")
               else
                    hcp_main_give_trait(attacker, "phar_main_trait_blunt", 20, 20)
                    hcp_main_give_trait(attacker, "hcp_trait_unlucky", 20, 20)
                    hcp_main_give_trait(defender, "hcp_trait_lucky", 20, 20)
                    out("HCP_FAILED_AMBUSH_BATTLE_DETECTED_ATTACKER_LOST")
               end
          end

          ------------------------------
          ---- GENERAL BATTLE OUTCOME ----
          ------------------------------
          if not battle:siege_battle() then
               if attacker:won_battle() then
                    hcp_main_give_trait(attacker, "hcp_trait_attacking_victory", 20, 17)
                    hcp_main_give_trait(defender, "hcp_trait_defending_defeat", 20, 50)
                    hcp_main_give_trait(defender, "hcp_trait_military_admin_bad", 20, 15)
                    out("hcp attacker won battle applying traits")
               else
                    hcp_main_give_trait(attacker, "hcp_trait_attacking_defeat", 20, 50)
                    hcp_main_give_trait(defender, "hcp_trait_defending_victory", 20, 25)
                    hcp_main_give_trait(attacker, "hcp_trait_military_admin_bad", 20, 10)
                    out("hcp attacker lost battle applying traits")
               end
          end

          ------------------------------
          ---- PYRRHIC VICTORY ----
          ------------------------------
          if battle:attacker_battle_result() == "pyrrhic_victory" then
               hcp_main_give_trait(attacker, "phar_main_trait_blunt", 20, 15)
               out("hcp attacker won battle with a pyrrhic victory so applying traits")
          end
          if battle:defender_battle_result() == "pyrrhic_victory" then
               hcp_main_give_trait(defender, "phar_main_trait_blunt", 20, 15)
               out("hcp defender won battle with a pyrrhic victory so applying traits")
          end

          ------------------------------
          ---- VALIANT DEFEAT ----
          ------------------------------
          if battle:attacker_battle_result() == "valiant_defeat" then
               hcp_main_give_trait(attacker, "hcp_trait_survivor", 20, 15)
               out("hcp attacker lost battle with a valiant defeat so applying traits")
          end
          if battle:defender_battle_result() == "valiant_defeat" then
               hcp_main_give_trait(defender, "hcp_trait_survivor", 20, 15)
               out("hcp defender lost battle with a valiant defeat so applying traits")
          end

          ------------------------------
          ---- CLOSE VICTORY ----
          ------------------------------
          if battle:attacker_battle_result() == "close_victory" then
               hcp_main_give_trait(attacker, "hcp_trait_disciplinarian", 20, 15)
               out("hcp attacker won battle with a close victory so applying traits")
          end
          if battle:defender_battle_result() == "close_victory" then
               hcp_main_give_trait(defender, "hcp_trait_disciplinarian", 20, 15)
               out("hcp defender won battle with a close victory so applying traits")
          end

          ----------------------
          ---- CLOSE DEFEAT ----
          ----------------------
          if battle:attacker_battle_result() == "close_defeat" then
               hcp_main_give_trait(attacker, "hcp_trait_bad_disciplinarian", 20, 10)
               out("hcp attacker lost battle with a close defeat so applying traits")
          end
          if battle:defender_battle_result() == "close_defeat" then
               hcp_main_give_trait(defender, "hcp_trait_bad_disciplinarian", 20, 10)
               out("hcp defender lost battle with a close defeat so applying traits")
          end


          --------------------------------
          ---- BATTLES AGAINST REBELS ----
          --------------------------------
          local battle = context:pending_battle()
          local attacker = battle:attacker()
          local defender = battle:defender()

          if attacker:faction():is_rebel() and attacker:won_battle() == false then
               hcp_main_give_trait(defender, "hcp_trait_authoritarian", 20, 20)
               out("HCP_battle_against_rebels_defender_gains_authoritarian_trait")
          elseif defender:faction():is_rebel() and defender:won_battle() == false then
               hcp_main_give_trait(attacker, "hcp_trait_authoritarian", 20, 20)
               out("HCP_battle_against_rebels_attacker_gains_authoritarian_trait")
          end


          ----------------------------------------
          ---- FOUGHT BATTLE FAR FROM CAPITAL ----
          ----------------------------------------
          if attacker:faction():is_allowed_to_capture_territory() then
               if cm:char_is_general_with_army(attacker) and attacker:faction():has_home_region() then
                    local home = attacker:faction():home_region():settlement()
                    local distance = 2000
                    if distance and distance_squared(attacker:logical_position_x(), attacker:logical_position_y(), home:logical_position_x(), home:logical_position_y()) >= distance * distance then
                         hcp_main_give_trait(attacker, "phar_main_trait_individualistic", 20, 30)
                         out("hcp battle fought far from capital")
                    end
               end
          end

          if defender:faction():is_allowed_to_capture_territory() then
               if cm:char_is_general_with_army(defender) and defender:faction():has_home_region() then
                    local home = defender:faction():home_region():settlement()
                    local distance = 2000
                    if distance and distance_squared(defender:logical_position_x(), defender:logical_position_y(), home:logical_position_x(), home:logical_position_y()) >= distance * distance then
                         hcp_main_give_trait(defender, "phar_main_trait_individualistic", 20, 30)
                         out("hcp battle fought far from capital")
                    end
               end
          end


          ----------------------
          ---- FOUGHT ALONE ----
          ----------------------
          local battle = context:pending_battle()
          --secodnary attackers
          local secondary_attackers = battle:secondary_attackers()
          if secondary_attackers:is_empty() then
               hcp_main_give_trait(attacker, "phar_main_trait_individualistic", 20, 20)
               out("hcp battle fought alone")
          end

          -- secondary defenders
          local secondary_defenders = battle:secondary_defenders()
          if secondary_defenders:is_empty() then
               hcp_main_give_trait(defender, "phar_main_trait_individualistic", 20, 20)
               out("hcp battle fought alone")
          end


          ---------------------------------
          ---- REINFORCED OTHER ARMIES ----
          ---------------------------------
          local battle = context:pending_battle()
          --secodnary attackers
          local secondary_attackers = battle:secondary_attackers()
          if not secondary_attackers:is_empty() then
               for i = 0, secondary_attackers:num_items() - 1 do
                    local character = secondary_attackers:item_at(i)
                    hcp_main_give_trait(attacker, "phar_main_trait_cooperative", 20, 20)
                    out("hcp battle reinforced other army")
               end
          end
          -- secondary defenders
          local secondary_defenders = battle:secondary_defenders()
          if not secondary_defenders:is_empty() then
               for i = 0, secondary_defenders:num_items() - 1 do
                    local character = secondary_defenders:item_at(i)
                    hcp_main_give_trait(defender, "phar_main_trait_cooperative", 20, 20)
                    out("hcp battle reinforced other army")
               end
          end


          ----------------------------------------
          ---- BEING REINFORCED BY OTHER ARMY ----
          ----------------------------------------
          local battle = context:pending_battle()
          --secondary attackers
          local secondary_attackers = battle:secondary_attackers()
          if not secondary_attackers:is_empty() and not battle:attacker():is_null_interface() then
               hcp_main_give_trait(attacker, "phar_main_trait_cooperative", 20, 20)
               hcp_main_give_trait(attacker, "hcp_trait_trusting", 20, 5)
               out("hcp battle reinforced by other army")
          end
          -- secondary defenders
          local secondary_defenders = battle:secondary_defenders()
          if not secondary_defenders:is_empty() and not battle:defender():is_null_interface() then
               hcp_main_give_trait(defender, "phar_main_trait_cooperative", 20, 20)
               hcp_main_give_trait(defender, "hcp_trait_trusting", 20, 5)
               out("hcp battle reinforced by other army")
          end


          -- ---------------------------------
          -- ---- DEFEATED LEGENDARY LORD ----
          -- ---------------------------------
          -- local battle = context:pending_battle()
          -- local winner_character = nil
          -- local defeated_character = nil

          -- if battle:attacker():won_battle() then
          --     winner_character = battle:attacker()
          --     defeated_character = battle:defender()
          -- elseif battle:defender():won_battle() then
          --     winner_character = battle:defender()
          --     defeated_character = battle:attacker()
          -- end

          -- -- If a defeated legendary lord is found, apply the corresponding trait
          -- if defeated_character and LEGENDARY_LORD_DEFEAT_TRAIT[defeated_character:character_subtype()] then
          --     local trait = LEGENDARY_LORD_DEFEAT_TRAIT[defeated_character:character_subtype()]
          --     hcp_main_give_trait(winner_character, trait, 20)
          --     out("hcp_trait_applied_for_defeating_legendary_lord: " .. defeated_character:character_subtype())
          -- end
     end,
     true
)


-----------------------------------------
---- CHARACTER MIGHT DESTROY FACTION ----
-----------------------------------------
-- Table to store potential faction killers
local potential_faction_killers = {}

core:add_listener(
     "hcp_character_might_destroy_faction",
     "BattleConflictFinished",
     true,
     function(context)
          local battle = context:pending_battle()
          local attacker = battle:attacker()
          local defender = battle:defender()

          -- Check if the attacker won and the defender faction might be destroyed
          if not attacker:is_null_interface() and cm:char_is_general_with_army(attacker) and attacker:won_battle() then
               local defender_faction = defender:faction()
               if defender_faction:num_regions() <= 1 then
                    potential_faction_killers[defender_faction:name()] = attacker
                    out("HCP_PotentialFactionKiller: Attacker " ..
                         attacker:onscreen_name() .. " might destroy faction " .. defender_faction:name())
               end
          end

          -- Check if the defender won and the attacker faction might be destroyed
          if not defender:is_null_interface() and cm:char_is_general_with_army(defender) and defender:won_battle() then
               local attacker_faction = attacker:faction()
               if attacker_faction:num_regions() <= 1 then
                    potential_faction_killers[attacker_faction:name()] = defender
                    out("HCP_PotentialFactionKiller: Defender " ..
                         defender:onscreen_name() .. " might destroy faction " .. attacker_faction:name())
               end
          end
     end,
     true
)


----------------------------------
-- FACTION DESTROYED CHECK ----
----------------------------------
core:add_listener(
     "hcp_faction_destroyed",
     "FactionDestroyed",
     true,
     function(context)
          local faction = context:faction()

          -- Check if the faction is dead
          if faction:is_dead() then
               local killer = potential_faction_killers[faction:name()]
               if killer then
                    hcp_main_give_trait(killer, "hcp_trait_factionkiller", 20)
                    out("HCP_FactionKillerTraitApplied: " ..
                         killer:onscreen_name() .. " destroyed faction " .. faction:name())
                    potential_faction_killers[faction:name()] = nil -- Clear the entry after trait assignment
               end
          end
     end,
     true
)


--------------------
---- REBELLIONS ----
--------------------
core:add_listener(
     "hcp_region_rebelled",
     "RegionRebels",
     true,
     function(context)
          if context:region():settlement():has_commander() then
               local character = context:region():settlement():commander()
               hcp_main_give_trait(character, "hcp_trait_disciplinarian", 20, 25)
               hcp_main_give_trait(character, "hcp_trait_authoritarian", 20, 15)
               hcp_main_give_trait(character, "hcp_trait_admin_bad", 20, 15)
               out("hcp_REGION_REBELLED_AND_ATTEMPTED_TO_GIVE_TRAIT_TO_" ..
                    tostring(cm:char_lookup_str(character:command_queue_index())))
          end
     end,
     true
)





-----------------------------
---- BUILDINGS COMPLETED ----
-----------------------------
core:add_listener(
     "hcp_building_completed_listener",
     "BuildingCompleted",
     true,
     function(context)
          local building = context:building()
          local settlement = building:region():settlement()
          local superchain_key = building:superchain()

          if settlement:has_commander() then
               local character = settlement:commander()


               --------------------------
               ---- BUILT FARMS ----
               --------------------------
               if FOOD_SUPERCHAINS_SET[superchain_key] then
                    hcp_main_give_trait(character, "hcp_trait_farmer_good", 20, 66)
                    out("hcp_farmer: Applied hcp_trait_farmer_good to " .. character:onscreen_name())
               else
                    hcp_main_give_trait(character, "hcp_trait_farmer_bad", 20, 5)
                    out("hcp_farmer: Building superchain not in FOOD_SUPERCHAINS_SET")
               end


               --------------------------
               ---- BUILT MINES ----
               --------------------------
               if MINE_SUPERCHAINS_SET[superchain_key] then
                    hcp_main_give_trait(character, "hcp_trait_miner", 20, 25)
                    out("hcp_miner: Applied hcp_trait_miner to " .. character:onscreen_name())
               else
                    out("hcp_miner: Building superchain not in MINE_SUPERCHAINS_SET")
               end


               ------------------------------
               ---- BUILT SMUGGLERS' DEN ----
               ------------------------------
               if superchain_key == "phar_main_port_coast_derivative_type_a" or superchain_key == "phar_main_irsu_resource_production_port_coast_derivative_type_a" then
                    hcp_main_give_trait(character, "hcp_trait_criminal", 20, 20)
                    out("hcp_smuggler: built smugglers' den and applying trait to " .. character:onscreen_name())
               else
                    out("hcp_smuggler: smugglers' den not found")
               end


               ----------------------
               ---- BUILT SHRINE ----
               ----------------------
               if superchain_key == "phar_main_ers_shrine" then
                    hcp_main_give_trait(character, "phar_main_trait_spiritual", 20, 20)
                    out("hcp_builder: hcp_character_present_for_construction_of_shrine")
               end


               ----------------------
               ---- BUILT TEMPLE ----
               ----------------------
               if superchain_key == "phar_main_religion_temple" or superchain_key == "phar_map_religion_dwelling_all" then
                    hcp_main_give_trait(character, "phar_main_trait_spiritual", 20, 20)
                    out("hcp_builder: hcp_character_present_for_construction_of_temple")
               end


               --------------------
               ---- BUILT ADMIN----
               --------------------
               if MANAGEMENT_BUILDING_SUPERCHAINS_SET[superchain_key] then
                    hcp_main_give_trait(character, "hcp_trait_admin_good", 20, 20)
                    out("hcp_builder: Applied hcp_trait_admin_good to " .. character:onscreen_name())
               end


               ---------------------------------
               ---- BUILT MILITARY ADMIN----
               ---------------------------------
               if MILITARY_ADMIN_BUILDINGS_SET[superchain_key] then
                    hcp_main_give_trait(character, "hcp_trait_military_admin_good", 20, 20)
                    out("hcp_builder: Applied hcp_trait_admin_good to " .. character:onscreen_name())
               end


               -------------------------
               ---- BUILT GOLD MINE ----
               -------------------------
               if GOLD_SUPERCHAINS_SET[superchain_key] then
                    hcp_main_give_trait(character, "phar_main_trait_materialistic", 20, 20)
                    out("hcp_builder: Applied phar_main_trait_materialistic to " .. character:onscreen_name())
               end

               ----------------------------
               ---- BUILT ANY BUILDING ----
               ----------------------------
               hcp_main_give_trait(character, "phar_main_trait_cultured", 20, 10)
          else
               out("No commander found in settlement")
          end
     end,
     true
)


core:add_listener(
     "hcp_character_rank_up_listener",
     "CharacterRankUp",
     true,
     function(context)
          local character = context:character()

          out("HCP_CHARACTER_RANKED_UP: " .. character:onscreen_name())

          if character:is_null_interface() then
               return out("HCP_CHARACTER_RANKED_UP_BUT_IS_NULL_INTERFACE!")
          end


          ------------------------------------
          ---- POPULAR/UNPOPULAR GOVERNOR ----
          ------------------------------------
          if character:has_region() and character:in_settlement() then
               local region = character:region()
               out("HCP_CHARACTER_" .. character:onscreen_name() .. " IS GOVERNOR OF REGION: " .. region:name())
               if not character:turns_in_own_regions() < 5 and character:military_force():active_stance() ~= "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MUSTER" then
                    if region:public_order() >= 50 then
                         hcp_main_give_trait(character, "hcp_trait_popular", 20, 10)
                         out("HCP_CHARACTER_" ..
                              character:onscreen_name() ..
                              " RANKED UP IN SETTLEMENT WITH HIGH PUBLIC ORDER. GIVING POPULAR.")
                    elseif region:public_order() <= -50 then
                         hcp_main_give_trait(character, "hcp_trait_unpopular", 20, 10)
                         out("HCP_CHARACTER_" ..
                              character:onscreen_name() ..
                              " RANKED UP IN SETTLEMENT WITH LOW PUBLIC ORDER. GIVING UNPOPULAR.")
                    end
               end
          end


          ----------------------------
          ---- POLITICIAN RANK UP ----
          ----------------------------
          if character:is_politician() then
               hcp_main_give_trait(character, "hcp_trait_military_admin_good", 20, 10)
               out("HCP_CHARACTER_" .. character:onscreen_name() .. " IS A POLITICIAN. GIVING MILITARY ADMIN GOOD TRAIT.")
          end
          if character:is_politician() and character:faction():at_war() then
               hcp_main_give_trait(character, "hcp_trait_warmonger", 20, 4)
               out("HCP_CHARACTER_" .. character:onscreen_name() .. " IS AT WAR. GIVING WARMONGER TRAIT.")
          elseif character:is_politician() and not character:faction():at_war() then
               hcp_main_give_trait(character, "hcp_trait_pacifist", 20, 10)
               out("HCP_CHARACTER_" .. character:onscreen_name() .. " IS NOT AT WAR. GIVING PACIFIST TRAIT.")
          end
     end,
     true
)


----------------------------------------------
---- MAIN CHARACTER TURN START PROCESSING ----
----------------------------------------------
core:add_listener(
     "hcp_character_turn_start_main",
     "CharacterTurnStart",
     true,
     function(context)
          local character = context:character()

          if character:is_null_interface() then
               out("hcp_character_turn_start_main character is_null_interface!")
               return
          end

          if not character:character_type("general") or character:character_details():is_civilian() then
               out("hcp_character_turn_start_main character is not a general or is a civilian!")
               return
          end


          -------------------------------------------------------------
          ---- LOW/HIGH INFLUENCE REGION FOR RESPECTFUL/IRREVERENT ----
          -------------------------------------------------------------
          local character = context:character()
          local influence_threshold = 0.6
          local religion = character:faction():state_religion()

          if cm:char_is_general_with_army(character)
              and not character:region():is_null_interface()
              and character:has_region() then
               local region_influence = character:region():religion_proportion(religion)

               --low influence check
               if region_influence < influence_threshold then
                    hcp_main_give_trait(character, "phar_main_trait_respectful", 20, 3)
                    out("HCP_CHAR_IN_LOW_INFLUENCE_REGION!")
                    --high influence check
               elseif region_influence > influence_threshold then
                    hcp_main_give_trait(character, "phar_main_trait_irreverent", 20, 1)
                    out("HCP_CHAR_IN_HIGH_INFLUENCE_REGION!")
               end
          end


          ---------------------------------------------------------
          ---- WARS AND ALLIES CHECK FOR RESPECTFUL/IRREVERENT ----
          ---------------------------------------------------------
          -- local character = context:character()
          -- local faction = character:faction()

          -- if faction:num_allies() == 0 and faction:at_war() then
          --     hcp_main_give_trait(character, "phar_main_trait_irreverent", 20, 1)
          -- elseif faction:num_allies() > 1 then
          --     hcp_main_give_trait(character, "phar_main_trait_respectful", 20, 1)
          -- end


          -------------------------------------------------------
          ---- PLAGUE, EARTHQUAKE, FLOOD, DROUGHT, DISASTERS ----
          -------------------------------------------------------
          if character:has_region() then
               local faction_key = character:faction():name()
               local province = character:region():province()
               local province_name = character:region():province_name()
               out("HCP_TEST_BLIGHTED_PASSED_CHECK_CHARACTER_IS_IN_PROVINCE_" .. tostring(province_name))

               local disaster_traits = {
                    { "phar_main_effect_bundle_incident_disaster_plague_recruitment_slots", "hcp_trait_blighted" },
                    { "phar_main_effect_bundle_incident_disaster_flood",                    "hcp_trait_unpopular" },
                    { "phar_main_effect_bundle_incident_disaster_drought_food_production",  "hcp_trait_farmer_bad" },
                    { "phar_main_effect_bundle_incident_disaster_earthquake",               "hcp_trait_unpopular" }
               }

               -- Loop through the table
               for i = 1, #disaster_traits do
                    local effect_bundle_key = disaster_traits[i][1]
                    local trait_key = disaster_traits[i][2]

                    if province:has_effect_bundle(effect_bundle_key, faction_key) then
                         hcp_main_give_trait(character, trait_key, 20, 10)
                         out("Applied " .. trait_key .. " due to effect bundle " .. effect_bundle_key)
                    end
               end
          end


          ----------------
          ---- AT SEA ----
          ----------------
          if character:is_at_sea() then
               hcp_main_give_trait(character, "hcp_trait_sea_legs", 20, 10)
               out("HCP_CHAR_IS_AT_SEA_APPLYING_TRAIT")
          end


          ---------------------------------------------
          ---- RANDOM CHANCE FOR TRAITS EVERY TURN ----
          ---------------------------------------------
          -- if cm:model():random_percent(0) then
          --     local random_index = math.random(#CHARACTER_CREATED_TRAITS)
          --     local selected_trait = CHARACTER_CREATED_TRAITS[random_index]

          --     out("HCP_RANDOM_NUMBER_IS_" .. random_index)

          --     hcp_main_give_trait(character, selected_trait, 4)
          --     out("hcp_add_random_trait_to_character_PASSED_RANDOM_CHECK_AND_IS_APPLYING_" .. tostring(selected_trait))
          -- end


          -------------------------------------------------------------
          ---- GARRISONED IN SETTLEMENT WITH HIGH/LOW PUBLIC ORDER ----
          -------------------------------------------------------------
          local region = character:region()
          local public_order = region:public_order()
          local faction_name = region:owning_faction():name()
          local is_in_settlement = character:in_settlement() == true

          if cm:char_is_general_with_army(character) and character:has_region() and is_in_settlement then
               if not character:turns_in_own_regions() < 5 and character:military_force():active_stance() ~= "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MUSTER" then
                    if public_order >= 75 and faction_name == character:faction():name() then
                         hcp_main_give_trait(character, "phar_main_trait_content", 20, 2)
                         hcp_main_give_trait(character, "hcp_trait_bad_disciplinarian", 20, 2)
                         out("hcp_character_is_garrisoned_in_settlement_with_high_public_order!")
                    elseif public_order <= -75 and faction_name == character:faction():name() then
                         hcp_main_give_trait(character, "hcp_trait_disciplinarian", 20, 15)
                         hcp_main_give_trait(character, "hcp_trait_admin_bad", 20, 15)
                         out("hcp_character_is_garrisoned_in_settlement_with_low_public_order!")
                    end
               end
          end
     end,
     true
)

--[[


]] --


--------------------------------------------
---- MAIN CHARACTER TURN END PROCESSING ----
--------------------------------------------
core:add_listener(
     "hcp_character_turn_end_main",
     "CharacterTurnEnd",
     true,
     function(context)
          local character = context:character()

          if character:is_null_interface() then
               out("hcp_character_turn_end_main character is_null_interface!")
               return
          end

          if character:character_type("colonel") or character:character_details():is_civilian() then
               out("hcp_character_turn_end_main character is a colonel or is a civilian!")
               return
          end


          -----------------------------------------------------
          ---- SPENT TURN IN ENEMY REGION OR IN SETTLEMENT ----
          -----------------------------------------------------
          ---Handles Hesitant, Confident, Scout, Cuckold

          local faction = character:faction()
          local region = character:region()

          if faction:is_allowed_to_capture_territory()
              and cm:char_is_general_with_army(character)
              and character:has_region()
              and not region:is_abandoned() then
               -- Check if the character is in a settlement and applies hesitant
               if character:in_settlement() then
                    --[[
                hcp_main_give_trait(character, "phar_main_trait_hesitant", 20, 5)
                out("HCP: Character in settlement, applying 'hesitant' trait.")
                ]] --
                    -- Check if the character is in an enemy region and apply scout, confident and pragmatic
               elseif faction:name() ~= region:owning_faction():name() then
                    hcp_main_give_trait(character, "phar_main_trait_confident", 20, 5)
                    hcp_main_give_trait(character, "hcp_trait_scout", 20, 5)
                    hcp_main_give_trait(character, "hcp_trait_pragmatic", 20, 5)
                    out("HCP: Character in enemy region, applying 'confident' and 'scout' traits.")

                    -- Additional check for marriage and action points and applies cuckold.
                    if character:family_member():has_spouse() and character:turns_in_enemy_regions() >= 10 then
                         hcp_main_give_trait(character, "hcp_trait_cuckold", 20, 3)
                         out("HCP: Character is married and has full action points, applying 'cuckold' trait.")
                    end

                    -- Character is in a friendly region but not in a settlement; he still gets scout.
               else
                    hcp_main_give_trait(character, "hcp_trait_scout", 20, 5)
                    out("HCP: Character in friendly region, applying 'scout' trait.")
               end

               ------------------------------------------
               ---- SPENT TURN OUTSIDE OF SETTLEMENT ----
               ------------------------------------------
               ---handles feck and bad_disciplinarian
               if not character:in_settlement() and cm:char_is_general_with_army(character) and character:military_force():active_stance() ~= "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MUSTER" then
                    hcp_main_give_trait(character, "hcp_trait_feck", 20, 5)
                    --hcp_main_give_trait(character, "hcp_trait_bad_disciplinarian", 20, 1)
                    out(
                         "HCP: Character not in settlement with full action points, applying 'feck' and 'bad_disciplinarian' traits.")
               end
          end

          ------------------
          ---- SLOTHFUL ----
          ------------------
          if cm:char_is_general_with_army(character)
              and character:has_region()
              and character:turns_in_own_regions() >= 10
              and character:in_settlement()
              and character:military_force():active_stance() ~= "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MUSTER"
              and character:military_force():active_stance() ~= "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MARCH"
              and character:military_force():active_stance() ~= "MILITARY_FORCE_SITUATIONAL_STANCE_LAY_SIEGE" then
               out("hcp_slothful_character_is_eligible_for_slothful")

               hcp_main_give_trait(character, "hcp_trait_slothful", 20, 5)
          end

          ----------------------------
          ---- LAZY IN SETTLEMENT ----
          ----------------------------
          ---Handles "bad" traits like drink, girls, arse, and gambler
          if cm:char_is_general_with_army(character)
              and character:has_region()
              and character:turns_in_own_regions() >= 10
              and character:in_settlement()
              and character:military_force():active_stance() ~= "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MUSTER" then
               out("HCP_LAZY_IN_SETTLEMENT_BEGINS")

               local sober_chance = 1
               local drink_chance = 1

               local region = character:region()
               out("HCP_CHARACTER_" .. character:onscreen_name() .. " IS GOVERNOR OF REGION: " .. region:name())

               if region:public_order() >= 50 then
                    -- Old characters are more likely to get lazy traits like in Attila
                    if character:age() > 50 then
                         drink_chance = drink_chance + 2
                         out("hcp_give_lazy_traits_character_is_old_so_drink_chance_is " .. drink_chance)
                    end
                    -- Check if settlement has a military admin, temple, or beer building and increase chance if so
                    local slot_list = character:region():settlement():slot_list()
                    out("Checking " .. slot_list:num_items() .. " slots in the settlement.")

                    for i = 0, slot_list:num_items() - 1 do
                         if slot_list:item_at(i):has_building() then
                              local building_superchain = slot_list:item_at(i):building():superchain()
                              out("Checking building with superchain: " .. building_superchain)

                              if MILITARY_ADMIN_BUILDINGS_SET[building_superchain] then
                                   sober_chance = sober_chance + 4
                                   out("hcp_give_lazy_traits_found_military_admin_building_so_sober_chance_is " ..
                                        sober_chance)
                              end

                              if DRINK_BUILDING_SET[building_superchain] then
                                   drink_chance = drink_chance + 4
                                   out("hcp_give_lazy_traits_found_drink_building_so_drink_chance_is " .. drink_chance)
                              end

                              if building_superchain == "phar_main_religion_temple" or building_superchain == "phar_map_religion_dwelling_all" then
                                   sober_chance = sober_chance + 4
                                   out("hcp_give_lazy_traits_found_temple_so_sober_chance_is " .. sober_chance)
                              end
                         end
                    end

                    out("Final sober_chance: " .. sober_chance)
                    out("Final drink_chance: " .. drink_chance)

                    -- Apply the traits after processing all the buildings
                    local traits = {
                         { "hcp_trait_sober",      sober_chance },
                         { "hcp_trait_drink",      drink_chance },
                         { "hcp_trait_girls",      drink_chance },
                         { "hcp_trait_arse",       drink_chance },
                         { "hcp_trait_degenerate", drink_chance },
                         { "hcp_trait_gambler",    drink_chance }
                    }

                    for i = 1, #traits do
                         out("Applying trait: " .. traits[i][1] .. " with chance: " .. traits[i][2])
                         hcp_main_give_trait(character, traits[i][1], 20, traits[i][2])
                    end
                    -- else
                    --     out("Character is not eligible for lazy traits (not in settlement or insufficient action points).")
               end
          end


          -------------------------------
          ---- CORRUPT IN SETTLEMENT ----
          -------------------------------
          if cm:char_is_general_with_army(character)
              and character:in_settlement() then
               local building_list = region:settlement():building_list()
               out("HCP_CHARACTER_" ..
                    character:onscreen_name() ..
                    " IS IN REGION: " .. region:name() .. " CHECKING FOR TREASURY, PALACE OF PLEASURE AND GOLD MINE")

               --check faction treasury
               -- local faction = character:faction()
               -- if (faction:is_human() and faction:treasury() >= 100000)
               --     or (not faction:is_human() and faction:treasury() >= 250000) then
               --     hcp_main_give_trait(character, "hcp_trait_corrupt", 20, 3)
               --     out("HCP_CORRUPT treasury is high! Treasury_is_" .. tostring(faction:treasury()))
               -- end

               --check for palace of pleasures
               for i = 0, building_list:num_items() - 1 do
                    local building = building_list:item_at(i)
                    if not building:is_null_interface() then
                         local superchain = building:superchain()
                         if superchain == "phar_map_bab_province_management_happiness_growth_type_a" then
                              hcp_main_give_trait(character, "hcp_trait_corrupt", 20, 5)
                              hcp_main_give_trait(character, "hcp_trait_degenerate", 20, 5)
                              out("HCP_CORRUPT pleasure palace found!")
                              break
                         end

                         --check for gold mine
                         if GOLD_SUPERCHAINS_SET[superchain] then
                              hcp_main_give_trait(character, "hcp_trait_corrupt", 20, 1)
                              out("HCP_CORRUPT gold mine found!")
                              break
                         end
                    end
               end
          end


          -------------------------------
          ---- SPENT TURN IN STANCES ----
          -------------------------------
          local character = context:character();

          if cm:char_is_general_with_army(character) then
               local stance = character:military_force():active_stance();

               -- RAIDING
               if stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_LAND_RAID" then
                    hcp_main_give_trait(character, "phar_main_trait_blunt", 20, 20);
                    -- AMBUSHING
               elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_AMBUSH" then
                    hcp_main_give_trait(character, "phar_main_trait_underhanded", 20, 20);
                    -- FORCED MARCH
               elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MARCH" then
                    hcp_main_give_trait(character, "phar_main_trait_ambitious", 20, 15);
                    -- ENCAMP
               elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_SET_CAMP" then
                    hcp_main_give_trait(character, "phar_main_trait_content", 20, 30);
                    -- RECRUITING
               elseif stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MUSTER" then
                    hcp_main_give_trait(character, "hcp_trait_charismatic", 20, 10);
                    hcp_main_give_trait(character, "hcp_trait_military_admin_good", 20, 5);
               end
          end


          ----------------------------
          ---- SUFFERED ATTRITION ----
          ----------------------------
          local character = context:character()
          local military_force = character:military_force()
          if not military_force:is_null_interface() then
               if military_force:will_suffer_any_attrition() then
                    hcp_main_give_trait(character, "phar_main_trait_ambitious", 20, 15);
                    out("HCP_character_suffered_attrition")
               end
          end


          -------------------------------
          ---- CHARACTER UNDER SIEGE ----
          -------------------------------
          if cm:char_is_general_with_army(character)
              and character:has_garrison_residence()
              and character:garrison_residence():is_under_siege() then
               hcp_main_give_trait(character, "hcp_trait_blighted", 20, 20)
               out("HCP_character_under_siege")
          end


          -- ----------------------
          -- ---- LOSING MONEY ----
          -- ----------------------
          -- if cm:char_is_general_with_army(character)
          --     and character:faction():losing_money()
          --     and character:model():turn_number() > 5 then
          --     hcp_main_give_trait(character, "PLACEHOLDER_LOSING_MONEY", 20, 5)
          --     out("HCP_faction_losing_money_" .. tostring(character:faction():name()))
          -- end


          -- ----------------------
          -- ---- LOW TAXES ----
          -- ----------------------
          -- if cm:char_is_general_with_army(character)
          --     and character:faction():tax_level() < 80 then
          --     hcp_main_give_trait(character, "PLACEHOLDER_BAD_TAXMAN", 20, 5)
          --     out("HCP_faction_taxes_less_than_80_percent_" .. tostring(character:faction():name()))
          -- end


          ---------------------------------------
          ---- SETTLEMENT HAS SMUGGLERS' DEN ----
          ---------------------------------------
          if cm:char_is_general_with_army(character)
              and character:has_region()
              and character:in_settlement() then
               local building_list = region:settlement():building_list()
               out("HCP_CHARACTER_" .. character:onscreen_name() ..
                    " IS IN REGION: " .. region:name() .. " CHECKING FOR SMUGGLERS' DEN")

               --check for smugglers' den
               for i = 0, building_list:num_items() - 1 do
                    local building = building_list:item_at(i)
                    if not building:is_null_interface() then
                         local superchain = building:superchain()
                         if superchain == "phar_main_port_coast_derivative_type_a" or superchain == "phar_main_irsu_resource_production_port_coast_derivative_type_a" then
                              hcp_main_give_trait(character, "hcp_trait_criminal", 20, 4)
                              out("HCP_SMUGGLERS' DEN found!")
                              break
                         end
                    end
               end
          end


          ------------------------------------------------
          ---- SETTLEMENT HAS MILITARY ADMIN BUILDING ----
          ------------------------------------------------
          if cm:char_is_general_with_army(character)
              and character:has_region()
              and character:in_settlement() then
               local region = character:region()
               local building_list = region:settlement():building_list()

               out("HCP_CHARACTER_" ..
                    character:onscreen_name() ..
                    " IS IN REGION: " .. region:name() .. " CHECKING FOR MILITARY ADMIN BUILDINGS")
               for i = 0, building_list:num_items() - 1 do
                    if building_list:item_at(i):is_null_interface() == false then
                         local military_admin_superchain = building_list:item_at(i):superchain()
                         if MILITARY_ADMIN_BUILDINGS_SET[military_admin_superchain] then
                              hcp_main_give_trait(character, "hcp_trait_military_admin_good", 20, 5)
                              out("HCP_CHARACTER_" ..
                                   character:onscreen_name() ..
                                   " FOUND MILITARY ADMIN BUILDING: " .. military_admin_superchain)
                         end
                    end
               end
          end



          ---------------------------------------
          ---- SETTLEMENT HAS ADMIN BUILDING ----
          ---------------------------------------
          if cm:char_is_general_with_army(character)
              and character:has_region()
              and character:in_settlement() then
               local region = character:region()
               local building_list = region:settlement():building_list()

               out("HCP_CHARACTER_" ..
                    character:onscreen_name() ..
                    " IS IN REGION: " .. region:name() .. " CHECKING FOR MANAGEMENT BUILDINGS")
               for i = 0, building_list:num_items() - 1 do
                    if building_list:item_at(i):is_null_interface() == false then
                         local management_superchain = building_list:item_at(i):superchain()
                         if MANAGEMENT_BUILDING_SUPERCHAINS_SET[management_superchain] then
                              hcp_main_give_trait(character, "hcp_trait_admin_good", 20, 5)
                              out("HCP_CHARACTER_" ..
                                   character:onscreen_name() .. " FOUND MANAGEMENT BUILDING: " .. management_superchain)
                         end
                    end
               end
          end


          ------------------------------------
          ---- IS CHARACTER YOUNG OR OLD? ----
          ------------------------------------
          local character = context:character()

          if character:age() < 30 then
               hcp_main_give_trait(character, "hcp_trait_energetic", 20, 2)
               hcp_main_give_trait(character, "hcp_trait_fertile", 20, 2)
               out("HCP_CHARACTER_" .. character:onscreen_name() .. "_is_young")
          elseif character:age() > 50 then
               hcp_main_give_trait(character, "hcp_trait_slothful", 20, 2)
               hcp_main_give_trait(character, "hcp_trait_mad", 20, 2)
               hcp_main_give_trait(character, "hcp_trait_infertile", 20, 2)
               hcp_main_give_trait(character, "hcp_trait_blind", 20, 2)
               out("HCP_CHARACTER_" .. character:onscreen_name() .. "_is_old")
          end


          ----------------------------------
          ---- SELF PERPETUATING TRAITS ---- <-------PUT THIS LAST!
          ----------------------------------
          for i = 1, #SELF_PERPETUATING_TRAITS do
               if character:has_trait(SELF_PERPETUATING_TRAITS[i]) then
                    hcp_main_give_trait(character, SELF_PERPETUATING_TRAITS[i], 15, 3)
                    out("HCP_CHARACTER_" ..
                         character:onscreen_name() .. " HAS SELF PERPETUATING TRAIT: " .. SELF_PERPETUATING_TRAITS[i])
               end
          end
     end,
     true
)


cm:add_saving_game_callback(
     function(context)
          cm:save_named_value("is_legacy_claimed", is_legacy_claimed, context);
     end
)

cm:add_loading_game_callback(
     function(context)
          if cm:is_new_game() == false then
               ---@diagnostic disable-next-line: cast-local-type
               is_legacy_claimed = cm:load_named_value("is_legacy_claimed", 0, context)
          end
     end
)

-----------------------
---- RELATIVE DIED ----
-----------------------
-- core:add_listener(
--     "hcp_character_relative_killed",
--     "FactionCharacterDiedOrWounded",
--     true,
--     function(context)
--         local faction = context:faction()
--         local family_member = context:family_member()
--         local dead_family_member = family_member:character():command_queue_index()
--         out("hcp_character_family_relation_died_called_" .. dead_family_member)
--         if faction:is_human() then
--             if not family_member:is_null_interface() then
--                 if family_member:is_in_faction_leaders_family() then
--                     for i = 0, faction:character_list():num_items() - 1 do
--                         local character = faction:character_list():item_at(i)
--                         if not character:is_null_interface()
--                         and character:family_member():is_in_faction_leaders_family()
--                         and character:command_queue_index() ~= dead_family_member then
--                             hcp_main_give_trait(character, "hcp_trait_bereaved", 20, 100)
--                             out("hcp_FAMILY_MEMBER_DIED_SO_APPLYING_BEREAVED_TO_CHARACTER_" .. character:command_queue_index())
--                         end
--                     end
--                 end
--             end
--         end
--     end,
--     true
-- )
