pp_script_author = "8 Hertz WAN IP"
pp_script_version = "0.1"
pp_mod_name = "hertz_pp_spawn_patrol"

out(pp_mod_name .. " script version V" .. pp_script_version .. " - Made by " .. pp_script_author);

province_exlusion = {
     "wh3_main_combi_province_eagle_gate",
     "wh3_main_combi_province_griffon_gate",
     "wh3_main_combi_province_phoenix_gate",
     "wh3_main_combi_province_unicorn_gate",
     "wh3_main_chaos_province_central_great_bastion",
     "wh3_main_chaos_province_eastern_great_bastion",
     "wh3_main_chaos_province_western_great_bastion",
     "wh3_main_combi_province_central_great_bastion",
     "wh3_main_combi_province_eastern_great_bastion",
     "wh3_main_combi_province_western_great_bastion",
};

region_exclusion = {
};

-- Mostly used for tracking faction wars atm
faction_patrol_list = {
     ["TEMPLATE"] = { province_list = { "DEBUG", }, patrols = { "DEBUG", }, at_war_with = { "DEBUG", } }
};

patrol_saved_information = { removed_cqis = {} };

-- Activates leightweight mode where patrols teleport for the player instead of normally move
hertz_leightweight_mode_cap = 50;
-- When patrols fail to get an order, the script will retry giving orders to patrols.
-- These functions control and limit the amount of times the script wil retry ordering all patrols to avoid infinite loops
hertz_order_retry_count = 0;
hertz_order_retry_cap = 5;

province_regions = nil;

----------------------------------------------------------------------
-- Keeps track of each faction and which faction they are at war with.
----------------------------------------------------------------------
function get_faction_wars(source_faction, clear_at_war_list)
     local faction_list = cm:model():world():faction_list()
     local faction_war_list_1 = {};
     local faction_war_list_2 = {};

     if faction_patrol_list[source_faction:name()] == nil then
          faction_patrol_list[source_faction:name()] = faction_patrol_list["TEMPLATE"];
     end

     if clear_at_war_list then
          faction_patrol_list[source_faction:name()].at_war_with = {};
     end

     for i = 0, faction_list:num_items() - 1 do
          local target_faction = faction_list:item_at(i);
          -- out("HERTZ_OUT: faction_patrol_list["..target_faction:name().."].at_war_with = ["..faction_patrol_list[source_faction:name()].at_war_with[1].."]")

          if source_faction:at_war_with(target_faction) then
               if not table.contains(faction_patrol_list[source_faction:name()].at_war_with, target_faction:name()) and source_faction:name() ~= target_faction:name() then
                    table.insert(faction_patrol_list[source_faction:name()].at_war_with, target_faction:name())
                    out("Faction: " .. source_faction:name() .. " is at war with: " .. target_faction:name());
               end;
               -- if not table.contains(faction_patrol_list[target_faction:name()].at_war_with, source_faction:name()) then
               -- 	table.insert(faction_patrol_list[target_faction:name()].at_war_with, source_faction:name())
               -- 	if test then
               -- 		for k = 1, #faction_patrol_list[target_faction:name()].at_war_with do
               -- 			--out("Faction: " ..target_faction:name().. " is at war with: " ..faction_patrol_list[target_faction:name()].at_war_with[k]);
               -- 		end;
               -- 	end
               -- end;
          end;
     end;
     -- if test then
     -- 	for j = 1, #faction_patrol_list[source_faction:name()].at_war_with do
     -- 		--out("Faction: " ..source_faction:name().. " is at war with: " ..faction_patrol_list[source_faction:name()].at_war_with[j]);
     -- 	end;
     -- end
     return faction_patrol_list[source_faction:name()].at_war_with;
end;

-------------------------------------------------------------------------
-- Return the province patrol that is patrolling in the province provided
-------------------------------------------------------------------------
function get_province_patrol(province_key, faction_se)
     local target_found = false;
     for i = 0, faction_se:military_force_list():num_items() - 1 do
          local target_mf = faction_se:military_force_list():item_at(i);
          local force_type = target_mf:force_type()
          if target_mf:has_effect_bundle("hertz_patrol_bundle") and target_mf:general_character():region():province_name() == province_key then
               target_found = true;
               return target_mf:general_character();
          end;
     end;
     if not target_found then
          out("HERTZ_OUT: Province patrol not found. Returning false.")
          return false;
     end;
