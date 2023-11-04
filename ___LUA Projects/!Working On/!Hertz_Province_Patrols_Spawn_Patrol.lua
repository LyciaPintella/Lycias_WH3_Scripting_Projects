local player_faction = nil;
local order_retry_cap = 3;

-- Checks which patrols are removed when they are lost in the wrong region
-- Also tracks previous turn settlement rank for incidents
function hertz_create_new_patrol(province_regions)
     local province_capital = nil;
     local existing_patrol = get_province_patrol(cm:get_region(province_regions[1]):province_name(),
          cm:get_region(province_regions[1]):owning_faction());
     local force_created = false;
     local target_exclusion_region = false;

     -- Check if no other patrols exist in the current province.
     if existing_patrol == false then
          out("Checking for excluded capitals.")
          for i = 1, #region_exclusion do
               if cm:get_region(province_regions[1]):province_name() == cm:get_region(region_exclusion[i]):province_name() and cm:get_region(region_exclusion[i]):is_province_capital() then
                    target_exclusion_region = cm:get_region(region_exclusion[i])
               end;
          end;

          -- Look for the province Capital
          for i = 1, #province_regions do
               local target_region = cm:get_region(province_regions[i]);
               if target_region:is_province_capital() or target_exclusion_region ~= false then
                    if target_exclusion_region ~= false then
                         out("exclusion capital region found [" .. target_exclusion_region:name() .. "]");
                         target_region = target_exclusion_region;
                    end;

                    local region_key = target_region:name();
                    local faction_key = target_region:owning_faction():name();
                    local subculture_key = target_region:owning_faction():name();
                    local settlement_script_interface = target_region:settlement();
                    local target_subculture = settlement_script_interface:faction():subculture();
                    local settlement_level = tonumber(1);

                    -- Get the current province Capital settlement rank
                    if target_exclusion_region ~= false then
                         -- If the Capital is in an excluded region, it needs to grab that settlement rank but spawn the force in a different region
                         settlement_level = tonumber(settlement_script_interface:primary_slot():building()
                         :building_level());
                         target_exclusion_region = false;
                    else
                         settlement_level = hertz_get_settlement_level(province_regions, true);
                    end;

                    if settlement_level == nil then
                         settlement_level = 1;
                    end

                    -- out("Settlement level = " ..settlement_level);

                    -- Swap target faction to Nekai's force when checking his vassals territory
                    -- This is done to make sure the patrol force spawns under Nekai's banner.
                    if faction_key == "wh2_dlc13_lzd_defenders_of_the_great_plan" then
                         faction_key = "wh2_dlc13_lzd_spirits_of_the_jungle"
                    end;

                    -- Only spawn patrols in settlements higher than rank 1.
                    if settlement_level > 1 or target_subculture == "wh_dlc05_sc_wef_wood_elves" or faction_key == "wh2_dlc13_lzd_spirits_of_the_jungle" or faction_key == "wh2_dlc13_lzd_spirits_of_the_jungle" then
                         -- Generate the patrols unit list
                         generated_patrol_force = hertz_generate_patrol_unit_list(target_subculture, faction_key,
                              settlement_level)

                         if generated_patrol_force ~= false then
                              -- Set the variables and numbers needed for force generation
                              local sc_patrol_table = ram_unit_lists[target_subculture]

                              -- sc_patrol_table = ram_unit_lists[target_subculture];

                              -- Check if the subculture has special patrol setups.
                              if sc_patrol_table.faction_custom_patrols.enabled == true then
                                   if hertz_table_contains_string(sc_patrol_table.faction_custom_patrols.factions, faction_key) then
                                        -- Full custom unit list per predetermined factions
                                        if sc_patrol_table.faction_custom_patrols.type == "full" then
                                             sc_patrol_table = sc_patrol_table.faction_custom_patrols[faction_key];

                                             -- Custom commander per predetermined faction
                                        elseif sc_patrol_table.faction_custom_patrols.type == "lord" then
                                             sc_patrol_table.com = sc_patrol_table.faction_custom_patrols[faction_key]
                                             .com
                                        end;
                                   end;
                              end;

                              -- Get a valid spawning location from the target region inside the owned province.
                              local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_settlement(
                              faction_key, region_key, false, true, 5);

                              --Spawn the patrol
                              cm:create_force_with_general(
                                   faction_key,
                                   generated_patrol_force,
                                   region_key,
                                   pos_x,
                                   pos_y,
                                   "general",
                                   sc_patrol_table.com,
                                   sc_patrol_table.name,
                                   "",
                                   "",
                                   "",
                                   false,
                                   function(cqi)
                                        local target_char = cm:get_character_by_cqi(cqi);
                                        -- Safeguard if loyalty still shows up for a province patrol.
                                        -- Keeps it neutral so that no dilemmas or events pop up for the patrol.
                                        if target_char:loyalty() < 5 or target_char:loyalty() > 5 then
                                             cm:modify_character_personal_loyalty_factor(
                                             cm:char_lookup_str(target_char:command_queue_index()),
                                                  5 - target_char:loyalty());
                                        end
                                cm:convert_force_to_type(target_char:military_force(), "PATROL_ARMY");
                                        cm:

                                        -- Set custom Vampire Counts province patrol alive bundle according to settlement rank.
                                        if target_subculture == "wh_main_sc_vmp_vampire_counts" then
                                             out("applying vampire bundle [hertz_vamp_patrol_" ..
                                             tostring(settlement_level) ..
                                             "] with the effect value of [" .. tostring((settlement_level * 2) - 2) ..
                                             "]")
                                             local vamp_patrol_bundle = cm:create_new_custom_effect_bundle(
                                             "hertz_patrol_bundle");
                                             vamp_patrol_bundle:set_duration(-1);
                                             vamp_patrol_bundle:add_effect("hertz_vamp_patrol_" .. settlement_level,
                                                  "force_to_province_own", (settlement_level * 2) - 2);
                                             cm:apply_custom_effect_bundle_to_force(vamp_patrol_bundle,
                                                  target_char:military_force());
                                        elseif target_subculture == "wh3_dlc23_sc_chd_chaos_dwarfs" then
                                             out("applying chaos dwarf [hertz_chd_patrol_" ..
                                             tostring(settlement_level) .. "]")
                                             local chorf_patrol_bundle = cm:create_new_custom_effect_bundle(
                                             "hertz_patrol_bundle");
                                             chorf_patrol_bundle:set_duration(-1);
                                             local units_to_check = {
                                                  "wh3_dlc23_chd_inf_chaos_dwarf_warriors",
                                                  "wh3_dlc23_chd_inf_chaos_dwarf_blunderbusses",
                                                  "wh3_dlc23_chd_mon_great_taurus",
                                                  "wh3_dlc23_chd_veh_magma_cannon",
                                                  "wh3_dlc23_chd_veh_iron_daemon"
                                             }
                                             -- Use a table to store unit counts
                                             local unit_counts = {
                                                  wh3_dlc23_chd_inf_chaos_dwarf_warriors = 0,
                                                  wh3_dlc23_chd_inf_chaos_dwarf_blunderbusses = 0,
                                                  wh3_dlc23_chd_mon_great_taurus = 0,
                                                  wh3_dlc23_chd_veh_magma_cannon = 0,
                                                  wh3_dlc23_chd_veh_iron_daemon = 0
                                             }
                                             -- Split generated_patrol_force into individual unit strings
                                             local patrol_units = {}
                                             for unit_str in string.gmatch(generated_patrol_force, "[^,%s]+") do
                                                  table.insert(patrol_units, unit_str)
                                             end

                                             -- Iterate over each unit in patrol_units and count them in unit_counts if they are in units_to_check
                                             for _, unit_name in ipairs(patrol_units) do
                                                  if unit_counts[unit_name] ~= nil then
                                                       unit_counts[unit_name] = unit_counts[unit_name] + 1
                                                       out("Unit found: [" .. unit_name .. "]")
                                                  end
                                             end
                                             if unit_counts.wh3_dlc23_chd_inf_chaos_dwarf_warriors > 0 then
                                                  chorf_patrol_bundle:add_effect("hertz_hidden_unit_cat_chd_warrior",
                                                       "faction_to_faction_own_unseen",
                                                       unit_counts.wh3_dlc23_chd_inf_chaos_dwarf_warriors);
                                             end

                                             if unit_counts.wh3_dlc23_chd_inf_chaos_dwarf_blunderbusses > 0 then
                                                  chorf_patrol_bundle:add_effect("hertz_hidden_unit_cat_chd_blunderbuss",
                                                       "faction_to_faction_own_unseen",
                                                       unit_counts.wh3_dlc23_chd_inf_chaos_dwarf_blunderbusses);
                                             end

                                             if unit_counts.wh3_dlc23_chd_mon_great_taurus > 0 then
                                                  chorf_patrol_bundle:add_effect("hertz_hidden_unit_cat_chd_taurus",
                                                       "faction_to_faction_own_unseen",
                                                       unit_counts.wh3_dlc23_chd_mon_great_taurus);
                                             end

                                             if (unit_counts.wh3_dlc23_chd_veh_magma_cannon + unit_counts.wh3_dlc23_chd_veh_iron_daemon) > 0 then
                                                  chorf_patrol_bundle:add_effect("hertz_hidden_unit_cat_chd_warmachine",
                                                       "faction_to_faction_own_unseen",
                                                       (unit_counts.wh3_dlc23_chd_veh_magma_cannon + unit_counts.wh3_dlc23_chd_veh_iron_daemon));
                                             end
                                             cm:apply_custom_effect_bundle_to_force(chorf_patrol_bundle,
                                                  target_char:military_force());

                                             -- Set the default province patrol alive bundle.
                                        else
                                             cm:apply_effect_bundle_to_characters_force("hertz_patrol_bundle", cqi, -1,
                                                  true);
                                        end;
                                        cm:apply_effect_bundle_to_region("hertz_patrol_alive_bundle", province_regions
                                        [i], -1);
                                        cm:cai_disable_movement_for_character(cm:char_lookup_str(cqi));
                                        cm:zero_action_points(cm:char_lookup_str(cqi));

                                        -- Apply special upkeep bundle for Nekai's patrols.
                                        if faction_key == "wh2_dlc13_lzd_spirits_of_the_jungle" then
                                             cm:apply_effect_bundle_to_characters_force(
                                             "wh2_dlc16_bundle_military_upkeep_free_force_immune_to_regionless_attrition",
                                                  cqi, -1, true);
                                        end;
                                   end
                              );
                         end;
                    end;
               end;
          end;
     end;
