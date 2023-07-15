local Power_of_Nature = {
    Avelorn_Faction_Key = "wh2_main_hef_avelorn",
    ["Cultures"] = {
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
    Regions = {},
    out = function(t)
        ModLog("Alarielle's Confederated Power of Nature: " .. tostring(t) .. ".")
    end
};

function Power_of_Nature:Start_Power_of_Nature_Listeners()
    self.out("Adding CharacterTurnStart listener." .. "")
    core:add_listener("Power_of_Nature", "CharacterTurnStart", function(context)
        local character = context:character()
        return character:character_subtype_key() == "wh2_dlc10_hef_alarielle" and character:faction():name() ~= self.Avelorn_Faction_Key
    end, function(context)
        local character = context:character()
        self.out("Found Alarielle outside of Avelorn faction. Is she at sea?: " .. tostring(character:is_at_sea()) .. "")

        if character:has_region() and not character:is_at_sea() then
            self.out("Alarielle wasn't at sea and she has a region.")
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

            if not region:is_abandoned() and alarielle_faction:at_war_with(region_owning_faction) == false and self["Cultures"][region_culture] ~= nil then

                if region:has_effect_bundle("wh2_dlc10_Power_of_Nature") then
                    cm:remove_effect_bundle_from_region("wh2_dlc10_Power_of_Nature", region_key);
                end

                self.out("cm:apply_effect_bundle_to_region" .. "")

                cm:apply_effect_bundle_to_region("wh2_dlc10_Power_of_Nature", region_key, 15);
                self.Regions[region_key] = 15;

                cm:add_garrison_residence_vfx(region:garrison_residence():command_queue_index(), self.vfx.full, false);
                core:trigger_event("ScriptEventPowerOfNatureTriggered");
            end
        end

    end, true);

    -- update the vfx on each region each turn
    core:add_listener("Power_of_Nature_Region", "RegionTurnStart", function(context)
        return self.Regions[context:region():name()] ~= nil;
    end, function(context)
        local region = context:region();
        local region_key = region:name();
        local garrison_residence = region:garrison_residence();
        local garrison_residence_cqi = garrison_residence:command_queue_index();
        local region_culture = region:owning_faction():culture();

        cm:remove_garrison_residence_vfx(garrison_residence_cqi, self.vfx.full);
        cm:remove_garrison_residence_vfx(garrison_residence_cqi, self.vfx.half);

        if region:is_abandoned() or self["Cultures"][region_culture] ~= true then
            cm:remove_effect_bundle_from_region("wh2_dlc10_Power_of_Nature", region_key);
        end

        local turns_remaining = self.Regions[region_key];
        turns_remaining = turns_remaining - 1;

        if turns_remaining > 7 then
            -- display full VFX
            cm:add_garrison_residence_vfx(garrison_residence_cqi, self.vfx.full, false);
            self.Regions[region_key] = turns_remaining;
        elseif turns_remaining > 0 then
            -- switch to half strength VFX
            cm:add_garrison_residence_vfx(garrison_residence_cqi, self.vfx.half, false);
            self.Regions[region_key] = turns_remaining;
        else
            self.Regions[region_key] = nil;
        end
    end, true);
end
cm:add_first_tick_callback(function()
    Power_of_Nature:Start_Power_of_Nature_Listeners()
end);

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(function(context)
    -- cm:save_named_value("defender_of_ulthuan_level", defender_of_ulthuan_level, context)
    cm:save_named_value("Power_of_Nature_Regions", Power_of_Nature.regions, context)
end)

cm:add_loading_game_callback(function(context)
    -- defender_of_ulthuan_level = cm:load_named_value("defender_of_ulthuan_level", 1, context)
    Power_of_Nature.regions = cm:load_named_value("Power_of_Nature_Regions", {}, context)
end)

