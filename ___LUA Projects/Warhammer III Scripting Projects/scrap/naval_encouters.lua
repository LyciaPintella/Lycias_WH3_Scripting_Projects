local encounter_sea_location_set = {
     ["main_warhammer"] = {
          {
               {165, 787}, {237, 776}, {294, 818}, {376, 765}, {291, 456}, {259, 521}, {375, 852}, {534, 896}, {157, 678}, {668, 890}, {753, 849}, {408, 723},
               {501, 766}, {590, 799}, {310, 746}, {337, 710}, {359, 669}, {301, 648}, {297, 694}, {263, 656}, {228, 709}, {202, 642}, {339, 542}, {171, 603},
               {139, 543}, {105, 469}, {158, 488}, {140, 424}, {181, 381}, {424, 873}, {253, 367}, {210, 425}, {350, 604}, {373, 572}, {379, 519}, {433, 490},
               {333, 477}, {344, 432}, {294, 383}, {443, 676}, {359, 401}, {424, 382}, {456, 412}, {506, 392}, {541, 342}, {572, 418}, {365, 348}, {427, 328},
               {318, 330}, {270, 317}, {241, 476}, {372, 301}, {265, 410}, {267, 165}, {315, 251}, {289, 214}, {395, 254}, {360, 214}, {151, 638}, {79, 511},
               {633, 499}, {331, 780}, {447, 883}, {440, 708}, {390, 820}, {613, 779}, {454, 346}, {205, 486}, {318, 281}, {504, 357}, {1364, 634}, {1373, 537},
               {1402, 414}, {1254, 452}, {1212, 502}, {1236, 302}, {925, 132}, {934, 373}, {801, 387}, {830, 257}, {767, 150}, {667, 77}, {565, 57}, {592, 135},
               {504, 152}, {514, 232}, {863, 40}, {788, 77}, {465, 94}, {359, 89}, {273, 64}, {166, 28}, {162, 99}, {103, 148}, {35, 217}, {15, 275}, {45, 353},
               {28, 400}, {78, 410}, {38, 444}, {14, 520}, {394, 145}
          }, {
               {153, 779}, {236, 775}, {294, 818}, {355, 716}, {264, 437}, {223, 504}, {399, 854}, {559, 891}, {189, 678}, {683, 879}, {777, 833}, {406, 714},
               {546, 779}, {210, 653}, {311, 724}, {158, 507}, {359, 669}, {352, 589}, {309, 651}, {281, 656}, {228, 709}, {188, 633}, {328, 529}, {148, 561},
               {113, 549}, {105, 464}, {154, 463}, {161, 405}, {181, 381}, {424, 873}, {253, 367}, {197, 415}, {358, 617}, {398, 563}, {373, 490}, {422, 510},
               {307, 461}, {344, 432}, {294, 383}, {459, 750}, {359, 401}, {424, 382}, {488, 436}, {482, 373}, {566, 375}, {565, 418}, {392, 342}, {413, 296},
               {333, 294}, {287, 333}, {267, 498}, {327, 254}, {265, 410}, {259, 241}, {295, 264}, {320, 213}, {377, 274}, {374, 228}, {158, 611}, {71, 507},
               {644, 505}, {331, 780}, {468, 880}, {550, 639}, {390, 820}, {613, 779}, {508, 338}, {268, 679}, {263, 549}, {337, 339}, {27, 478}, {66, 385},
               {20, 299}, {92, 186}, {186, 68}, {332, 72}, {301, 147}, {256, 196}, {412, 152}, {420, 83}, {521, 68}, {560, 116}, {491, 153}, {478, 229}, {613, 46},
               {807, 73}, {895, 38}, {984, 95}, {977, 211}, {782, 148}, {870, 252}, {852, 358}, {943, 386}, {1050, 338}, {1138, 226}, {1323, 411}, {1238, 501},
               {1393, 488}, {1374, 605}, {1368, 654}, {1407, 413}, {937, 283}
          }
     },

     ["wh3_main_chaos"] = {
          {
               {1033, 145}, {1084, 92}, {1034, 67}, {978, 75}, {980, 108}, {76, 108}, {81, 145}, {76, 191}, {82, 255}, {132, 232}, {158, 195}, {192, 164},
               {235, 158}, {195, 206}, {219, 238}, {266, 242}, {210, 262}, {158, 245}, {126, 286}, {79, 319}, {69, 368}, {37, 386}, {25, 424}, {13, 468}, {55, 486},
               {98, 459}, {152, 412}, {216, 373}, {278, 355}, {329, 311}, {373, 308}, {457, 305}, {485, 266}, {542, 273}, {567, 298}, {678, 269}, {603, 295},
               {589, 326}, {508, 314}, {429, 341}, {411, 323}, {336, 329}, {207, 412}, {72, 508}, {124, 262}, {135, 464}, {96, 513}, {78, 540}
          }
     }
};

local encounter_events_details = {
     ["wh2_main_incident_encounter_at_sea_1"] = {["category"] = "battle", ["variation"] = {"_a", "_b", "_c"}, ["model"] = {1, 4, 24, 27}},

     ["wh2_main_incident_encounter_at_sea_2"] = {["category"] = "battle", ["variation"] = {"_a", "_b", "_c"}, ["model"] = {3, 28, 29, 30, 31}},

     ["wh2_main_incident_encounter_at_sea_3"] = {["category"] = "battle", ["variation"] = {"_a", "_b", "_c"}, ["model"] = {2, 25, 26}},

     ["wh2_main_incident_encounter_at_sea_4"] = {["category"] = "battle", ["variation"] = {"_a"}, ["model"] = {11}},

     ["wh2_main_dilemma_encounter_at_sea_1"] = {
          ["category"] = "marker",
          ["variation"] = {"", "_a"},
          ["model"] = {5, 6, 7, 8},
          ["followup_incidents"] = {
               {"wh2_main_encounter_at_sea_combat_1", "wh2_main_encounter_at_sea_combat_2"},
               {"wh2_main_encounter_at_sea_campaign_2", "wh2_main_encounter_at_sea_campaign_3"}
          }
     },

     ["wh2_main_dilemma_encounter_at_sea_2"] = {
          ["category"] = "marker",
          ["variation"] = {"", "_a"},
          ["model"] = {9, 10, 18},
          ["followup_incidents"] = {
               {"wh2_main_encounter_at_sea_combat_3", "wh2_main_encounter_at_sea_combat_4"},
               {"wh2_main_encounter_at_sea_campaign_1", "wh2_main_encounter_at_sea_campaign_2"}
          }
     },

     ["wh2_main_dilemma_encounter_at_sea_3"] = {
          ["category"] = "marker",
          ["variation"] = {"", "_a"},
          ["model"] = {12, 23, 32},
          ["followup_incidents"] = {
               {"wh2_main_encounter_at_sea_combat_4", "wh2_main_encounter_at_sea_combat_5"},
               {"wh2_main_encounter_at_sea_campaign_1", "wh2_main_encounter_at_sea_campaign_4"}
          }
     },

     ["wh2_main_dilemma_encounter_at_sea_4"] = {
          ["category"] = "marker",
          ["variation"] = {"", "_a"},
          ["model"] = {13, 15, 16, 17, 19, 20, 21, 22},
          ["followup_incidents"] = {
               {"wh2_main_encounter_at_sea_combat_1", "wh2_main_encounter_at_sea_combat_2"},
               {"wh2_main_encounter_at_sea_campaign_3", "wh2_main_encounter_at_sea_campaign_2"}
          }
     }
};

