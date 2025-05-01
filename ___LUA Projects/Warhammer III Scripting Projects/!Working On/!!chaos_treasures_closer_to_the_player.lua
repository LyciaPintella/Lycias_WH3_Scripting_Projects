-- Table that will be saved and loaded
items_poi_alt = { ["wh3_main_freiya1"] = { 0, 0, "false" } };

-- Main function
function chaos_treasures()
     if items_poi_alt["wh3_main_freiya1"][3] == "false" then
          local treasure_loc_all = {
               [1] = { 60, 835 },
               [2] = { 240, 895 },
               [3] = { 145, 743 },
               [4] = { 325, 800 },
               [5] = { 295, 705 },
               [6] = { 235, 565 },
               [7] = { 90, 638 },
               [8] = { 102, 450 },
               [9] = { 325, 385 },
               [10] = { 340, 185 },
               [11] = { 298, 45 },
               [12] = { 233, 154 },
               [13] = { 176, 296 },
               [14] = { 50, 130 },
               [15] = { 639, 516 },
               [16] = { 450, 545 },
               [17] = { 390, 520 },
               [18] = { 574, 656 },
               [19] = { 586, 782 },
               [20] = { 489, 820 },
               [21] = { 547, 903 },
               [22] = { 505, 115 },
               [23] = { 670, 55 },
               [24] = { 654, 198 },
               [25] = { 630, 300 },
               [26] = { 480, 285 },
               [27] = { 525, 360 },
               [28] = { 685, 393 },
               [29] = { 780, 825 },
               [30] = { 729, 652 },
               [31] = { 843, 711 },
               [32] = { 988, 795 },
               [33] = { 910, 585 },
               [34] = { 817, 490 },
               [35] = { 1060, 540 },
               [36] = { 1000, 430 },
               [37] = { 798, 408 },
               [38] = { 885, 360 },
               [39] = { 950, 260 },
               [40] = { 770, 295 },
               [41] = { 805, 170 },
               [42] = { 790, 30 },
               [43] = { 1255, 370 },
               [44] = { 1400, 460 },
               [45] = { 1222, 505 },
               [46] = { 1305, 595 },
               [47] = { 1370, 660 },
               [48] = { 1214, 697 },
               [49] = { 1110, 619 }
          };

          local treasure_list = {
               [1] = { "wh3_main_anc_weapon_gilellions_soulnetter" },
               [2] = { "wh3_main_anc_weapon_skars_kraken_killer" },
               [3] = { "wh3_main_anc_weapon_chainsword" },
               [4] = { "wh3_main_anc_weapon_the_bane_spear" },
               [5] = { "wh3_main_anc_follower_the_dark_princes_paramour" },
               [6] = { "wh3_main_anc_weapon_slaaneshs_blade" },
               [7] = { "wh3_main_anc_follower_personal_sycophant" }
          };

          -- Shuffle the treasure list to randomize which item is obtained at which location
          cm:shuffle_table(treasure_list);

          local faction = cm:get_local_faction();
          local faction_leader = faction:faction_leader();
          local freiya_pos_x = nil;
          local freiya_pos_y = nil;
          local capital = nil;

          -- Check if the faction has a settlement
          if faction:has_home_region() then
               -- Get the coordinates of the capital settlement
               capital = faction:home_region():settlement();
               local Settlement_name = capital:region():name();
               freiya_pos_x = capital:logical_position_x();
               freiya_pos_y = capital:logical_position_y();
          else
               -- If there is no settlement, check if the faction leader is on the map
               if faction_leader:has_military_force() then
                    -- Get the coordinates of the faction leader army
                    freiya_pos_x = faction_leader:logical_position_x();
                    freiya_pos_y = faction_leader:logical_position_y();
               else
                    -- If the faction leader isn't on the map, get the coordinates of any other general
                    local mf_list = faction:military_force_list();

                    for i = 0, mf_list:num_items() - 1 do
                         local current_mf = mf_list:item_at(i);

                         if current_mf:has_general() and not current_mf:is_armed_citizenry() then
                              local general = current_mf:general_character();
                              freiya_pos_x = general:logical_position_x();
                              freiya_pos_y = general:logical_position_y();
                              break;
                         end;
                    end;
               end;
          end;

          -- Measure the distance between each potential marker and the player's capital or faction leader or any random general
          for list_id, coords in pairs(treasure_loc_all) do
               local distance = distance_squared(freiya_pos_x, freiya_pos_y, coords[1], coords[2]);
               treasure_loc_all[list_id][3] = distance;
          end;

          -- Sort the markers table by distance
          table.sort(
               treasure_loc_all,
               function(a, b)
                    return a[3] < b[3];
               end
          );

          -- Create the table that will contain the coordinates for each treasure
          items_poi_alt = {
               ["wh3_main_freiya1"] = { treasure_loc_all[1][1], treasure_loc_all[1][2], treasure_list[1][1] },
               ["wh3_main_freiya2"] = { treasure_loc_all[2][1], treasure_loc_all[2][2], treasure_list[2][1] },
               ["wh3_main_freiya3"] = { treasure_loc_all[3][1], treasure_loc_all[3][2], treasure_list[3][1] },
               ["wh3_main_freiya4"] = { treasure_loc_all[4][1], treasure_loc_all[4][2], treasure_list[4][1] },
               ["wh3_main_freiya5"] = { treasure_loc_all[5][1], treasure_loc_all[5][2], treasure_list[5][1] },
               ["wh3_main_freiya6"] = { treasure_loc_all[6][1], treasure_loc_all[6][2], treasure_list[6][1] },
               ["wh3_main_freiya7"] = { treasure_loc_all[7][1], treasure_loc_all[7][2], treasure_list[7][1] }
          };
     end;

     local turn_count = cm:turn_number();
     -- If it's more than turn 30, just spawn all the treasures, otherwise wait for the turn 30 to happen
     -- search for bookmark to get the other one.
     if turn_count > 0 then
          -- Only add the marker if the item hasn't been already obtained
          for encounter_id, data in pairs(items_poi_alt) do
               --if not cm:model():world():ancillary_exists(data[3]) then
               if not cm:get_local_faction():ancillary_exists(data[3]) then
                    cm:remove_interactable_campaign_marker(encounter_id);
                    cm:add_interactable_campaign_marker(encounter_id, encounter_id, data[1], data[2], 3);
               end;
          end;
     else
          -- Wait for the turn 30
          core:add_listener(
               "chaos_treasure_listen",
               "WorldStartRound",
               true,
               function()
                    turn_count = cm:turn_number();
                    --bookmark
                    if turn_count == 1 then
                         -- Only add the marker if the item hasn't been already obtained
                         for encounter_id, data in pairs(items_poi_alt) do
                              --if not cm:model():world():ancillary_exists(data[3]) then
                              if not cm:get_local_faction():ancillary_exists(data[3]) then
                                   cm:remove_interactable_campaign_marker(encounter_id);
                                   cm:add_interactable_campaign_marker(encounter_id, encounter_id, data[1], data[2], 3);
                              end;
                         end;

                         local player_factions = cm:get_human_factions();
                         -- Display an event message to warn the player that treasures are now available
                         for i = 1, #player_factions do
                              cm:show_message_event(
                                   player_factions[i],
                                   "event_feed_strings_text_wh_event_feed_string_scripted_event_freiya_chaos_treasure_expanded_title",
                                   "",
                                   "event_feed_strings_text_wh_event_feed_string_scripted_event_freiya_chaos_treasure_expanded_description",
                                   true,
                                   165
                              );
                         end;
                    end;
               end,
               true
          );
     end;
