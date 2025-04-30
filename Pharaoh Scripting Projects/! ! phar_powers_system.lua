local file_info = debug.getinfo(1, "S")
local folder_file_splits = string.split(file_info.source, "\\")
out("Loading " .. folder_file_splits[#folder_file_splits])

powers_system = {
     persistent = {
          all_royal_powers_enabled = false,

          faction_data = {
               --[[
			faction_key = {
				court_positions = 0,

				cooldowns = {
					power = 5,
				},

				tier_unlocks = {
					[1] = {
						power1,
						power2,
					}
				}
			},
			--]]
          },
     },

     shared_states_suffixed = {
          -- Each tier will have a shared state like this. Example for the first 2 tiers:
          -- legitimacy_needed_for_powers_of_tier_1
          -- legitimacy_needed_for_powers_of_tier_2
          power_tier_legitimacy_requirement_prefix = "legitimacy_needed_for_powers_of_tier_",
     },

     shared_states = {
          corvee_labour_unlocked = "corvee_labour_is_unlocked",
          corvee_labour_available = "corvee_labour_is_available",
          corvee_labour_active = "corvee_labour_is_active",
          corvee_labour_max_building_level = "corvee_labour_max_building_level",
          corvee_labour_build_time_reduction = "corvee_labour_build_time_reduction",

          growth_migration_unlocked = "growth_migration_is_unlocked",
          growth_migration_available = "growth_migration_is_available",

          competency_points = "num_competency_points",

          raise_resources_unlocked = "raise_resources_is_unlocked",
          raise_resources_available = "raise_resources_is_available",
          raise_armies_unlocked = "raise_armies_is_unlocked",
          raise_armies_available = "raise_armies_is_available",

          foment_dissent_unlocked = "foment_dissent_is_unlocked",
          foment_dissent_available = "foment_dissent_is_available",

          bribe_force_unlocked = "bribe_force_is_unlocked",
          bribe_force_available = "bribe_force_is_available",
     },

     court_position_name_key_prefix = "phar_position_",

     update_powers_ui_event = "powers_new_unlocked_power",

     ids = {
          corvee_labour = "corvee_labour",
          forced_annexation = "forced_annexation",
          growth_migration = "growth_migration",
          court_positions = "court_positions",
          competency_points = "competency_points",
          raise_resources = "raise_resources",
          raise_armies = "raise_armies",
          foment_dissent = "foment_dissent",
          bribe_force = "bribe_force",
          remote_colonisation = "remote_colonisation",
          war_games = "war_games",
     },

     --[[ This is defined in on_loading_game function of the powers system
	power_id_to_table_map = {
		-- power_string = power_config
		-- eg:
		corvee_labour = pharaohs_powers_config.corvee_labour,
	},
	--]]

     events = {
          RoundStart = function(self, context)
               for faction_key, faction_data in pairs(self.persistent.faction_data) do
                    for power, cooldown in pairs(faction_data.cooldowns) do
                         faction_data.cooldowns[power] = cooldown - 1

                         if faction_data.cooldowns[power] == 0 then
                              faction_data.cooldowns[power] = nil
                         end
                    end
               end
          end,

          FactionTurnStart = function(self, context)
               local faction = context:faction()
               local faction_key = faction:name()
               local faction_data = self.persistent.faction_data[faction_key]
               if faction_data then
                    if self:power_available_to_mechanic(self.ids.corvee_labour) then
                         self:update_corvee_labour_status(faction_key)
                    end

                    if self:power_available_to_mechanic(self.ids.growth_migration) then
                         self:update_growth_migration_status(faction_key)
                    end

                    if self:power_available_to_mechanic(self.ids.competency_points) then
                         self:update_competency_points(faction_key)
                    end

                    if self:power_available_to_mechanic(self.ids.raise_resources) then
                         self:update_raise_resources_status(faction_key)
                    end

                    if self:power_available_to_mechanic(self.ids.raise_armies) then
                         self:update_raise_armies_status(faction_key)
                    end

                    if self:power_available_to_mechanic(self.ids.foment_dissent) then
                         self:update_foment_dissent_status(faction_key)
                    end

                    if self:power_available_to_mechanic(self.ids.bribe_force) then
                         self:update_bribe_force_status(faction_key)
                    end
               end
          end,

          UITriggerScriptEvent = function(self, context)
               local faction_cqi = context:faction_cqi()
               local faction = cm:model():faction_for_command_queue_index(faction_cqi)

               if not faction or faction:is_null_interface() then
                    return
               end

               local faction_key = faction:name()

               if not legitimacy_choice:legitimacy_unlocked(self.legitimacy_system, faction_key) then
                    return
               end

               local splits = context:trigger():split(":")
               if splits[1] == "trigger_forced_annexation" then
                    local to_be_annexed_key = splits[2]
                    self:trigger_forced_annexation(faction_key, to_be_annexed_key)
                    return
               end

               if splits[1] == "toggle_corvee_labour" then
                    self:toggle_corvee_labour(faction_key)
                    return
               end

               if splits[1] == "trigger_growth_migration" then
                    local region_key = splits[2]
                    self:trigger_growth_migration(faction_key, region_key)
                    return
               end

               if splits[1] == "trigger_raise_resources" then
                    local region_key = splits[2]
                    self:trigger_raise_resources(faction_key, region_key)
                    return
               end

               if splits[1] == "trigger_raise_armies" then
                    local character_cqi = tonumber(splits[2])
                    self:trigger_raise_armies(faction_key, character_cqi)
                    return
               end

               if splits[1] == "trigger_foment_dissent" then
                    local region_key = splits[2]
                    self:trigger_foment_dissent(faction_key, region_key)
                    return
               end

               if splits[1] == "trigger_bribe_force" then
                    local character_cqi = tonumber(splits[2])
                    self:trigger_bribe_force(faction_key, character_cqi)
                    return
               end

               if splits[1] == "phar_crown_unlock_powers" then
                    table.remove(splits, 1)
                    self:unlock_powers_from_string_list(faction_key, splits)
               end
          end,

          BuildingConstructionIssuedByPlayer = function(self, context)
               local faction = context:garrison_residence():faction()

               local corvee_labour_is_active = cm:get_bool_script_state(faction, self.shared_states.corvee_labour_active)

               local repair_all_buildings_in_province = function(garrison_residence, faction_key)
                    local province = garrison_residence:region():province()
                    local region_list = province:regions()

                    for i = 0, region_list:num_items() - 1 do
                         local region = region_list:item_at(i)
                         local region_owner = region:owning_faction()
                         if not region_owner:is_null_interface() and region_owner:name() == faction_key then
                              local slot_list = region:slot_list()
                              for j = 0, slot_list:num_items() - 1 do
                                   local slot = slot_list:item_at(j)
                                   if slot:has_building() then
                                        local building = slot:building()
                                        if building:percent_health() < 100 and not cm:is_building_excluded_from_corvee_labour(building:name()) then
                                             cm:region_slot_instantly_repair_building(slot)
                                        end
                                   end
                              end
                         end
                    end
               end

               if corvee_labour_is_active then
                    local faction_key = faction:name()
                    local building_key = context:building()
                    local success, power, tier = self:can_trigger_corvee_labour(faction_key)
                    if success and not cm:is_building_excluded_from_corvee_labour(building_key) then
                         local tier_index = table_find(power.tiers, tier, true)

                         repair_all_buildings_in_province(context:garrison_residence(), faction_key)

                         self:trigger_power_cooldown(faction_key, self.ids.corvee_labour, tier)
                         cm:set_script_state(faction, self.shared_states.corvee_labour_available, false)
                         cm:set_script_state(faction, self.shared_states.corvee_labour_active, false)

                         local ui_config = self.ui_config.powers.corvee_labour
                         local faction_leader = faction:faction_leader()
                         cm:add_event_feed_event(
                              "ruler_skill_construction",
                              faction:name(),
                              0,
                              ui_config.tooltip_title_prefix .. tostring(tier_index),
                              self:get_court_ruler_position_localisation_key(),
                              context:building(),
                              faction_leader:command_queue_index(),
                              context:garrison_residence():region():command_queue_index()
                         )

                         core:trigger_event("ScriptEventCorveeLabourUsed", { faction = faction })

                         if faction_key == cm:get_local_faction_name(true) then
                              cm:notify_crown_power_used(faction_key, self.ids.corvee_labour,
                                   self.political_states_system.config.id)

                              self:get_ui_button_power_table_for_faction(faction_key, nil, "corvee_labour", nil)
                         end
                    end
               end
          end,

          ContextTriggerEvent = function(self, context)
               local local_faction_key = cm:get_local_faction_name(true)

               local splits = context.string:split(":")
               local uic = context.component

               if not uic then
                    return
               end

               uic = UIComponent(uic)

               -- powers can be observed before picking legitimacy path, so we need to be able to display their tooltip even when ligitimacy path isn't unlocked
               if splits[1] == "phar_setup_power_tooltip" then
                    local power_string = splits[2]
                    local tier = tonumber(splits[3])
                    local powers_culture_id = splits[4]
                    local param1 = splits[5]

                    if not (powers_culture_id == self.config.id or legitimacy_choice:legitimacy_unlocked(self.legitimacy_system, local_faction_key)) then
                         return
                    end

                    self:setup_power_tooltip(uic, power_string, tier, param1)
                    return
               end

               if not legitimacy_choice:legitimacy_unlocked(self.legitimacy_system, local_faction_key) then
                    return
               end

               if splits[1] == "set_to_inactive_if_cant_unlock_powers" then
                    if not self:can_faction_use_powers(local_faction_key) then
                         uic:SetState("inactive")
                    end
                    return
               end

               if splits[1] == "pharaohs_crown_setup_power_tier_slot" then
                    local tier = splits[2]
                    local index = splits[3]
                    self:setup_power_tier_slot(local_faction_key, uic, tonumber(tier), tonumber(index))
                    return
               end

               if splits[1] == "pharaohs_crown_get_powers_table_for_tier" then
                    local tier = splits[2]
                    self:get_ui_power_table_for_faction(local_faction_key, uic, tonumber(tier))
                    return
               end

               if splits[1] == "pharaohs_crown_powers_locked_tooltip" then
                    local tier = tonumber(splits[2])
                    self:setup_powers_locked_tooltip(uic, tier)
                    return
               end

               if splits[1] == "pharaohs_crown_get_power_ui_button_data" or splits[1] == "pharaohs_crown_get_power_ui_button_data_diplomacy" then
                    local power_string = splits[2]
                    local param1 = splits[3]
                    if self.power_id_to_table_map[power_string] then
                         local tier_if_not_available = splits[1] == "pharaohs_crown_get_power_ui_button_data_diplomacy" and
                         1
                         self:get_ui_button_power_table_for_faction(local_faction_key, uic, power_string, param1,
                              tier_if_not_available)
                    end
                    return
               end
          end,
     },

     on_new_game_started = function(self, context)
          for tier, requirement in ipairs(self.config.tier_legitimacy_requirement) do
               local shared_state = self.shared_states_suffixed.power_tier_legitimacy_requirement_prefix ..
               tostring(tier) .. "_" .. self.legitimacy_system.config.resource_key
               cm:set_script_state(shared_state, requirement)
          end
     end,

     enable_all_royal_powers = function(self)
          --[[
		The way powers work currently is by checking if a power is in the config of the power system. For instance,
		egyptians have corvee_labour in their config so they get access to this power.

		When we enable all royal powers for the legitimacy path (this is currently an option in campaign customization)
		we just fill up the config with the other powers, thus the legitimacy path gets access to them.

		This is a quick and dirty solution, but i don't see any problems with it currently and it's way faster than
		rewriting a bunch of other functions to somehow check for other royal powers.
		--]]

          self.persistent.enable_all_royal_powers = true

          for power_id, power_config in pairs(all_royal_powers_config.powers_config) do
               if not self.config[power_id] then
                    self.config[power_id] = power_config
               end
          end

          for power_id, power_ui_config in pairs(all_royal_powers_config.ui_config) do
               if not self.ui_config.powers[power_id] then
                    self.ui_config.powers[power_id] = power_ui_config
               end
          end

          self:setup_power_id_to_table_map()
     end,

     get_faction_data = function(self, faction_key)
          if not self.persistent.faction_data[faction_key] then
               self.persistent.faction_data[faction_key] = {
                    court_positions = 0,
                    cooldowns = {},
                    tier_unlocks = {},
               }

               local faction_data = self.persistent.faction_data[faction_key]
               for _ = 1, #self.config.max_powers_per_tier do
                    table.insert(faction_data.tier_unlocks, {})
               end
          end

          return self.persistent.faction_data[faction_key]
     end,

     num_unlocked_powers_of_tier = function(self, faction_key, tier_num)
          local faction_data = self.persistent.faction_data[faction_key]
          return (faction_data and #faction_data.tier_unlocks[tier_num]) or 0
     end,

     num_unlocked_powers = function(self, faction_key)
          local unlocked_powers = 0
          for tier = 1, #self.config.max_powers_per_tier do
               unlocked_powers = unlocked_powers + self:num_unlocked_powers_of_tier(faction_key, tier)
          end

          return unlocked_powers
     end,

     num_available_power_unlocks = function(self, faction_key)
          local legitimacy = self.legitimacy_system:get_legitimacy(faction_key)
          local total_power_unlocks_reached = 0

          for tier, legitimacy_requirement in ipairs(self.config.tier_legitimacy_requirement) do
               if legitimacy >= legitimacy_requirement then
                    total_power_unlocks_reached = total_power_unlocks_reached + self.config.max_powers_per_tier[tier]
               end
          end

          if total_power_unlocks_reached <= 0 then
               return 0
          end

          return total_power_unlocks_reached - self:num_unlocked_powers(faction_key)
     end,

     power_available_to_mechanic = function(self, power_str)
          return to_bool(self.config[power_str])
     end,

     total_unlockable_powers = function(self, faction_key)
          local unlockable_powers = 0
          for tier, powers_per_tier in ipairs(self.config.max_powers_per_tier) do
               unlockable_powers = unlockable_powers + powers_per_tier
          end

          return unlockable_powers
     end,

     get_power_string_to_unlock_function_map = function(self)
          return {
               corvee_labour = self.unlock_corvee_labour,
               forced_annexation = self.unlock_forced_annexation,
               growth_migration = self.unlock_growth_migration,
               court_positions = self.unlock_court_positions,
               competency_points = self.unlock_competency_points,
               raise_resources = self.unlock_raise_resources,
               raise_armies = self.unlock_raise_armies,
               foment_dissent = self.unlock_foment_dissent,
               bribe_force = self.unlock_bribe_force,
               remote_colonisation = self.unlock_remote_colonisation,
               war_games = self.unlock_war_games,
          }
     end,

     get_court_ruler_position_localisation_key = function(self)
          local relevant_court = self.get_relevant_court()
          local ruling_position_obj = court.util_functions.get_court_position(relevant_court,
               relevant_court.config.ruler_position)
          return court.position_functions.get_position_name_localization_key(ruling_position_obj, relevant_court)
     end,

     -- Used when unlocking powers from UI
     -- String list must be in the following format
     --{
     --	"power_string=tier_to_unlock",
     --	"corvee_labour=3",
     --	"forced_annexation=2",
     --}
     unlock_powers_from_string_list = function(self, faction_key, string_list)
          local power_string_to_unlock_function_map = self:get_power_string_to_unlock_function_map()

          for _, power_string_tier in ipairs(string_list) do
               local splits = power_string_tier:split("=")
               local power_string = splits[1]
               local tier = tonumber(splits[2])
               local unlock_method = power_string_to_unlock_function_map[power_string]

               if unlock_method then
                    unlock_method(self, faction_key, tier)
               end
          end

          common.send_ui_update_message(self.update_powers_ui_event)
     end,

     unlock_tier = function(self, faction_key, power_string, tier_num)
          local power = self.power_id_to_table_map[power_string]

          if not power then
               self:error_message("trying to unlock a tier for a power that doesn't exist: " .. tostring(power_string))
               return false
          end

          local tier = power.tiers[tier_num]

          if not tier then
               self:error_message("trying to unlock a tier that doesnt exist of the power " ..
               power_string .. ": " .. tostring(tier_num))
               return false
          end

          local num_powers = self:num_unlocked_powers_of_tier(faction_key, tier_num)

          if num_powers >= self.config.max_powers_per_tier[tier_num] then
               self:error_message(
               "trying to unlock a power for a tier in which we already have the max amount of unlocks: " .. tier_num)
               return false
          end

          local current_legitimacy = self.legitimacy_system:get_legitimacy(faction_key)
          local legitimacy_requirement = self.config.tier_legitimacy_requirement[tier_num]

          if current_legitimacy < legitimacy_requirement then
               self:error_message("trying to unlock a power without having the legitimacy requirement.")
               return false
          end

          if self:tier_unlocked(faction_key, power_string, tier_num) then
               self:error_message("trying to unlock a power that has already been unlocked.")
               return false
          end

          local faction_data = self:get_faction_data(faction_key)

          table.insert(faction_data.tier_unlocks[tier_num], power_string)

          if self.config.lose_legitimacy_when_unlocking_power then
               self.legitimacy_system:add_legitimacy(faction_key, self.config.bought_power_factor,
                    -legitimacy_requirement)
          end

          if self.config.refund_lower_tier_of_same_power_when_unlocking then
               for i = 1, tier_num - 1 do
                    local found_power_index = table_find(faction_data.tier_unlocks[i], power_string, true)
                    if found_power_index then
                         table.remove(faction_data.tier_unlocks[i], found_power_index)
                         break
                    end
               end
          end

          return true
     end,

     unlock_corvee_labour = function(self, faction_key, tier_num)
          local ret = self:unlock_tier(faction_key, self.ids.corvee_labour, tier_num)

          local faction = cm:get_faction(faction_key)

          cm:set_script_state(faction, self.shared_states.corvee_labour_max_building_level,
               self.config.corvee_labour.tiers[tier_num].max_building_level)

          local build_time_reduction = self.config.corvee_labour.tiers[tier_num].build_time_reduction or 0
          cm:set_script_state(faction, self.shared_states.corvee_labour_build_time_reduction, build_time_reduction)

          if ret and self.shared_states.corvee_labour_available and self:can_trigger_corvee_labour(faction_key, true) then
               cm:set_script_state(faction, self.shared_states.corvee_labour_unlocked, true)
               cm:set_script_state(faction, self.shared_states.corvee_labour_available, true)
          end

          return ret
     end,

     unlock_forced_annexation = function(self, faction_key, tier_num)
          return self:unlock_tier(faction_key, self.ids.forced_annexation, tier_num)
     end,

     unlock_growth_migration = function(self, faction_key, tier_num)
          local ret = self:unlock_tier(faction_key, self.ids.growth_migration, tier_num)

          if ret and self.shared_states.growth_migration_available and self:can_trigger_growth_migration(faction_key, nil, true) then
               local faction = cm:get_faction(faction_key)
               cm:set_script_state(faction, self.shared_states.growth_migration_unlocked, true)
               cm:set_script_state(faction, self.shared_states.growth_migration_available, true)
          end

          return ret
     end,

     unlock_court_positions = function(self, faction_key, tier_num)
          local success = self:unlock_tier(faction_key, self.ids.court_positions, tier_num)

          self:update_court_positions(faction_key)

          return success
     end,

     unlock_competency_points = function(self, faction_key, tier_num)
          local ret = self:unlock_tier(faction_key, self.ids.competency_points, tier_num)

          if ret then
               local faction_data = self.persistent.faction_data[faction_key]
               faction_data.cooldowns[self.ids.competency_points] = 0
               self:update_competency_points(faction_key)
          end

          return ret
     end,

     unlock_raise_resources = function(self, faction_key, tier_num)
          local success = self:unlock_tier(faction_key, self.ids.raise_resources, tier_num)
          if success and self.shared_states.raise_resources_available and self:can_trigger_raise_resources(faction_key, nil, true) then
               local faction = cm:get_faction(faction_key)
               cm:set_script_state(faction, self.shared_states.raise_resources_unlocked, true)
               cm:set_script_state(faction, self.shared_states.raise_resources_available, true)
          end
          return success
     end,

     unlock_raise_armies = function(self, faction_key, tier_num)
          local success = self:unlock_tier(faction_key, self.ids.raise_armies, tier_num)
          if success and self.shared_states.raise_armies_available and self:can_trigger_raise_armies(faction_key, nil, true) then
               local faction = cm:get_faction(faction_key)
               cm:set_script_state(faction, self.shared_states.raise_armies_unlocked, true)
               cm:set_script_state(faction, self.shared_states.raise_armies_available, true)
          end
          return success
     end,

     unlock_foment_dissent = function(self, faction_key, tier_num)
          local success = self:unlock_tier(faction_key, self.ids.foment_dissent, tier_num)
          if success and self.shared_states.foment_dissent_available and self:can_trigger_foment_dissent(faction_key, nil, true) then
               local faction = cm:get_faction(faction_key)
               cm:set_script_state(faction, self.shared_states.foment_dissent_unlocked, true)
               cm:set_script_state(faction, self.shared_states.foment_dissent_available, true)
          end
          return success
     end,

     unlock_bribe_force = function(self, faction_key, tier_num)
          local success = self:unlock_tier(faction_key, self.ids.bribe_force, tier_num)
          if success and self.shared_states.bribe_force_available and self:can_trigger_bribe_force(faction_key, nil, true) then
               local faction = cm:get_faction(faction_key)
               cm:set_script_state(faction, self.shared_states.bribe_force_unlocked, true)
               cm:set_script_state(faction, self.shared_states.bribe_force_available, true)
          end
          return success
     end,

     unlock_remote_colonisation = function(self, faction_key, tier_num)
          local success = self:unlock_tier(faction_key, self.ids.remote_colonisation, tier_num)

          if not success then
               return false
          end

          cm:remove_effect_bundle(self.config.remote_colonisation.effect_bundle_key, faction_key)

          local tier_table = self.config.remote_colonisation.tiers[tier_num]

          local bundle = cm:create_new_custom_effect_bundle(self.config.remote_colonisation.effect_bundle_key)
          local effects = bundle:effects()

          for i = 0, effects:num_items() - 1 do
               local effect = effects:item_at(i)
               for key, value in pairs(tier_table) do
                    if effect:key() == "phar_combi_remote_colonisation_" .. key then
                         bundle:set_effect_value(effect, value)
                    end
               end
          end

          bundle:set_duration(0)

          cm:apply_custom_effect_bundle_to_faction(bundle, cm:get_faction(faction_key))

          return true
     end,

     unlock_war_games = function(self, faction_key, tier_num)
          local success = self:unlock_tier(faction_key, self.ids.war_games, tier_num)

          if not success then
               return false
          end

          local tier_table = self.config.war_games.tiers[tier_num]

          cm:faction_set_war_games_parameters(
               faction_key,
               tier_table.max_charges,
               tier_table.recharge_turns,
               tier_table.levels_per_charge
          )

          return true
     end,

     tier_unlocked = function(self, faction_key, power_string, tier)
          local faction_data = self.persistent.faction_data[faction_key]

          if not faction_data then
               return false
          end

          if self.config.lock_power_when_legitimacy_bellow_requirement
              and self.legitimacy_system:get_legitimacy(faction_key) < self.config.tier_legitimacy_requirement[tier]
          then
               return false
          end

          for _, power in ipairs(faction_data.tier_unlocks[tier]) do
               if power == power_string then
                    return true
               end
          end

          return false
     end,

     get_unlocked_tiers = function(self, faction_key, power_string)
          local faction_data = self.persistent.faction_data[faction_key]

          if not faction_data then
               return {}
          end

          local unlocked_tiers = {}

          for tier, unlocks in pairs(faction_data.tier_unlocks) do
               for _, unlocked_power in ipairs(unlocks) do
                    if unlocked_power == power_string then
                         table.insert(unlocked_tiers, tier)
                    end
               end
          end

          return unlocked_tiers
     end,

     get_unlocked_powers_for_tier = function(self, faction_key, tier)
          local faction_data = self.persistent.faction_data[faction_key]

          if not faction_data then
               return {}
          end

          return faction_data.tier_unlocks[tier]
     end,

     get_power_tier_helper = function(self, faction_key, power_string, cur_legitimacy)
          local power = self.power_id_to_table_map[power_string]

          if not power then
               self:error_message("trying to get the tier for a power that doesn't exist: " .. tostring(power_string))
               return
          end

          local unlocked_tiers = self:get_unlocked_tiers(faction_key, power_string)
          local best_available_tier = 0

          for _, tier in ipairs(unlocked_tiers) do
               if best_available_tier < tier
                   and (not self.config.lock_power_when_legitimacy_bellow_requirement
                        or self.config.tier_legitimacy_requirement[tier] <= cur_legitimacy)
               then
                    best_available_tier = tier
               end
          end

          return (best_available_tier ~= 0 and best_available_tier) or nil
     end,

     get_power_tier = function(self, faction_key, power_string)
          local cur_legitimacy = self.legitimacy_system:get_legitimacy(faction_key)

          return (self.political_states_system:is_ruler(faction_key)
                   and (not self.config.only_sitting_ruler_has_access_to_powers or self.political_states_system:is_sitting_ruler(faction_key))
                   and self:get_power_tier_helper(faction_key, power_string, cur_legitimacy))
              or nil
     end,

     get_corvee_labour_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.corvee_labour)
     end,

     get_forced_annexation_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.forced_annexation)
     end,

     get_growth_migration_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.growth_migration)
     end,

     get_court_positions_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.court_positions)
     end,

     get_competency_points_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.competency_points)
     end,

     get_raise_resources_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.raise_resources)
     end,

     get_raise_armies_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.raise_armies)
     end,

     get_foment_dissent_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.foment_dissent)
     end,

     get_bribe_force_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.bribe_force)
     end,

     get_remote_colonisation_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.remote_colonisation)
     end,

     get_war_games_tier = function(self, faction_key)
          return self:get_power_tier(faction_key, self.ids.war_games)
     end,

     trigger_power_helper = function(self, faction_key, power_string, skip_error_message)
          local power = self.power_id_to_table_map[power_string]

          if not power then
               if not skip_error_message then
                    self:error_message("trying to trigger a power that doesn't exist: " .. tostring(power_string))
               end
               return
          end

          local tier = self:get_power_tier(faction_key, power_string)

          if not tier then
               if not skip_error_message then
                    self:error_message("trying to trigger " ..
                    power_string .. " without unlocking it or having the legitimacy!")
               end
               return
          end

          return power, power.tiers[tier]
     end,
