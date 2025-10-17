out("Loading phar_ancient_legacy_hammurabi.lua")

require("phar_ancient_legacy_hammurabi_config")
require("phar_ancient_legacy_hammurabi_ui")

-- make config be iterable with ipairs and add id property to each config
for effect_type_key, effect_type in dpairs(ancient_legacy_hammurabi_config.effect_types) do
     if is_string(effect_type_key) then
          effect_type.id = effect_type_key
          table.insert(ancient_legacy_hammurabi_config.effect_types, effect_type)

          for parameter_key, parameter in dpairs(effect_type.parameters) do
               if is_string(effect_type_key) then
                    parameter.id = parameter_key
                    parameter.effect_type = effect_type
                    table.insert(effect_type.parameters, parameter)

                    if is_table(parameter.values) then
                         for index, value in ipairs(parameter.values) do
                              value.parameter = parameter
                              parameter.values[value.id] = value
                         end
                    end
               end
          end
     end
end

for category_key, category in dpairs(ancient_legacy_hammurabi_config.categories) do
     if is_string(category_key) then
          category.id = category_key
          table.insert(ancient_legacy_hammurabi_config.categories, category)

          for sub_category_key, sub_category in dpairs(category.sub_categories) do
               if is_string(sub_category_key) then
                    sub_category.id = sub_category_key
                    sub_category.category = category
                    table.insert(category.sub_categories, sub_category)

                    for effect_type_key, effect_type in dpairs(sub_category.effect_types) do
                         effect_type.sub_category = sub_category
                    end
               end
          end

          if is_table(category.levels) then
               category.levels = table_stable_sort(category.levels, function(lhs, rhs) return lhs.level < rhs.level end)
          end
     end
end

------------------------------------------------------------------------------------------------------------