end;

------------------------------------------------------------------------------------------------------------
-- This function runs at the start of the turn for every faction.
-- It checks the factions owned regions and provinces and spawns and orders patrols when conditions are met.
------------------------------------------------------------------------------------------------------------
local function patrol_and_province_commands(faction_script_interface)
     get_faction_wars(faction_script_interface, false);
     if order_retry_count <= order_retry_cap then
          order_retry_count = order_retry_count + 1;

          local target_faction = faction_script_interface;
          local target_subculture = faction_script_interface:subculture();
          local region_list = target_faction:region_list();
          local checking_province = "";
          local checked_provinces = {};
          local patrol_not_moved = true;
          faction_patrol_list[target_faction:name()].patrols = {};
          out("Checking " .. target_faction:name())

          -- When checking Nekai, check its vassals provinces for patrol availability
          if target_faction:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" then
               target_faction = cm:get_faction("wh2_dlc13_lzd_defenders_of_the_great_plan");
               region_list = target_faction:region_list();
          end;

          local faction_region_count = region_list:num_items()
          out("region count is [" .. faction_region_count .. "]")

          for i = 0, region_list:num_items() - 1 do
               --Switch back to the vassal faction for Nekai to continue checking their regions
               if target_faction:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" then
                    target_faction = cm:get_faction("wh2_dlc13_lzd_defenders_of_the_great_plan");
               end
               local target_region = region_list:item_at(i);

               -- Check for each province once to make sure not too many checks are spammed.
               if target_region:province_name() ~= checking_province and not table:contains(province_exlusion, target_region:province_name()) then
                    checking_province = target_region:province_name();

                    -- Goes through the target factions region lists and returns all fully owned provinces.
                    if (target_subculture ~= "wh_main_sc_chs_chaos") then
                         province_regions = hertz_get_province_owned_regions(checking_province, target_faction:name(),
                              false)
                    else
                         province_regions = hertz_get_province_owned_regions(checking_province, target_faction:name(),
                              true)
                    end

                    -- Swap the target faction to Nekai to make sure that any patrols that are checked or spawned belong to Nekai.
                    if target_faction:name() == "wh2_dlc13_lzd_defenders_of_the_great_plan" then
                         target_faction = cm:get_faction("wh2_dlc13_lzd_spirits_of_the_jungle");
                    end;

                    -- Gets the province patrol of the current target province if it exists. Otherwise returns "false"
                    local target_patrol = get_province_patrol(checking_province, target_faction)
                    local faction_table = faction_patrol_list[target_faction:name()]

                    -- Checks if the faction owns the entire province, and if the entire province is bigger than 1 region.
                    out("amount of regions in province: " .. table.maxn(province_regions))
                    if (province_regions ~= false and not table:contains(checked_provinces, checking_province) and table.maxn(province_regions) > 1) or target_subculture == "wh3_main_sc_ksl_kislev" or target_subculture == "wh_main_sc_chs_chaos" then
                         table.insert(checked_provinces, checking_province);

                         -- Start the patrol functionality for the Tomb Kings.
                         if target_faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
                              -- tomb_kings_province_patrol(province_regions, target_faction);

                              -- Start the patrol functionality for the other factions.
                         elseif target_faction:subculture() ~= "wh2_dlc09_sc_tmb_tomb_kings" then
                              -- Check if a patrol is found in the checking province.
                              if target_patrol ~= false then
                                   -- Reset their force_type to default PATROL_ARMY if not set.
                                   if target_patrol:military_force():force_type():key() ~= "PATROL_ARMY" then
                                        cm:convert_force_to_type(target_patrol:military_force(), "PATROL_ARMY");
                                   end;

                                   -- Order the patrol when it is found.
                                   out("Moving patrol")
                                   if patrol_not_moved then
                                        hertz_order_patrol(province_regions, target_faction, target_patrol,
                                             faction_region_count)
                                   end;

                                   -- Target faction owns an entire province but a patrol is not currently alive.
                              elseif not target_patrol then
                                   local patrol_alive_bundle = false
                                   local patrol_replenish_bundle = false
                                   local patrol_dead_bundle = false

                                   -- Check the entire region for the patrol cooldown effect bundle
                                   for j = 1, #province_regions do
                                        if cm:get_region(province_regions[j]):has_effect_bundle("hertz_patrol_alive_bundle") then
                                             hertz_patrol_alive_bundle = true;
                                             cm:remove_effect_bundle_from_region("hertz_patrol_alive_bundle",
                                                  province_regions[j])
                                             cm:apply_effect_bundle_to_region("hertz_patrol_replenish_bundle",
                                                  province_regions[j], 5);
                                        end;

                                        if cm:get_region(province_regions[j]):has_effect_bundle("hertz_patrol_replenish_bundle") then
                                             patrol_replenish_bundle = true;
                                        end;

                                        if cm:get_region(province_regions[j]):has_effect_bundle("hertz_patrol_died_bundle") then
                                             patrol_dead_bundle = true;
                                        end;
                                        out("hertz_patrol_alive_bundle = [" .. tostring(hertz_patrol_alive_bundle) .. "]")
                                        out("patrol_replenish_bundle = [" .. tostring(patrol_replenish_bundle) .. "]")
                                        out("patrol_dead_bundle = [" .. tostring(patrol_dead_bundle) .. "]")
                                   end;
                                   -- If the patrol is not on cooldown, spawn the patrol.
                                   if not patrol_alive_bundle and not patrol_replenish_bundle and not patrol_dead_bundle and target_faction:holds_entire_province(checking_province, true) then
                                        -- Only give Kislev the ability to have province patrols in single settlement provinces province patrols.
                                        if target_subculture ~= "wh3_main_sc_ksl_kislev" and target_subculture ~= "wh_main_sc_chs_chaos" and table.maxn(province_regions) > 1 then
                                             hertz_create_new_patrol(province_regions, target_faction);
                                        elseif target_subculture == "wh3_main_sc_ksl_kislev" or target_subculture == "wh_main_sc_chs_chaos" then
                                             hertz_create_new_patrol(province_regions, target_faction);
                                        end
                                   end;
                              end;
                         end;
                    end;
               end;
          end;

          -----------------------------------------------------------------------------------------------------------------
          -- Patrol Order retry Logic
          -- Some bugs or features which slow the game down will make the script skip all patrol orders.
          -- This piece of code checks the players patrols and retries giving them orders if they have not moved this turn.
          -----------------------------------------------------------------------------------------------------------------
          if target_faction:is_human() then
               --Checks and gives rewards for any patrol dilemma's from the previous turn.
               check_dilemma_rewards(target_faction);
               patrol_not_moved = false;

               -- 3 second callback timer that checks the players patrol positions.
               -- If the patrols have not moved, restart this entire function.
               -- This callback will run every 3 seconds up to 15 seconds untill patrols have moved.
               cm:callback(
                    function()
                         for k = 1, #faction_patrol_list[target_faction:name()].patrols do
                              if not table:contains(patrol_saved_information.removed_cqis, faction_patrol_list[target_faction:name()].patrols[k]:command_queue_index()) then
                                   local checking_patrol = faction_patrol_list[target_faction:name()].patrols[k];
                                   local saved_pos = patrol_saved_information[checking_patrol:command_queue_index()];
                                   --out("Patrol in ["..faction_patrol_list[target_faction:name()].patrols[k]:region():name().."] not moved. ["..faction_patrol_list[target_faction:name()].patrols[k]:action_points_remaining_percent().."] action pints remaining");
                                   if checking_patrol:logical_position_x() == saved_pos.pos_x and checking_patrol:logical_position_y() == saved_pos.pos_y then
                                        patrol_not_moved = true;
                                        hertz_patrols_ordered = false;
                                   end;
                              end
                         end;

                         if patrol_not_moved then
                              patrol_and_province_commands(target_faction);
                         else
                              order_retry_count = order_retry_cap;
                              hertz_patrols_ordered = true;
                              cm:disable_event_feed_events(false, "wh_event_category_character",
                                   "wh_event_subcategory_character_deaths", "");
                         end;
                         if target_faction ~= "wh2_dlc13_lzd_spirits_of_the_jungle" then
                              clean_lost_patrols(target_faction);
                         end;
                    end,
                    3
               )
          else
               -- AI Patrols have a tendency to end up in other factions territory.
               -- It is very hard to efficiently track which province the patrol belongs to without filling the internal registry with information
               -- So when a wrong position has been given to the patrol it will delete the AI patrol and respawn him in the next turn
               -- The players patrols have a different functionality when they end up in other peoples territory
               clean_lost_patrols(target_faction);
          end;
     end;
