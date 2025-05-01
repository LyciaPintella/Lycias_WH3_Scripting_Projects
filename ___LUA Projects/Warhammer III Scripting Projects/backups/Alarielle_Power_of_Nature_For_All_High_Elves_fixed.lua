local Power_of_Nature = {
    alarielle_faction_key = "wh2_main_hef_avelorn",
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
    out = function(t)
        ModLog("Alarielle's Confederated Power of Nature: " .. tostring(t) .. ".")
    end
};

function Power_of_Nature:start_power_of_nature_listeners()
    self.out("Adding CharacterTurnStart listener.")
    core:add_listener("Power_of_Nature", "CharacterTurnStart", function(context)
        local character = context:character()
        return character:character_subtype_key() == "wh2_dlc10_hef_alarielle" and character:faction():name() ~= self.alarielle_faction_key
    end, function(context)
        local character = context:character()
        self.out("Found Alarielle Working For Someone Other Than Avelorn: character:is_at_sea() == " .. tostring(character:is_at_sea()) .. "")

        if character:has_region() and not character:is_at_sea() then
            out("Alarielle wasn't at sea and she has a region. Adding region variables" .. "")
            local alarielle_faction = cm:get_faction(character:faction():name())
            local region = character:region();
            out("region:name() == " .. region:name() .. "")

            local region_key = region:name();
            out("region_key == " .. region_key .. "")

            local region_owning_faction = region:owning_faction();
            out("region:owning_faction():name() == " .. region:owning_faction():name() .. ", region_owning_faction:name() == " .. region_owning_faction:name() .. "")

            local region_culture = region_owning_faction:culture();
            out("region_culture == " .. region_culture .. "")

            out("region:is_abandoned() == " .. tostring(region:is_abandoned()) .. "")
            if not region:is_abandoned() then
                out("Is region an allowed culture?: " .. tostring(self["cultures"][region_culture]) .. "")
                if self["cultures"][region_culture] ~= nil then
                    out("War?: " .. tostring(alarielle_faction:at_war_with(region_owning_faction)) .. "")
                    if alarielle_faction:at_war_with(region_owning_faction) == false then

                        if region:has_effect_bundle("wh2_dlc10_power_of_nature") then
                            cm:remove_effect_bundle_from_region("wh2_dlc10_power_of_nature", region_key);
                        end

                        out("cm:apply_effect_bundle_to_region" .. "")

                        cm:apply_effect_bundle_to_region("wh2_dlc10_power_of_nature", region_key, 15);
                        self.regions[region_key] = 15;

                        cm:add_garrison_residence_vfx(region:garrison_residence():command_queue_index(), self.vfx.full, false);
                        core:trigger_event("ScriptEventPowerOfNatureTriggered");
                    end
                end
            end
        end
    end, true);

    -- update the vfx on each region each turn
    core:add_listener("power_of_nature_region", "RegionTurnStart", function(context)
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
            cm:remove_effect_bundle_from_region("wh2_dlc10_power_of_nature", region_key);
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
cm:add_first_tick_callback(function()
    Power_of_Nature:start_power_of_nature_listeners()
end);

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
function Power_of_Nature:callbacks()
    cm:add_saving_game_callback(function(context)
        cm:save_named_value("Power_of_Nature_Regions", self.power_of_nature_regions, context);
    end);

    cm:add_loading_game_callback(function(context)
        self.power_of_nature_regions = cm:load_named_value("Power_of_Nature_Regions", {}, context);
    end);
end
Power_of_Nature:callbacks();
