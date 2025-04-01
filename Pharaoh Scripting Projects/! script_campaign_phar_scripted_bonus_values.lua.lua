out("Loading phar_scripted_bonus_values.lua")

scripted_bonus_values = {
     bonus_value_keys = {
          restore_ap_post_battle = "restore_post_battle_action_points",
          restore_ap_post_general_action = "restore_post_general_interaction_action_points",
          restore_ap_post_prayer = "restore_post_prayer_action_points",
          start_hp_new_recruit = "start_hp_new_recruit_mod",
          char_xp_per_turn = "scripted_char_xp_per_turn",
          victory_points_from_buildings = "scripted_victory_points_from_buildings",
          enable_stalking = "scripted_enable_stalking_stance",
          local_deities_favour_all_gods = "local_deities_favour_all_gods",
          scripted_attrition_to_enemy_from_raiding = "scripted_attrition_to_enemy_from_raiding",
          gold_per_defensive_or_military_alliance = "gold_per_defensive_or_military_alliance",
          legitimacy_from_allies = "scripted_legitimacy_from_allies",
          ten_or_less_units = {
               [1] = { bonus_value_key = "scripted_bonus_10_or_less_units_food_upkeep", effect_key = "phar_main_unit_upkeep_cost_percentage_multiplier_mod_food" },
               [2] = { bonus_value_key = "scripted_bonus_10_or_less_units_bronze_upkeep", effect_key = "phar_main_unit_upkeep_cost_percentage_multiplier_mod_bronze" },
               [3] = { bonus_value_key = "scripted_bonus_10_or_less_units_movement", effect_key = "phar_main_mod_land_movement_campaign_basic" },
               [4] = { bonus_value_key = "scripted_bonus_10_or_less_units_ambush", effect_key = "phar_main_ambush_chance_of_success_attack_bonus_basic" },
               [5] = { bonus_value_key = "scripted_bonus_10_or_less_units_aura_size", effect_key = "phar_main_general_aoe_mod_unit_sets_bodyguards" },
               [6] = { bonus_value_key = "scripted_bonus_10_or_less_units_aura_morale", effect_key = "phar_main_general_aoe_morale_effect_mod_unit_sets_phar_main_bodyguards" },
          },
          equipment_upon_recruitment = "scripted_ancillary_upon_recruitment"
     },
     saved_data = {
          unit_prev_hp = {},
          mf_with_stalking_stance = {},
     },
     variables = {
          stalking_stance_db_key = "MILITARY_FORCE_ACTIVE_STANCE_TYPE_STALKING",
          raiding_stance_enum_number = 14,
          scripted_attrition_from_raiding_bundle_key = "effect_bundle_agent_actor_placeholder",
          scripted_attrition_from_raiding_effect_key = "phar_main_damage_mod_attrition_record_all",
          scripted_attrition_from_raiding_effect_scope = "force_to_force_enemy_provincewide",

          ancillary_upon_recruit_setup = {
               [1] = {
                    { item = "phar_main_common_equipment_chariot",  weight = 10 },
                    { item = "phar_main_rare_equipment_chariots_6", weight = 10 },
               },
               [2] = {
                    { item = "phar_main_rare_equipment_chariots_2", weight = 10 },
                    { item = "phar_main_rare_equipment_chariots_5", weight = 10 },
                    { item = "phar_main_rare_equipment_chariots_6", weight = 10 },
               },
               [3] = {
                    { item = "phar_main_rare_equipment_chariots_1", weight = 10 },
                    { item = "phar_main_rare_equipment_chariots_2", weight = 10 },
                    { item = "phar_main_rare_equipment_chariots_3", weight = 10 },
                    { item = "phar_main_rare_equipment_chariots_4", weight = 10 },
                    { item = "phar_main_rare_equipment_chariots_5", weight = 10 },
                    { item = "phar_main_rare_equipment_chariots_6", weight = 10 },
               },
          }
     },
}

function scripted_bonus_values.should_apply_hp_mod_at_battle_start(force)
     return cm:get_forces_bonus_value(force, "hp_mod_at_battle_start_when_marching") > 0 and
     force:active_stance() == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_MARCH"
end

