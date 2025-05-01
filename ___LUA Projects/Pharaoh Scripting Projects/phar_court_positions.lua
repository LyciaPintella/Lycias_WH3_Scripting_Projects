out("Loading phar_court_positions.lua")

-- main file phar.court.lua

-- this holds requests used by more than one position
court.common_requests =
{
     -- Strongarm - sets the success chance of one of your Threaten Plots to 100%
     strongarm =
     {
          request_name = "Strongarm",

          ui_config =
          {
               name_localization_key = "random_localisation_strings_string_phar_main_court_request_name_strongarm",
               icon_path = "ui\\skins\\default\\court\\intrigue_icons\\icon_court_intrigue_threaten.png",
               effect_description_localization_key =
               "random_localisation_strings_string_phar_main_court_request_effect_strongarm",
               cant_call_reason_no_threaten_localization_key =
               "random_localisation_strings_string_phar_main_court_request_name_strongarm_cant_call_no_threaten",
          },

          -- returns bool for success and, if false, the reason request can't be used
          can_use_request = function(self, faction_court, position_obj, faction_key)
               local result = ""
               local threaten_plots = self:get_suitable_plots(faction_court, position_obj, faction_key)
               if #threaten_plots == 0 then
                    result = court.util_functions.append_as_red_bullet_point(result,
                         get_localised_random_string(self.ui_config.cant_call_reason_no_threaten_localization_key))
               end

               if result == "" then
                    return true, ""
               end

               return false, result
          end,

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               local localized_info = common.get_localised_string(self.ui_config.effect_description_localization_key)
               return localized_info
          end,

          -- possibly we should choose the threaten plot to use this on
          -- this depends on UI and design. in that case - use get_plot_persistent_data directly
          call_request = function(self, faction_court, position_obj, faction_key)
               court.output(faction_key ..
               " used small request '" .. self.request_name .. "' with " .. position_obj.name .. "!")
               local threaten_plot_persistent_data = self:get_random_plot(faction_court, position_obj, faction_key)
               if not threaten_plot_persistent_data then
                    return false
               end
               threaten_plot_persistent_data.court_leader_support = true
               return true
          end,

          get_random_plot = function(self, faction_court, position_obj, faction_key)
               local threaten_plots = self:get_suitable_plots(faction_court, position_obj, faction_key)
               if #threaten_plots == 0 then
                    return nil
               end

               local rand_index = cm:model():random_int(1, #threaten_plots);
               local random_plot = threaten_plots[rand_index]
               return random_plot
          end,

          get_suitable_plots = function(self, faction_court, position_obj, faction_key)
               local suitable_plots = {}
               for plot_resolve_turn, plots_by_resolve_turn in dpairs(faction_court.persistent.plots_persistent_data_by_resolve_turn) do
                    local threaten_plots = plots_by_resolve_turn["threaten"]
                    if threaten_plots then
                         for _, plot_persistent_data in ipairs(threaten_plots) do
                              if faction_key == plot_persistent_data.plotting_faction then
                                   table.insert(suitable_plots, plot_persistent_data)
                              end
                         end
                    end
               end

               return suitable_plots
          end,
     },

     -- Servants - improve all of your active Plots by 2 Levels each
     servants =
     {
          request_name = "Servants",

          request_config =
          {
               plots_level_increment = 2,
          },

          ui_config =
          {
               name_localization_key = "random_localisation_strings_string_phar_main_court_request_name_servants",
               icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_hire_natives.png",
               effect_description_localization_key =
               "random_localisation_strings_string_phar_main_court_request_effect_servants",
               cant_call_no_plots_to_improve_localization_key =
               "random_localisation_strings_string_phar_main_court_request_servants_cant_call",
          },

          -- returns bool for success and, if false, the reason request can't be used
          can_use_request = function(self, faction_court, position_obj, faction_key)
               local result = ""
               local plots_to_improve = self:get_plots_to_improve(faction_court, position_obj, faction_key)
               if #plots_to_improve == 0 then
                    -- we could just return the result since it is a single check, but I want it consistent, and ready to easily copy-paste if another check appears
                    result = court.util_functions.append_as_red_bullet_point(result,
                         get_localised_random_string(self.ui_config.cant_call_no_plots_to_improve_localization_key))
               end
               if result == "" then
                    return true, ""
               end

               return false, result
          end,

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               local localized_info = common.get_localised_string(self.ui_config.effect_description_localization_key)
               return localized_info
          end,

          call_request = function(self, faction_court, position_obj, faction_key)
               local is_request_accessibile = self:can_use_request(faction_court, position_obj, faction_key)
               if not is_request_accessibile then
                    return nil
               end

               court.output(faction_key .. " used request '" .. self.request_name .. "' with " .. position_obj.name ..
               ";")
               local plots_to_improve = self:get_plots_to_improve(faction_court, position_obj, faction_key)

               local max_plot_level = court.plot_functions:get_plot_max_level(faction_key)
               for _, plot_persistent_data in ipairs(plots_to_improve) do
                    local new_level = plot_persistent_data.plot_level + self.request_config.plots_level_increment
                    if new_level > max_plot_level then
                         new_level = max_plot_level
                    end
                    plot_persistent_data.plot_level = new_level
               end
               return true
          end,

          get_plots_to_improve = function(self, faction_court, position_obj, faction_key)
               local plots_to_improve = {}

               local max_plot_level = court.plot_functions:get_plot_max_level(faction_key)
               for plot_resolve_turn, plots_by_resolve_turn in dpairs(faction_court.persistent.plots_persistent_data_by_resolve_turn) do
                    for _, plots_by_key in dpairs(plots_by_resolve_turn) do
                         for _, plot_persistent_data in ipairs(plots_by_key) do
                              -- we check if the plot can be improved, and belongs to the faction doing the request
                              -- I need to ask design if we should increase plots against the faction being requested
                              if plot_persistent_data.plot_level < max_plot_level
                                  and plot_persistent_data.plotting_faction == faction_key
                              then
                                   table.insert(plots_to_improve, plot_persistent_data)
                              end
                         end
                    end
               end
               return plots_to_improve
          end,
     },

     -- Request Elites - gives the units set up by the position config - used by variations of the First Commander
     -- uses common function from court.unit_request_functions but with a different config from request_kushites
     request_elites =
     {
          request_name = "Request Elites",

          ui_config =
          {
               name_localization_key = "ui_text_replacements_localised_text_phar_main_court_commander_request_2_title",
               icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_request_elites.png",
               effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_map_court_general_elite_request_desc",
               court_leader_cant_call_localization_key = "phar_main_court_request_elites_cant_call",
          },

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               return court.unit_request_functions.get_effect_info(self, faction_court, position_obj, faction_key)
          end,

          -- returns bool for success and, if false, the reason request can't be used
          can_use_request = function(self, faction_court, position_obj, faction_key)
               return court.unit_request_functions.can_use_request(self, faction_court, position_obj, faction_key)
          end,

          call_request = function(self, faction_court, position_obj, faction_key)
               return court.unit_request_functions.call_request(self, faction_court, position_obj, faction_key)
          end,
     },

     -- Hire Kushites - gives the units set up by the position config - used by viceroy of Kush
     -- uses common function from court.unit_request_functions but with a different config from request_elites
     request_kushites =
     {
          request_name = "Hire Kushites",

          ui_config =
          {
               name_localization_key = "ui_text_replacements_localised_text_phar_main_court_viceroy_kush_request_1_title",
               icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_hire_kushites.png",
               effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_main_court_viceroy_kush_request_1_desc",                           -- WARNING: this record has no parameterization % in the db
          },

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               return court.unit_request_functions.get_effect_info(self, faction_court, position_obj, faction_key)
          end,

          -- returns bool for success and, if false, the reason request can't be used
          can_use_request = function(self, faction_court, position_obj, faction_key)
               return court.unit_request_functions.can_use_request(self, faction_court, position_obj, faction_key)
          end,

          call_request = function(self, faction_court, position_obj, faction_key)
               return court.unit_request_functions.call_request(self, faction_court, position_obj, faction_key)
          end,
     },

     -- "Army Wages"
     army_discounts =
     {
          request_name = "Army Wages",
          -- marking that the request influences discounts, so should open the UI to choose
          influence_discounts = true,

          ui_config =
          {
               name_localization_key = "ui_text_replacements_localised_text_phar_main_court_commander_request_1_title",
               icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_influence_discounts.png",
               effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_main_court_commander_request_1_desc",
               cant_call_position_localization_key = "phar_main_court_request_army_wages_cant_call_position",
               cant_call_invalid_range_localization_key = "phar_main_court_request_army_wages_cant_call_invalid_range",
          },

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               return court.influence_discounts_functions.get_effect_info(self, faction_court, position_obj, faction_key)
          end,

          -- returns bool for success and, if false, the reason request can't be used
          can_use_request = function(self, faction_court, position_obj, faction_key, chosen_category_index)
               return court.influence_discounts_functions.can_use_request(self, faction_court, position_obj, faction_key)
          end,

          call_request = function(self, faction_court, position_obj, faction_key, categories)
               return court.influence_discounts_functions.call_request(self, faction_court, position_obj, faction_key,
                    categories)
          end,
     },

     -- "Influence Discounts"
     building_discounts =
     {
          request_name = "Influence Discounts",
          -- marking that the request influences discounts, so should open the UI to choose
          influence_discounts = true,

          ui_config =
          {
               name_localization_key = "ui_text_replacements_localised_text_phar_main_court_treasurer_request_1_title",
               icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_learn_discounts.png",
               effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_main_court_treasurer_request_1_desc",
          },

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               return court.influence_discounts_functions.get_effect_info(self, faction_court, position_obj, faction_key)
          end,

          -- returns bool for success and, if false, the reason request can't be used
          can_use_request = function(self, faction_court, position_obj, faction_key, chosen_category_index)
               return court.influence_discounts_functions.can_use_request(self, faction_court, position_obj, faction_key)
          end,

          call_request = function(self, faction_court, position_obj, faction_key, categories)
               return court.influence_discounts_functions.call_request(self, faction_court, position_obj, faction_key,
                    categories)
          end,
     },

     battle_heralds =
     {
          request_name = "Battle Heralds",

          ui_config =
          {
               name_localization_key = "ui_text_replacements_localised_text_phar_map_court_lawagetas_request_1_title",
               icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_battle_heralds.png",
               effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_map_court_lawagetas_request_1_desc",
          },

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               local localized_info = common.get_localised_string(self.ui_config.effect_description_localization_key)
               return localized_info
          end,

          call_request = function(self, faction_court, position_obj, faction_key)
               -- Battle Heralds - each army provides own influence on the province it is.

               court.output(faction_key ..
               " used request '" ..
               self.request_name ..
               "' with " ..
               position_obj.name ..
               "- it should be entirely impolemented via bonuses in faction_court.config.available_positions[position_obj.name].request_bonus_packs[2]")

               return true
          end,
     },

     warrior_gifts =
     {
          request_name = "Warrior Gifts",

          ui_config =
          {
               name_localization_key = "ui_text_replacements_localised_text_phar_map_court_lawagetas_request_2_title",
               icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_warrior_gifts.png",
               effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_map_court_lawagetas_request_2_desc",
          },

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               local localized_info = common.get_localised_string(self.ui_config.effect_description_localization_key)
               return localized_info
          end,

          call_request = function(self, faction_court, position_obj, faction_key)
               -- Warrior Gifts - the bodyguards of each army gain battle speed and melee attack.

               court.output(faction_key ..
               " used request '" ..
               self.request_name ..
               "' with " ..
               position_obj.name ..
               "- it should be entirely impolemented via bonuses in faction_court.config.available_positions[position_obj.name].request_bonus_packs[2]")

               return true
          end,
     },

     embezzle_request =
     {
          request_name = "Embezzle Request",

          ui_config =
          {
               name_localization_key = "ui_text_replacements_localised_text_phar_main_court_treasurer_request_2_title",
               icon_path = "ui\\skins\\default\\court\\intrigue_icons\\icon_court_intrigue_bribe.png",
               effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_main_court_treasurer_request_2_desc",
               cant_use_shemsu_hor_localization_key = "phar_main_court_plot_not_accessible_shemsu_hor",
          },

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               local localized_info = common.get_localised_string(self.ui_config.effect_description_localization_key)
               return localized_info
          end,

          -- returns bool for success and, if false, the reason request can't be used
          can_use_request = function(self, faction_court, position_obj, faction_key, chosen_category_index)
               local result = ""
               -- no need to check if Shemsu Hor system is active - if it is disabled it is never Shemsu Hor
               if shemsu_hor.is_shemsu_hor() then
                    local text, _ = get_localised_text_replacement_and_source(self.ui_config
                    .cant_use_shemsu_hor_localization_key)
                    result = court.util_functions.append_as_red_bullet_point(result, text)
               end

               if result == "" then
                    return true, ""
               end

               return false, result
          end,

          call_request = function(self, faction_court, position_obj, faction_key)
               -- Embezzle - gain a free use of Embezzle until end of turn;
               court.output(faction_key .. " used small request 'Learn Discounts' with " .. position_obj.name)

               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
               faction_table.has_embezzle_request = true
               return true
          end,
     },

     assassinate_request =
     {
          -- Assassinate - gain a free use of Assassinate plot  until end of turn
          request_name = "assassinate_request",

          ui_config =
          {
               name_localization_key = "ui_text_replacements_localised_text_phar_main_court_vizier_request_2_title",
               icon_path = "ui\\skins\\default\\court\\intrigue_icons\\icon_court_intrigue_conspire.png",
               effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_main_court_vizier_request_2_desc",
               pschent_crown_effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_main_court_vizier_request_2_desc_pschent",
               cant_use_shemsu_hor_localization_key = "phar_main_court_plot_not_accessible_shemsu_hor",
          },

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               local localized_info = common.get_localised_string(self.ui_config.effect_description_localization_key)
               if court.util_functions.is_pschent_crown_equipped(faction_court) then
                    localized_info = common.get_localised_string(self.ui_config
                    .pschent_crown_effect_description_localization_key)
               end

               return localized_info
          end,

          -- returns bool for success and, if false, the reason request can't be used
          can_use_request = function(self, faction_court, position_obj, faction_key, chosen_category_index)
               local result = ""
               -- no need to check if Shemsu Hor system is active - if it is disabled it is never Shemsu Hor
               if shemsu_hor.is_shemsu_hor() then
                    local text, _ = get_localised_text_replacement_and_source(self.ui_config
                    .cant_use_shemsu_hor_localization_key)
                    result = court.util_functions.append_as_red_bullet_point(result, text)
               end

               if result == "" then
                    return true, ""
               end

               return false, result
          end,

          call_request = function(self, faction_court, position_obj, faction_key)
               court.output(faction_key .. " used request '" .. self.request_name .. "' with " .. position_obj.name ..
               ";")
               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
               faction_table.has_assassinate_request = true
               return true
          end,
     },

     cease_request =
     {
          request_name = "cease_request",

          ui_config =
          {
               name_localization_key =
               "ui_text_replacements_localised_text_phar_main_court_chief_bodyguards_request_1_title",
               icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_protection.png",
               effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_main_court_chief_bodyguards_request_1_desc",                           -- WARNING: this record has no parameterization % in the db
          },

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               local localized_info = common.get_localised_string(self.ui_config.effect_description_localization_key)
               return localized_info
          end,

          call_request = function(self, faction_court, position_obj, faction_key)
               -- (60) Cease - gain a free use of Cease until end of turn;

               court.output(faction_key .. " used request '" .. self.request_name .. "' with " .. position_obj.name ..
               ";")

               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
               faction_table.has_cease_request = true
               return true
          end,
     },

     -- Connections - gain 3 court actions until end of turn (4 with pschent crown)
     connections =
     {
          request_name = "Connections",

          ui_config =
          {
               name_localization_key = "ui_text_replacements_localised_text_phar_main_court_vizier_request_1_title",
               icon_path = "ui\\skins\\default\\court\\intrigue_icons\\icon_court_intrigue_scheme.png",
               effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_main_court_vizier_request_1_desc",
               pschent_crown_effect_description_localization_key =
               "ui_text_replacements_localised_text_phar_main_court_vizier_request_1_desc_pschent",
          },

          get_effect_info = function(self, faction_court, position_obj, faction_key)
               local localized_info = nil
               if court.util_functions.is_pschent_crown_equipped(faction_court) then
                    localized_info = common.get_localised_string(self.ui_config
                    .pschent_crown_effect_description_localization_key)
               else
                    localized_info = common.get_localised_string(self.ui_config.effect_description_localization_key)
               end

               return localized_info
          end,

          call_request = function(self, faction_court, position_obj, faction_key)
               court.output(faction_key .. " used request '" .. self.request_name .. "' with " .. position_obj.name ..
               ".")
               local result = position_obj:give_court_actions(faction_key, faction_court)
               return result
          end,
     },
}

court.common_abilities =
{
     give_court_actions_ability =
     {
          -- returns bool for success and, if false, the reason the action can't be used
          can_call_ability = function(self, position_obj, faction_court)
               local error_message = ""

               local has_pending_dilemma = court.util_functions.is_dilemma_active()
               if has_pending_dilemma then
                    local localized_error, _ = get_localised_random_string_and_source(court.ui.config.localization_keys
                    .dilemma_is_active)
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_error)
               end

               local faction_key = position_obj.persistent.current_holder_faction

               local cooldown_remaining = self.get_ability_cooldown_remaining(position_obj, faction_key)
               if cooldown_remaining > 0 then
                    local cooldown_remaining_str = tostring(cooldown_remaining)
                    local formatter_text, _ = get_localised_text_replacement_and_source_safe_formatted(
                    court.ui.config.localization_keys.cooldown_ends_X_turns, cooldown_remaining_str)
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, formatter_text)
               end

               if error_message == "" then
                    return true
               end

               return false, error_message
          end,

          get_ability_cooldown_remaining = function(position_obj, faction_key)
               local cooldown_end_turn = court.position_functions.get_position_mark_value(position_obj,
                    position_obj.persistent.current_holder_faction, "give_court_actions_ability", "cooldown_end_turn")
               if not is_number(cooldown_end_turn) then
                    return 0
               end

               local current_turn = cm:model():turn_number()
               if current_turn >= cooldown_end_turn then
                    return 0
               end

               local cooldown_remaining = cooldown_end_turn - current_turn
               return cooldown_remaining
          end,

          get_effect_info = function(position_obj, faction_court)
               local position_loc_key = court.position_functions.get_position_name_localization_key(position_obj,
                    faction_court)
               local position_display_name = common.get_localised_string(position_loc_key)

               local num_actions_gained = position_obj:get_num_court_actions_provided(faction_court)
               local localized_message_text, localized_message_source = get_localised_random_string_and_source_formatted(
               court.ui.config.localization_keys.give_court_actions_effect_info, position_display_name,
                    tostring(num_actions_gained))

               return localized_message_text, localized_message_source
          end,

          call_ability = function(self, position_obj, faction_court)
               local is_action_accessibile, error_message = self:can_call_ability(position_obj, faction_court)
               if not is_action_accessibile then
                    court.output("Error: give_court_actions.call_ability called, but it is inaccessible due to '" ..
                    error_message .. "'")
                    return false
               end

               local faction_key = position_obj.persistent.current_holder_faction

               local cooldown = position_obj.position_config.give_actions_cooldown
               local cooldown_end_turn = cooldown + cm:model():turn_number()
               court.position_functions.mark_position_with_value(position_obj, cooldown_end_turn,
                    position_obj.persistent.current_holder_faction, "give_court_actions_ability", "cooldown_end_turn")

               position_obj:give_court_actions(faction_key, faction_court)
          end,
     },
}