-- lycia modding
     trigger_power_cooldown = function(self, faction_key, power_string, tier_data)
          local faction_data = self:get_faction_data(faction_key)
          faction_data.cooldowns[power_string] = tier_data.cooldown
     end,

     can_trigger_corvee_labour = function(self, faction_key, skip_error_message)
          local faction_data = self.persistent.faction_data[faction_key]

          local send_error_message = (skip_error_message and function(msg) end) or
          function(msg) self:error_message(msg) end

          if not faction_data then
               send_error_message("trying to trigger corvee_labour on a non-existing faction: " .. tostring(faction_key))
               return false
          end

          local cooldown = faction_data.cooldowns[self.ids.corvee_labour] or 0

          if cooldown > 0 then
               send_error_message("trying to trigger corvee_labour when it's on cooldown: " .. tostring(cooldown))
               return false
          end

          local power, tier = self:trigger_power_helper(faction_key, self.ids.corvee_labour, skip_error_message)

          if not power or not tier then
               return false
          end

          return true, power, tier
     end,

     toggle_corvee_labour = function(self, faction_key)
          local faction = cm:get_faction(faction_key)

          if not faction then
               self:error_message("trying to toggle corvee labour on a non-existing faction: " .. tostring(faction_key))
               return
          end

          local success, power, tier = self:can_trigger_corvee_labour(faction_key)

          if not success then
               return
          end

          local corvee_labour_is_active = cm:get_bool_script_state(faction, self.shared_states.corvee_labour_active)

          if is_nil(corvee_labour_is_active) then
               corvee_labour_is_active = false
          end

          cm:set_script_state(faction, self.shared_states.corvee_labour_active, not corvee_labour_is_active)
     end,

     can_trigger_forced_annexation = function(self, faction_key, annexed_faction_key, skip_error_message)
          local faction_data = self.persistent.faction_data[faction_key]

          local send_error_message = (skip_error_message and function(msg) end) or
          function(msg) self:error_message(msg) end

          if not faction_data then
               send_error_message("trying to trigger forced annexation on a non-existing faction: " ..
               tostring(faction_key))
               return false
          end

          local cooldown = faction_data.cooldowns[self.ids.forced_annexation] or 0

          if cooldown > 0 then
               send_error_message("trying to trigger forced annexation when it's on cooldown: " .. tostring(cooldown))
               return false
          end

          if annexed_faction_key == "rebels" then
               send_error_message("trying to annex rebels????")
               return false
          end

          local annexed_faction = cm:get_faction(annexed_faction_key)

          if not annexed_faction then
               send_error_message("trying to annex a faction that doesn't exist: " .. tostring(annexed_faction_key))
               return false
          end

          if annexed_faction:is_dead() then
               send_error_message("trying to annex a dead faction: " .. tostring(annexed_faction_key))
               return false
          end

          if annexed_faction:is_human() then
               send_error_message("trying to annex a human faction: " .. tostring(annexed_faction_key))
               return false
          end

          local power, tier = self:trigger_power_helper(faction_key, self.ids.forced_annexation, skip_error_message)

          if not power or not tier then
               return false
          end

          local num_regions = annexed_faction:num_regions()

          if num_regions > tier.max_number_of_regions then
               send_error_message("trying to annex a faction that has too many regions: faction=" ..
               annexed_faction_key .. ", num_regions=" .. tostring(num_regions))
               return false
          end

          if num_regions < tier.min_number_of_regions then
               send_error_message("trying to annex a faction that has too few regions: faction=" ..
               annexed_faction_key .. ", num_regions=" .. tostring(num_regions))
               return false
          end

          return true, power, tier
     end,

     trigger_forced_annexation = function(self, faction_key, annexed_faction_key)
          local success, power, tier = self:can_trigger_forced_annexation(faction_key, annexed_faction_key)

          if not success then
               return
          end

          local tier_index = table_find(power.tiers, tier, true)

          self:trigger_power_cooldown(faction_key, self.ids.forced_annexation, tier)

          local annexed_faction = cm:get_faction(annexed_faction_key)
          local num_regions = annexed_faction:num_regions()
          local regions = annexed_faction:region_list()

          for i = 0, num_regions - 1 do
               local region = regions:item_at(i)
               local region_key = region:name()

               cm:transfer_region_to_faction(region_key, faction_key)
          end

          local armies = annexed_faction:military_force_list()
          local num_armies = armies:num_items()

          for i = 0, num_armies - 1 do
               local army = armies:item_at(i)
               local army_cqi = army:command_queue_index()
               cm:destroy_military_force(army_cqi)
          end

          local ui_config = self.ui_config.powers.forced_annexation
          cm:add_event_feed_event(
               "ruler_skill_annexation",
               faction_key,
               0,
               ui_config.tooltip_title_prefix .. tostring(tier_index),
               self:get_court_ruler_position_localisation_key(),
               "",
               annexed_faction:command_queue_index()
          )

          core:trigger_event("ScriptEventForceAnnexationUsed",
               { faction = cm:get_faction(faction_key), annexed_faction_key = annexed_faction_key })

          if faction_key == cm:get_local_faction_name(true) then
               cm:notify_crown_power_used(faction_key, self.ids.forced_annexation, self.political_states_system.config
               .id)
          end
     end,

     can_trigger_growth_migration = function(self, faction_key, region_key, skip_error_message)
          local power, tier = self:trigger_power_helper(faction_key, self.ids.growth_migration, skip_error_message)

          if not power or not tier then
               return false
          end

          local send_error_message = (skip_error_message and function(msg) end) or
          function(msg) self:error_message(msg) end
          local faction_data = self.persistent.faction_data[faction_key]

          if not faction_data then
               send_error_message("trying to trigger growth migration for a faction that has no powers data?: " ..
               tostring(faction_key))
               return false
          end

          local region = not is_nil(region_key) and cm:get_region(region_key)

          if not is_nil(region_key) and (not region or region:is_null_interface() or region:owning_faction():name() ~= faction_key) then
               send_error_message("trying to trigger growth migration with an invalid region key: " ..
               tostring(region_key))
               return false
          end

          local cooldown = faction_data.cooldowns[self.ids.growth_migration] or 0

          if cooldown > 0 then
               send_error_message("trying to trigger growth migration when cooldown is still in progress: cooldown=" ..
               tostring(cooldown))
               return false
          end

          return true, power, tier
     end,

     trigger_growth_migration = function(self, faction_key, region_key)
          local success, power, tier = self:can_trigger_growth_migration(faction_key, region_key)
          if not success then
               return
          end

          self:trigger_power_cooldown(faction_key, self.ids.growth_migration, tier)

          cm:add_development_points_to_region(region_key, tier.population_bonus)

          local faction = cm:get_faction(faction_key)
          cm:set_script_state(faction, self.shared_states.growth_migration_available, false)

          local faction_court = court.util_functions.get_faction_court_for_faction(faction_key)
          local court_position_key = self.court_position_name_key_prefix ..
          (faction_court and faction_court.config.ruler_position or "pharaoh")
          local tier_index = table_find(power.tiers, tier, true)
          local power_name_key = self.ui_config.powers.growth_migration.tooltip_title_prefix .. tier_index

          cm:show_message_event_ruler_skill_surplus(
               faction_key,
               power_name_key,
               court_position_key,
               region_key,
               tier.population_bonus
          )

          if faction_key == cm:get_local_faction_name(true) then
               cm:notify_crown_power_used(faction_key, self.ids.growth_migration, self.political_states_system.config.id)
          end
     end,

     can_trigger_raise_resources = function(self, faction_key, region_key, skip_error_message)
          local faction_data = self.persistent.faction_data[faction_key]

          local send_error_message = (skip_error_message and function(msg) end) or
          function(msg) self:error_message(msg) end

          if not faction_data then
               send_error_message("trying to trigger raise_resources on a non-existing faction: " ..
               tostring(faction_key))
               return false
          end

          local cooldown = faction_data.cooldowns[self.ids.raise_resources] or 0

          if cooldown > 0 then
               send_error_message("trying to trigger raise_resources when it's on cooldown: " .. tostring(cooldown))
               return false
          end

          local region = not is_nil(region_key) and cm:get_region(region_key)

          if not is_nil(region_key) and (not region or region:is_null_interface() or region:owning_faction():name() ~= faction_key) then
               send_error_message("trying to trigger raise_resources with an invalid region key: " ..
               tostring(region_key))
               return false
          end

          local power, tier = self:trigger_power_helper(faction_key, self.ids.raise_resources, skip_error_message)

          if not power or not tier then
               return false
          end

          return true, power, tier
     end,

     trigger_raise_resources = function(self, faction_key, region_key)
          local success, power, tier = self:can_trigger_raise_resources(faction_key, region_key)
          if not success then
               return
          end

          local tier_index = table_find(power.tiers, tier, true)

          self:trigger_power_cooldown(faction_key, self.ids.raise_resources, tier)

          local faction = cm:get_faction(faction_key)
          cm:set_script_state(faction, self.shared_states.raise_resources_available, false)

          local region = cm:get_region(region_key)

          local custom_bundle = cm:clone_or_create_custom_effect_bundle(faction_key, tier.effect_bundle_key)
          custom_bundle:set_duration(tier.duration)

          cm:apply_custom_effect_bundle_to_faction_province(custom_bundle, region)

          local ui_config = self.ui_config.powers.raise_resources
          local faction_leader = faction:faction_leader()
          cm:add_event_feed_event(
               "ruler_skill_food",
               faction:name(),
               0,
               ui_config.tooltip_title_prefix .. tostring(tier_index),
               self:get_court_ruler_position_localisation_key(),
               region:province_name(),
               faction_leader:command_queue_index()
          )

          if faction_key == cm:get_local_faction_name(true) then
               cm:notify_crown_power_used(faction_key, self.ids.raise_resources, self.political_states_system.config.id)
          end
     end,

     can_trigger_raise_armies = function(self, faction_key, character_cqi, skip_error_message)
          local faction_data = self.persistent.faction_data[faction_key]

          local send_error_message = (skip_error_message and function(msg) end) or
          function(msg) self:error_message(msg) end

          if not faction_data then
               send_error_message("trying to trigger raise_armies on a non-existing faction: " .. tostring(faction_key))
               return false
          end

          local cooldown = faction_data.cooldowns[self.ids.raise_armies] or 0

          if cooldown > 0 then
               send_error_message("trying to trigger raise_armies when it's on cooldown: " .. tostring(cooldown))
               return false
          end

          local character = not is_nil(character_cqi) and cm:get_character_by_cqi(character_cqi)

          if not is_nil(character_cqi) and (not character or character:is_null_interface() or character:faction():name() ~= faction_key) then
               send_error_message("trying to trigger raise_armies with an invalid character cqi: " ..
               tostring(character_cqi))
               return false
          end

          local power, tier = self:trigger_power_helper(faction_key, self.ids.raise_armies, skip_error_message)

          if not power or not tier then
               return false
          end

          return true, power, tier
     end,

     trigger_raise_armies = function(self, faction_key, character_cqi)
          local success, power, tier = self:can_trigger_raise_armies(faction_key, character_cqi)
          if not success then
               return
          end

          local tier_index = table_find(power.tiers, tier, true)

          self:trigger_power_cooldown(faction_key, self.ids.raise_armies, tier)

          local faction = cm:get_faction(faction_key)
          cm:set_script_state(faction, self.shared_states.raise_armies_available, false)

          cm:apply_effect_bundle_to_character(tier.effect_bundle_key, character_cqi, tier.duration)

          local ui_config = self.ui_config.powers.raise_armies
          cm:add_event_feed_event(
               "ruler_skill_armies",
               faction_key,
               0,
               ui_config.tooltip_title_prefix .. tostring(tier_index),
               self:get_court_ruler_position_localisation_key(),
               "",
               character_cqi
          )

          if faction_key == cm:get_local_faction_name(true) then
               cm:notify_crown_power_used(faction_key, self.ids.raise_armies, self.political_states_system.config.id)
          end
     end,

     can_trigger_foment_dissent = function(self, faction_key, region_key, skip_error_message)
          local faction_data = self.persistent.faction_data[faction_key]

          local send_error_message = (skip_error_message and function(msg) end) or
          function(msg) self:error_message(msg) end

          if not faction_data then
               send_error_message("trying to trigger foment_dissent on a non-existing faction: " .. tostring(faction_key))
               return false
          end

          local cooldown = faction_data.cooldowns[self.ids.foment_dissent] or 0

          if cooldown > 0 then
               send_error_message("trying to trigger foment_dissent when it's on cooldown: " .. tostring(cooldown))
               return false
          end

          local power, tier = self:trigger_power_helper(faction_key, self.ids.foment_dissent, skip_error_message)

          if not power or not tier then
               return false
          end

          if not is_nil(region_key) then
               local region = cm:get_region(region_key)

               if not region or region:is_null_interface() then
                    send_error_message("trying to trigger foment_dissent with an invalid region key: " ..
                    tostring(region_key))
                    return false
               end

               local province = region:province()
               local province_key = province:name()
               local adjacent_owned_regions = province:num_of_adjacent_regions_owned_by_faction(faction_key)
               local owned_regions_in_province = province:num_of_regions_owned_by_faction(faction_key)

               if adjacent_owned_regions == 0 then
                    send_error_message(
                    "trying to trigger foment_dissent on a province that has no adjacent regions owned by the faction: " ..
                    tostring(province_key))
                    return false
               end

               if owned_regions_in_province ~= 0 then
                    send_error_message(
                    "trying to trigger foment_dissent on a province that has regions owned by the faction: " ..
                    tostring(province_key))
                    return false
               end
          end

          return true, power, tier
     end,

     trigger_foment_dissent = function(self, faction_key, region_key)
          local success, power, tier = self:can_trigger_foment_dissent(faction_key, region_key)
          if not success then
               return
          end

          local tier_index = table_find(power.tiers, tier, true)

          self:trigger_power_cooldown(faction_key, self.ids.foment_dissent, tier)

          local faction = cm:get_faction(faction_key)
          local region = cm:get_region(region_key)
          local province = region:province()

          -- Determine the strength of the effect depending on the level of the power.
          local effect_strength = tier.base_effect_strength

          -- Prepare the custom effect bundle.
          local custom_bundle = cm:create_new_custom_effect_bundle(power.effect_bundle_key)
          custom_bundle:set_duration(tier.duration)
          custom_bundle:add_effect(power.effect_key, power.effect_scope, effect_strength)

          local province_regions = province:regions()

          -- We need to apply the custom effect bundle to all the faction province managers in the province but apply_custom_effect_bundle_to_faction_province
          -- needs a region (we don't have access to the faction province managers in the script). So we apply the custom effect bundle to all the regions
          -- and use the fact that any redundant applications of the bundle to the same faction province manager replace the previous ones.
          for i = 0, province_regions:num_items() - 1 do
               local region = province_regions:item_at(i)
               cm:apply_custom_effect_bundle_to_faction_province(custom_bundle, region)
          end

          -- TODO: Setup the "ruller_skill_foment_dissent" message event for the event feed.
          local ui_config = self.ui_config.powers.foment_dissent
          cm:add_event_feed_event(
               "ruler_skill_foment_dissent",
               faction_key,
               0,
               ui_config.tooltip_title_prefix .. tostring(tier_index),
               self:get_court_ruler_position_localisation_key(),
               region:province_name()
          )

          if faction_key == cm:get_local_faction_name(true) then
               cm:notify_crown_power_used(faction_key, self.ids.foment_dissent, self.political_states_system.config.id)

               local button_foment_dissent = core:get_ui_root():SequentialFind("button_foment_dissent")
               if button_foment_dissent then
                    self:get_ui_button_power_table_for_faction(faction_key, button_foment_dissent, "foment_dissent",
                         region_key)
               end
          end
     end,

     get_bribe_force_cost = function(self, faction_key, character_cqi)
          -- We expect faction_key and character_cqi to be valid and the power to have valid configuration data.
          -- The current formula is
          -- base_cost + sum of the converted costs of the units in the army * general_tier_multiplier * traits_multiplier
          local faction_data = self.persistent.faction_data[faction_key]
          local power, tier = self:trigger_power_helper(faction_key, self.ids.bribe_force, true)
          local character = cm:get_character_by_cqi(character_cqi)

          local military_force = character:military_force()
          local military_force_units = military_force:unit_list()
          local num_units = military_force_units:num_items()
          local total_converted_cost = 0

          for i = 0, num_units - 1 do
               local unit = military_force_units:item_at(i)
               local unit_cost = unit:get_recruitment_cost()
               local unit_key = unit:unit_key()
               for resource_key, resource_cost in pairs(unit_cost) do
                    total_converted_cost = total_converted_cost +
                    resource_cost * power.resource_multipliers[resource_key]
               end
          end

          total_converted_cost = total_converted_cost * tier.discount

          local general_tier_multiplier = 1 + character:rank() * power.general_tier_multiplier

          local traits_multiplier = 1

          for trait_key, multiplier in dpairs(power.trait_multipliers) do
               local trait_and_level = trait_key:split(":")
               if character:trait_level(trait_and_level[1]) >= tonumber(trait_and_level[2]) then
                    traits_multiplier = traits_multiplier * multiplier
               end
          end

          local faction_leader_multiplier = 1

          if character:is_faction_leader() then
               faction_leader_multiplier = power.faction_leader_cost_multiplier
          end

          local cost_mod = total_converted_cost * general_tier_multiplier * traits_multiplier * faction_leader_multiplier

          -- cost_mod is already negative but tier.base_cost from the power configuration is positive, so reverse its sign for the transaction.
          return -tier.base_cost + cost_mod
     end,

     get_bribe_force_cost_string = function(self, faction_key, character_cqi)
          local cost = self:get_bribe_force_cost(faction_key, character_cqi)
          local power, tier = self:trigger_power_helper(faction_key, self.ids.bribe_force, true)
          local cost_obj = cm:create_new_custom_resource_cost()

          cost_obj:add_resource_cost(power.cost_resource, power.cost_factor, cost)

          local faction = cm:get_faction(faction_key)
          local cost_string = cost_obj:to_string(faction, true)
          return cost_string
     end,

     can_trigger_bribe_force = function(self, faction_key, character_cqi, skip_error_message)
          local faction_data = self.persistent.faction_data[faction_key]

          local send_error_message = (skip_error_message and function(msg) end) or
          function(msg) self:error_message(msg) end

          if not faction_data then
               send_error_message("trying to get the cost of bribe_force for a faction that has no powers data: " ..
               tostring(faction_key))
               return false
          end

          local cooldown = faction_data.cooldowns[self.ids.bribe_force] or 0

          if cooldown > 0 then
               send_error_message("trying to trigger bribe_force when it's on cooldown: " .. tostring(cooldown))
               return false
          end

          local power, tier = self:trigger_power_helper(faction_key, self.ids.bribe_force, skip_error_message)

          if not power or not tier then
               return false
          end

          if not is_nil(character_cqi) then
               local character = cm:get_character_by_cqi(character_cqi)

               if not character or character:is_null_interface() or not character:has_military_force() or character:faction():name() == faction_key then
                    send_error_message("trying to trigger bribe_force with an invalid character cqi: " ..
                    tostring(character_cqi))
                    return false
               end

               local faction = cm:get_faction(faction_key)
               local character_faction = character:faction()
               if character_faction:is_null_interface() or not (character_faction:is_rebel() or character_faction:at_war_with(faction)) then
                    send_error_message(
                    "trying to trigger bribe_force with a character that is not an enemy of the faction: character_cqi=" ..
                    tostring(character_cqi))
                    return false
               end

               local cost = self:get_bribe_force_cost(faction_key, character_cqi)
               local available_resource = faction:pooled_resource(power.cost_resource):value()

               -- cost is already negative while available_resource is position, therefore comparison has to use -cost
               if available_resource < -cost then
                    send_error_message("trying to trigger bribe_force without enough resource: cost=" ..
                    tostring(cost) .. ", available_resource=" .. tostring(available_resource))
                    return false
               end
          end

          return true, power, tier
     end,

     trigger_bribe_force = function(self, faction_key, character_cqi)
          local success, power, tier = self:can_trigger_bribe_force(faction_key, character_cqi)
          if not success then
               return
          end

          local tier_index = table_find(power.tiers, tier, true)

          self:trigger_power_cooldown(faction_key, self.ids.bribe_force, tier)

          local faction = cm:get_faction(faction_key)
          local character = cm:get_character_by_cqi(character_cqi)
          local military_force = character:military_force()
          local military_force_cqi = military_force:command_queue_index()
          local cost = self:get_bribe_force_cost(faction_key, character_cqi)

          cm:destroy_military_force(military_force_cqi)

          -- Subtract the cost of the power from the faction's pooled resources.
          cm:faction_add_pooled_resource(faction_key, power.cost_resource, power.cost_factor, cost)

          -- TODO: Setup the "ruller_skill_bribe_force" message event for the event feed.
          local ui_config = self.ui_config.powers.bribe_force
          cm:add_event_feed_event(
               "ruler_skill_bribe_force",
               faction_key,
               0,
               ui_config.tooltip_title_prefix .. tostring(tier_index),
               self:get_court_ruler_position_localisation_key(),
               "",
               character_cqi
          )

          if faction_key == cm:get_local_faction_name(true) then
               cm:notify_crown_power_used(faction_key, self.ids.bribe_force, self.political_states_system.config.id)
          end
     end,

     can_trigger_power = function(self, faction_key, power_string, skip_error_message, param1)
          local power_func_table = {
               [self.ids.corvee_labour] = function() return self:can_trigger_corvee_labour(faction_key,
                         skip_error_message) end,
               [self.ids.forced_annexation] = function() return self:can_trigger_forced_annexation(faction_key, param1,
                         skip_error_message) end,
               [self.ids.growth_migration] = function() return self:can_trigger_growth_migration(faction_key, param1,
                         skip_error_message) end,
               [self.ids.raise_resources] = function() return self:can_trigger_raise_resources(faction_key, param1,
                         skip_error_message) end,
               [self.ids.raise_armies] = function() return self:can_trigger_raise_armies(faction_key, param1,
                         skip_error_message) end,
               [self.ids.foment_dissent] = function() return self:can_trigger_foment_dissent(faction_key, param1,
                         skip_error_message) end,
               [self.ids.bribe_force] = function() return self:can_trigger_bribe_force(faction_key, param1,
                         skip_error_message) end,
          }

          return not is_nil(power_func_table[power_string]) and power_func_table[power_string]()
     end,

     get_power_cost_string_for_target = function(self, faction_key, power_string, target)
          local power_func_table = {
               [self.ids.bribe_force] = function() return self:get_bribe_force_cost_string(faction_key, target) end,
          }

          return not is_nil(power_func_table[power_string]) and power_func_table[power_string]() or ""
     end,

     update_powers_statuses = function(self, faction_key)
          if self:power_available_to_mechanic(self.ids.court_positions) then
               self:update_court_positions(faction_key)
          end

          if self:power_available_to_mechanic(self.ids.corvee_labour) then
               self:update_corvee_labour_status(faction_key)
          end

          if self:power_available_to_mechanic(self.ids.growth_migration) then
               self:update_growth_migration_status(faction_key)
          end
     end,

     update_court_positions = function(self, faction_key)
          if not self.power_id_to_table_map[self.ids.court_positions]
              or not self.political_states_system:is_ruler(faction_key)
          then
               return
          end

          local faction_data = self:get_faction_data(faction_key)

          local tier = self:get_court_positions_tier(faction_key)

          local court_positions = 0

          if is_number(tier) and self.config.court_positions.tiers[tier] then
               court_positions = self.config.court_positions.tiers[tier].positions
          end

          if faction_data.court_positions ~= court_positions then
               faction_data.court_positions = court_positions
               local court_obj = self.get_relevant_court()
               court.court_functions.set_ruling_faction_allowed_positions(court_obj, court_positions)
          end
     end,

     -- returns how many positions the faction can hold at the same time
     -- limited by the self.ids.court_positions royal power
     get_max_court_positions_available = function(self, faction_key)
          if not self.power_id_to_table_map[self.ids.court_positions]
              or not self.political_states_system:is_ruler(faction_key)
          then
               return 1
          end

          local faction_data = self:get_faction_data(faction_key)
          local tier = self:get_court_positions_tier(faction_key)

          local court_positions = 1

          if is_number(tier) and self.config.court_positions.tiers[tier] then
               court_positions = self.config.court_positions.tiers[tier].positions
          end

          return court_positions
     end,

     update_corvee_labour_status = function(self, faction_key)
          local faction_data = self.persistent.faction_data[faction_key]
          local faction = cm:get_faction(faction_key)
          if faction_data
              and (faction_data.cooldowns[self.ids.corvee_labour] or 0) <= 0
              and self.political_states_system:is_ruler(faction_key)
              and self:get_corvee_labour_tier(faction_key)
              and self:can_trigger_corvee_labour(faction_key, true)
          then
               cm:set_script_state(faction, self.shared_states.corvee_labour_available, true)
          else
               cm:set_script_state(faction, self.shared_states.corvee_labour_available, false)
          end
     end,

     update_growth_migration_status = function(self, faction_key)
          local faction_data = self.persistent.faction_data[faction_key]
          local faction = cm:get_faction(faction_key)
          if faction_data
              and (faction_data.cooldowns[self.ids.growth_migration] or 0) <= 0
              and self.political_states_system:is_ruler(faction_key)
              and self:get_growth_migration_tier(faction_key)
              and self:can_trigger_growth_migration(faction_key, nil, true)
          then
               cm:set_script_state(faction, self.shared_states.growth_migration_available, true)
          else
               cm:set_script_state(faction, self.shared_states.growth_migration_available, false)
          end
     end,

     update_raise_resources_status = function(self, faction_key)
          local faction_data = self.persistent.faction_data[faction_key]
          local faction = cm:get_faction(faction_key)
          if faction_data
              and (faction_data.cooldowns[self.ids.raise_resources] or 0) <= 0
              and self.political_states_system:is_ruler(faction_key)
              and self:get_raise_resources_tier(faction_key)
              and self:can_trigger_raise_resources(faction_key, nil, true)
          then
               cm:set_script_state(faction, self.shared_states.raise_resources_available, true)
          else
               cm:set_script_state(faction, self.shared_states.raise_resources_available, false)
          end
     end,

     update_raise_armies_status = function(self, faction_key)
          local faction_data = self.persistent.faction_data[faction_key]
          local faction = cm:get_faction(faction_key)
          if faction_data
              and (faction_data.cooldowns[self.ids.raise_armies] or 0) <= 0
              and self.political_states_system:is_ruler(faction_key)
              and self:get_raise_armies_tier(faction_key)
              and self:can_trigger_raise_armies(faction_key, nil, true)
          then
               cm:set_script_state(faction, self.shared_states.raise_armies_available, true)
          else
               cm:set_script_state(faction, self.shared_states.raise_armies_available, false)
          end
     end,

     update_competency_points = function(self, faction_key)
          if not self.shared_states.competency_points then
               return
          end

          local faction_data = self.persistent.faction_data[faction_key]

          if not faction_data then
               return
          end

          local tier_num = self:get_competency_points_tier(faction_key)

          if not tier_num then
               return
          end

          local cooldown = faction_data.cooldowns[self.ids.competency_points] or 0

          if cooldown > 0 then
               return
          end

          local tier = self.config.competency_points.tiers[tier_num]
          local faction = cm:get_faction(faction_key)
          local current_competency_points = cm:get_float_script_state(faction, self.shared_states.competency_points)
          local added_points = tier.num_points
          current_competency_points = current_competency_points + added_points
          cm:set_script_state(faction, self.shared_states.competency_points, current_competency_points)

          cm:show_message_event_ruler_skill_competencies(
               faction_key,
               self.ui_config.powers.competency_points.tooltip_title_prefix .. tier_num,
               added_points
          )

          faction_data.cooldowns[self.ids.competency_points] = tier.cooldown
     end,

     update_foment_dissent_status = function(self, faction_key)
          local faction_data = self.persistent.faction_data[faction_key]
          local faction = cm:get_faction(faction_key)
          if faction_data
              and (faction_data.cooldowns[self.ids.foment_dissent] or 0) <= 0
              and self.political_states_system:is_ruler(faction_key)
              and self:get_power_tier(faction_key, self.ids.foment_dissent)
              and self:can_trigger_foment_dissent(faction_key, nil, true)
          then
               cm:set_script_state(faction, self.shared_states.foment_dissent_available, true)
          else
               cm:set_script_state(faction, self.shared_states.foment_dissent_available, false)
          end
     end,

     update_bribe_force_status = function(self, faction_key)
          local faction_data = self.persistent.faction_data[faction_key]
          local faction = cm:get_faction(faction_key)
          if faction_data
              and (faction_data.cooldowns[self.ids.bribe_force] or 0) <= 0
              and self.political_states_system:is_ruler(faction_key)
              and self:get_power_tier(faction_key, self.ids.bribe_force)
              and self:can_trigger_bribe_force(faction_key, nil, true)
          then
               cm:set_script_state(faction, self.shared_states.bribe_force_available, true)
          else
               cm:set_script_state(faction, self.shared_states.bribe_force_available, false)
          end
     end,

     check_for_new_power_event_message = function(self, faction_key, amount_of_new_legitimacy)
          if not self:can_faction_use_powers(faction_key) then
               return
          end

          local legitimacy = self.legitimacy_system:get_legitimacy(faction_key)
          local old_legitimacy = legitimacy - amount_of_new_legitimacy

          local faction_data = self.persistent.faction_data[faction_key]

          if not faction_data then
               return
          end

          local tier_unlocks = faction_data.tier_unlocks

          for tier, legitimacy_requirement in ipairs(self.config.tier_legitimacy_requirement) do
               if #tier_unlocks[tier] < self.config.max_powers_per_tier[tier]
                   and old_legitimacy < legitimacy_requirement
                   and legitimacy >= legitimacy_requirement
               then
                    local faction_leader = cm:get_faction(faction_key):faction_leader()
                    local region = faction_leader and not faction_leader:is_null_interface() and faction_leader:region()

                    if not region or region:is_null_interface() then
                         return
                    end

                    cm:add_event_feed_event(
                         "ruler_powers_available",
                         faction_key,
                         0
                    )
                    return
               end
          end
     end,

     on_first_tick = function(self, context)
          return true
     end,

     setup_power_id_to_table_map = function(self)
          self.power_id_to_table_map = {}

          for _, id in pairs(self.ids) do
               self.power_id_to_table_map[id] = self.config[id]
          end
     end,

     on_loading_game = function(self, context)
          if self.persistent.enable_all_royal_powers then
               self:enable_all_royal_powers()
          else
               self:setup_power_id_to_table_map()
          end

          for power, data in pairs(self.ui_config.powers) do
               data.config = self.config[power]
               data.power_string = power
          end

          if not self.persistent.faction_data then
               self.persistent.faction_data = {}
          end
     end,

     has_faction_new_power_available = function(self, faction_key)
          if not self:can_faction_use_powers(faction_key) then
               return false
          end

          local faction_data = self.persistent.faction_data[faction_key]
          if not faction_data then
               return false
          end

          local tier_unlocks = faction_data.tier_unlocks
          local legitimacy = self.legitimacy_system:get_legitimacy(faction_key)

          for tier, legitimacy_requirement in ipairs(self.config.tier_legitimacy_requirement) do
               if #tier_unlocks[tier] < self.config.max_powers_per_tier[tier] and legitimacy >= legitimacy_requirement then
                    return true
               end
          end

          return false
     end,

     can_faction_use_powers = function(self, faction_key)
          local is_sitting_ruler = self.political_states_system:is_sitting_ruler(faction_key)
          local only_sitting_ruler_has_powers = self.config.only_sitting_ruler_has_access_to_powers
          local is_ruler = self.political_states_system:is_ruler(faction_key)

          local can_use_powers = (is_sitting_ruler
               or (not only_sitting_ruler_has_powers and is_ruler))
          return can_use_powers
     end,

     setup_power_tooltip = function(self, uic, power_string, tier, param1)
          local power_data = self.ui_config.powers[power_string]

          if not power_data then
               self:error_message("Trying to set the tooltip of an unknown power " .. tostring(power_string))
               return
          end

          local tier_string = tostring(tier)
          local faction_key = cm:get_local_faction_name(true)
          local faction_data = self.persistent.faction_data[faction_key]
          local current_cooldown = (faction_data and faction_data.cooldowns[power_data.power_string]) or 0
          local cost = param1 and self:get_power_cost_string_for_target(faction_key, power_string, param1) or ""

          local tooltip_data = {
               title = common.get_localised_string(power_data.tooltip_title_prefix .. tier_string),
               icon_path = power_data.icon_path,
               text = common.get_localised_string(power_data.tooltip_info_key_prefix .. tier_string),
               tier_string = common.get_localised_string(self.ui_config.tooltip_tier_string_prefix .. tier_string),
               effect = common.get_localised_string(power_data.tooltip_tier_effect_prefix .. tier_string),
               flavour = common.get_localised_string(power_data.tooltip_flavour_prefix .. tier_string),
               cooldown = tostring(power_data.config.tiers[tier].cooldown or 0),
               current_cooldown = tostring(current_cooldown),
               power_type = self.config.power_type,
               cost = cost,
          }

          local script_id = self.ui_config.script_id_prefix .. power_string .. tier_string

          uic:SetProperty("script_id", script_id)

          common.set_context_value(script_id, tooltip_data)
     end,

     setup_power_tier_slot = function(self, faction_key, uic, tier, index)
          if (self:num_unlocked_powers(faction_key) == 0
                   and not self:can_faction_use_powers(faction_key))
              or self.config.tier_legitimacy_requirement[tier] > self.legitimacy_system:get_legitimacy(faction_key)
          then
               uic:SetState("inactive")
               return
          end

          local select_power_button = uic:SequentialFind("select_tier_btn")
          local assigned_power_uic = uic:SequentialFind("assigned_power_holder")

          if not select_power_button or not assigned_power_uic then
               self:error_message("select_power_button or assigned_power_holder missing for a tier_slot!")
               return
          end

          if self:can_faction_use_powers(faction_key) then
               uic:SetState("active")
               select_power_button:SetState("active")
               assigned_power_uic:SetState("active")
          else
               uic:SetState("inactive")
               select_power_button:SetState("inactive")
               assigned_power_uic:SetState("inactive")
          end

          local unlocked_powers = self:get_unlocked_powers_for_tier(faction_key, tier) or {}

          local power_string = (index <= #unlocked_powers and unlocked_powers[index]) or nil

          if not power_string then
               if select_power_button then
                    local select_power_data = {
                         tier = tier,
                         index = index,
                    }
                    local script_id = self.ui_config.script_id_prefix ..
                    "select_power_button_" .. tostring(tier) .. tostring(index)

                    select_power_button:SetProperty("script_id", script_id)
                    common.set_context_value(script_id, select_power_data)

                    select_power_button:SetVisible(true)
                    assigned_power_uic:SetVisible(false)
               end
               return
          end

          local power_data = self.ui_config.powers[power_string]

          if not power_data then
               self:error_message("Trying to set the tooltip of an unknown power " .. tostring(power_string))
               return
          end

          local power_ui_data = {
               power_string = power_string,
               icon_path = power_data.icon_path,
               tier = tier,
               power_type = self.config.power_type,
          }

          local script_id = self.ui_config.script_id_prefix ..
          "assigned_power_icon_" .. power_string .. tostring(tier) .. tostring(index)

          assigned_power_uic:SetProperty("script_id", script_id)

          common.set_context_value(script_id, power_ui_data)

          assigned_power_uic:SetVisible(true)
          select_power_button:SetVisible(false)
     end,

     get_ui_power_table_for_faction = function(self, faction_key, uic, tier)
          local powers_list = {}

          for power_string, ui_power_data in pairs(self.ui_config.powers) do
               local current_power_tier = self:get_power_tier(faction_key, power_string)
               if (current_power_tier or 0) < tier then
                    local power_table = {
                         would_upgrade = not is_nil(current_power_tier),
                         power_string = power_string,
                         tier = tier,
                         icon_path = ui_power_data.icon_path,
                         title = common.get_localised_string(ui_power_data.tooltip_title_prefix .. tostring(tier)),
                    }
                    table.insert(powers_list, power_table)
               end
          end

          local script_id = self.ui_config.script_id_prefix .. "select_power_list_" .. tostring(tier)

          uic:SetProperty("script_id", script_id)

          common.set_context_value(script_id, powers_list)
     end,

     get_ui_button_power_table_for_faction = function(self, faction_key, uic, power_string, param1, tier_if_not_available --[[opt=max_tier]])
          if not is_number(tier_if_not_available) then
               tier_if_not_available = self.power_id_to_table_map and self.power_id_to_table_map[power_string] and
               self.power_id_to_table_map[power_string].tiers and #self.power_id_to_table_map[power_string].tiers or 4
          end

          local current_power_tier = self:get_power_tier(faction_key, power_string)
          local is_available = current_power_tier and self:can_trigger_power(faction_key, power_string, true, param1)
          local faction_data = self.persistent.faction_data[faction_key]
          local current_cooldown = (faction_data and faction_data.cooldowns[power_string]) or 0
          local power_table = {
               power_string = power_string,
               tier = current_power_tier or tier_if_not_available,
               is_available = to_bool(is_available),
               current_cooldown = tostring(current_cooldown),
               param1 = param1,
          }

          local script_id = self.ui_config.script_id_prefix .. "power_ui_button_data_" .. tostring(power_string)

          if uic then
               uic:SetProperty("script_id", script_id)
          end

          common.set_context_value(script_id, power_table)
     end,

     -- This function is meant for the pharaohs_crown_powers.twui.xml file
     setup_powers_locked_tooltip = function(self, uic, tier)
          local powers_list = uic:SequentialFind("powers_buttons_holder")

          if not powers_list then
               return
          end

          local power_template = powers_list:SequentialFind("template_power")

          if not power_template then
               return
          end

          power_template:SetVisible(false)

          -- Sometimes the event is called multiple times so we clean up everything in the list that is not a template
          local i = 0
          while powers_list:ChildCount() > 1 do
               local child = powers_list:Find(i)
               if child ~= power_template:Address() then
                    child = UIComponent(child)
                    child:Destroy()
                    i = 0
               else
                    i = i + 1
               end
          end

          -- Create a power UIC for each power in the list
          for _, power_data in pairs(self.ui_config.powers) do
               local power_uic = powers_list:CreateFromComponent(power_template:Address(), power_data.power_string)
               power_uic = UIComponent(power_uic)

               power_uic:SetVisible(true)
               power_uic:SetImagePath(power_data.icon_path)

               local script_id = "pharaoh_power_locked_tooltip_holder" .. power_data.power_string .. tier

               common.set_context_value(script_id,
                    { power_string = power_data.power_string, power_tier = tier, power_type = self.ui_config.power_type })
               power_uic:SetProperty("script_id", script_id)
          end
     end,

     id = crown.id,

     notify_mechanics = crown.notify_mechanics,

     send_message_event_to_paths_including = crown.send_message_event_to_paths_including,

     send_message_event_to_paths_excluding = crown.send_message_event_to_paths_excluding,

     error_message = crown.error_message,
}