end;

-- Check if any force is standing against a patrol to disable army merging.
local function hertz_is_patrol_merging(player_faction)
     out("HERTZ_OUT: Patrol merging...")
     local mil_force_list = player_faction:military_force_list();
     local uim = cm:get_campaign_ui_manager()
     local patrol_force = {};
     local target_force = {};
     local unit_close_enough = false;

     for i = 0, mil_force_list:num_items() - 1 do
          if mil_force_list:item_at(i):has_effect_bundle("hertz_patrol_bundle") then
               --out("Patrol found")
               patrol_force.force = mil_force_list:item_at(i);
               patrol_force.general = patrol_force.force:general_character();
               patrol_force.region = patrol_force.general:region();
               patrol_force.x = patrol_force.general:logical_position_x()
               patrol_force.y = patrol_force.general:logical_position_y()

               for j = 0, mil_force_list:num_items() - 1 do
                    target_force.force = mil_force_list:item_at(j);
                    if target_force.force:has_general() and not target_force.force:is_armed_citizenry() then
                         target_force.general = target_force.force:general_character();
                         target_force.region = target_force.general:region();
                         target_force.x = target_force.general:logical_position_x();
                         target_force.y = target_force.general:logical_position_y();
                         --out("Merging force found calculating distance")

                         if patrol_force.region == target_force.region and uim:is_char_selected(target_force.general) then
                              local distance = distance_squared(patrol_force.x, patrol_force.y, target_force.x,
                                   target_force.y);
                              out("Distance is: [" .. distance .. "] meters")
                              if distance < 5 then
                                   unit_close_enough = true
                                   return true;
                              end;
                         end;
                    end;
               end;
          end;
     end;
     if not unit_close_enough then
          return false;
     end;