end;

----------------------------------------------------------------
-- Returns all owned region in the supplied province_key string
----------------------------------------------------------------
function hertz_get_province_owned_regions(province_key, faction_key, return_owns_entire_province)
     out("Province name = " .. province_key)
     out("faction = " .. faction_key);
     if return_owns_entire_province == nil then
          return_owns_entire_province = false;
     end
     local regions_table = {};
     local regions_added = false;
     local faction_script_interface = cm:get_faction(faction_key)
     local faction_region_list = faction_script_interface:region_list();

     for i = 0, faction_region_list:num_items() - 1 do
          local target_region = faction_region_list:item_at(i);
          if target_region:province_name() == province_key then
               if not table.contains(regions_table, target_region) and not table.contains(region_exclusion, target_region:name()) and target_region:owning_faction():name() == faction_key then
                    regions_added = true;
                    table.insert(regions_table, target_region:name());
                    out("Region inserted [" .. target_region:name() .. "] for [" .. faction_key .. "]");
               end;
          end;
     end;
     out("Regions inserted [" .. table.maxn(regions_table) .. "]");

     for i = 1, table.maxn(regions_table) do
          out("Region inserted [" .. regions_table[i] .. "]");
     end;

     if regions_added then
          if return_owns_entire_province then
               if faction_script_interface:holds_entire_province(province_key, true) then
                    out("Regions adding complete");
                    return regions_table;
               else
                    out("Regions adding failed. faction does not hold entire province.");
                    return {};
               end;
          else
               out("Regions adding complete");
               return regions_table;
          end;
     else
          out("Regions adding failed");
          return {};
     end;
end;

function hertz_get_local_settlement_level(region)
     if is_region(region) then
          return tonumber(region:settlement():primary_slot():building():building_level());
     else
          script_error(
          "ERROR: hertz_get_local_settlement_level() called. But supplied region is not a REGION_SCRIPT_INTERFACE.");
     end;
end;

---------------------------------------------------------------------------------
-- The vampire settlement/patrol rank is also determined by the local corruption.
---------------------------------------------------------------------------------
function hertz_vampire_counts_settlement_rank(settlement_rank, corruption)
     corruption = tonumber(corruption);

     if settlement_rank == 2 then
          if corruption > vamp_unit_lists[settlement_rank].required_corruption then
               return settlement_rank
          else
               return false
          end;
     elseif settlement_rank == 3 then
          if corruption > vamp_unit_lists[settlement_rank].required_corruption then
               return settlement_rank
          else
               hertz_vampire_counts_settlement_rank(settlement_rank - 1, corruption)
          end;
     elseif settlement_rank == 4 then
          if corruption > vamp_unit_lists[settlement_rank].required_corruption then
               return settlement_rank
          else
               hertz_vampire_counts_settlement_rank(settlement_rank - 1, corruption)
          end;
     elseif settlement_rank == 5 then
          if corruption > vamp_unit_lists[settlement_rank].required_corruption then
               return settlement_rank
          else
               hertz_vampire_counts_settlement_rank(settlement_rank - 1, corruption)
          end;
     end;
end;

-----------------------------------------------------------------------------------------------------
-- returns the highest settlement level in the province, or the current rank of the province capital.
-----------------------------------------------------------------------------------------------------
function hertz_get_settlement_level(province_regions, capital)
     if capital then
          for i = 1, #province_regions do
               local target_region = cm:get_region(province_regions[i]);

               if target_region:is_province_capital() then
                    local current_rank = tonumber(target_region:settlement():primary_slot():building():building_level());
                    if cm:get_region(province_regions[i]):owning_faction():subculture() == "wh_main_sc_vmp_vampire_counts" then
                         out("HERTZ_OUT: Vampiric corruption is: [" ..
                         cm:get_corruption_value_in_region(province_regions[1], "wh3_main_corruption_vampiric") .. "]")
                         return hertz_vampire_counts_settlement_rank(current_rank,
                              cm:get_corruption_value_in_region(province_regions[1], "wh3_main_corruption_vampiric"))
                    else
                         return current_rank;
                    end;
               end;
          end;
     else
          local current_rank = tonumber(0);
          for j = 1, #province_regions do
               local target_region = cm:get_region(province_regions[j]);

               if not target_region:is_province_capital() then
                    if target_region:settlement():primary_slot():building():building_level() > current_rank then
                         current_rank = tonumber(target_region:settlement():primary_slot():building():building_level());
                    end;
               end;
          end;
          if province_regions[1]:owning_faction():subculture() == "wh_main_sc_vmp_vampire_counts" then
               out("HERTZ_OUT: Vampiric corruption is: [" ..
               cm:get_corruption_value_in_region(province_regions[1], "wh3_main_corruption_vampiric") .. "]")
               return hertz_vampire_counts_settlement_rank(current_rank,
                    cm:get_corruption_value_in_region(province_regions[1], "wh3_main_corruption_vampiric"))
          else
               return current_rank;
          end;
     end;
