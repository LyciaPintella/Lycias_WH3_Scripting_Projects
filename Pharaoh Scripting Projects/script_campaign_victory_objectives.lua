out("Loading victory_objectives.lua")

-- It's dangerous to read unprepared! Take this guide to help you fight with the evil that will unveil ahead.

--[[
The file is split into sections:
	- section "Listeners Update Objectives' Conditions"			- Listeners which update objectives' conditions	- added in function add_listeners_for_updating_objectives_conditions
	- section "Check and Update Victory Objectives Conditions"	- functions which actually check and update conditions
	- section "Util functions"									- utility functions
--]]

-- cache all human factions when campaign loads, there are functions which might end up being called often
local human_factions = {}
local campaign_type = nil
local disable_diplomatic_event_duplication = false
local is_first_tick = false -- boolean used to tell globally in the file whether currently we are in campaign start's first tick

if __game_mode == __lib_type_campaign then
     cm:add_saving_game_callback(
          function(context)
               cm:save_named_value("HIPPOLYTA_SACRED_REGIONS", hippolyta_sacred_regions, context)
               cm:save_named_value("VICTORY_CONDITIONS_DATA", victory_conditions_data, context)
               cm:save_named_value("TROY_ADI_VICTORY_CONDITIONS_DIOMEDES_CHAMPIONS",
                    troy_adi_diomedes_champion_units_amount, context)
          end
     )

     cm:add_loading_game_callback(
          function(context)
               hippolyta_sacred_regions = cm:load_named_value("HIPPOLYTA_SACRED_REGIONS", hippolyta_sacred_regions,
                    context)
               victory_conditions_data = cm:load_named_value("VICTORY_CONDITIONS_DATA", victory_conditions_data, context)
               troy_adi_diomedes_champion_units_amount = cm:load_named_value(
               "TROY_ADI_VICTORY_CONDITIONS_DIOMEDES_CHAMPIONS", troy_adi_diomedes_champion_units_amount, context)
          end
     )

     cm:add_first_tick_callback(
          function()
               -- cache all human factions when campaign loads, there are functions which might end up being called often
               human_factions = cm:get_human_factions()
               campaign_type = cm:model():campaign_type_string()

               if not victory_conditions_core.is_campaign_type_valid(campaign_type) then
                    return
               end

               add_listeners_for_updating_objectives_conditions()
          end
     )

     core:add_listener(
          "FirstTickAfterNewCampaignStarted_victory_objectives",
          "FirstTickAfterNewCampaignStarted",
          function(context)
               return victory_conditions_core.is_campaign_type_valid(cm:model():campaign_type_string())
          end,
          function(context)
               -- cache all human factions when campaign loads, there are functions which might end up being called often
               human_factions = cm:get_human_factions()
               is_first_tick = true

               -- first initialize activation conditions because objective's completion depends on it being active,
               -- so we do this in case that we achieve completion of objective right from the start
               initialize_conditions_progress(true, false)
               initialize_conditions_progress(false, true)

               is_first_tick = false
          end,
          true
     )
end


