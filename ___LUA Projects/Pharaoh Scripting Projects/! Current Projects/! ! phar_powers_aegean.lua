local file_info = debug.getinfo(1, "S")
local folder_file_splits = string.split(file_info.source, "\\")
out("Loading " .. folder_file_splits[#folder_file_splits])

local aegean_powers_config = {
     id = "aegean_powers",

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
     bought_power_factor = "phar_aegean_legitimacy_bought_power",

     forced_annexation = {
          tiers = {
               [1] = {
                    cooldown = 10,
                    min_number_of_regions = 1,
                    max_number_of_regions = 1,
               },
               [2] = {
                    cooldown = 10,
                    min_number_of_regions = 1,
                    max_number_of_regions = 2,
               },
               [3] = {
                    cooldown = 9,
                    min_number_of_regions = 1,
                    max_number_of_regions = 3,
               },
               [4] = {
                    cooldown = 8,
                    min_number_of_regions = 1,
                    max_number_of_regions = 4,
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
                    cooldown = 4,
                    num_points = 4,
               },
               [4] = {
                    cooldown = 3,
                    num_points = 5,
               },
          },
     },

     remote_colonisation = {
          effect_bundle_key = "phar_combi_remote_colonisation",
          tiers = {
               [1] = {
                    max_distance = 2,
                    cooldown = 8,
                    cost_mod = 1.5,
                    cost_distance_mod = 0.3,
               },
               [2] = {
                    max_distance = 5,
                    cooldown = 7,
                    cost_mod = 1.3,
                    cost_distance_mod = 0.3,
               },
               [3] = {
                    max_distance = 6,
                    cooldown = 6,
                    cost_mod = 1,
                    cost_distance_mod = 0.3,
               },
               [4] = {
                    max_distance = 10,
                    cooldown = 5,
                    cost_mod = 0.8,
                    cost_distance_mod = 0.3,
               },
          },
     },

     war_games = {
          tiers = {
               [1] = {
                    levels_per_charge = 2,
                    recharge_turns = 6,
                    max_charges = 2,
               },
               [2] = {
                    levels_per_charge = 3,
                    recharge_turns = 5,
                    max_charges = 3,
               },
               [3] = {
                    levels_per_charge = 4,
                    recharge_turns = 4,
                    max_charges = 3,
               },
               [4] = {
                    levels_per_charge = 5,
                    recharge_turns = 3,
                    max_charges = 3,
               },
          },
     },
}

local aegean_powers_ui_config = {
     -- This is filled out automatically
     --mechanic = pharaohs_powers,
     --panel_is_opened = false,

     tooltip_tier_string_prefix = "campaign_localised_strings_string_tooltip_tier_prefix_",

     script_id_prefix = "aegean_power_",
     power_type = "aegean",

     powers = {
          --[[
		Each power has these filled out automatically for it:
			config = aegean_powers_config.power_config,
			power_string = "power_string"

		Example for corvee_labour:
			config = aegean_powers_config.corvee_labour,
			power_string = "corvee_labour"
		--]]

          forced_annexation = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_wanax_annexation.png",
               tooltip_title_prefix = "campaign_localised_strings_string_forced_annexation_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_forced_annexation_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_forced_annexation_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_forced_annexation_tooltip_flavour_",
          },
          court_positions = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_wanax_court.png",
               tooltip_title_prefix = "campaign_localised_strings_string_court_positions_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_court_positions_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_court_positions_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_court_positions_tooltip_flavour_aegea_",
          },
          competency_points = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_wanax_competency.png",
               tooltip_title_prefix = "campaign_localised_strings_string_competency_points_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_competency_points_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_competency_points_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_competency_points_tooltip_flavour_",
          },
          remote_colonisation = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_wanax_colonization.png",
               tooltip_title_prefix = "campaign_localised_strings_string_remote_colonisation_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_remote_colonisation_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_remote_colonisation_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_remote_colonisation_tooltip_flavour_",
          },
          war_games = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_wanax_training.png",
               tooltip_title_prefix = "campaign_localised_strings_string_war_games_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_war_games_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_war_games_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_war_games_tooltip_flavour_",
          },
     },
}

aegean_powers = {
     config = aegean_powers_config,
     ui_config = aegean_powers_ui_config,

     get_relevant_court = function()
          return court.aegean_court
     end,

     post_init = function(self)
          self.legitimacy_system = aegean_legitimacy
          self.political_states_system = aegean_political_states
     end,
}

aegean_powers = crown:create_mechanic_from_type(powers_system, aegean_powers)

return aegean_powers
