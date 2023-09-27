local power_of_nature_vfx = {
    full = "scripted_effect7",
    half = "scripted_effect8"
};
local power_of_nature_regions = {};

core:add_listener("pintella_character_turn_start", "CharacterTurnStart", function(context)
    local character = context:character()
    return character:character_subtype_key() == "wh2_dlc10_hef_alarielle" and character:faction():name() ~= "wh2_main_hef_avelorn" -- character is alarielle and it belongs to another faction
end, function(context)
    local character = context:character()

    if character:has_region() and not character:is_at_sea() then
        local region = character:region();

        if not region:is_abandoned() and region:owning_faction():name() == character:faction():name() then
            local region_key = region:name();

            if region:has_effect_bundle("wh2_dlc10_power_of_nature") then
                cm:remove_effect_bundle_from_region("wh2_dlc10_power_of_nature", region_key);
            end

            cm:apply_effect_bundle_to_region("wh2_dlc10_power_of_nature", region_key, 10);
            power_of_nature_regions[region_key] = 10;

            cm:add_garrison_residence_vfx(region:garrison_residence():command_queue_index(), power_of_nature_vfx.full, false);
            core:trigger_event("ScriptEventPowerOfNatureTriggered");
        end
    end
end, true)

-- this is for the vfx power and removal
core:add_listener("pintella_power_of_nature_region", "RegionTurnStart", function(context)
    return power_of_nature_regions[context:region():name()] ~= nil;
end, function(context)
    local region = context:region();
    local region_key = region:name();
    local garrison_residence = region:garrison_residence();
    local garrison_residence_cqi = garrison_residence:command_queue_index();

    cm:remove_garrison_residence_vfx(garrison_residence_cqi, power_of_nature_vfx.full);
    cm:remove_garrison_residence_vfx(garrison_residence_cqi, power_of_nature_vfx.half);

    if region:is_abandoned() or region:owning_faction():culture() ~= "wh2_main_hef_high_elves" then
        cm:remove_effect_bundle_from_region("wh2_dlc10_power_of_nature", region_key);
    end

    local turns_remaining = power_of_nature_regions[region_key];
    turns_remaining = turns_remaining - 1;

    if turns_remaining > 5 then
        -- display full VFX
        cm:add_garrison_residence_vfx(garrison_residence_cqi, power_of_nature_vfx.full, false);
        power_of_nature_regions[region_key] = turns_remaining;
    elseif turns_remaining > 0 then
        -- switch to half strength VFX
        cm:add_garrison_residence_vfx(garrison_residence_cqi, power_of_nature_vfx.half, false);
        power_of_nature_regions[region_key] = turns_remaining;
    else
        power_of_nature_regions[region_key] = nil;
    end
end, true);

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(function(context)
    cm:save_named_value("pintella_power_of_nature_regions", power_of_nature_regions, context);
end);

cm:add_loading_game_callback(function(context)
    power_of_nature_regions = cm:load_named_value("pintella_power_of_nature_regions", {}, context);
end);
