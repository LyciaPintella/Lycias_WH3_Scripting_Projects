local function z_sea_peoples_join()
     local sea_peoples_factions = {
          "phar_main_denyen",
          "phar_main_ekwesh",
          "phar_main_weshesh",
          "phar_sea_aegean_sea_raiders_rebels",
          "phar_sea_denyen",
          "phar_sea_ekwesh",
          "phar_sea_weshesh",
          "phar_main_al_khufu_invasion_sea_people",
          "phar_main_lukka",
          "phar_main_shekelesh",
          "phar_main_teresh",
          "phar_main_tjeker",
          "phar_sea_lukka",
          "phar_sea_peleset_separatists",
          "phar_sea_sea_wanderers_rebels",
          "phar_sea_shekelesh",
          "phar_sea_teresh",
          "phar_sea_tjeker",
          "phar_sea_sherden_separatists",
          "phar_sea_western_islanders_rebels"
     }

     core:add_listener(
          "z_sea_people_join",
          "BattleCompleted",
          function(context)
               local lose_faction_name = context:pending_battle():battle_results():losing_faction_key()
               return table_find(sea_peoples_factions, lose_faction_name, false) ~= nil
          end,
          function(context)
               local win_faction_name = context:pending_battle():battle_results():winning_faction_key()

               local sea_peoples_units = {
                    { unit = "phar_main_sea_islander_young_spears",            weight = 2 },
                    { unit = "phar_main_sea_seafaring_clubmen",                weight = 2 },
                    { unit = "phar_main_sea_aegean_fameseekers",               weight = 2 },
                    { unit = "phar_main_sea_islander_swordsmen",               weight = 2 },
                    { unit = "phar_main_sea_seafaring_slings",                 weight = 2 },
                    { unit = "phar_main_sea_aegean_light_archers",             weight = 5 },
                    { unit = "phar_main_sea_aegean_spear_chargers",            weight = 5 },
                    { unit = "phar_main_sea_islander_heavy_axemen",            weight = 5 },
                    { unit = "phar_main_sea_seafaring_javelinmen",             weight = 5 },
                    { unit = "phar_main_sea_seafaring_raiders",                weight = 5 },
                    { unit = "phar_main_sea_aegean_armoured_javelin_throwers", weight = 4 },
                    { unit = "phar_main_sea_aegean_armoured_raiders",          weight = 4 },
                    { unit = "phar_main_sea_marauder_slingers",                weight = 4 },
                    { unit = "phar_main_sea_marauding_axe_chargers",           weight = 4 },
                    { unit = "phar_main_sea_roving_khopesh_warriors",          weight = 4 },
                    { unit = "phar_main_sea_aegean_armoured_archers",          weight = 4 },
                    { unit = "phar_main_sea_aegean_panoply_spearmen",          weight = 4 },
                    { unit = "phar_main_sea_islander_raiders",                 weight = 4 },
                    { unit = "phar_main_sea_renowned_seafaring_raiders",       weight = 4 }
               }

               local attacker_unit_num = cm:pending_battle_cache_num_attacker_units()
               local defender_unit_num = cm:pending_battle_cache_num_defender_units()
               local attacker_is_winner = context:pending_battle():attacker_faction():name() == win_faction_name
               local loser_unit_num = (attacker_is_winner and defender_unit_num) or attacker_unit_num

               if loser_unit_num > 4 then
                    local capture_num_units = cm:model():random_int(math.round(loser_unit_num / 7, 0),
                         math.round(loser_unit_num / 5, 0))

                    -- Calculate total weight
                    local unit_total_weight = 0;
                    for i, v in ipairs(sea_peoples_units) do
                         unit_total_weight = unit_total_weight + v.weight;
                    end;

                    -- Add our units.
                    local r = 0; -- Random number used for weighting.

                    for i = 1, capture_num_units do
                         -- Roll a weighted random
                         r = cm:model():random_int(0, unit_total_weight)

                         -- Use our modified values from above to work out the weighting.
                         for i, unit_data in ipairs(sea_peoples_units) do
                              r = r - unit_data.weight; -- Subtract the weighting from our random total above.

                              if r <= 0 then      -- If we're below 0 then we fall within that attribute's values.
                                   local select_unit = unit_data.unit
                                   local faction_cqi = cm:get_faction(win_faction_name):command_queue_index()
                                   local current_unit_amount = cm:num_units_in_faction_mercenary_pool(faction_cqi,
                                        select_unit, "sea_peoples")
                                   current_unit_amount = current_unit_amount + 1

                                   local custom_unit = cm:create_custom_unit_from_key(select_unit, false)
                                   custom_unit:add_custom_id("sea_peoples")
                                   custom_unit:add_mercenary_recruit_data(
                                        current_unit_amount,
                                        0,
                                        current_unit_amount,
                                        0,
                                        0,
                                        "", "", ""
                                   )
                                   cm:add_custom_unit_to_faction_mercenary_pool(win_faction_name, custom_unit)

                                   break;
                              end;
                         end;
                    end;
               end;
          end,
          true
     )

     core:add_listener(
          "z_sea_peoples_start_hp_new_recruit",
          "UnitTrained",
          function(context)
               return context:unit():belongs_to_unit_set("phar_main_sea_people_units") and
               table_find(sea_peoples_factions, context:unit():military_force():faction():name(), false) == nil
          end,
          function(context)
               cm:change_unit_health(context:unit():command_queue_index(), -0.5)
          end,
          true
     )
end


cm:add_first_tick_callback(function() z_sea_peoples_join() end);