end;

-- Check if a character enter any of the treasure markers
core:add_listener(
     "chaos_treasure_marker",
     "AreaEntered",
     function(context)
          local character = context:family_member():character();
          return not character:is_null_interface() and context:area_key():starts_with("wh3_main_freiya") and
          cm:char_is_general_with_army(character);
     end,
     function(context)
          local character = context:family_member():character();
          local faction = character:faction();

          -- Only the player and lords can get the treasures
          if character:is_null_interface() or not character:has_military_force() or not faction:is_human() then
               return;
          end;

          local mf = character:military_force();
          local faction_cqi = faction:command_queue_index();
          local dilemma_triggered = false;
          local area_key = context:area_key();

          cm:set_saved_value("chaos_treasure_active_marker", area_key);

          dilemma_triggered = cm:trigger_dilemma_with_targets(faction_cqi, "wh3_dilemma_chaos_treasures", faction_cqi, 0,
               character:command_queue_index(), mf:command_queue_index(), 0, 0);

          if dilemma_triggered then
               core:add_listener(
                    "dilemma_choice_made_event_trigger_chaos_treasure_incident",
                    "DilemmaChoiceMadeEvent",
                    true,
                    function(context)
                         local dilemma = context:dilemma();
                         local choice = context:choice();

                         if choice == 0 then
                              local x, y = cm:find_valid_spawn_location_for_character_from_position(faction:name(),
                                   items_poi_alt[area_key][1], items_poi_alt[area_key][2], false);

                              cm:remove_interactable_campaign_marker(area_key);
                              generate_chaos_treasure_invasion(character, { x, y }, cm:turn_number());
                         else
                              return;
                         end;
                    end,
                    false
               );
          end;
     end,
     true
);

