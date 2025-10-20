local file_info = debug.getinfo(1, "S")
local folder_file_splits = string.split(file_info.source, "\\")
out("Loading " .. folder_file_splits[#folder_file_splits])

local meso_powers_config = {
     id = "meso_powers",

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
     bought_power_factor = "phar_meso_legitimacy_bought_power",

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

     corvee_labour = {
          tiers = {
               [1] = {
                    cooldown = 5,
                    max_building_level = 2,
                    build_time_reduction = 0,
                    enable_ers_construction = false,
               },
               [2] = {
                    cooldown = 4,
                    max_building_level = 3,
                    build_time_reduction = 1,
                    enable_ers_construction = false,
               },
               [3] = {
                    cooldown = 3,
                    max_building_level = 4,
                    build_time_reduction = 2,
                    enable_ers_construction = false,
               },
               [4] = {
                    cooldown = 2,
                    max_building_level = 5,
                    build_time_reduction = 3,
                    enable_ers_construction = true,
               },
          },
     },

     raise_armies = {
          tiers = {
               [1] = {
                    cooldown = 12,
                    duration = 3,
                    effect_bundle_key = "phar_main_great_king_powers_raise_armies_tier_1",
               },
               [2] = {
                    cooldown = 11,
                    duration = 5,
                    effect_bundle_key = "phar_main_great_king_powers_raise_armies_tier_2",
               },
               [3] = {
                    cooldown = 9,
                    duration = 8,
                    effect_bundle_key = "phar_main_great_king_powers_raise_armies_tier_3",
               },
               [4] = {
                    cooldown = 6,
                    duration = 12,
                    effect_bundle_key = "phar_main_great_king_powers_raise_armies_tier_4",
               },
          }
     },

     foment_dissent = {
          -- No tier bundles. A custom effect bundle is used for each application because the strength of the effect depends on the target province.
          effect_bundle_key = "phar_map_effect_bundle_royal_powers_foment_dissent",
          effect_key = "troy_effect_campaign_happiness_factor_other",
          effect_scope = "province_to_province_own",

          tiers = {
               [1] = {
                    cooldown = 12,
                    duration = 8,
                    base_effect_strength = -10,
               },
               [2] = {
                    cooldown = 11,
                    duration = 11,
                    base_effect_strength = -11,
               },
               [3] = {
                    cooldown = 9,
                    duration = 13,
                    base_effect_strength = -13,
               },
               [4] = {
                    cooldown = 6,
                    duration = 15,
                    base_effect_strength = -15,
               },
          },
     },

     bribe_force = {
          cost_resource = "troy_gold",
          cost_factor = "troy_resource_factor_faction", -- TODO: Setup the actual cost factor in the database and set it here.

          can_bribe_faction_leader = true,

          -- See the get_bribe_force_cost function for the actual cost calculation. The following multipliers are used in the formula.
          -- Resource multipliers applied to the unit recruitment cost of all units in the bribed army. Note that these are different by design
          -- from the generic CAI conversion rates.
          -- For reference: a full army can have a recruit cost of 10k food, 2000 bronze, 600 gold
          resource_multipliers = {
               troy_gold = 1.0,
               troy_food = 0.3,
               troy_wood = 0.1,
               troy_stone = 0.1, -- Mostly ignored, units don't cost stone
               troy_bronze = 0.2,
          },

          -- Multiplier for the enemy general's tier
          general_tier_multiplier = 0.1, -- Formula is 1 + (0.1 * rank)

          -- Multiplier for the enemy general being the faction leader
          faction_leader_cost_multiplier = 2,

          -- Trait multipliers for the enemy general
          -- Traits making you more likely to desire more money to accept a bribe (thru good or bad reasons) should have higher values (1.0+), and vice-versa
          -- Traits are in the format: ["trait_key:trait_level"], from character_trait_levels table. Any trait from there can be used below. If they don't have a level, use "1"
          trait_multipliers = {
               ["phar_main_trait_ambitious:1"]         = 1.2,
               ["phar_main_trait_ambitious:2"]         = 1.4,
               ["phar_main_trait_ambitious:3"]         = 1.6,
               ["phar_main_trait_barbaric:1"]          = 1.2,
               ["phar_main_trait_barbaric:2"]          = 1.4,
               ["phar_main_trait_barbaric:3"]          = 1.6,
               ["phar_main_trait_blunt:1"]             = 1.1,
               ["phar_main_trait_blunt:2"]             = 1.2,
               ["phar_main_trait_blunt:3"]             = 1.3,
               ["phar_main_trait_brave:1"]             = 1.1,
               ["phar_main_trait_brave:2"]             = 1.2,
               ["phar_main_trait_brave:3"]             = 1.3,
               ["phar_main_trait_cautious:1"]          = 0.9,
               ["phar_main_trait_cautious:2"]          = 0.8,
               ["phar_main_trait_cautious:3"]          = 0.7,
               ["phar_main_trait_confident:1"]         = 1.1,
               ["phar_main_trait_confident:2"]         = 1.2,
               ["phar_main_trait_confident:3"]         = 1.3,
               ["phar_main_trait_content:1"]           = 0.8,
               ["phar_main_trait_content:2"]           = 0.6,
               ["phar_main_trait_content:3"]           = 0.4,
               ["phar_main_trait_cooperative:1"]       = 0.8,
               ["phar_main_trait_cooperative:2"]       = 0.6,
               ["phar_main_trait_cooperative:3"]       = 0.4,
               ["phar_main_trait_cowardly:1"]          = 0.8,
               ["phar_main_trait_cowardly:2"]          = 0.6,
               ["phar_main_trait_cowardly:3"]          = 0.4,
               ["phar_main_trait_cruel:1"]             = 1.25,
               ["phar_main_trait_cruel:2"]             = 1.50,
               ["phar_main_trait_cruel:3"]             = 1.75,
               ["phar_main_trait_cultured:1"]          = 1.0,
               ["phar_main_trait_cultured:2"]          = 0.95,
               ["phar_main_trait_cultured:3"]          = 0.9,
               ["phar_main_trait_hesitant:1"]          = 1.1,
               ["phar_main_trait_hesitant:2"]          = 1.2,
               ["phar_main_trait_hesitant:3"]          = 1.3,
               ["phar_main_trait_individualistic:1"]   = 0.9,
               ["phar_main_trait_individualistic:2"]   = 0.8,
               ["phar_main_trait_individualistic:3"]   = 0.7,
               ["phar_main_trait_irreverent:1"]        = 1.1,
               ["phar_main_trait_irreverent:2"]        = 1.2,
               ["phar_main_trait_irreverent:3"]        = 1.3,
               ["phar_main_trait_materialistic:1"]     = 0.9,
               ["phar_main_trait_materialistic:2"]     = 0.8,
               ["phar_main_trait_materialistic:3"]     = 0.7,
               ["phar_main_trait_merciful:1"]          = 0.9,
               ["phar_main_trait_merciful:2"]          = 0.8,
               ["phar_main_trait_merciful:3"]          = 0.7,
               ["phar_main_trait_reckless:1"]          = 1.1,
               ["phar_main_trait_reckless:2"]          = 1.2,
               ["phar_main_trait_reckless:3"]          = 1.3,
               ["phar_main_trait_respectful:1"]        = 0.9,
               ["phar_main_trait_respectful:2"]        = 0.8,
               ["phar_main_trait_respectful:3"]        = 0.7,
               ["phar_main_trait_spiritual:1"]         = 0.9,
               ["phar_main_trait_spiritual:2"]         = 0.8,
               ["phar_main_trait_spiritual:3"]         = 0.7,
               ["phar_main_trait_underhanded:1"]       = 1.0,
               ["phar_main_trait_underhanded:2"]       = 1.0,
               ["phar_main_trait_underhanded:3"]       = 1.0,
               -- Sea People-specific traits
               ["phar_sea_special_coastal_ambusher:1"] = 1.0,
               ["phar_sea_special_coastal_ambusher:2"] = 1.0,
               ["phar_sea_special_coastal_ambusher:3"] = 1.0,
               ["phar_sea_special_coastal_predator:1"] = 1.2,
               ["phar_sea_special_coastal_predator:2"] = 1.4,
               ["phar_sea_special_coastal_predator:3"] = 1.6,
               ["phar_sea_special_colonizer:1"]        = 1.1,
               ["phar_sea_special_colonizer:2"]        = 1.2,
               ["phar_sea_special_colonizer:3"]        = 1.3,
               ["phar_sea_special_sea_wolf:1"]         = 0.9,
               ["phar_sea_special_sea_wolf:2"]         = 0.8,
               ["phar_sea_special_sea_wolf:3"]         = 0.7,
          },
          tiers = {
               [1] = {
                    cooldown = 12,
                    base_cost = 2000,
                    discount = 1.1,
               },
               [2] = {
                    cooldown = 11,
                    base_cost = 1500,
                    discount = 1.0,
               },
               [3] = {
                    cooldown = 9,
                    base_cost = 1200,
                    discount = 0.9,
               },
               [4] = {
                    cooldown = 6,
                    base_cost = 1000,
                    discount = 0.8,
               },
          },
     },
}

local meso_powers_ui_config = {
     -- This is filled out automatically
     --mechanic = pharaohs_powers,
     --panel_is_opened = false,

     tooltip_tier_string_prefix = "campaign_localised_strings_string_tooltip_tier_prefix_",

     script_id_prefix = "meso_power_",
     power_type = "meso",

     powers = {
          --[[
		Each power has these filled out automatically for it:
			config = meso_powers_config.power_config,
			power_string = "power_string"

		Example for corvee_labour:
			config = meso_powers_config.corvee_labour,
			power_string = "corvee_labour"
		--]]

          competency_points = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_meso_king_competency.png",
               tooltip_title_prefix = "campaign_localised_strings_string_competency_points_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_competency_points_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_competency_points_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_competency_points_tooltip_flavour_",
          },
          corvee_labour = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_meso_king_corvee_labour.png",
               tooltip_title_prefix = "campaign_localised_strings_string_corvee_labour_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_corvee_labour_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_corvee_labour_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_corvee_labour_tooltip_flavour_meso_",
          },
          raise_armies = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_meso_king_inspire_troops.png",
               tooltip_title_prefix = "campaign_localised_strings_string_raise_armies_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_raise_armies_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_raise_armies_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_raise_armies_tooltip_flavour_meso_",
          },
          foment_dissent = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_meso_king_agitate.png",
               tooltip_title_prefix = "campaign_localised_strings_string_foment_dissent_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_foment_dissent_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_foment_dissent_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_foment_dissent_tooltip_flavour_",
          },
          bribe_force = {
               icon_path = "UI/skins/default/pharaohs_crown/powers/power_meso_king_bribe.png",
               tooltip_title_prefix = "campaign_localised_strings_string_bribe_force_tooltip_title_",
               tooltip_info_key_prefix = "campaign_localised_strings_string_bribe_force_tooltip_info_",
               tooltip_tier_effect_prefix = "campaign_localised_strings_string_bribe_force_tooltip_effect_",
               tooltip_flavour_prefix = "campaign_localised_strings_string_bribe_force_tooltip_flavour_",
          },
     },
}

meso_powers = {
     config = meso_powers_config,
     ui_config = meso_powers_ui_config,

     get_relevant_court = function()
          return court.mesopotamian_court
     end,

     post_init = function(self)
          self.legitimacy_system = meso_legitimacy
          self.political_states_system = meso_political_states
     end,
}

meso_powers = crown:create_mechanic_from_type(powers_system, meso_powers)

return meso_powers
