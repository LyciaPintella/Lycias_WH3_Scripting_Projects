local Power_of_Nature = {
    ["cultures"] = {
        ["wh2_main_hef_high_elves"] = true,
        ["wh2_main_lzd_lizardmen"] = true,
        ["wh3_main_cth_cathay"] = true,
        ["wh3_main_ksl_kislev"] = true,
        ["wh_dlc05_wef_wood_elves"] = true,
        ["wh_main_brt_bretonnia"] = true,
        ["wh_main_emp_empire"] = true,
        ["wh_main_dwf_dwarfs"] = true,
        ["ovn_albion"] = true
    },
    vfx = {
        full = "scripted_effect7",
        half = "scripted_effect8"
    },
    regions = {},
    effect_bundle_key = "wh2_dlc10_power_of_nature",
    out = function(t)
        ModLog("Alarielle's Global World Torment And True Power of Nature: " .. tostring(t) .. ".")
    end

};

local Alarielle = {
    faction_key = "wh2_main_hef_avelorn"
}
local hellebron_faction_key = "wh2_main_def_har_ganeth";

local defender_of_ulthuan_effect = "";
local defender_of_ulthuan_level = 1;

local ulthuan_regions = {
    ["outer"] = {
        ["wh3_main_combi_region_vauls_anvil_ulthuan"] = true,
        ["wh3_main_combi_region_tor_sethai"] = true,
        ["wh3_main_combi_region_whitepeak"] = true,
        ["wh3_main_combi_region_tor_anroc"] = true,
        ["wh3_main_combi_region_avethir"] = true,
        ["wh3_main_combi_region_tor_dranil"] = true,
        ["wh3_main_combi_region_tor_anlec"] = true,
        ["wh3_main_combi_region_shrine_of_khaine"] = true,
        ["wh3_main_combi_region_tor_achare"] = true,
        ["wh3_main_combi_region_elisia"] = true,
        ["wh3_main_combi_region_shrine_of_kurnous"] = true,
        ["wh3_main_combi_region_mistnar"] = true,
        ["wh3_main_combi_region_tor_koruali"] = true,
        ["wh3_main_combi_region_tor_yvresse"] = true,
        ["wh3_main_combi_region_elessaeli"] = true,
        ["wh3_main_combi_region_tralinia"] = true,
        ["wh3_main_combi_region_shrine_of_loec"] = true,
        ["wh3_main_combi_region_cairn_thel"] = true
    },
    ["inner"] = {
        ["wh3_main_combi_region_lothern"] = true,
        ["wh3_main_combi_region_tower_of_lysean"] = true,
        ["wh3_main_combi_region_tor_elyr"] = true,
        ["wh3_main_combi_region_eagle_gate"] = true,
        ["wh3_main_combi_region_whitefire_tor"] = true,
        ["wh3_main_combi_region_griffon_gate"] = true,
        ["wh3_main_combi_region_evershale"] = true,
        ["wh3_main_combi_region_unicorn_gate"] = true,
        ["wh3_main_combi_region_phoenix_gate"] = true,
        ["wh3_main_combi_region_tor_saroir"] = true,
        ["wh3_main_combi_region_gaean_vale"] = true,
        ["wh3_main_combi_region_tor_finu"] = true,
        ["wh3_main_combi_region_white_tower_of_hoeth"] = true,
        ["wh3_main_combi_region_port_elistor"] = true,
        ["wh3_main_combi_region_angerrial"] = true,
        ["wh3_main_combi_region_shrine_of_asuryan"] = true
    },
    ["outer_lost"] = 0,
    ["inner_lost"] = 0
};

