local Eltharion_Mists = {
    m_hef_culture = "wh2_main_hef_high_elves",
    m_eltharion_faction_key = "wh2_main_hef_yvresse",
    m_regions = {
        -- regions to apply mist to
        level_1 = {"wh3_main_combi_region_tor_yvresse", "wh3_main_combi_region_tralinia"},
        -- northern and southern yvresse
        level_2 = {"wh3_main_combi_region_tor_yvresse", "wh3_main_combi_region_elessaeli", "wh3_main_combi_region_tralinia", "wh3_main_combi_region_shrine_of_loec", "wh3_main_combi_region_cairn_thel"},
        -- outer ring
        level_3 = {
            "wh3_main_combi_region_vauls_anvil_ulthuan", "wh3_main_combi_region_tor_sethai", "wh3_main_combi_region_avethir", "wh3_main_combi_region_whitepeak", "wh3_main_combi_region_tor_anroc",
            "wh3_main_combi_region_tor_dranil", "wh3_main_combi_region_tor_anlec", "wh3_main_combi_region_shrine_of_khaine", "wh3_main_combi_region_tor_achare",
            "wh3_main_combi_region_shrine_of_kurnous", "wh3_main_combi_region_elisia", "wh3_main_combi_region_mistnar", "wh3_main_combi_region_tor_koruali", "wh3_main_combi_region_tor_yvresse",
            "wh3_main_combi_region_elessaeli", "wh3_main_combi_region_tralinia", "wh3_main_combi_region_shrine_of_loec", "wh3_main_combi_region_cairn_thel", "wh3_main_combi_region_lothern",
            "wh3_main_combi_region_angerrial"}
    },
    m_mist_effects = {
        level_1 = "wh2_dlc15_hef_mist_of_yvresse_1",
        level_2 = "wh2_dlc15_hef_mist_of_yvresse_2",
        level_3 = "wh2_dlc15_hef_mist_of_yvresse_3"
    },
    out = function(t)
        ModLog("Eltharion_Mists: " .. tostring(t) .. ".")
    end
}

function Eltharion_Mists:purge_mists_of_yvresse()
    self.out("wh2_dlc15_eltharion_mist: clearing Mists of Yvresse regional effect bundles")

    for i = 1, #self.m_regions.level_3 do
        local region = cm:get_region(self.m_regions.level_3[i])

        for k, effect in pairs(self.m_mist_effects) do
            if region:has_effect_bundle(effect) then
                cm:remove_effect_bundle_from_region(effect, self.m_regions.level_3[i])
            end
        end
    end
end

function Eltharion_Mists:purge_mists_if_dead_listener()
    -- Only start the eltharion-dead-check listener on script start if the faction is not thought to be dead
    core:add_listener("mist_of_yvresse_monitor", "FactionTurnStart", function()
        return cm:get_faction(self.m_eltharion_faction_key):is_dead()
    end, function()
        -- Purge the mists if Eltharion is dead
        self:purge_mists_of_yvresse()
        cm:set_saved_value("eltharion_faction_is_dead", true)
    end, false)
end

function Eltharion_Mists:apply_mists_of_yvresse_effects(region_key)
    -- checks relevant conditions (Mists upgrades and active Rites) and applies the appropriate effect bundles
    local region = cm:get_region(region_key)

    if not region:is_null_interface() and not region:is_abandoned() then
        local owning_faction = region:owning_faction()
        local yvresse_faction = cm:get_faction(Eltharion_Mists.m_eltharion_faction_key)
        local m_mist_ritual = cm:get_saved_value("m_mist_ritual") or 0

        if owning_faction:culture() == self.m_hef_culture and
            ((owning_faction:name() == self.m_eltharion_faction_key) or owning_faction:allied_with(yvresse_faction) or owning_faction:is_vassal_of(yvresse_faction) or
                yvresse_faction:is_vassal_of(owning_faction)) then

            cm:create_storm_for_region(region_key, 1, 1, "hef_mist_storm")

            if m_mist_ritual == 3 then
                cm:apply_effect_bundle_to_region(self.m_mist_effects.level_3, region_key, 0)
            elseif m_mist_ritual == 2 then
                cm:apply_effect_bundle_to_region(self.m_mist_effects.level_2, region_key, 0)
            elseif m_mist_ritual == 1 then
                cm:apply_effect_bundle_to_region(self.m_mist_effects.level_1, region_key, 0)
            end

            if yvresse_faction:has_effect_bundle("wh2_dlc15_ritual_hef_ladrielle") then
                cm:apply_effect_bundle_to_region("wh2_dlc15_hef_mist_of_yvresse_rite_empowered", region_key, 0)
            elseif region:has_effect_bundle("wh2_dlc15_hef_mist_of_yvresse_rite_empowered") then
                cm:remove_effect_bundle_from_region("wh2_dlc15_hef_mist_of_yvresse_rite_empowered", region_key)
            end
        end
    end