end;

-----------------------------------------------------------------------------------------------------------------
-- Removes any patrols that end their turn inside another province owned by a different faction and getting lost.
-- Units are removed when they are found
-----------------------------------------------------------------------------------------------------------------
function clean_lost_patrols(faction_se)
     out("HERTZ_OUT: Cleaning lost patrols for [" .. faction_se:name() .. "]")
     local lost_patrols = {};
     for i = 0, faction_se:military_force_list():num_items() - 1 do
          if string.find(faction_se:military_force_list():item_at(i):general_character():get_forename(), "names_name_5003") then
               out(faction_se:military_force_list():item_at(i):general_character():get_forename())
               if not faction_se:military_force_list():item_at(i):has_effect_bundle("hertz_patrol_bundle") then
                    out("Invalid patrol found: No patrol effect bundle.")
                    table.insert(lost_patrols,
                         faction_se:military_force_list():item_at(i):general_character():command_queue_index())
               end
          end;
          if faction_se:military_force_list():item_at(i):has_effect_bundle("hertz_patrol_bundle") then
               out("Patrol found")
               local target_patrol_force = faction_se:military_force_list():item_at(i)
               local target_region = target_patrol_force:general_character():region();

               if not target_region:is_abandoned() then
                    local target_region_owner = target_patrol_force:general_character():region():owning_faction();
                    out("Target province is [" ..
                    target_region:province_name() ..
                    "] - Patrol in region [" .. target_region:name() .. "] - Owned by [" ..
                    target_region_owner:name() .. "]")

                    if faction_se:name() == "wh2_dlc13_lzd_defenders_of_the_great_plan" or faction_se:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" then
                         if target_region_owner:holds_entire_province(target_region:province_name(), true) and target_region_owner:name() ~= "wh2_dlc13_lzd_defenders_of_the_great_plan" and target_region_owner:name() ~= "wh2_dlc13_lzd_spirits_of_the_jungle" then
                              out("Lost patrol found attempting to kill def great plan")
                              table.insert(lost_patrols, target_patrol_force:general_character():command_queue_index())
                         end;
                    else
                         if target_region_owner:holds_entire_province(target_region:province_name(), true) and target_region_owner ~= faction_se then
                              out("Lost patrol found attempting to kill")
                              table.insert(lost_patrols, target_patrol_force:general_character():command_queue_index())
                         end;
                    end;
               else
                    local owned_region_found = false;

                    for j = 0, faction_se:region_list():num_items() - 1 do
                         if faction_se:region_list():item_at(j):province_name() == target_region:province_name() then
                              owned_region_found = true;
                         end;
                    end;

                    if not owned_region_found then
                         out("Lost patrol found attempting to kill")
                         table.insert(lost_patrols, target_patrol_force:general_character():command_queue_index())
                    end;
               end;
          end;
     end;
     out("Lost patrols found [" .. table.concat(lost_patrols, ", ") .. "]")
     for k = 1, #lost_patrols do
          cm:callback(
               function()
                    cm:kill_character(lost_patrols[k], true, false);
               end,
               0.1,
               "close_panel_callback"
          )
     end;
end;