--------------------------------------------------------------
-- Listeners Update Objectives' Conditions
--------------------------------------------------------------
function add_listeners_for_updating_objectives_conditions()
     -- conditions_discover_any_region_of_list
     core:add_listener(
          "CharacterBesiegesSettlement_conditions_discover_any_region_of_list",
          "CharacterBesiegesSettlement",
          function(context) return true end,
          function(context)
               for _, human_faction_key in ipairs(human_factions) do
                    local human_faction = cm:get_faction(human_faction_key)
                    check_discover_any_region_of_list_for_foreign_regions(human_faction)
               end
          end,
          true
     )

     -- conditions_discover_any_region_of_list
     core:add_listener(
          "CharacterCapturedSettlementUnopposed_conditions_discover_any_region_of_list",
          "CharacterCapturedSettlementUnopposed",
          function(context) return true end,
          function(context)
               for _, human_faction_key in ipairs(human_factions) do
                    local human_faction = cm:get_faction(human_faction_key)
                    check_discover_any_region_of_list_for_foreign_regions(human_faction)
               end
          end,
          true
     )

     -- conditions_discover_any_region_of_list
     core:add_listener(
          "FactionTurnEnd_conditions_discover_any_region_of_list",
          "FactionTurnEnd",
          function(context) return true end,
          function(context)
               for _, human_faction_key in ipairs(human_factions) do
                    local human_faction = cm:get_faction(human_faction_key)
                    check_discover_any_region_of_list_for_foreign_regions(human_faction)
               end
          end,
          true
     )

     -- conditions_have_pooled_resource_amount
     core:add_listener(
          "PooledResourceTransactionEvent_conditions_have_pooled_resource_amount",
          "PooledResourceTransactionEvent",
          function(context)
               return context:faction():is_human() and
               table_contains(conditions_have_pooled_resource_amount.unique_pooled_resource_keys,
                    context:resource():key())
          end,
          function(context)
               check_have_pooled_resource_amount(context:faction(), context:resource():key())
          end,
          true
     )

     -- conditions_unlock_ancient_legacy
     core:add_listener(
          "AncientLegacyClaimed_conditions_unlock_ancient_legacy",
          "AncientLegacyClaimed",
          function(context)
               local ancient_legacy_name = context.stored_table.ancient_legacy_name
               return context.stored_table.faction:is_human() and
                   (conditions_unlock_ancient_legacy.activation[ancient_legacy_name] or conditions_unlock_ancient_legacy.completion[ancient_legacy_name])
          end,
          function(context)
               check_unlock_ancient_legacy(context.stored_table.faction, context.stored_table.ancient_legacy_name)
          end,
          true
     )

     -- conditions_have_max_favour_with_gods
     core:add_listener(
          "LocalDeitiesGodTotalFavourChanged_conditions_have_max_favour_with_gods",
          "LocalDeitiesGodTotalFavourChanged",
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_key)
               return faction:is_human()
          end,
          function(context)
               local god_key = context.stored_table.god_key
               local max_favour_reached = context.stored_table.total_favour >= deities.get_max_favour_for_god(god_key)
               local faction = cm:get_faction(context.stored_table.faction_key)
               check_have_max_favour_with_gods(faction, god_key, max_favour_reached)
          end,
          true
     )

     -- conditions_have_favour_amount_with_any_god
     core:add_listener(
          "LocalDeitiesGodTotalFavourChanged_conditions_have_favour_amount_with_any_god",
          "LocalDeitiesGodTotalFavourChanged",
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_key)
               return faction:is_human()
          end,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_key)
               check_have_favour_amount_with_any_god(faction, context.stored_table.god_key,
                    context.stored_table.total_favour)
          end,
          true
     )

     -- conditions_have_amount_of_max_level_of_building_chain
     core:add_listener(
          "BuildingCompleted_conditions_have_amount_of_max_level_of_building_chain",
          "BuildingCompleted",
          function(context)
               local building = context:building()
               return building:faction():is_human() and
                   table_contains(conditions_have_amount_of_max_level_of_building_chain.unique_building_chain_keys,
                        building:chain())
          end,
          function(context)
               local building = context:building()
               validate_conditions_have_amount_of_max_level_of_building_chain(building:faction())
          end,
          true
     )

     -- conditions_have_amount_of_max_level_of_building_chain
     core:add_listener(
          "BuildingDemolishedPostOutcomeApplication_conditions_have_amount_of_max_level_of_building_chain",
          "BuildingDemolishedPostOutcomeApplication",
          function(context)
               return context:faction():is_human()
          end,
          function(context)
               validate_conditions_have_amount_of_max_level_of_building_chain(context:faction())
          end,
          true
     )

     -- conditions_have_amount_of_max_level_of_building_chain
     core:add_listener(
          "RegionFactionChangeEvent_conditions_have_amount_of_max_level_of_building_chain",
          "RegionFactionChangeEvent",
          function(context)
               local new_owner_faction = context:region():owning_faction()
               local previous_owner_faction = context:previous_faction()
               return new_owner_faction:is_human() or previous_owner_faction:is_human()
          end,
          function(context)
               local new_owner_faction = context:region():owning_faction()
               local previous_owner_faction = context:previous_faction()

               if previous_owner_faction:is_human() then
                    validate_conditions_have_amount_of_max_level_of_building_chain(previous_owner_faction)
               end

               if new_owner_faction:is_human() then
                    validate_conditions_have_amount_of_max_level_of_building_chain(new_owner_faction)
               end
          end,
          true
     )

     -- conditions_have_amount_of_max_level_of_building_chain
     core:add_listener(
          "RegionAboutToBeAbandoned_conditions_have_amount_of_max_level_of_building_chain",
          "RegionAboutToBeAbandoned",
          function(context)
               return context:region():owning_faction():is_human()
          end,
          function(context)
               local region = context:region()
               validate_conditions_have_amount_of_max_level_of_building_chain(region:owning_faction(), region:name())
          end,
          true
     )

     -- conditions_have_amount_of_max_level_of_building_chain
     core:add_listener(
          "MilitaryForceBuildingCompleteEvent_conditions_have_amount_of_max_level_of_building_chain",
          "CharacterMilitaryForceBuildingCompleted",
          function(context)
               local building = context:building()
               return building:faction():is_human() and
                   table_contains(conditions_have_amount_of_max_level_of_building_chain.unique_building_chain_keys,
                        building:chain())
          end,
          function(context)
               validate_conditions_have_amount_of_max_level_of_building_chain(context:building():faction())
          end,
          true
     )

     -- conditions_have_amount_of_max_level_of_building_chain
     core:add_listener(
          "MilitaryForceDestroyed_conditions_have_amount_of_max_level_of_building_chain",
          "MilitaryForceDestroyed",
          function(context)
               local military_force = context:military_force()
               local is_horde = military_force:is_horde() or tribes_privileges.is_horde_type(military_force)
               return is_horde and military_force:faction():is_human()
          end,
          function(context)
               validate_conditions_have_amount_of_max_level_of_building_chain(context:military_force():faction(), nil,
                    context:military_force():command_queue_index())
          end,
          true
     )

     -- conditions_choose_legitimacy_path
     core:add_listener(
          "LegitimacyPathUnlocked_conditions_choose_legitimacy_path",
          "LegitimacyPathUnlocked",
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_key)
               return faction:is_human()
          end,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_key)
               check_choose_legitimacy_path(faction, context.stored_table.path_id)
          end,
          true
     )

     -- conditions_sea_people_invasion_started
     core:add_listener(
          "SeaPeopleInvasionStarted_conditions_sea_people_invasion_started",
          "SeaPeopleInvasionStarted",
          true,
          function(context)
               for _, human_faction_key in ipairs(human_factions) do
                    local human_faction = cm:get_faction(human_faction_key)
                    check_sea_people_invasion_started(human_faction)
               end
          end,
          true
     )

     -- conditions_raze_region
     core:add_listener(
          "CharacterRazedSettlement_conditions_raze_region",
          "CharacterRazedSettlement",
          function(context)
               local razing_faction = context:character():faction()
               return razing_faction:is_human()
          end,
          function(context)
               local razing_faction = context:character():faction()
               local region_key = context:garrison_residence():region():name()

               check_raze_region(razing_faction, region_key)
               check_raze_n_regions(razing_faction, 1)
          end,
          true
     )

     -- conditions_raze_region
     core:add_listener(
          "ScriptEventEminenceObediencePerformed_conditions_raze_region",
          "ScriptEventEminenceObediencePerformed",
          true,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_key)
               if not faction:is_human() then
                    return
               end

               local region_key = context.stored_table.region_key
               check_raze_region(faction, region_key)
               check_raze_n_regions(faction, 1)
          end,
          true
     )
     --lycia bookmark
     -- conditions_discover_any_region_of_list
     -- conditions_control_region
     core:add_listener(
          "RegionFactionChangeEvent_conditions_discover_any_region_of_list_conditions_control_region",
          "RegionFactionChangeEvent",
          function(context)
               local new_owner_faction = context:region():owning_faction()
               local prev_owner_faction = context:previous_faction()

               local contributes_to_any_human = function(faction, human_factions)
                    for _, human_faction_key in ipairs(human_factions) do
                         local human_faction = cm:get_faction(human_faction_key)
                         if faction_has_contributing_diplomacy_with_other_faction(faction, human_faction) then
                              return true
                         end
                    end
                    return false
               end

               local region_key = context:region():name()
               local is_region_of_interest = conditions_control_region and
               (conditions_control_region.activation[region_key] or conditions_control_region.completion[region_key])

               return is_region_of_interest and
                   (new_owner_faction:is_human() or prev_owner_faction:is_human() or new_owner_faction:is_rebel() or prev_owner_faction:is_rebel()
                        or contributes_to_any_human(new_owner_faction, human_factions) or contributes_to_any_human(prev_owner_faction, human_factions))
          end,
          function(context)
               local factions_gained_control = {}
               local factions_lost_control = {}

               local new_owner_faction = context:region():owning_faction()
               if new_owner_faction:is_human() then
                    table.insert(factions_gained_control, new_owner_faction:name())
               end

               local prev_owner_faction = context:previous_faction()
               if prev_owner_faction:is_human() then
                    table.insert(factions_lost_control, prev_owner_faction:name())
               end

               for _, human_faction_key in ipairs(human_factions) do
                    local human_faction = cm:get_faction(human_faction_key)

                    if human_faction_key ~= new_owner_faction:name() then
                         if faction_has_contributing_diplomacy_with_other_faction(new_owner_faction, human_faction) then
                              table.insert(factions_gained_control, human_faction_key)
                         end
                    end

                    if human_faction_key ~= prev_owner_faction:name() then
                         if faction_has_contributing_diplomacy_with_other_faction(prev_owner_faction, human_faction) then
                              table.insert(factions_lost_control, human_faction_key)
                         end
                    end
               end

               local region_key = context:region():name()
               for _, faction_lost_control_key in ipairs(factions_lost_control) do
                    -- change controlled status only if the faction lost control of the region (confederating an ally causes lost and gain of control at the same time)
                    if not table_contains(factions_gained_control, faction_lost_control_key) then
                         check_control_region(cm:get_faction(faction_lost_control_key), region_key, false)
                    end
               end

               for _, faction_gained_control_key in ipairs(factions_gained_control) do
                    -- change controlled status only if the faction gained control of the region (confederating an ally causes lost and gain of control at the same time)
                    if not table_contains(factions_lost_control, faction_gained_control_key) then
                         local faction_gained_control = cm:get_faction(faction_gained_control_key)
                         -- it's possible that this region was just discovered so make sure that objectives are activated
                         check_discover_any_region_of_list(faction_gained_control, region_key)
                         check_control_region(faction_gained_control, region_key, true)
                    end
               end

               if new_owner_faction:is_rebel() or prev_owner_faction:is_rebel() then
                    for _, human_faction_key in ipairs(human_factions) do
                         local human_faction = cm:get_faction(human_faction_key)
                         local controls_region = new_owner_faction:name() == human_faction_key or
                         faction_has_contributing_diplomacy_with_other_faction(new_owner_faction, human_faction)
                         check_control_region(human_faction, region_key, controls_region)
                    end
               end
          end,
          true
     )

     -- conditions_discover_any_region_of_list
     -- conditions_control_region
     core:add_listener(
          "PostPositiveDiplomaticEvent_conditions_discover_any_region_of_list_conditions_control_region",
          "PostPositiveDiplomaticEvent",
          function(context)
               local proposer = context:proposer()
               local recipient = context:recipient()

               return context:is_alliance()
                   or context:is_vassalage()
                   -- or context:is_subjugation()
                   or context:is_confederation()
          end,
          function(context)
               -- load newly acquired objectives from alliance
               if disable_diplomatic_event_duplication == false then
                    -- update progress in each of them.
                    local proposer = context:proposer()
                    local recipient = context:recipient()
                    for _, human_faction_key in ipairs(human_factions) do
                         local human_faction = cm:get_faction(human_faction_key)
                         check_discover_any_region_of_list_for_foreign_regions(human_faction)

                         if proposer:name() == human_faction_key then
                              check_control_region_from_diplomacy_with_faction(proposer, recipient, true)
                         elseif recipient:name() == human_faction_key then
                              check_control_region_from_diplomacy_with_faction(recipient, proposer, true)
                         end
                    end

                    disable_diplomatic_event_duplication = true
               else
                    disable_diplomatic_event_duplication = false
               end
          end,
          true
     )

     -- conditions_discover_any_region_of_list
     -- conditions_control_region
     core:add_listener(
          "NegativeDiplomaticEvent_conditions_discover_any_region_of_list_conditions_control_region",
          "NegativeDiplomaticEvent",
          function(context)
               return context:was_alliance()
                   or context:was_vassalage()
               -- or context:was_subjugation()
          end,
          function(context)
               -- load newly acquired objectives from alliance
               if disable_diplomatic_event_duplication == false then
                    -- update progress in each of them.
                    local proposer = context:proposer()
                    local recipient = context:recipient()
                    for _, human_faction_key in ipairs(human_factions) do
                         local human_faction = cm:get_faction(human_faction_key)
                         check_discover_any_region_of_list_for_foreign_regions(human_faction)

                         if proposer:name() == human_faction_key then
                              check_control_region_from_diplomacy_with_faction(proposer, recipient, false)
                         elseif recipient:name() == human_faction_key then
                              check_control_region_from_diplomacy_with_faction(recipient, proposer, false)
                         end
                    end

                    disable_diplomatic_event_duplication = true
               else
                    disable_diplomatic_event_duplication = false
               end
          end,
          true
     )

     -- conditions_discover_any_region_of_list
     -- conditions_control_region
     core:add_listener(
          "FactionBecomesSubject_conditions_discover_any_region_of_list_conditions_control_region",
          "FactionBecomesSubject",
          true,
          function(context)
               local subjugate = context:faction()
               for _, human_faction_key in ipairs(human_factions) do
                    local human_faction = cm:get_faction(human_faction_key)
                    if subjugate:is_subject_of(human_faction) then
                         check_discover_any_region_of_list_for_foreign_regions(human_faction)
                         check_control_region_from_diplomacy_with_faction(human_faction, subjugate, true)
                    end
               end
          end,
          true
     )

     -- conditions_control_region
     core:add_listener(
          "FactionRejectedSovereign_conditions_control_region",
          "FactionRejectedSovereign",
          function(context)
               return context:sovereign():is_human()
          end,
          function(context)
               check_control_region_from_diplomacy_with_faction(context:sovereign(), context:faction(), false)
          end,
          true
     )

     -- conditions_have_tudhaliya_princes
     core:add_listener(
          "TudhaliyaPrinceAssignedToVassal_conditions_have_tudhaliya_princes",
          "TudhaliyaPrinceAssignedToVassal",
          function(context)
               return context.stored_table.faction:is_human()
          end,
          function(context)
               check_have_tudhaliya_princes(context.stored_table.faction, true)
          end,
          true
     )

     -- conditions_have_tudhaliya_princes
     core:add_listener(
          "TudhaliyaPrinceUnassignedFromVassal_conditions_have_tudhaliya_princes",
          "TudhaliyaPrinceUnassignedFromVassal",
          function(context)
               return context.stored_table.faction:is_human()
          end,
          function(context)
               check_have_tudhaliya_princes(context.stored_table.faction, false)
          end,
          true
     )

     -- conditions_sea_people_invasion_ended
     core:add_listener(
          "SeaPeopleInvasionEnded_conditions_sea_people_invasion_ended",
          "SeaPeopleInvasionEnded",
          true,
          function(context)
               for _, human_faction_key in ipairs(human_factions) do
                    local human_faction = cm:get_faction(human_faction_key)
                    check_sea_people_invasion_ended(human_faction)
               end
          end,
          true
     )

     -- conditions_reach_campaign_turn
     core:add_listener(
          "FactionTurnStart_conditions_reach_campaign_turn",
          "FactionTurnStart",
          function(context)
               return context:faction():is_human()
          end,
          function(context)
               check_reach_campaign_turn(context:faction(), cm:turn_number())
          end,
          true
     )

     -- conditions_maintain_be_ruler
     core:add_listener(
          "ScriptEventLegitimacyWarEnded_conditions_maintain_be_ruler",
          "ScriptEventLegitimacyWarEnded",
          true,
          function(context)
               local previous_ruling_faction = nil
               if context.stored_table.previous_ruling_faction_key then
                    previous_ruling_faction = cm:get_faction(context.stored_table.previous_ruling_faction_key)
               end

               local new_ruling_faction = nil
               if context.stored_table.new_ruling_faction_key then
                    new_ruling_faction = cm:get_faction(context.stored_table.new_ruling_faction_key)
               end

               legitimacy_ruler_changed(previous_ruling_faction, new_ruling_faction,
                    context.stored_table.legitimacy_path_id)
          end,
          true
     )

     -- conditions_maintain_be_ruler
     core:add_listener(
          "ScriptEventRulerChanged_conditions_maintain_be_ruler",
          "ScriptEventRulerChanged",
          true,
          function(context)
               local previous_ruling_faction = nil
               if context.stored_table.old_ruler_faction_key then
                    previous_ruling_faction = cm:get_faction(context.stored_table.old_ruler_faction_key)
               end

               local new_ruling_faction = nil
               if context.stored_table.new_ruler_faction_key then
                    new_ruling_faction = cm:get_faction(context.stored_table.new_ruler_faction_key)
               end

               legitimacy_ruler_changed(previous_ruling_faction, new_ruling_faction,
                    context.stored_table.political_states.legitimacy_system.config.id)
          end,
          true
     )

     -- conditions_spend_pooled_resource_amount
     core:add_listener(
          "PooledResourceTransactionEvent_conditions_spend_pooled_resource_amount",
          "PooledResourceTransactionEvent",
          function(context)
               return context:faction():is_human() and
                   table_contains(conditions_spend_pooled_resource_amount.unique_pooled_resource_keys,
                        context:resource():key()) and
                   context:amount() < 0
          end,
          function(context)
               check_spend_pooled_resource_amount(context:faction(), context:resource():key(), math.abs(context:amount()))
          end,
          true
     )

     -- conditions_spend_turns_in_civilization_level
     core:add_listener(
          "FactionTurnStart_conditions_spend_turns_in_civilization_level",
          "FactionTurnStart",
          function(context)
               return context:faction():is_human()
          end,
          function(context)
               local civilization_level = pillars_civilization.get_current_civilization_level()
               check_spend_turns_in_civilization_level(context:faction(), civilization_level.name, true)
          end,
          true
     )

     -- conditions_spend_turns_in_any_tribe_category
     core:add_listener(
          "ScriptStartedTurnWithTribeCategory_conditions_spend_turns_in_any_tribe_category",
          "ScriptStartedTurnWithTribeCategory",
          function(context)
               return context.stored_table.faction:is_human()
          end,
          function(context)
               check_spend_turns_in_any_tribe_category(context.stored_table.faction, context.stored_table.tribe_category,
                    true)
          end,
          true
     )

     -- conditions_loot_resources_from_settlements
     core:add_listener(
          "CharacterLootedSettlement_conditions_loot_resources_from_settlements",
          "CharacterLootedSettlement",
          function(context)
               return context:character():faction():is_human()
          end,
          function(context)
               local faction = context:character():faction()
               local looted_resources = context:looted_resources():resources()
               for _, tuple in ipairs(looted_resources) do
                    local resource_key = tuple[1]
                    local amount = tuple[2]

                    check_loot_resources_from_settlements(faction, resource_key, amount, false)
               end
          end,
          true
     )

     -- conditions_maintain_muwatalli_gratitude_per_turn
     core:add_listener(
          "ScriptEventMuwatalliStartedTurnWithGratitude_conditions_maintain_muwatalli_gratitude_per_turn",
          "ScriptEventMuwatalliStartedTurnWithGratitude",
          function(context)
               return context.stored_table.faction:is_human()
          end,
          function(context)
               check_maintain_muwatalli_gratitude_per_turn(context.stored_table.faction, context.stored_table.gratitude)
          end,
          true
     )

     -- conditions_have_hammurabi_laws
     core:add_listener(
          "ScriptEventHammurabiActivatedLaw_conditions_have_hammurabi_laws",
          "ScriptEventHammurabiActivatedLaw",
          true,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_name)
               if not faction:is_human() then
                    return
               end

               check_have_hammurabi_laws(faction, 1)
          end,
          true
     )

     -- conditions_have_hammurabi_laws
     core:add_listener(
          "ScriptEventHammurabiRemovedActiveLaws_conditions_have_hammurabi_laws",
          "ScriptEventHammurabiRemovedActiveLaws",
          true,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_name)
               if not faction:is_human() then
                    return
               end

               check_have_hammurabi_laws(faction, -context.stored_table.laws_count)
          end,
          true
     )

     -- conditions_hatshepsut_cash_out_ancillary_or_effect_bundle
     core:add_listener(
          "ScriptEventHatshepsutCashOutAncillary_conditions_hatshepsut_cash_out_ancillary_or_effect_bundle",
          "ScriptEventHatshepsutCashOutAncillary",
          true,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_name)
               if not faction:is_human() then
                    return
               end

               check_hatshepsut_cash_out_ancillary_or_effect_bundle(faction, 1)
          end,
          true
     )

     -- conditions_hatshepsut_cash_out_ancillary_or_effect_bundle
     core:add_listener(
          "ScriptEventHatshepsutCashOutEffectBundle_conditions_hatshepsut_cash_out_ancillary_or_effect_bundle",
          "ScriptEventHatshepsutCashOutEffectBundle",
          true,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_name)
               if not faction:is_human() then
                    return
               end

               check_hatshepsut_cash_out_ancillary_or_effect_bundle(faction, 1)
          end,
          true
     )

     -- conditions_recruit_units
     core:add_listener(
          "UnitTrained_conditions_recruit_units",
          "UnitTrained",
          function(context)
               return context:unit():faction():is_human()
          end,
          function(context)
               local faction = context:unit():faction()
               local global_recruitment = context:globally_recruited()
               check_recruit_units(faction, 1, global_recruitment)
          end,
          true
     )

     -- conditions_unlock_forge_path
     core:add_listener(
          "ForgePathUnlocked_conditions_unlock_forge_path",
          "ForgePathUnlocked",
          true,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_key)
               if not faction:is_human() then
                    return
               end

               check_unlock_forge_path(faction, context.stored_table.path_id)
          end,
          true
     )

     -- conditions_use_eminence_obedience
     core:add_listener(
          "ScriptEventEminenceObediencePerformed_conditions_use_eminence_obedience",
          "ScriptEventEminenceObediencePerformed",
          true,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_key)
               if not faction:is_human() then
                    return
               end

               local is_cult_centre = context.stored_table.settlement_type == "cult_centre"
               check_use_eminence_obedience(faction, 1, is_cult_centre)
          end,
          true
     )

     -- conditions_maintain_equipped_ancillaries
     core:add_listener(
          "CharacterAncillaryEquipped_conditions_maintain_equipped_ancillaries",
          "CharacterAncillaryEquipped",
          function(context)
               return context:character():faction():is_human()
          end,
          function(context)
               local faction = context:character():faction()
               check_maintain_equipped_ancillaries(faction)
          end,
          true
     )

     -- conditions_maintain_equipped_ancillaries
     core:add_listener(
          "CharacterAncillaryLost_conditions_maintain_equipped_ancillaries",
          "CharacterAncillaryLost",
          function(context)
               return context:character():faction():is_human()
          end,
          function(context)
               local faction = context:character():faction()
               check_maintain_equipped_ancillaries(faction)
          end,
          true
     )

     -- conditions_capture_settlements_with_thutmose_culmination
     core:add_listener(
          "ScriptEventThutmoseConqueredCityWithCulmination_conditions_capture_settlements_with_thutmose_culmination",
          "ScriptEventThutmoseConqueredCityWithCulmination",
          true,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_key)
               if not faction:is_human() then
                    return
               end

               check_capture_settlements_with_thutmose_culmination(faction, 1)
          end,
          true
     )

     -- conditions_complete_ambitions
     core:add_listener(
          "ScriptEventAmbitionSuccessful_conditions_complete_ambitions",
          "ScriptEventAmbitionSuccessful",
          true,
          function(context)
               local faction = context:faction()
               if not faction:is_human() then
                    return
               end

               check_complete_ambitions(faction, 1, context.stored_table.pool_name)
          end,
          true
     )