function scripted_bonus_values.apply_hp_mod_at_battle_start(force)
     local is_mod_already_applied = force:unit_list():num_items() == 0 or
     scripted_bonus_values.saved_data.unit_prev_hp[force:unit_list():item_at(0):command_queue_index()] ~= nil
     if is_mod_already_applied then
          return
     end

     local hp_mod = cm:get_forces_bonus_value(force, "hp_mod_at_battle_start_when_marching") * 0.01

     for i = 0, force:unit_list():num_items() - 1 do
          local unit = force:unit_list():item_at(i)
          local current_hp = unit:num_soldiers_or_hitpoints()
          local delta = math.floor(unit:start_soldiers_or_hitpoints() * hp_mod)
          local new_hp = math.max(1, current_hp - delta)
          cm:set_unit_soldiers_or_hitpoints(unit, new_hp)
          scripted_bonus_values.saved_data.unit_prev_hp[unit:command_queue_index()] = current_hp
     end
end

function scripted_bonus_values.restore_hp_mod_at_battle_start(force)
     for i = 0, force:unit_list():num_items() - 1 do
          local unit = force:unit_list():item_at(i)
          local prev_hp = scripted_bonus_values.saved_data.unit_prev_hp[unit:command_queue_index()]
          cm:set_unit_soldiers_or_hitpoints(unit, prev_hp or 0)
     end
end

-- Works only for characters with military forces(not agents)!
function scripted_bonus_values.restore_action_points(character, bonus_value)
     local mf = character:military_force()
     if mf and not mf:is_null_interface() then
          local action_points = cm:get_forces_bonus_value(mf, bonus_value)
          action_points = action_points + cm:get_characters_bonus_value(character, bonus_value)
          action_points = action_points / 100 --converting to decimal as we're using percentages for this method

          if action_points > 0 then
               cm:replenish_action_points(cm:char_lookup_str(character:command_queue_index()), 0, action_points)
          end
     end
end

function scripted_bonus_values.grant_favour_to_all_gods(faction_key, amount, source)
     local god_slots = deities.get_god_slots(faction_key)
     for i = 1, deities.get_faction_god_slots_count(faction_key) do
          if god_slots[i].god_key then
               local god_key = god_slots[i].god_key
               deities.grant_favour(faction_key, god_key, amount, source)
          end
     end
end

function scripted_bonus_values.check_building_for_scripted_bonus_value(building, bonus_value_key)
     if not building or building:is_null_interface() then
          script_error(
          "ERROR: scripted_bonus_values.check_building_for_scripted_bonus_value called, but the provided building is invalid: " ..
          building)
          return
     end

     if not bonus_value_key or not is_string(bonus_value_key) then
          script_error(
          "ERROR scripted_bonus_values.check_building_for_scripted_bonus_value called, but the provided bonus_value_key is not valid: " ..
          bonus_value_key)
          return
     end

     local searched_sbv_value = 0
     local effects_list = building:effects_list()
     for i = 0, effects_list:num_items() - 1 do
          local curr_effect_bonus_values = effects_list:item_at(i):bonus_values()
          searched_sbv_value = searched_sbv_value + curr_effect_bonus_values:scripted_value(bonus_value_key, "value")
     end

     return searched_sbv_value
end

function scripted_bonus_values.check_region_for_building_with_scripted_bonus_value(region, bonus_value_key)
     if not region or region:is_null_interface() then
          script_error(
          "ERROR: scripted_bonus_values.check_region_for_building_with_scripted_bonus_value called, but the provided region is not valid: " ..
          region)
          return
     end

     if not bonus_value_key or not is_string(bonus_value_key) then
          script_error(
          "ERROR scripted_bonus_values.check_region_for_building_with_scripted_bonus_value called, but the provided bonus_value_key is not valid: " ..
          bonus_value_key)
          return
     end

     local searched_sbv_value = 0
     local slot_list = region:slot_list()
     for i = 0, slot_list:num_items() - 1 do
          local curr_slot = slot_list:item_at(i)
          if curr_slot:has_building() then
               searched_sbv_value = searched_sbv_value +
               scripted_bonus_values.check_building_for_scripted_bonus_value(curr_slot:building(), bonus_value_key)
          end
     end

     return searched_sbv_value
end

function scripted_bonus_values.add_victory_points_from_buildings(faction_key, amount)
     local human_factions_list = cm:get_human_factions()
     if cm:get_faction(faction_key):is_human() then
          for i, faction in ipairs(human_factions_list) do
               cm:faction_add_pooled_resource(faction, "phar_victory_points", "buildings", amount)
          end
     else
          cm:faction_add_pooled_resource(faction_key, "phar_victory_points", "buildings", amount)
     end
end

