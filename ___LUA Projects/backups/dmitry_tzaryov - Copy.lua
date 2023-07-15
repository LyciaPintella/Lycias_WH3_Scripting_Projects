local function add_kislev_mod_listeners()
    core:add_listener("DmitryBuildingCompleted", "BuildingCompleted", function(context)
        local building = context:building()
        local building_faction = building:faction()
        return building:name() == "wh3_main_special_ksl_kislev_1_2" and building_faction == "wh3_main_ksl_the_ice_court" and LC_settings.setup_str_dmitry and not LC_settings.setup_mixer_dmitry
    end, function(context)
        local faction_name = context:building():faction():name()
        cm:spawn_character_to_pool(faction_name, "names_name_66990223", "names_name_66990224", "", "", 50, true, "general", "dead_ksl_dmitri_tzaryov", true, "");
    end, false)

    core:add_listener("KatarinBuildingCompleted", "BuildingCompleted", function(context)
        local building = context:building()
        local building_faction = building:faction()
        return building:name() == "wh3_main_special_ksl_kislev_1_2" and building_faction == "wh3_main_ksl_the_ice_court" and LC_settings.setup_mixer_dmitry
    end, function(context)
        local faction_name = context:building():faction():name()
        cm:spawn_character_to_pool(faction_name, "names_name_1506497736", "names_name_2147358958", "", "", 50, true, "general", "wh3_main_ksl_katarin", true, "");
    end, false)
end
cm:add_first_tick_callback_new(function()
    add_kislev_mod_listeners()

end)

local function dmitry_replace_ll()
    out("XXX Dmitry Begin XXX");
    local kislev = cm:get_faction("wh3_main_ksl_the_ice_court");
    local kislev_faction_leader_cqi = kislev:faction_leader():command_queue_index();
    local custom_starting_army = {
        -- Dmitri Tzaryov
        faction = "wh3_main_ksl_the_ice_court",
        subtype = "dead_ksl_dmitri_tzaryov",
        forename = "names_name_66990223",
        units = "wh3_main_ksl_inf_ice_guard_0,wh3_main_ksl_inf_ice_guard_1,wh3_main_ksl_inf_tzar_guard_0,wh3_main_ksl_inf_tzar_guard_0,wh3_main_ksl_cav_gryphon_legion_0,wh3_main_ksl_cav_gryphon_legion_0,wh3_main_ksl_inf_kossars_1,wh3_main_ksl_inf_kossars_1,wh3_main_ksl_inf_kossars_1,kossar_bardiche,kossar_bardiche,wh3_main_ksl_veh_little_grom_0"
    }
    out("JESSICA Kislev: custom_starting_army.units = " .. custom_starting_army.units .. ".")
    cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
    cm:set_character_immortality(cm:char_lookup_str(kislev_faction_leader_cqi), false);
    cm:kill_character(kislev_faction_leader_cqi, true, true);
    cm:disable_event_feed_events(false, "wh_event_category_character", "", "")
    cm:create_force_with_general( -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
    "wh3_main_ksl_the_ice_court", custom_starting_army.units, "wh3_main_combi_region_kislev", 700, 735, "general", "dead_ksl_dmitri_tzaryov", "names_name_66990223", "", "names_name_66990224", "",
    true, -- make_faction_leader,
    function(cqi) -- callback
        local str = "character_cqi:" .. cqi
        cm:set_character_immortality(str, true);
        cm:set_character_unique(str, true);
    end);
end
cm:add_first_tick_callback_new(function()
    if LC_settings.setup_str_dmitry and LC_settings.setup_mixer_dmitry then
        dmitry_replace_ll()
    end
end)

local function replace_starting_armies()
    local custom_starting_army = {
        -- Dmitri Tzaryov
        faction = "wh3_main_ksl_the_ice_court",
        subtype = "dead_ksl_dmitri_tzaryov",
        forename = "names_name_66990223",
        units = "wh3_main_ksl_inf_ice_guard_0,wh3_main_ksl_inf_ice_guard_1,wh3_main_ksl_inf_tzar_guard_0,wh3_main_ksl_inf_tzar_guard_0,wh3_main_ksl_cav_gryphon_legion_0,wh3_main_ksl_cav_gryphon_legion_0,wh3_main_ksl_inf_kossars_1,wh3_main_ksl_inf_kossars_1,wh3_main_ksl_inf_kossars_1,kossar_bardiche,kossar_bardiche,wh3_main_ksl_veh_little_grom_0"
    }

    local kislev = cm:get_faction(custom_starting_army.faction);
    local general_subtype = custom_starting_army.subtype;
    local general_forename = custom_starting_army.forename;
    local unit_list = custom_starting_army.units;
    local char_list = kislev:character_list();

    for j = 0, char_list:num_items() - 1 do
        local current_char = char_list:item_at(j);

        if current_char:is_null_interface() == false then
            out("Jessica Kislev: Checking general_subtype " .. tostring(current_char:character_subtype_key()) .. " against " .. tostring(general_subtype) .. "," .. " with forename " ..
                    tostring(current_char:get_forename()) .. ", against " .. tostring(general_forename) .. ". current_char:has_military_force() is " .. tostring(current_char:has_military_force()) ..
                    ".");
            if current_char:character_subtype_key() == general_subtype and current_char:get_forename() == general_forename and current_char:has_military_force() == true then
                cm:remove_all_units_from_general(current_char);
                out("Removing starting units from " .. general_subtype .. " with forename " .. general_forename);
                out("Granting new starting units to " .. general_subtype .. " with forename " .. general_forename);
                for k = 1, #unit_list do
                    local unit = unit_list[k]
                    out("Jessica Kislev: k = " .. k .. ". tostring(#unit_list) = " .. #unit_list .. ". unit = " .. tostring(unit) .. ". unit_list[k] is " .. unit_list[k] .. ".")

                    cm:grant_unit_to_character(cm:char_lookup_str(current_char:cqi()), unit);
                end
            end
        end
    end
    out("XXX Dmitry Finished XXX");
end
cm:add_first_tick_callback_new(function()
    if LC_settings.setup_str_dmitry and LC_settings.setup_mixer_dmitry then
        replace_starting_armies()
    end
end)