end

--------------------------------------------------------------
-- END Listeners Update Objectives' Conditions
--------------------------------------------------------------

function initialize_conditions_progress(check_activation, check_completion)
     -- TODO: conditions_unlock_ancient_legacy
     -- TODO: conditions_have_max_favour_with_gods
     -- TODO: conditions_have_favour_amount_with_any_god
     -- TODO: conditions_have_amount_of_max_level_of_building_chain
     -- TODO: conditions_have_tudhaliya_princes
     -- TODO: conditions_sea_people_invasion_ended

     local  check_specific= { activation = check_activation, completion = check_completion }

     for _, human_faction_key in ipairs(human_factions) do
          local human_faction = cm:get_faction(human_faction_key)

          -- conditions_discover_any_region_of_list
          check_discover_any_region_of_list_for_foreign_regions(human_faction, check_specific)

          -- conditions_have_pooled_resource_amount
          for _, pooled_resource_key in ipairs(conditions_have_pooled_resource_amount.unique_pooled_resource_keys) do
               check_have_pooled_resource_amount(human_faction, pooled_resource_key, check_specific)
          end

          -- conditions_choose_legitimacy_path
          local unlocked_legitimacy = legitimacy_choice:get_unlocked_legitimacy(human_faction:name())
          if unlocked_legitimacy then
               check_choose_legitimacy_path(human_faction, unlocked_legitimacy.config.id, check_specific)
          end

          -- conditions_sea_people_invasion_started
          if sea_invasion.persistent.has_first_invasion_spawned then
               check_sea_people_invasion_started(human_faction, check_specific)
          end

          -- conditions_control_region
          do
               local controlled_regions = {}
               local own_regions_list = human_faction:region_list()
               for i = 0, own_regions_list:num_items() - 1 do
                    table.insert(controlled_regions, own_regions_list:item_at(i))
               end

               -- both vassals and subjugates are the same concept but are two different systems, so we handle both in case we change which one we use
               local vassals = human_faction:factions_master_of()
               local subjugates = human_faction:factions_sovereign_of()

               if human_faction:num_allies() > 0 or vassals:num_items() > 0 or subjugates:num_items() > 0 then
                    local insert_regions_for_contributing_factions = function(controlled_regions, contributing_factions)
                         if not contributing_factions then
                              return
                         end

                         for i = 0, contributing_factions:num_items() - 1 do
                              local region_list = contributing_factions:item_at(i):region_list()
                              for j = 0, region_list:num_items() - 1 do
                                   table.insert(controlled_regions, region_list:item_at(j))
                              end
                         end
                    end

                    insert_regions_for_contributing_factions(controlled_regions,
                         human_faction:factions_defensive_alliance_with())
                    insert_regions_for_contributing_factions(controlled_regions,
                         human_faction:factions_military_alliance_with())
                    insert_regions_for_contributing_factions(controlled_regions, vassals)
                    insert_regions_for_contributing_factions(controlled_regions, subjugates)
               end

               for _, region in ipairs(controlled_regions) do
                    check_control_region(human_faction, region:name(), true, check_specific)
               end
          end

          -- conditions_maintain_be_ruler
          if unlocked_legitimacy and unlocked_legitimacy.political_states_system:is_ruler(human_faction_key) then
               check_maintain_be_ruler(human_faction, unlocked_legitimacy.config.id, true, check_specific)
          end
     end

     --conditions_control_region for razed regions
     local world_regions = cm:model():world():region_manager():region_list()
     for i = 0, world_regions:num_items() - 1 do
          local region = world_regions:item_at(i)
          if region:is_abandoned() then
               for _, human_faction_key in ipairs(human_factions) do
                    check_control_region(cm:get_faction(human_faction_key), region:name(), false)
               end
          end
     end