function scripted_bonus_values.check_bonus_values_from_building(building, should_add)
     if not building or building:is_null_interface() then
          script_error(
          "ERROR: scripted_bonus_values.check_bonus_values_from_building called, but the provided building is not valid! " ..
          building)
          return
     end

     local faction_key = building:faction():name()
     local vp_from_building = scripted_bonus_values.check_building_for_scripted_bonus_value(building,
          scripted_bonus_values.bonus_value_keys.victory_points_from_buildings)
     if vp_from_building ~= 0 then
          if should_add then
               scripted_bonus_values.add_victory_points_from_buildings(faction_key, vp_from_building)
          else
               scripted_bonus_values.add_victory_points_from_buildings(faction_key, -vp_from_building)
          end
     end

     local local_deities_favour_all_gods = scripted_bonus_values.check_building_for_scripted_bonus_value(building,
          scripted_bonus_values.bonus_value_keys.local_deities_favour_all_gods)
     if local_deities_favour_all_gods ~= 0 then
          if not should_add then
               local_deities_favour_all_gods = local_deities_favour_all_gods * -1
          end

          scripted_bonus_values.grant_favour_to_all_gods(faction_key, local_deities_favour_all_gods, "wonder")
     end
end

function scripted_bonus_values.check_bonuses_from_region_buildings(region, faction_key, should_add)
     if not region or region:is_null_interface() then
          script_error(
          "ERROR: scripted_bonus_values.check_bonuses_from_region_buildings called, but the provided region is not valid! " ..
          region)
          return
     end

     if not faction_key or not is_string(faction_key) then
          script_error(
          "ERROR scripted_bonus_values.check_bonuses_from_region_buildings called, but the provided faction_key is not valid: " ..
          faction_key)
          return
     end

     local vps_from_buildings = scripted_bonus_values.check_region_for_building_with_scripted_bonus_value(region,
          scripted_bonus_values.bonus_value_keys.victory_points_from_buildings)

     if vps_from_buildings ~= 0 then
          if should_add then
               scripted_bonus_values.add_victory_points_from_buildings(faction_key, vps_from_buildings)
          else
               scripted_bonus_values.add_victory_points_from_buildings(faction_key, -vps_from_buildings)
          end
     end

     local local_deities_favour_all_gods = scripted_bonus_values.check_region_for_building_with_scripted_bonus_value(
     region, scripted_bonus_values.bonus_value_keys.local_deities_favour_all_gods)
     if local_deities_favour_all_gods ~= 0 then
          if not should_add then
               local_deities_favour_all_gods = local_deities_favour_all_gods * -1
          end

          scripted_bonus_values.grant_favour_to_all_gods(faction_key, local_deities_favour_all_gods, "wonder")
     end
end

function scripted_bonus_values.check_force_for_stalking_stance_bonus_value(military_force)
     if not military_force or military_force:is_null_interface() then
          script_error(
          "ERROR: scripted_bonus_values.check_force_for_stalking_stance_bonus_value called, but the provided military_force is not valid! " ..
          military_force)
          return
     end

     local should_enable_stance = cm:get_forces_bonus_value(military_force,
          scripted_bonus_values.bonus_value_keys.enable_stalking)
     if should_enable_stance > 0 then
          return true
     end

     return false
end

function scripted_bonus_values.add_effect_to_custom_bundle_and_apply(character, custom_effect_bundle, effect,
                                                                     bonus_value_key, scope)
     local military_force = character:military_force()

     local character_bonus_value = cm:get_characters_bonus_value(character, bonus_value_key)
     local faction_bonus_value = cm:get_factions_bonus_value(character:faction():name(), bonus_value_key)
     local value = character_bonus_value + faction_bonus_value
     if value ~= 0 then
          --Duration set to 2, because FactionTurnStart immediately after this event shortens the duration by 1
          --Actual duration - 1
          custom_effect_bundle:set_duration(2)
          custom_effect_bundle:add_effect(effect, scope, value)
          cm:apply_custom_effect_bundle_to_force(custom_effect_bundle, military_force)
     end
end

function scripted_bonus_values.is_character_garrison(character)
     return character:has_garrison_residence() and not character:garrison_residence():garrison_army():is_null_interface()
         and
         character:command_queue_index() ==
         character:garrison_residence():garrison_army():general_character():command_queue_index()
end

function scripted_bonus_values.check_faction_for_gold_per_defensive_or_military_alliance_bonus_value(faction)
     local bonus_values = faction:bonus_values()
     local bonus = bonus_values:scripted_value(
     scripted_bonus_values.bonus_value_keys.gold_per_defensive_or_military_alliance, "value")
     if bonus > 0 then
          cm:faction_add_pooled_resource(faction:name(), "troy_gold", "troy_resource_factor_faction", bonus)
     end
