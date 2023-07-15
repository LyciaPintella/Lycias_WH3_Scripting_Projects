local tableChaosSubCultures = {}

tableChaosSubCultures["wh3_main_pro_sc_kho_khorne"] = true
tableChaosSubCultures["wh3_main_pro_sc_tze_tzeentch"] = true
tableChaosSubCultures["wh3_main_sc_dae_daemons"] = true
tableChaosSubCultures["wh3_main_sc_kho_khorne"] = true
tableChaosSubCultures["wh3_main_sc_nur_nurgle"] = true
tableChaosSubCultures["wh3_main_sc_sla_slaanesh"] = true
tableChaosSubCultures["wh3_main_sc_tze_tzeentch"] = true
tableChaosSubCultures["wh_main_sc_chs_chaos"] = true

function AAAFyTyChaosMaxCities_Listeners()

    local listFactions = cm:model():world():faction_list()

    core:add_listener("AAAFyTyChaosMaxCities_WorldStartRound", "WorldStartRound", function(context)

        return cm:turn_number() > 0

    end, function(context)

        -- out("AAAFyTyChaosMaxCities - WorldStartRound!")

        for iCounter = 0, listFactions:num_items() - 1 do

            local factionCurrent = listFactions:item_at(iCounter)

            if tableChaosSubCultures[factionCurrent:subculture()] then

                local iNumRegions = factionCurrent:region_list():num_items()

                if iNumRegions > 0 then

                    for iSubCounter = 0, iNumRegions - 1 do

                        local slotCurrent = factionCurrent:region_list():item_at(iSubCounter):settlement():primary_slot()
                        local strBuilding = slotCurrent:building():name()
                        local tableUpgrades = cm:get_building_level_upgrades(strBuilding)

                        if is_empty_table(tableUpgrades) == false then

                            repeat

                                if #tableUpgrades > 1 then

                                    strBuilding = tableUpgrades[cm:random_number(#tableUpgrades, 1)]

                                else

                                    strBuilding = tableUpgrades[1]

                                end

                                tableUpgrades = cm:get_building_level_upgrades(strBuilding)

                            until is_empty_table(tableUpgrades)

                            cm:instantly_upgrade_building_in_region(slotCurrent, strBuilding)

                        end

                    end

                end

            end

        end

    end, true)

end

cm:add_first_tick_callback(function()
    AAAFyTyChaosMaxCities_Listeners()
end);