-- a list of all possible potisions all courts could have. The courts are populated by these
court.position_templates =
{
     -- NOTE:
     -- the persistent field of all factions is in the form of:
     --persistent = {
     --	current_holder = [target_character_lookup], -- where target_character_lookup is by family_member_cqi
     --	current_holder_family_member_CQI = [family_member_cqi],
     --	current_holder_faction = [faction_key],
     --	regard = { [faction_key] = number, ...},
     -- 	-- NOTE: shemsu_hor_marks are cleared at Shemsu Hor!!
     -- 	-- plots are resolved
     --	plot_levels = { [faction_key] = { [plot_key] = number, ...}, ...},
     --	-- NOTE: 'shemsu_hor_marks' can contain arbitrary tables that signify actions taken this shemsu_hor, and should not be done again. filled by mark_position and cleared at Shemsu Hor
     --	shemsu_hor_marks
     --},

     --pharaoh - egyptian court leader
     {
          name = "pharaoh",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_pharaoh",
          description_localization_key = "ui_text_replacements_localised_text_phar_main_court_pharaoh_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_main_court_commander_description_1",
               "ui_text_replacements_localised_text_phar_main_court_pharaoh_description_1",
               "ui_text_replacements_localised_text_phar_main_court_pharaoh_description_2",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_pharaoh.png",
          help_page_key = "help_crown_court_egyptian_positions",

          position_config =
          {
               -- should be a resource record
               court_actions_towards_pos_extra_cost = 100,
               plots_immunity = { "threaten", },
               intrigue_immunity = { "assist", },
               -- you can't claim this position from the court, it is controlled through the political states
               claim_forbidden = true,
               -- you can't quit this position from the court, it is controlled through the political states
               quit_forbidden = true,
               legitimacy_provided = 20,

               position_units =
               {
                    {
                         unit_key = "phar_main_pharaoh_elite_pharaoh_guard",
                         amount = 1,
                    },
                    {
                         unit_key = "phar_main_pharaoh_elite_royal_khopesh_guards",
                         amount = 2,
                    },
                    {
                         unit_key = "phar_main_pharaoh_elite_braves_of_the_king",
                         amount = 1,
                    },
                    {
                         unit_key = "phar_main_pharaoh_elite_royal_chariot_companions",
                         amount = 2,
                    },
                    {
                         unit_key = "phar_main_pharaoh_elite_royal_archers",
                         amount = 2,
                    },
               },

               position_units_pschent =
               {
                    {
                         unit_key = "phar_main_pharaoh_elite_pharaoh_guard",
                         amount = 2,
                    },
                    {
                         unit_key = "phar_main_pharaoh_elite_royal_khopesh_guards",
                         amount = 2,
                    },
                    {
                         unit_key = "phar_main_pharaoh_elite_braves_of_the_king",
                         amount = 2,
                    },
                    {
                         unit_key = "phar_main_pharaoh_elite_royal_chariot_companions",
                         amount = 2,
                    },
                    {
                         unit_key = "phar_main_pharaoh_elite_royal_archers",
                         amount = 2,
                    },
               },
          },

          persistent = {
          },

          trigger_visit_corvee_labor = function(self, faction_key, visited_region_obj)
               court.position_functions.instantly_finish_building_constructions_on_region(visited_region_obj,
                    self.position_config.visit_params.max_building_level,
                    self.position_config.visit_params.visit_ers)
          end,

          requests =
          {
               court.common_requests.strongarm,
               court.common_requests.servants,
          },
          -----------
          -- INTERNAL - meant to be called only from inside this table
     },

     --high_king - hittite court leader
     {
          name = "high_king",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_great_king",
          description_localization_key = "ui_text_replacements_localised_text_phar_main_court_great_king_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_main_court_commander_description_1",
               "ui_text_replacements_localised_text_phar_main_court_pharaoh_description_1",
               "ui_text_replacements_localised_text_phar_main_court_pharaoh_description_2",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_great_king_of_hatti.png",
          help_page_key = "help_crown_court_hittite_positions",

          position_config =
          {
               -- should be a resource record
               court_actions_towards_pos_extra_cost = 100,
               plots_immunity = { "threaten", },
               intrigue_immunity = { "assist", },
               -- you can't claim this position from the court, it is controlled through the political states
               claim_forbidden = true,
               -- you can't quit this position from the court, it is controlled through the political states
               quit_forbidden = true,
               legitimacy_provided = 20,

               -- units given to the faction holding the position
               position_units =
               {
                    {
                         unit_key = "phar_main_great_king_elite_royal_hittite_chariots",
                         amount = 2,
                    },
                    {
                         unit_key = "phar_main_great_king_elite_royal_hittite_chargers",
                         amount = 2,
                    },
                    {
                         unit_key = "phar_main_great_king_elite_golden_spearmen",
                         amount = 1,
                    },
                    {
                         unit_key = "phar_main_great_king_elite_mesedi",
                         amount = 2,
                    },
               },
          },

          persistent = {
          },

          trigger_visit_corvee_labor = function(self, faction_key, visited_region_obj)
               court.position_functions.instantly_finish_building_constructions_on_region(visited_region_obj,
                    self.position_config.visit_params.max_building_level,
                    self.position_config.visit_params.visit_ers)
          end,

          requests =
          {
               court.common_requests.strongarm,
               court.common_requests.servants,
          },

          -----------
          -- INTERNAL - meant to be called only from inside this table
     },

     --wanax - aegean court leader
     {
          name = "wanax",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_wanax",
          description_localization_key = "ui_text_replacements_localised_text_phar_map_court_aegea_wanax_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_aegea_wanax_description_1",
               "ui_text_replacements_localised_text_phar_map_court_aegea_wanax_description_2",
               "ui_text_replacements_localised_text_phar_map_court_aegea_wanax_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_wanax.png",
          help_page_key = "help_crown_court_aegean_positions",

          position_config =
          {
               -- should be a resource record
               court_actions_towards_pos_extra_cost = 100,
               plots_immunity = { "threaten", },
               intrigue_immunity = { "assist", },
               -- you can't claim this position from the court, it is controlled through the political states
               claim_forbidden = true,
               -- you can't quit this position from the court, it is controlled through the political states
               quit_forbidden = true,
               legitimacy_provided = 20,

               -- units given to the faction holding the position
               position_units =
               {
                    {
                         unit_key = "phar_map_achaean_elite_temple_warriors",
                         amount = 1,
                    },
                    {
                         unit_key = "phar_map_achaean_elite_stalker_skirmishers",
                         amount = 1,
                    },
                    {
                         unit_key = "phar_map_achaean_elite_myrmidon_swordsmen",
                         amount = 1,
                    },
                    {
                         unit_key = "phar_map_wilusan_elite_champions_of_troy",
                         amount = 1,
                    },
                    {
                         unit_key = "phar_map_wilusan_elite_trojan_nobles",
                         amount = 1,
                    },
                    {
                         unit_key = "phar_map_wilusan_elite_dardanian_defenders",
                         amount = 1,
                    },
               },
          },

          persistent = {
          },

          requests =
          {
               court.common_requests.strongarm,
               court.common_requests.servants,
          },

          -----------
          -- INTERNAL - meant to be called only from inside this table
     },

     --king_of_universe - mesopotamian court leader
     {
          name = "king_of_universe",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_king_of_universe",
          description_localization_key =
          "ui_text_replacements_localised_text_phar_map_court_meso_king_of_universe_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_universe_description_1",
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_universe_description_2",
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_universe_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_king_of_universe.png",
          help_page_key = "help_crown_court_mesopotamian_positions",

          position_config =
          {
               -- should be a resource record
               court_actions_towards_pos_extra_cost = 100,
               plots_immunity = { "threaten", },
               intrigue_immunity = { "assist", },
               -- you can't claim this position from the court, it is controlled through the political states
               claim_forbidden = true,
               -- you can't quit this position from the court, it is controlled through the political states
               quit_forbidden = true,
               legitimacy_provided = 30,

               -- units given to the faction holding the position
               position_units =
               {
                    {

                         unit_key = "phar_map_meso_elite_royal_marya",
                         amount = 1,
                    },
               },

               request_bonus_packs =
               {
                    {
                         unit_key = "phar_map_meso_elite_royal_marya",
                         amount = 1,
                    },
               },
          },

          persistent = {
          },

          trigger_visit_corvee_labor = function(self, faction_key, visited_region_obj)
               court.position_functions.instantly_finish_building_constructions_on_region(visited_region_obj,
                    self.position_config.visit_params.max_building_level,
                    self.position_config.visit_params.visit_ers)
          end,

          requests =
          {
               court.common_requests.servants,
               court.common_requests.request_elites,
          },

          -----------
          -- INTERNAL - meant to be called only from inside this table
     },

     --vizier/tuhkanti
     {
          name = "vizier",
          alt_name = "tuhkanti",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_vizier",
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_vizier.png",
          description_localization_key = "ui_text_replacements_localised_text_phar_main_court_vizier_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_main_court_vizier_description_1",
               "ui_text_replacements_localised_text_phar_main_court_vizier_description_2",
          },
          help_page_key = "help_crown_court_egyptian_positions_vizier",

          position_config =
          {
               -- by current design visit is strictly for the egyptian Vizier,
               visit_params =
               {
                    max_building_level = 5,
                    visit_ers = false,
               },

               -- vizier can use the assassinate plot
               -- factions can also gain one-time use of the plot from a request (asking the vizier to assassinate someone on their behalf)
               -- but it doesn't make sense they can use it against the vizier
               plots_immunity = { "assassinate", },
               legitimacy_provided = 14,

               court_actions_gained = 3,
               -- when the pschent_crown is equipped the effect is stronger
               court_actions_gained_pschent = 4,

               give_actions_cooldown = 6,
               give_actions_cooldown_pschent = 3,
          },

          persistent = {
          },

          trigger_visit_corvee_labor = function(self, faction_key, visited_region_obj)
               court.position_functions.instantly_finish_building_constructions_on_region(visited_region_obj,
                    self.position_config.visit_params.max_building_level,
                    self.position_config.visit_params.visit_ers)
          end,

          -- a position-specific court ability
          -- as a court action the Vizier can gain three Court Actions until end of turn
          give_court_actions_ability = court.common_abilities.give_court_actions_ability,

          get_num_court_actions_provided = function(self, faction_court)
               local actions_gained = self.position_config.court_actions_gained
               -- if pschent crown is equipped - it changes the effect of the request
               if court.util_functions.is_pschent_crown_equipped(faction_court) then
                    actions_gained = self.position_config.court_actions_gained_pschent
               end

               return actions_gained
          end,

          -- can be called by the vizier using the court ability, or another faction with a request
          give_court_actions = function(self, faction_key, faction_court)
               local actions_gained = self:get_num_court_actions_provided(faction_court)
               court.util_functions.add_court_extra_actions_for_faction(faction_key, actions_gained)
               return true
          end,

          requests =
          {
               court.common_requests.connections,
               court.common_requests.assassinate_request,
          },

          -----------
          -- INTERNAL - meant to be called only from inside this table
     },

     --first_commander/high_commander
     {
          name = "first_commander",
          alt_name = "high_commander",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_first_commander",
          description_localization_key =
          "ui_text_replacements_localised_text_phar_main_court_first_commander_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_main_court_commander_description_1",
               "ui_text_replacements_localised_text_phar_main_court_commander_description_2",
               "ui_text_replacements_localised_text_phar_main_court_commander_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_first_commander.png",
          help_page_key = "help_crown_court_egyptian_positions_first_commander",

          -- these are related to showing the ability buttons to see and/or change the discounts
          ability_tooltip_discounts_show = "phar_main_court_show_discounts_commander_tooltip", -- ui_text_replacements
          ability_title_discounts_show = "phar_main_court_see_commander_discounts",    -- ui_text_replacements
          ability_title_discounts_set = "phar_main_court_apply_commander_discounts",   -- ui_text_replacements

          position_config =
          {
               shemsu_hor_possible_effects =
               {
                    -- phar_main_cost_mod_unit_sets_court_axes
                    {
                         effect_id = "phar_main_cost_mod_unit_sets_court_axes",
                         effect_display_name = "ui_text_replacements_localised_text_phar_main_court_axes_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_main_cost_mod_unit_sets_court_clubs
                    {
                         effect_id = "phar_main_cost_mod_unit_sets_court_clubs",
                         effect_display_name = "ui_text_replacements_localised_text_phar_main_court_clubs_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_main_cost_mod_unit_sets_court_khopesh_sword
                    {
                         effect_id = "phar_main_cost_mod_unit_sets_court_khopesh_sword",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_khopesh_sword_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_main_cost_mod_unit_sets_court_spear
                    {
                         effect_id = "phar_main_cost_mod_unit_sets_court_spear",
                         effect_display_name = "ui_text_replacements_localised_text_phar_main_court_spear_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_main_cost_mod_unit_sets_court_bows
                    {
                         effect_id = "phar_main_cost_mod_unit_sets_court_bows",
                         effect_display_name = "ui_text_replacements_localised_text_phar_main_court_bows_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_main_cost_mod_unit_sets_court_javelins_slings
                    {
                         effect_id = "phar_main_cost_mod_unit_sets_court_javelins_slings",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_javelins_slings_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_main_cost_mod_unit_sets_chariots_all
                    {
                         effect_id = "phar_main_cost_mod_unit_sets_chariots_all",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_chariots_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
               },

               max_discount = 25,
               discount_sum = 50,   -- this should NOT be used directly, only via get_discounts_sum due to bonuses and effects
               num_categories_to_influence = 1, -- this should NOT be used directly, only via get_number_of_categories_to_influence due to bonuses and effects
               discount_increment = 5,
               large_request_fixed_amount = 25,
               -- the sum of these should match 'discount_sum'
               shemsu_hor_initial_discounts = { 25, 25 },
               -- chosen by the AI at random
               ai_sets =
               {
                    { 25, 25 },
                    { 0,  0, 25, 25 },
                    { 0,  0, 0,  0, 25, 25 },
               },

               ai_sets_pschent =
               {
                    { 25, 25, 25, 25 },
                    { 0,  0,  25, 25, 25, 25 },
                    { 25, 25, 0,  0,  25, 25 },
               },

               legitimacy_provided = 7,
               -- the court leader should have the same elite mercenary units available,
               -- the units should not stack if they hold both positions
               do_not_provide_mercenary_units_to_court_leader = true,

          },

          persistent = {
          },

          requests =
          {
               court.common_requests.request_elites,
               court.common_requests.army_discounts,
          },
     },

     --mycenian_heqetas - a variant of the first_commander/high_commander
     {
          name = "mycenian_heqetas",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_mycenian_heqetas",
          description_localization_key =
          "ui_text_replacements_localised_text_phar_map_court_aegea_mycenian_heqetas_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_aegea_mycenian_heqetas_description_1",
               "ui_text_replacements_localised_text_phar_map_court_aegea_mycenian_heqetas_description_2",
               "ui_text_replacements_localised_text_phar_map_court_aegea_mycenian_heqetas_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_heqetas_mycenae.png",
          help_page_key = "help_crown_court_aegean_positions_mycenian_heqetas",

          -- these are related to showing the ability buttons to see and/or change the discounts
          ability_tooltip_discounts_show = "phar_main_court_show_discounts_commander_tooltip", -- ui_text_replacements
          ability_title_discounts_show = "phar_main_court_see_commander_discounts",    -- ui_text_replacements
          ability_title_discounts_set = "phar_main_court_apply_commander_discounts",   -- ui_text_replacements

          position_config =
          {
               shemsu_hor_possible_effects =
               {
                    -- phar_main_cost_mod_unit_sets_court_axes
                    {
                         effect_id = "phar_main_cost_mod_unit_sets_court_axes",
                         effect_display_name = "ui_text_replacements_localised_text_phar_main_court_axes_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_main_cost_mod_unit_sets_court_spear
                    {
                         effect_id = "phar_main_cost_mod_unit_sets_court_spear",
                         effect_display_name = "ui_text_replacements_localised_text_phar_main_court_spear_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_map_cost_mod_unit_sets_court_javelins
                    {
                         effect_id = "phar_map_cost_mod_unit_sets_court_javelins",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_map_court_javelins_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_map_cost_mod_unit_sets_court_melee_chariots
                    {
                         effect_id = "phar_map_cost_mod_unit_sets_court_melee_chariots",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_map_court_melee_chariots_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
               },

               max_discount = 25,
               discount_sum = 50,   -- this should NOT be used directly, only via get_discounts_sum due to bonuses and effects
               num_categories_to_influence = 1, -- this should NOT be used directly, only via get_number_of_categories_to_influence due to bonuses and effects
               discount_increment = 5,
               large_request_fixed_amount = 25,
               -- the sum of these should match 'discount_sum'
               shemsu_hor_initial_discounts = { 0, 0, 0, 0 },
               -- chosen by the AI at random
               ai_sets =
               {
                    { 25, 25 },
                    { 0,  0, 25, 25 },
               },
               legitimacy_provided = 7,
               -- the court leader should have the same elite mercenary units available,
               -- the units should not stack if they hold both positions
               do_not_provide_mercenary_units_to_court_leader = true,

          },

          persistent = {
          },

          requests =
          {
               court.common_requests.request_elites,
               court.common_requests.army_discounts,
          },
     },

     --anatolian_heqetas - a variant of the first_commander/high_commander
     {
          name = "anatolian_heqetas",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_anatolian_heqetas",
          description_localization_key =
          "ui_text_replacements_localised_text_phar_map_court_aegea_anatolian_heqetas_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_aegea_anatolian_heqetas_description_1",
               "ui_text_replacements_localised_text_phar_map_court_aegea_anatolian_heqetas_description_2",
               "ui_text_replacements_localised_text_phar_map_court_aegea_anatolian_heqetas_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_heqetas_anatolia.png",
          help_page_key = "help_crown_court_aegean_positions_anatolian_heqetas",

          -- these are related to showing the ability buttons to see and/or change the discounts
          ability_tooltip_discounts_show = "phar_main_court_show_discounts_commander_tooltip", -- ui_text_replacements
          ability_title_discounts_show = "phar_main_court_see_commander_discounts",    -- ui_text_replacements
          ability_title_discounts_set = "phar_main_court_apply_commander_discounts",   -- ui_text_replacements

          position_config =
          {
               shemsu_hor_possible_effects =
               {
                    -- phar_map_cost_mod_unit_sets_court_swords_clubs
                    {
                         effect_id = "phar_map_cost_mod_unit_sets_court_swords_clubs",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_map_court_swords_clubs_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_main_cost_mod_unit_sets_court_bows
                    {
                         effect_id = "phar_main_cost_mod_unit_sets_court_bows",
                         effect_display_name = "ui_text_replacements_localised_text_phar_main_court_bows_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_map_cost_mod_unit_sets_court_slings
                    {
                         effect_id = "phar_map_cost_mod_unit_sets_court_slings",
                         effect_display_name = "ui_text_replacements_localised_text_phar_map_court_slings_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
                    -- phar_map_cost_mod_unit_sets_court_ranged_chariots
                    {
                         effect_id = "phar_map_cost_mod_unit_sets_court_ranged_chariots",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_map_court_ranged_chariots_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_unit_discount_title",
                    },
               },

               max_discount = 25,
               discount_sum = 50,   -- this should NOT be used directly, only via get_discounts_sum due to bonuses and effects
               num_categories_to_influence = 1, -- this should NOT be used directly, only via get_number_of_categories_to_influence due to bonuses and effects
               discount_increment = 5,
               large_request_fixed_amount = 25,
               -- the sum of these should match 'discount_sum'
               shemsu_hor_initial_discounts = { 0, 0, 0, 0 },
               -- chosen by the AI at random
               ai_sets =
               {
                    { 25, 25 },
                    { 0,  0, 25, 25 },
               },
               legitimacy_provided = 7,
               -- the court leader should have the same elite mercenary units available,
               -- the units should not stack if they hold both positions
               do_not_provide_mercenary_units_to_court_leader = true,

          },

          persistent = {
          },

          requests =
          {
               court.common_requests.request_elites,
               court.common_requests.army_discounts,
          },
     },

     --royal_treasurer/lawgiver
     {
          name = "royal_treasurer",
          alt_name = "lawgiver",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_royal_treasurer",
          description_localization_key = "ui_text_replacements_localised_text_phar_main_court_treasurer_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_main_court_treasurer_description_1",
               "ui_text_replacements_localised_text_phar_main_court_treasurer_description_2",
               "ui_text_replacements_localised_text_phar_main_court_treasurer_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_royal_treasurer.png",
          help_page_key = "help_crown_court_egyptian_positions_treasurer",
          ability_tooltip_discounts_show = "phar_main_court_show_discounts_treasurer_tooltip", -- ui_text_replacements
          ability_title_discounts_show = "phar_main_court_see_treasurer_discounts",    -- ui_text_replacements
          ability_title_discounts_set = "phar_main_court_apply_treasurer_discounts",   -- ui_text_replacements

          position_config =
          {
               shemsu_hor_possible_effects =
               {
                    -- Administartion & Admin ERS
                    {
                         effect_id = "phar_main_mod_cost_municipal_complex_admin_ers",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_municipal_complex_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
                    --Province Management
                    {
                         effect_id = "phar_main_mod_cost_province_management",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_province_management_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
                    --Recruitment
                    {
                         effect_id = "phar_main_mod_cost_military_recruit",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_military_recruit_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
                    --Military Support & Military ERS
                    {
                         effect_id = "phar_main_mod_cost_military_support_military_ers",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_military_support_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
                    --Production Management & Economic ERS
                    {
                         effect_id = "phar_main_mod_cost_production_management_economic_ers",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_production_management_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
                    --Resource Production
                    {
                         effect_id = "phar_main_mod_cost_building_sets_resource_production",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_resource_production_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
               },

               max_discount = 25,
               discount_sum = 50,   -- this should NOT be used directly, only via get_discounts_sum due to bonuses and effects
               num_categories_to_influence = 1, -- this should NOT be used directly, only via get_number_of_categories_to_influence due to bonuses and effects
               discount_increment = 5,
               large_request_fixed_amount = 25,
               -- the sum of these should match 'discount_sum'
               shemsu_hor_initial_discounts = { 25, 25 },
               -- chosen by the AI at random
               ai_sets =
               {
                    { 25, 25 },
                    { 0,  0, 25, 25 },
                    { 0,  0, 0,  0, 25, 25 },
               },

               ai_sets_pschent =
               {
                    { 25, 25, 25, 25 },
                    { 0,  0,  25, 25, 25, 25 },
                    { 25, 25, 0,  0,  25, 25 },
               },

               -- treasurer can use the embezzle plot
               -- factions can also gain one-time use of the plot from a request (asking the treasurer to embezzle someone on their behalf)
               -- but it doesn't make sense they can use it against the treasurer
               plots_immunity = { "embezzle", },
               legitimacy_provided = 14,
          },

          persistent = {
          },

          requests =
          {
               court.common_requests.embezzle_request,
               court.common_requests.building_discounts,
          },
     },

     --high_priest_of_amun
     {
          name = "high_priest_of_amun",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_high_priest_of_amun",
          description_localization_key = "ui_text_replacements_localised_text_phar_main_court_priest_amun_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_main_court_priest_amun_description_1",
               "ui_text_replacements_localised_text_phar_main_court_priest_amun_description_2",
               "ui_text_replacements_localised_text_phar_main_court_priest_amun_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_high_priest.png",
          help_page_key = "help_crown_court_egyptian_positions_high_priest_of_amun",

          position_config =
          {
               gods_favour_bonus = 10,
               main_god_additional_favour = 10,
               legitimacy_provided = 14,
          },

          persistent = {
          },

          on_position_gained = function(self, faction_court, character_obj)
               -- add gods_favour_bonus to all currently worshipped gods
               local local_faction = character_obj:faction()
               local faction_key = local_faction:name()

               if not deities.persistent[faction_key] then
                    court.output("Warning: no deities found for faction " .. faction_key)
                    return
               end

               local favour_multiplier = 1
               if court.util_functions.is_pschent_crown_equipped(faction_court) then
                    favour_multiplier = court.config.pschent_crown_effect_multiplier
               end

               local god_slots = deities.get_god_slots(faction_key)
               for i = 1, deities.get_faction_god_slots_count(faction_key) do
                    if god_slots[i].god_key then
                         local god_key = god_slots[i].god_key
                         local favour_gained = self:god_favour_bonus(god_key, faction_court) * favour_multiplier
                         deities.grant_favour(faction_key, god_key, favour_gained, "court")
                    end
               end
          end,

          on_position_lost = function(self, faction_court, character_obj)
               -- remove gods_favour_bonus to all currently worshipped gods
               local local_faction = character_obj:faction()
               local faction_key = local_faction:name()

               if not deities.persistent[faction_key] then
                    court.output("Warning: no deities found for faction " .. faction_key)
                    return
               end

               local favour_multiplier = 1
               if court.util_functions.is_pschent_crown_equipped(faction_court) then
                    favour_multiplier = court.config.pschent_crown_effect_multiplier
               end

               local god_slots = deities.get_god_slots(faction_key)
               for i = 1, deities.get_faction_god_slots_count(faction_key) do
                    if god_slots[i].god_key then
                         local god_key = god_slots[i].god_key
                         local favour_lost = self:god_favour_bonus(god_key, faction_court) * favour_multiplier
                         deities.grant_favour(faction_key, god_key, -favour_lost, "court")
                    end
               end
          end,

          requests =
          {
               {
                    request_name = "Cost of Worship",

                    ui_config =
                    {
                         name_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_priest_request_1_title",
                         icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_cost_of_worship.png",
                         effect_description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_priest_request_1_desc",                   -- WARNING: this record has no parameterization % in the db
                    },

                    get_effect_info = function(self, faction_court, position_obj, faction_key)
                         local localized_info = common.get_localised_string(self.ui_config
                         .effect_description_localization_key)
                         return localized_info
                    end,

                    call_request = function(self, faction_court, position_obj, faction_key)
                         -- Cost of Worship - learn what changes the Lawgiver will make on Shemsu Hor;
                         court.output(faction_key ..
                         " used request '" ..
                         self.request_name ..
                         "' with " ..
                         position_obj.name ..
                         " - it should be entirely impolemented via bonuses in faction_court.config.available_positions[position_obj.name].request_bonus_packs[1]")
                         return true
                    end,
               },
               {
                    request_name = "Piety",

                    ui_config =
                    {
                         name_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_priest_request_2_title",
                         icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_piety.png",
                         effect_description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_priest_request_2_desc",
                         cant_call_no_deities_found_localization_key = "phar_main_court_request_piety_cant_call_faction",
                    },

                    get_effect_info = function(self, faction_court, position_obj, faction_key)
                         local localized_info = common.get_localised_string(self.ui_config
                         .effect_description_localization_key)
                         local parametrized_info = string.format(localized_info,
                              position_obj.position_config.gods_favour_bonus)
                         return parametrized_info
                    end,

                    -- returns bool for success and, if false, the reason request can't be used
                    can_use_request = function(self, faction_court, position_obj, faction_key)
                         local result = ""
                         if not deities.persistent[faction_key] then
                              local localized_faction_name = common.get_localised_string("factions_screen_name_" ..
                              faction_key)
                              local localized_text, _ = get_localised_text_replacement_and_source_formatted(
                              self.ui_config.cant_call_no_deities_found_localization_key, localized_faction_name)
                              -- we could just return the result since it is a single check, but I want it consistent, and ready to easily copy-paste if another check appears
                              result = court.util_functions.append_as_red_bullet_point(result, localized_text)
                         end

                         if result == "" then
                              return true, ""
                         end

                         return false, result
                    end,

                    call_request = function(self, faction_court, position_obj, faction_key)
                         -- Piety - Gain temporary favour with all gods you worship until Shemsu Hor;
                         local is_request_accessibile = self:can_use_request(faction_court, position_obj, faction_key)
                         if not is_request_accessibile then
                              return nil
                         end

                         court.output(faction_key ..
                         " used request '" .. self.request_name .. "' with " .. position_obj.name .. ";")

                         local faction_table = court.util_functions.get_faction_persistent_data(faction_key)

                         local favour_multiplier = 1
                         if court.util_functions.is_pschent_crown_equipped(faction_court) then
                              favour_multiplier = court.config.pschent_crown_effect_multiplier
                         end

                         local current_turn = cm:model():turn_number()
                         local remove_at_turn = current_turn + court.config.non_shemsu_hor_request_cooldown
                         local god_slots = deities.get_god_slots(faction_key)
                         for i = 1, deities.get_faction_god_slots_count(faction_key) do
                              if god_slots[i].god_key then
                                   local god_key = god_slots[i].god_key
                                   local favor_gain = position_obj.position_config.gods_favour_bonus * favour_multiplier
                                   court.favour_functions.add_temporary_favour(faction_table, god_key, favor_gain,
                                        remove_at_turn)
                              end
                         end

                         return true
                    end,
               },
          },

          on_new_god_worshipped = function(self, faction_court, new_god_key, old_god_key)
               if old_god_key then
                    local favour_lost = self:god_favour_bonus(old_god_key, faction_court)
                    if court.util_functions.is_pschent_crown_equipped(faction_court) then
                         favour_lost = favour_lost * court.config.pschent_crown_effect_multiplier
                    end
                    deities.grant_favour(self.persistent.current_holder_faction, old_god_key, -favour_lost, "court")
               end

               if new_god_key then
                    local favour_gained = self:god_favour_bonus(new_god_key, faction_court)
                    if court.util_functions.is_pschent_crown_equipped(faction_court) then
                         favour_gained = favour_gained * court.config.pschent_crown_effect_multiplier
                    end
                    deities.grant_favour(self.persistent.current_holder_faction, new_god_key, favour_gained, "court")
               end
          end,

          on_aten_created = function(self, aten_key, faction_court)
               if aten_key then
                    local favour_gained = self:god_favour_bonus(aten_key, faction_court)
                    local court_obj = court.util_functions.get_faction_court_for_faction(self.persistent
                    .current_holder_faction)
                    if not court_obj then
                         return
                    end
                    if court.util_functions.is_pschent_crown_equipped(court_obj) then
                         favour_gained = favour_gained * court.config.pschent_crown_effect_multiplier
                    end
                    deities.grant_favour(self.persistent.current_holder_faction, aten_key, favour_gained, "court")
               end
          end,

          on_crown_state_changed = function(self, phar_court, crown_equipped)
               -- we are only interested in this if the position is filled
               local holder_faction = self.persistent.current_holder_faction
               if not holder_faction
                   or holder_faction == "" then
                    return
               end

               local pschent_favour_multiplier = court.config.pschent_crown_effect_multiplier

               local god_slots = deities.get_god_slots(holder_faction)
               for i = 1, deities.get_faction_god_slots_count(holder_faction) do
                    if god_slots[i].god_key then
                         local god_key = god_slots[i].god_key
                         local standard_favour = self:god_favour_bonus(god_key, phar_court)
                         local crown_favor = standard_favour * pschent_favour_multiplier

                         if crown_equipped then
                              -- if we just switched from standard to the crown favor
                              -- therefore we gained the crown_favor and lost the standard one
                              local favor_change = crown_favor - standard_favour
                              deities.grant_favour(holder_faction, god_key, favor_change, "court")
                         else
                              -- if we just switched from crown to standard favor
                              -- therefore we gained the standard favor and lost crown_favor
                              local favor_change = standard_favour - crown_favor
                              deities.grant_favour(holder_faction, god_key, favor_change, "court")
                         end
                    end
               end
          end,
          -------------------
          -- internal methods
          god_favour_bonus = function(self, god_key, faction_court)
               local favour_bonus = self.position_config.gods_favour_bonus
               local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, self)
               if court_specific_config and is_string(court_specific_config.main_god_key) then
                    local main_god_key = court_specific_config.main_god_key
                    if god_key == main_god_key then
                         favour_bonus = favour_bonus + self.position_config.main_god_additional_favour
                    end
               end

               return favour_bonus
          end,
     },

     --viceroy_of_kush
     {
          name = "viceroy_of_kush",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_viceroy_of_kush",
          description_localization_key = "ui_text_replacements_localised_text_phar_main_court_viceroy_kush_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_main_court_viceroy_kush_description_1",
               "ui_text_replacements_localised_text_phar_main_court_viceroy_kush_description_2",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_viceroy_of_kush.png",
          help_page_key = "help_crown_court_egyptian_positions_viceroy_of_kush",

          position_config =
          {
               large_request_gold_provided = 200,
               -- placeholder value
               kush_region_name = "kush",
               legitimacy_provided = 7,
          },

          persistent = {
          },

          on_round_start = function(self, faction_court)
               if not self.persistent.current_holder then
                    return
               end

               local faction_has_unlocked_court = feature_unlock.is_feature_unlocked_for_faction(
               self.persistent.current_holder_faction, feature_ids_config.court)
               if not faction_has_unlocked_court then
                    return
               end
          end,

          requests =
          {
               court.common_requests.request_kushites,
               --Reap the Mines
               {
                    request_name = "Reap the Mines",

                    ui_config =
                    {
                         name_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_viceroy_kush_request_2_title",
                         icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_reap_the_mines.png",
                         effect_description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_viceroy_kush_request_2_desc",
                         -- using the exact same key by design
                         pschent_crown_effect_description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_viceroy_kush_request_2_desc",
                    },

                    get_effect_info = function(self, faction_court, position_obj, faction_key)
                         local localized_info = common.get_localised_string(self.ui_config
                         .effect_description_localization_key)
                         if court.util_functions.is_pschent_crown_equipped(faction_court) then
                              localized_info = common.get_localised_string(self.ui_config
                              .pschent_crown_effect_description_localization_key)
                         end

                         local gold_provided = self:get_gold_provided(faction_court, position_obj)
                         local parametrized_info = string.format(localized_info, gold_provided)
                         return parametrized_info
                    end,

                    call_request = function(self, faction_court, position_obj, faction_key)
                         -- Reap the Mines - gain a flat amount Gold. Usable once per Shemsu Hor;

                         court.output(faction_key ..
                         " used request '" .. self.request_name .. "' with " .. position_obj.name .. ";")

                         local gold_provided = self:get_gold_provided(faction_court, position_obj)
                         cm:faction_add_pooled_resource(faction_key, "troy_gold", court.config.court_resource_factor,
                              gold_provided)
                         return true
                    end,

                    get_gold_provided = function(self, faction_court, position_obj)
                         local gold_provided = position_obj.position_config.large_request_gold_provided
                         if court.util_functions.is_pschent_crown_equipped(faction_court) then
                              gold_provided = gold_provided * court.config.pschent_crown_effect_multiplier
                         end
                         return gold_provided
                    end,
               },
          },
     },

     --high_judge
     {
          name = "high_judge",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_high_judge",
          description_localization_key = "ui_text_replacements_localised_text_phar_main_court_judge_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_main_court_judge_description_1",
               "ui_text_replacements_localised_text_phar_main_court_judge_description_2",
               "ui_text_replacements_localised_text_phar_main_court_judge_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_high_judge.png",
          help_page_key = "help_crown_court_hittite_positions_high_judge",

          position_config =
          {
               visit_dilemma = "phar_main_dilemma_court_visit_settlement_test",
               legitimacy_provided = 14,
               can_disband_rebels = true,
               periodic_dilemma_cooldown = 6,
          },

          persistent = {
          },

          on_position_gained = function(self, faction_court, character_obj)
               if not shemsu_hor.is_active then
                    self.trigger_periodic_dilemma.mark_periodic_dilemma_next_trigger(self)
               end
          end,

          -- a position-specific court ability
          -- as a court action the High Judge can choose to rule over a case on their turn
          trigger_dilemma =
          {
               -- returns bool for success and, if false, the reason the ability can't be used
               can_call_ability = function(self, position_obj, faction_court)
                    local error_message = ""

                    local has_pending_dilemma = court.util_functions.is_dilemma_active()
                    if has_pending_dilemma then
                         local localized_error, _ = get_localised_random_string_and_source(court.ui.config
                         .localization_keys.dilemma_is_active)
                         error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_error)
                    end

                    local faction_key = position_obj.persistent.current_holder_faction
                    local max_court_actions_per_turn = court.util_functions.max_court_actions_for_faction(faction_key)
                    local court_actions_this_turn = court.util_functions.get_court_actions_used_this_turn(faction_key)
                    if max_court_actions_per_turn <= court_actions_this_turn then
                         local faction_display_str = common.get_localised_string("factions_screen_name_" .. faction_key)
                         local localized_text, __ = get_localised_text_replacement_and_source_formatted(
                         court.ui.config.localization_keys.faction_court_actions_used_up, faction_display_str,
                              max_court_actions_per_turn)
                         error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
                    end

                    local cooldown_remaining = self.get_ability_cooldown_remaining(position_obj, faction_key)
                    if cooldown_remaining > 0 then
                         local cooldown_remaining_str = tostring(cooldown_remaining)
                         local formatter_text, _ = get_localised_text_replacement_and_source_safe_formatted(
                         court.ui.config.localization_keys.cooldown_ends_X_turns, cooldown_remaining_str)
                         error_message = court.util_functions.append_as_red_bullet_point(error_message, formatter_text)
                    end

                    if error_message == "" then
                         return true
                    end

                    return false, error_message
               end,

               get_effect_info = function(position_obj, faction_court)
                    local localized_text = get_localised_random_string(court.ui.config.localization_keys
                    .judge_dilemma_effect_info)
                    return localized_text
               end,

               call_ability = function(self, position_obj, faction_court)
                    local is_ability_accessibile, error_message = self:can_call_ability(position_obj, faction_court)
                    if not is_ability_accessibile then
                         court.output("Error: trigger_dilemma.call_ability called, but it is inaccessible due to '" ..
                         error_message .. "'")
                         return false
                    end

                    local faction_key = position_obj.persistent.current_holder_faction
                    local dilemma_triggered = court.judge_dilemmas.pick_and_trigger_judge_dilemma(faction_key)
                    if dilemma_triggered then
                         court.util_functions.increase_used_court_actions_for_faction(faction_court, faction_key)
                         -- this returns the next Shemsu Hor turn, or if disabled, the turn after one Shemsu Hor period
                         local cooldown_end_turn = court.shemsu_hor.get_cooldown_end_turn()
                         -- we mark the turn the cooldown ends
                         court.position_functions.mark_position_with_value(position_obj, cooldown_end_turn,
                              "dilemma_triggered", faction_key, "cooldown_end_turn")

                         local local_faction_name = cm:get_local_faction_name(true)
                         if local_faction_name == faction_key
                             and court.ui.components.referenced_components.panel
                         then
                              court.ui.components.referenced_components.panel:InterfaceFunction("close_panel")
                         end
                    end
                    return dilemma_triggered
               end,

               get_ability_cooldown_remaining = function(position_obj, faction_key)
                    local cooldown_end_turn = court.position_functions.get_position_mark_value(position_obj,
                         "dilemma_triggered", faction_key, "cooldown_end_turn")
                    if not is_number(cooldown_end_turn) then
                         return 0
                    end

                    local current_turn = cm:model():turn_number()
                    if current_turn >= cooldown_end_turn then
                         return 0
                    end

                    local cooldown_remaining = cooldown_end_turn - current_turn
                    return cooldown_remaining
               end,
          },

          -- periodically triggered High Judge dilemmas, either on Shemsu Hor or after a number of turns
          trigger_periodic_dilemma =
          {
               get_periodic_dilemma_cooldown_remaining = function(position_obj, faction_key)
                    local cooldown_end_turn = court.position_functions.get_position_mark_value(position_obj, faction_key,
                         "periodic_dilemma_triggered", "periodic_dilemma_cooldown_end_turn")
                    if not is_number(cooldown_end_turn) then
                         return 0
                    end

                    local current_turn = cm:model():turn_number()
                    if current_turn >= cooldown_end_turn then
                         return 0
                    end

                    local cooldown_remaining = cooldown_end_turn - current_turn
                    return cooldown_remaining
               end,

               mark_periodic_dilemma_next_trigger = function(position_obj)
                    local current_turn = cm:model():turn_number()
                    court.position_functions.mark_position_with_value(position_obj,
                         current_turn + position_obj.position_config.periodic_dilemma_cooldown,
                         position_obj.persistent.current_holder_faction, "periodic_dilemma_triggered",
                         "periodic_dilemma_cooldown_end_turn")
               end,

               check_trigger_periodic_dilemma = function(position_obj)
                    local faction_key = position_obj.persistent.current_holder_faction
                    if (shemsu_hor.is_active and shemsu_hor.is_shemsu_hor())
                        or position_obj.trigger_periodic_dilemma.get_periodic_dilemma_cooldown_remaining(position_obj, faction_key) <= 0
                    then
                         local dilemma_triggered = court.judge_dilemmas.pick_and_trigger_judge_dilemma(position_obj
                         .persistent.current_holder_faction)
                         if not shemsu_hor.is_active then
                              position_obj.trigger_periodic_dilemma.mark_periodic_dilemma_next_trigger(position_obj)
                         end
                    end
               end,
          },

          requests =
          {
               --Grant Ruling
               {
                    request_name = "Grant Ruling",

                    ui_config =
                    {
                         name_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_judge_request_1_title",
                         icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_grant_ruling.png",
                         effect_description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_judge_request_1_desc",                   -- WARNING: this record has no parameterization % in the db
                    },

                    get_effect_info = function(self, faction_court, position_obj, faction_key)
                         local localized_info = common.get_localised_string(self.ui_config
                         .effect_description_localization_key)
                         return localized_info
                    end,

                    call_request = function(self, faction_court, position_obj, faction_key)
                         -- Grant Ruling - generate a "case" dilemma for yourself;

                         court.output(faction_key ..
                         " used request '" .. self.request_name .. "' with " .. position_obj.name .. ";")
                         local dilemma_triggered = court.judge_dilemmas.pick_and_trigger_judge_dilemma(faction_key)
                         local local_faction_name = cm:get_local_faction_name(true)
                         if local_faction_name == faction_key
                             and court.ui.components.referenced_components.panel
                         then
                              court.ui.components.referenced_components.panel:InterfaceFunction("close_panel")
                         end
                         return dilemma_triggered
                    end,
               },
               --design name: Quash Rebellion
               {
                    request_name = "Quash Rebellion",

                    ui_config =
                    {
                         name_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_judge_request_2_title",
                         icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_q_quash_rebelion.png",
                         effect_description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_judge_request_2_desc",
                    },

                    get_effect_info = function(self, faction_court, position_obj, faction_key)
                         local localized_info = common.get_localised_string(self.ui_config
                         .effect_description_localization_key)
                         return localized_info
                    end,

                    -- returns bool for success and, if false, the reason the request can't be used
                    can_use_request = function(self, faction_court, position_obj, faction_key)
                         return true
                    end,

                    call_request = function(self, faction_court, position_obj, faction_key)
                         -- design name: Quash Rebellion - allows one use of the pre-battle action to disband a rebellion by any of your armies. This effect is active until Shemsu Hor;
                         local is_request_accessibile = self:can_use_request(faction_court, position_obj, faction_key)
                         if not is_request_accessibile then
                              return nil
                         end

                         court.output(faction_key ..
                         " used request '" .. self.request_name .. "' with " .. position_obj.name .. ";")

                         -- this returns the turn this faction would lose the ability, if unused
                         -- it is the turn after the next Shemsu Hor turn, or if disabled, the turn after one Shemsu Hor period
                         local ability_end_turn = court.shemsu_hor.get_cooldown_end_turn()
                         -- we mark that the faction can use this new ability to disband rebellions
                         local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
                         faction_table.can_disband_rebellion_until_turn = ability_end_turn
                         return true
                    end,
               },
          },

          trigger_visit_dilemma = function(self, faction_key, visited_region_obj)
               local faction_obj = cm:get_faction(faction_key)
               -- only humans get dilemmas
               if not faction_obj:is_human() then
                    return
               end

               local dilemma_name = self.position_config.visit_dilemma
               local target_cqi = visited_region_obj:command_queue_index()
               cm:trigger_dilemma_with_targets_raw(faction_obj:command_queue_index(), dilemma_name, 0, 0, 0, 0,
                    target_cqi, 0, false, 0)
          end,

          on_turn_start = function(self, faction_court)
               if not self.persistent.current_holder then
                    return
               end

               self.trigger_periodic_dilemma.check_trigger_periodic_dilemma(self)
          end,
     },

     --chief_of_royal_bodyguards
     {
          name = "chief_of_royal_bodyguards",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_chief_of_royal_bodyguards",
          description_localization_key =
          "ui_text_replacements_localised_text_phar_main_court_chief_bodyguards_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_main_court_chief_bodyguards_description_1",
               "ui_text_replacements_localised_text_phar_main_court_chief_bodyguards_description_2",
               "ui_text_replacements_localised_text_phar_main_court_chief_bodyguards_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_chief_of_royal_bodyguards.png",
          help_page_key = "help_crown_court_hittite_positions_chief_of_royal_bodyguards",

          position_config =
          {
               legitimacy_provided = 7,
          },

          persistent = {
          },

          requests =
          {
               court.common_requests.cease_request,
               {
                    request_name = "Royal Bodyguards",

                    ui_config =
                    {
                         name_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_chief_bodyguards_request_2_title",
                         icon_path =
                         "ui\\skins\\default\\court\\request_icons\\icon_court_request_improve_bodyguards.png",
                         effect_description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_chief_bodyguards_request_2_desc",
                    },

                    get_effect_info = function(self, faction_court, position_obj, faction_key)
                         local localized_info = common.get_localised_string(self.ui_config
                         .effect_description_localization_key)
                         return localized_info
                    end,

                    call_request = function(self, faction_court, position_obj, faction_key)
                         -- Royal Bodyguards - gain a buff for the bodyguard unit of all your generals until Shemsu Hor;

                         court.output(faction_key ..
                         " used request '" ..
                         self.request_name ..
                         "' with " ..
                         position_obj.name ..
                         "- it should be entirely impolemented via bonuses in faction_court.config.available_positions[position_obj.name].request_bonus_packs[2]")

                         return true
                    end,
               },
          },

     },

     --lawagetes
     {
          name = "lawagetes",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_lawagetes",
          description_localization_key = "ui_text_replacements_localised_text_phar_map_court_aegea_lawagetes_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_aegea_lawagetes_description_1",
               "ui_text_replacements_localised_text_phar_map_court_aegea_lawagetes_description_2",
               "ui_text_replacements_localised_text_phar_map_court_aegea_lawagetes_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_lawagetas.png",
          help_page_key = "help_crown_court_aegean_positions_lawagetes",

          position_config =
          {
               legitimacy_provided = 14,
          },
          persistent = {
          },

          requests =
          {
               court.common_requests.battle_heralds,
               court.common_requests.warrior_gifts,
          },
     },

     --oracle
     {
          name = "oracle",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_oracle",
          description_localization_key = "ui_text_replacements_localised_text_phar_map_court_aegea_oracle_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_aegea_oracle_description_1",
               "ui_text_replacements_localised_text_phar_map_court_aegea_oracle_description_2",
               "ui_text_replacements_localised_text_phar_map_court_aegea_oracle_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_oracle.png",
          help_page_key = "help_crown_court_aegean_positions_oracle",

          position_config =
          {
               gods_favour_bonus = 160,
               main_god_additional_favour = 90,
               legitimacy_provided = 14,
          },

          persistent = {
          },

          on_position_gained = function(self, faction_court, character_obj)
               -- add gods_favour_bonus to all currently worshipped gods
               local local_faction = character_obj:faction()
               local faction_key = local_faction:name()

               if not deities.persistent[faction_key] then
                    court.output("Warning: no deities found for faction " .. faction_key)
                    return
               end

               local favour_multiplier = 1
               if court.util_functions.is_pschent_crown_equipped(faction_court) then
                    favour_multiplier = court.config.pschent_crown_effect_multiplier
               end

               local god_slots = deities.get_god_slots(faction_key)
               for i = 1, deities.get_faction_god_slots_count(faction_key) do
                    if god_slots[i].god_key then
                         local god_key = god_slots[i].god_key
                         local favour_gained = self:god_favour_bonus(god_key, faction_court) * favour_multiplier
                         deities.grant_favour(faction_key, god_key, favour_gained, "court")
                    end
               end
          end,

          on_position_lost = function(self, faction_court, character_obj)
               -- remove gods_favour_bonus to all currently worshipped gods
               local local_faction = character_obj:faction()
               local faction_key = local_faction:name()

               if not deities.persistent[faction_key] then
                    court.output("Warning: no deities found for faction " .. faction_key)
                    return
               end

               local favour_multiplier = 1
               if court.util_functions.is_pschent_crown_equipped(faction_court) then
                    favour_multiplier = court.config.pschent_crown_effect_multiplier
               end

               local god_slots = deities.get_god_slots(faction_key)
               for i = 1, deities.get_faction_god_slots_count(faction_key) do
                    if god_slots[i].god_key then
                         local god_key = god_slots[i].god_key
                         local favour_lost = self:god_favour_bonus(god_key, faction_court) * favour_multiplier
                         deities.grant_favour(faction_key, god_key, -favour_lost, "court")
                    end
               end
          end,

          requests =
          {
               {
                    request_name = "Cost of Worship",

                    ui_config =
                    {
                         name_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_priest_request_1_title",
                         icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_cost_of_worship.png",
                         effect_description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_priest_request_1_desc",                   -- WARNING: this record has no parameterization % in the db
                    },

                    get_effect_info = function(self, faction_court, position_obj, faction_key)
                         local localized_info = common.get_localised_string(self.ui_config
                         .effect_description_localization_key)
                         return localized_info
                    end,

                    call_request = function(self, faction_court, position_obj, faction_key)
                         -- Cost of Worship - learn what changes the Lawgiver will make on Shemsu Hor;
                         court.output(faction_key ..
                         " used request '" ..
                         self.request_name ..
                         "' with " ..
                         position_obj.name ..
                         " - it should be entirely impolemented via bonuses in faction_court.config.available_positions[position_obj.name].request_bonus_packs[1]")
                         return true
                    end,
               },
               {
                    request_name = "Piety",

                    ui_config =
                    {
                         name_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_priest_request_2_title",
                         icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_piety.png",
                         effect_description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_priest_request_2_desc",
                         cant_call_no_deities_found_localization_key = "phar_main_court_request_piety_cant_call_faction",
                    },

                    get_effect_info = function(self, faction_court, position_obj, faction_key)
                         local localized_info = common.get_localised_string(self.ui_config
                         .effect_description_localization_key)
                         local parametrized_info = string.format(localized_info,
                              position_obj.position_config.gods_favour_bonus)
                         return parametrized_info
                    end,

                    -- returns bool for success and, if false, the reason request can't be used
                    can_use_request = function(self, faction_court, position_obj, faction_key)
                         local result = ""
                         if not deities.persistent[faction_key] then
                              local localized_faction_name = common.get_localised_string("factions_screen_name_" ..
                              faction_key)
                              local localized_text, _ = get_localised_text_replacement_and_source_formatted(
                              self.ui_config.cant_call_no_deities_found_localization_key, localized_faction_name)
                              -- we could just return the result since it is a single check, but I want it consistent, and ready to easily copy-paste if another check appears
                              result = court.util_functions.append_as_red_bullet_point(result, localized_text)
                         end

                         if result == "" then
                              return true, ""
                         end

                         return false, result
                    end,

                    call_request = function(self, faction_court, position_obj, faction_key)
                         -- Piety - Gain temporary favour with all gods you worship until Shemsu Hor;
                         local is_request_accessibile = self:can_use_request(faction_court, position_obj, faction_key)
                         if not is_request_accessibile then
                              return nil
                         end

                         court.output(faction_key ..
                         " used request '" .. self.request_name .. "' with " .. position_obj.name .. ";")

                         local faction_table = court.util_functions.get_faction_persistent_data(faction_key)

                         local favour_multiplier = 1
                         if court.util_functions.is_pschent_crown_equipped(faction_court) then
                              favour_multiplier = court.config.pschent_crown_effect_multiplier
                         end

                         local current_turn = cm:model():turn_number()
                         local remove_at_turn = current_turn + court.config.non_shemsu_hor_request_cooldown
                         local god_slots = deities.get_god_slots(faction_key)
                         for i = 1, deities.get_faction_god_slots_count(faction_key) do
                              if god_slots[i].god_key then
                                   local god_key = god_slots[i].god_key
                                   local favor_gain = position_obj.position_config.gods_favour_bonus * favour_multiplier
                                   court.favour_functions.add_temporary_favour(faction_table, god_key, favor_gain,
                                        remove_at_turn)
                              end
                         end

                         return true
                    end,
               },
          },

          on_new_god_worshipped = function(self, faction_court, new_god_key, old_god_key)
               if old_god_key then
                    local favour_lost = self:god_favour_bonus(old_god_key, faction_court)
                    if court.util_functions.is_pschent_crown_equipped(faction_court) then
                         favour_lost = favour_lost * court.config.pschent_crown_effect_multiplier
                    end
                    deities.grant_favour(self.persistent.current_holder_faction, old_god_key, -favour_lost, "court")
               end

               if new_god_key then
                    local favour_gained = self:god_favour_bonus(new_god_key, faction_court)
                    if court.util_functions.is_pschent_crown_equipped(faction_court) then
                         favour_gained = favour_gained * court.config.pschent_crown_effect_multiplier
                    end
                    deities.grant_favour(self.persistent.current_holder_faction, new_god_key, favour_gained, "court")
               end
          end,

          on_aten_created = function(self, aten_key, faction_court)
               if aten_key then
                    local favour_gained = self:god_favour_bonus(aten_key, faction_court)
                    local court_obj = court.util_functions.get_faction_court_for_faction(self.persistent
                    .current_holder_faction)
                    if not court_obj then
                         return
                    end
                    if court.util_functions.is_pschent_crown_equipped(court_obj) then
                         favour_gained = favour_gained * court.config.pschent_crown_effect_multiplier
                    end
                    deities.grant_favour(self.persistent.current_holder_faction, aten_key, favour_gained, "court")
               end
          end,

          on_crown_state_changed = function(self, phar_court, crown_equipped)
               -- we are only interested in this if the position is filled
               local holder_faction = self.persistent.current_holder_faction
               if not holder_faction
                   or holder_faction == "" then
                    return
               end

               local pschent_favour_multiplier = court.config.pschent_crown_effect_multiplier

               local god_slots = deities.get_god_slots(holder_faction)
               for i = 1, deities.get_faction_god_slots_count(holder_faction) do
                    if god_slots[i].god_key then
                         local god_key = god_slots[i].god_key
                         local standard_favour = self:god_favour_bonus(god_key, phar_court)
                         local crown_favor = standard_favour * pschent_favour_multiplier

                         if crown_equipped then
                              -- if we just switched from standard to the crown favor
                              -- therefore we gained the crown_favor and lost the standard one
                              local favor_change = crown_favor - standard_favour
                              deities.grant_favour(holder_faction, god_key, favor_change, "court")
                         else
                              -- if we just switched from crown to standard favor
                              -- therefore we gained the standard favor and lost crown_favor
                              local favor_change = standard_favour - crown_favor
                              deities.grant_favour(holder_faction, god_key, favor_change, "court")
                         end
                    end
               end
          end,
          -------------------
          -- internal methods
          god_favour_bonus = function(self, god_key, faction_court)
               local favour_bonus = self.position_config.gods_favour_bonus
               local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, self)
               if court_specific_config and is_string(court_specific_config.main_god_key) then
                    local main_god_key = court_specific_config.main_god_key
                    if god_key == main_god_key then
                         favour_bonus = favour_bonus + self.position_config.main_god_additional_favour
                    end
               end

               return favour_bonus
          end,
     },

     --grand_telestas -- Aegean Treasurer
     {
          name = "grand_telestas",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_grand_telestas",
          description_localization_key =
          "ui_text_replacements_localised_text_phar_map_court_aegea_grand_telestas_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_aegea_grand_telestas_description_1",
               "ui_text_replacements_localised_text_phar_map_court_aegea_grand_telestas_description_2",
               "ui_text_replacements_localised_text_phar_map_court_aegea_grand_telestas_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_royal_treasurer.png",
          help_page_key = "help_crown_court_aegean_positions_grand_telestas",
          ability_tooltip_discounts_show = "phar_main_court_show_discounts_treasurer_tooltip", -- ui_text_replacements
          ability_title_discounts_show = "phar_main_court_see_treasurer_discounts",    -- ui_text_replacements
          ability_title_discounts_set = "phar_main_court_apply_treasurer_discounts",   -- ui_text_replacements

          position_config =
          {
               shemsu_hor_possible_effects =
               {
                    -- Administartion & Admin ERS
                    {
                         effect_id = "phar_main_mod_cost_municipal_complex_admin_ers",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_municipal_complex_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
                    --Province Management
                    {
                         effect_id = "phar_main_mod_cost_province_management",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_province_management_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
                    --Recruitment
                    {
                         effect_id = "phar_main_mod_cost_military_recruit",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_military_recruit_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
                    --Military Support & Military ERS
                    {
                         effect_id = "phar_main_mod_cost_military_support_military_ers",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_military_support_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
                    --Production Management & Economic ERS
                    {
                         effect_id = "phar_main_mod_cost_production_management_economic_ers",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_production_management_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
                    --Resource Production
                    {
                         effect_id = "phar_main_mod_cost_building_sets_resource_production",
                         effect_display_name =
                         "ui_text_replacements_localised_text_phar_main_court_resource_production_discount_title",
                         category = "ui_text_replacements_localised_text_phar_main_court_building_discount_title",
                    },
               },

               max_discount = 25,
               discount_sum = 50,   -- this should NOT be used directly, only via get_discounts_sum due to bonuses and effects
               num_categories_to_influence = 1, -- this should NOT be used directly, only via get_number_of_categories_to_influence due to bonuses and effects
               discount_increment = 5,
               large_request_fixed_amount = 25,
               -- the sum of these should match 'discount_sum'
               shemsu_hor_initial_discounts = { 25, 25 },
               ai_sets =
               {
                    { 25, 25 },
                    { 0,  0, 25, 25 },
                    { 0,  0, 0,  0, 25, 25 },
               },

               -- treasurer can use the embezzle plot
               -- factions can also gain one-time use of the plot from a request (asking the treasurer to embezzle someone on their behalf)
               -- but it doesn't make sense they can use it against the treasurer
               plots_immunity = { "embezzle", },
               legitimacy_provided = 14,
          },

          persistent = {
          },

          requests =
          {
               court.common_requests.embezzle_request,
               court.common_requests.building_discounts,
          },
     },

     --king_of_babylon
     {
          name = "king_of_babylon",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_king_of_babylon",
          description_localization_key =
          "ui_text_replacements_localised_text_phar_map_court_meso_king_of_babylon_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_babylon_description_1",
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_babylon_description_2",
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_babylon_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_king_of_babylon.png",
          help_page_key = "help_crown_court_mesopotamian_positions_king_of_babylon",

          position_config =
          {

               -- Favour bonuses
               gods_favour_bonus = 160,
               main_god_additional_favour = 90,
               legitimacy_provided = 25,

               position_units =
               {
                    {
                         unit_key = "phar_map_meso_elite_babylonian_specialists",
                         amount = 1,
                    },
               },

               request_bonus_packs =
               {
                    {
                         unit_key = "phar_map_meso_elite_babylonian_specialists",
                         amount = 1,
                    },
               },
          },

          persistent = {
          },

          on_position_gained = function(self, faction_court, character_obj)
               -- add gods_favour_bonus to all currently worshipped gods
               local local_faction = character_obj:faction()
               local faction_key = local_faction:name()

               if not deities.persistent[faction_key] then
                    court.output("Warning: no deities found for faction " .. faction_key)
                    return
               end

               local favour_multiplier = 1

               local god_slots = deities.get_god_slots(faction_key)
               for i = 1, deities.get_faction_god_slots_count(faction_key) do
                    if god_slots[i].god_key then
                         local god_key = god_slots[i].god_key
                         local favour_gained = self:god_favour_bonus(god_key, faction_court) * favour_multiplier
                         deities.grant_favour(faction_key, god_key, favour_gained, "court")
                    end
               end
          end,

          on_position_lost = function(self, faction_court, character_obj)
               -- remove gods_favour_bonus to all currently worshipped gods
               local local_faction = character_obj:faction()
               local faction_key = local_faction:name()

               if not deities.persistent[faction_key] then
                    court.output("Warning: no deities found for faction " .. faction_key)
                    return
               end

               local favour_multiplier = 1

               local god_slots = deities.get_god_slots(faction_key)
               for i = 1, deities.get_faction_god_slots_count(faction_key) do
                    if god_slots[i].god_key then
                         local god_key = god_slots[i].god_key
                         local favour_lost = self:god_favour_bonus(god_key, faction_court) * favour_multiplier
                         deities.grant_favour(faction_key, god_key, -favour_lost, "court")
                    end
               end
          end,

          requests =
          {
               {
                    request_name = "Cost of Worship",

                    ui_config =
                    {
                         name_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_priest_request_1_title",
                         icon_path = "ui\\skins\\default\\court\\request_icons\\icon_court_request_cost_of_worship.png",
                         effect_description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_priest_request_1_desc",                   -- WARNING: this record has no parameterization % in the db
                    },

                    get_effect_info = function(self, faction_court, position_obj, faction_key)
                         local localized_info = common.get_localised_string(self.ui_config
                         .effect_description_localization_key)
                         return localized_info
                    end,

                    call_request = function(self, faction_court, position_obj, faction_key)
                         -- Cost of Worship - ;
                         court.output(faction_key ..
                         " used request '" ..
                         self.request_name ..
                         "' with " ..
                         position_obj.name ..
                         " - it should be entirely impolemented via bonuses in faction_court.config.available_positions[position_obj.name].request_bonus_packs[1]")
                         return true
                    end,
               },
               court.common_requests.request_elites,
          },

          on_new_god_worshipped = function(self, faction_court, new_god_key, old_god_key)
               if old_god_key then
                    local favour_lost = self:god_favour_bonus(old_god_key, faction_court)
                    deities.grant_favour(self.persistent.current_holder_faction, old_god_key, -favour_lost, "court")
               end

               if new_god_key then
                    local favour_gained = self:god_favour_bonus(new_god_key, faction_court)
                    deities.grant_favour(self.persistent.current_holder_faction, new_god_key, favour_gained, "court")
               end
          end,

          on_aten_created = function(self, aten_key, faction_court)
               if aten_key then
                    local favour_gained = self:god_favour_bonus(aten_key, faction_court)
                    local court_obj = court.util_functions.get_faction_court_for_faction(self.persistent
                    .current_holder_faction)
                    if not court_obj then
                         return
                    end
                    if court.util_functions.is_pschent_crown_equipped(court_obj) then
                         favour_gained = favour_gained * court.config.pschent_crown_effect_multiplier
                    end
                    deities.grant_favour(self.persistent.current_holder_faction, aten_key, favour_gained, "court")
               end
          end,

          -------------------
          -- internal methods
          god_favour_bonus = function(self, god_key, faction_court)
               local favour_bonus = self.position_config.gods_favour_bonus
               local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, self)
               if court_specific_config and is_string(court_specific_config.main_god_key) then
                    local main_god_key = court_specific_config.main_god_key
                    if god_key == main_god_key then
                         favour_bonus = favour_bonus + self.position_config.main_god_additional_favour
                    end
               end

               return favour_bonus
          end,
     },

     --king_of_assur
     {
          name = "king_of_assur",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_king_of_assur",
          description_localization_key =
          "ui_text_replacements_localised_text_phar_map_court_meso_king_of_assur_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_assur_description_1",
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_assur_description_2",
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_assur_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_king_of_assyria.png",
          help_page_key = "help_crown_court_mesopotamian_positions_king_of_assur",

          position_config =
          {
               -- treasurer can use the embezzle plot
               -- factions can also gain one-time use of the plot from a request (asking the treasurer to embezzle someone on their behalf)
               -- but it doesn't make sense they can use it against the treasurer
               plots_immunity = { "embezzle", },
               legitimacy_provided = 25,

               can_disband_rebels = true,

               position_units =
               {
                    {
                         unit_key = "phar_map_meso_elite_assur_noblemen",
                         amount = 1,
                    },
               },

               request_bonus_packs =
               {
                    {
                         unit_key = "phar_map_meso_elite_assur_noblemen",
                         amount = 1,
                    },
               },
          },

          persistent = {
          },

          requests =
          {
               court.common_requests.embezzle_request,
               court.common_requests.request_elites,
          },
     },

     --king_of_hanigalbat
     {
          name = "king_of_hanigalbat",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_king_of_hanigalbat",
          description_localization_key =
          "ui_text_replacements_localised_text_phar_map_court_meso_king_of_hanigalbat_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_hanigalbat_description_1",
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_hanigalbat_description_2",
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_hanigalbat_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_king_of_hanigalbat.png",
          help_page_key = "help_crown_court_mesopotamian_positions_king_of_hanigalbat",
          ability_tooltip_discounts_show = "phar_main_court_show_discounts_treasurer_tooltip", -- ui_text_replacements
          ability_title_discounts_show = "phar_main_court_see_treasurer_discounts",    -- ui_text_replacements
          ability_title_discounts_set = "phar_main_court_apply_treasurer_discounts",   -- ui_text_replacements

          position_config =
          {
               -- this faction can use the assassinate plot
               -- factions can also gain one-time use of the plot from a request (asking the vizier to assassinate someone on their behalf)
               -- but it doesn't make sense they can use it against the King of Hanigalbat
               plots_immunity = { "assassinate", },
               legitimacy_provided = 20,

               court_actions_gained = 3,

               give_actions_cooldown = 6,

               position_units =
               {
                    {
                         unit_key = "phar_map_meso_elite_euphrats_tigers_chariots",
                         amount = 1,
                    },
               },

               request_bonus_packs =
               {
                    {
                         unit_key = "phar_map_meso_elite_euphrats_tigers_chariots",
                         amount = 1,
                    },
               },
          },

          persistent = {
          },

          -- a position-specific court ability
          -- as a court action this position can gain three Court Actions until end of turn
          give_court_actions_ability = court.common_abilities.give_court_actions_ability,

          get_num_court_actions_provided = function(self, faction_court)
               local actions_gained = self.position_config.court_actions_gained
               return actions_gained
          end,

          -- can be called by the vizier using the court ability, or another faction with a request
          give_court_actions = function(self, faction_key, faction_court)
               local actions_gained = self:get_num_court_actions_provided(faction_court)
               court.util_functions.add_court_extra_actions_for_faction(faction_key, actions_gained)
               return true
          end,

          requests =
          {
               court.common_requests.assassinate_request,
               court.common_requests.request_elites,
          },
     },

     --king_of_elam
     {
          name = "king_of_elam",
          name_localization_key = "ui_text_replacements_localised_text_phar_position_king_of_elam",
          description_localization_key =
          "ui_text_replacements_localised_text_phar_map_court_meso_king_of_elam_description",
          benefits_localization_keys =
          {
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_elam_description_1",
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_elam_description_2",
               "ui_text_replacements_localised_text_phar_map_court_meso_king_of_elam_description_3",
          },
          icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_king_of_elam.png",
          help_page_key = "help_crown_court_mesopotamian_positions_king_of_elam",

          position_config =
          {
               legitimacy_provided = 20,

               position_units =
               {
                    {
                         unit_key = "phar_map_meso_elite_elamite_royal_chargers",
                         amount = 1,
                    },
               },

               request_bonus_packs =
               {
                    {
                         unit_key = "phar_map_meso_elite_elamite_royal_chargers",
                         amount = 1,
                    },
               },
          },

          persistent = {
          },

          requests =
          {
               court.common_requests.cease_request,
               court.common_requests.request_elites,
          },

     },
}

court.position_functions =
{
     -------------------------------------------------------------------------------------
     -- EXTERNAL METHODS: meant to be called from outside this file, for UI or AI purposes

     --- @function claim_position
     --- @desc Checks if the leader of a faction can claim the court position and if so - gives it to them.
     --- @desc claiming has more requirements than simply recieving it by diplomacy
     --- @p object faction_court - one of the courts listed in court.all_courts
     --- @p string faction_key - the faction key
     --- @p string court_position_str - the court position key (name or alt_name)
     --- @p [opt=false] bool skip_checks - if set to anything other than false/nil the system will not check for eligibility
     --- @p [opt=false] bool skip_payment - if set to anything other than false/nil the faction will not pay for the position
     --- @p [opt=nil] string supporting_faction_key - the court leader faction, when it gives away the position to [faction_key]
     --- @return true if request called successfully, or nil if unable
     claim_position = function(faction_court, faction_key, court_position_str, skip_checks, skip_payment,
                               supporting_faction_key)
          local faction_obj = cm:get_faction(faction_key)
          if not faction_obj or faction_obj:is_null_interface() then
               court.output(
               "Error: can't find faction '" .. faction_key .. "' trying to claim position '" .. court_position_str ..
               "'", 10)
               return nil
          end

          if not skip_checks then
               local court_position_obj = court.util_functions.get_court_position(faction_court, court_position_str)
               local can_claim_position, error_message = court.util_functions.can_claim_position_directly(faction_court,
                    faction_key, court_position_obj, skip_payment)
               if not can_claim_position then
                    court.output("Error: faction '" .. faction_key .. "' can't claim position because: " .. error_message,
                         10)
                    return nil
               end
          end

          local character_obj = faction_obj:faction_leader()
          if (not character_obj) or character_obj:is_null_interface() then
               court.output(
               "Error: can't find the leader of faction '" ..
               faction_key .. "' trying to claim position '" .. court_position_str .. "'", 10)
               return nil
          end

          -- this does additional position-specific checks, like if it is vacant, culture
          local result = court.position_functions.give_position_internal(faction_court, character_obj, court_position_str,
               skip_checks, skip_payment,
               false, -- initial_holder
               false, -- has_legitimacy_war_just_ended
               false --  test_position (if 'true' or default, would return error if the character already has a position)
          )
          return result
     end,

     --- @function give_own_character_a_position
     --- @desc Checks if the leader of the court can give a court position to one of their characters and if so - gives it to them.
     --- @desc this has more requirements than simply giving it by diplomacy
     --- @p object faction_court - one of the courts listed in court.all_courts
     --- @p string faction_key - the faction key
     --- @p object character_obj - the script interface of the character
     --- @p string court_position_str - the court position key (name or alt_name)
     --- @p [opt=false] bool skip_checks - if set to anything other than false/nil the system will not check for eligibility
     --- @p [opt=false] bool skip_payment - if set to anything other than false/nil the faction will not pay for the position
     --- @p [opt=nil] string supporting_faction_key - the court leader faction, when it gives away the position to [faction_key]
     --- @return true if request called successfully, or nil if unable
     give_own_character_a_position = function(faction_court, faction_key, character_obj, court_position_str, skip_checks,
                                              skip_payment, supporting_faction_key)
          local court_position_obj = court.util_functions.get_court_position(faction_court, court_position_str)
          local can_give_position, error_message = court.util_functions.can_give_own_character_a_position(faction_court,
               faction_key, court_position_obj, character_obj, supporting_faction_key)
          if not can_give_position then
               court.output(
               "Error: faction '" ..
               faction_key .. "' can't give position '" .. court_position_str .. "' because: " .. error_message, 10)
               return nil
          end

          -- this does additional position-specific checks, like if it is vacant, culture
          local result = court.position_functions.give_position_internal(faction_court, character_obj, court_position_str,
               skip_checks, skip_payment)
          return result
     end,

     --- @function give_character_a_position
     --- @desc Gives a character the court position, e.g. by diplomacy, avoids the checks with claiming the position
     --- @p object faction_court - one of the courts listed in court.all_courts
     --- @p string character_lookup - a way to find the character, e.g. "forename:1357720468" for Ramesses
     --- @p string court_position_str - the court position key (name or alt_name)
     --- @return true if request called successfully, or nil if unable
     give_character_a_position = function(faction_court, character_lookup, court_position_str)
          local character_obj = cm:get_character(character_lookup)
          if character_obj:is_null_interface() then
               court.output(
               "Error: can't find character '" ..
               character_lookup .. "' trying to get position '" .. court_position_str .. "'", 10)
               return nil
          end

          -- this does additional position-specific checks, like if it is vacant, culture
          local result = court.position_functions.give_position_internal(faction_court, character_obj, court_position_str)
          return result
     end,

     --- @function can_faction_call_request
     --- @desc Checks if the faction can use a specific request right now
     --- @p object faction_court - one of the courts listed in court.all_courts
     --- @p string faction_key - the faction key
     --- @p int request_index - 1 for small request and 2 for large request
     --- @p string court_position_str - the name of the position we're interested in
     --- @p boolean use_dominance - if set to true we will use the dominance resource from the atreus Ancient Legacy instead of regard
     --- @return boolean xor nil, string : boolean for whether giving the position is possible xor nil for programming error, message why it is impossible
     can_faction_call_request = function(faction_court, faction_key, request_index, court_position_str, use_dominance)
          if not is_string(faction_key) then
               return nil, "faction_key passed is not a string"
          elseif not faction_court then
               return nil, "no faction_court passed"
          end

          local result = ""

          local has_pending_dilemma = court.util_functions.is_dilemma_active()
          if has_pending_dilemma then
               local localized_error, _ = get_localised_random_string_and_source(court.ui.config.localization_keys
               .dilemma_is_active)
               result = court.util_functions.append_as_red_bullet_point(result, localized_error)
          end

          if (not court.config.can_make_requests_during_war) and court.util_functions.is_in_legitimacy_war(faction_court) then
               local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
               .cant_use_requests_during_war)
               result = court.util_functions.append_as_red_bullet_point(result, localized_text)
          end

          local court_position_obj = court.util_functions.get_court_position(faction_court, court_position_str)
          if court_position_obj.persistent.current_holder == nil then
               local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
               .cant_use_requests_to_empty_position)
               result = court.util_functions.append_as_red_bullet_point(result, localized_text)
          end

          if court_position_obj.persistent.current_holder_faction == faction_key then
               local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
               .cant_use_requests_to_own_position)
               result = court.util_functions.append_as_red_bullet_point(result, localized_text)
          end

          if use_dominance then
               local faction_obj = cm:get_faction(faction_key)
               local base_cost_obj = cm:create_new_custom_resource_cost()
               base_cost_obj:add_resource_cost(ancient_legacy_atreus_config.resource_key,
                    court.config.court_resource_factor, -court.config.demand_dominance_cost)
               local can_pay = faction_obj:can_afford_resource_cost_object(base_cost_obj)

               if not can_pay then
                    local position_localized_string, _ = court.position_functions.get_localized_position_name(
                    court_position_obj, faction_court)
                    local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
                    .can_not_afford_court_action)
                    result = court.util_functions.append_as_red_bullet_point(result, localized_text)
               end
          else
               local usable_regard, local_regard = court.position_functions
               .get_position_regard_data_towards_faction_by_obj(court_position_obj, faction_key)
               local needed_regard = court.util_functions.get_property(faction_key, "request_regard_cost")

               if usable_regard < needed_regard then
                    local position_localized_string, _ = court.position_functions.get_localized_position_name(
                    court_position_obj, faction_court)
                    local localized_text, _ = get_localised_text_replacement_and_source_formatted(
                    court.ui.config.localization_keys.not_enough_regard, position_localized_string, needed_regard,
                         local_regard)
                    result = court.util_functions.append_as_red_bullet_point(result, localized_text)
               end
          end
          local request_mark_str = "request_" .. request_index
          local request_obj = court_position_obj.requests[request_index]

          local cooldown_end_turn = court.position_functions.get_position_mark_value(court_position_obj, request_mark_str,
               faction_key, "cooldown_end_turn")
          if cooldown_end_turn then
               local current_turn = cm:model():turn_number()
               if current_turn < cooldown_end_turn then
                    local cooldown_remaining = cooldown_end_turn - current_turn
                    local cooldown_remaining_str = tostring(cooldown_remaining)
                    local formatter_text, _ = get_localised_text_replacement_and_source_safe_formatted(
                    court.ui.config.localization_keys.cooldown_ends_X_turns, cooldown_remaining_str)
                    result = court.util_functions.append_as_red_bullet_point(result, formatter_text)
               end
          end

          local court_actions_needed = court.position_functions.get_request_actions_needed(request_obj, faction_key,
               faction_court)

          local available_actions = court.util_functions.get_available_court_actions(faction_key)
          if available_actions < court_actions_needed then
               local can_purchase_actions = false
               local autopurchase_request_actions = court.util_functions.get_property(faction_key,
                    "can_purchase_court_actions") and court.config.autopurchase_requests
               if autopurchase_request_actions then
                    local extra_actions_needed = court_actions_needed - available_actions
                    if extra_actions_needed > 0 then
                         local cost_obj = cm:create_new_custom_resource_cost()
                         court.util_functions.add_court_action_purchase_cost(faction_key, cost_obj, extra_actions_needed)
                         local faction_obj = cm:get_faction(faction_key)
                         -- since here actions are gold we will just show the 'no actions' message
                         can_purchase_actions = faction_obj:can_afford_resource_cost_object(cost_obj)
                    end
               end

               if not can_purchase_actions then
                    local localized_faction_name = common.get_localised_string("factions_screen_name_" .. faction_key)
                    local localized_text, _ = get_localised_text_replacement_and_source_formatted(
                    court.ui.config.localization_keys.faction_used_up_actions_for_request, court_actions_needed)
                    result = court.util_functions.append_as_red_bullet_point(result, localized_text)
               end
          end

          if is_function(request_obj.can_use_request) then
               local can_call_result, error_message = request_obj:can_use_request(faction_court, court_position_obj,
                    faction_key)
               if not can_call_result then
                    -- can_use_request should return the points as red bullet points, so we don't need to add them as such, just append them
                    result = court.util_functions.message_append(result, error_message)
               end
          end

          if result == "" then
               return true
          end

          return false, result
     end,

     --- @function call_request
     --- @desc Checks if the faction can call a request from the given position, and then requests it
     --- @p object faction_court - one of the courts listed in court.all_courts
     --- @p string faction_key - the faction key
     --- @p string court_position_str - the court position key (name or alt_name)
     --- @p int request_index - 1 for small request and 2 for large request
     --- @p boolean use_dominance - if set to true we will use the dominance resource from the atreus Ancient Legacy instead of regard
     --- @return 'OK', or the reason for failing
     call_request = function(faction_court, faction_key, court_position_str, request_index, use_dominance, ...)
          local court_position_obj = court.util_functions.get_court_position(faction_court, court_position_str)
          local request_obj = court_position_obj.requests[request_index]

          local request_accessibility, failure_reason = court.position_functions.can_faction_call_request(faction_court,
               faction_key, request_index, court_position_str, use_dominance)
          if not request_accessibility then
               court.output(
               "Error: trying to make request '" ..
               request_obj.request_name .. "' but can't, due to : " .. failure_reason, 10)
               return nil
          end

          -- we need to cache the actions and the cost before the request is executed, as some requests give actions - so taking them later would give a false result
          local court_actions_needed = court.position_functions.get_request_actions_needed(request_obj, faction_key,
               faction_court)
          local available_actions = court.util_functions.get_available_court_actions(faction_key)
          local actions_purchase_cost = nil
          if available_actions < court_actions_needed then
               local autopurchase_request_actions = court.util_functions.get_property(faction_key,
                    "can_purchase_court_actions") and court.config.autopurchase_requests
               if autopurchase_request_actions then
                    local extra_actions_needed = court_actions_needed - available_actions
                    if extra_actions_needed > 0 then
                         actions_purchase_cost = cm:create_new_custom_resource_cost()
                         court.util_functions.add_court_action_purchase_cost(faction_key, actions_purchase_cost,
                              extra_actions_needed)
                         local faction_obj = cm:get_faction(faction_key)
                         court.util_functions.add_court_extra_actions_for_faction(faction_key, extra_actions_needed)
                    end
               end
          end

          local result = court_position_obj.requests[request_index]:call_request(faction_court, court_position_obj,
               faction_key, unpack(arg))
          if not result then
               court.output(
               "ERROR: request '" ..
               court_position_obj.requests[request_index].request_name ..
               "' from '" .. faction_key .. "' towards '" .. court_position_str .. "' failed", 10)
               return result
          end

          local request_mark_str = "request_" .. request_index
          local cooldown_end_turn = nil
          if shemsu_hor.is_active then
               cooldown_end_turn = court.shemsu_hor.get_cooldown_end_turn()
          else
               local current_turn = cm:model():turn_number()
               cooldown_end_turn = current_turn + court.config.non_shemsu_hor_request_cooldown
          end

          court.position_functions.mark_position_with_value(court_position_obj, cooldown_end_turn, request_mark_str,
               faction_key, "cooldown_end_turn")

          court.position_functions.give_request_bonus_packs(faction_court, court_position_obj, request_index, faction_key)

          if use_dominance then
               local faction_obj = cm:get_faction(faction_key)
               local dominance_cost_obj = cm:create_new_custom_resource_cost()
               dominance_cost_obj:add_resource_cost(ancient_legacy_atreus_config.resource_key,
                    court.config.court_resource_factor, -court.config.demand_dominance_cost)

               cm:faction_apply_resource_transaction(faction_obj, dominance_cost_obj)
          else
               local regard_cost = court.util_functions.get_property(faction_key, "request_regard_cost")
               court.position_functions.change_regard_towards_faction_by_obj(court_position_obj, faction_key,
                    -regard_cost)
          end

          if faction_key == cm:get_local_faction_name(true) then
               court.log_functions.log_court_action("request_used", faction_key, court_position_str, request_index, arg)
          end

          if actions_purchase_cost then
               local extra_actions_needed = court_actions_needed - available_actions
               local faction_obj = cm:get_faction(faction_key)
               cm:faction_apply_resource_transaction(faction_obj, actions_purchase_cost)
          end
          -- this needs to be the last thing called, as it sends events the action is over
          -- this is also why we need to call it even if the court_actions_needed is 0
          court.util_functions.increase_used_court_actions_for_faction(faction_court, faction_key, court_actions_needed)

          return result
     end,

     --- @function get_position_regard_towards_faction
     --- @desc Getter for the regard the position has towards the faction
     --- @p object faction_court - one of the courts listed in court.all_courts
     --- @p string court_position_str - the court position key (name or alt_name)
     --- @p string faction_key - the faction key
     --- @return integer - the regard towards the faction
     get_position_regard_towards_faction = function(faction_court, court_position_str, faction_key)
          local position_obj = court.util_functions.get_court_position(faction_court, court_position_str)
          return court.position_functions.get_position_regard_towards_faction_by_obj(position_obj, faction_key)
     end,

     can_faction_see_discount_plans_position = function(position_obj, faction_court, faction_key)
          if not position_obj.persistent.current_holder then
               return false
          end

          -- unlike other cooldowns which prevent you from doing things, seeing discounts only work until the cooldown is over
          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, position_obj)
          local can_see_discounts_mark = court_specific_config.can_see_discounts_mark
          local cooldown_end_turn = court.position_functions.get_position_mark_value(position_obj, can_see_discounts_mark,
               faction_key, "cooldown_end_turn")
          if is_number(cooldown_end_turn) then
               local current_turn = cm:model():turn_number()
               if current_turn < cooldown_end_turn then
                    return true
               end
          end

          return false
     end,

     has_faction_court_position_available = function(faction_name)
          local faction_court = court.util_functions.get_faction_court_for_faction(faction_name)
          if not faction_court then
               return
          end

          local faction_obj = cm:get_faction(faction_name)
          if not faction_obj or faction_obj:is_null_interface() then
               return false
          end

          local faction_leader_key = faction_court:ruling_faction()
          if faction_name == faction_leader_key
              or faction_court.config.any_faction_can_hold_multiple_positions
          then
               -- if this becomes a performance hit we could add an option to return the first error, not all of them
               if not court.util_functions.can_give_own_character_a_position(faction_court, faction_name) then
                    return false
               end
          else
               -- if this becomes a performance hit we could add an option to return the first error, not all of them
               if not court.util_functions.can_claim_position_directly(faction_court, faction_name) then
                    return false
               end
          end

          return true
     end,

     get_request_actions_needed = function(request_obj, faction_key, faction_court)
          local court_actions_needed = court.util_functions.get_property(faction_key, "requests_court_actions_needed")
          if request_obj.court_actions_needed_override then
               court_actions_needed = request_obj:court_actions_needed_override(faction_court, faction_key)
          end
          return court_actions_needed
     end,

     -------------------------------------------------------------------
     -- INTERNAL METHODS - meant to only be called from inside this file

     -- returns the mercenary units provided to the faction from holding the positon
     get_position_mercenary_units = function(faction_court, court_position_obj)
          local has_pschent_crown = court.util_functions.is_pschent_crown_equipped(faction_court)
          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court,
               court_position_obj)

          if court_specific_config then
               if has_pschent_crown
                   and is_table(court_specific_config.position_units_pschent)
               then
                    return court_specific_config.position_units_pschent
               end

               if is_table(court_specific_config.position_units) then
                    return court_specific_config.position_units
               end
          end

          if has_pschent_crown
              and is_table(court_position_obj.position_config.position_units_pschent)
          then
               return court_position_obj.position_config.position_units_pschent
          end

          return court_position_obj.position_config.position_units
     end,

     -- a faction has gained a position (or something forced a refresh of the units)
     -- now we should give it the units provided by the position
     give_position_mercenary_units = function(faction_court, court_position_obj)
          local faction_key = court_position_obj.persistent.current_holder_faction
          if not faction_key then
               court.output("ERROR: trying to give position units of vacant position!", 10)
               return
          end

          local faction_has_unlocked_court = feature_unlock.is_feature_unlocked_for_faction(
          court_position_obj.persistent.current_holder_faction, feature_ids_config.court)
          if not faction_has_unlocked_court then
               -- mercenary units are given only when the faction has unlocked the court
               return
          end

          if court_position_obj.position_config.do_not_provide_mercenary_units_to_court_leader then
               local ruling_faction_key = faction_court:ruling_faction()
               if faction_key == ruling_faction_key then
                    -- the court leader should have the same elite mercenary units available
                    -- the units should not stack if they hold both positions, so the other positions have this flag to skip it
                    return
               end
          end

          local position_units = court.position_functions.get_position_mercenary_units(faction_court, court_position_obj)
          if not position_units then
               -- this position does not provide any units
               return
          end

          local faction_obj = cm:get_faction(faction_key)
          court.mercenary_functions.add_units_to_mercenary_pool(faction_court, court_position_obj, faction_obj,
               position_units, court_position_obj.name)
     end,

     -- we need to update them
     update_position_mercenary_units = function(faction_court, court_position_obj)
          local faction_key = court_position_obj.persistent.current_holder_faction
          if not faction_key then
               return
          end

          local faction_has_unlocked_court = feature_unlock.is_feature_unlocked_for_faction(
          court_position_obj.persistent.current_holder_faction, feature_ids_config.court)
          if not faction_has_unlocked_court then
               -- mercenary units are given only when the faction has unlocked the court
               return
          end

          if court_position_obj.position_config.do_not_provide_mercenary_units_to_court_leader then
               local ruling_faction_key = faction_court:ruling_faction()
               if faction_key == ruling_faction_key then
                    -- the court leader should have the same elite mercenary units available
                    -- the units should not stack if they hold both positions, so the other positions have this flag to skip it
                    return
               end
          end

          local position_units = court.position_functions.get_position_mercenary_units(faction_court, court_position_obj)
          if not position_units then
               -- this position does not provide any units
               return
          end

          local faction_obj = cm:get_faction(faction_key)
          court.mercenary_functions.change_units_in_mercenary_pool(faction_court, court_position_obj, faction_obj,
               position_units, court_position_obj.name)
     end,

     -- returns the mercenary units provided to the faction from holding the positon
     get_request_mercenary_units = function(faction_court, court_position_obj)
          local has_pschent_crown = court.util_functions.is_pschent_crown_equipped(faction_court)
          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court,
               court_position_obj)

          if court_specific_config then
               if has_pschent_crown
                   and is_table(court_specific_config.request_units_pschent_pschent)
               then
                    return court_specific_config.request_units_pschent_pschent
               end

               if is_table(court_specific_config.request_units) then
                    return court_specific_config.request_units
               end
          end

          if has_pschent_crown
              and is_table(court_position_obj.position_config.request_units_pschent_pschent)
          then
               return court_position_obj.position_config.request_units_pschent_pschent
          end

          return court_specific_config.request_units
     end,

     get_request_bonus_packs = function(faction_court, court_position_obj, request_index)
          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court,
               court_position_obj)

          if not court_specific_config then
               return nil
          end

          local court_specific_request_bonuses = nil
          if court_specific_config.request_bonus_packs
              and court_specific_config.request_bonus_packs[request_index]
          then
               court_specific_request_bonuses = court_specific_config.request_bonus_packs[request_index]
          end

          local has_pschent_crown = court.util_functions.is_pschent_crown_equipped(faction_court)
          if has_pschent_crown
              and court_specific_config.pschent_crown_override_request_bonus_packs
              and court_specific_config.pschent_crown_override_request_bonus_packs[request_index] then
               court_specific_request_bonuses = court_specific_config.pschent_crown_override_request_bonus_packs
               [request_index]
          end

          return court_specific_request_bonuses
     end,

     -- gives bonuses only until the next shemsu hor
     give_request_bonus_packs = function(faction_court, court_position_obj, request_index, faction_key)
          -- we find out how long the bonuses should last
          local turns_to_shemsu_hor = shemsu_hor.get_turns_to_shemsu_hor()
          if turns_to_shemsu_hor == 0 then
               turns_to_shemsu_hor = shemsu_hor.get_shemsu_hor_period()
          end

          -- we find the bonuses themselves
          local court_specific_request_bonuses = court.position_functions.get_request_bonus_packs(faction_court,
               court_position_obj, request_index)
          if court_specific_request_bonuses then
               for _, bonus_id in ipairs(court_specific_request_bonuses) do
                    cm:apply_effect_bundle(bonus_id, faction_key, turns_to_shemsu_hor)
               end
          end
     end,

     --- @function give_position_internal
     --- @desc Does a few final checks the character can hold the position, it is vacant and gives it to them
     --- @p object faction_court - one of the courts listed in court.all_courts
     --- @p object character_obj - the script interface of the character
     --- @p string court_position_str - the court position key (name or alt_name)
     --- @p [opt=false] bool suppress_eligibility_checks - if provided we skip the eligibility test
     --- @p [opt=false] bool skip_payment - if set to anything other than false/nil the faction will not pay for the position
     --- @p [opt=false] bool initial_holder - indicates this is called at game start and not from normal game change
     --- @p [opt=false] bool has_legitimacy_war_just_ended - mainly called from "Court_ScriptEventLegitimacyWarEnded" event listener to indicate that the legitimacy war has just ended; this is used because at this point *political_states:political_state() would still return "legitimacy_war"
     --- @p [opt=true] bool test_position - if the function should test the character for already holding a positon
     --- @return true, if the position is given, and nil if there was an error
     give_position_internal = function(faction_court,
                                       character_obj,
                                       court_position_str,
                                       suppress_eligibility_checks,
                                       skip_payment,
                                       initial_holder,
                                       has_legitimacy_war_just_ended,
                                       test_position
     )
          if test_position == nil then
               test_position = true
          end
          -- if this is a claim for the faction_court leader position and the faction_court is currently under a legitimacy war then the claimant can't get the position
          if (not suppress_eligibility_checks)
              and (not has_legitimacy_war_just_ended)
              and court.util_functions.is_in_legitimacy_war(faction_court)
              and court_position_str == faction_court.config.ruler_position
          then
               return nil
          end

          if not suppress_eligibility_checks then
               local is_character_eligible, error_message = court.util_functions.is_character_eligible(faction_court,
                    character_obj, test_position)
               if not is_character_eligible then
                    court.output("Error: character is not eligible due to :" .. error_message .. "!", 10)
                    return nil
               end
          end

          local character_forename = character_obj:get_forename()
          local court_position = court.util_functions.get_court_position(faction_court, court_position_str)
          if court_position.persistent.current_holder ~= nil then
               court.output(
               "Error: trying to set " ..
               character_forename ..
               " as " ..
               court_position_str ..
               " but the position is occupied by " .. tostring(court_position.persistent.current_holder), 10)
               return nil
          end

          local family_member_cqi = character_obj:family_member():command_queue_index()
          local target_character_lookup = "family_member_cqi:" .. family_member_cqi

          for available_position_name, _ in dpairs(faction_court.config.available_positions) do
               local current_holder = court.util_functions.get_character_at_position(faction_court,
                    available_position_name)
               if current_holder == target_character_lookup then
                    -- if the character was in another position we free it
                    -- (perhaps we should control this behavior via parameter)
                    court.position_functions.remove_character_from_position(faction_court, available_position_name)
                    break
               end
          end

          local faction_key = character_obj:faction():name()

          if not skip_payment then
               local claim_cost_obj = court.position_functions.get_claim_position_cost_obj(faction_court, faction_key)
               local faction_obj = cm:get_faction(faction_key)
               cm:faction_apply_resource_transaction(faction_obj, claim_cost_obj)
               court.util_functions.increase_used_court_actions_for_faction(faction_court, faction_key, 1)
          end

          local position_localized_string, _ = court.position_functions.get_localized_position_name(court_position,
               faction_court)
          cm:set_script_state(character_obj, court.developer_config.shared_state.position_key_state, court_position_str)
          cm:set_script_state(character_obj, court.developer_config.shared_state.position_localized_name_state,
               position_localized_string)

          court_position.persistent.current_holder = target_character_lookup
          court_position.persistent.current_holder_family_member_CQI = family_member_cqi
          court_position.persistent.current_holder_faction = faction_key

          local faction_persistent_data = court.util_functions.get_faction_persistent_data(faction_key)
          if not faction_persistent_data.owned_positions then
               faction_persistent_data.owned_positions = {}
          end
          table.insert(faction_persistent_data.owned_positions, court_position_str)
          faction_persistent_data.faction_court_name = faction_court.court_name

          if not faction_persistent_data.shemsu_hor_marks then
               faction_persistent_data.shemsu_hor_marks = {}
          end

          court.output("Long live the new " .. court_position_str .. " - " .. target_character_lookup .. ";", 1)

          local faction_has_unlocked_court = feature_unlock.is_feature_unlocked_for_faction(faction_key,
               feature_ids_config.court)
          if faction_has_unlocked_court then
               court.position_functions.give_position_bonuses(faction_court, character_obj, court_position)
          end

          if not court.util_functions.is_court_legitimacy_unlocked(faction_court, faction_key) then
               court.util_functions.unlock_legitimacy(faction_court, faction_key, true)
          end

          local added_legitimacy = court.position_functions.get_position_legitimacy_gain(court_position, faction_key)
          if added_legitimacy ~= 0 then
               faction_court.court_legitimacy():add_legitimacy(faction_key,
                    faction_court.config.court_legitimacy_positions_factor_key, added_legitimacy)
          end

          -- if there are no units in the position config, none will be given, there is no need to check here
          court.position_functions.give_position_mercenary_units(faction_court, court_position, faction_key)

          court_position.persistent.turn_gained = cm:model():turn_number()
          if court_position.on_position_gained then
               court_position:on_position_gained(faction_court, character_obj)
          end

          if not initial_holder then
               for current_faction_key, faction_data in dpairs(court.factions_config) do
                    if current_faction_key ~= "default"
                        and court.util_functions.get_faction_court_for_faction(current_faction_key) == faction_court
                        and faction_key ~= current_faction_key
                    then
                         local regard_gained = faction_data.new_position_regard_gained
                         if regard_gained and regard_gained > 0 then
                              -- by design, extra regard is only given when the faction has one or more positions
                              -- this could include the court leader position
                              local faction_persistent_data = court.util_functions.get_faction_persistent_data(
                              current_faction_key)
                              if faction_persistent_data
                                  and faction_persistent_data.owned_positions
                                  and #faction_persistent_data.owned_positions > 0
                              then
                                   local diplomacy_multiplier = court.position_functions
                                   .get_diplomacy_regard_change_multiplier(court_position, faction_key)
                                   local modified_regard = diplomacy_multiplier * regard_gained
                                   court.position_functions.change_regard_towards_faction_by_obj(court_position,
                                        current_faction_key, modified_regard)
                              end
                         end
                    end
               end

               if faction_key == cm:get_local_faction_name(true) then
                    court.log_functions.log_court_action("position_gained", faction_key, court_position_str,
                         family_member_cqi)

                    local owned_positions_number = #faction_persistent_data.owned_positions
                    local available_positions_number = table_size(faction_court.config.available_positions)
                    local event_data =
                    {
                         faction = cm:get_faction(faction_key),
                         court_name = faction_court.court_name,
                         owned_positions_number = owned_positions_number,
                         faction_filled_all_positions = owned_positions_number >= available_positions_number,
                    }
                    core:trigger_event("ScriptEventCourtPositionGained", event_data)

                    cm:notify_court_position_gained(faction_key, court_position_str)
               end

               court.event_message_functions.send_court_position_gained_event(faction_court, court_position)
          end

          core:trigger_event("ScriptEventCourtFactionGainedCourtPosition", {
               faction_key = faction_key,
               court_position_key = court_position_str,
               character = character_obj,
          })

          return true
     end,

     get_position_legitimacy_gain = function(position_obj, faction_key)
          local base_legitimacy = 0
          if position_obj.position_config and position_obj.position_config.legitimacy_provided then
               base_legitimacy = base_legitimacy + position_obj.position_config.legitimacy_provided
          end

          local faction_config = court.util_functions.get_faction_config(faction_key)
          if faction_config
              and faction_config.additional_legitimacy_positions
              and is_number(faction_config.additional_legitimacy_positions[position_obj.name])
          then
               base_legitimacy = base_legitimacy + faction_config.additional_legitimacy_positions[position_obj.name]
          end
          return base_legitimacy
     end,

     -- this includes the bonuses to the faction and character, from the position config and court override, also the ones overriden by owning the Pschent crown
     give_position_bonuses = function(faction_court, character_obj, court_position_obj)
          local has_pschent_crown = court.util_functions.is_pschent_crown_equipped(faction_court)
          local faction_key = court_position_obj.persistent.current_holder_faction

          local faction_bonuses = court.position_functions.get_position_faction_bonuses(faction_court, court_position_obj,
               has_pschent_crown)
          if faction_bonuses then
               for _, bonus_id in ipairs(faction_bonuses) do
                    cm:apply_effect_bundle(bonus_id, faction_key, -1)
               end
          end

          local char_CQI = character_obj:command_queue_index()
          local character_bonuses = court.position_functions.get_position_character_bonuses(faction_court,
               court_position_obj, has_pschent_crown)
          if character_bonuses then
               for _, character_bonus_id in ipairs(character_bonuses) do
                    cm:apply_effect_bundle_to_character(character_bonus_id, char_CQI, -1)
               end
          end
     end,

     --- @function remove_character_from_position
     --- @desc Vacates the position
     --- @p object faction_court - one of the courts listed in court.all_courts
     --- @p string court_position_str - the court position key (name or alt_name)
     --- @p [opt = nil] bool forced_removal - if 'true' the character was removed by force, the faction can't reclaim the position for a set amount of turns (position_kicked_ban_duration)
     --- @return true, if the position is vacated, and nil if there was an error
     remove_character_from_position = function(faction_court, court_position_str, forced_removal)
          local court_position = court.util_functions.get_court_position(faction_court, court_position_str)
          if court_position.persistent.current_holder == nil then
               court.output(
               "Error: trying to remove holder of " .. court_position_str .. " position, but it is empty already!", 10)
               return nil
          end

          local character_obj = cm:get_character(court_position.persistent.current_holder)
          local faction_key = court_position.persistent.current_holder_faction

          -- this might be nil if the faction was destroyed - then the character is not active
          if character_obj and (not character_obj:is_null_interface()) then
               court.position_functions.remove_position_bonuses(faction_court, character_obj, court_position)

               -- we remove any units provided by this position (if any)
               court.mercenary_functions.remove_units_by_source(faction_court, court_position, court_position.name)
               if court_position.on_position_lost then
                    court_position:on_position_lost(faction_court, character_obj)
               end
          end

          -- all the plots towards this position are now invalid
          court.plot_functions.invalidate_plots(faction_court.court_name, court_position.name)

          court.output(
          "Down with " ..
          tostring(court_position.persistent.current_holder) .. " they are no longer " .. court_position_str .. "!", 1)

          local faction_persistent_data = court.util_functions.get_faction_persistent_data(faction_key)
          if faction_persistent_data.owned_positions then
               local removed_successfully = table_erase(faction_persistent_data.owned_positions, court_position.name)
               if (not removed_successfully) and court_position.alt_name then
                    -- perhaps it was recorded as owned under the alternative name, we try to remove it this way
                    removed_successfully = table_erase(faction_persistent_data.owned_positions, court_position.alt_name)
               end
               if not removed_successfully then
                    court.output(
                    "Error: Encountered problem removing " ..
                    court_position_str ..
                    " from the positions held by " .. court_position.persistent.current_holder_faction .. "!", 10)
               end
          else
               court.output("Error: no owned_positions for " .. faction_key .. "!", 10)
          end

          if faction_key == cm:get_local_faction_name(true) then
               court.log_functions.log_court_action("position_lost", faction_key, court_position_str,
                    court_position.persistent.current_holder_family_member_CQI)
          end

          if character_obj and (not character_obj:is_null_interface()) then
               cm:remove_script_state(character_obj, court.developer_config.shared_state.position_key_state)
               cm:remove_script_state(character_obj, court.developer_config.shared_state.position_localized_name_state)
          end

          local added_legitimacy = court.position_functions.get_position_legitimacy_gain(court_position, faction_key)
          if added_legitimacy ~= 0 then
               faction_court.court_legitimacy():add_legitimacy(faction_key,
                    faction_court.config.court_legitimacy_positions_factor_key, -added_legitimacy)
          end

          court.event_message_functions.send_court_position_abandoned_event(faction_court, court_position)
          court_position.persistent.current_holder = nil
          court_position.persistent.current_holder_family_member_CQI = nil
          court_position.persistent.current_holder_faction = nil

          if court.config.reset_position_regard_on_becoming_vacant then
               -- once a position becomes vacant all regard towards it is lost
               court_position.persistent.regard = nil
          end

          if forced_removal == true then
               local faction_persistent_data = court.util_functions.get_faction_persistent_data(faction_key)
               -- at this turn the faction will be able to claim the position again
               local ban_end_turn = court.config.position_kicked_ban_duration + cm:model():turn_number()
               if not is_table(faction_persistent_data.position_bans) then
                    faction_persistent_data.position_bans = {}
               end
               faction_persistent_data.position_bans[court_position_str] = court.config.position_kicked_ban_duration +
               cm:model():turn_number()
          end

          core:trigger_event("ScriptEventCourtFactionLostCourtPosition", {
               faction_key = faction_key,
               court_position_key = court_position_str,
          })

          return true
     end,

     -- this includes the bonuses to the faction and character, from the position config and court override, also the ones overriden by owning the Pschent crown
     remove_position_bonuses = function(faction_court, character_obj, court_position_obj)
          local has_pschent_crown = court.util_functions.is_pschent_crown_equipped(faction_court)
          local faction_key = court_position_obj.persistent.current_holder_faction

          local faction_bonuses = court.position_functions.get_position_faction_bonuses(faction_court, court_position_obj,
               has_pschent_crown)
          if faction_bonuses then
               for _, bonus_id in ipairs(faction_bonuses) do
                    cm:remove_effect_bundle(bonus_id, faction_key)
               end
          end

          local char_CQI = character_obj:command_queue_index()
          local character_bonuses = court.position_functions.get_position_character_bonuses(faction_court,
               court_position_obj, has_pschent_crown)
          if character_bonuses then
               for _, character_bonus_id in ipairs(character_bonuses) do
                    cm:remove_effect_bundle_from_character(character_bonus_id, char_CQI)
               end
          end
     end,

     -- there are the bonuses applied to the position-holding faction, possibly overriden by the pschent crown
     get_position_faction_bonuses = function(faction_court, court_position_obj, has_pschent_crown)
          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court,
               court_position_obj)

          if not court_specific_config then
               -- there are no court specific bonuses for this position
               return nil
          end

          local faction_bonuses = court_specific_config.bonus_pack
          -- giving the faction bonuses from the position or position override
          if has_pschent_crown
              and court_specific_config.pschent_crown_override_bonus_pack then
               faction_bonuses = court_specific_config.pschent_crown_override_bonus_pack
          end
          return faction_bonuses
     end,

     -- there are the bonuses applied to the position-holding character, possibly overriden by the pschent crown
     get_position_character_bonuses = function(faction_court, court_position_obj, has_pschent_crown)
          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court,
               court_position_obj)

          -- there are no court specific bonuses for this position
          if not court_specific_config then
               return nil
          end

          local character_bonuses = court_specific_config.character_bonus_pack
          -- giving the faction bonuses from the position or position override
          if has_pschent_crown
              and court_specific_config.pschent_crown_override_character_bonus_pack then
               character_bonuses = court_specific_config.pschent_crown_override_character_bonus_pack
          end
          return character_bonuses
     end,

     get_kick_from_position_cost_obj = function(court_position_obj, faction_obj, court_obj)
          local position_holder_key = court_position_obj.persistent.current_holder_faction
          local legitimacy = court_obj.court_legitimacy():get_legitimacy(position_holder_key)
          local base_kick_cost = legitimacy

          local cost_multiplier = court.config.position_kick_cost_multiplier_legitimacy

          local related_region_obj = court.util_functions.get_position_related_region(court_obj, court_position_obj)
          local court_specific_config = court.util_functions.get_position_config_from_court(court_obj, court_position_obj)
          if related_region_obj then
               local region_owner = related_region_obj:owning_faction()
               if region_owner
                   and (not region_owner:is_null_interface())
                   and region_owner:name() == position_holder_key
               then
                    cost_multiplier = cost_multiplier * court.config.position_kick_cost_multiplier_region
               end
          end

          local final_kick_cost = base_kick_cost * cost_multiplier
          local kick_cost_obj = cm:create_new_custom_resource_cost()
          kick_cost_obj:add_resource_cost("troy_gold", court.config.court_resource_factor, final_kick_cost)
          return kick_cost_obj
     end,

     -- only faction leaders can kick from positions, but anyone else should not see the button at all so we're not checking this here
     can_kick_from_position = function(court_position_obj, faction_obj, kick_cost_obj)
          local error_message = ""

          local faction_key = faction_obj:name()
          local available_actions = court.util_functions.get_available_court_actions(faction_key)
          if available_actions == 0 then
               local text, _ = get_localised_text_replacement_and_source_formatted(
               court.plots.localization_keys.faction_out_of_court_actions, 1)
               error_message = court.util_functions.append_as_red_bullet_point(error_message, text)
          end

          local can_afford = faction_obj:can_afford_resource_cost_object(kick_cost_obj)
          if not can_afford then
               local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
               .can_not_afford_court_action)
               error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
          end

          local faction_persistent_data = court.util_functions.get_faction_persistent_data(faction_key)
          local kick_cooldown_end_turn = faction_persistent_data.kick_cooldown_end_turn or 0
          local current_turn = cm:model():turn_number()
          if kick_cooldown_end_turn > current_turn then
               local claim_turn_str = tostring(kick_cooldown_end_turn)
               local cooldown_remaining = kick_cooldown_end_turn - current_turn
               local cooldown_remaining_str = tostring(cooldown_remaining)
               local formatter_text, _ = get_localised_text_replacement_and_source_safe_formatted(
               court.ui.config.localization_keys.cooldown_ends_X_turns, cooldown_remaining_str)
               error_message = court.util_functions.append_as_red_bullet_point(error_message, formatter_text)
          end

          local has_pending_dilemma = court.util_functions.is_dilemma_active()
          if has_pending_dilemma then
               local localized_error, _ = get_localised_random_string_and_source(court.ui.config.localization_keys
               .dilemma_is_active)
               error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_error)
          end

          if error_message == "" then
               return true
          end

          return false, error_message
     end,

     -- returns the key of the region required for the position - can be nil if there is none
     get_position_related_region_key = function(court_obj, position_obj)
          local court_specific_config = court.util_functions.get_position_config_from_court(court_obj, position_obj)
          if not court_specific_config then
               return nil
          end

          local related_region_key = court_specific_config.related_region_key
          if not related_region_key then
               return nil
          end

          return related_region_key
     end,

     -- returns the script interface of the region required for the position - can be nil if there is none
     get_position_related_region_obj = function(court_obj, position_obj)
          local related_region_key = court.position_functions.get_position_related_region_key(court_obj, position_obj)
          if not related_region_key then
               return nil
          end

          local related_region_obj = cm:get_region(related_region_key)
          if (not related_region_obj) or related_region_obj:is_null_interface() then
               return nil
          end

          return related_region_obj
     end,

     --------------------------
     -- regard related

     --- @function get_regard_towards_faction
     --- @desc similar to get_position_regard_towards_faction, but takes the position table
     --- @p object position_obj - the table with the court position
     --- @p string faction_key - the key for faction
     --- @return integer - the regard towards the faction
     get_regard_towards_faction = function(position_obj, faction_key)
          if not position_obj.persistent.regard then
               return 0
          end

          if not position_obj.persistent.regard[faction_key] then
               return 0
          end

          return position_obj.persistent.regard[faction_key]
     end,

     get_diplomacy_regard_change_multiplier = function(position_obj, faction_key)
          local diplomacy_regard_multiplier = court.position_functions
          .get_diplomacy_regard_change_multiplier_between_factions(faction_key,
               position_obj.persistent.current_holder_faction)
          return diplomacy_regard_multiplier
     end,

     get_diplomacy_regard_change_multiplier_between_factions = function(faction_key, second_faction_key)
          local faction_obj = cm:get_faction(faction_key)
          -- the diplomacy categories are in DIPLOMATIC_ATTITUDE_CATEGORY, from 0 (DIPLOMATIC_ATTITUDE_CATEGORY_HOSTILE)  to 6 (DIPLOMATIC_ATTITUDE_CATEGORY_BEST_FRIENDS), with 3 being neutral
          local attitude_category = faction_obj:attitude_category_with(second_faction_key)
          if is_number(court.config.diplomacy_regard_config[attitude_category]) then
               return court.config.diplomacy_regard_config[attitude_category]
          end
          return 1
     end,

     change_regard_towards_faction_by_name = function(faction_court, court_position_str, faction_key, regard_delta)
          local position_obj = court.util_functions.get_court_position(faction_court, court_position_str)
          court.position_functions.change_regard_towards_faction_by_obj(position_obj, faction_key, regard_delta)
     end,

     change_regard_towards_faction_by_obj = function(position_obj, faction_key, regard_delta)
          if position_obj.persistent.current_holder_faction == faction_key then
               court.output(faction_key ..
               " tried to  gain regard with position " .. position_obj.name .. " but it is held by the same faction.")
               return
          end

          if not position_obj.persistent.regard then
               position_obj.persistent.regard = {}
          end

          if not position_obj.persistent.regard[faction_key] then
               position_obj.persistent.regard[faction_key] = 0
          end

          local new_regard = position_obj.persistent.regard[faction_key] + regard_delta
          local min_regard = court.position_functions.get_min_regard_for_faction(faction_key)
          if new_regard < min_regard then
               new_regard = min_regard
          end

          position_obj.persistent.regard[faction_key] = new_regard

          court.output("Regard by '" ..
          position_obj.name ..
          "' towards '" ..
          faction_key .. "' changed by " .. regard_delta .. " and now is " .. position_obj.persistent.regard
          [faction_key])
     end,

     set_regard_towards_faction_by_name = function(faction_court, court_position_str, faction_key, new_regard)
          local position_obj = court.util_functions.get_court_position(faction_court, court_position_str)
          court.position_functions.set_regard_towards_faction_by_obj(position_obj, faction_key, new_regard)
     end,

     set_regard_towards_faction_by_obj = function(position_obj, faction_key, new_regard)
          if not position_obj.persistent.regard then
               position_obj.persistent.regard = {}
          end

          if not position_obj.persistent.regard[faction_key] then
               position_obj.persistent.regard[faction_key] = 0
          end

          if position_obj.persistent.regard[faction_key] ~= new_regard then
               if new_regard < 0 then
                    new_regard = 0
               end

               position_obj.persistent.regard[faction_key] = new_regard
               court.output("Regard by '" ..
               position_obj.name ..
               "' towards '" .. faction_key .. "' is now " .. position_obj.persistent.regard[faction_key])
          end
     end,

     get_position_regard_towards_faction_by_obj = function(position_obj, faction_key)
          if not position_obj.persistent.regard then
               return 0
          end

          if not position_obj.persistent.regard[faction_key] then
               return 0
          end

          return position_obj.persistent.regard[faction_key]
     end,

     -- returns usable regard and current regard of the position towards the faction
     -- usable regard may be different because some factions can have minimum regard less than 0
     get_position_regard_data_towards_faction_by_obj = function(position_obj, faction_key)
          local current_regard = court.position_functions.get_position_regard_towards_faction_by_obj(position_obj,
               faction_key)
          local min_regard = court.position_functions.get_min_regard_for_faction(faction_key)
          local usable_regard = current_regard - min_regard

          return usable_regard, current_regard
     end,

     get_min_regard_for_faction = function(faction_key)
          local result = court.util_functions.get_property(faction_key, "min_regard")
          return result
     end,

     -- end of regard related
     -------------------------------------------

     get_valid_contender_scores = function(faction_court, faction_key, min_valid_score)
          local print_values = court_cheat.print_contender_values
          local main_contender_candidate_value, debug_value = court.position_functions.get_faction_claim_candidate_value(
          faction_court, faction_key, print_values)

          if print_values then
               debug_value = "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\nPRIMARY FACTION SCORE:\n" .. debug_value
          end
          local valid_contender_scores = {}
          local faction_list = cm:model():world():faction_list()
          for i = 0, faction_list:num_items() - 1 do
               local faction_obj = faction_list:item_at(i)
               local contender_key = faction_obj:name()
               if contender_key ~= faction_key and court.position_functions.is_valid_contender(faction_court, faction_obj) then
                    local candidate_value, contender_debug_value = court.position_functions
                    .get_faction_claim_candidate_value(faction_court, contender_key, print_values)
                    if print_values then
                         debug_value = debug_value ..
                         "\n=============================\n contender base score:\n" .. contender_debug_value
                    end

                    candidate_value = candidate_value -
                    (main_contender_candidate_value * court.config.claim_position_cost.player_coefficient)
                    if (not is_number(min_valid_score))
                        or candidate_value >= min_valid_score
                    then
                         if print_values then
                              debug_value = debug_value ..
                              "\nVALID CONTENDER\nScore after comparing with primary candidate:\n  " .. candidate_value
                         end
                         local legitimacy = faction_court.court_legitimacy():get_legitimacy(contender_key)
                         local score_table =
                         {
                              faction_key = contender_key,
                              faction_obj = faction_obj,
                              candidate_value = candidate_value,
                              legitimacy = legitimacy,
                              court_name = faction_court.court_name,
                         }
                         table.insert(valid_contender_scores, score_table)
                    else
                         if print_values then
                              debug_value = debug_value ..
                              "\nScore after comparing with primary candidate:\n  " .. candidate_value
                         end
                    end
               end
          end

          -- we need it to only print once or it will spam the world
          if court_cheat.print_contender_values then
               court.output(debug_value, 100)
               court_cheat.print_contender_values = false
          end
          return valid_contender_scores
     end,

     is_valid_contender = function(faction_court, faction)
          local contender_key = faction:name()

          -- first we exclude non-subjects, factions without a court or from a different court or without unlocked legitimacy
          local is_subject = court.util_functions.is_subject_to_leader(faction_court, faction)
          if not is_subject then
               return false
          end

          local actual_court_for_faction = court.util_functions.get_faction_court_for_faction(contender_key)
          if actual_court_for_faction ~= faction_court then
               return false
          end

          local legitimacy_unlocked = court.util_functions.is_court_legitimacy_unlocked(faction_court, contender_key)
          if (not legitimacy_unlocked) and faction:is_human() then
               return false
          end

          -- I am NOT checking if the faction can claim the position (court.util_functions.can_claim_position_directly(...) )
          -- I can't check for affordability without entering infinite recursion (can_claim_position_directly calls get_claim_position_cost_obj)
          -- and most of the conditions are static (shemsu hor, legitimacy war), and do not vary between factions

          -- instead, I need to check if the faction has positions and if that disqualifies it from being a contender (config setting)
          local faction_table = court.util_functions.get_faction_persistent_data(contender_key)
          local has_positions = is_table(faction_table.owned_positions) and #faction_table.owned_positions > 0
          if (not court.config.claim_position_cost.include_position_holders_as_pretenders)
              and has_positions
          then
               return false
          end

          return true
     end,

     get_claim_position_cost_obj = function(faction_court, faction_key)
          local cost_obj = cm:create_new_custom_resource_cost()
          -- this is the main way to set up costs
          if court.config.claim_position_cost.claim_position_resource_costs_record then
               cost_obj:get_cost_from_record(court.config.claim_position_cost.claim_position_resource_costs_record)
          elseif court.config.claim_position_cost.claim_test_cost then
               for _, resource_info in ipairs(court.config.claim_position_cost.claim_test_cost) do
                    cost_obj:add_resource_cost(resource_info[1], court.config.court_resource_factor, resource_info[2])
               end
          end

          local valid_contender_scores = court.position_functions.get_valid_contender_scores(faction_court, faction_key,
               court.config.claim_position_cost.min_valid_score_claim_price_calculation)
          valid_contender_scores = table_stable_sort(valid_contender_scores,
               function(a, b) return a.candidate_value > b.candidate_value end)

          local number_of_top_contenders = math.min(#valid_contender_scores,
               court.config.claim_position_cost.top_contenders_to_sum)
          local top_candidates_sum = 0
          for index = 1, number_of_top_contenders do
               local valid_contender_score = valid_contender_scores[index]
               -- scores can be negative, only the positive affect the cost
               if valid_contender_score.candidate_value > 0 then
                    top_candidates_sum = top_candidates_sum + valid_contender_score.candidate_value
               end
          end

          cost_obj:multiply_by(top_candidates_sum)

          local faction_specific_multiplier = court.util_functions.get_property(faction_key, "claim_cost_multiplier") or
          1
          if faction_specific_multiplier ~= 1 then
               cost_obj:multiply_by(faction_specific_multiplier)
          end

          if court.util_functions.is_related_to_leader(faction_court, faction_key) then
               cost_obj:multiply_by(court.config.related_claim_multiplier)
          end

          -- possibly check for discounts and apply them, similar to get_intrigue_full_cost_obj
          return cost_obj
     end,

     get_faction_claim_candidate_value = function(faction_court, faction_key, add_debug_string)
          local legitimacy = faction_court.court_legitimacy():get_legitimacy(faction_key)
          local legitimacy_value = legitimacy * court.config.claim_position_cost.legitimacy_coefficient

          local faction_obj = cm:get_faction(faction_key)
          local strength = faction_obj:strength()
          local strength_value = strength * court.config.claim_position_cost.strength_coefficient

          local candidate_value = legitimacy_value + strength_value
          if not add_debug_string then
               return candidate_value
          end

          local output_string = "base value for '" .. faction_key .. "':" .. candidate_value
          output_string = output_string ..
          "\n legitimacy:" .. legitimacy .. "; \n weighted legitimacy:" .. legitimacy_value
          output_string = output_string .. " \n strength:" .. strength .. "; \n weighted strength:" .. strength_value
          return candidate_value, output_string
     end,

     -- sets the ruling faction leader to the ruling position
     -- does not free the position if there is no leader
     set_court_ruling_position_faction_after_legitimacy_war = function(faction_court_obj)
          local ruling_faction_key = faction_court_obj:ruling_faction()
          -- if there is no court leader return
          if not ruling_faction_key then
               return
          end

          local ruling_faction_obj = cm:get_faction(ruling_faction_key)
          if not ruling_faction_obj or (ruling_faction_obj:is_null_interface()) then
               return
          end

          local ruling_position_str = faction_court_obj.config.ruler_position
          local ruler_character_obj = ruling_faction_obj:faction_leader()
          local result = court.position_functions.give_position_internal(faction_court_obj, ruler_character_obj,
               ruling_position_str,
               true, -- suppress_eligibility_checks
               true, -- skip_payment
               false, -- initial_holder
               true -- has_legitimacy_war_just_ended
          )
     end,
     ---------------------------------------------------------------
     -- e.g. mark_position(position_obj, "phar_main_seti", "assist")
     -- will create position_obj.persistent.shemsu_hor_marks["phar_main_seti"]["assist"] == {},
     -- which signifies Seti already used an 'assist' intrigue this Shemsu Hor and should not do so again!

     mark_position = function(position_obj, ...)
          if not position_obj.persistent.shemsu_hor_marks then
               position_obj.persistent.shemsu_hor_marks = {}
          end

          local root = position_obj.persistent.shemsu_hor_marks
          for _, mark in ipairs(arg) do
               if not root[mark] then
                    root[mark] = {}
               end

               root = root[mark]
          end
     end,

     mark_position_with_value = function(position_obj, value, ...)
          if not position_obj.persistent.shemsu_hor_marks then
               position_obj.persistent.shemsu_hor_marks = {}
          end

          local root = position_obj.persistent.shemsu_hor_marks
          local param_count = #arg
          for index, mark in ipairs(arg) do
               if index == param_count then
                    root[mark] = value
                    return
               end

               if not root[mark] then
                    root[mark] = {}
               end

               root = root[mark]
          end
     end,

     -- e.g. is_position_marked(position_obj, "phar_main_seti", "assist")
     -- checks if position_obj.persistent.shemsu_hor_marks["phar_main_seti"]["assist"] exists
     -- which in this example signifies Seti already used an 'assist' intrigue this Shemsu Hor and should not do so again!
     is_position_marked = function(position_obj, ...)
          if not position_obj.persistent.shemsu_hor_marks then
               return false
          end

          local root = position_obj.persistent.shemsu_hor_marks
          for _, mark in ipairs(arg) do
               if not root[mark] then
                    return false
               end

               root = root[mark]
          end

          return true
     end,

     -- can be used to get a value when mark_position_with_value was used
     get_position_mark_value = function(position_obj, ...)
          if not position_obj.persistent.shemsu_hor_marks then
               return nil
          end

          local root = position_obj.persistent.shemsu_hor_marks
          for _, mark in ipairs(arg) do
               if not root[mark] then
                    return nil
               end

               root = root[mark]
          end

          return root
     end,

     clear_position_mark = function(position_obj, ...)
          local node_parent = position_obj.persistent
          local node = position_obj.persistent.shemsu_hor_marks
          local last_mark = nil
          for _, mark in ipairs(arg) do
               if not node[mark] then
                    return nil
               end
               last_mark = mark
               node_parent = node
               node = node[mark]
          end

          if node_parent[last_mark] then
               node_parent[last_mark] = nil
          end
     end,

     get_position_icon = function(position_obj, faction_court)
          local icon_path = position_obj.icon_path

          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, position_obj)
          if court_specific_config and court_specific_config.icon_path then
               -- this court has a different, specific icon for this position
               icon_path = court_specific_config.icon_path
          end

          return icon_path
     end,

     get_position_name_localization_key = function(position_obj, faction_court)
          local localization_key = position_obj.name_localization_key

          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, position_obj)
          if court_specific_config and court_specific_config.localization_key then
               -- this court has a different, specific name for this position
               localization_key = court_specific_config.localization_key
          end

          return localization_key
     end,

     get_localized_position_name = function(position_obj, faction_court)
          local localization_key = court.position_functions.get_position_name_localization_key(position_obj,
               faction_court)
          local localized_name = common.get_localised_string(localization_key)
          return localized_name, localization_key
     end,

     get_localized_position_description = function(position_obj, faction_court)
          local localization_key = position_obj.description_localization_key
          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, position_obj)
          if court_specific_config and court_specific_config.description_localization_key then
               -- this court has overrides for this position
               localization_key = court_specific_config.description_localization_key
          end
          local localized_description = common.get_localised_string(localization_key)
          return localized_description
     end,

     get_localized_position_benefits = function(position_obj, faction_court, faction_key)
          local benefits_list = position_obj.benefits_localization_keys
          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, position_obj)
          if court_specific_config and court_specific_config.benefits_localization_keys then
               -- this court has overrides for this position
               benefits_list = court_specific_config.benefits_localization_keys
          end

          local localized_benefits = {}
          for _, localization_key in ipairs(benefits_list) do
               local benefit = {}
               benefit.benefit_text = common.get_localised_string(localization_key)
               table.insert(localized_benefits, benefit)
          end
          -- we add the provided legitimacy as benefit
          local added_legitimacy = court.position_functions.get_position_legitimacy_gain(position_obj, faction_key)
          local provided_legitimacy_string, source = get_localised_text_replacement_and_source_formatted(
          court.ui.config.localization_keys.position_benefits_legitimacy, faction_court.config
          .court_legitimacy_text_icon, added_legitimacy)
          local benefit = {}
          benefit.benefit_text = provided_legitimacy_string
          table.insert(localized_benefits, benefit)
          return localized_benefits
     end,

     get_position_help_page_key = function(position_obj, faction_court)
          local help_page_key = position_obj.help_page_key

          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, position_obj)
          if court_specific_config and court_specific_config.help_page_key then
               -- this court has a different, specific name for this position
               help_page_key = court_specific_config.help_page_key
          end

          return help_page_key
     end,

     -- Currently this is not expected to be called in the game, but is remaining here for future content, like DLC
     instantly_finish_building_constructions_on_region = function(region, max_building_level, enable_ers_construction)
          local slots = region:slot_list()
          local num_slots = slots:num_items()

          for k = 0, num_slots - 1 do
               local slot = slots:item_at(k)
               if slot:is_there_construction() then
                    local construction_key = slot:construction_building_level_record_name()
                    local construction_level = slot:construction_building_level_record_level()
                    local slot_is_ers = slot:is_infrastructure_slot()
                    if construction_key ~= ""
                        and construction_level <= max_building_level
                        and (not slot_is_ers or enable_ers_construction)
                    then
                         cm:instantly_upgrade_building_in_region_slot(slot, construction_key)
                    end
               end
          end

          local event_data =
          {
               region_key = region:name(),
               max_building_level = max_building_level,
               enable_ers_construction = enable_ers_construction,
          }
          core:trigger_event("ScriptEventCourtInstantConstructionOnRegion", event_data)
     end,

     get_localized_request_name = function(request_obj)
          if not request_obj then
               court.output(
               "ERROR: court.position_functions.get_localized_request_name() called with invalid `request` object!")
               return nil
          end

          if not request_obj.ui_config then
               court.output(
               "ERROR: court.position_functions.get_localized_request_name() called with invalid `request.ui_config` object!")
               return nil
          end

          if not request_obj.ui_config.name_localization_key then
               court.output(
               "ERROR: court.position_functions.get_localized_request_name() called with invalid localization key!")
               return nil
          end

          local request_localization_key = request_obj.ui_config.name_localization_key
          return common.get_localised_string(request_localization_key)
     end,

     -- checks if we need to show the force_disband_button when playing with the judge against rebels
     handle_popup_pre_battle_open = function(component)
          local pb = cm:model():pending_battle()
          local local_faction_name = cm:get_local_faction_name(true)
          if (not pb) or
              (not pb:has_attacker()) or
              (not pb:attacker():faction():name() == local_faction_name)
          then
               return
          end

          local court_obj = court.util_functions.get_faction_court_for_faction(local_faction_name)
          if not court_obj then
               return
          end

          if not court.disband_rebels_functions.can_disband_defender(pb:attacker(), pb:defender()) then
               return
          end

          local force_disband_button
          if cm:model():pending_battle():siege_battle() then
               -- Rebels can't take over settlements with garisons, so disbanding them should not be a problem
               force_disband_button = find_uicomponent(component, "button_set_siege", "button_disband_enemy")
          else
               force_disband_button = find_uicomponent(component, "button_set_attack", "button_disband_enemy")
          end

          force_disband_button:SetVisible(true)
     end,

     should_show_court_discount_notifications = function(faction_key)
          if shemsu_hor.is_active and not shemsu_hor.is_shemsu_hor() then
               return false
          end

          local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
          if not court_obj then
               return false
          end

          local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
          if faction_table.owned_positions then
               for _, owned_position in ipairs(faction_table.owned_positions) do
                    local court_position_obj = court.util_functions.get_court_position(court_obj, owned_position)
                    if court.discount_functions.can_position_give_discounts(court_position_obj) then
                         local remaining_cooldown = court.discount_functions.get_choose_discounts_remaining_cooldown(
                         court_position_obj)
                         if remaining_cooldown <= 0 then
                              return true
                         end
                    end
               end
          end
          return false
     end,

     can_faction_give_discounts_position = function(court_obj, faction_key, position_key)
          local position_obj = court.util_functions.get_court_position(court_obj, position_key)
          if (not position_obj)
              or (not position_obj.persistent)
              or (not position_obj.persistent.current_holder_faction)
              or (position_obj.persistent.current_holder_faction ~= faction_key)
          then
               return false
          end

          -- if the faction already set the discounts this Shemsu Hor, there is no need to set a reminder to set them again
          local has_set_discounts = court.position_functions.is_position_marked(position_obj, "set_discounts",
               faction_key)
          if has_set_discounts then
               return false
          end

          return true
     end,
} -- position_functions

-- there are a lot of requests that give units, which have the same functions but different configs
court.unit_request_functions =
{
     get_effect_info = function(request_obj, faction_court, position_obj, faction_key)
          local localized_info = common.get_localised_string(request_obj.ui_config.effect_description_localization_key)
          return localized_info
     end,

     -- returns bool for success and, if false, the reason request can't be used
     can_use_request = function(request_obj, faction_court, position_obj, faction_key)
          local result = ""
          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, position_obj)
          if court_specific_config
              and not court_specific_config.is_unit_request_available_to_court_leader
          then
               -- we check if the faction is also the court leader - the mercenary units do not stack!
               local ruler_position = faction_court.config.ruler_position
               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
               if faction_table.owned_positions
                   and table_find(faction_table.owned_positions, ruler_position)
               then
                    -- we could just return the result since it is a single check, but I want it consistent, and ready to easily copy-paste if another check appears
                    result = court.util_functions.append_as_red_bullet_point(result,
                         get_localised_random_string(request_obj.ui_config.court_leader_cant_call_localization_key))
               end
          end
          if result == "" then
               return true, ""
          end

          return false, result
     end,

     call_request = function(request_obj, faction_court, position_obj, faction_key)
          -- Request Elites - spawns a small amount of Royal units in Special Recruitment. They are available until Shemsu Hor;
          court.output(faction_key .. " used request '" ..
          request_obj.request_name .. "' with " .. position_obj.name .. ";")
          local faction_obj = cm:get_faction(faction_key)
          local provided_units = court.position_functions.get_request_mercenary_units(faction_court, position_obj)
          -- when Shemsu Hor is active, units given from requests are removed when it arrives
          -- if Shemsu Hor is not active, we need to remember when they were given and remove them after the requests expires
          local remove_at_turn = nil
          if not shemsu_hor.is_active then
               local current_turn = cm:model():turn_number()
               remove_at_turn = current_turn + court.config.non_shemsu_hor_request_cooldown
          end
          -- remove_at_turn is OK to be nil, when there is no need to remove units at a specific turn
          court.mercenary_functions.add_units_to_mercenary_pool(faction_court, position_obj, faction_obj, provided_units,
               "request", remove_at_turn)
          return true
     end,
} -- court.unit_request_functions

-- there are some positions which can set discounts for categories for all factions in the Court
court.discount_functions =
{
     can_position_give_discounts = function(position_obj)
          if position_obj.position_config and is_table(position_obj.position_config.shemsu_hor_possible_effects) then
               return true
          end
          return false
     end,

     on_round_start = function(position_obj, faction_court)
          if not court.discount_functions.can_position_give_discounts(position_obj) then
               return
          end

          if not position_obj.persistent.current_holder then
               return
          end

          local faction_has_unlocked_court = feature_unlock.is_feature_unlocked_for_faction(
          position_obj.persistent.current_holder_faction, feature_ids_config.court)
          if not faction_has_unlocked_court then
               return
          end

          -- if Shemsu Hor is used, the discounts are applied on the turn after Shemsu Hor
          -- is Shemsu Hor is not used, discounts are applied every turn
          if (shemsu_hor.is_active and shemsu_hor.get_turns_to_shemsu_hor() == shemsu_hor.get_shemsu_hor_period() - 1)
              or (not shemsu_hor.is_active)
          then
               -- the discounts are updated every turn (or the round after Shemsu Hor, if it is enabled)
               court.discount_functions.give_shemsu_hor_discounts(position_obj, faction_court)
               position_obj.persistent.influenced_discounts = {}
               position_obj.persistent.influenced_amount = 0
               -- this will change the discounts on behalf of the AI, if needed
               court.discount_functions.check_ai_choose_discounts(position_obj, faction_court)
          end
     end,

     check_ai_choose_discounts = function(position_obj, faction_court)
          if not position_obj.persistent.current_holder then
               -- we only apply the bonuses if the position is occupied
               return
          end

          local holder_faction_obj = cm:get_faction(position_obj.persistent.current_holder_faction)
          if holder_faction_obj:is_human() then
               -- we don't change the discounts if the position is held by a player
               return
          end

          local remaining_cooldown = court.discount_functions.get_choose_discounts_remaining_cooldown(position_obj)
          if remaining_cooldown > 0 then
               -- the AI already set the discounts recently
               return
          end

          local has_pschent_crown = court.util_functions.is_pschent_crown_equipped(faction_court)
          local possible_sets = nil
          if has_pschent_crown then
               possible_sets = position_obj.position_config.ai_sets_pschent
          else
               possible_sets = position_obj.position_config.ai_sets
          end

          if not is_table(possible_sets) then
               return
          end

          local random_index = cm:model():random_int(1, #possible_sets)
          local random_set = possible_sets[random_index]
          if not is_table(random_set) then
               return
          end

          court.discount_functions.choose_discount_amounts(position_obj, faction_court, random_set)
     end,

     give_shemsu_hor_discounts = function(position_obj, faction_court)
          if not court.discount_functions.can_position_give_discounts(position_obj) then
               return
          end

          if not position_obj.persistent.current_holder then
               -- we only apply the bonuses if the position is occupied
               return
          end

          if not court.config.give_discounts_from_AI_positions then
               -- with this set to false, the AI should not give discounts, unless influenced
               local holder_faction_obj = cm:get_faction(position_obj.persistent.current_holder_faction)
               if (not holder_faction_obj:is_human())
                   and (
                        (not position_obj.persistent.influenced_discounts)
                        or is_empty_table(position_obj.persistent.influenced_discounts)
                   )
               then
                    return
               end
          end

          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, position_obj)
          local discount_bundle_used = court_specific_config.discounts_bundle
          local discounts_scope = court_specific_config.discounts_scope
          local bundle = cm:create_new_custom_effect_bundle(discount_bundle_used)
          local discount_values = court.discount_functions.get_chosen_discounts(position_obj)

          -- with the new logic, the discounts are updated every turn (but still need 2 turns or will immediately time out)
          local duration = 2
          if shemsu_hor.is_active then
               -- if Shemsu Hor is inactive, the discounts last for the entire period
               duration = shemsu_hor.get_shemsu_hor_period()
          end
          local effects = position_obj.position_config.shemsu_hor_possible_effects
          for index, effect_table in ipairs(effects) do
               local amount = discount_values[index] or 0
               if amount ~= 0 then
                    -- cost modifications need to be negative to be discounts
                    bundle:add_effect(effect_table.effect_id, discounts_scope, -amount)
               end
          end

          -- discounts last only for one Shemsu Hor period, and have to be reapplied
          bundle:set_duration(duration)

          local applicable_factions = court.util_functions.get_factions_in_regions(faction_court.config.sacred_lands)
          for _, faction_obj in ipairs(applicable_factions) do
               local faction_name = faction_obj:name()
               local region_holder_court = court.util_functions.get_faction_court_for_faction(faction_name)
               if region_holder_court == faction_court then
                    cm:apply_custom_effect_bundle_to_faction(bundle, faction_obj)
               end
          end
     end,

     choose_discount_amounts = function(position_obj, faction_court, amounts)
          -- verify the amounts are valid
          local error_found = false
          local bonuses_sum = 0
          for index, amount in ipairs(amounts) do
               if amount < 0 or amount > position_obj.position_config.max_discount then
                    error_found = true
                    court.output(
                    "Error: when choosing discounts the one at index '" ..
                    index ..
                    "' was " ..
                    amount .. " which is outside the valid values 0-" .. position_obj.position_config.max_discount, 10)
               end

               local divisibility = amount
               if amount ~= 0 then
                    divisibility = math.fmod(amount, position_obj.position_config.discount_increment)
               end

               if divisibility ~= 0 then
                    error_found = true
                    court.output(
                    "Error: when choosing discounts the one at index '" ..
                    index ..
                    "' was " .. amount .. " which is not divisible by " ..
                    position_obj.position_config.discount_increment, 10)
               end

               if position_obj.persistent.influenced_discounts and
                   position_obj.persistent.influenced_discounts[index] and
                   position_obj.persistent.influenced_discounts[index] > amount
               then
                    error_found = true
                    court.output(
                    "Error: when choosing discounts the one at index '" ..
                    index ..
                    "' was " ..
                    amount ..
                    " which is less than the one fixed by a large request:" ..
                    position_obj.persistent.influenced_discounts[index], 10)
               end

               bonuses_sum = amount + bonuses_sum
          end

          local discount_sum = court.discount_functions.get_discounts_sum(position_obj, faction_court)
          if bonuses_sum ~= discount_sum then
               error_found = true
               court.output(
               "Error: when choosing discounts the sum was " ..
               bonuses_sum .. " which is not the set up value of:" .. discount_sum, 10)
          end

          if not error_found then
               position_obj.persistent.chosen_discounts = amounts
               local cooldown_end_turn = court.shemsu_hor.get_cooldown_end_turn()
               court.position_functions.mark_position_with_value(position_obj, cooldown_end_turn,
                    position_obj.persistent.current_holder_faction, "set_discounts", "cooldown_end_turn")
               if court.config.apply_discounts_immediately_on_set then
                    court.discount_functions.give_shemsu_hor_discounts(position_obj, faction_court)
               end
               return true
          else
               return false
          end
     end,

     get_chosen_discounts = function(position_obj)
          if position_obj.persistent.chosen_discounts then
               return position_obj.persistent.chosen_discounts
          end

          return position_obj.position_config.shemsu_hor_initial_discounts
     end,

     -- the position holder can change the chosen discounts only once every X turns (normally 6 from the Shemsu Hor period)
     -- returns the turns remaining until cooldown is over, 0 or negative mean cooldown is over
     get_choose_discounts_remaining_cooldown = function(position_obj)
          if not position_obj.persistent.current_holder_faction then
               return -1
          end
          local cooldown_end_turn = court.position_functions.get_position_mark_value(position_obj,
               position_obj.persistent.current_holder_faction, "set_discounts", "cooldown_end_turn")
          if not is_number(cooldown_end_turn) then
               return -1
          end

          local current_turn = cm:model():turn_number()
          if current_turn > cooldown_end_turn then
               return -1
          end
          return cooldown_end_turn - current_turn
     end,

     can_influence_discounts = function(position_obj)
          local influenced_already = position_obj.persistent.influenced_amount
          if not influenced_already then
               influenced_already = 0
          end

          -- if another influence would push the amount over the max sum we don't allow it
          -- we limit the amount of discount that can be influenced to only the original amount, disregarding the crown increase of discount sum
          -- because if more than the original amount is influenced (locked), and the crown is removed, we can't reduce it to the new sum!
          if influenced_already + position_obj.position_config.large_request_fixed_amount > position_obj.position_config.discount_sum then
               return false
          end

          return true
     end,

     get_discounts_sum = function(position_obj, faction_court)
          local result = position_obj.position_config.discount_sum
          local has_pschent_crown = court.util_functions.is_pschent_crown_equipped(faction_court)
          if has_pschent_crown then
               result = result * court.config.pschent_crown_effect_multiplier
          end

          return result
     end,

     get_number_of_categories_to_influence = function(position_obj, faction_court)
          local result = position_obj.position_config.num_categories_to_influence or 0
          local has_pschent_crown = court.util_functions.is_pschent_crown_equipped(faction_court)
          if has_pschent_crown then
               result = result * court.config.pschent_crown_effect_multiplier
          end

          return result
     end,

     on_crown_state_changed = function(position_obj, phar_court, crown_equipped)
          -- DISCOUNTS
          if not position_obj.position_config then
               return
          end
          -- even if the position is vacant we still need to update the default discounts
          local standard_discount_sum = position_obj.position_config.discount_sum
          if not standard_discount_sum then
               -- position with no discounts do not need to handle this
               return
          end
          local pschent_favour_multiplier = court.config.pschent_crown_effect_multiplier
          local crown_discount_sum = standard_discount_sum * pschent_favour_multiplier

          local change_needed = 0
          if crown_equipped then
               change_needed = crown_discount_sum - standard_discount_sum
          else
               change_needed = standard_discount_sum - crown_discount_sum
          end

          if change_needed > 0 then
               court.discount_functions.increase_chosen_discounts(position_obj, phar_court, change_needed)
          else
               -- we must send a positive number
               court.discount_functions.reduce_chosen_discounts(position_obj, phar_court, -change_needed)
          end
     end,

     reduce_chosen_discounts = function(position_obj, phar_court, reduction_needed)
          local new_chosen_amounts = {}
          local old_chosen_amounts = court.discount_functions.get_chosen_discounts(position_obj)
          for i = 1, #position_obj.position_config.shemsu_hor_possible_effects do
               -- on game start some of the values may be missing, indicating 0
               local old_chosen_amount = old_chosen_amounts[i] or 0
               if position_obj.persistent.influenced_discounts
                   and position_obj.persistent.influenced_discounts[i]
                   and position_obj.persistent.influenced_discounts[i] >= old_chosen_amount
               then
                    -- this category is fixed, we can't reduce it
                    table.insert(new_chosen_amounts, position_obj.persistent.influenced_discounts[i])
               else
                    local new_amount = old_chosen_amount
                    if reduction_needed > 0 then
                         if old_chosen_amount >= reduction_needed then
                              -- this discount alone more than compensates for the reduction, we reduce it
                              new_amount = old_chosen_amount - reduction_needed
                              reduction_needed = 0
                         else
                              -- we need to reduce the discount from this category entirely to offset the reduction needed
                              new_amount = 0
                              reduction_needed = reduction_needed - old_chosen_amount
                         end
                    end

                    table.insert(new_chosen_amounts, new_amount)
               end
          end

          return court.discount_functions.choose_discount_amounts(position_obj, phar_court, new_chosen_amounts)
     end,

     increase_chosen_discounts = function(position_obj, phar_court, increase_needed)
          local new_chosen_amounts = {}
          local old_chosen_amounts = court.discount_functions.get_chosen_discounts(position_obj)
          for i = 1, #position_obj.position_config.shemsu_hor_possible_effects do
               -- on game start some of the values may be missing, indicating 0
               local old_chosen_amount = old_chosen_amounts[i] or 0
               if position_obj.persistent.influenced_discounts
                   and position_obj.persistent.influenced_discounts[i]
                   and position_obj.persistent.influenced_discounts[i] >= old_chosen_amount
               then
                    -- this category is fixed, we can't change it
                    table.insert(new_chosen_amounts, position_obj.persistent.influenced_discounts[i])
               else
                    local new_amount = old_chosen_amount
                    if increase_needed > 0 then
                         local change_possible = position_obj.position_config.large_request_fixed_amount -
                         old_chosen_amount
                         if change_possible >= increase_needed then
                              -- this discount alone more than compensates for the increase, we increase it
                              new_amount = old_chosen_amount + increase_needed
                              increase_needed = 0
                         else
                              -- we need to increase the discount from this category to its max to offset the increase needed
                              new_amount = position_obj.position_config.large_request_fixed_amount
                              increase_needed = increase_needed - change_possible
                         end
                    end

                    table.insert(new_chosen_amounts, new_amount)
               end
          end

          return court.discount_functions.choose_discount_amounts(position_obj, phar_court, new_chosen_amounts)
     end,

} -- court.discount_functions

-- factions can influence the discounts with a request for the positions that give the discounts
court.influence_discounts_functions =
{
     get_effect_info = function(request_obj, faction_court, position_obj, faction_key)
          local localized_text, _ = get_localised_text_replacement_and_source_formatted(
          request_obj.ui_config.effect_description_localization_key,
               position_obj.position_config.large_request_fixed_amount)
          return localized_text
     end,

     -- returns bool for success and, if false, the reason request can't be used
     can_use_request = function(request_obj, faction_court, position_obj, faction_key, chosen_category_index)
          local result = ""
          if not court.discount_functions.can_influence_discounts(position_obj) then
               local position_localized_string = court.position_functions.get_localized_position_name(position_obj,
                    faction_court)
               local localized_text, _ = get_localised_text_replacement_and_source_formatted(
               court.ui.config.localization_keys.position_has_maximum_fixed_amount, position_localized_string)
               result = court.util_functions.append_as_red_bullet_point(result, localized_text)
          end

          if not position_obj.persistent.influenced_discounts then
               position_obj.persistent.influenced_discounts = {}
          end

          if not position_obj.persistent.influenced_amount then
               position_obj.persistent.influenced_amount = 0
          end

          if chosen_category_index then
               local categories_count = #position_obj.position_config.shemsu_hor_possible_effects
               if chosen_category_index < 1 or chosen_category_index > categories_count then
                    local localized_text, __ = get_localised_text_replacement_and_source_formatted(
                    request_obj.ui_config.cant_call_invalid_range_localization_key, chosen_category_index,
                         categories_count)
                    result = court.util_functions.append_as_red_bullet_point(result, localized_text)
               end
          end

          if result == "" then
               return true, ""
          end

          return false, result
     end,

     call_request = function(request_obj, faction_court, position_obj, faction_key, categories)
          -- Influence Discounts - force one or more categories to gain 25% discount on the next turn (used to be after Shemsu Hor). Usable with cooldown

          local num_influenced_categories = court.discount_functions.get_number_of_categories_to_influence(position_obj,
               faction_court)
          if #categories ~= num_influenced_categories then
               court.output(
               "Received " ..
               #categories ..
               " categories to influence, but by config we should influence " .. num_influenced_categories .. "!", 10)
               return false
          end

          court.output(faction_key ..
          " used request '" ..
          request_obj.request_name .. "' with " ..
          position_obj.name .. " and " .. num_influenced_categories .. " indexes ")

          for i = 1, num_influenced_categories do
               local chosen_category_str = categories[i]
               local chosen_category_index = tonumber(chosen_category_str)
               local result = court.influence_discounts_functions.influence_category(request_obj, faction_court,
                    position_obj, faction_key, chosen_category_index)
               if not result then
                    return false
               end
          end

          -- if we influence the discounts we can see them as well at any time
          -- unlike other once-per-shemsu-hor items, if we have Shemsu Hor disabled discounts get applied next turn
          -- this is why we can only see them until the next turn
          local cooldown_end_turn = -1
          if shemsu_hor.is_active then
               cooldown_end_turn = court.shemsu_hor.get_cooldown_end_turn()
          else
               cooldown_end_turn = cm:model():turn_number() + 1
          end
          -- we mark the turn the cooldown ends
          local court_specific_config = court.util_functions.get_position_config_from_court(faction_court, position_obj)
          local can_see_discounts_mark = court_specific_config.can_see_discounts_mark
          court.position_functions.mark_position_with_value(position_obj, cooldown_end_turn, can_see_discounts_mark,
               faction_key, "cooldown_end_turn")
          if court.config.apply_discounts_immediately_on_influence then
               court.discount_functions.give_shemsu_hor_discounts(position_obj, faction_court)
          end
          return true
     end,

     -- sets the category discount to the max
     -- if needed - decreases non-locked discounts to keep within the max
     influence_category = function(request_obj, faction_court, position_obj, faction_key, chosen_category_index)
          local is_request_accessibile = request_obj:can_use_request(faction_court, position_obj, faction_key,
               chosen_category_index)
          if not is_request_accessibile then
               return nil
          end

          court.output(" influencing index " .. chosen_category_index)

          if position_obj.persistent.influenced_discounts[chosen_category_index] == position_obj.position_config.large_request_fixed_amount then
               -- somebody already requested the same thing, we have nothing more to do
               return true
          end

          position_obj.persistent.influenced_discounts[chosen_category_index] = position_obj.position_config
          .large_request_fixed_amount
          position_obj.persistent.influenced_amount = position_obj.persistent.influenced_amount +
          position_obj.position_config.large_request_fixed_amount

          -- if the request increased the discount in a category we may have to reduce another discount so the sum remains the same
          -- first we calculate the new sum
          local new_sum = 0
          local old_chosen_amounts = court.discount_functions.get_chosen_discounts(position_obj)
          for i = 1, #position_obj.position_config.shemsu_hor_possible_effects do
               local old_discount = old_chosen_amounts[i] or 0
               if position_obj.persistent.influenced_discounts[i] and position_obj.persistent.influenced_discounts[i] > old_discount then
                    new_sum = new_sum + position_obj.persistent.influenced_discounts[i]
               else
                    new_sum = new_sum + old_discount
               end
          end

          local reduction_needed = new_sum - court.discount_functions.get_discounts_sum(position_obj, faction_court)
          if reduction_needed <= 0 then
               return true
          end

          court.discount_functions.reduce_chosen_discounts(position_obj, faction_court, reduction_needed)
          return true
     end,
}

-- factions can disband rebels if they have the appropriate position or have made the appropriate request
court.disband_rebels_functions =
{
     can_disband_defender = function(attacker_commander_obj, defender_commander_obj)
          -- only rebels can be disbanded
          if (not defender_commander_obj)
              or (not defender_commander_obj:faction():is_rebel())
          then
               return false
          end

          local attacker_faction_key = attacker_commander_obj:faction():name()
          local court_obj = court.util_functions.get_faction_court_for_faction(attacker_faction_key)
          if not court_obj then
               return false
          end
          local attacker_court_position_string = cm:get_string_script_state(attacker_commander_obj,
               court.developer_config.shared_state.position_key_state)
          if is_string(attacker_court_position_string) then
               local attacker_court_position_obj = court.util_functions.get_court_position(court_obj,
                    attacker_court_position_string)
               if attacker_court_position_obj
                   and attacker_court_position_obj.position_config.can_disband_rebels
               then
                    -- the position holder can use this ability every X turns
                    -- if there is a cooldown and it hasn't run out yet they can't use it again
                    local cooldown_end_turn = court.position_functions.get_position_mark_value(
                    attacker_court_position_obj, attacker_faction_key, "disband_rebellion", "cooldown_end_turn")
                    if is_number(cooldown_end_turn) then
                         local current_turn = cm:model():turn_number()
                         if current_turn < cooldown_end_turn then
                              return false
                         end
                    end
                    return true
               end
               -- the character has a position, but it does not grant this ability - we fall through to see if the request was used
          end

          -- player does not have a position which allows them to disband rebels
          -- they can pass judgement only if they have the large favour "Quash Rebellion" requested from HJ
          -- this favor grants the ability for a limited time.
          -- they can use it if they made the request and the timer has not run out yet
          local faction_table = court.util_functions.get_faction_persistent_data(attacker_faction_key)
          local current_turn = cm:model():turn_number()
          if (not is_number(faction_table.can_disband_rebellion_until_turn))
              or current_turn > faction_table.can_disband_rebellion_until_turn
          then
               -- no request was made, ability was used or timed out
               return false
          end
          return true
     end,

     disband_rebels = function(pending_battle)
          local defender_commander_obj = pending_battle:defender()
          if not court.disband_rebels_functions.can_disband_defender(pending_battle:attacker(), defender_commander_obj) then
               return false
          end

          local attacker_faction_key = pending_battle:attacker():faction():name()
          local court_obj = court.util_functions.get_faction_court_for_faction(attacker_faction_key)
          if not court_obj then
               return false
          end

          local attacker_family_cqi = pending_battle:attacker():family_member():command_queue_index()
          court.output("High Judge (or someone who made a request) disbanding a rebel army")
          cm:force_pending_battle_complete()
          local character_lookup_value = "character_cqi:" .. defender_commander_obj:command_queue_index()
          cm:kill_character(character_lookup_value, true)

          local attacker_court_position_string = cm:get_string_script_state(pending_battle:attacker(),
               court.developer_config.shared_state.position_key_state)
          if is_string(attacker_court_position_string) then
               local attacker_court_position_obj = court.util_functions.get_court_position(court_obj,
                    attacker_court_position_string)
               if attacker_court_position_obj then
                    -- this returns the next turn this character could use this ability
                    -- it is the turn after the next Shemsu Hor turn, or if disabled, the turn after one Shemsu Hor period
                    local cooldown_end_turn = court.shemsu_hor.get_cooldown_end_turn()
                    court.position_functions.mark_position_with_value(attacker_court_position_obj, cooldown_end_turn,
                         attacker_faction_key, "disband_rebellion", "cooldown_end_turn")
                    return true
               end
          end

          -- we gained this ability with a request. we must remove the value so we can't use it again
          local faction_table = court.util_functions.get_faction_persistent_data(attacker_faction_key)
          faction_table.can_disband_rebellion_until_turn = nil
          return true
     end,
}

court.judge_dilemmas =
{
     -- to force a dilemma set 'default_weight = 0' and add 'weight = 1,' in the dilemma you want
     default_weight = 1,

     -- localization keys
     region_ruling_text = "phar_main_court_judge_dilemma_rule_region",
     regard_change = "phar_main_court_judge_dilemma_regard_change",
     postpone = "phar_main_court_judge_dilemma_postpone",

     -- there are 4 commonly used sets of payloads:

     -- local means it is applied to the region of the dilemma, not the faction with the dilemma
     justice_served_local_bundle = "phar_main_court_judge_justice_served_region",
     justice_served_local_bundle_duration = 6,
     justice_served_faction_bundle = "phar_main_court_judge_justice_served_faction",
     justice_served_faction_bundle_duration = 6,
     justice_served_resource_record = "phar_main_court_judge_dilemma_justice_served",

     benevolence_faction_bundle = "phar_main_court_judge_charitable",
     benevolence_faction_bundle_duration = 6,

     bribed_faction_bundle = "phar_main_court_judge_bribed",
     bribed_faction_bundle_duration = 6,

     injustice_local_bundle = "phar_main_court_judge_injustice",
     injustice_local_bundle_duration = 6,

     dilemmas =
     {
          --Archetype: Judge against the Crown or take bribe
          -- the_palace_tax - phar_main_court_judge_dilemma_tuhkanti_1
          {
               court_judge_dilemma_type = "the_palace_tax",
               db_dilemma_key = "phar_main_court_judge_dilemma_tuhkanti_1",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_tuhkanti_1_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_tuhkanti_1_log_choice_2",
               option_1_regard_change = -60,
               option_2_regard_change = 60,

               targeted_position = "tuhkanti",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"

                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_1_regard_change)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_benevolence(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_2_regard_change)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_injustice(region_key)
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
                    local faction_key = context:faction():name()
                    local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
                    local position_obj = court.util_functions.get_court_position(court_obj, self.targeted_position)
                    local modified_regard_changed = 0
                    local choice = context:choice()
                    -- C gives 0-based choices, so 0 is the first one
                    if choice == 0 then
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_1_regard_change)
                    elseif choice == 1 then -- court_judge_DilemmaChoiceMadeEvent should not call this if the dilemma is postponed, but we can check just in case
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_2_regard_change)
                    end
                    court.position_functions.change_regard_towards_faction_by_name(court_obj, self.targeted_position,
                         faction_key, modified_regard_changed)
               end,
          },

          -- poisoner_exposed - phar_main_court_judge_dilemma_tuhkanti_2
          {
               court_judge_dilemma_type = "poisoner_exposed",
               db_dilemma_key = "phar_main_court_judge_dilemma_tuhkanti_2",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_tuhkanti_2_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_tuhkanti_2_log_choice_2",

               option_1_regard_change = -60,
               option_2_regard_change = 60,
               resource_record_option_2 = "phar_main_court_judge_dilemma_tuhkanti_2_choice_2",

               targeted_position = "tuhkanti",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"

                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice1_payload = choice1_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_1_regard_change)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_bribed(region_key)
                    choice2_payload = choice2_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_2_regard_change)

                    choice2_payload = choice2_payload .. "faction_pooled_resource_transaction{"
                    choice2_payload = choice2_payload .. "resource_cost " .. self.resource_record_option_2 .. ";}"

                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
                    local faction_key = context:faction():name()
                    local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
                    local position_obj = court.util_functions.get_court_position(court_obj, self.targeted_position)
                    local modified_regard_changed = 0
                    local choice = context:choice()
                    -- C gives 0-based choices, so 0 is the first one
                    if choice == 0 then
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_1_regard_change)
                    elseif choice == 1 then -- court_judge_DilemmaChoiceMadeEvent should not call this if the dilemma is postponed, but we can check just in case
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_2_regard_change)
                    end
                    court.position_functions.change_regard_towards_faction_by_name(court_obj, self.targeted_position,
                         faction_key, modified_regard_changed)
               end,
          },

          -- prices_of_oxen - phar_main_court_judge_dilemma_lawgiver_1
          {
               court_judge_dilemma_type = "prices_of_oxen",
               db_dilemma_key = "phar_main_court_judge_dilemma_lawgiver_1",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_lawgiver_1_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_lawgiver_1_log_choice_2",

               option_1_regard_change = -60,
               option_2_regard_change = 60,

               targeted_position = "lawgiver",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"

                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_1_regard_change)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_2_regard_change)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_injustice(region_key)
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
                    local faction_key = context:faction():name()
                    local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
                    local position_obj = court.util_functions.get_court_position(court_obj, self.targeted_position)
                    local modified_regard_changed = 0
                    local choice = context:choice()
                    -- C gives 0-based choices, so 0 is the first one
                    if choice == 0 then
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_1_regard_change)
                    elseif choice == 1 then -- court_judge_DilemmaChoiceMadeEvent should not call this if the dilemma is postponed, but we can check just in case
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_2_regard_change)
                    end
                    court.position_functions.change_regard_towards_faction_by_name(court_obj, self.targeted_position,
                         faction_key, modified_regard_changed)
               end,
          },

          -- cheap_copper - phar_main_court_judge_dilemma_lawgiver_2
          {
               court_judge_dilemma_type = "cheap_copper",
               db_dilemma_key = "phar_main_court_judge_dilemma_lawgiver_2",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_lawgiver_2_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_lawgiver_2_log_choice_2",

               option_1_regard_change = -60,
               option_2_regard_change = 60,
               option_2_resource_record = "phar_main_court_judge_dilemma_lawgiver_2_choice_2",

               targeted_position = "lawgiver",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"

                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_1_regard_change)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_benevolence(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_2_regard_change)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_bribed(region_key)
                    choice2_payload = choice2_payload .. "faction_pooled_resource_transaction{"
                    choice2_payload = choice2_payload .. "resource_cost " .. self.option_2_resource_record .. ";}"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
                    local faction_key = context:faction():name()
                    local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
                    local position_obj = court.util_functions.get_court_position(court_obj, self.targeted_position)
                    local modified_regard_changed = 0
                    local choice = context:choice()
                    -- C gives 0-based choices, so 0 is the first one
                    if choice == 0 then
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_1_regard_change)
                    elseif choice == 1 then -- court_judge_DilemmaChoiceMadeEvent should not call this if the dilemma is postponed, but we can check just in case
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_2_regard_change)
                    end
                    court.position_functions.change_regard_towards_faction_by_name(court_obj, self.targeted_position,
                         faction_key, modified_regard_changed)
               end,
          },

          -- taken_daughters - phar_main_court_judge_dilemma_chief_bodyguards_1
          {
               court_judge_dilemma_type = "taken_daughters",
               db_dilemma_key = "phar_main_court_judge_dilemma_chief_bodyguards_1",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_chief_bodyguards_1_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_chief_bodyguards_1_log_choice_2",

               option_1_regard_change = -60,
               option_2_regard_change = 60,
               -- copied from muwatalli_config.actions.gain_ancillary/ancillaries_list
               option_2_ancillaries_list = {
                    {
                         key = "phar_main_rare_equipment_axes_3",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_axes_4",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_axes_5",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_axes_6",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_bows_4",
                         weight = 10
                    },
                    {
                         key = "phar_main_rare_equipment_bows_5",
                         weight = 10
                    },
                    {
                         key = "phar_main_rare_equipment_chariots_1",
                         weight = 10
                    },
                    {
                         key = "phar_main_rare_equipment_chariots_2",
                         weight = 10
                    },
                    {
                         key = "phar_main_rare_equipment_chariots_4",
                         weight = 10
                    },
                    {
                         key = "phar_main_rare_equipment_chariots_5",
                         weight = 10
                    },
                    {
                         key = "phar_main_rare_equipment_bows_3",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_clubs_1",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_clubs_3",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_clubs_5",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_heavy_armour_1",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_heavy_armour_2",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_heavy_armour_3",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_heavy_armour_4",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_heavy_armour_5",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_heavy_armour_6",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_heavy_armour_7",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_large_shield_1",
                         weight = 7
                    },
                    {
                         key = "phar_main_rare_equipment_large_shield_2",
                         weight = 7
                    },
                    {
                         key = "phar_main_rare_equipment_large_shield_3",
                         weight = 7
                    },
                    {
                         key = "phar_main_rare_equipment_large_shield_5",
                         weight = 7
                    },
                    {
                         key = "phar_main_rare_equipment_large_shield_6",
                         weight = 7
                    },
                    {
                         key = "phar_main_rare_equipment_light_armour_1",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_light_armour_2",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_light_armour_8",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_medium_armour_1",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_medium_armour_3",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_medium_armour_4",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_medium_armour_5",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_medium_shield_1",
                         weight = 7
                    },
                    {
                         key = "phar_main_rare_equipment_medium_shield_3",
                         weight = 7
                    },
                    {
                         key = "phar_main_rare_equipment_medium_shield_4",
                         weight = 7
                    },
                    {
                         key = "phar_main_rare_equipment_medium_shield_5",
                         weight = 7
                    },
                    {
                         key = "phar_main_rare_equipment_spears_1",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_spears_2",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_spears_3",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_spears_6",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_swords_1",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_swords_2",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_swords_3",
                         weight = 5
                    },
                    {
                         key = "phar_main_rare_equipment_swords_5",
                         weight = 5
                    },
               },

               targeted_position = "chief_of_royal_bodyguards",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"

                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)

                    choice1_payload = choice1_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_1_regard_change)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_2_regard_change)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_bribed(region_key)
                    choice2_payload = choice2_payload .. "add_ancillary{ "
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local weighted_ancillaries_list = weighted_list:new()
                    for _, ancillary_entry in ipairs(self.option_2_ancillaries_list) do
                         weighted_ancillaries_list:add_item(ancillary_entry.key, ancillary_entry.weight)
                    end

                    local random_ancillary = weighted_ancillaries_list:weighted_select()
                    if not random_ancillary or #random_ancillary <= 0 then
                         script_error("Court Dilemma: " .. self.court_judge_dilemma_type .. "invalid ancillary key.")
                         return
                    end
                    choice2_payload = choice2_payload ..
                    "cqi " .. faction_leader_cqi .. "; ancillary " .. random_ancillary .. ";}"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
                    local faction_key = context:faction():name()
                    local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
                    local position_obj = court.util_functions.get_court_position(court_obj, self.targeted_position)
                    local modified_regard_changed = 0
                    local choice = context:choice()
                    -- C gives 0-based choices, so 0 is the first one
                    if choice == 0 then
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_1_regard_change)
                    elseif choice == 1 then -- court_judge_DilemmaChoiceMadeEvent should not call this if the dilemma is postponed, but we can check just in case
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_2_regard_change)
                    end
                    court.position_functions.change_regard_towards_faction_by_name(court_obj, self.targeted_position,
                         faction_key, modified_regard_changed)
               end,
          },

          -- bodyguards_for_hire - phar_main_court_judge_dilemma_chief_bodyguards_2
          {
               court_judge_dilemma_type = "bodyguards_for_hire",
               db_dilemma_key = "phar_main_court_judge_dilemma_chief_bodyguards_2",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_chief_bodyguards_2_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_chief_bodyguards_2_log_choice_2",

               option_1_regard_change = -60,
               option_2_regard_change = 60,

               targeted_position = "chief_of_royal_bodyguards",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_1_regard_change)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_benevolence(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_2_regard_change)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_injustice(region_key)
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
                    local faction_key = context:faction():name()
                    local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
                    local position_obj = court.util_functions.get_court_position(court_obj, self.targeted_position)
                    local modified_regard_changed = 0
                    local choice = context:choice()
                    -- C gives 0-based choices, so 0 is the first one
                    if choice == 0 then
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_1_regard_change)
                    elseif choice == 1 then -- court_judge_DilemmaChoiceMadeEvent should not call this if the dilemma is postponed, but we can check just in case
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_2_regard_change)
                    end
                    court.position_functions.change_regard_towards_faction_by_name(court_obj, self.targeted_position,
                         faction_key, modified_regard_changed)
               end,
          },

          -- nobles_dead_warriors - phar_main_court_judge_dilemma_commander_1
          {
               court_judge_dilemma_type = "nobles_dead_warriors",
               db_dilemma_key = "phar_main_court_judge_dilemma_commander_1",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_commander_1_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_commander_1_log_choice_2",

               option_1_regard_change = -60,
               option_2_regard_change = 60,

               targeted_position = "high_commander",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_1_regard_change)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_2_regard_change)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_injustice(region_key)
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
                    local faction_key = context:faction():name()
                    local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
                    local position_obj = court.util_functions.get_court_position(court_obj, self.targeted_position)
                    local modified_regard_changed = 0
                    local choice = context:choice()
                    -- C gives 0-based choices, so 0 is the first one
                    if choice == 0 then
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_1_regard_change)
                    elseif choice == 1 then -- court_judge_DilemmaChoiceMadeEvent should not call this if the dilemma is postponed, but we can check just in case
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_2_regard_change)
                    end
                    court.position_functions.change_regard_towards_faction_by_name(court_obj, self.targeted_position,
                         faction_key, modified_regard_changed)
               end,
          },

          -- raided_village - phar_main_court_judge_dilemma_commander_2
          {
               court_judge_dilemma_type = "raided_village",
               db_dilemma_key = "phar_main_court_judge_dilemma_commander_2",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_commander_2_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_commander_2_log_choice_2",

               option_1_regard_change = -60,
               option_2_regard_change = 60,

               targeted_position = "high_commander",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_1_regard_change)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_benevolence(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload ..
                    court.judge_dilemmas:get_payload_regard_changed(self.targeted_position, faction_key,
                         self.option_2_regard_change)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_bribed(region_key)
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
                    local faction_key = context:faction():name()
                    local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
                    local position_obj = court.util_functions.get_court_position(court_obj, self.targeted_position)
                    local modified_regard_changed = 0
                    local choice = context:choice()
                    -- C gives 0-based choices, so 0 is the first one
                    if choice == 0 then
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_1_regard_change)
                    elseif choice == 1 then -- court_judge_DilemmaChoiceMadeEvent should not call this if the dilemma is postponed, but we can check just in case
                         modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
                              self.option_2_regard_change)
                    end
                    court.position_functions.change_regard_towards_faction_by_name(court_obj, self.targeted_position,
                         faction_key, modified_regard_changed)
               end,
          },

          --Archetype: convict a man or hire them
          -- clay_sorcery - phar_main_court_judge_dilemma_hire_man_1
          {
               court_judge_dilemma_type = "clay_sorcery",
               db_dilemma_key = "phar_main_court_judge_dilemma_hire_man_1",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_hire_man_1_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_hire_man_1_log_choice_2",

               choice_2_ancillary = "phar_main_rare_10", -- Avid Collector

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "add_ancillary{ "
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    choice2_payload = choice2_payload ..
                    "cqi " .. faction_leader_cqi .. "; ancillary " .. self.choice_2_ancillary .. ";}"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- stolen_gems - phar_main_court_judge_dilemma_hire_man_2
          {
               court_judge_dilemma_type = "stolen_gems",
               db_dilemma_key = "phar_main_court_judge_dilemma_hire_man_2",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_hire_man_2_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_hire_man_2_log_choice_2",

               choice_1_ancillary_1 = "phar_main_rare_13", -- Gem Merchant
               choice_1_ancillary_2 = "phar_main_rare_49", -- malachite_jewellery
               choice_2_ancillary = "phar_main_rare_12", -- Smuggler

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. "add_ancillary{ "
                    choice1_payload = choice1_payload ..
                    "cqi " .. faction_leader_cqi .. "; ancillary " .. self.choice_1_ancillary_1 .. ";}"
                    choice1_payload = choice1_payload .. "add_ancillary{ "
                    choice1_payload = choice1_payload ..
                    "cqi " .. faction_leader_cqi .. "; ancillary " .. self.choice_1_ancillary_2 .. ";}"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "add_ancillary{ "
                    choice2_payload = choice2_payload ..
                    "cqi " .. faction_leader_cqi .. "; ancillary " .. self.choice_2_ancillary .. ";}"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- commoners_verdict - phar_main_court_judge_dilemma_hire_man_3
          {
               court_judge_dilemma_type = "commoners_verdict",
               db_dilemma_key = "phar_main_court_judge_dilemma_hire_man_3",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_hire_man_3_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_hire_man_3_log_choice_2",

               choice_1_ancillary = "phar_main_rare_11", -- Diplomat
               choice_1_bundle = "phar_main_court_high_judge_hire_man_3_choice_1",
               choice_1_bundle_duration = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. "effect_bundle{ bundle_key " .. self.choice_1_bundle .. ";"
                    choice1_payload = choice1_payload .. "turns " .. self.choice_1_bundle_duration .. "; }"
                    choice1_payload = choice1_payload .. "add_ancillary{ "
                    choice1_payload = choice1_payload ..
                    "cqi " .. faction_leader_cqi .. "; ancillary " .. self.choice_1_ancillary .. ";}"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- wanted - phar_main_court_judge_dilemma_hire_man_4
          {
               court_judge_dilemma_type = "wanted",
               db_dilemma_key = "phar_main_court_judge_dilemma_hire_man_4",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_hire_man_4_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_hire_man_4_log_choice_2",

               choice_2_ancillary = "phar_main_rare_14", -- Saboteur
               resource_record_option_2 = "phar_main_court_judge_dilemma_hire_man_4_choice_2",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_bribed(region_key)
                    choice2_payload = choice2_payload .. "faction_pooled_resource_transaction{"
                    choice2_payload = choice2_payload .. "resource_cost " .. self.resource_record_option_2 .. ";}"
                    choice2_payload = choice2_payload .. "add_ancillary{ "
                    choice2_payload = choice2_payload ..
                    "cqi " .. faction_leader_cqi .. "; ancillary " .. self.choice_2_ancillary .. ";}"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- a_noble_scorned - phar_main_court_judge_dilemma_hire_man_5
          {
               court_judge_dilemma_type = "a_noble_scorned",
               db_dilemma_key = "phar_main_court_judge_dilemma_hire_man_5",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_hire_man_5_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_hire_man_5_log_choice_2",

               resource_record_option_1 = "phar_main_court_judge_dilemma_hire_man_5_choice_1",
               choice_2_ancillary = "phar_main_rare_15", -- Duelist

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_injustice(region_key)
                    choice1_payload = choice1_payload .. "faction_pooled_resource_transaction{"
                    choice1_payload = choice1_payload .. "resource_cost " .. self.resource_record_option_1 .. ";}"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_benevolence(region_key)
                    choice2_payload = choice2_payload .. "add_ancillary{ "
                    choice2_payload = choice2_payload ..
                    "cqi " .. faction_leader_cqi .. "; ancillary " .. self.choice_2_ancillary .. ";}"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- two_fathers_two_sons - phar_main_court_judge_dilemma_hire_man_6
          {
               court_judge_dilemma_type = "two_fathers_two_sons",
               db_dilemma_key = "phar_main_court_judge_dilemma_hire_man_6",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_hire_man_6_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_hire_man_6_log_choice_2",

               resource_record_option_1 = "phar_main_court_judge_dilemma_hire_man_6_choice_1",
               choice_1_ancillary = "phar_main_rare_16", -- Blind Veteran
               resource_record_option_2 = "phar_main_court_judge_dilemma_hire_man_6_choice_2",
               choice_2_ancillary = "phar_main_rare_17", -- Strongman

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. "faction_pooled_resource_transaction{"
                    choice1_payload = choice1_payload .. "resource_cost " .. self.resource_record_option_1 .. ";}"
                    choice1_payload = choice1_payload .. "add_ancillary{ "
                    choice1_payload = choice1_payload ..
                    "cqi " .. faction_leader_cqi .. "; ancillary " .. self.choice_1_ancillary .. ";}"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "faction_pooled_resource_transaction{"
                    choice2_payload = choice2_payload .. "resource_cost " .. self.resource_record_option_2 .. ";}"
                    choice2_payload = choice2_payload .. "add_ancillary{ "
                    choice2_payload = choice2_payload ..
                    "cqi " .. faction_leader_cqi .. "; ancillary " .. self.choice_2_ancillary .. ";}"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          --Archetype: enforce tax/fee or waive it
          -- retribution_against_merchant - phar_main_court_judge_dilemma_enforce_tax_1
          {
               court_judge_dilemma_type = "retribution_against_merchant",
               db_dilemma_key = "phar_main_court_judge_dilemma_enforce_tax_1",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_enforce_tax_1_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_enforce_tax_1_log_choice_2",

               resource_record_option_2 = "phar_main_court_judge_dilemma_enforce_tax_1_choice_2",
               choice_2_bundle = "phar_main_court_judge_dilemma_enforce_tax_1_choice_2",
               choice_2_bundle_duration = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_injustice(region_key)
                    choice2_payload = choice2_payload .. "faction_pooled_resource_transaction{"
                    choice2_payload = choice2_payload .. "resource_cost " .. self.resource_record_option_2 .. ";}"
                    choice2_payload = choice2_payload .. "effect_bundle{ bundle_key " .. self.choice_2_bundle .. ";"
                    choice2_payload = choice2_payload .. "turns " .. self.choice_2_bundle_duration .. "; }"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- fighting_pit - phar_main_court_judge_dilemma_enforce_tax_2
          {
               court_judge_dilemma_type = "fighting_pit",
               db_dilemma_key = "phar_main_court_judge_dilemma_enforce_tax_2",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_enforce_tax_2_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_enforce_tax_2_log_choice_2",

               choice_2_bundle = "phar_main_court_judge_dilemma_enforce_tax_2_choice_2",
               choice_2_bundle_duration = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_injustice(region_key)
                    choice2_payload = choice2_payload .. "effect_bundle{ bundle_key " .. self.choice_2_bundle .. ";"
                    choice2_payload = choice2_payload .. "turns " .. self.choice_2_bundle_duration .. "; }"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- purification_of_animals - phar_main_court_judge_dilemma_enforce_tax_3
          {
               court_judge_dilemma_type = "purification_of_animals",
               db_dilemma_key = "phar_main_court_judge_dilemma_enforce_tax_3",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_enforce_tax_3_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_enforce_tax_3_log_choice_2",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_benevolence(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- light_bronze - phar_main_court_judge_dilemma_enforce_tax_4
          {
               court_judge_dilemma_type = "light_bronze",
               db_dilemma_key = "phar_main_court_judge_dilemma_enforce_tax_4",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_enforce_tax_4_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_enforce_tax_4_log_choice_2",

               choice_1_bundle = "phar_main_court_judge_dilemma_enforce_tax_4_choice_1",
               choice_1_bundle_duration = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_benevolence(region_key)
                    choice1_payload = choice1_payload .. "effect_bundle{ bundle_key " .. self.choice_1_bundle .. ";"
                    choice1_payload = choice1_payload .. "turns " .. self.choice_1_bundle_duration .. "; }"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)

                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- stray_sheep - phar_main_court_judge_dilemma_enforce_tax_5
          {
               court_judge_dilemma_type = "stray_sheep",
               db_dilemma_key = "phar_main_court_judge_dilemma_enforce_tax_5",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_enforce_tax_5_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_enforce_tax_5_log_choice_2",

               choice_1_bundle = "phar_main_court_judge_dilemma_enforce_tax_5_choice_1",
               choice_1_bundle_duration = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_benevolence(region_key)
                    choice1_payload = choice1_payload .. "effect_bundle{ bundle_key " .. self.choice_1_bundle .. ";"
                    choice1_payload = choice1_payload .. "turns " .. self.choice_1_bundle_duration .. "; }"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)

                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- drunken_sheep - phar_main_court_judge_dilemma_enforce_tax_6
          {
               court_judge_dilemma_type = "drunken_sheep",
               db_dilemma_key = "phar_main_court_judge_dilemma_enforce_tax_6",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_enforce_tax_6_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_enforce_tax_6_log_choice_2",

               choice_1_bundle = "phar_main_court_judge_dilemma_enforce_tax_6_choice_1",
               choice_1_bundle_duration = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader_cqi = faction_obj:faction_leader():command_queue_index()

                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_benevolence(region_key)
                    choice1_payload = choice1_payload .. "effect_bundle{ bundle_key " .. self.choice_1_bundle .. ";"
                    choice1_payload = choice1_payload .. "turns " .. self.choice_1_bundle_duration .. "; }"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)

                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          --Archetype: Divide Land/Property
          -- two_hairs_one_field_1 - phar_main_court_judge_dilemma_divide_land_1
          {
               court_judge_dilemma_type = "two_hairs_one_field_1",
               db_dilemma_key = "phar_main_court_judge_dilemma_divide_land_1",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_divinde_land_1_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_divinde_land_1_log_choice_2",

               choice_1_bundle = "phar_main_court_high_judge_divide_land_1_choice_1",
               choice_1_bundle_duration_turns = 6,
               choice_2_bundle = "phar_main_court_high_judge_divide_land_1_choice_2",
               choice_2_bundle_duration_turns = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. "effect_bundle{ bundle_key " .. self.choice_1_bundle .. ";"
                    choice1_payload = choice1_payload .. "turns " .. self.choice_1_bundle_duration_turns .. "; }"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "effect_bundle{ bundle_key " .. self.choice_2_bundle .. ";"
                    choice2_payload = choice2_payload .. "turns " .. self.choice_2_bundle_duration_turns .. "; }"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- royal_grant_1 - phar_main_court_judge_dilemma_divide_land_2
          {
               court_judge_dilemma_type = "royal_grant_1",
               db_dilemma_key = "phar_main_court_judge_dilemma_divide_land_2",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_divinde_land_2_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_divinde_land_2_log_choice_2",

               choice_2_bundle = "phar_main_court_high_judge_divide_land_2_choice_2",
               choice_2_bundle_duration_turns = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "effect_bundle{ bundle_key " .. self.choice_2_bundle .. ";"
                    choice2_payload = choice2_payload .. "turns " .. self.choice_2_bundle_duration_turns .. "; }"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },


          -- estate_with_no_heir_1 - phar_main_court_judge_dilemma_divide_land_3
          {
               court_judge_dilemma_type = "estate_with_no_heir_1",
               db_dilemma_key = "phar_main_court_judge_dilemma_divide_land_3",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_divinde_land_3_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_divinde_land_3_log_choice_2",

               choice_1_bundle = "phar_main_court_high_judge_divide_land_3_choice_1",
               choice_1_bundle_duration_turns = 6,
               choice_2_bundle = "phar_main_court_high_judge_divide_land_3_choice_2",
               choice_2_bundle_duration_turns = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. "effect_bundle{ bundle_key " .. self.choice_1_bundle .. ";"
                    choice1_payload = choice1_payload .. "turns " .. self.choice_1_bundle_duration_turns .. "; }"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "effect_bundle{ bundle_key " .. self.choice_2_bundle .. ";"
                    choice2_payload = choice2_payload .. "turns " .. self.choice_2_bundle_duration_turns .. "; }"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- two_hairs_one_field_2 - phar_main_court_judge_dilemma_divide_land_4
          {
               court_judge_dilemma_type = "two_hairs_one_field_2",
               db_dilemma_key = "phar_main_court_judge_dilemma_divide_land_4",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_divinde_land_4_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_divinde_land_4_log_choice_2",

               resource_record_option_1 = "phar_main_court_judge_dilemma_divide_land_4_choice_1",
               choice_2_bundle = "phar_main_court_high_judge_divide_land_4_choice_2",
               choice_2_bundle_duration_turns = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. "faction_pooled_resource_transaction{"
                    choice1_payload = choice1_payload .. "resource_cost " .. self.resource_record_option_1 .. ";}"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "effect_bundle{ bundle_key " .. self.choice_2_bundle .. ";"
                    choice2_payload = choice2_payload .. "turns " .. self.choice_2_bundle_duration_turns .. "; }"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- royal_grant_2 - phar_main_court_judge_dilemma_divide_land_5
          {
               court_judge_dilemma_type = "royal_grant_2",
               db_dilemma_key = "phar_main_court_judge_dilemma_divide_land_5",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_divinde_land_5_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_divinde_land_5_log_choice_2",

               choice_1_bundle = "phar_main_court_high_judge_divide_land_5_choice_1",
               choice_1_bundle_duration_turns = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. "effect_bundle{ bundle_key " .. self.choice_1_bundle .. ";"
                    choice1_payload = choice1_payload .. "turns " .. self.choice_1_bundle_duration_turns .. "; }"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- estate_with_no_heir_2 - phar_main_court_judge_dilemma_divide_land_6
          {
               court_judge_dilemma_type = "estate_with_no_heir_2",
               db_dilemma_key = "phar_main_court_judge_dilemma_divide_land_6",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_divinde_land_6_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_divinde_land_6_log_choice_2",

               choice_1_bundle = "phar_main_court_high_judge_divide_land_6_choice_1",
               choice_1_bundle_duration_turns = 6,
               resource_record_option_2 = "phar_main_court_judge_dilemma_divide_land_6_choice_2",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. "effect_bundle{ bundle_key " .. self.choice_1_bundle .. ";"
                    choice1_payload = choice1_payload .. "turns " .. self.choice_1_bundle_duration_turns .. "; }"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "faction_pooled_resource_transaction{"
                    choice2_payload = choice2_payload .. "resource_cost " .. self.resource_record_option_2 .. ";}"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- two_hairs_one_field_3 - phar_main_court_judge_dilemma_divide_land_7
          {
               court_judge_dilemma_type = "two_hairs_one_field_3",
               db_dilemma_key = "phar_main_court_judge_dilemma_divide_land_7",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_divinde_land_7_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_divinde_land_7_log_choice_2",

               choice_1_bundle = "phar_main_court_high_judge_divide_land_7_choice_1",
               choice_1_bundle_duration_turns = 6,
               resource_record_option_2 = "phar_main_court_judge_dilemma_divide_land_7_choice_2",

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. "effect_bundle{ bundle_key " .. self.choice_1_bundle .. ";"
                    choice1_payload = choice1_payload .. "turns " .. self.choice_1_bundle_duration_turns .. "; }"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "faction_pooled_resource_transaction{"
                    choice2_payload = choice2_payload .. "resource_cost " .. self.resource_record_option_2 .. ";}"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- royal_grant_3 - phar_main_court_judge_dilemma_divide_land_8
          {
               court_judge_dilemma_type = "royal_grant_3",
               db_dilemma_key = "phar_main_court_judge_dilemma_divide_land_8",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_divinde_land_8_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_divinde_land_8_log_choice_2",

               choice_1_bundle = "phar_main_court_high_judge_divide_land_8_choice_1",
               choice_1_bundle_duration_turns = 6,
               choice_2_bundle = "phar_main_court_high_judge_divide_land_8_choice_2",
               choice_2_bundle_duration_turns = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. "effect_bundle{ bundle_key " .. self.choice_1_bundle .. ";"
                    choice1_payload = choice1_payload .. "turns " .. self.choice_1_bundle_duration_turns .. "; }"
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "effect_bundle{ bundle_key " .. self.choice_2_bundle .. ";"
                    choice2_payload = choice2_payload .. "turns " .. self.choice_2_bundle_duration_turns .. "; }"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },

          -- estate_with_no_heir_3 - phar_main_court_judge_dilemma_divide_land_9
          {
               court_judge_dilemma_type = "estate_with_no_heir_3",
               db_dilemma_key = "phar_main_court_judge_dilemma_divide_land_9",
               log_localization_choice_1_key = "phar_main_court_judge_dilemma_divinde_land_9_log_choice_1",
               log_localization_choice_2_key = "phar_main_court_judge_dilemma_divinde_land_9_log_choice_2",

               choice_2_bundle = "phar_main_court_high_judge_divide_land_9_choice_2",
               choice_2_bundle_duration_turns = 6,

               on_dilemma_generated = function(self, faction_key, region_key)
                    local choice1_payload = "payload{"
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice1_payload = choice1_payload .. court.judge_dilemmas:get_payload_justice_served(region_key)
                    choice1_payload = choice1_payload .. "}"

                    local choice2_payload = "payload{"
                    choice2_payload = choice2_payload .. court.judge_dilemmas:get_payload_region_ruled(region_key)
                    choice2_payload = choice2_payload .. "effect_bundle{ bundle_key " .. self.choice_2_bundle .. ";"
                    choice2_payload = choice2_payload .. "turns " .. self.choice_2_bundle_duration_turns .. "; }"
                    choice2_payload = choice2_payload .. "}"

                    return choice1_payload, choice2_payload
               end,

               on_dilemma_resolved = function(self, context)
               end,
          },
     },

     get_payload_justice_served = function(self, region_key)
          local payload_string = "effect_bundle{ bundle_key " .. self.justice_served_local_bundle .. ";"
          payload_string = payload_string .. "turns " .. self.justice_served_local_bundle_duration .. ";"
          payload_string = payload_string .. "region " .. region_key .. "; }"

          payload_string = payload_string .. "effect_bundle{ bundle_key " .. self.justice_served_faction_bundle .. ";"
          payload_string = payload_string .. "turns " .. self.justice_served_faction_bundle_duration .. "; }"

          payload_string = payload_string .. "faction_pooled_resource_transaction{"
          payload_string = payload_string .. "resource_cost " .. self.justice_served_resource_record .. ";}"
          return payload_string
     end,

     get_payload_benevolence = function(self, region_key)
          local payload_string = "effect_bundle{ bundle_key " .. self.benevolence_faction_bundle .. ";"
          payload_string = payload_string .. "turns " .. self.benevolence_faction_bundle_duration .. "; }"
          return payload_string
     end,

     get_payload_bribed = function(self, region_key)
          local payload_string = "effect_bundle{ bundle_key " .. self.bribed_faction_bundle .. ";"
          payload_string = payload_string .. "turns " .. self.bribed_faction_bundle_duration .. "; }"
          return payload_string
     end,

     get_payload_injustice = function(self, region_key)
          local payload_string = "effect_bundle{ bundle_key " .. self.injustice_local_bundle .. ";"
          payload_string = payload_string .. "turns " .. self.injustice_local_bundle_duration .. ";"
          payload_string = payload_string .. "region " .. region_key .. "; }"
          return payload_string
     end,

     get_payload_region_ruled = function(self, region_key)
          local payload_string = "text_display{ lookup " .. self.region_ruling_text
          payload_string = payload_string .. "#text:regions_onscreen_" .. region_key .. ";}"
          return payload_string
     end,

     get_payload_regard_changed = function(self, position_key, faction_key, regard_changed)
          local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
          if not court_obj then
               return ""
          end
          local position_obj = court.util_functions.get_court_position(court_obj, position_key)

          local payload_string = "text_display{ lookup " .. self.regard_change
          local modified_regard_changed = court.judge_dilemmas:get_regard_changed(position_obj, faction_key,
               regard_changed)
          payload_string = payload_string .. "#text:" .. modified_regard_changed

          local localization_key = court.position_functions.get_position_name_localization_key(position_obj, court_obj)
          payload_string = payload_string .. "#text:" .. localization_key
          payload_string = payload_string .. ";}"
          return payload_string
     end,

     get_regard_changed = function(self, position_obj, faction_key, base_regard_change)
          -- negative regard does not have multipliers from diplomacy
          if base_regard_change < 0 then
               return base_regard_change
          end
          local diplomacy_multiplier = court.position_functions.get_diplomacy_regard_change_multiplier(position_obj,
               faction_key)
          local result = base_regard_change * diplomacy_multiplier
          return result
     end,

     pick_region_key_for_dilemma = function()
          -- maybe it would make sense to filter them to be owned by someone in the same court
          -- but design says nothing of the sort
          local valid_regions = {}
          for _, region_key in ipairs(sacred_hatti_lands) do
               local region_obj = cm:get_region(region_key)
               if region_obj and (not region_obj:is_null_interface()) and (not region_obj:is_abandoned()) then
                    table.insert(valid_regions, region_key)
               end
          end
          if #valid_regions <= 0 then
               court.output("Error: no possible region found for judge dilemma")
               return nil
          end
          local number_of_sacred_lands = #valid_regions
          -- no abandoned
          local rand_index = cm:model():random_int(1, #valid_regions);
          local random_region_key = valid_regions[rand_index]
          return random_region_key
     end,

     get_dilemma_by_db_key = function(db_dilemma_key)
          local found_dilemma = table_find(court.judge_dilemmas.dilemmas,
               function(e) return e.db_dilemma_key == db_dilemma_key end)
          return found_dilemma
     end,

     can_choose_dilemma = function(dilemma_obj, court_obj, faction_key)
          if dilemma_obj.targeted_position then
               local position_obj = court.util_functions.get_court_position(court_obj, dilemma_obj.targeted_position)
               if (not position_obj)
                   or position_obj.persistent.current_holder == nil
                   or position_obj.persistent.current_holder_faction == faction_key
               then
                    return false
               end
          end

          return true
     end,

     -- returns the dilemma config and region key
     pick_judge_dilemma = function(faction_key)
          local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
          local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
          if faction_table.current_dilemma_type and faction_table.current_dilemma_region_key then
               local dilemma_config = table_find(court.judge_dilemmas.dilemmas,
                    function(e) return e.court_judge_dilemma_type == faction_table.current_dilemma_type end)
               if court.judge_dilemmas.can_choose_dilemma(dilemma_config, court_obj, faction_key) then
                    return dilemma_config, faction_table.current_dilemma_region_key
               end
          end

          if #court.judge_dilemmas.dilemmas == 0 then
               court.output("Error: no possible judge dilemmas found", 10)
               return nil
          end

          local dilemma_config
          if court_cheat.judge_dilemmas.forced_dilemma then
               dilemma_config = table_find(court.judge_dilemmas.dilemmas,
                    function(e) return e.court_judge_dilemma_type == court_cheat.judge_dilemmas.forced_dilemma end)
               if not dilemma_config then
                    script_error(" no judge dilemma found with key " .. court_cheat.judge_dilemmas.forced_dilemma)
                    return nil
               end

               if not court.judge_dilemmas.can_choose_dilemma(dilemma_config, court_obj, faction_key) then
                    dilemma_config = nil
               end
          end

          if not dilemma_config then
               local weighted_dilemmas = weighted_list:new()
               for _, dilemma in ipairs(court.judge_dilemmas.dilemmas) do
                    if court.judge_dilemmas.can_choose_dilemma(dilemma, court_obj, faction_key) then
                         local weight = dilemma.weight or court.judge_dilemmas.default_weight
                         weighted_dilemmas:add_item(dilemma, weight)
                    end
               end

               if #weighted_dilemmas.items <= 0 then
                    court.output("No valid judge dilemmas to generate")
                    return nil
               end

               dilemma_config, _ = weighted_dilemmas:weighted_select()
          end
          if not dilemma_config then
               return nil
          end

          local region_key = court.judge_dilemmas:pick_region_key_for_dilemma()
          if not region_key then
               return nil
          end

          return dilemma_config, region_key
     end,

     -- tries to generate and trigger a dilemma for the faction
     pick_and_trigger_judge_dilemma = function(faction_key)
          local faction_obj = cm:get_faction(faction_key)
          -- only human factions get dilemmas
          if not faction_obj:is_human() then
               return
          end

          local dilemma_config, region_key = court.judge_dilemmas.pick_judge_dilemma(faction_key)
          if (not dilemma_config) or (not region_key) then
               return false
          end

          local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
          if not faction_table or not faction_table.faction_key then
               return
          end

          local choice1_payload = nil
          local choice2_payload = nil
          if (is_function(dilemma_config.on_dilemma_generated)) then
               choice1_payload, choice2_payload = dilemma_config:on_dilemma_generated(faction_table.faction_key,
                    region_key)
          end

          court.output("generated judge dilemma:" ..
          dilemma_config.court_judge_dilemma_type .. "; DB key:" .. dilemma_config.db_dilemma_key)
          local db_dilemma_key = dilemma_config.db_dilemma_key

          faction_table.current_dilemma_type = dilemma_config.court_judge_dilemma_type
          faction_table.current_dilemma_region_key = region_key
          if choice1_payload and choice2_payload then
               -- we add an empty choice 3 payload, otherwise choice 3 does not show at all
               local choice3_payload = "payload{}"
               -- we must cache the dilemma, because the player may reload the autosave and we must create it anew
               court.util_functions.add_pending_dilemma(faction_table.faction_key, db_dilemma_key, choice1_payload,
                    choice2_payload, choice3_payload)
               cm:trigger_custom_dilemma(faction_table.faction_key, db_dilemma_key, choice1_payload, choice2_payload,
                    choice3_payload)
               return true
          end

          local faction_obj = cm:get_faction(faction_table.faction_key)
          cm:trigger_dilemma_with_targets(faction_obj:command_queue_index(), db_dilemma_key, 0, 0, 0, 0, nil, 0, nil, 0)
          return true
     end,
}

--Court_HighJudge_DisbandRebels_PreBattleOption - on opened panel
core:add_listener(
     "Court_HighJudge_DisbandRebels_PreBattleOption",
     "PanelOpenedCampaign",
     function(context)
          return cm.game_is_running and context.string == "popup_pre_battle"
     end,
     function(context)
          local component = UIComponent(context.component)
          court.position_functions.handle_popup_pre_battle_open(component)
     end,
     true
)

--Court_HighJudge_DisbandRebels_FirstTickAfterWorldCreated - in case popup_pre_battle was opened before loading is complete (when loading from a pre-battle save file)
core:add_listener(
     "Court_FirstTickAfterWorldCreated",
     "FirstTickAfterWorldCreated",
     function(context)
          return cm:get_campaign_ui_manager():is_panel_open("popup_pre_battle")
     end,
     function(context)
          court.position_functions.handle_popup_pre_battle_open(core:get_ui_root())
     end,
     true
)

--Court_HighJudge_DisbandRebels_PreBattleOption_Interaction - on button clicked
core:add_listener(
     "Court_HighJudge_DisbandRebels_PreBattleOption_Interaction",
     "ComponentLClickUp",
     function(context)
          return context.string == "button_disband_enemy"
     end,
     function(context)
          local pb = cm:model():pending_battle()
          if not pb:has_attacker() then
               return
          end

          local local_faction_name = cm:get_local_faction_name(true)
          local court_obj = court.util_functions.get_faction_court_for_faction(local_faction_name)
          if not court_obj then
               return
          end

          if not court.disband_rebels_functions.can_disband_defender(pb:attacker(), pb:defender())
          then
               return
          end

          local local_faction_cqi = cm:get_faction(cm:get_local_faction_name(true)):command_queue_index()
          CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "Court_HighJudge_DisbandRebels")

          local force_disband_button = UIComponent(context.component)
          force_disband_button:SetVisible(false)

          --Set the attack button to invisible to ensure it can't be pressed and softlock the game
          local attack_button = find_uicomponent("button_attack_container", "button_attack")
          attack_button:SetVisible(false)
     end,
     true
)

--Court_HighJudge_DisbandRebels - on UITriggerScriptEvent
core:add_listener(
     "Court_HighJudge_DisbandRebels",
     "UITriggerScriptEvent",
     function(context) return context:trigger() == "Court_HighJudge_DisbandRebels" end,
     function(context)
          local pb = cm:model():pending_battle()
          local successfully_disbanded = court.disband_rebels_functions.disband_rebels(pb)
          if not successfully_disbanded then
               local local_faction_key = cm:get_local_faction_name(true)
               court.output("Error: " .. local_faction_key ..
               " could not disband enemies, yet the an event was received!", 10)
          end
     end,
     true
)

--Court_ScriptEventOnAtenCreated
core:add_listener(
     "Court_ScriptEventOnAtenCreated",
     "ScriptEventOnAtenCreated",
     true,
     function(context)
          local faction_key = context.stored_table.faction_key
          local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
          if not court_obj then
               return
          end
          local high_priest_obj = court.util_functions.get_court_position(court_obj, "high_priest_of_amun")
          if (not high_priest_obj) or
              (high_priest_obj.persistent.current_holder_faction ~= faction_key) then
               return
          end

          high_priest_obj:on_aten_created(context.stored_table.aten_key, court_obj)
     end,
     true
)

--Court_ScriptEventWorshipGod
core:add_listener(
     "Court_ScriptEventWorshipGod",
     "ScriptEventWorshipGod",
     true,
     function(context)
          local court_obj = court.util_functions.get_faction_court_for_faction(context.stored_table.faction_key)
          if not court_obj then
               return
          end

          -- some positions need to update the favor for the gods
          for _, position_obj in ipairs(court_obj.positions) do
               if is_function(position_obj.on_new_god_worshipped)
                   and position_obj.persistent.current_holder_faction == context.stored_table.faction_key
               then
                    position_obj:on_new_god_worshipped(court_obj, context.stored_table.new_god_key,
                         context.stored_table.old_god_key)
               end
          end
     end,
     true
)

--CourtJudge_CharacterPerformedSuccessfulAgentAction
core:add_listener(
     "CourtJudge_CharacterPerformedSuccessfulAgentAction",
     "CharacterPerformedSuccessfulAgentAction",
     function(context) return context:unique_id() == "phar_settlement_visit_judge" end,
     function(context)
          local character = context:character()
          local action_id = context:unique_id()

          if not action_id then
               court.output("Error: character_performed_successful_agent_action: action type is not defined", 10)
               return
          end

          local local_faction_name = cm:get_local_faction_name(true)
          local court_obj = court.util_functions.get_faction_court_for_faction(local_faction_name)
          if not court_obj then
               return
          end

          local high_judge_position_obj = court.util_functions.get_court_position(court_obj, "high_judge")
          if (not high_judge_position_obj)
              or (not high_judge_position_obj.persistent.current_holder)
          then
               court.output("Error: 'phar_settlement_visit_judge' executed but 'high_judge' position is vacant!", 10)
               return
          end

          local position_character_obj = cm:get_character(high_judge_position_obj.persistent.current_holder)
          local position_character_cqi = position_character_obj:command_queue_index()

          local active_character_cqi = character:command_queue_index()
          if active_character_cqi ~= position_character_cqi then
               court.output(
               "Error: 'phar_settlement_visit_judge' executed by someone who is not in the 'high_judge' position!", 10)
               return
          end

          local target_garrison = context:target_garrison()
          if not target_garrison or target_garrison:is_null_interface() or not target_garrison:is_settlement() then
               court.output("Error: 'phar_settlement_visit_judge' executed but there is no valid settlement target!", 10)
               return
          end

          high_judge_position_obj:trigger_visit_dilemma(high_judge_position_obj.persistent.current_holder_faction,
               target_garrison:region())
     end,
     true
)

--CourtVizier_CharacterPerformedSuccessfulAgentAction
core:add_listener(
     "CourtVizier_CharacterPerformedSuccessfulAgentAction",
     "CharacterPerformedSuccessfulAgentAction",
     function(context) return context:unique_id() == "phar_settlement_visit_vizier" end,
     function(context)
          local character = context:character()
          local action_id = context:unique_id()

          if not action_id then
               court.output("Error: character_performed_successful_agent_action: action type is not defined", 10)
               return
          end

          local faction_obj = character:faction()
          local faction_key = faction_obj:name()
          local faction_court = court.util_functions.get_faction_court_for_faction(faction_key)
          if not faction_court then
               court.output(
               "Error: 'phar_settlement_visit_vizier' executed but faction '" ..
               faction_key .. "' is not part of any court!", 10)
               return
          end

          local vizier_position_obj = court.util_functions.get_court_position(faction_court, "vizier")
          if not vizier_position_obj or not vizier_position_obj.persistent.current_holder then
               court.output("Error: 'phar_settlement_visit_vizier' executed but 'vizier' position is vacant!", 10)
               return
          end

          local position_character_obj = cm:get_character(vizier_position_obj.persistent.current_holder)
          local position_character_cqi = position_character_obj:command_queue_index()

          local active_character_cqi = character:command_queue_index()
          if active_character_cqi ~= position_character_cqi then
               court.output(
               "Error: 'phar_settlement_visit_vizier' executed by someone who is not in the 'vizier' position!", 10)
               return
          end

          local local_region_obj = position_character_obj:region()
          vizier_position_obj:trigger_visit_corvee_labor(vizier_position_obj.persistent.current_holder_faction,
               local_region_obj)
     end,
     true
)

--court_judge_DilemmaChoiceMadeEvent
core:add_listener(
     "court_judge_DilemmaChoiceMadeEvent",
     "DilemmaChoiceMadeEvent",
     true,
     function(context)
          local db_dilemma_key = context:dilemma()
          local dilemma_config = court.judge_dilemmas.get_dilemma_by_db_key(db_dilemma_key)
          if not dilemma_config then
               -- this is not a court judge dilemma
               return
          end

          local faction_key = context:faction():name()
          local choice = context:choice()
          court.log_functions.log_court_action("dilemma_resolved", faction_key, "", db_dilemma_key, choice)
          if choice == 2 then
               -- by design the third choice (0 based) will postpone the dilemma. it is already cached
               return
          end
          dilemma_config:on_dilemma_resolved(context)

          -- we remove the cache so next time a different dilemma is picked
          local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
          faction_table.current_dilemma_type = nil
          faction_table.current_dilemma_region_key = nil
     end,
     true
)

--positions_FactionTurnStart
core:add_listener(
     "positions_FactionTurnStart",
     "FactionTurnStart",
     true,
     function(context)
          local faction_key = context:faction():name()
          local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
          if not court_obj then
               return
          end
          for _, position_obj in ipairs(court_obj.positions) do
               if position_obj.on_turn_start
                   and position_obj.persistent
                   and position_obj.persistent.current_holder_faction == faction_key
               then
                    position_obj:on_turn_start(court_obj)
               end
          end
     end,
     true
)

--positions_FactionTurnStart
core:add_listener(
     "positions_RoundStart",
     "RoundStart",
     true,
     function(context)
          local current_turn = cm:model():turn_number()
          for _, court_obj in ipairs(court.all_courts) do
               for _, position_obj in ipairs(court_obj.positions) do
                    -- if the position has marked request units that need to expire on this turn we need to remove them
                    if position_obj.persistent
                        and position_obj.persistent.units
                        and position_obj.persistent.units["request"]
                        and position_obj.persistent.units["request"][current_turn]
                    then
                         court.mercenary_functions.remove_units_by_source(court_obj, position_obj, "request",
                              current_turn)
                    end
               end
          end
     end,
     true
)