function Power_of_Nature:Start_Power_of_Nature_Listeners()
    cm:add_faction_turn_start_listener_by_name("Power_of_Nature", Alarielle.faction_key, function(context)
        local character = context:faction():faction_leader();

        if character:has_region() and not character:is_at_sea() then
            self.out("Alarielle wasn't at sea and she has a region." .. "")
            local alarielle_faction = cm:get_faction(character:faction():name())
            local region = character:region();
            local region_key = region:name();
            local region_owning_faction = region:owning_faction();
            local region_culture = region_owning_faction:culture();

            self.out("region's name is: " .. region:name() .. "")
            self.out("region's key is: " .. region_key .. "")
            self.out("region's owning faction's name: " .. region:owning_faction():name() .. ", region_owning_faction:name() == " .. region_owning_faction:name() .. "")
            self.out("region's culture is: " .. region_culture .. "")
            self.out("is region abandoned?: " .. tostring(region:is_abandoned()) .. "")

            if not region:is_abandoned() and alarielle_faction:at_war_with(region_owning_faction) == false and self["cultures"][region_culture] ~= nil then

                if region:has_effect_bundle(self.effect_bundle_key) then
                    cm:remove_effect_bundle_from_region(self.effect_bundle_key, region_key);
                end

                self.out("cm:apply_effect_bundle_to_region" .. "")

                cm:apply_effect_bundle_to_region(self.effect_bundle_key, region_key, 15);
                self.regions[region_key] = 15;

                cm:add_garrison_residence_vfx(region:garrison_residence():command_queue_index(), self.vfx.full, false);
                core:trigger_event("ScriptEventPowerOfNatureTriggered");
            end
        end

    end, true);

    -- update the vfx on each region each turn
    core:add_listener("Power_of_Nature_Region", "RegionTurnStart", function(context)
        return self.regions[context:region():name()] ~= nil;
    end, function(context)
        local region = context:region();
        local region_key = region:name();
        local garrison_residence = region:garrison_residence();
        local garrison_residence_cqi = garrison_residence:command_queue_index();
        local region_culture = region:owning_faction():culture();

        cm:remove_garrison_residence_vfx(garrison_residence_cqi, self.vfx.full);
        cm:remove_garrison_residence_vfx(garrison_residence_cqi, self.vfx.half);

        if region:is_abandoned() or self["cultures"][region_culture] ~= true then
            cm:remove_effect_bundle_from_region(self.effect_bundle_key, region_key);
        end

        local turns_remaining = self.regions[region_key];
        turns_remaining = turns_remaining - 1;

        if turns_remaining > 7 then
            -- display full VFX
            cm:add_garrison_residence_vfx(garrison_residence_cqi, self.vfx.full, false);
            self.regions[region_key] = turns_remaining;
        elseif turns_remaining > 0 then
            -- switch to half strength VFX
            cm:add_garrison_residence_vfx(garrison_residence_cqi, self.vfx.half, false);
            self.regions[region_key] = turns_remaining;
        else
            self.regions[region_key] = nil;
        end
    end, true);
end