end

function scripted_bonus_values.check_faction_for_legitimacy_per_defensive_or_military_alliance_bonus_value(faction, add,
                                                                                                           multiplier)
     local bonus_value_amount = cm:get_factions_bonus_value(faction,
          scripted_bonus_values.bonus_value_keys.legitimacy_from_allies)
     bonus_value_amount = bonus_value_amount * multiplier

     if not add then
          bonus_value_amount = -bonus_value_amount
     end
     scripted_bonus_values.add_legitimacy_for_defensive_or_military_alliance_bonus_value(faction, bonus_value_amount)
end

function scripted_bonus_values.add_legitimacy_from_effects_for_defensive_or_military_alliance_bonus_value(faction,
                                                                                                          effects_list,
                                                                                                          add)
     local bonus_value_amount = 0
     for i = 0, effects_list:num_items() - 1 do
          local curr_effect_bonus_values = effects_list:item_at(i):bonus_values()
          bonus_value_amount = bonus_value_amount +
          curr_effect_bonus_values:scripted_value(scripted_bonus_values.bonus_value_keys.legitimacy_from_allies, "value")
     end

     bonus_value_amount = bonus_value_amount * faction:num_allies()
     if bonus_value_amount ~= 0 then
          if not add then
               bonus_value_amount = -bonus_value_amount
          end

          scripted_bonus_values.add_legitimacy_for_defensive_or_military_alliance_bonus_value(faction, bonus_value_amount)
     end
end

function scripted_bonus_values.add_legitimacy_for_defensive_or_military_alliance_bonus_value(faction, amount)
     local faction_key = faction:name()
     local legitimacy_object = legitimacy_choice:get_unlocked_legitimacy(faction_key)
     if not (legitimacy_object and legitimacy_object:can_use(faction_key)) then
          return
     end

     local factor = legitimacy_object.config.allies_factor
     legitimacy_object:add_legitimacy(faction_key, factor, amount)
end

function scripted_bonus_values.give_random_ancillary_for_bonus_value(character, value)
     if scripted_bonus_values.variables.ancillary_upon_recruit_setup[value] then
          local weighted_list = weighted_list:new_from_pairs_list(scripted_bonus_values.variables
          .ancillary_upon_recruit_setup[value])
          local selected_item = weighted_list:weighted_select()
          cm:force_add_ancillary(cm:char_lookup_str(character), selected_item)
     else
          out(
          "scripted_bonus_values.give_random_ancillary_for_bonus_value no ancillary setup in ancillary_upon_recruit_setup for value: " ..
          value)
     end
end

