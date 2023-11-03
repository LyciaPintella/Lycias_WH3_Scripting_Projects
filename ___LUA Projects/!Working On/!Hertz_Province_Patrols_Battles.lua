-----------------------------------------------------
--Functionality for when patrols lose after a battle
-----------------------------------------------------
local function hertz_patrol_death(winning_force, patrol_se, region)
     out("Patrol in province " .. region:province_name() .. " defeated. triggering dilemma");

     -- If patrol died in the wrong province, pick the other side of the pending battle as patrol province
     local province_regions = {};
     local target_region = nil;
     local patrol_faction = region:owning_faction();
     local suitible_province_found = false;
     local existing_patrol = get_province_patrol(region:province_name(), patrol_faction);
     local dilemma_complete = false;
     local target_is_patrol_force = true;
     local force_unit_count = cm:get_saved_value("patrol_force_count");
     out("Force unit count is [" .. force_unit_count .. "]")

     -- Check if the patrol force is still alive after the battle
     if not patrol_se:is_null_interface() then
          if patrol_se:has_effect_bundle("hertz_patrol_bundle") or patrol_se:military_force():has_effect_bundle("hertz_patrol_bundle") then
               out("patrol stil alive, commence slaughter without mercy...")
               cm:kill_character(patrol_se:command_queue_index(), true, false);
          else
               out("Normal force selected to kill. Cancelling rest of function");
               target_is_patrol_force = false;
          end;
     end

     if target_is_patrol_force then
          if existing_patrol ~= false then
               -- Region patrol died in has another patrol in it. Triggering patrol died in the wrong region grabbing winning_force region.
               province_regions = hertz_get_province_owned_regions(winning_force:region():province_name(),
                    patrol_faction:name(), false);
               existing_patrol = get_province_patrol(winning_force:region():province_name(), patrol_faction)
               -- BOOKMARK
               if existing_patrol == false and winning_force:faction():name() ~= winning_force:region():owning_faction():name() then
                    suitible_province_found = true;
                    target_region = winning_force:region();
               end;
               -- BOOKMARK
          elseif winning_force:faction():name() ~= region:owning_faction():name() then
               -- Patrol died in region without another patrol in it. Grabbing province regions
               province_regions = hertz_get_province_owned_regions(region:province_name(), patrol_faction:name(), false);
               suitible_province_found = true;
               target_region = region;
          end

          if suitible_province_found then
               out("suitable Province found applying effects.")
               cm:apply_effect_bundle_to_region("hertz_patrol_died_bundle", cm:get_region(province_regions[1]):name(), 5);
               remove_patrol_bundle(province_regions);
          else
               out("no suitable Province doing nothing.")
          end

          -- Trigger the dilemma for when a patrol is defeated.
          if winning_force:faction():is_human() then
               out("Winning force is player, doing the dilemma thingy")
               hertz_patrol_dilemma(winning_force:faction(), target_region, target_region:settlement(), winning_force,
                    province_regions, force_unit_count)
          end;
     end;
end;

