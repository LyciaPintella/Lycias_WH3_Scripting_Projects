out("Loading phar_ancient_legacy_hammurabi_config.lua")

local create_value_config = function(id, amount, level_requirement, time_cost, justice_gained, divine_law_justice_cost)
     return {
          id = id,
          amount = amount,
          level_requirement = level_requirement,
          time_cost = time_cost,
          justice_gained = justice_gained,
          divine_law_justice_cost = divine_law_justice_cost
     }
end

ancient_legacy_hammurabi_config = {
     max_laws_count = 60,
     max_effects_per_law = 3,
     law_effect_bundle_prefix = "phar_map_al_hammurabi_law_custom_bundle_",
     resource_factor_consumed_by_law_creation = "troy_resource_factor_faction",
     law_removals_gained_for_leader_change = 3,
     restored_percent_of_original_cost_upon_law_remove = 75, -- applicable only to law that is currently being researched (by design)
     resource_key = "phar_map_hammurabi_justice",
     resource_factor_generate_justice = "troy_resource_factor_faction",
     repeated_effects_includes_value = true, -- whether we should check the value of an effect when checking if we already have the same effect in order to increase cost of law
     resource_factor_consumed_by_category_leveling = "troy_resource_factor_faction",
     repeated_effect_non_beneficial_exponent_base = 0.5,

     law_default_description = "ui_text_replacements_localised_text_phar_map_hammurabi_law_default_description",
     ad_text = "ui_text_replacements_localised_text_phar_map_hammurabi_law_description_date_ad",
     bc_text = "ui_text_replacements_localised_text_phar_map_hammurabi_law_description_date_bc",

     actions = {
          instant_research_any_technology = {
               unfulfilled_prerequisites_additional_cost = 6,
               cost_per_turn = 2,
               resource_factor_consumed_by_action = "troy_resource_factor_faction"
          },
          divine_law = {
               resource_factor_consumed_by_action = "troy_resource_factor_faction",
               resource_factor_reward_victory_points = "troy_resource_factor_faction",
               reward_victory_points = 2,
          },
     },

     ambitions_rewarding_justice = {
          {
               tag = "builder",
               amount = 8,
          },
          {
               tag = "overseer",
               amount = 8,
          },
          {
               tag = "scribe",
               amount = 8,
          },
          {
               tag = "diplomat",
               amount = 8,
          },
     },

     effect_types = {

          resource_income_all = {
               name = "ui_text_replacements_localised_text_phar_map_resource_income",
               level_requirement = 1,

               parameters = {
                    raiding = {
                         name = "ui_text_replacements_localised_text_phar_map_from_raiding",
                         level_requirement = 1,
                         effect_key = "phar_main_raid_income_mod_basic",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    captives = {
                         name = "ui_text_replacements_localised_text_phar_map_from_captives",
                         level_requirement = 2,
                         effect_key = "phar_main_post_battle_release_income_mod",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    sacking = {
                         name = "ui_text_replacements_localised_text_phar_map_from_sacking",
                         level_requirement = 5,
                         effect_key = "phar_main_provided_sacking_loot_mod_basic",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    razing = {
                         name = "ui_text_replacements_localised_text_phar_map_from_razing",
                         level_requirement = 7,
                         effect_key = "phar_main_razing_mod_basic",
                         scope_key = "faction_to_character_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

               },
          },

          unit_cost_recruitment = {
               level_requirement = 1,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 1,
                         effect_key = "phar_map_recruitment_cost_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 1,
                         effect_key = "phar_map_recruitment_cost_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 2,
                         effect_key = "phar_map_recruitment_cost_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 3,
                         effect_key = "phar_map_recruitment_cost_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 4,
                         effect_key = "phar_map_recruitment_cost_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 6,
                         effect_key = "phar_map_recruitment_cost_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 8,
                         effect_key = "phar_map_recruitment_cost_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 10,
                         effect_key = "phar_map_recruitment_cost_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 12,
                         effect_key = "phar_map_recruitment_cost_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 14,
                         effect_key = "phar_map_recruitment_cost_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 16,
                         effect_key = "phar_map_recruitment_cost_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 18,
                         effect_key = "phar_map_recruitment_cost_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 20,
                         effect_key = "phar_map_recruitment_cost_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 5, 11, -3, 3, 3),
                         }
                    },
               },
          },

          resource_income_food = {
               level_requirement = 1,

               parameters = {
                    buildings = {
                         name = "ui_text_replacements_localised_text_phar_map_from_buildings",
                         level_requirement = 1,
                         effect_key = "phar_main_effect_economy_buildings_multi_food",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    prosperity_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_prosperity",
                         level_requirement = 2,
                         effect_key = "phar_main_income_prosperity_civilization_level_resource_mult_food",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -4, 11, -3, 3, 3),
                         }
                    },

                    crisis_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_crisis",
                         level_requirement = 4,
                         effect_key = "phar_main_income_crisis_civilization_level_resource_mult_food",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_2", 10, 8, 9, 7, 4),
                              create_value_config("positive_1", 8, 1, 6, 5, 8),
                              create_value_config("negative_1", -3, 1, -1, 1, 6),
                              create_value_config("negative_2", -4, 11, -2, 2, 3),
                              create_value_config("negative_3", -5, 17, -3, 3, 2),
                         }
                    },

                    collapse_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_collapse",
                         level_requirement = 8,
                         effect_key = "phar_main_income_collapse_civilization_level_resource_mult_food",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_2", 8, 8, 6, 5, 4),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -1, 1, 6),
                              create_value_config("negative_2", -4, 11, -2, 2, 3),
                              create_value_config("negative_3", -5, 17, -3, 3, 2),
                              create_value_config("negative_4", -6, 20, -4, 4, 1),
                         }
                    },

                    per_vassal = {
                         name = "ui_text_replacements_localised_text_phar_map_per_vassal",
                         level_requirement = 11,
                         effect_key = "troy_effect_buildings_food_from_vassals",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 50, 14, 9, 7, 4),
                              create_value_config("positive_2", 40, 8, 6, 5, 8),
                              create_value_config("positive_1", 30, 1, 3, 2, 5),
                              create_value_config("negative_1", -20, 1, -2, 1, 6),
                              create_value_config("negative_2", -30, 11, -3, 3, 3),
                         }
                    },
               },
          },

          happiness = {
               level_requirement = 1,

               parameters = {
                    from_max_level_settlements = {
                         level_requirement = 5,
                         effect_key = "phar_map_province_management_happiness_factor_max_level_settlement",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    from_generals = {
                         level_requirement = 1,
                         effect_key = "phar_main_province_public_order_happiness_character_factor_basic",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    --[[	effect turned off, because it can't work with current scoping
				to_adjacent_enemy_province = {
					level_requirement = 9,
					effect_key = "phar_main_province_management_happiness_factor_enemy_adjacent",
					scope_key = "faction_to_province_own_factionwide",
					is_positive_good = false,
					values = {
						create_value_config("positive_3", -3, 14, 9, 7, 4),
						create_value_config("positive_2", -2, 8, 6, 5, 8),
						create_value_config("positive_1", -1, 1, 3, 2, 5),
					}
				},
				--]]

                    from_temples = {
                         level_requirement = 3,
                         effect_key = "phar_main_effect_happiness_temples_technology",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    from_pillars_of_civ = {
                         level_requirement = 9,
                         effect_key = "phar_map_province_management_happiness_factor_pillars_of_civ",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },
               },
          },

          resource_income_stone = {
               level_requirement = 1,

               parameters = {
                    buildings = {
                         name = "ui_text_replacements_localised_text_phar_map_from_buildings",
                         level_requirement = 1,
                         effect_key = "phar_main_effect_economy_buildings_multi_stone",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -4, 11, -3, 3, 3),
                         }
                    },

                    prosperity_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_prosperity",
                         level_requirement = 2,
                         effect_key = "phar_main_income_prosperity_civilization_level_resource_mult_stone",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -4, 11, -3, 3, 3),
                         }
                    },

                    crisis_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_crisis",
                         level_requirement = 4,
                         effect_key = "phar_main_income_crisis_civilization_level_resource_mult_stone",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_2", 10, 8, 9, 7, 4),
                              create_value_config("positive_1", 8, 1, 6, 5, 8),
                              create_value_config("negative_1", -3, 1, -1, 1, 6),
                              create_value_config("negative_2", -4, 11, -2, 2, 3),
                              create_value_config("negative_3", -5, 17, -3, 3, 2),
                         }
                    },

                    collapse_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_collapse",
                         level_requirement = 8,
                         effect_key = "phar_main_income_collapse_civilization_level_resource_mult_stone",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_2", 8, 8, 6, 5, 4),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -1, 1, 6),
                              create_value_config("negative_2", -4, 11, -2, 2, 3),
                              create_value_config("negative_3", -5, 17, -3, 3, 2),
                              create_value_config("negative_4", -6, 20, -4, 4, 1),
                         }
                    },

                    per_vassal = {
                         name = "ui_text_replacements_localised_text_phar_map_per_vassal",
                         level_requirement = 11,
                         effect_key = "troy_effect_buildings_stone_from_vassals",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 40, 14, 9, 7, 4),
                              create_value_config("positive_2", 25, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                              create_value_config("negative_1", -5, 1, -2, 1, 6),
                              create_value_config("negative_2", -10, 11, -3, 3, 3),
                         }
                    },
               },
          },

          unit_cost_upkeep = {
               level_requirement = 9,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 9,
                         effect_key = "phar_map_upkeep_cost_unit_set_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 9,
                         effect_key = "phar_map_upkeep_cost_unit_set_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 10,
                         effect_key = "phar_map_upkeep_cost_unit_set_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 11,
                         effect_key = "phar_map_upkeep_cost_unit_set_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 12,
                         effect_key = "phar_map_upkeep_cost_unit_set_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 13,
                         effect_key = "phar_map_upkeep_cost_unit_set_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 14,
                         effect_key = "phar_map_upkeep_cost_unit_set_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 15,
                         effect_key = "phar_map_upkeep_cost_unit_set_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 16,
                         effect_key = "phar_map_upkeep_cost_unit_set_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 17,
                         effect_key = "phar_map_upkeep_cost_unit_set_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 18,
                         effect_key = "phar_map_upkeep_cost_unit_set_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 19,
                         effect_key = "phar_map_upkeep_cost_unit_set_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 20,
                         effect_key = "phar_map_upkeep_cost_unit_set_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

               },
          },

          construction_cost_resource = {
               level_requirement = 3,

               parameters = {
                    administration = {
                         level_requirement = 3,
                         effect_key = "phar_map_construction_cost_mod_building_set_municipal_complex",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    religious_ers = {
                         level_requirement = 3,
                         effect_key = "phar_main_mod_cost_religious_ers",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 4, 11, -3, 3, 3),
                         }
                    },

                    recruitment = {
                         level_requirement = 4,
                         effect_key = "phar_map_construction_cost_mod_building_set_military_recruit",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    administrative_ers = {
                         level_requirement = 6,
                         effect_key = "phar_map_construction_cost_mod_building_set_administration_ers",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                         }
                    },

                    resource = {
                         level_requirement = 8,
                         effect_key = "phar_map_construction_cost_mod_building_set_resource_production",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    nomadic_ers = {
                         level_requirement = 10,
                         effect_key = "phar_sea_construction_cost_nomad_ers",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                         }
                    },

                    management = {
                         level_requirement = 12,
                         effect_key = "phar_map_construction_cost_mod_building_set_province_management",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    military = {
                         level_requirement = 14,
                         effect_key = "phar_map_construction_cost_mod_building_set_military_administration",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    military_ers = {
                         level_requirement = 16,
                         effect_key = "phar_main_mod_cost_building_set_military_ers",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 4, 11, -3, 3, 3),
                         }
                    },

                    production = {
                         level_requirement = 18,
                         effect_key = "phar_map_construction_cost_mod_building_set_production_management",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },

                    economic_ers = {
                         level_requirement = 19,
                         effect_key = "phar_map_construction_cost_mod_building_set_economic_ers",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -10, 14, 9, 7, 4),
                              create_value_config("positive_2", -8, 8, 6, 5, 8),
                              create_value_config("positive_1", -6, 1, 3, 2, 5),
                              create_value_config("negative_1", 3, 1, -2, 1, 6),
                              create_value_config("negative_2", 4, 11, -3, 3, 3),
                         }
                    },

                    landmark = {
                         level_requirement = 20,
                         effect_key = "phar_map_construction_cost_mod_building_set_landmark",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_3", -8, 14, 9, 7, 4),
                              create_value_config("positive_2", -6, 8, 6, 5, 8),
                              create_value_config("positive_1", -4, 1, 3, 2, 5),
                              create_value_config("negative_1", 2, 1, -2, 1, 6),
                              create_value_config("negative_2", 3, 11, -3, 3, 3),
                         }
                    },
               },
          },

          resource_income_wood = {
               level_requirement = 7,

               parameters = {
                    buildings = {
                         name = "ui_text_replacements_localised_text_phar_map_from_buildings",
                         level_requirement = 7,
                         effect_key = "phar_main_effect_economy_buildings_multi_wood",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -4, 11, -3, 3, 3),
                         }
                    },

                    prosperity_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_prosperity",
                         level_requirement = 8,
                         effect_key = "phar_main_income_prosperity_civilization_level_resource_mult_wood",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -4, 11, -3, 3, 3),
                         }
                    },

                    crisis_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_crisis",
                         level_requirement = 10,
                         effect_key = "phar_main_income_crisis_civilization_level_resource_mult_wood",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_2", 10, 8, 9, 7, 4),
                              create_value_config("positive_1", 8, 1, 6, 5, 8),
                              create_value_config("negative_1", -3, 1, -1, 1, 6),
                              create_value_config("negative_2", -4, 11, -2, 2, 3),
                              create_value_config("negative_3", -5, 17, -3, 3, 2),
                         }
                    },

                    collapse_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_collapse",
                         level_requirement = 12,
                         effect_key = "phar_main_income_collapse_civilization_level_resource_mult_wood",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_2", 8, 8, 6, 5, 4),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -1, 1, 6),
                              create_value_config("negative_2", -4, 11, -2, 2, 3),
                              create_value_config("negative_3", -5, 17, -3, 3, 2),
                              create_value_config("negative_4", -6, 20, -4, 4, 1),
                         }
                    },

                    per_vassal = {
                         name = "ui_text_replacements_localised_text_phar_map_per_vassal",
                         level_requirement = 15,
                         effect_key = "troy_effect_buildings_wood_from_vassals",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 30, 14, 9, 7, 4),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 10, 1, 3, 2, 5),
                              create_value_config("negative_1", -5, 1, -2, 1, 6),
                              create_value_config("negative_2", -10, 11, -3, 3, 3),
                         }
                    },
               },
          },

          influence = {
               level_requirement = 5,

               parameters = {
                    from_max_level_settlements = {
                         level_requirement = 6,
                         effect_key = "phar_map_province_management_influence_factor_max_level_settlement",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    from_generals = {
                         level_requirement = 5,
                         effect_key = "troy_effect_influence_factor_province_with_hero",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    --[[	parameter turned off, because it's not working as intended
				per_alliance = {
					level_requirement = 14,
					effect_key = "phar_effect_technology_influence_per_alliance",
					scope_key = "faction_to_province_own_factionwide",
					is_positive_good = true,
					values = {
						create_value_config("positive_3", 3, 14, 9, 7, 4),
						create_value_config("positive_2", 2, 8, 6, 5, 8),
						create_value_config("positive_1", 1, 1, 3, 2, 5),
						create_value_config("negative_1", -1, 1, -2, 1, 6),
						create_value_config("negative_2", -2, 11, -3, 3, 3),
					}
				},
				]] --

                    from_pillars_of_civ = {
                         level_requirement = 10,
                         effect_key = "phar_map_province_management_influence_factor_pillars_of_civ",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },
               },
          },

          resource_income_bronze = {
               level_requirement = 11,

               parameters = {
                    buildings = {
                         name = "ui_text_replacements_localised_text_phar_map_from_buildings",
                         level_requirement = 11,
                         effect_key = "phar_main_effect_economy_buildings_multi_bronze",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -4, 11, -3, 3, 3),
                         }
                    },

                    prosperity_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_prosperity",
                         level_requirement = 12,
                         effect_key = "phar_main_income_prosperity_civilization_level_resource_mult_bronze",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -4, 11, -3, 3, 3),
                         }
                    },

                    crisis_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_crisis",
                         level_requirement = 13,
                         effect_key = "phar_main_income_crisis_civilization_level_resource_mult_bronze",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_2", 10, 8, 9, 7, 4),
                              create_value_config("positive_1", 8, 1, 6, 5, 8),
                              create_value_config("negative_1", -3, 1, -1, 1, 6),
                              create_value_config("negative_2", -4, 11, -2, 2, 3),
                              create_value_config("negative_3", -5, 17, -3, 3, 2),
                         }
                    },

                    collapse_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_collapse",
                         level_requirement = 15,
                         effect_key = "phar_main_income_collapse_civilization_level_resource_mult_bronze",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_2", 8, 8, 12, 5, 4),
                              create_value_config("positive_1", 6, 1, 9, 2, 5),
                              create_value_config("negative_1", -3, 1, -1, 1, 6),
                              create_value_config("negative_2", -4, 11, -2, 2, 3),
                              create_value_config("negative_3", -5, 17, -3, 3, 2),
                              create_value_config("negative_4", -6, 20, -4, 4, 1),
                         }
                    },

                    per_vassal = {
                         name = "ui_text_replacements_localised_text_phar_map_per_vassal",
                         level_requirement = 17,
                         effect_key = "troy_effect_buildings_bronze_from_vassals",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 30, 14, 9, 7, 4),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 10, 1, 3, 2, 5),
                              create_value_config("negative_1", -5, 1, -2, 1, 6),
                              create_value_config("negative_2", -10, 11, -3, 3, 3),
                         }
                    },
               },
          },

          workforce_growth = {
               level_requirement = 13,

               parameters = {
                    from_max_level_settlements = {
                         level_requirement = 15,
                         effect_key = "phar_map_province_management_growth_factor_max_level_settlement",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 14, 9, 7, 4),
                              create_value_config("positive_2", 3, 8, 6, 5, 8),
                              create_value_config("positive_1", 2, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    from_generals = {
                         level_requirement = 13,
                         effect_key = "phar_main_province_development_growth_added_character_basic",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 14, 9, 7, 4),
                              create_value_config("positive_2", 3, 8, 6, 5, 8),
                              create_value_config("positive_1", 2, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    --[[	parameter turned off, because it's not working as intended
				per_alliance = {
					level_requirement = 19,
					effect_key = "phar_effect_technology_growth_per_alliance",
					scope_key = "faction_to_province_own_factionwide",
					is_positive_good = true,
					values = {
						create_value_config("positive_3", 4, 14, 9, 7, 4),
						create_value_config("positive_2", 3, 8, 6, 5, 8),
						create_value_config("positive_1", 2, 1, 3, 2, 5),
						create_value_config("negative_1", -1, 1, -2, 1, 6),
						create_value_config("negative_2", -2, 11, -3, 3, 3),
					}
				},
				]] --

                    from_pillars_of_civ = {
                         level_requirement = 17,
                         effect_key = "phar_map_province_management_growth_factor_pillars_of_civ",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 14, 9, 7, 4),
                              create_value_config("positive_2", 3, 8, 6, 5, 8),
                              create_value_config("positive_1", 2, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },
               },
          },

          diplomatic_relations = {
               level_requirement = 17,

               parameters = {
                    egyptian = {
                         level_requirement = 17,
                         effect_key = "phar_main_diplomatic_relations_kemet",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 5, 14, 12, 9, 4),
                              create_value_config("positive_2", 3, 8, 9, 7, 11),
                              create_value_config("positive_1", 2, 1, 6, 2, 8),
                              create_value_config("negative_1", -2, 1, -3, 1, 6),
                              create_value_config("negative_2", -3, 11, -5, 3, 3),
                         }
                    },

                    canaanite = {
                         name = "ui_text_replacements_localised_text_phar_main_help_pages_factions_canaanite_title",
                         level_requirement = 17,
                         effect_key = "phar_main_diplomatic_relations_canaanites",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 5, 14, 12, 9, 4),
                              create_value_config("positive_2", 3, 8, 9, 7, 11),
                              create_value_config("positive_1", 2, 1, 6, 2, 8),
                              create_value_config("negative_1", -2, 1, -3, 1, 6),
                              create_value_config("negative_2", -3, 11, -5, 3, 3),
                         }
                    },

                    hittite = {
                         level_requirement = 17,
                         effect_key = "phar_main_diplomatic_relations_hittites",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 5, 14, 12, 9, 4),
                              create_value_config("positive_2", 3, 8, 9, 7, 11),
                              create_value_config("positive_1", 2, 1, 6, 2, 8),
                              create_value_config("negative_1", -2, 1, -3, 1, 6),
                              create_value_config("negative_2", -3, 11, -5, 3, 3),
                         }
                    },

                    aegean = {
                         level_requirement = 17,
                         effect_key = "phar_map_technologies_diplomatic_relations_aegeans",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 5, 14, 12, 9, 4),
                              create_value_config("positive_2", 3, 8, 9, 7, 11),
                              create_value_config("positive_1", 2, 1, 6, 2, 8),
                              create_value_config("negative_1", -2, 1, -3, 1, 6),
                              create_value_config("negative_2", -3, 11, -5, 3, 3),
                         }
                    },

                    mesopotamian = {
                         name = "ui_text_replacements_localised_text_phar_local_deities_cultures_mesopotamian",
                         level_requirement = 17,
                         effect_key = "phar_map_technologies_diplomatic_relations_mesopotamia",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 5, 14, 12, 9, 4),
                              create_value_config("positive_2", 3, 8, 9, 7, 11),
                              create_value_config("positive_1", 2, 1, 6, 2, 8),
                              create_value_config("negative_1", -2, 1, -3, 1, 6),
                              create_value_config("negative_2", -3, 11, -5, 3, 3),
                         }
                    },

                    sea_peoples = {
                         name = "ui_text_replacements_localised_text_phar_main_help_pages_factions_sea_peoples_title",
                         level_requirement = 20,
                         effect_key = "phar_sea_diplomatic_relations_sea_peoples",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 5, 14, 12, 9, 4),
                              create_value_config("positive_2", 3, 8, 9, 7, 11),
                              create_value_config("positive_1", 2, 1, 6, 2, 8),
                              create_value_config("negative_1", -2, 1, -3, 1, 6),
                         }
                    },

                    nomads = {
                         name =
                         "ui_text_replacements_localised_text_phar_main_help_pages_campaign_pillars_of_civilization_nomadic_tribes_title",
                         level_requirement = 20,
                         effect_key = "phar_sea_diplomatic_relations_nomads",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 5, 14, 12, 9, 4),
                              create_value_config("positive_2", 3, 8, 9, 7, 11),
                              create_value_config("positive_1", 2, 1, 6, 2, 8),
                              create_value_config("negative_1", -2, 1, -3, 1, 6),
                         }
                    },
               },
          },

          resource_income_gold = {
               level_requirement = 19,

               parameters = {
                    buildings = {
                         name = "ui_text_replacements_localised_text_phar_map_from_buildings",
                         level_requirement = 19,
                         effect_key = "phar_main_effect_economy_buildings_multi_gold",
                         scope_key = "faction_to_province_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -4, 11, -3, 3, 3),
                         }
                    },

                    prosperity_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_prosperity",
                         level_requirement = 19,
                         effect_key = "phar_main_income_prosperity_civilization_level_resource_mult_gold",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -4, 11, -3, 3, 3),
                         }
                    },

                    crisis_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_crisis",
                         level_requirement = 19,
                         effect_key = "phar_main_income_crisis_civilization_level_resource_mult_gold",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_2", 10, 8, 9, 7, 4),
                              create_value_config("positive_1", 8, 1, 6, 5, 8),
                              create_value_config("negative_1", -3, 1, -1, 1, 6),
                              create_value_config("negative_2", -4, 11, -2, 2, 3),
                              create_value_config("negative_3", -5, 17, -3, 3, 2),
                         }
                    },

                    collapse_civilization_level = {
                         name = "ui_text_replacements_localised_text_phar_map_during_collapse",
                         level_requirement = 19,
                         effect_key = "phar_main_income_collapse_civilization_level_resource_mult_gold",
                         scope_key = "faction_to_region_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_2", 8, 8, 12, 5, 4),
                              create_value_config("positive_1", 6, 1, 9, 2, 5),
                              create_value_config("negative_1", -3, 1, -1, 1, 6),
                              create_value_config("negative_2", -4, 11, -2, 2, 3),
                              create_value_config("negative_3", -5, 17, -3, 3, 2),
                              create_value_config("negative_4", -6, 20, -4, 4, 1),
                         }
                    },

                    per_vassal = {
                         name = "ui_text_replacements_localised_text_phar_map_per_vassal",
                         level_requirement = 20,
                         effect_key = "troy_effect_buildings_gold_from_vassals",
                         scope_key = "faction_to_faction_own",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 15, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 5, 1, 3, 2, 5),
                              create_value_config("negative_1", -4, 1, -2, 1, 6),
                              create_value_config("negative_2", -6, 11, -3, 3, 3),
                         }
                    },
               },
          },

          construction_cost_time = {
               level_requirement = 20,

               parameters = {
                    level_4_administration = {
                         level_requirement = 20,
                         effect_key = "phar_map_construction_time_mod_building_set_municipal_complex_level_4",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 7, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                              create_value_config("negative_2", 2, 11, -4, 5, 5),
                         }
                    },

                    level_4_recruitment = {
                         level_requirement = 20,
                         effect_key = "phar_map_construction_time_mod_building_set_military_recruit_level_4",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 7, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                              create_value_config("negative_2", 2, 11, -4, 5, 5),
                         }
                    },

                    level_4_management = {
                         level_requirement = 20,
                         effect_key = "phar_map_construction_time_mod_building_set_province_management_level_4",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 7, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                              create_value_config("negative_2", 2, 11, -4, 5, 5),
                         }
                    },

                    level_4_military = {
                         level_requirement = 20,
                         effect_key = "phar_map_construction_time_mod_building_set_military_administration_level_4",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 7, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                              create_value_config("negative_2", 2, 11, -4, 5, 5),
                         }
                    },

                    level_4_production = {
                         level_requirement = 20,
                         effect_key = "phar_map_construction_time_mod_building_set_production_management_level_4",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 7, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                              create_value_config("negative_2", 2, 11, -4, 5, 5),
                         }
                    },

                    level_5_administration = {
                         level_requirement = 20,
                         effect_key = "phar_map_construction_time_mod_building_set_municipal_complex_level_5",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 7, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                              create_value_config("negative_2", 2, 11, -4, 5, 5),
                         }
                    },

                    level_5_recruitment = {
                         level_requirement = 20,
                         effect_key = "phar_map_construction_time_mod_building_set_military_recruit_level_5",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 7, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                              create_value_config("negative_2", 2, 11, -4, 5, 5),
                         }
                    },

                    level_5_management = {
                         level_requirement = 20,
                         effect_key = "phar_map_construction_time_mod_building_set_province_management_level_5",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 7, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                              create_value_config("negative_2", 2, 11, -4, 5, 5),
                         }
                    },

                    landmark = {
                         level_requirement = 20,
                         effect_key = "phar_map_construction_time_mod_building_set_landmark",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 7, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                              create_value_config("negative_2", 2, 11, -4, 5, 5),
                         }
                    },
               },
          },

          construction_cost_workforce = {
               level_requirement = 15,

               parameters = {
                    level_4_administration = {
                         level_requirement = 15,
                         effect_key = "phar_map_workforce_cost_mod_building_set_municipal_complex_level_4",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 9, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                         }
                    },

                    level_4_recruitment = {
                         level_requirement = 15,
                         effect_key = "phar_map_workforce_cost_mod_building_set_military_recruit_level_4",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 9, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                         }
                    },

                    level_4_management = {
                         level_requirement = 16,
                         effect_key = "phar_map_workforce_cost_mod_building_set_province_management_level_4",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 9, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                         }
                    },

                    level_4_military = {
                         level_requirement = 16,
                         effect_key = "phar_map_workforce_cost_mod_building_set_military_administration_level_4",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 9, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                         }
                    },

                    level_4_production = {
                         level_requirement = 17,
                         effect_key = "phar_map_workforce_cost_mod_building_set_production_management_level_4",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 9, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                         }
                    },

                    level_5_administration = {
                         level_requirement = 17,
                         effect_key = "phar_map_workforce_cost_mod_building_set_municipal_complex_level_5",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 9, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                         }
                    },

                    level_5_recruitment = {
                         level_requirement = 18,
                         effect_key = "phar_map_workforce_cost_mod_building_set_military_recruit_level_5",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 9, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                         }
                    },

                    level_5_management = {
                         level_requirement = 18,
                         effect_key = "phar_map_workforce_cost_mod_building_set_province_management_level_5",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 9, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                         }
                    },

                    landmark = {
                         level_requirement = 19,
                         effect_key = "phar_map_workforce_cost_mod_building_set_landmark",
                         scope_key = "faction_to_region_own",
                         is_positive_good = false,
                         values = {
                              create_value_config("positive_2", -2, 8, 9, 9, 4),
                              create_value_config("positive_1", -1, 1, 6, 5, 8),
                              create_value_config("negative_1", 1, 1, -3, 3, 10),
                         }
                    },
               },
          },

          melee_defence = {
               level_requirement = 1,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 1,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 1,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 3,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 3,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 5,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 5,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 7,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 7,
                         effect_key = "phar_main_melee_defence_mod_mult_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 9,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 9,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 11,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 11,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 13,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 13,
                         effect_key = "phar_map_melee_defence_mod_mult_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },
               },
          },

          melee_attack = {
               level_requirement = 2,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 2,
                         effect_key = "phar_map_melee_attack_mod_mult_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 2,
                         effect_key = "phar_map_melee_attack_mod_mult_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 4,
                         effect_key = "phar_map_melee_attack_mod_mult_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 6,
                         effect_key = "phar_map_melee_attack_mod_mult_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 8,
                         effect_key = "phar_map_melee_attack_mod_mult_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 10,
                         effect_key = "phar_map_melee_attack_mod_mult_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 12,
                         effect_key = "phar_map_melee_attack_mod_mult_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 14,
                         effect_key = "phar_map_melee_attack_mod_mult_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 16,
                         effect_key = "phar_map_melee_attack_mod_mult_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 18,
                         effect_key = "phar_map_melee_attack_mod_mult_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },
               },
          },

          ammunition = {
               level_requirement = 2,

               parameters = {
                    phar_main_ranged_slings = {
                         level_requirement = 1,
                         effect_key = "phar_map_ammo_mod_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 16, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -4, 1, -2, 1, 6),
                              create_value_config("negative_2", -7, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 1,
                         effect_key = "phar_map_ammo_mod_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 16, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -4, 1, -2, 1, 6),
                              create_value_config("negative_2", -7, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 4,
                         effect_key = "phar_map_ammo_mod_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 16, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -4, 1, -2, 1, 6),
                              create_value_config("negative_2", -7, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 2,
                         effect_key = "phar_map_ammo_mod_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 16, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -4, 1, -2, 1, 6),
                              create_value_config("negative_2", -7, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 6,
                         effect_key = "phar_map_ammo_mod_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 16, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -4, 1, -2, 1, 6),
                              create_value_config("negative_2", -7, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 8,
                         effect_key = "phar_map_ammo_mod_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 16, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -4, 1, -2, 1, 6),
                              create_value_config("negative_2", -7, 11, -3, 3, 3),
                         }
                    },
               },
          },

          charge_bonus = {
               level_requirement = 5,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 5,
                         effect_key = "phar_map_charge_bonus_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 5,
                         effect_key = "phar_map_charge_bonus_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 7,
                         effect_key = "phar_map_charge_bonus_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 7,
                         effect_key = "phar_map_charge_bonus_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 9,
                         effect_key = "phar_map_charge_bonus_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 11,
                         effect_key = "phar_map_charge_bonus_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 9,
                         effect_key = "phar_map_charge_bonus_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 13,
                         effect_key = "phar_map_charge_bonus_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 13,
                         effect_key = "phar_map_charge_bonus_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 15,
                         effect_key = "phar_map_charge_bonus_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 15,
                         effect_key = "phar_map_charge_bonus_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },
               },
          },

          battle_speed = {
               level_requirement = 1,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 1,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 1,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 2,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 2,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 4,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 4,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 6,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 6,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 8,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 8,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 10,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 10,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 12,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 12,
                         effect_key = "phar_map_mod_land_movement_battle_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

               },
          },

          melee_damage = {
               level_requirement = 4,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 4,
                         effect_key = "phar_map_melee_damage_mod_mult_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 4,
                         effect_key = "phar_map_melee_damage_mod_mult_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 6,
                         effect_key = "phar_map_melee_damage_mod_mult_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 6,
                         effect_key = "phar_map_melee_damage_mod_mult_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 8,
                         effect_key = "phar_map_melee_damage_mod_mult_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 10,
                         effect_key = "phar_map_melee_damage_mod_mult_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 8,
                         effect_key = "phar_map_melee_damage_mod_mult_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 12,
                         effect_key = "phar_map_melee_damage_mod_mult_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 14,
                         effect_key = "phar_map_melee_damage_mod_mult_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 16,
                         effect_key = "phar_map_melee_damage_mod_mult_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },
               },
          },

          ranged_damage = {
               level_requirement = 3,

               parameters = {
                    phar_main_ranged_slings = {
                         level_requirement = 3,
                         effect_key = "phar_map_missile_damage_mod_mult_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 5,
                         effect_key = "phar_map_missile_damage_mod_mult_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 9,
                         effect_key = "phar_map_missile_damage_mod_mult_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 7,
                         effect_key = "phar_map_missile_damage_mod_mult_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 11,
                         effect_key = "phar_map_missile_damage_mod_mult_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 13,
                         effect_key = "phar_map_missile_damage_mod_mult_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },
               },
          },

          experience_battle = {
               level_requirement = 1,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 1,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 1,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 2,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 2,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 4,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 4,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 6,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 6,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 8,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 8,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 10,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 12,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 14,
                         effect_key = "phar_map_unit_percentage_xp_mod_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 14, 14, 9, 7, 4),
                              create_value_config("positive_2", 10, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                         }
                    },
               },
          },

          range = {
               level_requirement = 16,

               parameters = {
                    phar_main_ranged_slings = {
                         level_requirement = 16,
                         effect_key = "phar_map_range_mod_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 17,
                         effect_key = "phar_map_range_mod_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 19,
                         effect_key = "phar_map_range_mod_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 18,
                         effect_key = "phar_map_range_mod_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 20,
                         effect_key = "phar_map_range_mod_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 20,
                         effect_key = "phar_map_range_mod_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },
               },
          },

          armour = {
               level_requirement = 8,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 8,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 8,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 10,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 10,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 12,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 12,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 14,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 14,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 16,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 16,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 18,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 18,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 20,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 20,
                         effect_key = "phar_map_armour_mod_mult_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 7, 14, 9, 7, 4),
                              create_value_config("positive_2", 5, 8, 6, 5, 8),
                              create_value_config("positive_1", 3, 1, 3, 2, 5),
                              create_value_config("negative_1", -2, 1, -2, 1, 6),
                              create_value_config("negative_2", -3, 11, -3, 3, 3),
                         }
                    },
               },
          },

          melee_lethal_blow = {
               level_requirement = 14,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 14,
                         effect_key = "phar_map_melee_lethal_blow_mod_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 14,
                         effect_key = "phar_map_melee_lethal_blow_mod_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 15,
                         effect_key = "phar_map_melee_lethal_blow_mod_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 15,
                         effect_key = "phar_map_melee_lethal_blow_mod_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 16,
                         effect_key = "phar_map_melee_lethal_blow_mod_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 16,
                         effect_key = "phar_map_melee_lethal_blow_mod_unit_sets_phar_main_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 17,
                         effect_key = "phar_map_melee_lethal_blow_mod_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 17,
                         effect_key = "phar_map_melee_lethal_blow_mod_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 18,
                         effect_key = "phar_map_melee_lethal_blow_mod_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 18,
                         effect_key = "phar_map_melee_lethal_blow_mod_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },
               },
          },

          ranged_lethal_blow = {
               level_requirement = 12,

               parameters = {
                    phar_main_ranged_slings = {
                         level_requirement = 12,
                         effect_key = "phar_map_missile_lethal_blow_mod_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 13,
                         effect_key = "phar_map_missile_lethal_blow_mod_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 15,
                         effect_key = "phar_map_missile_lethal_blow_mod_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 14,
                         effect_key = "phar_map_missile_lethal_blow_mod_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 16,
                         effect_key = "phar_map_missile_lethal_blow_mod_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },

                    phar_main_cavalry_all = {
                         level_requirement = 17,
                         effect_key = "phar_map_missile_lethal_blow_mod_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                              create_value_config("negative_1", -1, 1, -2, 1, 6),
                              create_value_config("negative_2", -2, 11, -3, 3, 3),
                         }
                    },
               },
          },

          experience_per_turn = {
               level_requirement = 10,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 10,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 10,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 11,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 11,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 13,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 13,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 15,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 15,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 17,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 17,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 19,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 19,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 20,
                         effect_key = "phar_map_unit_xp_mod_training_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_4", 30, 20, 12, 9, 4),
                              create_value_config("positive_3", 25, 14, 9, 7, 11),
                              create_value_config("positive_2", 20, 8, 6, 5, 8),
                              create_value_config("positive_1", 15, 1, 3, 2, 5),
                         }
                    },
               },
        },

