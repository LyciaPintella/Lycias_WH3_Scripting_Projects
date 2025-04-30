local file_info = debug.getinfo(1, "S")
local folder_file_splits = string.split(file_info.source, "\\")
out("Loading " .. folder_file_splits[#folder_file_splits])

local egypt_legitimacy_config = {
     id = "legitimacy",
     resource_key = "phar_legitimacy",
     dynasty_line_key = "phar_legitimacy",

     -- Sacred lands
     sacred_lands_factor = "phar_legitimacy_sacred_egyptian_lands",

     -- Starting bonus
     starting_bonus_factor = "phar_legitimacy_rightful_heir",

     -- Ancillaries
     ancillaries_factor = "phar_legitimacy_ancillaries",

     -- Settlement Buildings
     building_factor = "phar_legitimacy_buildings",
     legitimacy_from_buildings_scripted_bonus_value = "scripted_legitimacy_from_buildings",

     -- Monuments
     monument_factor = "phar_legitimacy_monuments",
     legitimacy_from_monument_scripted_bonus_value = "scripted_legitimacy_from_monument",
     monument_ers_building_chain_key = "phar_main_ers_monument",
     wonder_building_chain_key = "phar_main_al_khufu",
     -- Comment this line out to disable the technology check
     legitimacy_from_monument_technology_unlock_key = "civil_19_monument_legitimacy",
     allies_factor = "phar_legitimacy_ally",

     -- Points of Interest (POIs) and other ERS buildings
     ers_factor = "phar_legitimacy_external_region_buildings",
     legitimacy_from_ers_scripted_bonus_value = "scripted_legitimacy_from_ers",
     ers_building_chain_key = "phar_main_ers_",

     -- Battles
     battle_factor = "phar_legitimacy_battle",
     battle_legitimacy_multiplier_scripted_bonus_value_id = "scripted_battle_legitimacy_multiplier",

     -- Local Deities
     local_deities_factor = "phar_map_legitimacy_local_deities",

     -- Court
     court_position_factor = "phar_legitimacy_court_position",
     court_plots_factor = "phar_map_court_decay",

     -- Minimum amount of sacred regions to have legitimacy be active for the faction.
     -- For programmers/tech design: This number can be overridden for specific factions using <legitimacy_object>:override_min_sacred_regions_for_faction(faction_key, new_min)
     minimum_sacred_regions = 1,

     -- Override the minimum amount of regions for specific factions
     override_faction_minimum_sacred_regions = {
          phar_main_bay = 0,
          phar_sea_sherden = 3,
          phar_sea_peleset = 3,
     },

     -- Resource cost requirement to unlock this legitimacy path
     -- Set to nil to remove this cost
     resource_cost = nil,

     resource_cost_factor = "troy_resource_factor_events",

     -- If this is false then both the resource cost and the sacred regions requirements need to be met
     -- If this is true then only EITHER requirement needs to be met
     resource_cost_can_replace_minimum_sacred_regions_requirement = true,

     -- Override the resource cost for different factions
     override_faction_resource_cost = {
          phar_main_irsu = {
               troy_gold = -1000,
          },
     },

     -- When a faction that has NOT claimed this legitimacy path and has this many sacred regions of this path
     -- it will unlock the ancient legacies of this legitimacy path
     num_sacred_regions_to_conquer = 25,

     legitimacy_decay = {
          --[[
		{
			-- Amount of legitimacy to be removed each turn
			amount = 1,

			-- Portion of the current legitimacy factor value to decay each turn. If this is set then amount is ignored.
			portion = 0.5,

			-- From which factor to remove the legitimacy
			factor = "phar_legitimacy_sacred_egyptian_lands",

			-- If this is set will apply this effect bundle to the faction on every
			-- FactionTurnStart and will not apply a resource transaction from Lua.
			-- Since it's applied on FactionTurnStart and only for 1 turn the effect bundle
			-- advancement has to not be set to start_turn_completed
			-- Also, the amount deducted should be set to -1, as the code is actually adjusting it.
			effect_bundle = "faction_effect_bundle_key",

			-- At what amount of legitimacy from the given factor to stop the decay
			stop_at = 0,

			-- Will construct a shared state name with this prefix and the suffix "<_legitimacy_resource_key>" on game launch
			shared_state_prefix = "",

			-- Will set up a global shared state with this name and with a value of how much legitimacy is decayed per turn
			shared_state_name = "shared_state",

			-- Multiplies legitimacy decay by this much if applied to an AI
			ai_multiplier = 0.5
		},
		--]]

          {
               amount = 1,
               portion = 0.1,
               factor = "phar_legitimacy_battle",
               effect_bundle = "phar_main_egyptian_legitimacy_battle_decay",
               stop_at = 0,
               shared_state_prefix = "legitimacy_battle_decay_amount",
               ai_multiplier = 0.7,
          },

          {
               amount = 1,
               portion = 0.1,
               factor = "phar_map_court_decay",
               effect_bundle = "phar_map_egyptian_legitimacy_court_decay",
               stop_at = 0,
               ai_multiplier = 0.7,
          },
     },

     sources = {
          sacred_region = 1,

          battle_won = {
               --[[
			 The formula to determine gained legitimacy when winning battles is currently:
				base_legitimacy_won = (enemy_army_strength / defeated_army_strength_base) * legitimacy_per_strength_base

				if our army_strength < enemy_army_strength then
					odds_multiplier = 0.7 + 0.3 * ((enemy_army_strength / our_army_strength) ^ 1.5)
				else
					odds_multiplier = 1.08 - 0.08 * ((our_army_strength / enemy_army_strength) ^ 1.6)

				total_legitimacy_won = base_legitimacy_won * min(10, odds_multiplier)
			--]]
               defeated_army_strength_base = 5100,
               legitimacy_per_strength_base = 8,
               maximum_odds_multiplier = 10,

               minimum_legitimacy_from_battle = 1,
               maximum_legitimacy_from_battle = 100,
          },

          local_deities = {
               -- If a tier is missing from this table then will use the legitimacy from the next lower tier
               -- E.g. if we get a god to tier 5, but the table only contains data for tier 4 and 6, then will use tier 4
               tier_to_legitimacy = {
                    [1] = 4,
                    [2] = 12,
                    [3] = 24,
                    [4] = 25,
                    [5] = 26,
                    [6] = 27,
                    [7] = 28,
               },

               -- Favoured deity is a system where the sitting ruler's deity with the highest favour is considered
               -- the favoured. Everyone who worships this favoured deity gets bonus legitimacy.
               enable_favoured_deity = true,
               favoured_deity_legitimacy_multiplier = 1.5,

               -- If enable_favoured_deity is true then the favoured deity can only be one of these
               -- If this table is empty will assume all gods are relevant
               relevant_favoured_deities = {
                    "aten",
                    "ra",
                    "ptah",
                    "horus",
                    "anubis",
                    "isis",
                    "set",
                    "amun",
                    "osiris",
                    "thoth",
               },

               legitimacy_path_region_name =
               "{{tr:ui_text_replacements_localised_text_phar_map_pharaohs_crown_favoured_deity_culture_name_egypt}}",

               -- scripted bonus value that gives extra legitimacy per reached deity tier
               extra_legitimacy_bonus_value = "local_deities_extra_legitimacy_per_tier"
          },
     },

     sinks = {
          region_lost = 0,
          --battle_lost = 1,
     },

     -- Setup different legitimacy gain/removal for different factions
     -- For instance, if you want a specific faction to have 3 times the legitimacy gain from sacred regions
     faction_factor_multiplier = {
          --[[
		faction_key = {
			factor = 5,
		},
		--]]
     },

     -- Similar to above, but only for AI factions and for all factors
     ai_faction_legitimacy_multiplier = 1.2,

     -- Same as above, but for different factors. This stacks with the decay multiplier above, so be careful.
     -- Example: If we have a decay multiplier for battle at 0.5 and a battle multiplier here of 2,
     --          the decay will be multiplied by 0.5 * 2 = 1, while the gain rate will be multiplied by 2.
     --          Result is that AIs will have 2x the battle legitimacy gain rate,
     --          but their decay will remain the same as the player's.
     ai_faction_multiplier_per_factor = {
          ["phar_legitimacy_battle"] = 1.15,
     },

     starting_amounts = {
          --[[
		{
			faction_key = <faction_key>,
			starting_amount = <number>,
		}
		--]]
          {
               faction_key = "phar_main_seti",
               starting_amount = 8,
          },

          {
               faction_key = "phar_main_amenmesse",
               starting_amount = 6,
          },

          {
               faction_key = "phar_main_tausret",
               starting_amount = 5,
          },

          {
               faction_key = "phar_main_ramesses",
               starting_amount = 4,
          },

          {
               faction_key = "phar_main_bay",
               starting_amount = 2,
          },

          {
               faction_key = "phar_main_irsu",
               starting_amount = 0,
          },

          {
               faction_key = "phar_main_suppiluliuma",
               starting_amount = 0,
          },

          {
               faction_key = "phar_main_kurunta",
               starting_amount = 0,
          },

          {
               faction_key = "phar_main_merneptah",
               starting_amount = 12,
          },

          {
               faction_key = "phar_main_setnakhte",
               starting_amount = 6,
          },

          {
               faction_key = "phar_main_akhmim",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_per_amun",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_pi_ramesses",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_rhacotis",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_buto",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_faiyum",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_het_nesut",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_khemenu",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_mefka_qes",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_saww",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_waset",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_zawty",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_abdju",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_kurkur",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_mes",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_miam",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_nubt",
               starting_amount = 3,
          },

          {
               faction_key = "phar_main_buhen",
               starting_amount = 2,
          },

          {
               faction_key = "phar_main_kawa",
               starting_amount = 2,
          },

          {
               faction_key = "phar_main_kerma",
               starting_amount = 2,
          },

          {
               faction_key = "phar_main_napata",
               starting_amount = 2,
          },

          {
               faction_key = "phar_main_bahariya",
               starting_amount = 1,
          },

          {
               faction_key = "phar_main_dakhla",
               starting_amount = 1,
          },

          {
               faction_key = "phar_main_dungul",
               starting_amount = 1,
          },

          {
               faction_key = "phar_main_farafra",
               starting_amount = 1,
          },

          {
               faction_key = "phar_main_kharga",
               starting_amount = 1,
          },
     },

     -- Same as above but for all AI factions instead of specific factions
     ai_bonus_starting_amount = 0,

     building_chain_restrictions = {
          "phar_main_ers_monument_egyp",
     },

     unlock_event = {
          event_key = "politics_legitimacy_path",
          localised_name_key = "troy_main_fm_helen_state_unhappy",
     },

     ui = {
          shared_state_sacred_region_legitimacy = "legitimacy_per_sacred_region",
          shared_state_sacred_regions_to_unlock_legitimacy = "num_sacred_egyptian_lands_to_unlock_legitimacy",
          shared_state_sacred_regions_to_unlock_legitimacy_for_faction = "num_sacred_egyptian_lands_to_unlock_legitimacy",
          shared_state_last_legitimacy_change_was_positive = "last_legitimacy_change_was_positive",

          tooltip_title = "egyptian legitimacy",
          tooltip_description = "egyptian legitimacy",

          sources = {
               {
                    name_key = "campaign_localised_strings_string_legitimacy_factor_battles",
                    factors_keys = { "phar_legitimacy_battle" },
                    tooltip_key = "tooltip_phar_crown_legitimacy_source_egypt_battle",
               },
               {
                    name_key = "campaign_localised_strings_string_legitimacy_factor_sacred_lands",
                    factors_keys = { "phar_legitimacy_sacred_egyptian_lands" },
                    item_display_text = "uied_component_texts_localised_string_dy_title_NewState_Text_3d58e6bc",
                    tooltip_key = "tooltip_phar_crown_legitimacy_source_egypt_sacred_land",
               },
               {
                    name_key = "campaign_localised_strings_string_legitimacy_factor_monuments",
                    factors_keys = { "phar_legitimacy_monuments" },
                    item_display_text = "uied_component_texts_localised_string_dy_title_NewState_Text_3d58e6bc",
                    tooltip_key = "tooltip_phar_crown_legitimacy_source_egypt_monument",
               },
               {
                    name_key = "campaign_localised_strings_string_legitimacy_factor_buildings",
                    factors_keys = { "phar_legitimacy_buildings" },
                    tooltip_key = "tooltip_phar_crown_legitimacy_source_egypt_building",
               },
               {
                    name_key = "campaign_localised_strings_string_legitimacy_factor_landmarks",
                    factors_keys = { "phar_legitimacy_external_region_buildings" },
                    tooltip_key = "tooltip_phar_crown_legitimacy_source_egypt_poi",
               },
               {
                    name_key = "campaign_localised_strings_string_legitimacy_factor_character",
                    factors_keys = { "phar_legitimacy_rightful_heir", "phar_legitimacy_ancillaries", "phar_legitimacy_court_position" },
                    item_display_text = "{{tr:uied_component_texts_localised_string_dy_title_NewState_Text_5d393ad7}}",
                    tooltip_key = "tooltip_phar_crown_legitimacy_source_egypt_character",
               },
               -- {
               -- 	name_key = "event_feed_subcategories_subcategory_title_phar_event_subcategory_politics_court_positions",
               -- 	factors_keys = { "phar_legitimacy_court_position" },
               -- 	tooltip_key = "",
               -- },
               {
                    name_key = "campaign_localised_strings_string_legitimacy_factor_court_plots",
                    factors_keys = { "phar_map_court_decay" },
                    item_display_text = "{{tr:uied_component_texts_localised_string_dy_title_active_Text_3523bdfb}}",
                    tooltip_key = "tooltip_phar_crown_legitimacy_source_egypt_court_intrigue",
               },
               {
                    name_key = "campaign_localised_strings_string_legitimacy_factor_allies",
                    factors_keys = { "phar_legitimacy_ally" },
                    item_display_text = "{{tr:uied_component_texts_localised_string_dy_title_NewState_Text_5be9fa27}}",
                    tooltip_key = "tooltip_phar_crown_legitimacy_source_egypt_decree",
               },
               {
                    name_key = "campaign_localised_strings_string_legitimacy_factor_deities",
                    factors_keys = { "phar_map_legitimacy_local_deities" },
                    item_display_text_favoured_god =
                    "campaign_localised_strings_string_phar_map_pharaohs_crown_patron_deity_legitimacy_source",
                    tooltip_key = "tooltip_phar_crown_legitimacy_source_egypt_deities",
               },
          },

          tooltip_value_breakdown_cco_id = "tooltip_value_breakdown_legitimacy",

          legacy_button_tooltip =
          "{{tr:uied_component_texts_localised_string_button_fm_phar_pharaoh_crown_tooltip_egypt}}",
     },
}

egypt_legitimacy = {
     config = egypt_legitimacy_config,

     post_init = function(self)
          self.powers_system = pharaohs_powers
          self.political_states_system = egypt_political_states
          self.sacred_lands = sacred_egypt_lands
          self.special_ancillary_system = pharaohs_crowns

          legitimacy_choice:register_legitimacy_object(self)
     end,
}

egypt_legitimacy = crown:create_mechanic_from_type(legitimacy_system, egypt_legitimacy)

return egypt_legitimacy
