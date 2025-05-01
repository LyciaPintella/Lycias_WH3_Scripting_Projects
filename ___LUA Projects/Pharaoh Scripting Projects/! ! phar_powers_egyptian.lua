local file_info = debug.getinfo(1, "S")
local folder_file_splits = string.split(file_info.source, "\\")
out("Loading " .. folder_file_splits[#folder_file_splits])

local pharaohs_powers_config = {
     id = "pharaohs_powers",

     max_powers_per_tier = {
          [1] = 2,
          [2] = 1,
          [3] = 1,
          [4] = 1,
     },

     tier_legitimacy_requirement = {
          [1] = 150,
          [2] = 200,
          [3] = 250,
          [4] = 300,
     },

     -- Only the sitting ruler has access to powers. Consequently this means powers are inaccessible during legitimacy wars
     only_sitting_ruler_has_access_to_powers = true,

     -- Whether to refund points if you unlock a higher tier of a power you've already unlocked
     refund_lower_tier_of_same_power_when_unlocking = true,

     -- Whether to stop the power from working when your legitimacy is bellow
     -- the required legitimacy to unlock that power.
     lock_power_when_legitimacy_bellow_requirement = true,

     lose_legitimacy_when_unlocking_power = false,
     bought_power_factor = "phar_legitimacy_bought_power",

     corvee_labour = {
          tiers = {
               [1] = {
                    cooldown = 5,
                    max_building_level = 2,
                    build_time_reduction = 0,
                    enable_ers_construction = false,
               },
               [2] = {
                    cooldown = 5,
                    max_building_level = 3,
                    build_time_reduction = 1,
                    enable_ers_construction = false,
               },
               [3] = {
                    cooldown = 5,
                    max_building_level = 4,
                    build_time_reduction = 2,
                    enable_ers_construction = false,
               },
               [4] = {
                    cooldown = 4,
                    max_building_level = 5,
                    build_time_reduction = 3,
                    enable_ers_construction = true,
               },
          },
     },

     forced_annexation = {
          tiers = {
               [1] = {
                    cooldown = 10,
                    min_number_of_regions = 1,
                    max_number_of_regions = 1,
               },
               [2] = {
                    cooldown = 12,
                    min_number_of_regions = 1,
                    max_number_of_regions = 2,
               },
               [3] = {
                    cooldown = 14,
                    min_number_of_regions = 1,
                    max_number_of_regions = 3,
               },
               [4] = {
                    cooldown = 16,
                    min_number_of_regions = 1,
                    max_number_of_regions = 4,
               },
          },
     },

     growth_migration = {
          tiers = {
               [1] = {
                    cooldown = 4,
                    population_bonus = 1,
               },
               [2] = {
                    cooldown = 4,
                    population_bonus = 2,
               },
               [3] = {
                    cooldown = 4,
                    population_bonus = 3,
               },
               [4] = {
                    cooldown = 3,
                    population_bonus = 4,
               },
          },
     },

     court_positions = {
          tiers = {
               [1] = {
                    positions = 2,
               },
               [2] = {
                    positions = 3,
               },
               [3] = {
                    positions = 4,
               },
               [4] = {
                    positions = 5,
               },
          },
     },

     competency_points = {
          tiers = {
               [1] = {
                    cooldown = 5,
                    num_points = 2,
               },
               [2] = {
                    cooldown = 5,
                    num_points = 3,
               },
               [3] = {
                    cooldown = 5,
                    num_points = 4,
               },
               [4] = {
                    cooldown = 4,
                    num_points = 5,
               },
          },
     },
}

local pharaohs_powers_ui_config = {
     -- This is filled out automatically
     --mechanic = pharaohs_powers,
     --panel_is_opened = false,

     tooltip_tier_string_prefix = "campaign_localised_strings_string_tooltip_tier_prefix_",

     script_id_prefix = "pharaoh_power_",
     power_type = "egyptian",

     powers = {
          --[[
		Each power has these filled out automatically for it:
			config = pharaohs_powers_config.power_config,
			power_string = "power_string"

		Example for corvee_labour:
			config = pharaohs_powers_config.corvee_labour,
			power_string = "corvee_labour"
		--]]

          corvee_labour = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_pharaoh_corvee_labour.png",
               tooltip_title_prefix = "campaign_localised_strings_string_corvee_labour_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_corvee_labour_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_corvee_labour_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_corvee_labour_tooltip_flavour_",
          },
          forced_annexation = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_pharaoh_forced_annexation.png",
               tooltip_title_prefix = "campaign_localised_strings_string_forced_annexation_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_forced_annexation_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_forced_annexation_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_forced_annexation_tooltip_flavour_",
          },
          growth_migration = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_pharaoh_growth_migration.png",
               tooltip_title_prefix = "campaign_localised_strings_string_growth_migration_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_growth_migration_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_growth_migration_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_growth_migration_tooltip_flavour_",
          },
          court_positions = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_pharaoh_court.png",
               tooltip_title_prefix = "campaign_localised_strings_string_court_positions_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_court_positions_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_court_positions_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_court_positions_tooltip_flavour_",
          },
          competency_points = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_pharaoh_competency.png",
               tooltip_title_prefix = "campaign_localised_strings_string_competency_points_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_competency_points_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_competency_points_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_competency_points_tooltip_flavour_",
          },
     },
}

pharaohs_powers = {
     config = pharaohs_powers_config,
     ui_config = pharaohs_powers_ui_config,

     get_relevant_court = function()
          return court.egyptian_court
     end,

     post_init = function(self)
          self.legitimacy_system = egypt_legitimacy
          self.political_states_system = egypt_political_states
     end,
}

pharaohs_powers = crown:create_mechanic_from_type(powers_system, pharaohs_powers)

return pharaohs_powers