end

function Eltharion_Mists:update_mists_of_yvresse()
    -- purge existing mist, then check which regions should be misty and loop through them to apply effects
    self:purge_mists_of_yvresse()
    local yvresse_faction = cm:get_faction(self.m_eltharion_faction_key)
    local yvresse_defence = yvresse_faction:pooled_resource_manager():resource("yvresse_defence"):value();

    self.out("wh2_dlc15_eltharion_mist: updating Mists of Yvresse regional effect bundles")
    if yvresse_defence >= 25 and yvresse_defence <= 49 then
        core:trigger_event("ScriptEventYvresseDefenceOne")

        for i = 1, #self.m_regions.level_1 do
            local region = self.m_regions.level_1[i]
            self:apply_mists_of_yvresse_effects(region)
        end
    elseif yvresse_defence >= 50 and yvresse_defence <= 74 then
        core:trigger_event("ScriptEventYvresseDefenceTwo")

        for i = 1, #self.m_regions.level_2 do
            local region = self.m_regions.level_2[i]
            self:apply_mists_of_yvresse_effects(region)
        end
    elseif yvresse_defence >= 75 and yvresse_faction:is_human() then
        core:trigger_event("ScriptEventYvresseDefenceThree")

        for i = 1, #self.m_regions.level_3 do
            local region = self.m_regions.level_3[i]
            self:apply_mists_of_yvresse_effects(region)
        end
    elseif yvresse_defence >= 75 then
        -- Bookmark: AI maintains level 2 bonuses
        for i = 1, #self.m_regions.level_3 do
            local region = self.m_regions.level_3[i]
            self:apply_mists_of_yvresse_effects(region)
        end
    end
end

function add_eltharion_mist_listeners()
    -- update straight away so mists persist when saving/loading
    Eltharion_Mists:update_mists_of_yvresse()
    Eltharion_Mists.out("Adding Eltharion Mist Listeners")

    -- Update the mists at the start of Yvresse's turn
    cm:add_faction_turn_start_listener_by_name("mist_of_yvresse_monitor", Eltharion_Mists.m_eltharion_faction_key, function(context)
        if cm:get_saved_value("eltharion_faction_is_dead") then
            -- if the eltharion-is thought to be dead check listener is not running then start it (eltharion's faction has come back to life?)
            cm:set_saved_value("eltharion_faction_is_dead", false)
            Eltharion_Mists:purge_mists_if_dead_listener()
        end
        Eltharion_Mists:update_mists_of_yvresse()
    end, true)

    -- listen for the Rite of Ladrielle/Athel Tamarha rituals and force an update so boosted effects appear immediately, or determine which level of the athel tamarha mist ritual is unlocked
    core:add_listener("mist_ritual_unlock", "RitualCompletedEvent", function(context)
        local ritual = context:ritual()

        return ritual:ritual_key() == "wh2_dlc15_ritual_hef_ladrielle" or ritual:ritual_chain_key() == "wh2_dlc15_athel_tamarha_mist"
    end, function(context)

        local ritual = context:ritual():ritual_key()

        if ritual == "wh2_dlc15_athel_tamarha_mist_3" then
            cm:set_saved_value("m_mist_ritual", 3)
        elseif ritual == "wh2_dlc15_athel_tamarha_mist_2" then
            cm:set_saved_value("m_mist_ritual", 2)
        elseif ritual == "wh2_dlc15_athel_tamarha_mist_1" then
            cm:set_saved_value("m_mist_ritual", 1)
        end

        Eltharion_Mists:update_mists_of_yvresse()
    end, true)

    -- Update every time Eltharion occupies/loses a settlement
    core:add_listener("mist_region_captured_update", "GarrisonOccupiedEvent", function(context)
        return context:garrison_residence():faction():name() == Eltharion_Mists.m_eltharion_faction_key or context:character():faction():name() == Eltharion_Mists.m_eltharion_faction_key
    end, function()
        Eltharion_Mists:update_mists_of_yvresse()
    end, true)

    -- update when the Yvresse Defence level increases
    core:add_listener("mist_yvresse_defence_update", "PooledResourceEffectChangedEvent", function(context)
        return context:resource():key() == "yvresse_defence"
    end, function()
        Eltharion_Mists:update_mists_of_yvresse()
    end, true)

    if not cm:get_saved_value("eltharion_faction_is_dead") then
        Eltharion_Mists:purge_mists_if_dead_listener()
    end
end