--Lycia Bookmark!
          replenishment = {
               level_requirement = 6,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 6,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 6,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 7,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 7,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 8,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 8,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 9,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 10,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 9,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 11,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 11,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 12,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 12,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 13,
                         effect_key = "phar_map_replenishment_percentage_bonus_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 6, 14, 6, 7, 4),
                              create_value_config("positive_2", 4, 8, 4, 5, 8),
                              create_value_config("positive_1", 2, 1, 2, 2, 5),
                         }
                    },
               },
          },
        --Lycia Bookmark - End Replenishment Section

          reload_time = {
               level_requirement = 9,

               parameters = {
                    phar_main_ranged_slings = {
                         level_requirement = 9,
                         effect_key = "phar_map_reload_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 11,
                         effect_key = "phar_map_reload_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_bodyguards = {
                         level_requirement = 15,
                         effect_key = "phar_map_reload_unit_sets_bodyguards",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 13,
                         effect_key = "phar_map_reload_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 17,
                         effect_key = "phar_map_reload_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 19,
                         effect_key = "phar_map_reload_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 10, 14, 9, 7, 4),
                              create_value_config("positive_2", 8, 8, 6, 5, 8),
                              create_value_config("positive_1", 6, 1, 3, 2, 5),
                              create_value_config("negative_1", -3, 1, -2, 1, 6),
                              create_value_config("negative_2", -5, 11, -3, 3, 3),
                         }
                    },
               },
          },

          morale = {
               level_requirement = 18,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 18,
                         effect_key = "phar_map_morale_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 4, 20, 12, 9, 4),
                              create_value_config("positive_2", 3, 19, 9, 7, 11),
                              create_value_config("positive_1", 2, 18, 6, 3, 8),
                         }
                    },
               },
          },

          recruitment_rank = {
               level_requirement = 7,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 7,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_1h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 7,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_ranged_slings",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 9,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_2h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 9,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_1h_swords",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 11,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_ranged_bows",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 11,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_2h_clubs",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 13,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_1h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 13,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_ranged_javelins",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 15,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_1h_spears",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 15,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_2h_axes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 17,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_1h_khopesh",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 17,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_cavalry_all",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 19,
                         effect_key = "phar_map_unit_xp_mod_unit_sets_chariots",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         values = {
                              create_value_config("positive_3", 3, 14, 9, 7, 4),
                              create_value_config("positive_2", 2, 8, 6, 5, 8),
                              create_value_config("positive_1", 1, 1, 3, 2, 5),
                         }
                    },
               },
          },

          att_resist_heat = {
               level_requirement = 11,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_resist_heat",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_scare_horses = {
               level_requirement = 12,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_scare_horses",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_desert_fighters = {
               level_requirement = 12,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 12,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_desert_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_storm_warriors = {
               level_requirement = 13,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_storm_warriors",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_ignore_forest_penalties = {
               level_requirement = 14,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_ignore_forest_penalties",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_flanking_attack_improved = {
               level_requirement = 14,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_flanking_attack_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_flanking_attack_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_flanking_attack_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_flanking_attack_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_flanking_attack_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_flanking_attack_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_flanking_attack_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_flanking_attack_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_flanking_attack_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 14,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_flanking_attack_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_powerful_strikes = {
               level_requirement = 15,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_powerful_strikes",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_steadfast = {
               level_requirement = 15,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_rear_defence",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_flanking_defense_improved = {
               level_requirement = 19,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_flanking_defence_improved",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_disciplined = {
               level_requirement = 16,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_disciplined",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_encourage = {
               level_requirement = 17,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_encourages",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_furious_charge = {
               level_requirement = 17,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_furious_charge",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_furious_charge",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_furious_charge",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_furious_charge",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_furious_charge",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_furious_charge",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_furious_charge",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_furious_charge",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_furious_charge",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_furious_charge",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_hide_scrub = {
               level_requirement = 18,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_hide_scrub_and_forest",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_immune_fear = {
               level_requirement = 18,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_scare_immune",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_expendable = {
               level_requirement = 16,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_expendable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_overburdened = {
               level_requirement = 13,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 7,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 13,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_overburdened",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },
               }
          },

          att_weak_vigour = {
               level_requirement = 11,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 11,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_fatigue_weakness",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = false,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },
               }
          },

          att_guerilla_deploy = {
               level_requirement = 19,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_cavalry_all = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_guerrilla_deploy",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_immune_psychology = {
               level_requirement = 20,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_cavalry_all_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_chariots_immune_to_psychology",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          att_unspottable = {
               level_requirement = 20,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_clubs_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_slings_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_spears_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_swords_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_bows_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_clubs_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_axes_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_ranged_javelins_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_spears_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_2h_axes_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_attribute_1h_khopesh_unspottable",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          abi_eager_for_battle = {
               level_requirement = 15,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_clubs_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_slings_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_spears_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_swords_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_bows_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_clubs_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_axes_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_javelins_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_spears_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_axes_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_khopesh_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_cavalry_all_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 15,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_chariots_eager_for_battle_no_phase",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, -4, 5, 4),
                         }
                    },
               }
          },

          abi_catch_your_breath = {
               level_requirement = 16,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_clubs_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_slings_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_spears_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_swords_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_bows_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_clubs_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_axes_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_javelins_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_spears_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_axes_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_khopesh_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_cavalry_all_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 16,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_chariots_catch_your_breath",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          abi_sand_scorpions = {
               level_requirement = 17,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_clubs_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_slings_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_spears_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_swords_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_bows_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_clubs_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_axes_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_javelins_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_spears_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_axes_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_khopesh_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_cavalry_all_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 17,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_chariots_sand_scorpions",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          abi_mistwalkers = {
               level_requirement = 18,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_clubs_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_slings_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_spears_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_swords_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_bows_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_clubs_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_axes_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_javelins_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_spears_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_axes_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_khopesh_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_cavalry_all_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 18,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_chariots_mistwalkers",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          abi_inspired_by_the_best = {
               level_requirement = 19,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_clubs_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_slings_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_spears_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_swords_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_bows_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_clubs_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_axes_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_javelins_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_spears_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_axes_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_khopesh_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_cavalry_all_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 19,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_chariots_inspired_by_the_best",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },

          abi_underdog = {
               level_requirement = 20,

               parameters = {
                    phar_main_1h_clubs = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_clubs_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_slings = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_slings_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_spears = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_spears_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_swords = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_swords_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_bows = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_bowmen",
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_bows_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_clubs = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_clubs_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_axes = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_axes_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_ranged_javelins = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_javelin_throwers",
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_ranged_javelins_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_spears = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_spears_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_2h_axes = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_2h_axes_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_1h_khopesh = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_1h_khopesh_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_map_cavalry_all = {
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_cavalry_all_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },

                    phar_main_chariots = {
                         name = "ui_text_replacements_localised_text_hp_title_unit_chariots",
                         level_requirement = 20,
                         effect_key = "phar_map_enable_unit_set_unit_abilities_chariots_underdog",
                         scope_key = "faction_to_force_own_factionwide",
                         is_positive_good = true,
                         is_boolean = true,
                         values = {
                              create_value_config("positive_1", 1, 1, 8, 5, 4),
                         }
                    },
               }
          },
     },
}