-- Handle cleanup after the battle
core:add_listener(
     "chaos_treasure_postbattle_cleanup",
     "BattleCompleted",
     function()
          return cm:get_saved_value("chaos_treasure_battle_active");
     end,
     function()
          local invasion = invasion_manager:get_invasion("chaos_encounter_invasion");
          if invasion then
               cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
               cm:disable_event_feed_events(true, "wh_event_category_character", "", "");
               invasion:kill();
               invasion_manager:remove_invasion("chaos_encounter_invasion")
               cm:kill_all_armies_for_faction(cm:get_faction("wh_main_chs_chaos_qb3"))

               cm:callback(
                    function()
                         cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "");
                         cm:disable_event_feed_events(false, "wh_event_category_character", "", "");
                    end,
                    1
               );
          end;

          local pb = cm:model():pending_battle();

          if cm:pending_battle_cache_defender_victory() and pb:has_defender() then
               local area_key = cm:get_saved_value("chaos_treasure_active_marker");
               cm:add_ancillary_to_faction(cm:get_local_faction(), items_poi_alt[area_key][3], false);
               cm:remove_interactable_campaign_marker(area_key);
          end;
          cm:set_saved_value("chaos_treasure_battle_active", false);
          chaos_treasures()
     end,
     true
);

-- Generate the encounter battle
function generate_chaos_treasure_invasion(character, loc, turn)
     local faction_name = character:faction():name();
     local mf = character:military_force();
     local army_size = 20

     invasion_manager:remove_invasion("chaos_encounter_invasion")
     random_army_manager:remove_force("chaos_treasure_force")
     random_army_manager:new_force("chaos_treasure_force");

     if turn < 20 then
          army_size = 20
          -- C Tier
          random_army_manager:add_unit("chaos_treasure_force", "wh_dlc06_chs_inf_aspiring_champions_0", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chaos_warriors_mtze_halberds", 4);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_inf_chaos_warriors_1", 4);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_inf_chaos_warriors_2", 4);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_inf_bloodletters_1", 4);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_tze_inf_pink_horrors_1", 4);
          random_army_manager:add_unit("chaos_treasure_force", "wh_dlc01_chs_cav_gorebeast_chariot", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_veh_blood_shrine_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_veh_skullcannon_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_mon_warshrine", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh_dlc01_chs_mon_trolls_1", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_mon_spawn_of_khorne_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_tze_mon_spawn_of_tzeentch_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_art_hellcannon", 1);

          -- B Tier
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_inf_chosen_0", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_inf_chosen_1", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh_dlc01_chs_inf_chosen_2", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chosen_mkho", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chosen_mtze", 2);

          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_cav_chaos_knights_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_cav_chaos_knights_1", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_tze_cav_chaos_knights_0", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_cav_chaos_knights_mkho", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_cav_gorebeast_chariot", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_cav_bloodcrushers_0", 1);

          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_mon_warshrine_mkho", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_mon_warshrine_mtze", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_mon_giant", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_tze_mon_exalted_flamers_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_mon_khornataurs_0", 1);


          -- Tier 5
     elseif turn > 19 then
          army_size = 20
          -- B Tier
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_inf_chosen_0", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_inf_chosen_1", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh_dlc01_chs_inf_chosen_2", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chosen_mkho", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chosen_mnur", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chosen_msla", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chosen_mtze", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_sla_inf_daemonette_1", 5);
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_cav_chaos_knights_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_cav_chaos_knights_1", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_tze_cav_chaos_knights_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_cav_chaos_knights_mkho", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_cav_chaos_knights_mnur", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_cav_chaos_knights_msla", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_sla_cav_heartseekers_of_slaanesh_0", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_nur_cav_plague_drones_1", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_cav_gorebeast_chariot", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_cav_bloodcrushers_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_sla_veh_exalted_seeker_chariot_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_mon_warshrine_mkho", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_mon_warshrine_mnur", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_mon_warshrine_msla", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_mon_warshrine_mtze", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_mon_giant", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_tze_mon_exalted_flamers_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_sla_mon_fiends_of_slaanesh_0", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_mon_khornataurs_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh_main_chs_art_hellcannon", 1);


          -- A Tier
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chosen_mkho_dualweapons", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chosen_mnur_greatweapons", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chosen_msla_hellscourges", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_inf_chosen_mtze_halberds", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_cav_chaos_knights_mkho_lances", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_cav_chaos_knights_mnur_lances", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_cav_chaos_knights_msla_lances", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_dlc20_chs_cav_chaos_knights_mtze_lances", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_cav_skullcrushers_0", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_tze_cav_doom_knights_0", 3);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_tze_veh_burning_chariot_0", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_mon_bloodthirster_0", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh_dlc01_chs_mon_dragon_ogre", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh_dlc01_chs_mon_dragon_ogre_shaggoth", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_mon_khornataurs_1", 2);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_kho_mon_soul_grinder_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_nur_mon_soul_grinder_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_sla_mon_soul_grinder_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_sla_mon_keeper_of_secrets_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_nur_mon_great_unclean_one_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_tze_mon_lord_of_change_0", 1);
          random_army_manager:add_unit("chaos_treasure_force", "wh3_main_tze_mon_soul_grinder_0", 1);
     end;

     local force = random_army_manager:generate_force("chaos_treasure_force", army_size, false);
     local invasion_1 = invasion_manager:new_invasion("chaos_encounter_invasion", "wh_main_chs_chaos_qb3", force, loc);

     invasion_1:set_target("CHARACTER", character:command_queue_index(), faction_name);
     invasion_1:apply_effect("wh_main_bundle_military_upkeep_free_force", -1);
     invasion_1:start_invasion(
          function(self)
               local force_leader = self:get_general();

               core:add_listener(
                    "chaos_treasure_encounter_engage",
                    "FactionLeaderDeclaresWar",
                    true,
                    function(context)
                         if context:character():faction():name() == "wh_main_chs_chaos_qb3" then
                              cm:set_force_has_retreated_this_turn(mf);
                              cm:set_saved_value("chaos_treasure_battle_active", true);
                              cm:force_attack_of_opportunity(force_leader:military_force():command_queue_index(),
                                   mf:command_queue_index(), false);
                         end;
                    end,
                    false
               );

               cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
               cm:disable_event_feed_events(true, "wh_event_category_character", "", "");

               cm:force_declare_war("wh_main_chs_chaos_qb3", faction_name, false, false);
          end,
          false,
          false,
          false
     );
end;

function Log(text)
     local file = io.open("Freiya_Logs.txt", "a")
     file:write(text .. "\n")
     file:close()
end;

--cm:add_first_tick_callback(function() chaos_treasures() end)

--Save and load the table containing the treasure and coordinates to always have the same locations when reloading the game
cm:add_saving_game_callback(function(context)
     cm:save_named_value("items_poi_alt", items_poi_alt, context)
end)

cm:add_loading_game_callback(function(context)
     items_poi_alt = cm:load_named_value("items_poi_alt", items_poi_alt, context)
end)