function scripted_bonus_values.add_listeners()
     --Setup for effects that check if the army has 10 units or less; Triggers at the start of the turn and change persists for the entire turn
     core:add_listener(
          "scripted_check_for_10_units_or_less",
          "CharacterTurnStart",
          function(context)
               local character = context:character()
               --Just to be extra safe
               if not character or context:character():is_null_interface()
                   or not context:character():has_military_force()
                   or scripted_bonus_values.is_character_garrison(character) then
                    return false
               end
               local mf = character:military_force()
               if mf:unit_list():num_items() <= 10 then
                    return true
               end
          end,
          function(context)
               local character = context:character()
               local custom_effect_bundle = cm:create_new_custom_effect_bundle(
               "phar_map_effect_bundle_scripted_ten_or_less_units_generic_bundle")
               if not custom_effect_bundle:is_null_interface() then
                    for i, bonus_value in ipairs(scripted_bonus_values.bonus_value_keys.ten_or_less_units) do
                         scripted_bonus_values.add_effect_to_custom_bundle_and_apply(character, custom_effect_bundle,
                              bonus_value.effect_key, bonus_value.bonus_value_key, "character_to_force_own")
                    end
               end
          end,
          true
     )

     core:add_listener(
          "scripted_check_if_alliance_exists_influence_title",
          "CharacterTurnStart",
          function(context)
               local character = context:character()

               --Just to be extra safe
               if not character or context:character():is_null_interface()
                   or not context:character():has_military_force()
                   or scripted_bonus_values.is_character_garrison(character) then
                    return false
               end
               local value = cm:get_characters_bonus_value(character, "scripted_bonus_if_alliance_exists_influence")
               if value ~= 0 then
                    local faction = character:faction()
                    if faction:num_allies() > 0 then
                         return true
                    end
               end
          end,
          function(context)
               local character = context:character()
               local custom_effect_bundle = cm:create_new_custom_effect_bundle(
               "phar_map_effect_bundle_influence_if_in_an_alliance")
               if not custom_effect_bundle:is_null_interface() then
                    scripted_bonus_values.add_effect_to_custom_bundle_and_apply(character, custom_effect_bundle,
                         "phar_main_state_religion_conversion_bonus_character_basic",
                         "scripted_bonus_if_alliance_exists_influence", "character_to_province_any")
               end
          end,
          true
     )


     core:add_listener(
          "scripted_attrition_to_enemy_from_raiding_ForceAdoptsStance",
          "ForceAdoptsStance",
          true,
          function(context)
               local military_force = context:military_force()
               if context:stance_adopted() == scripted_bonus_values.variables.raiding_stance_enum_number then
                    local attrition_from_to_enemy = cm:get_forces_bonus_value(military_force,
                         "scripted_attrition_to_enemy_from_raiding")
                    local custom_effect_bundle = cm:create_new_custom_effect_bundle(scripted_bonus_values.variables
                    .scripted_attrition_from_raiding_bundle_key)
                    if not custom_effect_bundle:is_null_interface() then
                         custom_effect_bundle:add_effect(
                         scripted_bonus_values.variables.scripted_attrition_from_raiding_effect_key,
                              scripted_bonus_values.variables.scripted_attrition_from_raiding_effect_scope,
                              attrition_from_to_enemy)
                         cm:apply_custom_effect_bundle_to_force(custom_effect_bundle, military_force)
                    end
               else
                    cm:remove_effect_bundle_from_force(
                    scripted_bonus_values.variables.scripted_attrition_from_raiding_bundle_key,
                         military_force:command_queue_index())
               end
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_hp_mod_at_battle_start_when_marching_PendingBattle",
          "PendingBattle",
          true,
          function(context)
               local attacker_force = context:pending_battle():has_attacker() and
               context:pending_battle():attacker():has_military_force() and
               context:pending_battle():attacker():military_force()
               if attacker_force and scripted_bonus_values.should_apply_hp_mod_at_battle_start(attacker_force) then
                    scripted_bonus_values.apply_hp_mod_at_battle_start(attacker_force)
               end

               local defender_force = context:pending_battle():has_defender() and
               context:pending_battle():defender():has_military_force() and
               context:pending_battle():defender():military_force()
               if defender_force and scripted_bonus_values.should_apply_hp_mod_at_battle_start(defender_force) then
                    scripted_bonus_values.apply_hp_mod_at_battle_start(defender_force)
               end

               for i = 0, context:pending_battle():secondary_attackers():num_items() - 1 do
                    local character = context:pending_battle():secondary_attackers():item_at(i)
                    local force = character:has_military_force() and character:military_force()
                    if force and scripted_bonus_values.should_apply_hp_mod_at_battle_start(force) then
                         scripted_bonus_values.apply_hp_mod_at_battle_start(force)
                    end
               end

               for i = 0, context:pending_battle():secondary_defenders():num_items() - 1 do
                    local character = context:pending_battle():secondary_defenders():item_at(i)
                    local force = character:has_military_force() and character:military_force()
                    if force and scripted_bonus_values.should_apply_hp_mod_at_battle_start(force) then
                         scripted_bonus_values.apply_hp_mod_at_battle_start(force)
                    end
               end
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_hp_mod_at_battle_start_when_marching_CharacterWithdrewFromBattle",
          "CharacterWithdrewFromBattle",
          true,
          function(context)
               local pb = cm:model():pending_battle()

               local attacker_force = pb:has_attacker() and pb:attacker():has_military_force() and
               pb:attacker():military_force()
               if attacker_force and scripted_bonus_values.should_apply_hp_mod_at_battle_start(attacker_force) then
                    scripted_bonus_values.restore_hp_mod_at_battle_start(attacker_force)
               end

               local defender_force = pb:has_defender() and pb:defender():has_military_force() and
               pb:defender():military_force()
               if defender_force and scripted_bonus_values.should_apply_hp_mod_at_battle_start(defender_force) then
                    scripted_bonus_values.restore_hp_mod_at_battle_start(defender_force)
               end

               for i = 0, pb:secondary_attackers():num_items() - 1 do
                    local character = pb:secondary_attackers():item_at(i)
                    local force = character:has_military_force() and character:military_force()
                    if force and scripted_bonus_values.should_apply_hp_mod_at_battle_start(force) then
                         scripted_bonus_values.restore_hp_mod_at_battle_start(force)
                    end
               end

               for i = 0, pb:secondary_defenders():num_items() - 1 do
                    local character = pb:secondary_defenders():item_at(i)
                    local force = character:has_military_force() and character:military_force()
                    if force and scripted_bonus_values.should_apply_hp_mod_at_battle_start(force) then
                         scripted_bonus_values.restore_hp_mod_at_battle_start(force)
                    end
               end

               scripted_bonus_values.saved_data.unit_prev_hp = {} -- clear this table because it is no longer needed
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_hp_mod_at_battle_start_when_marching_BattleCompleted",
          "BattleCompleted",
          true,
          function(context)
               scripted_bonus_values.saved_data.unit_prev_hp = {} -- clear this table because it is no longer needed. This event is called after CharacterWithdrewFromBattle
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_restore_post_battle_action_points_BattleCompleted",
          "BattleCompleted",
          true,
          function(context)
               local pb = context:pending_battle()
               if pb:has_been_fought() then
                    local attacker = pb:attacker()
                    local defender = pb:defender()

                    if attacker and not attacker:is_null_interface() then
                         scripted_bonus_values.restore_action_points(attacker,
                              scripted_bonus_values.bonus_value_keys.restore_ap_post_battle)
                    end
                    if defender and not defender:is_null_interface() then
                         scripted_bonus_values.restore_action_points(defender,
                              scripted_bonus_values.bonus_value_keys.restore_ap_post_battle)
                    end
               end
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_restore_post_prayer_action_points_BattleCompleted",
          "CharacterPerformedSuccessfulAgentAction",
          function(context)
               return string.find(context:unique_id(), "pray")
          end,
          function(context)
               scripted_bonus_values.restore_action_points(context:character(),
                    scripted_bonus_values.bonus_value_keys.restore_ap_post_prayer)
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_restore_post_general_interaction_action_points",
          "CharacterPerformedSuccessfulAgentAction",
          function(context)
               return context:character():character_type("general")
          end,
          function(context)
               scripted_bonus_values.restore_action_points(context:character(),
                    scripted_bonus_values.bonus_value_keys.restore_ap_post_general_action)
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_start_hp_new_recruit",
          "UnitTrained",
          function(context)
               local bonus_value = cm:get_forces_bonus_value(context:unit():military_force(),
                    scripted_bonus_values.bonus_value_keys.start_hp_new_recruit)
               return bonus_value ~= 0
          end,
          function(context)
               local unit = context:unit()
               local force = unit:military_force()
               local base = cm:get_forces_bonus_value(force, scripted_bonus_values.bonus_value_keys.start_hp_new_recruit) /
               100
               cm:change_unit_health(unit:command_queue_index(), base)
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_character_xp_per_turn",
          "CharacterTurnStart",
          function(context)
               local character = context:character()
               return character:is_male() and
               (is_xp_gained_by_replaced_starting_generals or not character:is_replaced_starting_general())
          end,
          function(context)
               local character = context:character()
               local bonus_value = cm:get_characters_bonus_value(character,
                    scripted_bonus_values.bonus_value_keys.char_xp_per_turn)
               if bonus_value > 0 then
                    cm:add_agent_experience(cm:char_lookup_str(character:command_queue_index()), bonus_value)
               end
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_from_building_BuildingCompleted",
          "BuildingCompleted",
          function(context) return context:building():faction():is_human() end,
          function(context)
               scripted_bonus_values.check_bonus_values_from_building(context:building(), true)
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_from_building_BuildingDemolished",
          "BuildingDemolished",
          function(context) return context:building():faction():is_human() end,
          function(context)
               scripted_bonus_values.check_bonus_values_from_building(context:building(), false)
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_from_building_RegionFactionChangeEvent",
          "RegionFactionChangeEvent",
          true,
          function(context)
               local region = context:region()
               local current_owner = region:owning_faction()
               local previous_owner = context:previous_faction()
               if current_owner and not current_owner:is_null_interface() and not current_owner:is_rebel() and not current_owner:is_dead() and current_owner:is_human() then
                    scripted_bonus_values.check_bonuses_from_region_buildings(region, current_owner:name(), true)
               end
               if previous_owner and not previous_owner:is_null_interface() and not previous_owner:is_rebel() and not previous_owner:is_dead() and previous_owner:is_human() then
                    scripted_bonus_values.check_bonuses_from_region_buildings(region, previous_owner:name(), false)
               end
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_from_building_RegionAboutToBeAbandoned",
          "RegionAboutToBeAbandoned",
          function(context) return context:region():owning_faction():is_human() end,
          function(context)
               local region = context:region()
               scripted_bonus_values.check_bonuses_from_region_buildings(region, region:owning_faction():name(), false)
          end,
          true
     )


     core:add_listener(
          "scripted_bonus_values_from_building_MilitaryForceBuildingCompleteEvent",
          "CharacterMilitaryForceBuildingCompleted",
          function(context) return context:building():faction():is_human() end,
          function(context)
               scripted_bonus_values.check_bonus_values_from_building(context:building(), true)
          end,
          true
     )

     core:add_listener(
          "scripted_bonus_values_from_building_CharacterHordeBuildingDemolished",
          "CharacterMilitaryForceBuildingDemolished",
          function(context) return context:building():faction():is_human() end,
          function(context)
               scripted_bonus_values.check_bonus_values_from_building(context:building(), false)
          end,
          true
     )

     core:add_listener(
          "scripted_enable_stalking_stance_anc_equipped",
          "CharacterAncillaryEquipped",
          true,
          function(context)
               local character = context:character()
               if not character:has_military_force() then
                    return
               end

               local military_force = character:military_force()
               local mf_cqi = military_force:command_queue_index()

               cm:callback(
                    function()
                         -- character might get deleted so avoid using it and instead use military force cqi
                         military_force = cm:model():military_force_for_command_queue_index(mf_cqi)
                         if military_force:is_null_interface() then
                              return
                         end

                         local can_enable = scripted_bonus_values.check_force_for_stalking_stance_bonus_value(
                         military_force)
                         if can_enable and not table_find(scripted_bonus_values.saved_data.mf_with_stalking_stance, function(
                                 e) return e == mf_cqi end) then
                              cm:activate_stance_to_force(true, scripted_bonus_values.variables.stalking_stance_db_key,
                                   mf_cqi)
                              table.insert(scripted_bonus_values.saved_data.mf_with_stalking_stance, mf_cqi)
                         end
                    end,
                    0.1
               )
          end,
          true
     )

     core:add_listener(
          "scripted_enable_stalking_stance_anc_lost",
          "CharacterAncillaryLost",
          true,
          function(context)
               if context:character():has_military_force() then
                    local military_force = context:character():military_force()
                    local mf_cqi = military_force:command_queue_index()
                    local can_enable = scripted_bonus_values.check_force_for_stalking_stance_bonus_value(military_force)
                    local should_disable = not can_enable and
                    table_find(scripted_bonus_values.saved_data.mf_with_stalking_stance,
                         function(e) return e == mf_cqi end)
                    if should_disable then
                         cm:activate_stance_to_force(false, scripted_bonus_values.variables.stalking_stance_db_key,
                              mf_cqi)
                         table.remove(scripted_bonus_values.saved_data.mf_with_stalking_stance, mf_cqi)
                    end
               end
          end,
          true
     )

     core:add_listener(
          "scripted_enable_stalking_stance_enters_mf",
          "CharacterEntersMilitaryForce",
          true,
          function(context)
               local military_force = context:military_force()
               local mf_cqi = military_force:command_queue_index()
               local can_enable = scripted_bonus_values.check_force_for_stalking_stance_bonus_value(military_force)
               local should_enable = can_enable and
               not table_find(scripted_bonus_values.saved_data.mf_with_stalking_stance,
                    function(e) return e == mf_cqi end)
               if should_enable then
                    cm:activate_stance_to_force(true, scripted_bonus_values.variables.stalking_stance_db_key, mf_cqi)
                    table.insert(scripted_bonus_values.saved_data.mf_with_stalking_stance, mf_cqi)
               end
          end,
          true
     )

     core:add_listener(
          "scripted_enable_stalking_stance_leaves_mf",
          "CharacterLeavesMilitaryForce",
          true,
          function(context)
               local military_force = context:military_force()
               local mf_cqi = military_force:command_queue_index()
               local can_enable = scripted_bonus_values.check_force_for_stalking_stance_bonus_value(military_force)
               local should_disable = can_enable and
               table_find(scripted_bonus_values.saved_data.mf_with_stalking_stance, function(e) return e == mf_cqi end)
               if should_disable then
                    cm:activate_stance_to_force(false, scripted_bonus_values.variables.stalking_stance_db_key, mf_cqi)
                    table.remove(scripted_bonus_values.saved_data.mf_with_stalking_stance, mf_cqi)
               end
          end,
          true
     )

     -- fixing a save/loading issue as the callback prevents the data being saved in time for the start of turn save.
     core:add_listener(
          "scripted_enable_stalking_stance_char_selected",
          "CharacterTurnStart",
          true,
          function(context)
               local character = context:character()
               if character:has_military_force() then
                    local military_force = character:military_force()
                    local mf_cqi = military_force:command_queue_index()
                    if scripted_bonus_values.check_force_for_stalking_stance_bonus_value(military_force) and
                        not table_find(scripted_bonus_values.saved_data.mf_with_stalking_stance, function(e) return e ==
                             mf_cqi end) then
                         cm:activate_stance_to_force(true, scripted_bonus_values.variables.stalking_stance_db_key, mf_cqi)
                         table.insert(scripted_bonus_values.saved_data.mf_with_stalking_stance, mf_cqi)
                    end
               end
          end,
          true
     )

     core:add_listener(
          "LegitimacyPathUnlocked_scripted_bonus_values",
          "LegitimacyPathUnlocked",
          true,
          function(context)
               local faction = cm:get_faction(context.stored_table.faction_key)
               scripted_bonus_values.check_faction_for_legitimacy_per_defensive_or_military_alliance_bonus_value(faction,
                    true, faction:num_allies())
          end,
          true
     )

     core:add_listener(
          "PositiveDiplomaticEvent_scripted_bonus_values",
          "PositiveDiplomaticEvent",
          function(context)
               return context:is_alliance()
          end,
          function(context)
               -- using the character for the faction as this event is called twice for both parties.
               -- the character is the Faction leader of each faction respectively
               local faction = context:character():faction()
               scripted_bonus_values.check_faction_for_gold_per_defensive_or_military_alliance_bonus_value(faction)
               scripted_bonus_values.check_faction_for_legitimacy_per_defensive_or_military_alliance_bonus_value(faction,
                    true, 1)
          end,
          true
     )

     core:add_listener(
          "NegativeDiplomaticEvent_scripted_bonus_values",
          "NegativeDiplomaticEvent",
          function(context)
               return context:was_alliance()
          end,
          function(context)
               local faction = context:character():faction()
               scripted_bonus_values.check_faction_for_legitimacy_per_defensive_or_military_alliance_bonus_value(faction,
                    false, 1)
          end,
          true
     )

     core:add_listener(
          "ResearchCompleted_scripted_bonus_values",
          "ResearchCompleted",
          true,
          function(context)
               local technology_key = context:technology()
               local effects_list = cm:get_technology_record_effects_list(technology_key)
               scripted_bonus_values.add_legitimacy_from_effects_for_defensive_or_military_alliance_bonus_value(
               context:faction(), effects_list, true)
          end,
          true
     )

     core:add_listener(
          "CampaignEffectsBundleAwarded_scripted_bonus_values",
          "CampaignEffectsBundleAwarded",
          true,
          function(context)
               local previous_effect_bundle_instance = context:previous_effect_bundle_instance()
               if not previous_effect_bundle_instance:is_null_interface() then
                    local effects_list = previous_effect_bundle_instance:effects()
                    scripted_bonus_values.add_legitimacy_from_effects_for_defensive_or_military_alliance_bonus_value(
                    context:faction(), effects_list, false)
               end

               local effects_list = context:effect_bundle():effects()
               scripted_bonus_values.add_legitimacy_from_effects_for_defensive_or_military_alliance_bonus_value(
               context:faction(), effects_list, true)
          end,
          true
     )

     core:add_listener(
          "CampaignEffectsBundleRemoved_scripted_bonus_values",
          "CampaignEffectsBundleRemoved",
          true,
          function(context)
               local effects_list = context:effect_bundle():effects()
               scripted_bonus_values.add_legitimacy_from_effects_for_defensive_or_military_alliance_bonus_value(
               context:faction(), effects_list, false)
          end,
          true
     )

     core:add_listener(
          "NewCharacterRecruited_scripted_bonus_values",
          "NewCharacterRecruited",
          true,
          function(context)
               local character = context:character()
               local value = cm:get_characters_bonus_value(character,
                    scripted_bonus_values.bonus_value_keys.equipment_upon_recruitment)
               if value > 0 then
                    scripted_bonus_values.give_random_ancillary_for_bonus_value(character, value)
               end
          end,
          true
     )
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------

cm:add_saving_game_callback(
     function(context)
          cm:save_named_value("SCRIPTED_BONUS_VALUES_SAVED_DATA", scripted_bonus_values.saved_data, context)
     end
)

cm:add_loading_game_callback(
     function(context)
          scripted_bonus_values.saved_data = cm:load_named_value("SCRIPTED_BONUS_VALUES_SAVED_DATA",
               scripted_bonus_values.saved_data, context)
     end
)