-- followup incident when battle won, dilemma, enemy army size, treasure map chance (vampire coast only), followup incident when battle skipped
local encounter_events_battle_details = {
     ["wh2_main_incident_encounter_at_sea_1_a"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_1_a", 10, 30, "wh2_dlc11_incident_neo_encounter_at_sea_1_a"},
     ["wh2_main_incident_encounter_at_sea_1_b"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_1_b", 10, 30, "wh2_dlc11_incident_neo_encounter_at_sea_1_b"},
     ["wh2_main_incident_encounter_at_sea_1_c"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_1_c", 10, 30, "wh2_dlc11_incident_neo_encounter_at_sea_1_c"},
     ["wh2_main_incident_encounter_at_sea_2_a"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_2_a", 10, 30, "wh2_dlc11_incident_neo_encounter_at_sea_2_a"},
     ["wh2_main_incident_encounter_at_sea_2_b"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_2_b", 10, 30, "wh2_dlc11_incident_neo_encounter_at_sea_2_b"},
     ["wh2_main_incident_encounter_at_sea_2_c"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_2_c", 10, 30, "wh2_dlc11_incident_neo_encounter_at_sea_2_c"},
     ["wh2_main_incident_encounter_at_sea_3_a"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_3_a", 10, 30, "wh2_dlc11_incident_neo_encounter_at_sea_3_a"},
     ["wh2_main_incident_encounter_at_sea_3_b"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_3_b", 10, 30, "wh2_dlc11_incident_neo_encounter_at_sea_3_b"},
     ["wh2_main_incident_encounter_at_sea_3_c"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_3_c", 10, 30, "wh2_dlc11_incident_neo_encounter_at_sea_3_c"},
     ["wh2_main_incident_encounter_at_sea_4_a"] = {"wh2_dlc11_dilemma_neo_encounter_at_sea_4_a", 16, 50, "wh2_dlc11_incident_neo_encounter_at_sea_4_a"}
};

-- table of active encounters. this is populated when they spawn and then saved and loaded
local encounter_sea_spots = {};

-- percentage of locations that will be filled with encounters at the start of the game
local encounter_number_start = 17;

-- percentage of locations that will be filled with encounters each time they are respawned
local encounter_number_per_turn = 3;

-- percentage of active encounters that can be battle type
local encounter_number_battle = 45;

-- turn interval to respawn encounters
local encounter_respawn_turn_interval = 5;

-- opponent faction role
local sea_encounter_foe_roll;
local base_die_roll = 96;
local modded_die_roll = 0;
local upperbound1 = 0;
local upperbound2 = 0;

---Vac's find mods functions
function isTEBHere()
     if core:is_mod_loaded("cataph_teb_stuff") == true then
          out("TEB detected");
          return true
     else
          out("TEB not detected");
          return false
     end
end

function isAislinnhere()
     if core:is_mod_loaded("cataph_aislinn") == true then
          out("Sea Patrol detected");
          return true
     else
          out("Sea Patrol not detected");
          return false
     end
end

function setup_encounters_at_sea_listeners()
     local sea_encounter_battle_active = cm:get_saved_value("sea_encounter_battle_active");

     if sea_encounter_battle_active then
          add_encounter_postbattle_cleanup_listener(sea_encounter_battle_active[1], cm:get_faction(sea_encounter_battle_active[2]));
     end

     local TEB_die_mod = 0;
     local Aislinn_die_mod = 0;

     if isTEBHere() == true then TEB_die_mod = 15; end

     if isAislinnhere() == true then Aislinn_die_mod = 3; end

     upperbound1 = base_die_roll + TEB_die_mod;
     upperbound2 = upperbound1 + Aislinn_die_mod;

     modded_die_roll = base_die_roll + TEB_die_mod + Aislinn_die_mod;
     out("Modded die roll has " .. modded_die_roll .. " options");

     sea_encounter_foe_roll = cm:random_number(modded_die_roll);
     out("encounter roll is " .. sea_encounter_foe_roll);

     if sea_encounter_foe_roll <= 10 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_zombie_deckhands_mob_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_zombie_deckhands_mob_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_zombie_gunnery_mob_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_zombie_gunnery_mob_2", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_art_carronade", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_art_mortar", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_depth_guard_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_depth_guard_1", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_mon_rotting_leviathan_0", 1);
     end
     if sea_encounter_foe_roll > 10 and sea_encounter_foe_roll <= 20 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_art_queen_bess", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_cha_gunnery_wight_0", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_sartosa_militia_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_sartosa_free_company_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_syreens", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_art_mortar", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_depth_guard_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_depth_guard_1", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_mon_animated_hulks_0", 1);
     end
     if sea_encounter_foe_roll > 20 and sea_encounter_foe_roll <= 30 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_mon_necrofex_colossus_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_mon_rotting_prometheans_gunnery_mob_0", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_mon_terrorgheist", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_mon_mournguls_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_deck_gunners_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_art_mortar", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_syreens", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_cav_deck_droppers_2", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_cha_gunnery_wight_1", 1);
     end
     if sea_encounter_foe_roll > 30 and sea_encounter_foe_roll <= 40 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_mon_necrofex_colossus_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_inf_zombie_deckhands_mob_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_cha_vampire_fleet_captain_death_0", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc11_cst_mon_mournguls_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_cha_mourngul_haunter", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_art_mortar", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_inf_zombie_gunnery_mob_3", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_cav_deck_droppers_2", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc11_cst_mon_rotting_prometheans_0", 1);
     end
     if sea_encounter_foe_roll > 40 and sea_encounter_foe_roll <= 53 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_def_inf_dreadspears_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_def_inf_harpies", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_def_inf_darkshards_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_def_inf_black_ark_corsairs_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc10_def_mon_feral_manticore_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_def_mon_black_dragon", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_def_inf_black_ark_corsairs_1", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc10_def_mon_kharibdyss_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_def_cav_cold_one_chariot", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_def_cha_sorceress_dark_1", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_def_inf_bleakswords_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_main_def_cav_dark_riders_0", 2);
     end
     if sea_encounter_foe_roll > 53 and sea_encounter_foe_roll <= 66 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc08_nor_inf_marauder_hunters_1", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc08_nor_inf_marauder_berserkers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_inf_marauder_hunters_1", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_inf_marauder_hunters_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_feral_manticore", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_cha_skin_wolf_werekin_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_mon_skinwolves_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_inf_marauder_berserkers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_nor_inf_chaos_marauders_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_nor_inf_chaos_marauders_1", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_inf_marauder_champions_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_inf_marauder_champions_1", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_nor_mon_chaos_warhounds_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_inf_marauder_spearman_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_mon_frost_wyrm_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc08_nor_cav_marauder_horsemasters_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_nor_cav_marauder_horsemen_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_nor_cav_marauder_horsemen_1", 1);
     end
     if sea_encounter_foe_roll > 66 and sea_encounter_foe_roll <= 69 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_ogr_inf_gnoblars_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_ogr_inf_gnoblars_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_ogr_inf_maneaters_0", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_ogr_inf_maneaters_3", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_cha_butcher_beasts_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_cha_firebelly_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_cha_hunter_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_veh_gnoblar_scraplauncher_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_veh_ironblaster_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_mon_gorgers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_mon_stonehorn_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_mon_giant_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_cav_mournfang_cavalry_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_cav_mournfang_cavalry_2", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_mon_sabretusk_pack_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_inf_ironguts_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_inf_leadbelchers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_inf_maneaters_1", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_ogr_inf_maneaters_2", 2);
     end
     if sea_encounter_foe_roll > 69 and sea_encounter_foe_roll <= 72 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_skv_inf_skavenslaves_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_skv_inf_skavenslave_slingers_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_skv_inf_clanrats_1", 1)
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc12_skv_inf_warplock_jezzails_0", 1)
          random_army_manager:add_unit("encounter_force", "wh2_dlc16_skv_cha_packmaster_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_skv_inf_skavenslaves_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_main_skv_inf_skavenslave_slingers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc12_skv_inf_warplock_jezzails_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc12_skv_inf_ratling_gun_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_skv_art_plagueclaw_catapult", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_skv_art_warp_lightning_cannon", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_skv_mon_rat_ogres", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc16_skv_mon_brood_horror_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc14_skv_inf_poison_wind_mortar_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_main_skv_inf_death_runners_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_skv_inf_plague_monks", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_skv_inf_night_runners_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_skv_inf_night_runners_1", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_skv_inf_gutter_runner_slingers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc16_skv_mon_wolf_rats_0", 1);
     end
     if sea_encounter_foe_roll > 72 and sea_encounter_foe_roll <= 75 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc06_grn_inf_nasty_skulkers_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_grn_art_doom_diver_catapult", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc06_grn_inf_nasty_skulkers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_grn_art_doom_diver_catapult", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_grn_inf_orc_boyz", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_grn_inf_orc_arrer_boyz", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_grn_art_goblin_rock_lobber", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_grn_cha_goblin_big_boss_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_grn_inf_goblin_spearmen", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_grn_inf_orc_big_uns", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_grn_inf_goblin_archers", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc15_grn_veh_snotling_pump_wagon_roller_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc15_grn_veh_snotling_pump_wagon_flappas_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc06_grn_cav_squig_hoppers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_grn_cav_orc_boar_boy_big_uns", 1);
     end
     if sea_encounter_foe_roll > 75 and sea_encounter_foe_roll <= 78 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_hef_inf_lothern_sea_guard_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_hef_inf_lothern_sea_guard_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_hef_inf_spearmen_0", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_hef_inf_archers_1", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_hef_art_eagle_claw_bolt_thrower", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_cha_mage_life_4", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc15_hef_cha_mage_fire_2", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_art_eagle_claw_bolt_thrower", 2);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_mon_great_eagle", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc15_hef_inf_rangers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_cav_ellyrian_reavers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_cav_tiranoc_chariot", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_cav_ithilmar_chariot", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_cav_ellyrian_reavers_1", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_mon_moon_dragon", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_mon_phoenix_flamespyre", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc15_hef_mon_war_lions_of_chrace_0", 1);
     end
     if sea_encounter_foe_roll > 78 and sea_encounter_foe_roll <= 81 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_emp_inf_swordsmen", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_emp_inf_crossbowmen", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_emp_art_mortar", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc05_emp_cha_wizard_shadows_1", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc13_emp_veh_war_wagon_1", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_emp_cha_warrior_priest_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_emp_art_great_cannon", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_emp_cav_demigryph_knights_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_emp_inf_handgunners", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc04_emp_inf_flagellants_0", 3);
          random_army_manager:add_unit("encounter_force", "wh_main_emp_inf_greatswords", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_emp_inf_halberdiers", 3);
          random_army_manager:add_unit("encounter_force", "wh_main_emp_art_helblaster_volley_gun", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_emp_inf_spearmen_1", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_emp_inf_spearmen_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc13_emp_inf_archers_0", 2);
     end
     if sea_encounter_foe_roll == 82 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_cth_inf_peasant_spearmen_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_cth_inf_peasant_archers_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_cth_inf_jade_warriors_1", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_cth_inf_jade_warrior_crossbowmen_1", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_cth_cha_astromancer_2", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_cth_cav_jade_lancers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_cth_veh_sky_junk_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_cth_art_fire_rain_rocket_battery_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_cth_veh_sky_lantern_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_cth_inf_jade_warriors_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_cth_art_grand_cannon_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_cth_inf_jade_warrior_crossbowmen_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_cth_veh_war_compass_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_cth_cav_jade_longma_riders_0", 1);
     end
     if sea_encounter_foe_roll == 83 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_chs_inf_chaos_marauders_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_chs_inf_chaos_warriors_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_chs_cav_marauder_horsemen_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_chs_cha_exalted_hero_12", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_chs_cha_chaos_sorcerer_metal_10", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_cha_chaos_sorcerer_tzeentch_mtze_disc", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_cha_chaos_sorcerer_lord_death_mnur_warshrine", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc01_chs_cav_gorebeast_chariot", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_chs_cav_chaos_chariot", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_chs_cav_chaos_knights_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc01_chs_inf_chaos_warriors_2", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc01_chs_inf_chosen_2", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc01_chs_inf_forsaken_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc06_chs_inf_aspiring_champions_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_chs_inf_chaos_marauders_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_chs_inf_chaos_warriors_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_chs_inf_chosen_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc06_chs_cav_marauder_horsemasters_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_chs_cav_marauder_horsemen_1", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc01_chs_mon_dragon_ogre_shaggoth", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc06_chs_feral_manticore", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc01_chs_mon_dragon_ogre", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_chs_mon_chaos_spawn", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc01_chs_mon_trolls_1", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_chs_mon_trolls", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_chs_mon_chaos_warhounds_1", 2);
     end
     if sea_encounter_foe_roll == 84 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_dwf_inf_slayers", 3);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_dwf_inf_quarrellers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_dwf_cha_rune_smith_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc10_dwf_inf_giant_slayers", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_dwf_inf_dwarf_warrior_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc06_dwf_inf_rangers_1", 3);
          random_army_manager:add_unit("encounter_force", "wh_main_dwf_inf_thunderers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_dwf_inf_quarrellers_0", 3);
          random_army_manager:add_unit("encounter_force", "wh_dlc06_dwf_inf_rangers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_dwf_veh_gyrocopter_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_dwf_veh_gyrocopter_1", 2);
     end
     if sea_encounter_foe_roll == 85 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_dlc20_chs_cha_exalted_hero_mkho_juggernaut", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_kho_veh_skullcannon_0", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_dlc20_chs_inf_chaos_marauders_mkho_dualweapons", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_kho_inf_chaos_warhounds_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_kho_inf_bloodletters_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_kho_inf_bloodletters_1", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_cav_chaos_knights_mkho_lances", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_kho_inf_chaos_warriors_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_kho_inf_chaos_warriors_1", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_kho_inf_chaos_warriors_2", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_cav_marauder_horsemen_mkho_throwing_axes", 3);
          random_army_manager:add_unit("encounter_force", "wh3_main_kho_cav_bloodcrushers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_pro_kho_inf_chaos_furies_0", 3);
          random_army_manager:add_unit("encounter_force", "wh3_main_kho_inf_flesh_hounds_of_khorne_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_kho_veh_skullcannon_0", 1);
     end
     if sea_encounter_foe_roll == 86 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_ksl_inf_kossars_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_ksl_inf_kossars_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_ksl_inf_armoured_kossars_1", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_ksl_cha_frost_maiden_tempest_2", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ksl_veh_heavy_war_sled_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ksl_veh_light_war_sled_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_ksl_cav_horse_raiders_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_ksl_cav_winged_lancers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ksl_inf_tzar_guard_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ksl_cav_horse_archers_0", 3);
          random_army_manager:add_unit("encounter_force", "wh3_main_ksl_inf_ice_guard_1", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_ksl_mon_snow_leopard_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_ksl_cav_war_bear_riders_1", 1);
     end
     if sea_encounter_foe_roll == 87 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_lzd_inf_saurus_spearmen_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_lzd_inf_skink_cohort_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc12_lzd_mon_bastiladon_3", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc17_lzd_cha_skink_oracle_troglodon_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_lzd_cha_skink_priest_heavens_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_lzd_cav_cold_ones_feral_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_main_lzd_inf_saurus_warriors_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc13_lzd_mon_razordon_pack_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc17_lzd_inf_chameleon_stalkers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_lzd_inf_skink_skirmishers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc17_lzd_mon_troglodon_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_lzd_cav_terradon_riders_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_main_lzd_mon_bastiladon_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_lzd_mon_kroxigors", 1);
     end
     if sea_encounter_foe_roll == 88 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_dlc20_chs_cha_exalted_hero_mnur_chaos_chariot", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_nur_cha_plagueridden_nurgle_1", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_nur_inf_nurglings_0", 3);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_dlc20_chs_inf_chaos_marauders_mnur_greatweapons", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_cav_chaos_chariot_mnur", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_nur_cha_cultist_mnur_warshrine", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_cav_chaos_knights_mnur", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_nur_cav_pox_riders_of_nurgle_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_inf_chaos_warriors_mnur_greatweapons", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_inf_chosen_mnur_greatweapons", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_nur_inf_forsaken_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_nur_inf_plaguebearers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_nur_inf_plaguebearers_1", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_nur_mon_plague_toads_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_nur_mon_great_unclean_one_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_nur_inf_chaos_furies_0", 3);
     end
     if sea_encounter_foe_roll == 89 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_sla_veh_exalted_seeker_chariot_0", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_sla_veh_hellflayer_0", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_sla_cha_alluress_slaanesh_2", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_cav_chaos_knights_msla_lances", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_cav_marauder_horsemen_msla_javelins", 3);
          random_army_manager:add_unit("encounter_force", "wh3_main_sla_cav_heartseekers_of_slaanesh_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_sla_cav_hellstriders_1", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_inf_chaos_marauders_msla_hellscourges", 3);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_inf_chaos_warriors_msla_hellscourges", 3);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_inf_forsaken_msla", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_sla_inf_daemonette_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_sla_inf_daemonette_1", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_mon_warshrine_msla", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_sla_mon_keeper_of_secrets_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_sla_inf_chaos_furies_0", 3);
          random_army_manager:add_unit("encounter_force", "wh3_main_sla_mon_fiends_of_slaanesh_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_sla_mon_spawn_of_slaanesh_0", 1);
     end
     if sea_encounter_foe_roll == 90 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_dlc20_chs_cha_chaos_sorcerer_tzeentch_mtze_disc", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_tze_inf_pink_horrors_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_main_tze_inf_blue_horrors_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_dlc20_chs_inf_chaos_marauders_mtze_spears", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_tze_inf_blue_horrors_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_tze_inf_pink_horrors_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_inf_chaos_marauders_mtze", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_cav_marauder_horsemen_mtze_javelins", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_cav_chaos_knights_mtze_lances", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_inf_chaos_warriors_mtze_halberds", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_tze_mon_soul_grinder_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc20_chs_mon_warshrine_mtze", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_tze_mon_exalted_flamers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_tze_cav_doom_knights_0", 1);
          random_army_manager:add_unit("encounter_force", "wh3_main_tze_inf_chaos_furies_0", 3);
          random_army_manager:add_unit("encounter_force", "wh3_main_tze_mon_flamers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh3_main_tze_mon_screamers_0", 1);
     end
     if sea_encounter_foe_roll == 91 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_vmp_cha_vampire_1", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc04_vmp_veh_mortis_engine_0", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_vmp_inf_skeleton_warriors_1", 4);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_vmp_inf_zombie", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_vmp_cav_black_knights_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_vmp_cav_hexwraiths", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_vmp_inf_crypt_ghouls", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_vmp_mon_terrorgheist", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_vmp_mon_varghulf", 1);
          random_army_manager:add_unit("encounter_force", "wh_main_vmp_mon_crypt_horrors", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_vmp_mon_dire_wolves", 3);
          random_army_manager:add_unit("encounter_force", "wh_main_vmp_veh_black_coach", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc04_vmp_veh_corpse_cart_2", 1);
     end
     if sea_encounter_foe_roll == 92 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc05_wef_inf_eternal_guard_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc05_wef_inf_glade_guard_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc05_wef_inf_deepwood_scouts_1", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc05_wef_inf_glade_guard_1", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc05_wef_inf_glade_guard_2", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc05_wef_inf_wardancers_1", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc05_wef_inf_waywatchers_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc16_wef_mon_hawks_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc16_wef_mon_malicious_treekin_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc16_wef_inf_malicious_dryads_0", 3);
          random_army_manager:add_unit("encounter_force", "wh_dlc05_wef_cha_spellsinger_life_1", 1);
     end
     if sea_encounter_foe_roll == 93 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc17_bst_cha_bray_shaman_wild_2", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc03_bst_inf_gor_herd_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc03_bst_inf_cygor_0", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc03_bst_inf_centigors_1", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc17_bst_cha_wargor_2", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc17_bst_cav_tuskgor_chariot_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc17_bst_mon_ghorgon_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc03_bst_inf_razorgor_herd_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc03_bst_inf_minotaurs_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc05_bst_mon_harpies_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc03_bst_inf_ungor_raiders_0", 3);
          random_army_manager:add_unit("encounter_force", "wh_dlc03_bst_inf_chaos_warhounds_0", 2);
     end
     if sea_encounter_foe_roll == 94 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_dlc23_chd_cha_daemonsmith_sorcerer_death_bale_taurus", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_dlc23_chd_inf_hobgoblin_cutthroats", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_dlc23_chd_inf_chaos_dwarf_blunderbusses", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh3_dlc23_chd_inf_hobgoblin_sneaky_gits", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_inf_chaos_dwarf_warriors", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_inf_goblin_labourers", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_inf_chaos_dwarf_warriors_great_weapons", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_inf_chaos_dwarf_blunderbusses", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_inf_infernal_guard_fireglaives", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_inf_hobgoblin_archers", 4);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_inf_hobgoblin_cutthroats", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_mon_great_taurus", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_veh_dreadquake_mortar", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_veh_magma_cannon", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_veh_skullcracker", 1);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_cav_bull_centaurs_dual_axe", 2);
          random_army_manager:add_unit("encounter_force", "wh3_dlc23_chd_inf_infernal_ironsworn", 1);
     end
     if sea_encounter_foe_roll == 95 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc09_tmb_cha_necrotect_1", 1);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc09_tmb_inf_nehekhara_warriors_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_dlc09_tmb_inf_skeleton_archers_0", 4);
          random_army_manager:add_unit("encounter_force", "wh2_dlc09_tmb_cha_tomb_prince_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc09_tmb_inf_nehekhara_warriors_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc09_tmb_inf_skeleton_spearmen_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc09_tmb_mon_heirotitan_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc09_tmb_mon_tomb_scorpion_0", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc09_tmb_cav_necropolis_knights_1", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc09_tmb_mon_sepulchral_stalkers_0", 2);
          random_army_manager:add_unit("encounter_force", "wh2_dlc09_tmb_mon_ushabti_0", 3);
          random_army_manager:add_unit("encounter_force", "wh2_dlc09_tmb_mon_carrion_0", 2);
     end
     if sea_encounter_foe_roll == 96 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "wh_main_brt_inf_peasant_bowmen", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc07_brt_cav_knights_errant_0", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc07_brt_inf_battle_pilgrims_0", 4);
          random_army_manager:add_mandatory_unit("encounter_force", "wh_dlc07_brt_cav_knights_errant_0", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_brt_art_field_trebuchet", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc07_brt_inf_peasant_bowmen_1", 2);
          random_army_manager:add_unit("encounter_force", "wh_main_brt_cav_pegasus_knights", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc07_brt_art_blessed_field_trebuchet_0", 1);
          random_army_manager:add_unit("encounter_force", "wh_dlc07_brt_inf_peasant_bowmen_2", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc07_brt_inf_men_at_arms_2", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc07_brt_inf_foot_squires_0", 3);
          random_army_manager:add_unit("encounter_force", "wh_main_brt_cav_knights_of_the_realm", 2);
          random_army_manager:add_unit("encounter_force", "wh_dlc07_brt_inf_grail_reliquae_0", 1);
     end
     if isTEBHere() == true and sea_encounter_foe_roll > 96 and sea_encounter_foe_roll <= 109 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "teb_conqui_adventurers", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "teb_billmen", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "teb_xbowmen", 2);
          random_army_manager:add_unit("encounter_force", "teb_light_cannon", 1);
          random_army_manager:add_unit("encounter_force", "teb_noble_retinue", 1);
          random_army_manager:add_unit("encounter_force", "teb_xbow_cav", 2);
          random_army_manager:add_unit("encounter_force", "teb_merc_captain_barded_horse", 1);
          random_army_manager:add_unit("encounter_force", "teb_handgunners", 2);
          random_army_manager:add_unit("encounter_force", "teb_conqui_lancers", 2);
          random_army_manager:add_unit("encounter_force", "teb_conqui_riders", 1);
          random_army_manager:add_unit("encounter_force", "teb_paymaster", 1);
     end
     if isTEBHere() == true and sea_encounter_foe_roll == 110 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "teb_republican_guard", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "teb_pikemen", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "teb_xbowmen", 2);
          random_army_manager:add_unit("encounter_force", "teb_light_cannon", 1);
          random_army_manager:add_unit("encounter_force", "teb_encarmine", 1);
          random_army_manager:add_unit("encounter_force", "teb_xbow_cav", 2);
          random_army_manager:add_unit("encounter_force", "teb_priestess_horse", 1);
          random_army_manager:add_unit("encounter_force", "teb_handgunners", 2);
          random_army_manager:add_unit("encounter_force", "teb_carabiniers", 2);
          random_army_manager:add_unit("encounter_force", "teb_galloper", 1);
          random_army_manager:add_unit("encounter_force", "teb_paymaster", 1);
     end
     if isTEBHere() == true and sea_encounter_foe_roll == 111 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "teb_duellists", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "teb_billmen", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "teb_border_rangers", 2);
          random_army_manager:add_unit("encounter_force", "teb_light_cannon", 1);
          random_army_manager:add_unit("encounter_force", "teb_freelance_knights", 1);
          random_army_manager:add_unit("encounter_force", "teb_xbow_cav", 2);
          random_army_manager:add_unit("encounter_force", "teb_enforcers", 1);
          random_army_manager:add_unit("encounter_force", "teb_handgunners", 2);
          random_army_manager:add_unit("encounter_force", "teb_shieldbearers", 2);
          random_army_manager:add_unit("encounter_force", "teb_tank", 1);
          random_army_manager:add_unit("encounter_force", "teb_freelance_knights", 1);
     end
     if isAislinnhere() == true and sea_encounter_foe_roll > upperbound1 and sea_encounter_foe_roll <= upperbound2 then
          random_army_manager:new_force("encounter_force");
          random_army_manager:add_mandatory_unit("encounter_force", "AK_hef_sea_rangers", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_hef_inf_lothern_sea_guard_1", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "AK_hef_sea_company", 2);
          random_army_manager:add_mandatory_unit("encounter_force", "wh2_main_hef_art_eagle_claw_bolt_thrower", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc15_hef_cha_mage_beasts_2", 1);
          random_army_manager:add_unit("encounter_force", "AK_hef_sea_roc_riders", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_art_eagle_claw_bolt_thrower", 2);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_mon_great_eagle", 2);
          random_army_manager:add_unit("encounter_force", "AK_hef_sea_silver", 1);
          random_army_manager:add_unit("encounter_force", "AK_hef_sea_roc_riders", 1);
          random_army_manager:add_unit("encounter_force", "AKcr_hef_skycutter", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_mon_sun_dragon", 1);
          random_army_manager:add_unit("encounter_force", "wh2_main_hef_mon_phoenix_frostheart", 1);
          random_army_manager:add_unit("encounter_force", "wh2_dlc15_hef_inf_silverin_guard_0", 1);
     end

     -- spawn the encounters on turn 1, then respawn every so many turns
     core:add_listener("faction_turn_start_populate_sea_spots", "WorldStartRound", true, function()
          local turn_number = cm:model():turn_number();

          if turn_number == 1 then
               local campaign_set = encounter_sea_location_set[cm:get_campaign_name()];
               local chosen_coordinate_set = campaign_set[cm:random_number(#campaign_set)];

               for i = 1, #chosen_coordinate_set do
                    local spot = {["index"] = i, ["location"] = chosen_coordinate_set[i], ["occupied"] = "not", ["cooldown"] = 0};

                    table.insert(encounter_sea_spots, spot);
               end

               local encounters_to_spawn = math.floor((encounter_number_start / 100) * #encounter_sea_spots);

               populate_sea_spots("battle", encounters_to_spawn);
               populate_sea_spots("marker", encounters_to_spawn);
          elseif turn_number % encounter_respawn_turn_interval == 0 then
               for i = 1, #encounter_sea_spots do
                    local cooldown = encounter_sea_spots[i]["cooldown"];

                    if cooldown and cooldown > 0 then encounter_sea_spots[i]["cooldown"] = cooldown - 1; end
               end

               local encounters_to_spawn = math.floor((encounter_number_per_turn / 100) * #encounter_sea_spots)

               -- check if we have capacity to spawn more battle encounters
               local number_of_occupied_encounters_with_battle_events = 0;

               for i = 1, #encounter_sea_spots do
                    if encounter_sea_spots[i]["occupied"] == "battle" then
                         number_of_occupied_encounters_with_battle_events = number_of_occupied_encounters_with_battle_events + 1;
                    end
               end

               if number_of_occupied_encounters_with_battle_events < math.floor((encounter_number_battle / 100) * #encounter_sea_spots) then
                    populate_sea_spots("battle", encounters_to_spawn);
               end

               populate_sea_spots("marker", encounters_to_spawn);
          end
     end, true);

     -- handle an encounter being entered
     core:add_listener("area_entered_trigger_encounter_at_sea", "AreaEntered", function(context)
          local character = context:family_member():character();
          return not character:is_null_interface() and context:area_key():starts_with("test_marker_") and cm:char_is_general_with_army(character);
     end, function(context)
          local area_key = context:area_key();
          local index = tonumber(string.sub(area_key, 13));
          local active_encounter = encounter_sea_spots[index];
          local battle_incident = false;

          local character = context:family_member():character();
          local mf = character:military_force();
          local faction = character:faction();
          local faction_name = faction:name();
          local faction_cqi = faction:command_queue_index();
          local remove_encounter = true;
          local dilemma_triggered = false;

          if faction:is_human() and faction:is_factions_turn() then
               if faction_name == "wh2_dlc15_grn_broken_axe" then core:trigger_event("ScriptEventSeaEncounterTriggeredByPlayerThatIsPlayingGrom") end

               if active_encounter["occupied"] == "battle" then
                    battle_incident = active_encounter["event"];

                    -- the dilemma is only triggered if the character is in default stance, otherwise a generic event fires and the encounter isn't removed
                    if mf:active_stance() == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_DEFAULT" then
                         cm:cancel_actions_for(character);
                         dilemma_triggered = cm:trigger_dilemma_with_targets(faction_cqi, encounter_events_battle_details[battle_incident][1], faction_cqi, 0,
                                                                             character:command_queue_index(), mf:command_queue_index(), 0, 0);
                    else
                         remove_encounter = false;

                         cm:show_message_event_located(faction_name,
                                                       "event_feed_strings_text_wh2_dlc11_event_feed_string_scripted_event_passing_by_sea_encounter_title",
                                                       "event_feed_strings_text_wh2_dlc11_event_feed_string_scripted_event_passing_by_sea_encounter_primary_details",
                                                       "event_feed_strings_text_wh2_dlc11_event_feed_string_scripted_event_passing_by_sea_encounter_secondary_details",
                                                       active_encounter["location"][1], active_encounter["location"][2], false, 1017);
                    end
               else
                    dilemma_triggered = cm:trigger_dilemma_with_targets(faction_cqi, active_encounter["event"], faction_cqi, 0, character:command_queue_index(),
                                                                        mf:command_queue_index(), 0, 0);
               end

               -- handle followup events after making a dilemma choice
               if dilemma_triggered then
                    core:add_listener("dilemma_choice_made_event_trigger_counter_at_sea_incident", "DilemmaChoiceMadeEvent", true, function(context)
                         local dilemma = context:dilemma();
                         local choice = context:choice();

                         -- for dilemmas with just followup incidents
                         for event_key, event_details in pairs(encounter_events_details) do
                              if event_details["category"] == "marker" then
                                   for i = 1, #event_details["variation"] do
                                        if dilemma == event_key .. event_details["variation"][i] then
                                             local choice_index = choice + 1;

                                             trigger_encounter_followup_incident(character, event_details["followup_incidents"][choice_index][cm:random_number(
                                                                                      #event_details["followup_incidents"][choice_index])]);
                                             return;
                                        end
                                   end
                              end
                         end

                         -- for dilemmas with battles
                         for k, battle_data in pairs(encounter_events_battle_details) do
                              if dilemma == battle_data[1] then
                                   if choice == 0 then
                                        local x, y = cm:find_valid_spawn_location_for_character_from_position(faction:name(), active_encounter["location"][1],
                                                                                                              active_encounter["location"][2], false);

                                        cm:set_saved_value("sea_encounter_battle_active", {battle_incident, faction_name});
                                        generate_sea_encounter_invasion(character, {x, y}, encounter_events_battle_details[battle_incident][2]);
                                        add_encounter_postbattle_cleanup_listener(battle_incident, faction);
                                        return;
                                   else
                                        trigger_encounter_followup_incident(character, encounter_events_battle_details[battle_incident][4]);
                                        return;
                                   end
                              end
                         end
                    end, false);
               end
          end

          if remove_encounter then
               cm:remove_interactable_campaign_marker(area_key);
               active_encounter["occupied"] = "not";
               active_encounter["cooldown"] = 8;
               active_encounter["model"] = 0;
          end
     end, true);
end

-- handle spawning encounters
function populate_sea_spots(category, number_of_spots)
     -- build a table of empty positions not on a cooldown
     local available_spots = {};

     if #encounter_sea_spots > 0 then
          for i = 1, #encounter_sea_spots do
               if encounter_sea_spots[i]["cooldown"] == 0 and encounter_sea_spots[i]["occupied"] == "not" then
                    table.insert(available_spots, encounter_sea_spots[i]["index"]);
               end
          end
     end

     if number_of_spots > 0 and #available_spots >= number_of_spots then
          for i = 1, number_of_spots do
               local index = cm:random_number(#available_spots);
               local selected_spot = encounter_sea_spots[available_spots[index]];
               local is_northern_spot = selected_spot["location"][2] > 438 or cm:get_campaign_name() == "wh3_main_chaos";

               -- pick an event that has a valid model for the selected position. 1-17 are used in the south of the map, 18-32 are used in the north
               local events_to_select = {};

               for event_key, event_details in pairs(encounter_events_details) do
                    if event_details["category"] == category then
                         for j = 1, #event_details["model"] do
                              local current_model = event_details["model"][j];

                              if is_northern_spot and current_model > 17 then
                                   table.insert(events_to_select, event_key);
                                   break
                              elseif not is_northern_spot and current_model <= 17 then
                                   table.insert(events_to_select, event_key);
                                   break
                              end
                         end
                    end
               end

               local event_key = events_to_select[cm:random_number(#events_to_select)];
               local selected_event = encounter_events_details[event_key];

               -- build a list of valid models for the selected position
               local models_to_select = {};

               for j = 1, #selected_event["model"] do
                    local current_model = selected_event["model"][j];

                    if is_northern_spot and current_model > 17 then
                         table.insert(models_to_select, current_model);
                    elseif not is_northern_spot and current_model <= 17 then
                         table.insert(models_to_select, current_model);
                    end
               end

               local model_index = models_to_select[cm:random_number(#models_to_select)];

               selected_spot["occupied"] = category;

               cm:add_interactable_campaign_marker("test_marker_" .. selected_spot["index"], "encounter_marker_" .. tostring(model_index),
                                                   selected_spot["location"][1], selected_spot["location"][2], 4, "", "");

               selected_spot["model"] = model_index;

               selected_spot["event"] = event_key .. selected_event["variation"][cm:random_number(#selected_event["variation"])];

               table.remove(available_spots, index);
          end
     end
end

function trigger_encounter_followup_incident(character, incident)
     local faction = character:faction();
     local faction_cqi = faction:command_queue_index();
     local culture = faction:culture();
     local character_cqi = character:command_queue_index();
     local force_cqi = character:military_force():command_queue_index();

     if culture == "wh2_dlc09_tmb_tomb_kings" then
          incident = incident .. "_tmb";
     elseif culture == "wh_dlc08_nor_norsca" then
          incident = incident .. "_nor";
     end

     cm:trigger_incident_with_targets(faction_cqi, incident, 0, 0, character_cqi, force_cqi, 0, 0);

     if encounter_events_battle_details[incident] then
          -- trigger extra loot event if the faction has a bonus value
          if faction:bonus_values():scripted_value("increase_sea_encounter_loot", "value") > 0 then
               cm:callback(function()
                    cm:trigger_incident_with_targets(faction_cqi, "wh2_dlc11_neo_counter_extra_loot", 0, 0, character_cqi, force_cqi, 0, 0);
               end, 0.5);
          end

          -- check treasure map drops
          if culture == "wh2_dlc11_cst_vampire_coast" then trigger_treasure_map_mission(faction:name(), encounter_events_battle_details[incident][3]) end
     end
end

-- handle cleanup post encounter battle
function add_encounter_postbattle_cleanup_listener(incident_if_player_wins, faction)
     core:add_listener("encounter_at_sea_postbattle_cleanup", "BattleCompleted", function() return cm:get_saved_value("sea_encounter_battle_active"); end,
                       function()
          local invasion = invasion_manager:get_invasion("encounter_invasion");

          if invasion then invasion:kill(); end

          cm:callback(function()
               cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "")
               cm:disable_event_feed_events(false, "wh_event_category_character", "", "")
          end, 1);

          local pb = cm:model():pending_battle();

          if cm:pending_battle_cache_defender_victory() and pb:has_defender() then
               trigger_encounter_followup_incident(pb:defender(), incident_if_player_wins);
          end

          cm:set_saved_value("sea_encounter_battle_active", false);
     end, false);

     -- safeguard - the following turn, kill any invasion if it was not destroyed during the encounter
     core:add_listener("pirate_encounter_removal", "FactionTurnStart", function() return invasion_manager:get_invasion("encounter_invasion"); end, function()
          cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
          cm:disable_event_feed_events(true, "wh_event_category_character", "", "");

          invasion_manager:get_invasion("encounter_invasion"):kill();

          cm:callback(function()
               cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "");
               cm:disable_event_feed_events(false, "wh_event_category_character", "", "");
          end, 1);

          cm:set_saved_value("sea_encounter_battle_active", false);
     end, false);
end

-- generate encounter pirates
function generate_sea_encounter_invasion(character, loc, army_size)
     local faction_name = character:faction():name();
     local mf = character:military_force();

     local force = random_army_manager:generate_force("encounter_force", army_size, false);

     local enemy_faction
     if sea_encounter_foe_roll < 41 then enemy_faction = "wh2_dlc11_cst_vampire_coast_encounters" end
     if sea_encounter_foe_roll > 40 and sea_encounter_foe_roll <= 53 then enemy_faction = "wh2_main_def_dark_elves_qb1" end
     if sea_encounter_foe_roll > 53 and sea_encounter_foe_roll <= 66 then enemy_faction = "wh2_dlc13_nor_norsca_invasion" end
     if sea_encounter_foe_roll > 66 and sea_encounter_foe_roll <= 69 then enemy_faction = "wh3_main_ogr_ogre_kingdoms_invasion" end
     if sea_encounter_foe_roll > 69 and sea_encounter_foe_roll <= 72 then enemy_faction = "wh2_dlc13_skv_skaven_invasion" end
     if sea_encounter_foe_roll > 72 and sea_encounter_foe_roll <= 75 then enemy_faction = "wh2_dlc13_grn_greenskins_invasion" end
     if sea_encounter_foe_roll > 75 and sea_encounter_foe_roll <= 78 then enemy_faction = "wh2_main_hef_high_elves_qb1" end
     if sea_encounter_foe_roll > 78 and sea_encounter_foe_roll <= 81 then enemy_faction = "wh2_dlc16_emp_empire_invasion" end
     if sea_encounter_foe_roll == 82 then enemy_faction = "wh3_main_cth_cathay_qb1" end
     if sea_encounter_foe_roll == 83 then enemy_faction = "wh2_main_chs_chaos_incursion_lzd" end
     if sea_encounter_foe_roll == 84 then enemy_faction = "wh_main_dwf_dwarfs_qb2" end
     if sea_encounter_foe_roll == 85 then enemy_faction = "wh3_main_kho_khorne_qb1" end
     if sea_encounter_foe_roll == 86 then enemy_faction = "wh3_main_ksl_kislev_qb1" end
     if sea_encounter_foe_roll == 87 then enemy_faction = "wh2_main_lzd_lizardmen_qb3" end
     if sea_encounter_foe_roll == 88 then enemy_faction = "wh3_main_nur_nurgle_qb1" end
     if sea_encounter_foe_roll == 89 then enemy_faction = "wh3_main_sla_slaanesh_qb1" end
     if sea_encounter_foe_roll == 90 then enemy_faction = "wh3_main_tze_tzeentch_invasion" end
     if sea_encounter_foe_roll == 91 then enemy_faction = "wh_main_vmp_vampire_counts_qb1" end
     if sea_encounter_foe_roll == 92 then enemy_faction = "wh2_dlc16_wef_wood_elves_qb6" end
     if sea_encounter_foe_roll == 93 then enemy_faction = "wh2_dlc13_bst_beastmen_invasion" end
     if sea_encounter_foe_roll == 94 then enemy_faction = "wh3_dlc23_chd_minor_faction" end
     if sea_encounter_foe_roll == 95 then enemy_faction = "wh2_dlc09_tmb_tombking_qb1" end
     if sea_encounter_foe_roll == 96 then enemy_faction = "wh_main_brt_bretonnia_qb1" end
     if isTEBHere() == true and sea_encounter_foe_roll > 96 and sea_encounter_foe_roll <= 111 then enemy_faction = "wh2_dlc16_emp_empire_invasion" end
     if isAislinnhere() == true and sea_encounter_foe_roll > upperbound1 and sea_encounter_foe_roll <= upperbound2 then
          enemy_faction = "wh2_main_hef_high_elves_qb1"
     end

     local invasion_1 = invasion_manager:new_invasion("encounter_invasion", enemy_faction, force, loc);
     invasion_1:set_target("CHARACTER", character:command_queue_index(), faction_name);

     invasion_1:apply_effect("wh_main_bundle_military_upkeep_free_force", -1);
     invasion_1:start_invasion(function(self)
          local force_leader = self:get_general();

          core:add_listener("pirate_encounter_engage", "FactionLeaderDeclaresWar", true, function(context)
               if context:character():faction():name() == enemy_faction then
                    if not force_leader:is_at_sea() then
                         script_error("Tried to spawn an army for an encounter at sea, but the army is on land - how can this be?");
                    end

                    cm:set_force_has_retreated_this_turn(mf);
                    cm:force_attack_of_opportunity(force_leader:military_force():command_queue_index(), mf:command_queue_index(), false);
               end
          end, false);

          cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
          cm:disable_event_feed_events(true, "wh_event_category_character", "", "");

          cm:force_declare_war(enemy_faction, faction_name, false, false);
     end, false, false, false);
end

cm:add_saving_game_callback(function(context) cm:save_named_value("encounter_sea_spots", encounter_sea_spots, context); end);

cm:add_loading_game_callback(function(context) encounter_sea_spots = cm:load_named_value("encounter_sea_spots", {}, context); end);