end

--------------------------------------------------------------
-- Check and Update Victory Objectives Conditions
--------------------------------------------------------------

function check_activation(activation_conditions, faction, callback_modify_condition_progress)
     local faction_key = faction:name()

     for _, activation_condition in ipairs(activation_conditions) do
          local objective_uid = activation_condition.objective_uid

          if victory_conditions_core.is_objective_available_to_faction(faction, objective_uid) and
              not victory_conditions_core.has_active_objective_with_id(faction_key, objective_uid) then
               local condition_progress = victory_conditions_core.get_objective_activation_condition_progress(
               faction_key, objective_uid, activation_condition.id)
               if not condition_progress then
                    condition_progress = victory_conditions_core.create_objective_activation_condition_progress(
                    faction_key, objective_uid, activation_condition.id)
               end
               if not condition_progress then
                    script_error(
                    "VICTORY OBJECTIVES: Couldn't create condition progress. This might be OK when using cheats")
                    return
               end

               callback_modify_condition_progress(activation_condition, condition_progress)

               if victory_conditions_core.is_objective_ready_to_be_activated(faction_key, objective_uid) then
                    local add_event_feed_message = true
                    -- if is_first_tick then
                    -- 	local objective_config = table_find(victory_objectives_data, function(e) return e.uid == objective_uid end)
                    -- 	add_event_feed_message = objective_config.ignore_add_feed_message_on_campaign_start == nil or not objective_config.ignore_add_feed_message_on_campaign_start
                    -- end

                    victory_conditions_core.activate_objective_with_id(faction_key, objective_uid, add_event_feed_message)
               end
          end
     end