function add_alarielle_listeners()
    out("Adding Alarielle Listeners");

    -- POWER OF NATURE
    Power_of_Nature:Start_Power_of_Nature_Listeners()

    -- MORTAL WORLDS TORMENT
    cm:add_faction_turn_start_listener_by_name("mortal_worlds_torment", Alarielle.faction_key, function(context)
        local faction = context:faction();
        local alarielle = faction:faction_leader();

        local highest_average_corruption = 0; -- best of the five
        local average_chaos_corruption = 0;
        local average_khorne_corruption = 0;
        local average_nurgle_corruption = 0;
        local average_slaanesh_corruption = 0;
        local average_tzeentch_corruption = 0;
        local num_provinces = 0;

        local region_list = cm:model():world():region_manager():region_list();

        for r = 0, region_list:num_items() - 1 do
            if region_list:item_at(r):is_province_capital() == true then
                average_chaos_corruption = average_chaos_corruption + cm:get_corruption_value_in_region(region_list:item_at(r), "wh3_main_corruption_chaos");
                average_khorne_corruption = average_khorne_corruption + cm:get_corruption_value_in_region(region_list:item_at(r), "wh3_main_corruption_khorne");
                average_nurgle_corruption = average_nurgle_corruption + cm:get_corruption_value_in_region(region_list:item_at(r), "wh3_main_corruption_nurgle");
                average_slaanesh_corruption = average_slaanesh_corruption + cm:get_corruption_value_in_region(region_list:item_at(r), "wh3_main_corruption_slaanesh");
                average_tzeentch_corruption = average_tzeentch_corruption + cm:get_corruption_value_in_region(region_list:item_at(r), "wh3_main_corruption_tzeentch");

                highest_average_corruption = highest_average_corruption +
                                                 math.max(cm:get_corruption_value_in_region(region_list:item_at(r), "wh3_main_corruption_chaos"),
                                                          cm:get_corruption_value_in_region(region_list:item_at(r), "wh3_main_corruption_khorne"),
                                                          cm:get_corruption_value_in_region(region_list:item_at(r), "wh3_main_corruption_nurgle"),
                                                          cm:get_corruption_value_in_region(region_list:item_at(r), "wh3_main_corruption_slaanesh"),
                                                          cm:get_corruption_value_in_region(region_list:item_at(r), "wh3_main_corruption_tzeentch"));

                num_provinces = num_provinces + 1;
            end
        end

        highest_average_corruption = math.round(highest_average_corruption / num_provinces);
        average_chaos_corruption = math.round(average_chaos_corruption / num_provinces);
        average_khorne_corruption = math.round(average_khorne_corruption / num_provinces);
        average_nurgle_corruption = math.round(average_nurgle_corruption / num_provinces);
        average_slaanesh_corruption = math.round(average_slaanesh_corruption / num_provinces);
        average_tzeentch_corruption = math.round(average_tzeentch_corruption / num_provinces);

        if faction:has_effect_bundle("wh2_dlc10_bundle_alarielle_corruption_0") then
            cm:remove_effect_bundle("wh2_dlc10_bundle_alarielle_corruption_0", Alarielle.faction_key);
        end

        local effect_bundle = cm:create_new_custom_effect_bundle("wh2_dlc10_bundle_alarielle_corruption_0");
        effect_bundle:set_duration(0);

        if highest_average_corruption == 0 then
            effect_bundle:add_effect("wh2_dlc10_effect_alarielle_corruption_amount_good", "faction_to_faction_own_unseen", highest_average_corruption);
        else
            effect_bundle:add_effect("wh2_dlc10_effect_alarielle_corruption_amount", "faction_to_faction_own_unseen", highest_average_corruption);
            effect_bundle:add_effect("wh2_dlc10_effect_alarielle_corruption_amount_chaos", "faction_to_faction_own_unseen", average_chaos_corruption);
            effect_bundle:add_effect("wh2_dlc10_effect_alarielle_corruption_amount_khorne", "faction_to_faction_own_unseen", average_khorne_corruption);
            effect_bundle:add_effect("wh2_dlc10_effect_alarielle_corruption_amount_nurgle", "faction_to_faction_own_unseen", average_nurgle_corruption);
            effect_bundle:add_effect("wh2_dlc10_effect_alarielle_corruption_amount_slaanesh", "faction_to_faction_own_unseen", average_slaanesh_corruption);
            effect_bundle:add_effect("wh2_dlc10_effect_alarielle_corruption_amount_tzeentch", "faction_to_faction_own_unseen", average_tzeentch_corruption);
        end

        cm:apply_custom_effect_bundle_to_faction(effect_bundle, faction);

        cm:disable_event_feed_events(true, "wh_event_category_traits_ancillaries", "", "");

        local trait_level = alarielle:trait_points("wh2_dlc10_trait_alarielle_chaos");
        trait_level = trait_level - alarielle:trait_points("wh2_dlc10_trait_alarielle_chaos_none");

        local char_str = cm:char_lookup_str(alarielle);
        cm:force_remove_trait(char_str, "wh2_dlc10_trait_alarielle_chaos");
        cm:force_remove_trait(char_str, "wh2_dlc10_trait_alarielle_chaos_none");

        if highest_average_corruption > 26 then
            cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos", false, 3);
            core:trigger_event("ScriptEventMortalWorldsTorment4");

            if trait_level < 3 then
                cm:trigger_incident_with_targets(faction:command_queue_index(), "wh2_dlc10_incident_hef_alarielle_torment_increase", 0, 0, alarielle:command_queue_index(), 0, 0, 0);
            end
        elseif highest_average_corruption > 19 then
            cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos", false, 2);
            core:trigger_event("ScriptEventMortalWorldsTorment3");

            if trait_level < 2 then
                cm:trigger_incident_with_targets(faction:command_queue_index(), "wh2_dlc10_incident_hef_alarielle_torment_increase", 0, 0, alarielle:command_queue_index(), 0, 0, 0);
            elseif trait_level > 2 then
                cm:trigger_incident_with_targets(faction:command_queue_index(), "wh2_dlc10_incident_hef_alarielle_torment_decrease", 0, 0, alarielle:command_queue_index(), 0, 0, 0);
            end
        elseif highest_average_corruption > 13 then
            cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos", false);
            core:trigger_event("ScriptEventMortalWorldsTorment2");

            if trait_level < 1 then
                cm:trigger_incident_with_targets(faction:command_queue_index(), "wh2_dlc10_incident_hef_alarielle_torment_increase", 0, 0, alarielle:command_queue_index(), 0, 0, 0);
            elseif trait_level > 1 then
                cm:trigger_incident_with_targets(faction:command_queue_index(), "wh2_dlc10_incident_hef_alarielle_torment_decrease", 0, 0, alarielle:command_queue_index(), 0, 0, 0);
            end
        else
            cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos_none", false);
            core:trigger_event("ScriptEventMortalWorldsTorment1");

            if trait_level > -1 then
                cm:trigger_incident_with_targets(faction:command_queue_index(), "wh2_dlc10_incident_hef_alarielle_torment_decrease", 0, 0, alarielle:command_queue_index(), 0, 0, 0);
            end
        end

        cm:callback(function()
            cm:disable_event_feed_events(false, "wh_event_category_traits_ancillaries", "", "")
        end, 0.5);
    end, true);

    -- DEFENDER OF ULTHUAN
    if cm:get_faction(Alarielle.faction_key):is_human() then
        core:add_listener("defender_of_ulthuan_region_update", "RegionFactionChangeEvent", function(context)
            return ulthuan_regions["all"] and ulthuan_regions["all"][context:region():name()];
        end, function(context)
            local region = context:region();

            if not region:is_null_interface() then
                local region_key = region:name();
                self.out("Defender of Ulthuan Region Update: " .. region_key);
                local ulthuan_type = nil;

                if ulthuan_regions["outer"][region_key] ~= nil then
                    ulthuan_type = "outer";
                elseif ulthuan_regions["inner"][region_key] ~= nil then
                    ulthuan_type = "inner";
                end

                if ulthuan_type ~= nil then
                    if ulthuan_regions[ulthuan_type][region_key] and region:is_abandoned() or region:owning_faction():culture() ~= "wh2_main_hef_high_elves" then
                        ulthuan_regions[ulthuan_type][region_key] = false;
                        ulthuan_regions[ulthuan_type .. "_lost"] = ulthuan_regions[ulthuan_type .. "_lost"] + 1;
                        self.out("\tRegion was true and is now false - Value " .. ulthuan_type .. "_lost count is " .. tostring(ulthuan_regions[ulthuan_type .. "_lost"]) .. " (+1)");
                    elseif not ulthuan_regions[ulthuan_type][region_key] and not region:is_abandoned() and region:owning_faction():culture() == "wh2_main_hef_high_elves" then
                        ulthuan_regions[ulthuan_type][region_key] = true;
                        ulthuan_regions[ulthuan_type .. "_lost"] = ulthuan_regions[ulthuan_type .. "_lost"] - 1;
                        self.out("\tRegion was false and is now true - Value " .. ulthuan_type .. "_lost count is " .. tostring(ulthuan_regions[ulthuan_type .. "_lost"]) .. " (-1)");
                    else
                        self.out("\tNo changes made");
                    end

                    defender_of_ulthuan_remove_effects();

                    if ulthuan_regions["inner_lost"] > 0 then
                        if defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_all" or defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_outer" then
                            defender_of_ulthuan_show_event(region, "inner_lost");
                            core:trigger_event("ScriptEventDefenderOfUlthuanInnerLost");
                        end

                        defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_inner";
                    elseif ulthuan_regions["outer_lost"] > 0 then
                        if defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_all" then
                            defender_of_ulthuan_show_event(region, "outer_lost");
                            core:trigger_event("ScriptEventDefenderOfUlthuanOuterLost");
                        elseif defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_inner" then
                            core:trigger_event("ScriptEventDefenderOfUlthuanInnerRegained");
                        end

                        defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_outer";
                    else
                        if defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_outer" or defender_of_ulthuan_effect == "wh2_dlc10_defender_of_ulthuan_inner" then
                            defender_of_ulthuan_show_event(region, "united");
                            core:trigger_event("ScriptEventDefenderOfUlthuanUnited");
                            cm:complete_scripted_mission_objective(Alarielle.faction_key, "wh_main_short_victory", "ulthuan_controlled", true);
                        end

                        defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_all";
                    end

                    defender_of_ulthuan_level = 1;
                    cm:apply_effect_bundle(defender_of_ulthuan_effect .. "_" .. defender_of_ulthuan_level, Alarielle.faction_key, 0);
                end
            end
        end, true);

        cm:add_faction_turn_start_listener_by_name("defender_of_ulthuan_update", Alarielle.faction_key, function()
            if defender_of_ulthuan_level < 10 then
                defender_of_ulthuan_level = defender_of_ulthuan_level + 1;
            end

            defender_of_ulthuan_remove_effects();
            cm:apply_effect_bundle(defender_of_ulthuan_effect .. "_" .. defender_of_ulthuan_level, Alarielle.faction_key, 0);
        end, true);

        if cm:is_new_game() then
            defender_of_ulthuan_initialize(true);

            -- prevents growth in the phoenix gate province for the first owner
            cm:apply_effect_bundle_to_region("wh2_dlc10_dark_elf_fortress_gate", "wh3_main_combi_region_phoenix_gate", 0);
        else
            defender_of_ulthuan_initialize(false);
        end
    end