ancient_legacy_hammurabi_config.categories = {
     civil = {
          base_resource_cost = { { key = "troy_food", amount = -40 } },
          event_key = "ancient_legacy_hammurabi_civil_law_activated",
          event_for_predefined_description_key = "ancient_legacy_hammurabi_civil_law_activated_predefined_description",
          titles = {
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_civil_title_1",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_civil_title_2",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_civil_title_3",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_civil_title_4",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_civil_title_5",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_civil_title_6",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_civil_title_7",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_civil_title_8",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_civil_title_9",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_civil_title_10"
          },

          sub_categories = {
               economy = {
                    effect_types = {
                         ancient_legacy_hammurabi_config.effect_types.resource_income_all,
                         ancient_legacy_hammurabi_config.effect_types.resource_income_food,
                         ancient_legacy_hammurabi_config.effect_types.resource_income_stone,
                         ancient_legacy_hammurabi_config.effect_types.resource_income_wood,
                         ancient_legacy_hammurabi_config.effect_types.resource_income_bronze,
                         ancient_legacy_hammurabi_config.effect_types.resource_income_gold,
                    },

                    ui = {
                         order = 1,
                         icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_income_tab_icon.png",
                         cuneiform_icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_city_cuneiform.png",
                         title = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_income_title",
                         flavour = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_income_desc",
                    },
               },
               construction = {
                    effect_types = {
                         ancient_legacy_hammurabi_config.effect_types.construction_cost_resource,
                         ancient_legacy_hammurabi_config.effect_types.construction_cost_time,
                         ancient_legacy_hammurabi_config.effect_types.construction_cost_workforce,
                    },

                    ui = {
                         order = 2,
                         icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_construction_tab_icon.png",
                         cuneiform_icon_path =
                         "UI/skins/default/map_legacy_hammurabi/phar_map_mes_construction_cuneiform.png",
                         title =
                         "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_construction_title",
                         flavour =
                         "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_construction_desc",
                    },
               },
               army = {
                    effect_types = {
                         ancient_legacy_hammurabi_config.effect_types.unit_cost_recruitment,
                         ancient_legacy_hammurabi_config.effect_types.unit_cost_upkeep,
                    },

                    ui = {
                         order = 3,
                         icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_army_tab_icon.png",
                         cuneiform_icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_soldier_cuneiform.png",
                         title = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_army_title",
                         flavour = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_army_desc",
                    },
               },
               kingdom = {
                    effect_types = {
                         ancient_legacy_hammurabi_config.effect_types.happiness,
                         ancient_legacy_hammurabi_config.effect_types.influence,
                         ancient_legacy_hammurabi_config.effect_types.workforce_growth,
                         ancient_legacy_hammurabi_config.effect_types.diplomatic_relations,

                    },

                    ui = {
                         order = 4,
                         icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_kingdom_tab_icon.png",
                         cuneiform_icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_kingdom_cuneiform.png",
                         title = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_kingdom_title",
                         flavour = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_kingdom_desc",
                    },
               },
          },

          levels = {
               {
                    justice_cost = 1,
                    level = 2
               },
               {
                    justice_cost = 1,
                    level = 3
               },
               {
                    justice_cost = 1,
                    level = 4
               },
               {
                    justice_cost = 2,
                    level = 5
               },
               {
                    justice_cost = 2,
                    level = 6
               },
               {
                    justice_cost = 2,
                    level = 7
               },
               {
                    justice_cost = 3,
                    level = 8
               },
               {
                    justice_cost = 3,
                    level = 9
               },
               {
                    justice_cost = 3,
                    level = 10

               },
               {
                    justice_cost = 4,
                    level = 11
               },
               {
                    justice_cost = 4,
                    level = 12
               },
               {
                    justice_cost = 4,
                    level = 13
               },
               {
                    justice_cost = 5,
                    level = 14
               },
               {
                    justice_cost = 5,
                    level = 15
               },
               {
                    justice_cost = 5,
                    level = 16
               },
               {
                    justice_cost = 6,
                    level = 17
               },
               {
                    justice_cost = 6,
                    level = 18
               },
               {
                    justice_cost = 6,
                    level = 19
               },
               {
                    justice_cost = 7,
                    level = 20
               },
          },

          ui = {
               title = "ui_text_replacements_localised_text_phar_map_hammurabi_category_civil_title",
               illustration_state_name = "civilian",
               icon_state_name = "civilian",
          },
     },
     military = {
          base_resource_cost = { { key = "troy_bronze", amount = -20 } },
          event_key = "ancient_legacy_hammurabi_military_law_activated",
          event_for_predefined_description_key = "ancient_legacy_hammurabi_military_law_activated_predefined_description",
          titles = {
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_military_title_1",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_military_title_2",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_military_title_3",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_military_title_4",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_military_title_5",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_military_title_6",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_military_title_7",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_military_title_8",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_military_title_9",
               "ui_text_replacements_localised_text_phar_map_al_hammurabi_law_default_military_title_10"
          },

          sub_categories = {
               strength = {
                    effect_types = {
                         ancient_legacy_hammurabi_config.effect_types.melee_defence,
                         ancient_legacy_hammurabi_config.effect_types.melee_attack,
                         ancient_legacy_hammurabi_config.effect_types.ammunition,
                         ancient_legacy_hammurabi_config.effect_types.charge_bonus,
                         ancient_legacy_hammurabi_config.effect_types.battle_speed,
                         ancient_legacy_hammurabi_config.effect_types.melee_damage,
                         ancient_legacy_hammurabi_config.effect_types.ranged_damage,
                         ancient_legacy_hammurabi_config.effect_types.range,
                         ancient_legacy_hammurabi_config.effect_types.armour,
                         ancient_legacy_hammurabi_config.effect_types.melee_lethal_blow,
                         ancient_legacy_hammurabi_config.effect_types.ranged_lethal_blow,
                         ancient_legacy_hammurabi_config.effect_types.replenishment,
                         ancient_legacy_hammurabi_config.effect_types.reload_time,
                         ancient_legacy_hammurabi_config.effect_types.morale,
                    },

                    ui = {
                         order = 1,
                         icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_strength_tab_icon.png",
                         cuneiform_icon_path =
                         "UI/skins/default/map_legacy_hammurabi/phar_map_mes_strength_cuneiform.png",
                         title = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_strength_title",
                         flavour = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_strength_desc",
                    },
               },
               experience = {
                    effect_types = {
                         ancient_legacy_hammurabi_config.effect_types.experience_battle,
                         ancient_legacy_hammurabi_config.effect_types.experience_per_turn,
                         ancient_legacy_hammurabi_config.effect_types.recruitment_rank,
                    },

                    ui = {
                         order = 2,
                         icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_experience_tab_icon.png",
                         cuneiform_icon_path =
                         "UI/skins/default/map_legacy_hammurabi/phar_map_mes_experience_cuneiform.png",
                         title = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_experience_title",
                         flavour =
                         "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_experience_desc",
                    },
               },
               attributes = {
                    effect_types = {
                         ancient_legacy_hammurabi_config.effect_types.att_resist_heat,
                         ancient_legacy_hammurabi_config.effect_types.att_scare_horses,
                         ancient_legacy_hammurabi_config.effect_types.att_desert_fighters,
                         ancient_legacy_hammurabi_config.effect_types.att_storm_warriors,
                         ancient_legacy_hammurabi_config.effect_types.att_ignore_forest_penalties,
                         ancient_legacy_hammurabi_config.effect_types.att_flanking_attack_improved,
                         ancient_legacy_hammurabi_config.effect_types.att_powerful_strikes,
                         ancient_legacy_hammurabi_config.effect_types.att_steadfast,
                         ancient_legacy_hammurabi_config.effect_types.att_flanking_defense_improved,
                         ancient_legacy_hammurabi_config.effect_types.att_disciplined,
                         ancient_legacy_hammurabi_config.effect_types.att_encourage,
                         ancient_legacy_hammurabi_config.effect_types.att_furious_charge,
                         ancient_legacy_hammurabi_config.effect_types.att_hide_scrub,
                         ancient_legacy_hammurabi_config.effect_types.att_immune_fear,
                         ancient_legacy_hammurabi_config.effect_types.att_expendable,
                         ancient_legacy_hammurabi_config.effect_types.att_guerilla_deploy,
                         ancient_legacy_hammurabi_config.effect_types.att_immune_psychology,
                         ancient_legacy_hammurabi_config.effect_types.att_unspottable,
                         ancient_legacy_hammurabi_config.effect_types.att_overburdened,
                         ancient_legacy_hammurabi_config.effect_types.att_weak_vigour,
                    },

                    ui = {
                         order = 3,
                         icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_attributes_icon.png",
                         cuneiform_icon_path =
                         "UI/skins/default/map_legacy_hammurabi/phar_map_mes_attributes_cuneiform.png",
                         title = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_attributes_title",
                         flavour =
                         "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_attributes_desc",
                    },
               },
               abilities = {
                    effect_types = {
                         ancient_legacy_hammurabi_config.effect_types.abi_eager_for_battle,
                         ancient_legacy_hammurabi_config.effect_types.abi_catch_your_breath,
                         ancient_legacy_hammurabi_config.effect_types.abi_sand_scorpions,
                         ancient_legacy_hammurabi_config.effect_types.abi_mistwalkers,
                         ancient_legacy_hammurabi_config.effect_types.abi_inspired_by_the_best,
                         ancient_legacy_hammurabi_config.effect_types.abi_underdog,
                    },

                    ui = {
                         order = 4,
                         icon_path = "UI/skins/default/map_legacy_hammurabi/phar_map_mes_abilities_tab_icon.png",
                         cuneiform_icon_path =
                         "UI/skins/default/map_legacy_hammurabi/phar_map_mes_abilities_cuneiform.png",
                         title = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_abilities_title",
                         flavour = "ui_text_replacements_localised_text_phar_map_al_hammurabi_subcategory_abilities_desc",
                    },
               },
          },

          levels = {
               {
                    justice_cost = 1,
                    level = 2
               },
               {
                    justice_cost = 1,
                    level = 3
               },
               {
                    justice_cost = 1,
                    level = 4
               },
               {
                    justice_cost = 2,
                    level = 5
               },
               {
                    justice_cost = 2,
                    level = 6
               },
               {
                    justice_cost = 2,
                    level = 7
               },
               {
                    justice_cost = 3,
                    level = 8
               },
               {
                    justice_cost = 3,
                    level = 9
               },
               {
                    justice_cost = 3,
                    level = 10
               },
               {
                    justice_cost = 4,
                    level = 11
               },
               {
                    justice_cost = 4,
                    level = 12
               },
               {
                    justice_cost = 4,
                    level = 13
               },
               {
                    justice_cost = 5,
                    level = 14
               },
               {
                    justice_cost = 5,
                    level = 15
               },
               {
                    justice_cost = 5,
                    level = 16
               },
               {
                    justice_cost = 6,
                    level = 17
               },
               {
                    justice_cost = 6,
                    level = 18
               },
               {
                    justice_cost = 6,
                    level = 19
               },
               {
                    justice_cost = 7,
                    level = 20
               },
          },

          ui = {
               title = "ui_text_replacements_localised_text_phar_map_hammurabi_category_military_title",
               illustration_state_name = "military",
               icon_state_name = "military",
          },
     },
}