--------------------------------------------------------------------------------------------------------------
-- Returns the distance between 2 objects provided to the function
-- These objects can be a REGION_SCRIPT_INTERFACE, CHARACTER_SCRIPT_INTERFACE, or SETTLEMENT_SCRIPT_INTERFACE
--------------------------------------------------------------------------------------------------------------
function get_distance_between_objects(source_obj, target_obj)
     if is_region(source_obj) then
          source_obj = source_obj:settlement()
     end;
     if is_region(target_obj) then
          target_obj = target_obj:settlement()
     end;
     local obj_1 = {}
     local obj_2 = {}
     if is_region(source_obj) or is_character(source_obj) or is_settlement(source_obj) then
          obj_1.pos = { source_obj:logical_position_x(), source_obj:logical_position_y() }
     else
          script_error(
          "get_distance_between_objects() called but supplied source object is not a Region Object, Settlement Object or Character Object")
     end;
     if is_region(source_obj) or is_character(source_obj) or is_settlement(target_obj) then
          obj_2.pos = { target_obj:logical_position_x(), target_obj:logical_position_y() }
     else
          script_error(
          "get_distance_between_objects() called but supplied target object is not a Region Object, Settlement Object or Character Object")
     end;

     --out("Distance between forces ["..distance_squared(obj_1.pos[1], obj_1.pos[2], obj_2.pos[1], obj_2.pos[2]).."] meters")
     return distance_squared(obj_1.pos[1], obj_1.pos[2], obj_2.pos[1], obj_2.pos[2]);
end;

--------------------------------------------------------------------------------------------
-- Goes through every region in the given list to remove any patrol bundles that are active.
--------------------------------------------------------------------------------------------
function remove_patrol_bundle(province_regions)
     for i = 1, #province_regions do
          if cm:get_region(province_regions[i]):has_effect_bundle("hertz_patrol_alive_bundle") then
               cm:remove_effect_bundle_from_region("hertz_patrol_alive_bundle", cm:get_region(province_regions[i]):name());
               cm:remove_effect_bundle_from_region("hertz_tk_patrol_ambush_bundle",
                    cm:get_region(province_regions[i]):name());
          end;
     end;
end;

---------------------------------------------------------------------------------------
-- Function that takes a string and splits it to a table according to input seperators.
-- Professionally copy-pasted from StackOverflow
---------------------------------------------------------------------------------------
function hertz_split_str(inputstr, sep)
     local t = {}
     if inputstr == nil or inputstr == "" then
          script_error("ERROR: input string is empty")
     else
          if sep == nil then
               sep = "%s"
          end;

          for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
               table.insert(t, str)
          end;

          return t
     end;
end;

-------------------------------------------
-- Generate the unit lists for new patrols.
-------------------------------------------
function hertz_generate_patrol_unit_list(target_subculture, faction_key, settlement_level)
     local ram_force_numbers = {};

     -- When generating Bretonnia patrols, use their custom unit type number list.
     if target_subculture == "wh_main_sc_brt_bretonnia" then
          ram_force_numbers = brettonia_patrol_settings[settlement_level];

          -- When generating Bretonnia patrols, use their custom unit type number list.
     elseif target_subculture == "wh_dlc05_sc_wef_wood_elves" then
          ram_force_numbers = ram_unit_lists["wef_patrols"];

          -- When generating Vampire Counts patrols, their own custom spawning which helped build this one
     elseif target_subculture == "wh_main_sc_vmp_vampire_counts" then
          return generate_vamp_unit_lists(target_subculture, faction_key, settlement_level)

          -- When generating Bretonnia patrols, use their custom unit type number list.
     elseif faction_key == "wh2_dlc13_lzd_spirits_of_the_jungle" then
          ram_force_numbers = ram_unit_lists["nekai_patrols"];

          -- Default patrol force unit type numbers.
     else
          ram_force_numbers = ram_unit_lists[settlement_level];
     end;

     -- Get the patrol unit list per subculture.
     local ram_force_units = ram_unit_lists[target_subculture];

     -- Check if the subculture has special patrol setups.
     if ram_unit_lists[target_subculture].faction_custom_patrols.enabled == true then
          if table.contains(ram_unit_lists[target_subculture].faction_custom_patrols.factions, faction_key) then
               -- Full custom unit list per predetermined factions
               if ram_unit_lists[target_subculture].faction_custom_patrols.type == "full" then
                    ram_force_units = ram_unit_lists[target_subculture].faction_custom_patrols[faction_key];

                    -- Custom commander per predetermined faction
               elseif ram_unit_lists[target_subculture].faction_custom_patrols.type == "com" then
                    ram_force_units.com = ram_unit_lists[target_subculture].faction_custom_patrols[faction_key].com
               end;
          end;
     end;

     -- Generate the full force list
     random_army_manager:remove_force("new_patrol_force_" .. faction_key)
     random_army_manager:new_force("new_patrol_force_" .. faction_key)
     for i = 1, ram_force_numbers.inf_mel do
          -- Generate melee infantry
          random_number = cm:random_number(table.maxn(ram_force_units.inf_mel), 1)
          random_army_manager:add_mandatory_unit("new_patrol_force_" .. faction_key,
               ram_force_units.inf_mel[random_number], 1)
     end
     for i = 1, ram_force_numbers.inf_mis do
          -- Generate missile infantry
          random_number = cm:random_number(table.maxn(ram_force_units.inf_mis), 1)
          random_army_manager:add_mandatory_unit("new_patrol_force_" .. faction_key,
               ram_force_units.inf_mis[random_number], 1)
     end
     for i = 1, ram_force_numbers.large do
          -- Generate large units
          random_number = cm:random_number(table.maxn(ram_force_units.large), 1)
          random_army_manager:add_mandatory_unit("new_patrol_force_" .. faction_key, ram_force_units.large
          [random_number], 1)
     end
     for i = 1, ram_force_numbers.random do
          -- Generate random other/specialized units
          random_number = cm:random_number(table.maxn(ram_force_units.random), 1)
          random_army_manager:add_mandatory_unit("new_patrol_force_" .. faction_key,
               ram_force_units.random[random_number], 1)
     end

     -- Create and return full unit list.
     return random_army_manager:generate_force("new_patrol_force_" .. faction_key, ram_force_numbers.force_size, false);