end

function check_completion(completion_conditions, faction, callback_modify_condition_progress)
     local faction_key = faction:name()
     for _, completion_condition in ipairs(completion_conditions) do
          local objective_uid = completion_condition.objective_uid

          if victory_conditions_core.is_objective_available_to_faction(faction, objective_uid) then
               local was_objective_completed = victory_conditions_core.is_objective_completed(faction_key, objective_uid)
               local condition_progress = victory_conditions_core.get_objective_completion_condition_progress(
               faction_key, objective_uid, completion_condition.id)
               if not condition_progress then
                    condition_progress = victory_conditions_core.create_objective_completion_condition_progress(
                    faction_key, objective_uid, completion_condition.id)
               end
               if not condition_progress then
                    script_error(
                    "VICTORY OBJECTIVES: Couldn't create condition progress. This might be OK when using cheats")
                    return
               end

               callback_modify_condition_progress(completion_condition, condition_progress)

               if victory_conditions_core.has_active_objective_with_id(faction_key, objective_uid) then
                    local is_objective_completed = victory_conditions_core.is_objective_completed(faction_key,
                         objective_uid)
                    if was_objective_completed ~= is_objective_completed then
                         if campaign_type == "sp_normal" then
                              victory_conditions_core.award_or_take_points_for_objective(faction, objective_uid,
                                   is_objective_completed)
                         elseif campaign_type == "mp_co_op_normal" then
                              for _, human_faction_key in ipairs(human_factions) do
                                   local human_faction = cm:get_faction(human_faction_key)
                                   victory_conditions_core.award_or_take_points_for_objective(human_faction,
                                        objective_uid, is_objective_completed)
                              end
                         end
                    end
               end
          end
     end
end