ancient_legacy_hammurabi = {
     config = ancient_legacy_hammurabi_config,
     ui = ancient_legacy_hammurabi_ui,
     persistent = {
          faction_key = "",
          categories = {
               --[[
				{ id = "category id", level = 1 }
			]] --
          },
          active_laws = {},
          law_being_researched = nil,
          law_removals_count = 0,
          ai = {},
          ui = {}
     },

     utility = {
          get_effect_bundle_key_for_law = function(law_id)
               return ancient_legacy_hammurabi_config.law_effect_bundle_prefix .. law_id
          end,

          is_law_id_valid = function(law_id)
               return 1 <= law_id and law_id <= ancient_legacy_hammurabi_config.max_laws_count
          end,

          create_cost_object = function(resource_cost_plain_data, invert)
               local resource_cost_object = cm:create_new_custom_resource_cost()
               for _, resource in ipairs(resource_cost_plain_data) do
                    local amount = invert and (resource.amount * -1) or resource.amount
                    resource_cost_object:add_resource_cost(resource.key,
                         ancient_legacy_hammurabi_config.resource_factor_consumed_by_law_creation, amount)
               end

               return resource_cost_object
          end,

          create_cost_plain_data = function(category_config, law_turns)
               local resource_cost_plain_data = table_deep_copy(category_config.base_resource_cost)
               for _, resource in ipairs(resource_cost_plain_data) do
                    resource.amount = resource.amount * law_turns
               end

               return resource_cost_plain_data
          end,

          get_effect_full_config = function(effect_type_id, parameter_id, value_id)
               local effect_type_config = ancient_legacy_hammurabi.utility.get_effect_type_config(effect_type_id)
               if not effect_type_config then
                    return nil
               end

               local parameter_config = ancient_legacy_hammurabi.utility.get_parameter_config(effect_type_config,
                    parameter_id)
               if not parameter_config then
                    return nil
               end

               local value_config = ancient_legacy_hammurabi.utility.get_value_config(parameter_config, value_id)
               if not value_config then
                    return nil
               end

               return {
                    effect_type_config = effect_type_config,
                    parameter_config = parameter_config,
                    value_config =
                        value_config
               }
          end,

          get_effect_type_config = function(id)
               return ancient_legacy_hammurabi_config.effect_types[id]
          end,

          get_parameter_config = function(effect_type_config, parameter_id)
               return effect_type_config.parameters[parameter_id]
          end,

          get_value_config = function(parameter_config, value_id)
               return parameter_config.values[value_id]
          end,

          get_category_config = function(category_id)
               return ancient_legacy_hammurabi_config.categories[category_id]
          end,

          get_sub_category_config = function(category_id, sub_category_id)
               local category_config = ancient_legacy_hammurabi.utility.get_category_config(category_id)
               if not category_config then
                    return nil
               end

               return category_config.sub_categories[sub_category_id]
          end,

          get_category_config_index = function(category_id)
               for index, category_config in ipairs(ancient_legacy_hammurabi_config.categories) do
                    if category_config.id == category_id then
                         return index
                    end
               end
               return -1
          end,

          calculate_justice_cost_research_any_technology_action = function(faction, technology_key)
               local action_config = ancient_legacy_hammurabi.config.actions.instant_research_any_technology
               local turns_to_research = faction:turns_to_research_technology(technology_key)
               local required_resource_amount = (turns_to_research * action_config.cost_per_turn)
               if not (faction:is_technology_available(technology_key) or faction:active_research_technology() == technology_key) then
                    required_resource_amount = required_resource_amount +
                        action_config.unfulfilled_prerequisites_additional_cost
               end

               return required_resource_amount
          end,

          is_beneficial_parameter_value = function(parameter_config, value_config)
               return parameter_config.is_positive_good == (value_config.amount > 0)
          end,

          get_category_level_config = function(category_config, level)
               local level_config = nil
               for _, level_config in ipairs(category_config.levels) do
                    if level == level_config.level then
                         return level_config
                    end
               end
               return nil
          end,

          iterate_effects_plain_data = function(effects_plain_data, callback)
               for _, effect_plain_data in ipairs(effects_plain_data) do
                    local effect_full_config = ancient_legacy_hammurabi.utility.get_effect_full_config(
                         effect_plain_data.effect_type, effect_plain_data.parameter, effect_plain_data.value)
                    if effect_full_config then
                         callback(effect_full_config, effect_plain_data)
                    end
               end
          end,

          create_custom_effect_bundle = function(effect_bundle_key, effects_plain_data)
               local custom_effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)
               if custom_effect_bundle:is_null_interface() then
                    script_error("Hammurabi: (create_custom_effect_bundle) couldn't create effect bundle with key: " ..
                         effect_bundle_key)
                    return nil
               end

               local add_effect_to_bundle = function(effect_full_config)
                    custom_effect_bundle:add_effect(effect_full_config.parameter_config.effect_key,
                         effect_full_config.parameter_config.scope_key, effect_full_config.value_config.amount)
               end
               ancient_legacy_hammurabi.utility.iterate_effects_plain_data(effects_plain_data, add_effect_to_bundle)

               return custom_effect_bundle
          end,

          create_predefined_law_name = function(law_id, category_id, use_model_random)
               local category_config = ancient_legacy_hammurabi.utility.get_category_config(category_id)
               if not category_config then
                    return ""
               end

               local titles = category_config.titles or {}
               local title_index = use_model_random and cm:model():random_int(1, #titles) or math.random(1, #titles)
               local title = #titles > 0 and titles[title_index] or ""

               local current_historical_year = cm:model():current_historical_year()
               local date_string_key = current_historical_year >= 0 and ancient_legacy_hammurabi_config.ad_text or
                   ancient_legacy_hammurabi_config.bc_text
               local date_string = common.get_localised_string(date_string_key)
               local title_localised = common.get_localised_string(title)
               return common.string_safe_format(title_localised, math.abs(current_historical_year), date_string), title
          end,

          create_predefined_law_description = function(faction_key)
               local faction = cm:get_faction(faction_key)
               local leader_name = ""
               if not faction:is_null_interface() then
                    local faction_leader = faction:faction_leader()
                    if not faction_leader:is_null_interface() then
                         leader_name = faction_leader:onscreen_name()
                    end
               end

               local current_historical_year = cm:model():current_historical_year()
               local date_string_key = current_historical_year >= 0 and ancient_legacy_hammurabi_config.ad_text or
                   ancient_legacy_hammurabi_config.bc_text
               local date_string = common.get_localised_string(date_string_key)
               local law_default_description = common.get_localised_string(ancient_legacy_hammurabi_config
                    .law_default_description)
               return common.string_safe_format(law_default_description, math.abs(current_historical_year), date_string,
                    leader_name)
          end,

          find_next_best_value = function(value_id, parameter)
               -- by design values are sorted most positive to most negative
               local next_best_value_index = -1
               for index, value_config in ipairs(parameter.values) do
                    if value_config.id == value_id then
                         next_best_value_index = index - 1
                         break
                    end
               end

               return next_best_value_index >= 1 and parameter.values[next_best_value_index] or nil
          end,
     },

     --------------------------------------------------------------------
     -------------------------- Public Methods --------------------------
     ------------ These methods have parameter error checking -----------
     --------- Or are meant to be called from outside the script --------
     --------------------------------------------------------------------

     is_level_requirement_met = function(self, category_id, level_requirement)
          local category_level = self:get_level_for_category(category_id)
          return category_level >= level_requirement
     end,

     get_level_for_category = function(self, category_id)
          local category = self:get_category_data(category_id)
          return category and category.level or 0
     end,

     get_active_law = function(self, id)
          for _, law in ipairs(self.persistent.active_laws) do
               if law.id == id then
                    return law
               end
          end

          return nil
     end,

     get_active_laws_count = function(self)
          return #self.persistent.active_laws
     end,

     get_justice_points = function(self)
          local active_faction = cm:get_faction(self.persistent.faction_key)
          if active_faction:is_null_interface() then
               script_error("Hammurabi: (get_justice_points) can't find owner faction.")
               return 0
          end

          return active_faction:pooled_resource(self.config.resource_key):value()
     end,

     get_law_removals_count = function(self)
          return self.persistent.law_removals_count
     end,

     is_researching_law = function(self)
          return to_bool(self.persistent.law_being_researched)
     end,

     get_id_of_law_being_researched = function(self)
          return self.persistent.law_being_researched and self.persistent.law_being_researched.id or -1
     end,

     calculate_turns_cost_for_effects = function(self, effects)
          local turns = 0
          local turns_abs_value = 0
          for _, effect in ipairs(effects) do
               local effect_time_cost = self:calculate_effect_time_cost(effect.effect_type_config,
                    effect.parameter_config, effect.value_config)
               turns = turns + effect_time_cost
               turns_abs_value = turns_abs_value + math.abs(effect_time_cost)
          end

          -- by design the turns cost shouldn't fall under 1
          return math.max(1, turns), turns_abs_value
     end,

     calculate_justice_cost_for_divine_law_making = function(self, law_id)
          local active_law = self:get_active_law(law_id)
          if not active_law then
               script_error("Hammurabi: (calculate_justice_cost_for_divine_law_making) invalid law.")
               return 0
          end

          local justice_cost = 0
          local effects_plain_data = active_law.effects_plain_data
          self.utility.iterate_effects_plain_data(effects_plain_data, function(effect_full_config)
               justice_cost = justice_cost + effect_full_config.value_config.divine_law_justice_cost
          end)

          return justice_cost
     end,

     generate_next_law_id = function(self)
          for id = 1, self.config.max_laws_count do
               if not self:get_active_law(id) then
                    return id
               end
          end

          return -1
     end,

     create_effects_plain_data_for_divine_version_of_law = function(self, law_id)
          local active_law = self:get_active_law(law_id)
          if not active_law then
               script_error("Hammurabi: (create_effects_plain_data_for_divine_version_of_law) invalid law.")
               return {}
          end

          if active_law.is_divine then
               return table_deep_copy(active_law.effects_plain_data)
          end

          local effects_plain_data = table_deep_copy(active_law.effects_plain_data)
          self.utility.iterate_effects_plain_data(effects_plain_data, function(effect_full_config, effect_plain_data)
               local next_best_value = self.utility.find_next_best_value(effect_plain_data.value,
                    effect_full_config.parameter_config)

               if next_best_value then
                    effect_plain_data.value = next_best_value.id
               end
          end)

          return effects_plain_data
     end,

     --------------------------------------------------------------------
     ---------------------- UI related functiions -----------------------
     --------------------------------------------------------------------

     has_sub_category_level_up_notification = function(self, sub_category_config)
          local categories_level_up_notification = self.persistent.ui.categories_level_up_notification
          if not is_table(categories_level_up_notification) then
               return false
          end

          local category_id = sub_category_config.category.id
          local sub_categories_level_up_notification = categories_level_up_notification[category_id]
          if not is_table(sub_categories_level_up_notification) then
               return false
          end

          return table_contains(sub_categories_level_up_notification, sub_category_config.id)
     end,

     remove_sub_category_level_up_notification = function(self, sub_category_config)
          local categories_level_up_notification = self.persistent.ui.categories_level_up_notification
          if not is_table(categories_level_up_notification) then
               return
          end

          local category_id = sub_category_config.category.id
          local sub_categories_level_up_notification = categories_level_up_notification[category_id]
          if not is_table(sub_categories_level_up_notification) then
               return
          end

          table_erase(sub_categories_level_up_notification, sub_category_config.id)
     end,

     add_sub_categories_level_up_notification = function(self, category_id)
          local category_config = self.utility.get_category_config(category_id)
          local current_level = self:get_level_for_category(category_id)

          local categories_level_up_notification = self.persistent.ui.categories_level_up_notification
          if not is_table(categories_level_up_notification) then
               self.persistent.ui.categories_level_up_notification = {}
               categories_level_up_notification = self.persistent.ui.categories_level_up_notification
          end

          local sub_categories_level_up_notification = categories_level_up_notification[category_id]
          if not is_table(sub_categories_level_up_notification) then
               categories_level_up_notification[category_id] = {}
               sub_categories_level_up_notification = categories_level_up_notification[category_id]
          end

          for _, sub_category_config in ipairs(category_config.sub_categories) do
               local found_effect_type_for_current_level = to_bool(table_find(sub_category_config.effect_types,
                    function(effect_type_config)
                         return effect_type_config.level_requirement == current_level
                    end))

               -- it's possible that we have a notification from a previous level, so we have to check
               if found_effect_type_for_current_level and not table_contains(sub_categories_level_up_notification, sub_category_config.id) then
                    table.insert(sub_categories_level_up_notification, sub_category_config.id)
               end
          end
     end,

     --------------------------------------------------------------------
     ------------------------- Private Methods --------------------------
     -------- These methods do NOT have parameter error checking --------
     ------ Or aren't meant to be called from outside this script -------
     --------------------------------------------------------------------

     -- private function
     on_legacy_claimed = function(self, faction_key)
          local local_faction_name = cm:get_local_faction_name(true)

          local faction = cm:get_faction(faction_key)
          if (not faction) or faction:is_null_interface() then
               script_error("Hammurabi: Trying to claim legacy on a non existing faction: " .. tostring(faction_key))
               return
          end

          self.persistent = {
               faction_key = faction_key,
               categories = {},
               active_laws = {},
               law_being_researched = nil,
               law_removals_count = 0,
               ai = {},
               ui = {
                    show_newly_activated_law_notification = false,
               }
          }

          self:initialize_missing_categories()

          if local_faction_name == faction_key then
               egypt_political_states:activate_button(self.ui.config.component_ids.legacy_panel_button, true)
               self.ui:add_listeners(self)
          end

          cm:set_script_state(faction,
               "hammurabi_instant_research_any_technology_unfulfilled_prerequisites_additional_cost",
               self.config.actions.instant_research_any_technology.unfulfilled_prerequisites_additional_cost)
          cm:set_script_state(faction, "hammurabi_instant_research_any_technology_cost_per_turn",
               self.config.actions.instant_research_any_technology.cost_per_turn)
     end,

     -- private function
     on_turn_start = function(self)
        if self.persistent.law_being_researched then
            self:advance_law_being_researched()
        end

          --Lycia Bookmark - made the removal of laws option reset each turn.
          self.persistent.law_removals_count = self.persistent.law_removals_count + self.config.law_removals_gained_for_leader_change
          core:trigger_event("ScriptEventHammurabiLawRemovalsIncreased", { faction_name = self.persistent.faction_key })

          local active_faction = cm:get_faction(self.persistent.faction_key)
          if not active_faction:is_null_interface() and not active_faction:is_human() then
               self:perform_ai_turn(active_faction)
          end
     end,

     on_new_faction_leader = function(self)
          self.persistent.law_removals_count = self.persistent.law_removals_count + self.config.law_removals_gained_for_leader_change
          core:trigger_event("ScriptEventHammurabiLawRemovalsIncreased", { faction_name = self.persistent.faction_key })
     end,

     perform_ai_turn = function(self, active_faction)
          self:ai_attempt_law_research()
          self:ai_attempt_instant_finish_currently_researched_technology(active_faction)
          self:ai_attempt_level_up_category(active_faction)
     end,

     -- private function
     level_up_category = function(self, category_config)
          local category_data = self:get_category_data(category_config.id)
          local next_level_config = self.utility.get_category_level_config(category_config, category_data.level + 1)

          if not next_level_config then
               script_error("Hammurabi: (level_up_category) category is already max level.")
               return
          end

          local active_faction = cm:get_faction(self.persistent.faction_key)
          if active_faction:is_null_interface() then
               script_error("Hammurabi: (level_up_category) can't find owner faction.")
               return
          end

          local paid_successfully = self:pay_justice_cost(next_level_config.justice_cost,
               self.config.resource_factor_consumed_by_category_leveling)
          if not paid_successfully then
               script_error("Hammurabi: (level_up_category) faction doesn't have enough resources.")
               return
          end

          category_data.level = next_level_config.level

          core:trigger_event("ScriptEventHammurabiCategoryLevelUp",
               { faction_name = self.persistent.faction_key, category_id = category_config.id })
     end,

     -- private function
     advance_law_being_researched = function(self)
          local law_being_researched = self.persistent.law_being_researched
          law_being_researched.remaining_turns = law_being_researched.remaining_turns - 1
          core:trigger_event("ScriptEventHammurabiAdvancedLawBeingResearched",
               { faction_name = self.persistent.faction_key })

          if law_being_researched.remaining_turns > 0 then
               return
          end

          local law_to_activate = table_deep_copy(law_being_researched)
          -- clear because activate_researched_law sends an event and if event handler checks whether we are still researching it will return true ...
          self.persistent.law_being_researched = nil
          self:activate_researched_law(law_to_activate)
     end,

     -- private function
     research_law = function(self, category, name, description, effects, ignore_cost)
          if self.persistent.law_being_researched then
               script_error("Hammurabi: (research_law) a law is already being researched.")
               return
          end

          if not name or #name <= 0 then
               script_error("Hammurabi: (research_law) can't research a law with no name.")
               return
          end

          local active_faction = cm:get_faction(self.persistent.faction_key)
          if active_faction:is_null_interface() then
               script_error("Hammurabi: (research_law) can't find owner faction.")
               return
          end

          local law_id = self:generate_next_law_id()
          if not self.utility.is_law_id_valid(law_id) then
               script_error("Hammurabi: (research_law) invalid law id(probably reached maximum laws).")
               return
          end

          if self:get_active_law(law_id) then
               script_error("Hammurabi: (research_law) duplicated law id.")
               return
          end

          if not is_table(category.base_resource_cost) then
               script_error("Hammurabi: (research_law) category has no base_resource_cost.")
               return
          end

          for i = 1, #effects do
               local effect_type_id = effects[i].effect_type_config.id
               for j = i + 1, #effects do
                    local other_effect_type_id = effects[j].effect_type_config.id
                    if effect_type_id == other_effect_type_id then
                         script_error("Hammurabi: (research_law) effect type is used more than once: " .. effect_type_id)
                         return
                    end
               end
          end

          local current_category_level = self:get_level_for_category(category.id)
          for _, effect in ipairs(effects) do
               if effect.effect_type_config.level_requirement > current_category_level then
                    script_error("Hammurabi: (research_law) effect type " ..
                         effect.effect_type_config.id .. " has higher level requirement than current category level")
                    return
               end
               if effect.parameter_config.level_requirement > current_category_level then
                    script_error("Hammurabi: (research_law) parameter " ..
                         effect.parameter_config.id .. " has higher level requirement than current category level")
                    return
               end
               if effect.value_config.level_requirement > current_category_level then
                    script_error("Hammurabi: (research_law) value " ..
                         effect.value_config.id .. " has higher level requirement than current category level")
                    return
               end
          end

          if #effects > self.config.max_effects_per_law then
               script_error("Hammurabi: (research_law) exceeded maximum number of effects per law")
               return
          end

          -- negative effects reduce the amount of turns, which in turn reduce the cost for research, by design request we want to use the absolute number of turns for cost
          local turns, turns_abs_value = self:calculate_turns_cost_for_effects(effects)

          -- create plain data table for the cost since we will need the data in the future and better not store config in the save otherwise we risk working with old data
          local resource_cost_plain_data = self.utility.create_cost_plain_data(category, turns_abs_value)
          if not ignore_cost then
               local resource_cost_object = self.utility.create_cost_object(resource_cost_plain_data, false)
               if not active_faction:can_afford_resource_cost_object(resource_cost_object) then
                    script_error("Hammurabi: (research_law) faction doesn't have enough resources.")
                    return
               end

               cm:faction_apply_resource_transaction(active_faction, resource_cost_object)
          end

          local effects_plain_data = {}
          for _, effect in ipairs(effects) do
               table.insert(effects_plain_data,
                    {
                         effect_type = effect.effect_type_config.id,
                         parameter = effect.parameter_config.id,
                         value = effect
                             .value_config.id
                    })
          end

          local current_historical_year = cm:model():current_historical_year()
          local faction_leader = active_faction:faction_leader()
          local faction_leader_cqi = not faction_leader:is_null_interface() and
              faction_leader:family_member():command_queue_index() or 0

          self.persistent.law_being_researched = {
               id = law_id,
               category_id = category.id,
               remaining_turns = turns,
               cost_plain_data = resource_cost_plain_data,
               effects_plain_data = effects_plain_data, -- ( the data should be just the ids, otherwise serialization might save an old version of the configs )
               name = name,
               description = description,
               historical_year = current_historical_year,
               faction_leader_cqi = faction_leader_cqi,
          }

          core:trigger_event("ScriptEventHammurabiResearchingLaw",
               { faction_name = self.persistent.faction_key, law_id = law_id })
     end,

     -- private function
     activate_researched_law = function(self, law_being_researched)
          local active_faction = cm:get_faction(self.persistent.faction_key)
          if active_faction:is_null_interface() then
               script_error("Hammurabi: (activate_researched_law) can't find owner faction.")
               return false
          end

          local id = law_being_researched.id
          local effect_bundle_key = self.utility.get_effect_bundle_key_for_law(id)
          if active_faction:has_effect_bundle(effect_bundle_key) then
               script_error("Hammurabi: (activate_researched_law) duplicated effect bundle.")
               return false
          end

          local effects_plain_data = law_being_researched.effects_plain_data
          local bundle_to_apply = self.utility.create_custom_effect_bundle(effect_bundle_key, effects_plain_data)
          if not bundle_to_apply then
               script_error("Hammurabi: (activate_researched_law) couldn't create effect bundle with key: " ..
                    effect_bundle_key)
               return false
          end

          if bundle_to_apply:effects():is_empty() then
               script_error("Hammurabi: (activate_researched_law) no valid effects")
               return false
          end

          bundle_to_apply:set_duration(0)
          cm:apply_custom_effect_bundle_to_faction(bundle_to_apply, active_faction)

          local justice_gained = 0
          self.utility.iterate_effects_plain_data(effects_plain_data, function(effect_full_config)
               justice_gained = justice_gained + effect_full_config.value_config.justice_gained
          end)
          cm:faction_add_pooled_resource(self.persistent.faction_key, self.config.resource_key,
               self.config.resource_factor_generate_justice, justice_gained)

          table.insert(self.persistent.active_laws,
               {
                    id = id,
                    category_id = law_being_researched.category_id,
                    effect_bundle_key = effect_bundle_key,
                    effects_plain_data = effects_plain_data,
                    name = law_being_researched.name,
                    description = law_being_researched.description,
                    historical_year = law_being_researched.historical_year,
                    faction_leader_cqi = law_being_researched.faction_leader_cqi,
               })

          core:trigger_event("ScriptEventHammurabiActivatedLaw",
               { faction_name = self.persistent.faction_key, law_id = id })

          local category_config = self.utility.get_category_config(law_being_researched.category_id)
          if #law_being_researched.description > 0 then
               cm:add_event_feed_event(category_config.event_key, self.persistent.faction_key, 0,
                    law_being_researched.description)
          else
               local historical_year = law_being_researched.historical_year
               local date_string_key = historical_year >= 0 and ancient_legacy_hammurabi_config.ad_text or
                   ancient_legacy_hammurabi_config.bc_text
               cm:add_event_feed_event(category_config.event_for_predefined_description_key, self.persistent.faction_key,
                    0, date_string_key, "", "", law_being_researched.faction_leader_cqi, math.abs(historical_year))
          end

          return true
     end,

     -- private function
     remove_law_being_researched = function(self)
          local law_being_researched = self.persistent.law_being_researched
          if not law_being_researched then
               script_error("Hammurabi: (remove_law_being_researched) no law being researched at the moment")
               return
          end

          local active_faction = cm:get_faction(self.persistent.faction_key)
          if active_faction:is_null_interface() then
               script_error("Hammurabi: (remove_law_being_researched) can't find owner faction.")
               return
          end

          local restored_cost_object = self.utility.create_cost_object(law_being_researched.cost_plain_data, true)
          restored_cost_object:multiply_by(self.config.restored_percent_of_original_cost_upon_law_remove / 100)

          cm:faction_apply_resource_transaction(active_faction, restored_cost_object)
          self.persistent.law_being_researched = nil

          core:trigger_event("ScriptEventHammurabiRemovedLawBeingResearched",
               { faction_name = self.persistent.faction_key })
     end,

     -- private function
     remove_active_law = function(self, active_law)
          if self.persistent.law_removals_count <= 0 then
               script_error("Hammurabi: (remove_active_law) not enough law removals")
               return
          end


          if active_law.is_divine then
               script_error("Hammurabi: (remove_active_law) can't remove a divine law")
               return
          end

          self.persistent.law_removals_count = self.persistent.law_removals_count - 1

          cm:remove_effect_bundle(active_law.effect_bundle_key, self.persistent.faction_key)

          local index = table_find(self.persistent.active_laws, active_law, true)
          if index then
               table.remove(self.persistent.active_laws, index)
          end
     end,

     -- private function
     instant_research_any_technology_action = function(self, technology_key)
          local active_faction = cm:get_faction(self.persistent.faction_key)
          if active_faction:is_null_interface() then
               script_error("Hammurabi: (instant_research_any_technology_action) can't find owner faction.")
               return
          end

          if active_faction:has_technology(technology_key) then
               script_error("Hammurabi: (instant_research_any_technology_action) technology was already researched " ..
                    technology_key)
               return
          end

          local action_config = self.config.actions.instant_research_any_technology
          local justice_cost = self.utility.calculate_justice_cost_research_any_technology_action(active_faction,
               technology_key)
          local paid_successfully = self:pay_justice_cost(justice_cost, action_config.resource_factor_consumed_by_action)
          if not paid_successfully then
               return
          end

          if active_faction:active_research_technology() == technology_key then
               cm:instantly_complete_ongoing_research_for_faction(self.persistent.faction_key, true)
          else
               cm:set_technology_as_researched_for_faction(self.persistent.faction_key, technology_key)
          end
     end,

     -- private function
     make_divine_law = function(self, law_id)
          local active_faction = cm:get_faction(self.persistent.faction_key)
          if active_faction:is_null_interface() then
               script_error("Hammurabi: (make_divine_law) can't find owner faction.")
               return
          end

          local active_law = self:get_active_law(law_id)
          if not active_law then
               script_error("Hammurabi: (make_divine_law) invalid law.")
               return
          end

          if active_law.is_divine then
               script_error("Hammurabi: (make_divine_law) law is already divine.")
               return
          end

          local justice_cost = self:calculate_justice_cost_for_divine_law_making(law_id)
          local action_config = self.config.actions.divine_law
          local paid_successfully = self:pay_justice_cost(justice_cost, action_config.resource_factor_consumed_by_action)
          if not paid_successfully then
               return
          end

          cm:faction_add_pooled_resource(self.persistent.faction_key, victory_points_mechanic.config.victory_points_key,
               action_config.resource_factor_reward_victory_points, action_config.reward_victory_points)

          -- increase current value for each effect, by design we should ignore the level of category required
          local new_effects_plain_data = self:create_effects_plain_data_for_divine_version_of_law(law_id)
          active_law.effects_plain_data = new_effects_plain_data

          local bundle_to_apply = self.utility.create_custom_effect_bundle(active_law.effect_bundle_key,
               new_effects_plain_data)
          bundle_to_apply:set_duration(0)
          cm:apply_custom_effect_bundle_to_faction(bundle_to_apply, active_faction)

          active_law.is_divine = true
     end,

     ai_attempt_law_research = function(self)
          if self:is_researching_law() then
               return
          end

          local last_attempted_research_category_id = self.persistent.ai.last_attempted_research_category_id
          local next_category_index = last_attempted_research_category_id == nil and 1 or
              (self.utility.get_category_config_index(last_attempted_research_category_id) + 1)
          if next_category_index > #self.config.categories then
               next_category_index = 1
          end

          local research_category_config = self.config.categories[next_category_index]
          local ignored_effects = self:create_ignored_effects_from_active_laws()
          local effects = self:generate_random_effects(self.config.max_effects_per_law, research_category_config,
               ignored_effects, true, true)

          if #effects > 0 then
               local next_law_id = self:generate_next_law_id()
               local name, name_key = self.utility.create_predefined_law_name(next_law_id, research_category_config.id,
                    true)
               self:research_law(research_category_config, name_key, "", effects, true)
          end

          -- we change last_attempted_research_category_id even when we couldn't start in order to avoid getting stuck on the same category
          -- if a research can't be started for whatever reason
          self.persistent.ai.last_attempted_research_category_id = research_category_config.id
     end,

     ai_attempt_instant_finish_currently_researched_technology = function(self, active_faction)
          local technology_being_researched = active_faction:active_research_technology()
          if #technology_being_researched <= 0 then
               return
          end

          local justice_points = self:get_justice_points()
          local justice_cost = self.utility.calculate_justice_cost_research_any_technology_action(active_faction,
               technology_being_researched)
          if justice_cost > justice_points then
               return
          end

          self:instant_research_any_technology_action(technology_being_researched)
     end,

     ai_attempt_level_up_category = function(self, active_faction)
          local last_leveled_up_category_id = self.persistent.ai.last_leveled_up_category_id
          local last_leveled_up_category_index = 0
          if last_leveled_up_category_id ~= nil then
               last_leveled_up_category_index = self.utility.get_category_config_index(last_leveled_up_category_id)
          end

          local categories_count = #self.config.categories
          for i = 0, categories_count - 1 do
               local category_index = ((last_leveled_up_category_index + i) % categories_count) + 1
               local category_config = self.config.categories[category_index]
               local next_level_config = self.utility.get_category_level_config(category_config,
                    self:get_level_for_category(category_config.id) + 1)
               if next_level_config then
                    local justice_points = self:get_justice_points()
                    if next_level_config.justice_cost <= justice_points then
                         self:level_up_category(category_config)
                         self.persistent.ai.last_leveled_up_category_id = category_config.id
                         return
                    end
               end
          end
     end,

     -- private function
     generate_random_effect = function(self, use_model_random, viable_effects)
          if #viable_effects <= 0 then
               return nil
          end

          local get_random_in_range = function(min, max)
               return use_model_random and cm:model():random_int(min, max) or math.random(min, max)
          end

          local effect_type_index = get_random_in_range(1, #viable_effects)
          local viable_effect_type = viable_effects[effect_type_index]
          if #viable_effect_type.parameters <= 0 then
               return nil
          end

          local parameter_index = get_random_in_range(1, #viable_effect_type.parameters)
          local viable_parameter = viable_effect_type.parameters[parameter_index]

          if #viable_parameter.values <= 0 then
               return nil
          end

          local value_index = get_random_in_range(1, #viable_parameter.values)
          local value_config = viable_parameter.values[value_index]

          return {
               effect_type_config = viable_effect_type.config,
               parameter_config = viable_parameter.config,
               value_config =
                   value_config
          }
     end,

     -- private function
     create_ignored_effects_from_active_laws = function(self)
          local ignored_effects = {}
          for _, law in ipairs(self.persistent.active_laws) do
               for _, effect_plain_data in ipairs(law.effects_plain_data) do
                    self:add_ignored_effect(ignored_effects, effect_plain_data.effect_type, effect_plain_data.parameter,
                         effect_plain_data.value)
               end
          end

          return ignored_effects
     end,

     -- private function
     add_ignored_effect = function(self, ignored_effects, effect_type_id, parameter_id, value_id)
          if not ignored_effects[effect_type_id] then
               ignored_effects[effect_type_id] = {}
          end

          if not ignored_effects[effect_type_id][parameter_id] then
               ignored_effects[effect_type_id][parameter_id] = {}
          end

          if not ignored_effects[effect_type_id][parameter_id][value_id] then
               ignored_effects[effect_type_id][parameter_id][value_id] = true
          end
     end,

     -- private function
     build_viable_random_effects = function(self, category_config, only_beneficial, ignored_effects, ignored_effect_types)
          local viable_random_effects = {}
          local current_category_level = self:get_level_for_category(category_config.id)

          for _, sub_category_config in ipairs(category_config.sub_categories) do
               local valid_effect_types = {}
               for _, effect_type_config in ipairs(sub_category_config.effect_types) do
                    local valid_parameters = {}
                    if effect_type_config.level_requirement <= current_category_level then
                         for _, parameter_config in ipairs(effect_type_config.parameters) do
                              local valid_values = {}
                              if parameter_config.level_requirement <= current_category_level then
                                   for _, value_config in ipairs(parameter_config.values) do
                                        local meets_level_criteria = value_config.level_requirement <=
                                            current_category_level
                                        local meets_positivity_criteria = not only_beneficial or
                                            self.utility.is_beneficial_parameter_value(parameter_config, value_config)
                                        if meets_level_criteria and meets_positivity_criteria then
                                             if not table_contains(ignored_effect_types, effect_type_config.id) and
                                                 not (ignored_effects and
                                                      ignored_effects[effect_type_config.id] and
                                                      ignored_effects[effect_type_config.id][parameter_config.id] and
                                                      ignored_effects[effect_type_config.id][parameter_config.id][value_config.id])
                                             then
                                                  table.insert(valid_values, value_config)
                                             end
                                        end
                                   end
                              end

                              if #valid_values > 0 then
                                   table.insert(valid_parameters, { config = parameter_config, values = valid_values })
                              end
                         end
                    end

                    if #valid_parameters > 0 then
                         table.insert(valid_effect_types, { config = effect_type_config, parameters = valid_parameters })
                    end
               end

               table_append(viable_random_effects, valid_effect_types)
          end

          return viable_random_effects
     end,

     -- should only be called by the model
     generate_random_effects = function(self, target_number_effects, category_config, ignored_effects, only_beneficial,
                                        use_model_random)
          local effects = {}
          local all_ignored_effects = {}
          table_append(all_ignored_effects, ignored_effects)

          for i = 1, target_number_effects do
               local already_added_effect_types = {}
               for _, effect in ipairs(effects) do
                    table.insert(already_added_effect_types, effect.effect_type_config.id)
               end

               local viable_random_effects = self:build_viable_random_effects(category_config, only_beneficial,
                    all_ignored_effects, already_added_effect_types)
               if #viable_random_effects <= 0 then
                    break
               end

               local effect = self:generate_random_effect(use_model_random, viable_random_effects)
               if effect then
                    table.insert(effects, effect)
                    self:add_ignored_effect(all_ignored_effects, effect.effect_type_config.id, effect.parameter_config
                         .id, effect.value_config.id)
               end
          end

          return effects
     end,

     -- private function
     pay_justice_cost = function(self, amount, factor)
          local justice_points = self:get_justice_points()
          if justice_points < amount then
               script_error("Hammurabi: (pay_justice_cost) faction doesn't have enough justice points.")
               return false
          end

          cm:faction_add_pooled_resource(self.persistent.faction_key, self.config.resource_key, factor, -amount)
          return true
     end,

     -- private function
     initialize_missing_categories = function(self)
          for _, category_config in dpairs(self.config.categories) do
               local category_data = self:get_category_data(category_config.id)
               if not category_data then
                    table.insert(self.persistent.categories, { id = category_config.id, level = 1 })
               end
          end
     end,

     get_category_data = function(self, category_id)
          local result_category = nil
          for _, category in ipairs(self.persistent.categories) do
               if category.id == category_id then
                    result_category = category
                    break
               end
          end

          return result_category
     end,

     calculate_effect_time_cost = function(self, effect_type_config, parameter_config, value_config)
          local is_beneficial_parameter_value = self.utility.is_beneficial_parameter_value(parameter_config, value_config)
          local effect_active_law_occurences = 0
          for _, active_law in ipairs(self.persistent.active_laws) do
               for _, effect_plain_data in ipairs(active_law.effects_plain_data) do
                    local effect_config = self.utility.get_effect_full_config(effect_plain_data.effect_type,
                         effect_plain_data.parameter, effect_plain_data.value)
                    if effect_config then
                         local active_effect_is_beneficial_parameter_value = self.utility.is_beneficial_parameter_value(
                              effect_config.parameter_config, effect_config.value_config)
                         if effect_plain_data.effect_type == effect_type_config.id and
                             effect_plain_data.parameter == parameter_config.id and
                             is_beneficial_parameter_value == active_effect_is_beneficial_parameter_value and -- each beneficial type handles the cost differently and the number of active effects shouldn't be shared between both types
                             (not self.config.repeated_effects_includes_value or effect_plain_data.value == value_config.id)
                         then
                              effect_active_law_occurences = effect_active_law_occurences + 1
                         end
                    end
               end
          end

          if self.utility.is_beneficial_parameter_value(parameter_config, value_config) then
               return value_config.time_cost * (effect_active_law_occurences + 1), effect_active_law_occurences > 0
          else
               local new_cost = math.round(value_config.time_cost *
                    math.pow(self.config.repeated_effect_non_beneficial_exponent_base, effect_active_law_occurences))
               return math.min(-1, new_cost), effect_active_law_occurences > 0
          end

          return 0, false
     end,

     get_listeners = function(_)
          return {
               {
                    event = "FirstTickAfterWorldCreated",
                    auto_check_faction = false,
                    condition = true,
                    callback = function(self, context)
                         if cm:get_local_faction_name(true) == self.persistent.faction_key then
                              -- activating the button should at some point be a common code for all ancient legacies
                              egypt_political_states:activate_button(self.ui.config.component_ids.legacy_panel_button)
                              self.ui:add_listeners(self)
                              self.ui:update_hud_button(self)
                         end

                         local faction = cm:get_faction(self.persistent.faction_key)
                         cm:set_script_state(faction,
                              "hammurabi_instant_research_any_technology_unfulfilled_prerequisites_additional_cost",
                              self.config.actions.instant_research_any_technology
                              .unfulfilled_prerequisites_additional_cost)
                         cm:set_script_state(faction, "hammurabi_instant_research_any_technology_cost_per_turn",
                              self.config.actions.instant_research_any_technology.cost_per_turn)
                    end,
               },

               {
                    event = "FactionTurnStart",
                    auto_check_faction = true,
                    condition = true,
                    callback = function(self, context)
                         self:on_turn_start()
                    end
               },

               {
                    event = "CharacterBecomesFactionLeader",
                    auto_check_faction = false,
                    condition = function(self, context)
                         local faction_leader = context:character()
                         return faction_leader:faction():name() == self.persistent.faction_key
                    end,
                    callback = function(self, context)
                         self:on_new_faction_leader()
                    end
               },

               {
                    event = "ScriptEventAmbitionPayloadsAboutToBeCreated",
                    auto_check_faction = false,
                    condition = true,
                    callback = function(self, context)
                         if context.stored_table.faction_key ~= self.persistent.faction_key then
                              return
                         end

                         local rewarded_justice = 0
                         for _, tag in ipairs(context.stored_table.ambition_tags) do
                              local ambition_rewarding_justice = table_find(self.config.ambitions_rewarding_justice,
                                   function(it) return it.tag == tag end)
                              if ambition_rewarding_justice and ambition_rewarding_justice.amount > rewarded_justice then
                                   rewarded_justice = ambition_rewarding_justice.amount
                              end
                         end

                         if rewarded_justice > 0 then
                              table.insert(context.stored_table.additional_resources_payload,
                                   { self.config.resource_key, rewarded_justice })
                         end
                    end
               },

               {
                    event = "UITriggerScriptEvent",
                    auto_check_faction = true,
                    condition = true,
                    callback = function(self, context)
                         local params = context:trigger():split(":")
                         if params[1] ~= "hammurabi_research_law" then
                              return
                         end

                         local name = params[2]
                         local description = params[3]

                         local effects = {}
                         local effects_count = tonumber(params[4])
                         for i = 1, effects_count do
                              local effect_str = params[4 + i]:split(";")
                              local effect_type_id = effect_str[1]
                              local parameter_id = effect_str[2]
                              local value_id = effect_str[3]

                              local effect_full_config = self.utility.get_effect_full_config(effect_type_id, parameter_id,
                                   value_id)
                              if effect_full_config then
                                   table.insert(effects, effect_full_config)
                              else
                                   script_error("Hammurabi: invalid config for effect type " ..
                                        effect_type_id .. " or parameter " .. parameter_id .. " or value " .. value_id)
                              end
                         end

                         if table.is_empty(effects) then
                              script_error("Hammurabi: tried to research a law with no valid effects")
                              return
                         end

                         self:research_law(effects[1].effect_type_config.sub_category.category, name, description,
                              effects, false)
                    end,
               },

               {
                    event = "UITriggerScriptEvent",
                    auto_check_faction = true,
                    condition = true,
                    callback = function(self, context)
                         local params = context:trigger():split(":")
                         if params[1] ~= "hammurabi_level_up_category" then
                              return
                         end

                         local category_id = params[2] or ""

                         local category_config = self.utility.get_category_config(category_id)
                         if not category_config then
                              script_error(
                                   "Hammurabi: tried to level up category, but not config was found for category with id " ..
                                   category_id)
                              return
                         end

                         self:level_up_category(category_config)
                    end,
               },

               {
                    event = "UITriggerScriptEvent",
                    auto_check_faction = true,
                    condition = true,
                    callback = function(self, context)
                         if context:trigger() ~= "hammurabi_remove_law_being_researched" then
                              return
                         end

                         self:remove_law_being_researched()
                    end,
               },

               {
                    event = "UITriggerScriptEvent",
                    auto_check_faction = true,
                    condition = true,
                    callback = function(self, context)
                         local params = context:trigger():split(":")
                         if params[1] ~= "hammurabi_remove_active_laws" then
                              return
                         end

                         local laws_count = params[2]
                         for i = 1, laws_count do
                              local law_id = tonumber(params[2 + i])
                              local active_law = self:get_active_law(law_id)
                              if active_law then
                                   self:remove_active_law(active_law)
                              else
                                   script_error("Hammurabi: tried to remove non existent law with id " .. law_id)
                              end
                         end

                         core:trigger_event("ScriptEventHammurabiRemovedActiveLaws",
                              { faction_name = self.persistent.faction_key, laws_count = laws_count })
                    end,
               },

               {
                    event = "UITriggerScriptEvent",
                    auto_check_faction = true,
                    condition = true,
                    callback = function(self, context)
                         local params = context:trigger():split(":")
                         if params[1] ~= "hammurabi_make_divine_laws" then
                              return
                         end

                         local laws_count = params[2]
                         for i = 1, laws_count do
                              local law_id = tonumber(params[2 + i])
                              self:make_divine_law(law_id)
                         end

                         core:trigger_event("ScriptEventHammurabiMadeDivineLaws",
                              { faction_name = self.persistent.faction_key })
                    end,
               },

               {
                    event = "UITriggerScriptEvent",
                    auto_check_faction = true,
                    condition = true,
                    callback = function(self, context)
                         local params = context:trigger():split(":")
                         if params[1] ~= "hammurabi_research_any_technology" then
                              return
                         end

                         local technology_key = #params > 1 and params[2] or nil
                         if not technology_key then
                              script_error("Hammurabi: tried to research empty technology")
                              return
                         end

                         self:instant_research_any_technology_action(technology_key)
                    end,
               },

               {
                    event = "PanelOpenedCampaign",
                    auto_check_faction = true,
                    condition = function(self, context)
                         if context.string ~= self.ui.config.panel_name then
                              return false
                         end

                         local local_faction_name = cm:get_local_faction_name(true)
                         return self.persistent.faction_key == local_faction_name
                    end,
                    callback = function(self, context)
                         local panel_component = UIComponent(context:panel_component())
                         self.ui:on_panel_opened(self, self.persistent.faction_key, panel_component)
                    end
               },

               {
                    event = "PanelClosedCampaign",
                    auto_check_faction = true,
                    condition = function(self, context)
                         if context.string ~= self.ui.config.panel_name then
                              return
                         end

                         local local_faction_name = cm:get_local_faction_name(true)
                         return self.persistent.faction_key == local_faction_name
                    end,
                    callback = function(self, context)
                         self.ui:on_panel_closed()
                    end,
               },

               -- Only for development
               {
                    event = "UIReloaded",
                    auto_check_faction = true,
                    condition = true,
                    callback = function(self, context)
                         local local_faction_name = cm:get_local_faction_name(true)
                         if local_faction_name == self.persistent.faction_key then
                              egypt_political_states:activate_button(self.ui.config.component_ids.legacy_panel_button)
                              self.ui:update_hud_button(self)
                         end
                    end,
               },

               -- CHEATS
               {
                    event = "UITriggerScriptEvent",
                    auto_check_faction = false,
                    condition = function(self, context)
                         local trigger = context:trigger():split(":")
                         if trigger[1] ~= "HammurabiCheat" then
                              return
                         end

                         local faction = cm:model():faction_for_command_queue_index(context:faction_cqi())
                         return faction and not faction:is_null_interface() and
                             self.persistent.faction_key == faction:name()
                    end,
                    callback = function(self, context)
                         local trigger = context:trigger():split(":")
                         local cheat_id = trigger[2]

                         local cheat_finish_researched_law = function()
                              local law_being_researched = self.persistent.law_being_researched
                              if law_being_researched then
                                   local law_to_activate = table_deep_copy(law_being_researched)
                                   -- clear because activate_researched_law sends an event and if event handler checks whether we are still researching it will return true ...
                                   self.persistent.law_being_researched = nil
                                   self:activate_researched_law(law_to_activate)
                              end
                         end

                         if cheat_id == "InstantResearchLaw" then
                              cheat_finish_researched_law()
                         elseif cheat_id == "AddLawRemovals" then
                              self.persistent.law_removals_count = self.persistent.law_removals_count +
                                  self.config.law_removals_gained_for_leader_change
                              core:trigger_event("ScriptEventHammurabiLawRemovalsIncreased",
                                   { faction_name = self.persistent.faction_key })
                         elseif cheat_id == "AddRandomLaw" then
                              -- finish any law that is already being researched to allow us to add a new law and instant research it
                              cheat_finish_researched_law()

                              local category_index = cm:model():random_int(1, #ancient_legacy_hammurabi_config
                                   .categories)
                              local category_config = ancient_legacy_hammurabi_config.categories[category_index]
                              local target_count_effects = cm:model():random_int(1, self.config.max_effects_per_law)
                              local effects = self:generate_random_effects(target_count_effects, category_config, {},
                                   false, true)

                              if #effects > 0 then
                                   local next_law_id = self:generate_next_law_id()
                                   local name, name_key = self.utility.create_predefined_law_name(next_law_id,
                                        category_config.id, true)
                                   self:research_law(category_config, name_key, "", effects, true)
                                   cheat_finish_researched_law()
                              end
                         end
                    end
               },
          }
     end,

     -- persistent data is already loaded by ancient_legacy_common, we are just informed we are loaded
     on_loading_game = function(self, faction_key)
          -- it's possible that between different versions of the game new categories get added, so we need to add those categories to the persistent data
          self:initialize_missing_categories()

          if not is_table(self.persistent.ui) then
               self.persistent.ui = {
                    show_newly_activated_law_notification = false,
               }
          end
          --Lycia bookmark 2
          self.persistent.law_removals_count = self.persistent.law_removals_count + self.config.law_removals_gained_for_leader_change
          core:trigger_event("ScriptEventHammurabiLawRemovalsIncreased", { faction_name = self.persistent.faction_key })
     end,

}

return ancient_legacy_hammurabi