end;

function generate_vamp_unit_lists(target_subculture, faction_key, settlement_level)
     local ram_force_numbers = {};

     ram_force_units = vamp_unit_lists[settlement_level];

     local ram_force_numbers = vamp_unit_lists["force_size"];


     random_army_manager:new_force("new_patrol_force_" .. faction_key)
     for i = 1, ram_force_numbers.inf_mel do
          random_number = cm:random_number(table.maxn(ram_force_units.inf_mel), 1)
          random_army_manager:add_mandatory_unit("new_patrol_force_" .. faction_key,
               ram_force_units.inf_mel[random_number], 1)
     end
     for i = 1, ram_force_numbers.inf_mis do
          random_number = cm:random_number(table.maxn(ram_force_units.inf_mis), 1)
          random_army_manager:add_mandatory_unit("new_patrol_force_" .. faction_key,
               ram_force_units.inf_mis[random_number], 1)
     end
     for i = 1, ram_force_numbers.large do
          random_number = cm:random_number(table.maxn(ram_force_units.large), 1)
          random_army_manager:add_mandatory_unit("new_patrol_force_" .. faction_key, ram_force_units.large
          [random_number], 1)
     end
     for i = 1, ram_force_numbers.random do
          random_number = cm:random_number(table.maxn(ram_force_units.random), 1)
          random_army_manager:add_mandatory_unit("new_patrol_force_" .. faction_key,
               ram_force_units.random[random_number], 1)
     end

     return random_army_manager:generate_force("new_patrol_force_" .. faction_key, ram_force_numbers.force_size, false);
end;