-- conditions_discover_any_region_of_list
function check_discover_any_region_of_list(faction, region_key, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          -- right now there is no need to store which region is discovered, if any is discovered we can safely mark the condition as completed
          condition_progress.is_completed = true
     end

     local activation_conditions = conditions_discover_any_region_of_list.activation[region_key]
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_discover_any_region_of_list.completion[region_key]
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_discover_any_region_of_list
function check_discover_any_region_of_list_for_foreign_regions(faction, check_specific)
     local all_visible_regions_list = faction:get_foreign_visible_regions_for_player()

     for i = 0, all_visible_regions_list:num_items() - 1 do
          local region_key = all_visible_regions_list:item_at(i):name()
          check_discover_any_region_of_list(faction, region_key, check_specific)
     end
end

-- conditions_have_pooled_resource_amount
function check_have_pooled_resource_amount(faction, pooled_resource_key, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          local progressed_amount = calculate_progress_on_have_pooled_resource_amount(faction, condition)
          condition_progress.is_completed = progressed_amount >= condition.amount
     end

     local activation_conditions = conditions_have_pooled_resource_amount.activation[pooled_resource_key]
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_have_pooled_resource_amount.completion[pooled_resource_key]
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

function calculate_progress_on_have_pooled_resource_amount(faction, condition)
     local amount_per_resouce = {}

     for _, pooled_resource_key in ipairs(condition.allowed_pooled_resources) do
          local pooled_resource = faction:pooled_resource(pooled_resource_key)

          if not pooled_resource:is_null_interface() then
               local amount = 0
               if condition.factor_key then
                    local factors = pooled_resource:factors()
                    for i = 0, factors:num_items() - 1 do
                         local factor = factors:item_at(i)
                         if factor:factor_id() == condition.factor_key then
                              amount = amount + factor:value()
                              break
                         end
                    end
               else
                    amount = pooled_resource:value()
               end

               table.insert(amount_per_resouce, { pooled_resource_key = pooled_resource_key, amount = amount })
          end
     end

     if condition.absolute_value then
          for index, it in ipairs(amount_per_resouce) do
               amount_per_resouce[index].amount = math.abs(it.amount)
          end
     end

     local progressed_amount = 0
     local max_entry = amount_per_resouce[1]
     for _, it in ipairs(amount_per_resouce) do
          if condition.sum_resources then
               progressed_amount = progressed_amount + it.amount
          end

          if max_entry.amount < it.amount then
               max_entry = it
          end
     end

     if not condition.sum_resources then
          progressed_amount = max_entry and max_entry.amount or 0
     end

     local max_entry_pooled_resource_key = max_entry and max_entry.pooled_resource_key or
     condition.allowed_pooled_resources[1]
     return progressed_amount, max_entry_pooled_resource_key
end

-- conditions_unlock_ancient_legacy
function check_unlock_ancient_legacy(faction, ancient_legacy_name, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          condition_progress.is_completed = true
     end

     local activation_conditions = conditions_unlock_ancient_legacy.activation[ancient_legacy_name]
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_unlock_ancient_legacy.completion[ancient_legacy_name]
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_have_max_favour_with_gods
function check_have_max_favour_with_gods(faction, god_key, max_favour_reached, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if not condition_progress.max_favoured_gods then
               condition_progress.max_favoured_gods = {}
          end

          local max_favoured_gods = condition_progress.max_favoured_gods
          if max_favour_reached then
               if not table_contains(max_favoured_gods, god_key) then
                    table.insert(max_favoured_gods, god_key)
               end
          else
               table_erase(max_favoured_gods, god_key)
          end

          local unique_cultures_met = true
          if condition.unique_cultures_amount and condition.unique_cultures_amount > 1 then
               local current_unique_cultures = {}
               for _, god_key in ipairs(max_favoured_gods) do
                    local god = deities.get_god(god_key)
                    if god.culture and not table_contains(current_unique_cultures, god.culture) then
                         table.insert(current_unique_cultures, god.culture)
                    end
               end

               unique_cultures_met = #current_unique_cultures >= condition.unique_cultures_amount
          end

          condition_progress.is_completed = unique_cultures_met and #max_favoured_gods >= condition.gods_amount
     end

     local activation_conditions = conditions_have_max_favour_with_gods.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_have_max_favour_with_gods.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_have_favour_amount_with_any_god
function check_have_favour_amount_with_any_god(faction, god_key, favour, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if not condition_progress.favour_with_gods then
               condition_progress.favour_with_gods = {}
          end

          condition_progress.favour_with_gods[god_key] = favour

          local max_favour = 0
          for _, it_favour in pairs(condition_progress.favour_with_gods) do
               if max_favour < it_favour then
                    max_favour = it_favour
               end
          end

          condition_progress.is_completed = max_favour >= condition.amount
     end

     local activation_conditions = conditions_have_favour_amount_with_any_god.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_have_favour_amount_with_any_god.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_have_amount_of_max_level_of_building_chain
function check_have_amount_of_max_level_of_building_chain(faction, building_chain_key, amount_owned,
                                                          max_level_amount_owned, check_specific, check_completion_status)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if not check_completion_status then
               if not condition_progress.buildings_progress then
                    condition_progress.buildings_progress = {}
               end

               if condition.check_max_level then
                    condition_progress.buildings_progress[building_chain_key] = max_level_amount_owned
               else
                    condition_progress.buildings_progress[building_chain_key] = amount_owned
               end
          else
               local total_owned_buildings = 0
               for _, building_amount in pairs(condition_progress.buildings_progress) do
                    total_owned_buildings = total_owned_buildings + building_amount
               end

               condition_progress.is_completed = total_owned_buildings >= condition.amount
          end
     end

     local activation_conditions = conditions_have_amount_of_max_level_of_building_chain.activation[building_chain_key]
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_have_amount_of_max_level_of_building_chain.completion[building_chain_key]
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_have_amount_of_max_level_of_building_chain
function validate_conditions_have_amount_of_max_level_of_building_chain(faction, force_empty_buildings_for_region_key,
                                                                        force_empty_buildings_for_military_force_cqi,
                                                                        check_specific)
     -- the condition type by buildings stands out of the rest with its implementation
     -- because it was tough to get the data in the right moment (event)

     local building_chains_data = get_building_chains_data(faction, force_empty_buildings_for_region_key,
          force_empty_buildings_for_military_force_cqi)

     -- we must also account for those buildings that we don't have anymore
     for _, building_chain_key in ipairs(conditions_have_amount_of_max_level_of_building_chain.unique_building_chain_keys) do
          local building_chain_data = table_find(building_chains_data,
               function(it) return it.building_chain_key == building_chain_key end)
          if not building_chain_data then
               table.insert(building_chains_data,
                    { building_chain_key = building_chain_key, amount = 0, max_level_amount = 0 })
          end
     end

     -- Now that we can have multiple building chains for this condition, we need to first update the data for all chains and after that check if it is completed or not
     for i = 1, 2 do
          local check_completion_status = (i == 2)
          for _, building_chain_data in ipairs(building_chains_data) do
               check_have_amount_of_max_level_of_building_chain(faction, building_chain_data.building_chain_key,
                    building_chain_data.amount, building_chain_data.max_level_amount, check_specific,
                    check_completion_status)
          end
     end
end

-- conditions_choose_legitimacy_path
function check_choose_legitimacy_path(faction, legitimacy_path_id, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          -- once a legitimacy path is chosen we can't change it
          if condition_progress.is_completed then
               return
          end

          condition_progress.is_completed = condition.legitimacy_path == legitimacy_path_id
     end

     local activation_conditions = conditions_choose_legitimacy_path.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_choose_legitimacy_path.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_sea_people_invasion_started
function check_sea_people_invasion_started(faction, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          condition_progress.is_completed = true
     end

     local activation_conditions = conditions_sea_people_invasion_started.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_sea_people_invasion_started.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_control_region
function check_control_region(faction, region_key, is_controlled, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          local is_completed = is_controlled

          if condition.should_consider_razed_regions_as_under_control then
               local region = cm:get_region(region_key)
               if region then
                    is_completed = is_completed or region:is_abandoned()
               end
          end

          condition_progress.is_completed = is_completed
     end

     local activation_conditions = conditions_control_region.activation[region_key]
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_control_region.completion[region_key]
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end
--bookmark this diplomacy script works.
-- conditions_control_region
function check_control_region_from_diplomacy_with_faction(human_faction, ai_faction, is_controlled, check_specific)
     local region_list = ai_faction:region_list()
     for i = 0, region_list:num_items() - 1 do
          check_control_region(human_faction, region_list:item_at(i):name(), is_controlled, check_specific)
     end
end

-- conditions raze_region
function check_raze_region(faction, region_key, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          condition_progress.is_completed = true
     end

     local activation_conditions = conditions_raze_region.activation[region_key]
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_raze_region.completion[region_key]
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions check_raze_n_regions
function check_raze_n_regions(faction, razed_amount, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if condition_progress.num_razed_regions == nil then
               condition_progress.num_razed_regions = 0
          end

          condition_progress.num_razed_regions = condition_progress.num_razed_regions + razed_amount

          condition_progress.is_completed = condition_progress.num_razed_regions >= condition.amount
     end

     local activation_conditions = conditions_raze_n_regions.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_raze_n_regions.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_have_tudhaliya_princes
function check_have_tudhaliya_princes(faction, is_assigned, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if not condition_progress.assigned_count then
               condition_progress.assigned_count = 0
          end

          local delta = is_assigned and 1 or -1
          condition_progress.assigned_count = condition_progress.assigned_count + delta
          condition_progress.is_completed = condition_progress.assigned_count >= condition.amount
     end

     local activation_conditions = conditions_have_tudhaliya_princes.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_have_tudhaliya_princes.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_sea_people_invasion_ended
function check_sea_people_invasion_ended(faction, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          condition_progress.is_completed = true
     end

     local activation_conditions = conditions_sea_people_invasion_ended.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_sea_people_invasion_ended.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_reach_campaign_turn
function check_reach_campaign_turn(faction, turn, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          condition_progress.is_completed = turn >= condition.turn
     end

     local activation_conditions = conditions_reach_campaign_turn.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_reach_campaign_turn.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_maintain_be_ruler
function check_maintain_be_ruler(faction, legitimacy_path_id, is_current_ruler, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if condition.legitimacy_path ~= legitimacy_path_id then
               return
          end

          condition_progress.is_completed = is_current_ruler
     end

     local activation_conditions = conditions_maintain_be_ruler.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_maintain_be_ruler.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_spend_pooled_resource_amount
function check_spend_pooled_resource_amount(faction, pooled_resource_key, amount, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if condition_progress.total_spend == nil then
               condition_progress.total_spend = 0
          end

          condition_progress.total_spend = condition_progress.total_spend + amount
          condition_progress.is_completed = condition_progress.total_spend >= condition.amount
     end

     local activation_conditions = conditions_spend_pooled_resource_amount.activation[pooled_resource_key]
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_spend_pooled_resource_amount.completion[pooled_resource_key]
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

function check_spend_turns_in_civilization_level(faction, current_civilization_level, increment_turns, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          local target_civilization_level = condition.civilization_level
          if increment_turns then
               if condition.in_a_row then
                    local civilization_level_last_turn = condition_progress.civilization_level_last_turn or ""
                    local has_civilization_level_changed = civilization_level_last_turn ~= current_civilization_level

                    if has_civilization_level_changed then
                         if civilization_level_last_turn == target_civilization_level then
                              condition_progress[target_civilization_level] = nil
                         end
                    end

                    condition_progress.civilization_level_last_turn = current_civilization_level
               end

               if current_civilization_level == target_civilization_level then
                    if condition_progress[target_civilization_level] == nil then
                         condition_progress[target_civilization_level] = 0
                    end

                    condition_progress[target_civilization_level] = condition_progress[target_civilization_level] + 1
               end
          end

          local turns_spent = condition_progress[target_civilization_level]
          condition_progress.is_completed = is_number(turns_spent) and turns_spent >= condition.turns
     end

     local activation_conditions = conditions_spend_turns_in_civilization_level.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_spend_turns_in_civilization_level.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

function check_spend_turns_in_any_tribe_category(faction, tribe_category, increment_turns, check_specific)
     if not tribe_category then
          return
     end

     local callback_modify_condition_progress = function(condition, condition_progress)
          if not condition_progress.categories_turns then
               condition_progress.categories_turns = {}
          end

          local spent_turns = condition_progress.categories_turns[tribe_category]
          if spent_turns == nil then
               condition_progress.categories_turns[tribe_category] = 0
               spent_turns = 0
          end

          if increment_turns then
               condition_progress.categories_turns[tribe_category] = spent_turns + 1
               spent_turns = condition_progress.categories_turns[tribe_category]
          end

          local has_spent_enough_turns_in_any_category = false
          for _, turns in pairs(condition_progress.categories_turns) do
               if turns >= condition.turns then
                    has_spent_enough_turns_in_any_category = true
                    break
               end
          end

          condition_progress.is_completed = has_spent_enough_turns_in_any_category
     end

     local activation_conditions = conditions_spend_turns_in_any_tribe_category.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_spend_turns_in_any_tribe_category.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_loot_resources_from_settlements
function check_loot_resources_from_settlements(faction, pooled_resource_key, amount, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if condition_progress.total_looted == nil then
               condition_progress.total_looted = 0
          end

          condition_progress.total_looted = condition_progress.total_looted + amount
          condition_progress.is_completed = condition_progress.total_looted >= condition.amount
     end

     local activation_conditions = conditions_loot_resources_from_settlements.activation[pooled_resource_key]
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_loot_resources_from_settlements.completion[pooled_resource_key]
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_maintain_muwatalli_gratitude_per_turn
function check_maintain_muwatalli_gratitude_per_turn(faction, gratitude_per_turn, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          -- save current amount to be used in UI
          condition_progress.current_amount = gratitude_per_turn
          condition_progress.is_completed = condition_progress.current_amount >= condition.amount
     end

     local activation_conditions = conditions_maintain_muwatalli_gratitude_per_turn.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_maintain_muwatalli_gratitude_per_turn.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_have_hammurabi_laws
function check_have_hammurabi_laws(faction, gained_delta, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if not condition_progress.gained_count then
               condition_progress.gained_count = 0
          end

          condition_progress.gained_count = condition_progress.gained_count + gained_delta
          condition_progress.is_completed = condition_progress.gained_count >= condition.amount
     end

     local activation_conditions = conditions_have_hammurabi_laws.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_have_hammurabi_laws.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_hatshepsut_cash_out_ancillary_or_effect_bundle
function check_hatshepsut_cash_out_ancillary_or_effect_bundle(faction, cashed_out_amount, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if not condition_progress.total_cashed_out then
               condition_progress.total_cashed_out = 0
          end

          condition_progress.total_cashed_out = condition_progress.total_cashed_out + cashed_out_amount
          condition_progress.is_completed = condition_progress.total_cashed_out >= condition.amount
     end

     local activation_conditions = conditions_hatshepsut_cash_out_ancillary_or_effect_bundle.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_hatshepsut_cash_out_ancillary_or_effect_bundle.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_recruit_units
function check_recruit_units(faction, recruited_amount, is_global_recruitment, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          -- is_global_recruitment is an optional property, if it doesn't exist we simply count every recruitment
          if condition.is_global_recruitment and condition.is_global_recruitment ~= is_global_recruitment then
               return
          end

          if not condition_progress.recruited_amount then
               condition_progress.recruited_amount = 0
          end

          condition_progress.recruited_amount = condition_progress.recruited_amount + recruited_amount
          condition_progress.is_completed = condition_progress.recruited_amount >= condition.amount
     end

     local activation_conditions = conditions_recruit_units.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_recruit_units.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_unlock_forge_path
function check_unlock_forge_path(faction, path_id, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          -- once a path is chosen we can't change it
          if condition_progress.is_completed then
               return
          end

          condition_progress.is_completed = condition.path_name == path_id
     end

     local activation_conditions = conditions_unlock_forge_path.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_unlock_forge_path.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_use_eminence_obedience
function check_use_eminence_obedience(faction, used_amount, is_cult_centre, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          -- is_cult_centre is an optional property, if it doesn't exist we simply count every use
          if condition.is_cult_centre and condition.is_cult_centre ~= is_cult_centre then
               return
          end

          if not condition_progress.used_amount then
               condition_progress.used_amount = 0
          end

          condition_progress.used_amount = condition_progress.used_amount + used_amount
          condition_progress.is_completed = condition_progress.used_amount >= condition.amount
     end

     local activation_conditions = conditions_use_eminence_obedience.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_use_eminence_obedience.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_maintain_equipped_ancillaries
function check_maintain_equipped_ancillaries(faction, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          local equipped_ancillaries = {}
          local characters = faction:character_list()
          for i = 0, characters:num_items() - 1 do
               local character = characters:item_at(i)
               local ancillaries = character:ancillaries()
               for j = 0, ancillaries:num_items() - 1 do
                    local ancillary = ancillaries:item_at(j)
                    local ancillary_type = ancillary:type()
                    if ancillary_type == condition.ancillary_type then
                         local ancillary_key = ancillary:ancillary_key()
                         if equipped_ancillaries[ancillary_key] then
                              equipped_ancillaries[ancillary_key] = equipped_ancillaries[ancillary_key] + 1
                         else
                              equipped_ancillaries[ancillary_key] = 1
                         end
                    end
               end
          end

          local total_equipped = 0
          -- NOTE: if this loop should modify the model then rework it so it uses ipairs or dpairs
          for _, amount in pairs(equipped_ancillaries) do
               if condition.unique_ancillaries then
                    total_equipped = total_equipped + 1
               else
                    total_equipped = total_equipped + amount
               end
          end

          condition_progress.total_equipped = total_equipped
          condition_progress.is_completed = condition_progress.total_equipped >= condition.amount
     end

     local activation_conditions = conditions_maintain_equipped_ancillaries.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_maintain_equipped_ancillaries.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_capture_settlements_with_thutmose_culmination
function check_capture_settlements_with_thutmose_culmination(faction, culminations_amount, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if not condition_progress.culminations_amount then
               condition_progress.culminations_amount = 0
          end

          condition_progress.culminations_amount = condition_progress.culminations_amount + culminations_amount
          condition_progress.is_completed = condition_progress.culminations_amount >= condition.amount
     end

     local activation_conditions = conditions_capture_settlements_with_thutmose_culmination.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_capture_settlements_with_thutmose_culmination.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

-- conditions_complete_ambitions
function check_complete_ambitions(faction, completed_amount, pool_name, check_specific)
     local callback_modify_condition_progress = function(condition, condition_progress)
          if not (is_nil(condition.pool) or pool_name == condition.pool) then
               return
          end

          if not condition_progress.completed_amount then
               condition_progress.completed_amount = 0
          end

          condition_progress.completed_amount = condition_progress.completed_amount + completed_amount
          condition_progress.is_completed = condition_progress.completed_amount >= condition.amount
     end

     local activation_conditions = conditions_complete_ambitions.activation
     if (not check_specific or check_specific.activation) and activation_conditions then
          check_activation(activation_conditions, faction, callback_modify_condition_progress)
     end

     local completion_conditions = conditions_complete_ambitions.completion
     if (not check_specific or check_specific.completion) and completion_conditions then
          check_completion(completion_conditions, faction, callback_modify_condition_progress)
     end
end

--------------------------------------------------------------
-- END: Check and Update Victory Objectives Conditions
--------------------------------------------------------------

--------------------------------------------------------------
--Util functions
--------------------------------------------------------------

function get_building_chains_data(faction, force_empty_buildings_for_region_key,
                                  force_empty_buildings_for_military_force_cqi)
     local building_chains_data = {}

     local process_building = function(building_chains_data, building, force_empty_buildings)
          local building_chain_key = building:chain()
          local building_chain_data = table_find(building_chains_data,
               function(it) return it.building_chain_key == building_chain_key end)
          if not building_chain_data then
               building_chain_data = { building_chain_key = building_chain_key, amount = 0, max_level_amount = 0 }
               table.insert(building_chains_data, building_chain_data)
          end

          if not force_empty_buildings then
               building_chain_data.amount = building_chain_data.amount + 1

               if building:is_max_level_in_chain() then
                    building_chain_data.max_level_amount = building_chain_data.max_level_amount + 1
               end
          end
     end

     local region_list = faction:region_list()
     for i = 0, region_list:num_items() - 1 do
          local region = region_list:item_at(i)
          local force_empty_buildings = force_empty_buildings_for_region_key and
          force_empty_buildings_for_region_key == region:name()

          local settlement = region:settlement()
          local building_list = settlement:building_list()
          for j = 0, building_list:num_items() - 1 do
               process_building(building_chains_data, building_list:item_at(j), force_empty_buildings)
          end

          -- We have to handle ERS separately
          local slot_list = region:slot_list()
          for j = 0, slot_list:num_items() - 1 do
               local slot = slot_list:item_at(j)
               if slot:is_infrastructure_slot() and slot:has_building() and slot:faction():name() == faction:name() then
                    process_building(building_chains_data, slot:building(), force_empty_buildings)
               end
          end
     end

     local foreign_regions_with_owned_ers = faction:foreign_regions_with_owned_ers_list()
     for i = 0, foreign_regions_with_owned_ers:num_items() - 1 do
          local region = foreign_regions_with_owned_ers:item_at(i)
          local force_empty_buildings = force_empty_buildings_for_region_key and
          force_empty_buildings_for_region_key == region:name()

          local slot_list = region:slot_list()
          for j = 0, slot_list:num_items() - 1 do
               local slot = slot_list:item_at(j)
               if slot:is_infrastructure_slot() and slot:has_building() and slot:faction():name() == faction:name() then
                    process_building(building_chains_data, slot:building(), force_empty_buildings)
               end
          end
     end

     -- horde's are a special case since their buildings are in the military force
     local military_force_list = faction:military_force_list()
     for i = 0, military_force_list:num_items() - 1 do
          local military_force = military_force_list:item_at(i)

          local building_list = military_force:buildings()
          if building_list then
               local force_empty_buildings = force_empty_buildings_for_military_force_cqi and
               force_empty_buildings_for_military_force_cqi == military_force:command_queue_index()

               for j = 0, building_list:num_items() - 1 do
                    local building = building_list:item_at(j)
                    local building_chain_key = building:chain()
                    local building_chain_data = table_find(building_chains_data,
                         function(it) return it.building_chain_key == building_chain_key end)
                    if not building_chain_data then
                         building_chain_data = { building_chain_key = building_chain_key, amount = 0, max_level_amount = 0 }
                         table.insert(building_chains_data, building_chain_data)
                    end

                    if not force_empty_buildings then
                         building_chain_data.amount = building_chain_data.amount + 1

                         if building:is_max_level_in_chain() then
                              building_chain_data.max_level_amount = building_chain_data.max_level_amount + 1
                         end
                    end
               end
          end
     end

     return building_chains_data
end

function legitimacy_ruler_changed(previous_ruling_faction, new_ruling_faction, legitimacy_path_id)
     local is_previous_ruling_faction_human = previous_ruling_faction and previous_ruling_faction:is_human()
     local is_new_ruling_faction_human = new_ruling_faction and new_ruling_faction:is_human()
     if not is_previous_ruling_faction_human and not is_new_ruling_faction_human then
          return
     end

     if is_previous_ruling_faction_human then
          check_maintain_be_ruler(previous_ruling_faction, legitimacy_path_id, false)
     end

     if is_new_ruling_faction_human then
          check_maintain_be_ruler(new_ruling_faction, legitimacy_path_id, true)
     end
end

function faction_has_contributing_diplomacy_with_other_faction(faction, other_faction)
     return faction:allied_with(other_faction) or
         faction:is_vassal_of(other_faction) or
         faction:is_subject_of(other_faction)
end
