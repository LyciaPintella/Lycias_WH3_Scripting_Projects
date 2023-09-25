local script_author = "8 Hertz WAN IP"
local script_version = 2.0
local mod_name = "bretonniatwo_rename"

out(mod_name .. " script version V0." .. script_version .. " - Made by " .. script_author);

local rename_bre_bretonniatwo = {
     -- This is a template key for explanation and variable explanations
     -- The top section is for the name update conditions. What does the game check for when the name needs to update.
     -- The names of the conditions will always need to be [requirements_#] where # is the "update_id" of the name change the condition is for
     ["REQUIREMENTS_TEMPLATE"] = {
          -- include specifc factions for this rename condition, when including "factions_exclude" MUST be empty.
          factions_include = "",
          -- Exclude specifc factions for this rename condition, when including "factions_include" MUST be empty.
          factions_exclude = "",
          -- the number of provinces required to start checking the provinces themselves
          province_count = 0,
          -- What provinces need to be checked for when updating
          provinces = {""},
          -- the number of regions required to rename the faction
          region_count = 0,
          -- New or custom conditions can be added easily, you just need to create a function that is linked to it.
          custom_condition = nil
     },
     -- BRETONNIA Origo Two
     ["requirements_1"] = {factions_include = {"wh2_main_brt_knights_of_origo"}, factions_exclude = "", region_count = 6},
     -- BRETONNIA Artois Two
     ["requirements_2"] = {factions_include = {"wh_main_brt_artois"}, factions_exclude = "", region_count = 6},
     -- BRETONNIA Three
     ["requirements_3"] = {factions_include = {"wh_main_brt_artois"}, factions_exclude = "", region_count = 15},
     -- BRETONNIA Four
     ["requirements_4"] = {factions_include = {"wh_main_brt_artois"}, factions_exclude = "", region_count = 30},
     -- BRETONNIA Bastonne Two
     ["requirements_5"] = {factions_include = {"wh_main_brt_bastonne"}, factions_exclude = "", region_count = 6},
     -- BRETONNIA Three
     ["requirements_6"] = {factions_include = {"wh_main_brt_bastonne"}, factions_exclude = "", region_count = 15},
     -- BRETONNIA Four
     ["requirements_7"] = {factions_include = {"wh_main_brt_bastonne"}, factions_exclude = "", region_count = 30},
     -- BRETONNIA Lyonesse Two
     ["requirements_8"] = {factions_include = {"wh_main_brt_lyonesse"}, factions_exclude = "", region_count = 6},
     -- BRETONNIA Three
     ["requirements_9"] = {factions_include = {"wh_main_brt_lyonesse"}, factions_exclude = "", region_count = 15},
     -- BRETONNIA Four
     ["requirements_10"] = {factions_include = {"wh_main_brt_lyonesse"}, factions_exclude = "", region_count = 30},
     -- BRETONNIA Parr Two
     ["requirements_11"] = {factions_include = {"wh_main_brt_parravon"}, factions_exclude = "", region_count = 6},
     -- BRETONNIA Three
     ["requirements_12"] = {factions_include = {"wh_main_brt_parravon"}, factions_exclude = "", region_count = 15},
     -- BRETONNIA Four
     ["requirements_13"] = {factions_include = {"wh_main_brt_parravon"}, factions_exclude = "", region_count = 30},
     -- This is a template key for explanation and variable explanations
     -- The bottom section is for the different names this faction can unlock.
     -- Each name will need to have a numbered "update_id" to link it to the requirements
     ["UPDATE_TEMPLATE"] = {
          -- The faction currently holding the title. THIS VARIABLE IS NOT DEFINED IN THE name_updates TABLE BUT IN SCRIPT.
          faction_title_holder = "",
          -- update_id is linked to the triggering condition
          update_id = 0,
          -- What listener triggers the name_change
          event_trigger = "",
          -- .loc key of the new faction name
          new_name = "LOC_KEY",
          -- This string is for selecting the conditions the script will pick for updating
          conditions = {""}
     },
     -- BRETONNIA Main Two
     ["name_update_1"] = {
          faction_title_holder = "none",
          update_id = 1,
          event_trigger = "region_capture",
          new_name = "faction_name_origo_two",
          conditions = {"region_count"}
     },
     -- BRETONNIA Bordeleaux Two
     ["name_update_2"] = {
          faction_title_holder = "none",
          update_id = 2,
          event_trigger = "region_capture",
          new_name = "faction_name_bretart_two",
          conditions = {"region_count"}
     },
     -- BRETONNIA Carcassonne Two
     ["name_update_3"] = {
          faction_title_holder = "none",
          update_id = 3,
          event_trigger = "region_capture",
          new_name = "faction_name_bretart_three",
          conditions = {"region_count"}
     },
     -- BRETONNIA Main Three
     ["name_update_4"] = {
          faction_title_holder = "none",
          update_id = 4,
          event_trigger = "region_capture",
          new_name = "faction_name_bretart_four",
          conditions = {"region_count"}
     },
     -- BRETONNIA Main Four
     ["name_update_5"] = {
          faction_title_holder = "none",
          update_id = 5,
          event_trigger = "region_capture",
          new_name = "faction_name_bretbast_two",
          conditions = {"region_count"}
     },
     -- BRETONNIA Bordeleaux Four
     ["name_update_6"] = {
          faction_title_holder = "none",
          update_id = 6,
          event_trigger = "region_capture",
          new_name = "faction_name_bretbast_three",
          conditions = {"region_count"}
     },
     -- BRETONNIA Carcassonne Four
     ["name_update_7"] = {
          faction_title_holder = "none",
          update_id = 7,
          event_trigger = "region_capture",
          new_name = "faction_name_bretbast_four",
          conditions = {"region_count"}
     },
     -- BRETONNIA Crusaders Two
     ["name_update_8"] = {
          faction_title_holder = "none",
          update_id = 8,
          event_trigger = "region_capture",
          new_name = "faction_name_bretlys_two",
          conditions = {"region_count"}
     },
     -- BRETONNIA Crusaders Three
     ["name_update_9"] = {
          faction_title_holder = "none",
          update_id = 9,
          event_trigger = "region_capture",
          new_name = "faction_name_bretlys_three",
          conditions = {"region_count"}
     },
     -- BRETONNIA Crusaders Four
     ["name_update_10"] = {
          faction_title_holder = "none",
          update_id = 10,
          event_trigger = "region_capture",
          new_name = "faction_name_bretlys_four",
          conditions = {"region_count"}
     },
     -- BRETONNIA Crusaders Two
     ["name_update_11"] = {
          faction_title_holder = "none",
          update_id = 11,
          event_trigger = "region_capture",
          new_name = "faction_name_bretpav_two",
          conditions = {"region_count"}
     },
     -- BRETONNIA Crusaders Three
     ["name_update_12"] = {
          faction_title_holder = "none",
          update_id = 12,
          event_trigger = "region_capture",
          new_name = "faction_name_bretpav_three",
          conditions = {"region_count"}
     },
     -- BRETONNIA Crusaders Four
     ["name_update_13"] = {
          faction_title_holder = "none",
          update_id = 13,
          event_trigger = "region_capture",
          new_name = "faction_name_bretpav_four",
          conditions = {"region_count"}
     }
};

--[[
Changed faction_title_holder from "" to "none" to stop errors from saving the value to registry
]]

local bretonniatwo_rename_fac_list = {"wh_main_brt_artois", "wh_main_brt_bastonne", "wh2_main_brt_knights_of_origo", "wh_main_brt_parravon", "wh_main_brt_lyonesse"};

--- @function table_contains
--- @desc Returns true if the supplied indexed table contains the supplied object.
--- @p table subject table
--- @p object object
--- @return boolean table contains object
function table_contains(t, obj)
     for i = 1, #t do if t[i] == obj then return true; end end
     return false;
end

function bretonniatwo_rename_run_conditions(context, triggering_event, faction_key)
     out("HERTZ_OUT: picking target name_update.")
     local target_name_id = bretonniatwo_rename_setup_name_update(1, faction_key);
     local name_update = "name_update_" .. target_name_id;
     local requirements_table = "requirements_" .. target_name_id;
     local captured_region = context;
     local conditions_met = true;
     local title_holder = "";
     out(name_update);
     out(requirements_table);

     out("Checking title holders.")
     if rename_bre_bretonniatwo[name_update].faction_title_holder ~= nil and rename_bre_bretonniatwo[name_update].faction_title_holder ~= "none" then
          title_holder = rename_bre_bretonniatwo[name_update].faction_title_holder
          out("Title holder is: " .. title_holder);
     else
          out("Title holder is empty");
     end

     for i = 1, #rename_bre_bretonniatwo[name_update].conditions do
          local name_update_conditon = rename_bre_bretonniatwo[name_update].conditions[i]
          out("Condition is: " .. name_update_conditon);

          if triggering_event == "provinces" and name_update_conditon == triggering_event and conditions_met == true then
               out("Executing condition provinces");
               conditions_met = bretonniatwo_rename_check_provinces(captured_region, title_holder, name_update, requirements_table)
          end

          if name_update_conditon == "region_count" and conditions_met == true then
               out("Executing region_count provinces");
               conditions_met = bretonniatwo_rename_region_count(faction_key, title_holder, name_update, requirements_table);
          end
     end
     if conditions_met == true then
          cm:change_localised_faction_name(faction_key, "campaign_localised_strings_string_" .. rename_bre_bretonniatwo[name_update].new_name);
          if title_holder ~= nil and title_holder ~= "none" then
               cm:change_localised_faction_name(rename_bre_bretonniatwo[name_update].faction_title_holder, "factions_screen_name_" .. faction_key);
          end
          rename_bre_bretonniatwo[name_update].faction_title_holder = faction_key;
          out("HERTZ OUT: Faction renamed");
          out("New title holder is: " .. rename_bre_bretonniatwo[name_update].faction_title_holder);
     end
end

--[[
Added line: out("New title holder is: " ..rename_bre_bretonniatwo[name_update].faction_title_holder);

Changed rename_bre_bretonniatwo[name_update].faction_title_holder = faction_key; from rename_bre_bretonniatwo[name_update_table].faction_title_holder = faction_key;

Added rename_bre_bretonniatwo[name_update].faction_title_holder ~= "none" then to the title holder check

renamed name_holder variable to title_holder

replaced rename_bre_bretonniatwo[name_update].faction_title_holder with title_holder after checking title holders

added Else to if rename_bre_bretonniatwo[name_update].faction_title_holder ~= nil and rename_bre_bretonniatwo[name_update].faction_title_holder ~= "" then
]]

function bretonniatwo_rename_region_count(faction_key, faction_title_holder, name_update_table, requirements_table)
     out("HERTZ_OUT: Counting regions")
     if cm:get_faction(faction_key):region_list():num_items() >= rename_bre_bretonniatwo[requirements_table].region_count then
          out("Region count reached")
          return true;
     else
          out("Region count not reached")
          return false;
     end
end

function bretonniatwo_rename_check_provinces(region_script_interface, faction_title_holder, name_update_table, requirements_table)
     out("HERTZ_OUT Checking secured province.")
     local target_region = region_script_interface;
     local target_province = target_region:province_name();
     local triggering_faction = target_region:owning_faction();
     local conditions_met = false;
     local title_holder_provinces_table = {count = 0, provinces = {}}
     out(target_province);
     out(triggering_faction:name());

     -- check if captured province is secured
     if triggering_faction:holds_entire_province(target_province, false) == true then
          out("HERTZ_OUT | Faction: " .. triggering_faction:name() .. " has secured the province " .. target_province);
          local provinces_check_table = bretwo_rename_count_owned_provinces(triggering_faction);

          if faction_title_holder ~= "" then
               out("Name already taken, comparing province count")
               title_holder_provinces_table = bretwo_rename_count_owned_provinces(cm:get_faction(faction_title_holder));
          end

          if provinces_check_table.count >= rename_bre_bretonniatwo[requirements_table].province_count and provinces_check_table.count >
               title_holder_provinces_table.count then
               out("Required provinces count reached")

               if table_contains(rename_bre_bretonniatwo[requirements_table].provinces, target_province) then
                    for i = 1, #rename_bre_bretonniatwo[requirements_table].provinces do
                         local required_province = rename_bre_bretonniatwo[requirements_table].provinces[i]
                         out("checking required province " .. required_province)

                         if table_contains(provinces_check_table.provinces, required_province) then
                              out("Province " .. required_province .. " secured")
                              conditions_met = true
                         else
                              out("Province " .. required_province .. " not owned, breaking loop")
                              conditions_met = false
                              break
                         end
                    end
                    if conditions_met == true then
                         return true;
                    else
                         return false;
                    end
               end
          end
     else
          out("Province not secured")
     end
end

function bretwo_rename_count_owned_provinces(triggering_faction)
     out("HERTZ_OUT | Counting provinces for " .. triggering_faction:name());
     local faction_province_table = {count = 0, provinces = {}}
     local fac_region_list = triggering_faction:region_list();
     -- previous region used for the for loop
     local prev_region = fac_region_list:item_at(1);
     local counted_provinces = 0;

     -- Check all owned provinces for name change
     for i = 0, fac_region_list:num_items() - 1 do
          local selected_region = fac_region_list:item_at(i)

          if table_contains(faction_province_table.provinces, selected_region:province_name()) == false then
               if selected_region:province_name() ~= prev_region:province_name() or i == 0 then
                    out("Checking Region " .. i .. " : " .. selected_region:name());
                    out("Checking province: " .. selected_region:province_name());
                    local checking_province = selected_region:province_name();

                    if triggering_faction:holds_entire_province(selected_region:province_name(), false) == true then
                         out("Province owned")
                         counted_provinces = counted_provinces + 1;
                         faction_province_table.count = counted_provinces
                         out("Provinces counted: " .. faction_province_table.count)
                         table.insert(faction_province_table.provinces, checking_province)
                         out("Province added");
                         out(table.concat(faction_province_table.provinces, ", "))
                         prev_region = selected_region;
                    else
                         prev_region = selected_region;
                    end
               end
          end
     end
     return faction_province_table;
end

function bretonniatwo_rename_setup_name_update(update_id, faction_key)
     local name_update_result = "";
     local name_id = update_id

     -- Cycle through all rename updates til a valid one has been found.
     while name_update_result == "" do
          out("Checking name update " .. name_id)
          if bretonniatwo_rename_name_update_availability(true, faction_key, name_id) == true or
               bretonniatwo_rename_name_update_availability(false, faction_key, name_id) == true then
               if rename_bre_bretonniatwo["name_update_" .. name_id].faction_title_holder == faction_key then
                    name_id = name_id + 1;
               else
                    name_update_result = name_id
                    return name_update_result;
               end
          elseif rename_bre_bretonniatwo["name_update_" .. name_id].faction_title_holder == faction_key then
               name_id = name_id + 1;
          else
               name_id = name_id + 1;
          end

          if name_id == 20 then break end
     end
end

-- Check if the faction is included or excluded for this rename change.
-- included_faction = true, to check include
-- included_faction = false, to check exclude
function bretonniatwo_rename_name_update_availability(included_faction, faction_key, update_id)
     if rename_bre_bretonniatwo["requirements_" .. update_id].factions_include == "" and rename_bre_bretonniatwo["requirements_" .. update_id].factions_exclude == "" then
          return true

     elseif included_faction == true then
          for i = 1, #rename_bre_bretonniatwo["requirements_" .. update_id].factions_include do
               local target_faction = rename_bre_bretonniatwo["requirements_" .. update_id].factions_include[i];
               out("target_faction: " .. target_faction)

               if target_faction == faction_key then return true; end
          end
          return false;
     elseif included_faction == false then
          for i = 1, #rename_bre_bretonniatwo["requirements_" .. update_id].factions_exclude do
               local target_faction = rename_bre_bretonniatwo["requirements_" .. update_id].factions_exclude[i];
               out("target_faction: " .. target_faction)

               if target_faction == faction_key then return true; end
          end
          return false;
     end
end

-- Sets the faction and ungrim variables for use in script.
-- Sets up all listeners and is reserved for other possible variables that need to be set every time the lua environment is build
function bretonniatwo_rename_init()

     -- sets variables needed for mod updates
     if cm:get_saved_value("mod_version_v0." .. script_version) == nil then cm:set_saved_value("mod_version_v0." .. script_version, true); end
     -- Sets variables needed from turn one
     if cm:get_saved_value(mod_name .. "_turn_one_init") == nil then
          -- Sets names for factions needing already owning a rename region from turn one
          for i = 1, #bretonniatwo_rename_fac_list do
               local faction_key = bretonniatwo_rename_fac_list[i];
               out("Setup listeners for" .. faction_key)
               core:add_listener(faction_key .. "_FactionBeginTurnPhaseNormal", "FactionBeginTurnPhaseNormal",
                                 function(context) return context:faction():name() == faction_key; end, function(context)
                    local target_region = context:faction():region_list():item_at(0);
                    bretonniatwo_rename_run_conditions(target_region, "provinces", faction_key)
               end, false);
          end
          cm:set_saved_value(mod_name .. "_turn_one_init", true);
     end

     create_bretonniatwo_rename_listeners()
end

function create_bretonniatwo_rename_listeners()
     out("###### HERTZ_OUT: Creating Kislev Rename Listeners ######")
     for i = 1, #bretonniatwo_rename_fac_list do
          local faction_key = bretonniatwo_rename_fac_list[i];
          out("Setup listeners for" .. faction_key)
          core:add_listener(faction_key .. "_FactionBeginTurnPhaseNormal", "FactionBeginTurnPhaseNormal",
                            function(context) return context:faction():name() == faction_key; end, function(context) end, true);
          core:add_listener(faction_key .. "_RegionFactionChangeEvent", "RegionFactionChangeEvent",
                            function(context) return context:region():owning_faction():name() == faction_key; end,
                            function(context) bretonniatwo_rename_run_conditions(context:region(), "provinces", faction_key) end, true);
     end
end
cm:add_first_tick_callback(function() bretonniatwo_rename_init() end);

-----------------------------------------------------------------
---------------------======Save Game======-----------------------
-----------------------------------------------------------------

function bretonniatwo_rename_saved_game()
    cm:set_saved_value("brttwo_title_holder_1", rename_bre_bretonniatwo["name_update_1"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_2", rename_bre_bretonniatwo["name_update_2"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_3", rename_bre_bretonniatwo["name_update_3"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_4", rename_bre_bretonniatwo["name_update_4"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_5", rename_bre_bretonniatwo["name_update_5"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_6", rename_bre_bretonniatwo["name_update_6"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_7", rename_bre_bretonniatwo["name_update_7"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_8", rename_bre_bretonniatwo["name_update_8"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_9", rename_bre_bretonniatwo["name_update_9"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_10", rename_bre_bretonniatwo["name_update_10"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_11", rename_bre_bretonniatwo["name_update_11"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_12", rename_bre_bretonniatwo["name_update_12"].faction_title_holder);
    cm:set_saved_value("brttwo_title_holder_13", rename_bre_bretonniatwo["name_update_13"].faction_title_holder);
end
cm:add_saving_game_callback(function() bretonniatwo_rename_saved_game() end);

-----------------------------------------------------------------
---------------------======Load Game======-----------------------
-----------------------------------------------------------------

function bretonniatwo_rename_loaded_game()
    rename_bre_bretonniatwo["name_update_1"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_1")
    rename_bre_bretonniatwo["name_update_2"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_2")
    rename_bre_bretonniatwo["name_update_3"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_3")
    rename_bre_bretonniatwo["name_update_4"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_4")
    rename_bre_bretonniatwo["name_update_5"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_5")
    rename_bre_bretonniatwo["name_update_6"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_6")
    rename_bre_bretonniatwo["name_update_7"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_7")
    rename_bre_bretonniatwo["name_update_8"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_8")
    rename_bre_bretonniatwo["name_update_9"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_9")
    rename_bre_bretonniatwo["name_update_10"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_10")
    rename_bre_bretonniatwo["name_update_11"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_11")
    rename_bre_bretonniatwo["name_update_12"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_12")
    rename_bre_bretonniatwo["name_update_13"].faction_title_holder = cm:get_saved_value("brttwo_title_holder_13")
end
cm:add_loading_game_callback(function() bretonniatwo_rename_loaded_game() end);

--[[
Changed saved value name to include the subculture to stop overwriting from other scripts
]]