----------------------------------------------------------------------------------------------------
-- Adds treasury or experience according to the dilemma reward effects on any of the players forces.
----------------------------------------------------------------------------------------------------
function check_dilemma_rewards(target_faction)
     local mil_force_list = target_faction:military_force_list()
     local payload = nil;
     local gold_amount = 0;
     local exp_amount = 0;
     for i = 0, mil_force_list:num_items() - 1 do
          if mil_force_list:item_at(i):has_effect_bundle("hertz_raid_caravan_bundle_1") then
               cm:remove_effect_bundle_from_force("hertz_raid_caravan_bundle_1",
                    mil_force_list:item_at(i):command_queue_index())
               gold_amount = cm:random_number(500, 100);
               cm:trigger_custom_incident(target_faction:name(), "hertz_caravans_incident", true,
                    "payload{money " .. gold_amount .. ";}");
          elseif mil_force_list:item_at(i):has_effect_bundle("hertz_raid_caravan_bundle_2") then
               cm:remove_effect_bundle_from_force("hertz_raid_caravan_bundle_2",
                    mil_force_list:item_at(i):command_queue_index())
               gold_amount = cm:random_number(1000, 400);
               cm:trigger_custom_incident(target_faction:name(), "hertz_caravans_incident", true,
                    "payload{money " .. gold_amount .. ";}");
          elseif mil_force_list:item_at(i):has_effect_bundle("hertz_raid_caravan_bundle_3") then
               cm:remove_effect_bundle_from_force("hertz_raid_caravan_bundle_3",
                    mil_force_list:item_at(i):command_queue_index())
               gold_amount = cm:random_number(1500, 600);
               cm:trigger_custom_incident(target_faction:name(), "hertz_caravans_incident", true,
                    "payload{money " .. gold_amount .. ";}");
          elseif mil_force_list:item_at(i):has_effect_bundle("hertz_raid_caravan_bundle_4") then
               cm:remove_effect_bundle_from_force("hertz_raid_caravan_bundle_4",
                    mil_force_list:item_at(i):command_queue_index())
               gold_amount = cm:random_number(2000, 1000);
               cm:trigger_custom_incident(target_faction:name(), "hertz_caravans_incident", true,
                    "payload{money " .. gold_amount .. ";}");
          elseif mil_force_list:item_at(i):has_effect_bundle("hertz_raid_caravan_bundle_5") then
               cm:remove_effect_bundle_from_force("hertz_raid_caravan_bundle_5",
                    mil_force_list:item_at(i):command_queue_index())
               gold_amount = cm:random_number(2500, 1200);
               cm:trigger_custom_incident(target_faction:name(), "hertz_caravans_incident", true,
                    "payload{money " .. gold_amount .. ";}");
          end;

          if mil_force_list:item_at(i):has_effect_bundle("hertz_raid_settlement_bundle_1") then
               cm:remove_effect_bundle_from_force("hertz_raid_settlement_bundle_1",
                    mil_force_list:item_at(i):command_queue_index())
               exp_amount = cm:random_number(500, 100);
               cm:add_agent_experience(
               cm:char_lookup_str(mil_force_list:item_at(i):general_character():command_queue_index()), exp_amount, false)
               cm:add_experience_to_units_commanded_by_character(
               cm:char_lookup_str(mil_force_list:item_at(i):general_character():command_queue_index()), 1);
          elseif mil_force_list:item_at(i):has_effect_bundle("hertz_raid_settlement_bundle_2") then
               cm:remove_effect_bundle_from_force("hertz_raid_settlement_bundle_2",
                    mil_force_list:item_at(i):command_queue_index())
               exp_amount = cm:random_number(1000, 400);
               cm:add_agent_experience(
               cm:char_lookup_str(mil_force_list:item_at(i):general_character():command_queue_index()), exp_amount, false)
               cm:add_experience_to_units_commanded_by_character(
               cm:char_lookup_str(mil_force_list:item_at(i):general_character():command_queue_index()), 2);
          elseif mil_force_list:item_at(i):has_effect_bundle("hertz_raid_settlement_bundle_3") then
               cm:remove_effect_bundle_from_force("hertz_raid_settlement_bundle_3",
                    mil_force_list:item_at(i):command_queue_index())
               exp_amount = cm:random_number(1500, 600);
               cm:add_agent_experience(
               cm:char_lookup_str(mil_force_list:item_at(i):general_character():command_queue_index()), exp_amount, false)
               cm:add_experience_to_units_commanded_by_character(
               cm:char_lookup_str(mil_force_list:item_at(i):general_character():command_queue_index()), 3);
          end;
     end;
end;