end;


function hertz_pp_spawn_patrol_listeners()
     out("###### ADDING HERTZ hertz_pp_spawn_patrol LISTENERS ######")

     -- Resets all tracking values and starts the Province Patrol Logic
     core:add_listener(
          pp_mod_name .. "_ProvincePatrolsFactionBeginTurnPhaseNormal",
          "FactionBeginTurnPhaseNormal",
          function(context)
               out("HERTZ_OUT: Starting turn listener")
               out("HERTZ_OUT: subculture is: [" .. context:faction():subculture() .. "]")
               out("HERTZ_OUT: Table is empty: [" .. tostring(table:is_empty(hertz_active_faction_subcultures)) .. "]")
               out("HERTZ_OUT: Table 1 is: [" .. hertz_active_faction_subcultures[1] .. "]")
               out("HERTZ_OUT: Table contains is: [" ..
               tostring(table.contains(hertz_active_faction_subcultures, context:faction():subculture())) .. "]")
               if table.contains(hertz_active_faction_subcultures, context:faction():subculture()) ~= false then
                    return true;
               end;
          end,
          function(context)
               out("HERTZ_OUT: Running spawn logic")

               local target_faction = context:faction()
               hertz_patrols_ordered = false;
               order_retry_count = 0;
               patrol_saved_information.removed_cqis = {};

               patrol_and_province_commands(target_faction)
          end,
          true
     );

     core:add_listener(
          pp_mod_name .. "_CharacterSelected",
          "CharacterSelected",
          true,
          function(context)
               -- Disable movement for patrols when selected just to be safe.
               if context:character():faction():is_human() and context:character():military_force():has_effect_bundle("hertz_patrol_bundle")
                then
                    cm:disable_movement_for_character(cm:char_lookup_str(context:character():command_queue_index()));
               end
          end,
          true
     );
     core:add_listener(
     pp_mod_name .. "_CharacterCreated",
     "CharacterCreated",
     true,
     function(context)
          -- Disable movement for patrols when selected just to be safe.
          if context:character():faction():is_human() and context:character():military_force():has_effect_bundle("hertz_patrol_bundle")
               then
               cm:disable_movement_for_character(cm:char_lookup_str(context:character():command_queue_index()));
          end
     end,
     true
     );

     -- Closes the unit exchange panel if garrison force is standing next to another player army.
     core:add_listener(
          pp_mod_name .. "_nitExchangeBlocker",
          "PanelOpenedCampaign",
          function(context)
               return context.string == "unit_exchange";
          end,
          function(context)
               local garrison_force = hertz_is_patrol_merging()
               if garrison_force then
                    local uic_close_button = find_uicomponent(core:get_ui_root(), "unit_exchange", "hud_center_docker",
                         "ok_cancel_buttongroup", "button_cancel");

                    if uic_close_button and uic_close_button:Visible(true) then
                         --Callback to slow down the panel closing to make sure the game does not crash
                         cm:callback(
                              function()
                                   uic_close_button:SimulateLClick();
                              end,
                              0.1,
                              "close_panel_callback"
                         )
                    end;
               end;
          end,
          true
     );

     -- Patroll commands get dropped if a dilemma is open at the start of the players turn. This restars the province patrol logic.
     core:add_listener(
          pp_mod_name .. "_DilemmaChoiceMadeEvent_order_patrols",
          "DilemmaChoiceMadeEvent",
          function(context)
               if table:contains(hertz_active_faction_subcultures, context:faction():subculture()) then
                    return context:dilemma() ~= "hertz_patrol_defeated_dilemma";
               end;
          end,
          function(context)
               if not hertz_patrols_ordered and disable_post_dilemma_orders == true then
                    order_retry_count = 0;
                    patrol_and_province_commands(context:faction());
               end;
          end,
          true
     );

     -- Disables the functionality that orders all patrols after a dilemma has fired.
     core:add_listener(
          pp_mod_name .. "_DisablePostDilemmaPatrolCommands",
          "CharacterSelected",
          function(context)
               --if context:character():faction():is_human() and context:character():has_effect_bundle("hertz_patrol_bundle") then
               if context:character():has_effect_bundle("hertz_patrol_bundle") or context:character():military_force():has_effect_bundle("hertz_patrol_bundle") then
                    return true;
               end;
          end,
          function(context)
               out("Force as patrol bundle [" ..
               tostring(context:character():military_force():has_effect_bundle("hertz_patrol_bundle")) .. "]")
               out("Character as patrol bundle [" ..
               tostring(context:character():has_effect_bundle("hertz_patrol_bundle")) .. "]")
               disable_post_dilemma_orders = false
          end,
          true
     );

     -- core:add_listener(
     -- 	pp_mod_name.."",
     -- 	"",
     -- 	true,
     -- 	function(context)
     -- 	end,
     -- 	true
     -- );
end;

-----------------------------------------------------------------
---------------------======Save Game======-----------------------
-----------------------------------------------------------------
local function hertz_pp_spawn_patrol_saved_game()

end
cm:add_saving_game_callback(function() hertz_pp_spawn_patrol_saved_game() end);

-----------------------------------------------------------------
---------------------======Load Game======-----------------------
-----------------------------------------------------------------
local function hertz_pp_spawn_patrol_loaded_game()

end
cm:add_loading_game_callback(function() hertz_pp_spawn_patrol_loaded_game() end);

--[[
NOTES
Found a minor "bug" with a spawnpoint in the province Jungles of green mist, The Blood hall.
The patrol is spawning on the southside of the settlement into a small gap on the island and is not able to move through the city to take a stroll through the province.
This may happen on other islands as well, but may be a problem with pathing in the base game.
]]