end

function defender_of_ulthuan_initialize(new_game)
    local ulthuan_types = {"inner", "outer"};

    for i = 1, #ulthuan_types do
        for region_key, value in pairs(ulthuan_regions[ulthuan_types[i]]) do
            ulthuan_regions["all"][region_key] = true;
            local region = cm:get_region(region_key);

            if region and (region:is_abandoned() or region:owning_faction():culture() ~= "wh2_main_hef_high_elves") then
                ulthuan_regions[ulthuan_types[i]][region_key] = false;
                ulthuan_regions[ulthuan_types[i] .. "_lost"] = ulthuan_regions[ulthuan_types[i] .. "_lost"] + 1;
            end
        end
    end

    defender_of_ulthuan_remove_effects();

    if new_game then
        defender_of_ulthuan_level = 1;
    end

    if ulthuan_regions["inner_lost"] > 0 then
        defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_inner";
    elseif ulthuan_regions["outer_lost"] > 0 then
        defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_outer";
    else
        defender_of_ulthuan_effect = "wh2_dlc10_defender_of_ulthuan_all";
    end

    cm:apply_effect_bundle(defender_of_ulthuan_effect .. "_" .. defender_of_ulthuan_level, Alarielle.faction_key, 0);
end

function defender_of_ulthuan_remove_effects()
    local effects = {"inner", "outer", "all"};
    local faction = cm:get_faction(Alarielle.faction_key);

    for i = 1, 10 do
        for j = 1, #effects do
            local effect_bundle = "wh2_dlc10_defender_of_ulthuan_" .. effects[j] .. "_" .. i;

            if faction:has_effect_bundle(effect_bundle) then
                cm:remove_effect_bundle(effect_bundle, Alarielle.faction_key);
            end
        end
    end
end

function defender_of_ulthuan_show_event(region, event_type)
    if event_type == "united" then
        cm:show_message_event(Alarielle.faction_key, "event_feed_strings_text_wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_title",
                              "event_feed_strings_text_wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_united_primary_detail",
                              "event_feed_strings_text_wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_united_secondary_detail", false, 1012);
    else
        local settlement = region:settlement();

        cm:show_message_event_located(Alarielle.faction_key, "event_feed_strings_text_" .. "wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_title",
                                      "event_feed_strings_text_" .. "wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_" .. event_type .. "_primary_detail",
                                      "event_feed_strings_text_" .. "wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_" .. event_type .. "_secondary_detail",
                                      settlement:logical_position_x(), settlement:logical_position_y(), false, 1013);
    end
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(function(context)
    cm:save_named_value("defender_of_ulthuan_level", defender_of_ulthuan_level, context)
    cm:save_named_value("Power_of_Nature_Regions", Power_of_Nature.regions, context)
end)

cm:add_loading_game_callback(function(context)
    defender_of_ulthuan_level = cm:load_named_value("defender_of_ulthuan_level", 1, context)
    Power_of_Nature.regions = cm:load_named_value("Power_of_Nature_Regions", {}, context)
end)