local function hertz_pp_patrol_battles_listeners()
     -- Handles all patrol battles, and cleans up afterwards
     core:add_listener(
          pp_mod_name .. "_PanelOpenedCampaign_battle",
          "PanelOpenedCampaign",
          function(context)
               return context.string == "popup_pre_battle";
          end,
          function(context)
               out("HERTZ_OUT: pre_battle_panel_opened")
               local pb = cm:model():pending_battle();
               local attacker = pb:attacker();
               local defender = pb:defender();
               local secondary_attackers = pb:secondary_attackers();
               local secondary_defenders = pb:secondary_defenders();


               -- When a player starts a province patrol battle this listener will look for any force containing the province patrol bundle
               -- When a patrol is found all necessary info will be saved to be called when the battle is fought
               -- Info saved:
               -- Region the patrol belongs to - Used for effect bundles and dilemma setup
               -- which force in the pending battle is the patrol (attacker/defender/secondary_attacker/secondary_defender)
               -- The unit count of the patrol force - Used to trigger the dilemma
               if cm:get_saved_value("patrol_battle") == "tomb_kings" then
                    out("Tomb Kings patrol found in [" .. cm:get_saved_value("patrol_region") .. "]");
               elseif defender:military_force():has_effect_bundle("hertz_patrol_bundle") then
                    cm:set_saved_value("patrol_region", defender:region():name());
                    cm:set_saved_value("patrol_battle", "defender");
                    out(defender:military_force():unit_list():num_items())
                    cm:set_saved_value("patrol_force_count", defender:military_force():unit_list():num_items());
                    out("Defender patrol found in [" .. defender:region():name() .. "]");
               elseif attacker:military_force():has_effect_bundle("hertz_patrol_bundle") then
                    cm:set_saved_value("patrol_region", attacker:region():name());
                    cm:set_saved_value("patrol_battle", "attacker");
                    cm:set_saved_value("patrol_force_count", attacker:military_force():unit_list():num_items());
                    out("attacker patrol found in [" .. attacker:region():name() .. "]");
               else
                    cm:set_saved_value("patrol_region", attacker:region():name());
                    cm:set_saved_value("patrol_battle", false);
                    cm:set_saved_value("patrol_force_count", 0);
                    for k = 0, secondary_attackers:num_items() - 1 do
                         if secondary_attackers:item_at(k):military_force():has_effect_bundle("hertz_patrol_bundle") then
                              cm:set_saved_value("patrol_region", secondary_attackers:region():name());
                              cm:set_saved_value("patrol_battle", "attacker_reinforcements");
                              cm:set_saved_value("patrol_force_count",
                                   secondary_attackers:item_at(k):military_force():unit_list():num_items());
                              cm:set_saved_value("patrol_number", k);
                              out("attacker patrol found in [" .. secondary_attackers:region():name() .. "]");
                         end;
                    end;

                    for m = 0, secondary_defenders:num_items() - 1 do
                         if secondary_defenders:item_at(m):military_force():has_effect_bundle("hertz_patrol_bundle") then
                              cm:set_saved_value("patrol_region", secondary_defenders:region():name());
                              cm:set_saved_value("patrol_battle", "defender_reinforcements");
                              cm:set_saved_value("patrol_force_count",
                                   secondary_defenders:item_at(m):military_force():unit_list():num_items());
                              cm:set_saved_value("patrol_number", m);
                              out("Defender patrol found in [" .. secondary_defenders:region():name() .. "]");
                         end;
                    end;
               end;
          end,
          true
     );
     core:add_listener(
          pp_mod_name .. "BattleCompleted",
          "BattleCompleted",
          true,
          function(context)
               if cm:get_saved_value("patrol_battle") ~= false then
                    out("HERTZ_OUT: BattleCompleted do the things")
                    local patrol_force        = cm:get_saved_value("patrol_battle");
                    local pb                  = cm:model():pending_battle();
                    local attacker            = pb:attacker();
                    local defender            = pb:defender();
                    local secondary_attackers = pb:secondary_attackers();
                    local secondary_defenders = pb:secondary_defenders();
                    local target_region       = cm:get_region(cm:get_saved_value("patrol_region"))

                    --The new way checks saved_value for the region the patrol was in when battle started.
                    --The old way checked who was still alive and grabbed that region.
                    local old_region_check    = false
                    out("Battle patrol: [" .. cm:get_saved_value("patrol_battle") .. "]")
                    out("Battle patrol type: [" .. patrol_force .. "]")
                    out("pb:has_been_fought: [" .. tostring(pb:has_been_fought()) .. "]")

                    -- if not pb:has_been_fought() and patrol_force == "tomb_kings" then
                    -- 	--out("Tomb Kings patrol ambush")
                    -- 	cm:disable_event_feed_events(true, "wh_event_category_character", "wh_event_subcategory_character_deaths", "");

                    -- 	local province_regions = hertz_get_province_owned_regions(target_region:province_name(), attacker:faction():name(), false)
                    -- 	local tomb_kings_patrol_invasion = invasion_manager:get_invasion("hertz_tomb_invasion_force")

                    -- 	cm:apply_effect_bundle_to_region("hertz_patrol_replenish_bundle", attacker:region():name(), 2);

                    -- 	cm:remove_effect_bundle_from_region("hertz_patrol_alive_bundle", attacker:region():name());
                    -- 	cm:remove_effect_bundle_from_region("hertz_tk_patrol_ambush_bundle", attacker:region():name());

                    -- 	tomb_kings_patrol_invasion:set_general_immortal(false);


                    -- 	invasion_manager:kill_invasion_by_key("hertz_tomb_invasion_force")
                    -- 	remove_patrol_bundle(province_regions)
                    if not pb:has_been_fought() and cm:get_saved_value("patrol_battle") == true then
                         local attacker_won = cm:pending_battle_cache_attacker_victory()
                         out("Battle fought in [" .. cm:get_saved_value("patrol_region") .. "]")
                    elseif pb:has_been_fought() and cm:get_saved_value("patrol_battle") ~= false then
                         ---------------------------------------------------------------------------------------------------------
                         -- Tomb Kings post patrol battle functionality. Will kill the tomb kings patrol weither they won or lost.
                         -- If lost will also trigger patrol battle dilemma if the other conditions have been met.
                         ---------------------------------------------------------------------------------------------------------
                         local attacker_won = cm:pending_battle_cache_attacker_victory()
                         -- if patrol_force == "tomb_kings" then
                         -- 	out("Tomb Kings patrol ambush")
                         -- 	cm:disable_event_feed_events(true, "wh_event_category_character", "wh_event_subcategory_character_deaths", "");

                         -- 	local province_regions = hertz_get_province_owned_regions(target_region:province_name(), attacker:faction():name(), false)
                         -- 	local tomb_kings_patrol_invasion = invasion_manager:get_invasion("hertz_tomb_invasion_force")

                         -- 	cm:apply_effect_bundle_to_region("hertz_patrol_replenish_bundle", attacker:region():name(), 2);

                         -- 	cm:remove_effect_bundle_from_region("hertz_patrol_alive_bundle", attacker:region():name());
                         -- 	cm:remove_effect_bundle_from_region("hertz_tk_patrol_ambush_bundle", attacker:region():name());

                         -- 	tomb_kings_patrol_invasion:set_general_immortal(false);

                         -- 	if not attacker_won then
                         -- 		cm:remove_effect_bundle_from_region("hertz_patrol_replenish_bundle", attacker:region():name());
                         -- 		hertz_patrol_death(defender, attacker, target_region);
                         -- 	end
                         -- 	invasion_manager:kill_invasion_by_key("hertz_tomb_invasion_force")
                         -- 	remove_patrol_bundle(province_regions)

                         -- elseif patrol_force == "attacker" then
                         if patrol_force == "attacker" then
                              -------------------------------------------------------------------
                              -- Check if the patrol force won the battle if it was the attacker.
                              -------------------------------------------------------------------
                              if attacker:is_null_interface() and old_region_check then
                                   target_region = defender:region();
                              elseif old_region_check then
                                   target_region = attacker:region();
                              end
                              if not attacker_won then
                                   -- If the patrol is defeated run the patrol death functionality
                                   hertz_patrol_death(defender, attacker, target_region);
                              else
                                   cm:disable_movement_for_character(cm:char_lookup_str(attacker:command_queue_index()))
                                   cm:zero_action_points(cm:char_lookup_str(attacker:command_queue_index()));
                              end
                         elseif patrol_force == "defender" then
                              -------------------------------------------------------------------
                              -- Check if the patrol force won the battle if it was the defender.
                              -------------------------------------------------------------------
                              if defender:is_null_interface() and old_region_check then
                                   target_region = attacker:region();
                              elseif old_region_check then
                                   target_region = defender:region();
                              end
                              if attacker_won then
                                   -- If the patrol is defeated run the patrol death functionality
                                   hertz_patrol_death(attacker, defender, target_region);
                              else
                                   cm:disable_movement_for_character(cm:char_lookup_str(defender:command_queue_index()))
                                   cm:zero_action_points(cm:char_lookup_str(defender:command_queue_index()));
                              end
                         elseif patrol_force == "attacker_reinforcements" then
                              -----------------------------------------------------------------------------------
                              -- Check if the patrol force won the battle if it was the attackers reinforcements.
                              -----------------------------------------------------------------------------------
                              local target_patrol = secondary_attackers:item_at(cm:get_saved_value("patrol_number"))
                              if target_patrol:is_null_interface() and old_region_check then
                                   target_region = defender:region();
                              elseif old_region_check then
                                   target_region = attacker:region();
                              end
                              if not attacker_won then
                                   -- If the patrol is defeated run the patrol death functionality
                                   hertz_patrol_death(defender, target_patrol, target_region);
                              else
                                   cm:disable_movement_for_character(cm:char_lookup_str(target_patrol
                                        :command_queue_index()))
                                   cm:zero_action_points(cm:char_lookup_str(target_patrol:command_queue_index()));
                              end
                         elseif patrol_force == "defender_reinforcements" then
                              -----------------------------------------------------------------------------------
                              -- Check if the patrol force won the battle if it was the defenders reinforcements.
                              -----------------------------------------------------------------------------------
                              local target_patrol = secondary_defenders:item_at(cm:get_saved_value("patrol_number"))
                              if target_patrol:is_null_interface() and old_region_check then
                                   target_region = attacker:region();
                              elseif old_region_check then
                                   target_region = defender:region();
                              end
                              if attacker_won then
                                   -- If the patrol is defeated run the patrol death functionality
                                   hertz_patrol_death(attacker, target_patrol, target_region);
                              else
                                   cm:disable_movement_for_character(cm:char_lookup_str(target_patrol
                                        :command_queue_index()))
                                   cm:zero_action_points(cm:char_lookup_str(target_patrol:command_queue_index()));
                              end
                         end;
                    end;
                    -- Reset the value which checks if current battle has a patrol force in it
                    cm:set_saved_value("patrol_battle", false);
                    -- Disable character death sidebar events
                    cm:disable_event_feed_events(false, "wh_event_category_character",
                         "wh_event_subcategory_character_deaths", "");
               end;
          end,
          true
     );
end

cm:add_first_tick_callback(function() hertz_pp_patrol_battles_listeners() end);
