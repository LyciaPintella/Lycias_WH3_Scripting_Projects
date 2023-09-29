local Scripted_HEF_Technology_Tree = {
    region_mapping = {
        wh3_main_combi_region_black_crag = {
            hef_special_vortex = {
                culture = "wh2_main_hef_high_elves",
                allow_allies = true
            }
        },
        wh3_main_combi_region_konquata = {
            hef_special_albion = {
                culture = "wh2_main_hef_high_elves",
                allow_allies = true
            }
        }
    },
    ancillary_mapping = {}
}

function Scripted_HEF_Technology_Tree:start_technology_listeners()
    out("#### HE_Tech_Expansion_JM: Scripted_HEF_Technology_Tree:start_technology_listeners Called. ####");

    if cm:is_new_game() then
        for region_key, technologies in pairs(self.region_mapping) do
            local region = cm:get_region(region_key)
            if region then
                out("#### HE_Tech_Expansion_JM: New Game Detected. Checking Region: " .. tostring(region:name()) .. " Owned By Faction: " .. tostring(region:owning_faction():name()) ..
                        " For Technology: " .. tostring(self.region_mapping[region:name()]) .. " ####")
                -- lock the technology for all factions
                self:toggle_technology(technologies)

                -- unlock it for the owner in the start pos

                if not region:is_abandoned() then
                    self:toggle_technology(technologies, region:owning_faction())
                end
            end
        end
    end

    core:add_listener("region_changed_technology_unlock", "RegionFactionChangeEvent", function(context)
        return self.region_mapping[context:region():name()]
    end, function(context)
        local region = context:region()
        local owning_faction

        if not region:is_abandoned() then
            owning_faction = region:owning_faction()
        else
            out("#### HE_Tech_Expansion_JM: Region: " .. tostring(region:name()) .. " Is Abandoned Nobody Will Unlock Technologies From It.")
        end
        out("#### HE_Tech_Expansion_JM: Region: " .. tostring(region:name()) .. " Is Now Controlled By: " .. tostring(region:owning_faction():name()) .. " Enabling Technology: " ..
                tostring(self.region_mapping[region:name()]) .. " For Them. ####")
        self:toggle_technology(self.region_mapping[region:name()], owning_faction)
    end, true)

    core:add_listener("diplomatic_treaty_technology_unlock", "PositiveDiplomaticEvent", function(context)
        return context:is_military_alliance() or context:is_defensive_alliance() or context:is_vassalage()
    end, function(context)
        self:resolve_diplomatic_event(context:proposer(), context:recipient())
    end, true)

    core:add_listener("diplomatic_treaty_technology_unlock", "NegativeDiplomaticEvent", function(context)
        return context:was_military_alliance() or context:was_defensive_alliance() or context:was_vassalage()
    end, function(context)
        self:resolve_diplomatic_event(context:proposer(), context:recipient())
    end, true)
end

function Scripted_HEF_Technology_Tree:resolve_diplomatic_event(proposer, recipient)
    -- delay this by a tick as the treaty isn't created until just after this event
    cm:callback(function()
        for region_key, technologies in pairs(self.region_mapping) do
            local region = cm:get_region(region_key)

            if region and not region:is_abandoned() then
                local owning_faction = region:owning_faction()

                if owning_faction == proposer then
                    self:toggle_technology(technologies, proposer)
                elseif owning_faction == recipient then
                    self:toggle_technology(technologies, recipient)
                end
            end
        end
    end, 0.2)
end

function Scripted_HEF_Technology_Tree:toggle_technology(technologies, region_owner)
    -- unlock each technology tied to the region for the new owner and allies if needed
    if region_owner and not region_owner:is_rebel() then
        local faction_culture = region_owner:culture()
        -- build a list of allies and vassals
        local ally_list = {}
        for _, current_faction in model_pairs(region_owner:factions_allied_with()) do
            table.insert(ally_list, current_faction)
        end
        for _, current_faction in model_pairs(region_owner:vassals()) do
            table.insert(ally_list, current_faction)
        end
        for technology_key, details in pairs(technologies) do
            out("#### HE_Tech_Expansion_JM:toggle_technology(): Checking To See If " .. tostring(region_owner:name()) .. " Is Culture " .. tostring(details.culture) .. " For Technology " ..
                    tostring(technology_key) .. " ####")
            if faction_culture == details.culture then
                out("#### HE_Tech_Expansion_JM:toggle_technology(): Unlocking Technology " .. tostring(technology_key) .. " For " .. tostring(region_owner:name()) .. " ####")
                cm:unlock_technology(region_owner:name(), technology_key)
            end

            if details.allow_allies then
                for i = 1, #ally_list do
                    local current_ally = ally_list[i]

                    if current_ally:culture() == details.culture then
                        cm:unlock_technology(current_ally:name(), technology_key)
                    end
                end
            end
        end
    end

    -- lock the technology for every other faction, excluding allies if needed, of that culture
    local faction_list = cm:model():world():faction_list()

    for _, current_faction in model_pairs(faction_list) do
        local current_faction_culture = current_faction:culture()

        for technology_key, details in pairs(technologies) do
            if current_faction_culture == details.culture and region_owner ~= current_faction and
                (not region_owner or (details.allow_allies and region_owner and not region_owner:is_ally_vassal_or_client_state_of(current_faction))) then
                cm:lock_technology(current_faction:name(), technology_key)
            end
        end
    end
end
cm:add_first_tick_callback(function()
    Scripted_HEF_Technology_Tree:start_technology_listeners()
end);
