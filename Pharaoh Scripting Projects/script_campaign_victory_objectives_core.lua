out("Loading victory_objectives_core.lua")

local config =
{
     award_victory_points_factor_key = "troy_resource_factor_faction"
}

victory_conditions_core =
{
     add_listeners = function()
     end,

     is_campaign_type_valid = function(campaign_type)
          return campaign_type ~= "mp_vs_normal"
     end,

     has_active_objective_with_id = function(faction_key, objective_uid)
          local faction_condition = victory_conditions_core.get_faction_condition_by_script_key(faction_key,
               "point_victory")
          if not faction_condition then
               return false
          end

          return table_contains(faction_condition.activated_objectives, objective_uid)
     end,

     get_objective_activation_condition_progress = function(faction_key, objective_uid, condition_id)
          local faction_condition = victory_conditions_core.get_faction_condition_by_script_key(faction_key,
               "point_victory")
          if not faction_condition then
               return nil
          end

          local objective_activations_progress = faction_condition.objectives_activations_progress[objective_uid]
          if not objective_activations_progress then
               return nil
          end

          return objective_activations_progress[condition_id]
     end,

     create_objective_activation_condition_progress = function(faction_key, objective_uid, condition_id)
          local faction_condition = victory_conditions_core.get_faction_condition_by_script_key(faction_key,
               "point_victory")
          if not faction_condition then
               return nil
          end

          local objective_activations_progress = faction_condition.objectives_activations_progress[objective_uid]
          if not objective_activations_progress then
               faction_condition.objectives_activations_progress[objective_uid] = {}
               objective_activations_progress = faction_condition.objectives_activations_progress[objective_uid]
          end

          objective_activations_progress[condition_id] = { is_completed = false }
          return objective_activations_progress[condition_id]
     end,

     is_objective_ready_to_be_activated = function(faction_key, objective_uid)
          local faction_condition = victory_conditions_core.get_faction_condition_by_script_key(faction_key,
               "point_victory")
          if not faction_condition then
               return false
          end

          local objective_activations_progress = faction_condition.objectives_activations_progress[objective_uid]
          if not objective_activations_progress then
               return false
          end

          local objective = table_find(victory_objectives_data, function(e) return e.uid == objective_uid end)
          if not objective then
               out("ERROR: objective with doesn't exist: " .. objective_uid)
               return false
          end

          local completed_count = 0
          for _, condition in pairs(objective_activations_progress) do
               if condition.is_completed then
                    completed_count = completed_count + 1
               end
          end

          return completed_count >= #objective.activation_conditions
     end,

     activate_objective_with_id = function(faction_key, objective_uid, add_event_feed_message)
          local faction_condition = victory_conditions_core.get_faction_condition_by_script_key(faction_key,
               "point_victory")
          if not faction_condition then
               return
          end

          if table_contains(faction_condition.activated_objectives, objective_uid) then
               out("ERROR: objective already activated: " .. objective_uid)
               return
          end

          table.insert(faction_condition.activated_objectives, objective_uid)

          if add_event_feed_message then
               victory_conditions_core.add_event_feed_message(faction_key, objective_uid)
          end

          -- it is possible that an object has already met all completion conditions before we even activate it
          if victory_conditions_core.is_objective_completed(faction_key, objective_uid) then
               local campaign_type = cm:model():campaign_type_string()
               if campaign_type == "sp_normal" then
                    victory_conditions_core.award_or_take_points_for_objective(cm:get_faction(faction_key), objective_uid,
                         true)
               elseif campaign_type == "mp_co_op_normal" then
                    local human_factions = cm:get_human_factions()
                    for _, human_faction_key in ipairs(human_factions) do
                         victory_conditions_core.award_or_take_points_for_objective(cm:get_faction(human_faction_key),
                              objective_uid, true)
                    end
               end
          end
     end,

     get_objective_completion_condition_progress = function(faction_key, objective_uid, condition_id)
          local faction_condition = victory_conditions_core.get_faction_condition_by_script_key(faction_key,
               "point_victory")
          if not faction_condition then
               return nil
          end

          local objective_completions_progress = faction_condition.objectives_completions_progress[objective_uid]
          if not objective_completions_progress then
               return nil
          end

          return objective_completions_progress[condition_id]
     end,

     create_objective_completion_condition_progress = function(faction_key, objective_uid, condition_id)
          local faction_condition = victory_conditions_core.get_faction_condition_by_script_key(faction_key,
               "point_victory")
          if not faction_condition then
               return nil
          end

          local objective_completions_progress = faction_condition.objectives_completions_progress[objective_uid]
          if not objective_completions_progress then
               faction_condition.objectives_completions_progress[objective_uid] = {}
               objective_completions_progress = faction_condition.objectives_completions_progress[objective_uid]
          end

          objective_completions_progress[condition_id] = { is_completed = false }
          return objective_completions_progress[condition_id]
     end,

     is_objective_completed = function(faction_key, objective_uid)
          local faction_condition = victory_conditions_core.get_faction_condition_by_script_key(faction_key,
               "point_victory")
          if not faction_condition then
               return false
          end

          local objective = table_find(victory_objectives_data, function(e) return e.uid == objective_uid end)
          if not objective then
               out("ERROR: objective with doesn't exist: " .. objective_uid)
               return false
          end

          local completed_count = 0
          local objective_completions_progress = faction_condition.objectives_completions_progress[objective_uid]
          if objective_completions_progress then
               for _, condition in pairs(objective_completions_progress) do
                    if condition.is_completed then
                         completed_count = completed_count + 1
                    end
               end
          end

          return completed_count >= #objective.completion_conditions
     end,

     award_or_take_points_for_objective = function(faction, objective_uid, award)
          local objective = table_find(victory_objectives_data, function(e) return e.uid == objective_uid end)
          if not objective then
               out("ERROR: objective with doesn't exist: " .. objective_uid)
          end

          local vp_reward = award and objective.vp_reward or -objective.vp_reward
          cm:faction_add_pooled_resource(faction:name(), victory_points_mechanic.config.victory_points_key,
               config.award_victory_points_factor_key, vp_reward)
     end,

     calculate_victory_points = function(faction)
          if not faction or faction:is_null_interface() then
               return 0
          end

          local victory_points_resource = faction:pooled_resource(victory_points_mechanic.config.victory_points_key)
          if victory_points_resource:is_null_interface() then
               return 0
          end
          return victory_points_resource:value()
     end,

     get_faction_condition_by_script_key = function(faction_name, script_key)
          local faction_conditions_data = victory_conditions_data[faction_name]
          if not faction_conditions_data then
               out("ERROR: unable to find victory conditions for: " .. faction_name)
               return nil
          end

          for i = 1, #faction_conditions_data do
               local faction_condition = faction_conditions_data[i]

               if faction_condition and faction_condition.script_key and string.find(faction_condition.script_key, script_key) then
                    return faction_condition
               end
          end

          return nil
     end,

     add_event_feed_message = function(faction_key, objective_uid)
          local objective = table_find(victory_objectives_data, function(e) return e.uid == objective_uid end)
          if not objective then
               out("ERROR: objective with id doesn't exist: " .. objective_uid)
          end

          local category_title_key = objective.category and objective.category.title_key or ""
          local sub_category_title_key = objective.sub_category and objective.sub_category.title_key or ""

          cm:add_event_feed_message_new_victory_objective(
               faction_key,
               category_title_key,
               sub_category_title_key,
               objective.title_key,
               objective.description_key,
               objective.vp_reward
          )
     end,

     is_objective_available_to_faction = function(faction, objective_uid)
          local objective = table_find(victory_objectives_data, function(e) return e.uid == objective_uid end)
          if not objective then
               out("ERROR: objective with id doesn't exist: " .. objective_uid)
               return false
          end

          if is_table(objective.restricted_to_factions) and not table_contains(objective.restricted_to_factions, faction:name()) then
               return false
          end

          if is_table(objective.restricted_to_subcultures) and not table_contains(objective.restricted_to_subcultures, faction:subculture()) then
               return false
          end

          if is_table(objective.restricted_to_cultures) and not table_contains(objective.restricted_to_cultures, faction:culture()) then
               return false
          end

          return true
     end,

     unlock_all_objectives_for_local_faction = function()
          local faction = cm:get_local_faction(true)
          for _, objective in ipairs(victory_objectives_data) do
               if victory_conditions_core.is_objective_available_to_faction(faction, objective.uid) then
                    victory_conditions_core.activate_objective_with_id(faction:name(), objective.uid, false)
               end
          end
     end
}

if __game_mode == __lib_type_campaign then
     cm:add_first_tick_callback(
          function()
               local campaign_type = cm:model():campaign_type_string()
               if campaign_type ~= "mp_vs_normal" then
                    victory_conditions_core.add_listeners()
               end
          end
     )
end