-----------------------------------------------------------------------------------------------------
-- Returns faction corruption type based on FACTION_SCRIPT_INTERFACE or a faction name string object
-- Returns the following strings:
--	 - wh3_main_corruption_vampiric
--	 - wh3_main_corruption_slaanesh
--	 - wh3_main_corruption_chaos
--	 - wh3_main_corruption_khorne
--	 - wh3_main_corruption_skaven
--	 - wh3_main_corruption_nurgle
--	 - wh3_main_corruption_tzeentch
--	 - hertz_corruption_type_neutral
-- ("hertz_corruption_type_neutral" is not a variable used by CA, use it for your own validation)
-----------------------------------------------------------------------------------------------------
function hertz_get_corruption_type(faction_input)
     local faction = nil;
     -- All the corruption types per faction and subculture
     local hertz_corruption_data = {
          ["wh2_dlc09_sc_tmb_tomb_kings"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh2_dlc11_sc_cst_vampire_coast"] = {
               corruption_type = "wh3_main_corruption_vampiric",
               faction_specific = false,
          },
          ["wh2_main_sc_def_dark_elves"] = {
               corruption_type = "",
               faction_specific = {
                    ["wh2_main_def_cult_of_pleasure"] = "wh3_main_corruption_slaanesh",
               },
          },
          ["wh2_main_sc_hef_high_elves"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh2_main_sc_lzd_lizardmen"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh2_main_sc_skv_skaven"] = {
               corruption_type = "wh3_main_corruption_skaven",
               faction_specific = false,
          },
          ["wh3_main_sc_cth_cathay"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh3_main_sc_dae_daemons"] = {
               corruption_type = "wh3_main_corruption_chaos",
               faction_specific = false,
          },
          ["wh3_main_sc_kho_khorne"] = {
               corruption_type = "wh3_main_corruption_khorne",
               faction_specific = false,
          },
          ["wh3_main_sc_ksl_kislev"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh3_main_sc_nur_nurgle"] = {
               corruption_type = "wh3_main_corruption_nurgle",
               faction_specific = false,
          },
          ["wh3_main_sc_ogr_ogre_kingdoms"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh3_main_sc_sla_slaanesh"] = {
               corruption_type = "wh3_main_corruption_slaanesh",
               faction_specific = false,
          },
          ["wh3_main_sc_tze_tzeentch"] = {
               corruption_type = "wh3_main_corruption_tzeentch",
               faction_specific = false,
          },
          ["wh_dlc03_sc_bst_beastmen"] = {
               corruption_type = "wh3_main_corruption_chaos",
               faction_specific = false,
          },
          ["wh_dlc05_sc_wef_wood_elves"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh_dlc08_sc_nor_norsca"] = {
               corruption_type = "wh3_main_corruption_chaos",
               faction_specific = false,
          },
          ["wh_main_sc_brt_bretonnia"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh_main_sc_chs_chaos"] = {
               corruption_type = "wh3_main_corruption_chaos",
               faction_specific = false,
          },
          ["wh_main_sc_dwf_dwarfs"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh_main_sc_emp_empire"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh_main_sc_grn_greenskins"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh_main_sc_grn_savage_orcs"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh_main_sc_teb_teb"] = {
               corruption_type = "",
               faction_specific = false,
          },
          ["wh_main_sc_vmp_vampire_counts"] = {
               corruption_type = "wh3_main_corruption_vampiric",
               faction_specific = false,
          },
     }

     -- Input validation
     -- converts input into FACTION_SCRIPT_INTERFACE if its a valid faction string.
     if is_string(faction_input) then
          if is_faction(cm:get_faction(faction_input)) then
               faction = cm:get_faction(faction_input);
          else
               script_error("SCRIPT_ERROR: faction input is a string but not a valid faction: [" .. faction_input .. "]")
          end;
     else
          faction = faction_input
     end;

     -- Check if loaded faction is a valid FACTION_SCRIPT_INTERFACE
     if is_faction(faction) then
          local subculture = faction:subculture();
          local faction_name = faction:name();
          local corruption_type = "";

          -- Grabs neutral corruption if data type is empty
          if hertz_corruption_data[subculture].corruption_type == "" then
               corruption_type = "hertz_corruption_type_neutral";
               -- Grabs corruption type if a faction specific corruption is featured
          elseif hertz_corruption_data[subculture].corruption_type ~= "" and hertz_corruption_data[subculture].faction_specific ~= false then
               corruption_type = hertz_corruption_data[subculture].faction_specific[faction_name];
               -- Grabs corruption type if the entire subculture uses the same corruption.
          else
               corruption_type = hertz_corruption_data[subculture].corruption_type;
          end
          return corruption_type;
     else
          script_error("SCRIPT_ERROR: faction_input is not a valid FACTION_SCRIPT_INTERFACE or string: [" ..
          faction_input .. "]")
     end
end;

function hertz_table_contains_string(tab1, obj1)
     if not is_string(obj1) then
          obj1 = tostring(obj1)
     end;
     -- out("HERTZ_API: obj 1 is: ["..obj1.."]")

     for i = 1, #tab1 do
          local obj2 = tostring(tab1[i]);
          -- out("HERTZ_API: obj 2 is: ["..obj2.."]")
          if obj1 == obj2 then
               return true
          end
     end;
     return false;
end;
