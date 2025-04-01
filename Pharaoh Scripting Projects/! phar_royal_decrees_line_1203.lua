out("Loading phar_royal_decrees.lua")

decree_constants = {
	max_population_surplus = 8,
	comb_civil_tech_setup = {
		scripted_bonus_happiness = "scripted_tech_happiness_from_tech",
		scripted_bonus_influence = "scripted_tech_influence_from_tech",
		bundle_key = "phar_map_effect_bundle_technology_effect_influence_happiness",
		happiness_effect_key = "phar_main_effect_happiness_in_capital_technology",
		influence_effect_key = "phar_main_effect_influence_factor_technology",
		scope = "character_to_province_any",
	},
	comb_influence_tech_setup = {
		bundle_key = "phar_map_effect_bundle_technology_effect_influence_waystation",
		scripted_bonus_influence = "scripted_tech_non_religion_influence_from_tech",
		influence_effect_key = "phar_map_non_state_religion_conversion_bonus_building",
		scope = "province_to_province_own",
		building_chain_key = "ers_waystation"
	},

	-- technologies that need to update when tech is researched or allianace is created/broken
	-- they need to call phar_royal_decrees_methods.check_alliance_and_apply_bonus with the faction, and the config form this table
	-- the table maps the technology with the culture it applies to and the bundle given
	alliance_dependent_culture_technologies =
	{
		phar_main_tech_economic_9_bronze_alliance_hittites =
		{
			culture = "phar_main_clt_hatti",
			bundle_key = "phar_main_effect_bundle_technology_effect_mult_bronze_if_in_hatti_alliance",
		},
		phar_main_tech_economic_11_wood_alliance_canaanites =
		{
			culture = "phar_main_clt_canaan",
			bundle_key = "phar_main_effect_bundle_technology_effect_mult_wood_if_in_canaan_alliance",
		},
		phar_main_tech_economic_14_food_alliance_egyptians =
		{
			culture = "phar_main_clt_kemet",
			bundle_key = "phar_main_effect_bundle_technology_effect_mult_food_if_in_kemet_alliance",
		},
		phar_map_tech_economic_3_diplomacy_meso_alliance_food =
		{
			culture = "phar_map_clt_mesopotamian",
			bundle_key = "phar_map_effect_bundle_technology_effect_replenishment_food",
		},
		phar_map_tech_economic_5_diplomacy_aegea_alliance_stone =
		{
			culture = "troy_main_clt_danaans",
			bundle_key = "phar_main_effect_bundle_technology_effect_mult_stone_if_in_aegean_alliance",
		},
	},

	alliance_dependent_technologies =
	{
		"phar_main_tech_civil_4_growth_per_alliance",
		"phar_map_tech_military_22_tier_1_2_3_recruitment_cost_if_in_alliance_aegeans",
	},
}

phar_royal_decrees_methods = {
	add_listeners = function()
		--listener for any technology researched
		core:add_listener(
			"phar_royal_decrees_researched_listener",
			"ResearchCompleted",
			true,
			function(context)
				local faction = context:faction()
				local technology = context:technology()

				-- if the technology is culture dependent the alliance_dependent_culture_technologies will map it to the related culture and bundle
				local technology_config = decree_constants.alliance_dependent_culture_technologies[technology]
				if technology_config then
					phar_royal_decrees_methods.check_alliance_and_apply_bonus(faction, technology_config)

				elseif 	technology == "phar_main_tech_civil_1_happiness_capital" then
					phar_royal_decrees_methods.apply_happiness_bonus_to_capital(faction)

				elseif technology == "phar_main_tech_civil_22_gold_per_lvl_5_building" then
					phar_royal_decrees_methods.check_regions_and_apply_bonus_gold(faction)

				elseif technology == "phar_main_tech_civil_21_surplus_points_production" then
					phar_royal_decrees_methods.check_workforce_and_apply_bonus(faction)

				elseif technology == "phar_main_tech_civil_12_monument_influence" then
					phar_royal_decrees_methods.check_monuments_and_apply_bonus(faction, "influence")

				elseif technology == "phar_main_tech_civil_18_temple_happiness" then
					phar_royal_decrees_methods.check_temples_and_apply_bonus_happiness(faction)

				elseif technology == "phar_main_tech_civil_4_growth_per_alliance" then
					phar_royal_decrees_methods.check_alliances_and_apply_bonus_growth(faction, 0)

				elseif technology == "phar_main_tech_civil_17_pillars_points" then
					phar_royal_decrees_methods.check_pillars_and_apply_bonus_growth(faction)

				elseif technology == "phar_sea_economic_1_port_income" then
					phar_royal_decrees_methods.modify_port_region_income_by_percentage(faction)

				elseif technology == "phar_sea_military_21_max_horde_surplus_buff" then
					phar_royal_decrees_methods.modify_horde_forces_replenishment(faction)

				elseif technology == "phar_sea_military_15_raiding_penalty_buff" then
					phar_royal_decrees_methods.modify_horde_forces_raid_stance_happiness(faction)

				elseif technology == "phar_sea_civil_7_enables_settlement_occupation" then
					phar_royal_decrees_methods.remove_occupation_decision_restrictions(faction)

				elseif technology == "phar_map_tech_economic_4_ports_food_income" then
					phar_royal_decrees_methods.modify_port_region_income_by_percentage(faction)
				elseif technology == "phar_map_tech_military_19_level_10_general_aura" then
					phar_royal_decrees_methods.check_all_faction_character_levels_and_apply_bonus_effects(faction)
				elseif technology == "phar_map_tech_military_20_level_10_general_melee_defence_morale" then
					phar_royal_decrees_methods.check_all_faction_character_levels_and_apply_bonus_effects(faction)
				elseif technology == "phar_map_tech_military_23_level_10_general_recruitment_cost_tier_4_5" then
					phar_royal_decrees_methods.check_all_faction_character_levels_and_apply_bonus_effects(faction)
				elseif technology == "phar_map_tech_military_22_tier_1_2_3_recruitment_cost_if_in_alliance_aegeans" then
					-- parameters are faction, check_alliances, check_technology
					-- we don't need to check the technology because the event showed we just unlocked it
					phar_royal_decrees_methods.check_alliances_and_apply_bonus_recruitment(faction, true, false)
				elseif technology == "phar_map_tech_civil_1_influence_happiness" then
					phar_royal_decrees_methods.apply_civil_tech_bundle_to_faction_leader(faction)

				elseif technology == "phar_map_tech_civil_6_ers_influence" then
					phar_royal_decrees_methods.check_faction_regions_and_apply_bonus_influence(faction)
				end
			end,
			true
		)
		--listener for phar_map_tech_military_21_replenishment_after_raze_sack_outpost
		core:add_listener(
			"phar_royal_decrees_replenishment_after_raze_sack_outpost",
			"CharacterPerformsRegionSlotOccupationDecision",
			function(context)
				local faction = context:character():faction()
				return faction:has_technology("phar_map_tech_military_21_replenishment_after_raze_sack_outpost")
				 	and (context:occupation_decision_option() == "occupation_decision_ers_raze_without_occupy" or
					context:occupation_decision_option() == "occupation_decision_ers_sack")
			end,
			function(context)
				local character = context:character()
				local bonus_value = cm:get_factions_bonus_value(character:faction():name(), "scripted_bonus_replenishment_ers_destruction")
				local value = bonus_value/100	-- This is to conform to char_lookup_str(), which uses values between 0 and 1
				cm:replenish_units(cm:char_lookup_str(character), value)
			end,
			true
		)

		--listener for phar_map_tech_military_19_level_10_general_aura
		--listener for phar_map_tech_military_20_level_10_general_melee_defence_morale
		--listener for phar_map_tech_military_23_level_10_general_recruitment_cost_tier_4_5
		core:add_listener(
			"phar_royal_decrees_bonus_rank_up",
			"CharacterRankUp",
			function(context)
				local character = context:character()
				if character:character_type_key() ~= "general"
						or character:rank() < 10 then
					return false
				end
				local faction = character:faction()
				if faction:has_technology("phar_map_tech_military_19_level_10_general_aura")
						or faction:has_technology("phar_map_tech_military_20_level_10_general_melee_defence_morale")
						or faction:has_technology("phar_map_tech_military_23_level_10_general_recruitment_cost_tier_4_5") then
					return true
				end

				return false
			end,
			function(context)
				phar_royal_decrees_methods.check_character_level_decrees_and_apply_bonus_effect(context:character())
			end,
			true
		)

		--listener for phar_main_tech_civil_22_gold_per_lvl_5_building
		core:add_listener(
			"phar_royal_decrees_bonus_gold_building_constructed_listener",
			"BuildingCompleted",
			function(context)
				local building = context:building()
				return building:ui_level() >= 5 and building:faction():has_technology("phar_main_tech_civil_22_gold_per_lvl_5_building")
			end,
			function(context)
				local faction = context:building():faction()
				phar_royal_decrees_methods.update_bonus_gold(faction, 1)
			end,
			true
		)

		--listener for phar_main_tech_civil_22_gold_per_lvl_5_building
		core:add_listener(
			"phar_royal_decrees_bonus_gold_building_constructed_listener",
			"BuildingDemolished",
			function(context)
				local building = context:building()
				return building:faction():has_technology("phar_main_tech_civil_22_gold_per_lvl_5_building")
			end,
			function(context)
				local faction = context:building():faction()
				phar_royal_decrees_methods.update_bonus_gold(faction, -1)
			end,
			true
		)

		--listener for phar_main_tech_civil_21_surplus_points_production
		core:add_listener(
			"phar_royal_decrees_build_constr_started_remove_production_bonus_if_surplus_not_enough_listener",
			"BuildingConstructionStarted",
			function(context)
				local region = context:garrison_residence():region()
				local dev_points = region:faction_province_development_points()
				return dev_points < decree_constants.max_population_surplus and region:owning_faction():has_technology("phar_main_tech_civil_21_surplus_points_production")
			end,
			function(context)
				local faction = context:garrison_residence():faction()
				phar_royal_decrees_methods.check_workforce_and_apply_bonus(faction)
			end,
			true
		)
		--listener for phar_main_tech_civil_21_surplus_points_production
		core:add_listener(
			"phar_royal_decrees_constr_cancelled_started_add_production_bonus_if_surplus_enough_listener",
			"BuildingConstructionCanceled",
			function(context)
				local region = context:garrison_residence():region()
				local dev_points = region:faction_province_development_points()
				return dev_points >= 3 and region:owning_faction():has_technology("phar_main_tech_civil_21_surplus_points_production")
			end,
			function(context)
				local faction = context:garrison_residence():faction()
				--Adding callback since dev_points aren't properly updated before the event ends
				local wait_a_bit = 0.1
				phar_royal_decrees_methods.check_workforce_and_apply_bonus(faction, wait_a_bit)
			end,
			true
		)

		--listener for phar_main_tech_civil_21_surplus_points_production
		core:add_listener(
			"phar_royal_decrees_turn_start_add_production_bonus_if_surplus_enough_listener",
			"FactionTurnStart",
			function(context)
				local faction = context:faction()
				return faction:has_technology("phar_main_tech_civil_21_surplus_points_production")
			end,
			function(context)
				local faction = context:faction()
				phar_royal_decrees_methods.check_workforce_and_apply_bonus(faction)
			end,
			true
		)

		-- listener for applying the effects of "phar_sea_military_11_kill_post_battle_buff" tech on Sea horde armies performing the "Kill"/`CAMPAIGN_POST_BATTLE_CAPTIVE_OPTION::KILL_CAPTIVES` post battle option
		core:add_listener(
			"phar_royal_decrees_CharacterPostBattleSlaughter_phar_sea_military_11_kill_post_battle_buff",
			"CharacterPostBattleSlaughter",
			true,
			function(context)
				local character = context:character()
				local faction = character:faction()
				if not faction:has_technology("phar_sea_military_11_kill_post_battle_buff") then
					return
				end

				local force = character:military_force()
				if not force or force:is_null_interface() or not tribes_privileges.is_horde_type(force) then
					return
				end

				local bundle_key = "phar_sea_effect_bundle_royal_decrees_kill_post_battle_horde_force_movement_action_points"
				local bundle_duration_turns = 3

				local existing_effect_bundle = character:get_effect_bundle(bundle_key)
				if existing_effect_bundle and not existing_effect_bundle:is_null_interface() then
					cm:remove_effect_bundle_from_character(bundle_key, character:command_queue_index())
				end

				cm:apply_effect_bundle_to_character(bundle_key, character:command_queue_index(), bundle_duration_turns)
			end,
			true,
			true
		)

		--listener for phar_sea_economic_1_port_income
		core:add_listener(
			"phar_royal_decrees_turn_start_phar_sea_economic_1_port_income",
			"RegionFactionChangeEvent",
			true,
			function(context)
				phar_royal_decrees_methods.modify_port_region_income_by_percentage(context:region():owning_faction())
			end,
			true,
			true
		)

		--listener for phar_sea_military_21_max_horde_surplus_buff
		core:add_listener(
			"phar_royal_decrees_turn_start_phar_sea_military_21_max_horde_surplus_buff",
			"FactionTurnStart",
			true,
			function(context)
				phar_royal_decrees_methods.modify_horde_forces_replenishment(context:faction())
			end,
			true
		)

		-- listener for phar_sea_military_15_raiding_penalty_buff
		core:add_listener(
			"phar_royal_decrees_ForceAdoptsStance_phar_sea_military_15_raiding_penalty_buff",
			"ForceAdoptsStance",
			true,
			function(context)
				local force = context:military_force()
				local faction = force:faction()
				if not faction:has_technology("phar_sea_military_15_raiding_penalty_buff") or not tribes_privileges.is_horde_type(force) then
					return
				end

				local bundle_key = "phar_sea_effect_bundle_royal_decrees_horde_force_military_presence_raiding"
				local stance_id = context:stance_adopted()

				-- modify horde force raiding stance's (stance_id=3) happiness penalty
				if stance_id == 3 and not force:has_effect_bundle(bundle_key) then
					cm:apply_effect_bundle_to_force(bundle_key, force:command_queue_index(), 0)
				elseif stance_id ~= 3 and force:has_effect_bundle(bundle_key) then
					cm:remove_effect_bundle_from_force(bundle_key, force:command_queue_index())
				end
			end,
			true,
			true
		)

		--listener for phar_main_tech_military_12_ers_destruction
		core:add_listener(
			"phar_royal_decrees_ers_destroyed_listener",
			"CharacterPerformsRegionSlotOccupationDecision",
			function(context)
				local your_faction = context:character():faction()

				return ( context:occupation_decision_option() == "occupation_decision_ers_raze_without_occupy" or
				 	context:occupation_decision_option() == "occupation_decision_ers_sack" )
				 	 and
				 	your_faction:has_technology("phar_main_tech_military_12_ers_destruction")

			end,
			function(context)
				--local character = context:character()
				local your_faction = context:character():faction()
				phar_royal_decrees_methods.apply_influence_buff(your_faction)
			end,
			true
		)

		--listener for phar_main_tech_civil_4_growth_per_alliance
		--listener for phar_main_tech_economic_9_bronze_alliance_hittites
		--listener for phar_main_tech_economic_14_food_alliance_egyptians
		--listener for phar_main_tech_economic_11_wood_alliance_canaanites
		--listener for phar_map_tech_military_22_tier_1_2_3_recruitment_cost_if_in_alliance_aegeans
		core:add_listener(
			"phar_royal_decrees_alliance",
			"PositiveDiplomaticEvent",
			function(context)
				if not context:is_alliance() then
					return
				end

				local proposer = context:proposer()
				local recipient = context:recipient()

				for technology, _config in dpairs(decree_constants.alliance_dependent_culture_technologies) do
					if proposer:has_technology(technology) or recipient:has_technology(technology) then
						return true
					end
				end

				for _, tech in ipairs(decree_constants.alliance_dependent_technologies) do
					if proposer:has_technology(tech) or recipient:has_technology(tech) then
						return true
					end
				end
				return false
			end,
			function(context)

				local proposer = context:proposer()
				local recipient = context:recipient()

				if proposer:has_technology("phar_main_tech_civil_4_growth_per_alliance")
						and not (context:is_military_alliance() and proposer:defensive_allies_with(recipient)) then
					phar_royal_decrees_methods.check_alliances_and_apply_bonus_growth(proposer, 1)
				end
				if recipient:has_technology("phar_main_tech_civil_4_growth_per_alliance")
						and not(context:is_military_alliance() and recipient:defensive_allies_with(proposer)) then
					phar_royal_decrees_methods.check_alliances_and_apply_bonus_growth(recipient, 1)
				end
				if not (context:is_military_alliance() and proposer:defensive_allies_with(recipient))
						and (recipient:culture() == "troy_main_clt_danaans" or recipient:culture() == "troy_main_clt_trojans") then
					-- parameters are faction, check_alliances, check_technology
					-- we don't need to check the alliance because we just checked for it
					phar_royal_decrees_methods.check_alliances_and_apply_bonus_recruitment(proposer, false, true)
				end
				if not(context:is_military_alliance() and recipient:defensive_allies_with(proposer))
						and (proposer:culture() == "troy_main_clt_danaans" or proposer:culture() == "troy_main_clt_trojans") then
					-- parameters are faction, check_alliances, check_technology
					-- we don't need to check the alliance because we just checked for it
					phar_royal_decrees_methods.check_alliances_and_apply_bonus_recruitment(recipient, false, true)
				end

				phar_royal_decrees_methods.call_check_for_alliance(proposer, recipient, true)
			end,
			true
		)

		--listener for phar_main_tech_civil_4_growth_per_alliance
		--listener for phar_main_tech_economic_9_bronze_alliance_hittites
		--listener for phar_main_tech_economic_14_food_alliance_egyptians
		--listener for phar_main_tech_economic_11_wood_alliance_canaanites
		core:add_listener(
			"phar_royal_decrees_alliance_broken",
			"NegativeDiplomaticEvent",
			function(context)
				if not context:was_alliance() then
					return
				end

				local proposer = context:proposer()
				local recipient = context:recipient()

				for technology, _config in dpairs(decree_constants.alliance_dependent_culture_technologies) do
					if proposer:has_technology(technology) or recipient:has_technology(technology) then
						return true
					end
				end

				for _, tech in ipairs(decree_constants.alliance_dependent_technologies) do
					if proposer:has_technology(tech) or recipient:has_technology(tech) then
						return true
					end
				end
			end,
			function(context)

				local proposer = context:proposer()
				local recipient = context:recipient()

				if proposer:has_technology("phar_main_tech_civil_4_growth_per_alliance") then
					phar_royal_decrees_methods.check_alliances_and_apply_bonus_growth(proposer, 0)
				end
				if recipient:has_technology("phar_main_tech_civil_4_growth_per_alliance") then
					phar_royal_decrees_methods.check_alliances_and_apply_bonus_growth(recipient, 0)
				end

				if proposer:has_technology("phar_map_tech_military_22_tier_1_2_3_recruitment_cost_if_in_alliance_aegeans")
						and (recipient:culture() == "troy_main_clt_danaans" or recipient:culture() == "troy_main_clt_trojans") then
					phar_royal_decrees_methods.check_alliances_and_apply_bonus_recruitment(proposer, true, false)
				end
				if recipient:has_technology("phar_map_tech_military_22_tier_1_2_3_recruitment_cost_if_in_alliance_aegeans")
						and (proposer:culture() == "troy_main_clt_danaans" or proposer:culture() == "troy_main_clt_trojans") then
					phar_royal_decrees_methods.check_alliances_and_apply_bonus_recruitment(recipient, true, false)
				end

				phar_royal_decrees_methods.call_check_for_alliance(proposer, recipient, false)
			end,
			true
		)

		--listener for phar_main_tech_civil_12_monument_influence
		--listener for phar_main_tech_civil_16_surplus_when_ers_constructed
		--listener for phar_main_tech_civil_17_construction_time_when_ers_constructed
		core:add_listener(
			"phar_royal_decrees_monument_constructed",
			"BuildingCompleted",
			function(context)
				return context:building():slot():is_infrastructure_slot()
			end,
			function(context)
				local building = context:building()
				local faction = building:faction()
				local region = building:region()
				local region_name = region:name()

				if faction:has_technology("phar_main_tech_civil_16_surplus_when_ers_constructed") then
					cm:add_development_points_to_region(region_name, 1)

					local dev_points = region:faction_province_development_points()
					if dev_points >= decree_constants.max_population_surplus and faction:has_technology("phar_main_tech_civil_21_surplus_points_production") then
						phar_royal_decrees_methods.check_workforce_and_apply_bonus(faction)
					end
				end
				if faction:has_technology("phar_main_tech_civil_17_construction_time_when_ers_constructed") then
					phar_royal_decrees_methods.add_effect_bundle_construction_time_all_buildings_in_region(region_name, 5)
				end

				local ers_building_chains_prefix = "phar_main_ers_monument"
				local ers_unique_building_chains_prefix = "phar_main_ers_unique"
				if string.find(building:name(), ers_building_chains_prefix) or string.find(building:name(), ers_unique_building_chains_prefix) then
					if faction:has_technology("phar_main_tech_civil_12_monument_influence") then
						phar_royal_decrees_methods.check_monuments_and_apply_bonus(faction, "influence")
					end
				end
			end,
			true
		)


		--listener for phar_main_tech_civil_12_monument_influence
		core:add_listener(
				"phar_royal_decrees_monument_demolished",
				"BuildingDemolished",
				function(context)
					local building = context:building()
					local ers_building_chains_prefix = "phar_main_ers_monument"
					if string.find(building:name(), ers_building_chains_prefix) then
						return true
					end
				end,
				function(context)
					local faction = context:building():faction()
						if faction:has_technology("phar_main_tech_civil_12_monument_influence") then
							phar_royal_decrees_methods.check_monuments_and_apply_bonus(faction, "influence", true)
						end
				end,
				true
		)

		--listener for phar_main_tech_civil_18_temple_happiness
		core:add_listener(
			"phar_royal_decrees_temple_happiness",
			"BuildingCompleted",
			function(context)
				if context:is_conversion() then
					return false
				end
				local building = context:building()
				local temple_prefix = "temple"
				if string.find(building:name(), temple_prefix) then
					return true
				end
			end,
			function(context)
				local building = context:building()
				local faction = building:faction()
				if faction:has_technology("phar_main_tech_civil_18_temple_happiness") then
					phar_royal_decrees_methods.check_temples_and_apply_bonus_happiness(faction)
				end
				local region_name = building:region():name()
				if faction:has_technology("phar_main_tech_civil_10_temple_workforce") then
					cm:add_development_points_to_region(region_name, 3)
				end
			end,
			true
		)


		--listener for phar_main_tech_civil_18_temple_happiness
		core:add_listener(
			"phar_royal_decrees_temple_happiness_demolished",
			"BuildingDemolished",
			function(context)
				local building = context:building()
				local temple_prefix = "temple"
				if string.find(building:name(), temple_prefix) then
					return true
				end
			end,
			function(context)
				local faction = context:building():faction()
				if faction:has_technology("phar_main_tech_civil_18_temple_happiness") then
					phar_royal_decrees_methods.check_temples_and_apply_bonus_happiness(faction, true)
				end
			end,
			true
		)


		--listeners for phar_main_tech_civil_1_happiness_capital

		core:add_listener(
			"phar_royal_decrees_capital_happiness",
			"RegionFactionChangeEvent",
			function(context)
				local previous_faction = context:previous_faction()
				if context:was_capital() and previous_faction:has_technology("phar_main_tech_civil_1_happiness_capital") then
					return true
				end
			end,
			function(context)
				local previous_faction = context:previous_faction()
				phar_royal_decrees_methods.apply_happiness_bonus_to_capital(previous_faction)
			end,
			true
		)

		core:add_listener(
			"phar_royal_decrees_capital_happiness_home_region_change",
		 	"FactionChangesHomeRegion",
			 function(context)
				return context:faction():has_technology("phar_main_tech_civil_1_happiness_capital")
			 end,
			 function(context)
				local faction = context:faction()
				if not faction or faction:is_null_interface() then
					return
				end

				local previous_region = context:previous_home_region()
				if previous_region and not previous_region:is_null_interface() and not previous_region:is_abandoned() then
					local effect_bundle_key = "phar_main_effect_bundle_technology_happiness_in_capital"
					cm:remove_effect_bundle_from_province(effect_bundle_key, previous_region:name())
				end

				phar_royal_decrees_methods.apply_happiness_bonus_to_capital(faction)
			 end,
			 true
		)
		--listener for phar_main_tech_civil_17_construction_time_when_region_occupied
		core:add_listener(
			"phar_royal_decrees_region_occupied_constr",
			"RegionFactionChangeEvent",
			function(context)
				local faction = context:region():owning_faction()
				if faction:has_technology("phar_main_tech_civil_17_construction_time_when_region_occupied") then
					return true
				end
			end,
			function(context)
				local region_name = context:region():name()
				phar_royal_decrees_methods.add_effect_bundle_construction_time_all_buildings_in_region(region_name, 5)
			end,
			true
		)

		--listener for phar_main_tech_civil_16_surplus_when_region_occupied
		core:add_listener(
			"phar_royal_decrees_region_occupied_bonus_surplus",
			"RegionFactionChangeEvent",
			function(context)
				local new_faction = context:region():owning_faction()
				local previous_faction = context:previous_faction()
				return new_faction:has_technology("phar_main_tech_civil_16_surplus_when_region_occupied")
			end,
			function(context)
				cm:add_development_points_to_region(context:region():name(), 1)
			end,
			true
		)

		--listener for phar_main_tech_civil_21_surplus_points_production
		core:add_listener(
			"phar_royal_decrees_region_change_surplus_production",
			"RegionFactionChangeEvent",
			function(context)
				local new_faction = context:region():owning_faction()
				local previous_faction = context:previous_faction()
				if 	new_faction:has_technology("phar_main_tech_civil_21_surplus_points_production")
						or previous_faction:has_technology("phar_main_tech_civil_21_surplus_points_production") then
					return true
				end
			end,
			function(context)
				local region = context:region()
				local new_faction = region:owning_faction()
				local dev_points = region:faction_province_development_points()

				if (dev_points >= decree_constants.max_population_surplus
						and new_faction:has_technology("phar_main_tech_civil_21_surplus_points_production")) then
					phar_royal_decrees_methods.check_workforce_and_apply_bonus(new_faction)
				end
			end,
			true
		)

		--listener for phar_main_tech_civil_22_gold_per_lvl_5_building
		core:add_listener(
			"phar_royal_decrees_region_change_gold_per_lvl_5",
			"RegionFactionChangeEvent",
			function(context)
				local new_faction = context:region():owning_faction()
				local previous_faction = context:previous_faction()
				if new_faction:has_technology("phar_main_tech_civil_22_gold_per_lvl_5_building")
					or previous_faction:has_technology("phar_main_tech_civil_22_gold_per_lvl_5_building") then
					return true
				end
			end,
			function(context)
				local new_faction = context:region():owning_faction()
				local previous_faction = context:previous_faction()
				if new_faction:has_technology("phar_main_tech_civil_22_gold_per_lvl_5_building") then
					phar_royal_decrees_methods.check_regions_and_apply_bonus_gold(new_faction)
				end
				if previous_faction:has_technology("phar_main_tech_civil_22_gold_per_lvl_5_building") then
					phar_royal_decrees_methods.check_regions_and_apply_bonus_gold(previous_faction)
				end
			end,
			true
		)

		--listener for phar_main_tech_civil_17_pillars_points
		core:add_listener(
			"phar_royal_decrees_pillars_add_bonus_growth",
			"RegionFactionChangeEvent",
			function(context)
				local region = context:region()
				if not table_contains(pillars_civilization.config.regions, region:name()) then
					return false
				end
				return true
			end,
			function(context)
				local new_faction = context:region():owning_faction()
				local previous_faction = context:previous_faction()
				if new_faction:has_technology("phar_main_tech_civil_17_pillars_points") then
					phar_royal_decrees_methods.check_pillars_and_apply_bonus_growth(new_faction)
				end
				if previous_faction:has_technology("phar_main_tech_civil_17_pillars_points") then
					phar_royal_decrees_methods.check_pillars_and_apply_bonus_growth(previous_faction)
				end
			end,
			true
		)

		core:add_listener(
			"royal_decrees_ui_FactionTurnStart",
			"FactionTurnStart",
			function(context)
				local faction = context:faction()
				local faction_key = faction:name()
				local local_faction_key = cm:get_local_faction_name(true)
				return faction:is_human() and faction_key == local_faction_key
			end,
			function(context)
				local faction_key = context:faction():name()
				phar_royal_decrees_methods.check_royal_decrees_availability(faction_key)
			end,
			true
		)

		core:add_listener(
			"royal_decrees_CharacterCreated",
			"CharacterCreated",
			function(context)
				local char = context:character()
				local faction = char:faction()
				local fl = faction:faction_leader()
				return char == fl and faction:has_technology("phar_map_tech_civil_1_influence_happiness")
			end,
			function(context)
				local faction = context:character():faction()
				phar_royal_decrees_methods.apply_civil_tech_bundle_to_faction_leader(faction)
			end,
			true
		)

		core:add_listener(
			"royal_decrees_CharacterBecomesFactionLeader",
			"CharacterBecomesFactionLeader",
			function(context)
				local char = context:character()
				local faction = char:faction()
				local fl = faction:faction_leader()
				return char == fl and faction:has_technology("phar_map_tech_civil_1_influence_happiness")
			end,
			function(context)
				local faction = context:character():faction()
				phar_royal_decrees_methods.apply_civil_tech_bundle_to_faction_leader(faction)
			end,
			true
		)

		core:add_listener(
			"royal_decrees_CharacterEntersMilitaryForce",
			"CharacterEntersMilitaryForce",
			function(context)
				local char = context:character()
				local faction = char:faction()
				local fl = faction:faction_leader()
				return char == fl and faction:has_technology("phar_map_tech_civil_1_influence_happiness")
			end,
			function(context)
				local faction = context:character():faction()
				phar_royal_decrees_methods.apply_civil_tech_bundle_to_faction_leader(faction)
			end,
			true
		)

		--listener for phar_map_tech_civil_6_ers_influence
		core:add_listener(
			"phar_royal_decrees_BuildingCompleted_tech_civil_6",
			"BuildingCompleted",
			function(context)
				return string.find(context:building():chain(), decree_constants.comb_influence_tech_setup.building_chain_key)
			end,
			function(context)
				local building = context:building()
				local faction = building:faction()
				if faction:has_technology("phar_map_tech_civil_6_ers_influence") then
					local province = building:region():province()
					phar_royal_decrees_methods.check_province_for_faction_and_apply_bonus_influence(faction, province)
				end
			end,
			true
		)

		core:add_listener(
			"phar_royal_decrees_BuildingDemolished_tech_civil_6",
			"BuildingDemolished",
			function(context)
				return string.find(context:building():chain(), decree_constants.comb_influence_tech_setup.building_chain_key)
			end,
			function(context)
				local building = context:building()
				local province = building:region():province()
				local faction = building:faction()
				if faction:has_technology("phar_map_tech_civil_6_ers_influence") then
					phar_royal_decrees_methods.check_province_for_faction_and_apply_bonus_influence(faction, province, true)
				end
			end,
			true
		)

		core:add_listener(
			"phar_royal_decrees_RegionFactionChangeEvent_tech_civil_6",
			"RegionFactionChangeEvent",
			function(context)
				local region = context:region()
				local curr_faction = region:owning_faction()
				local previous_faction = context:previous_faction()
				return curr_faction:has_technology("phar_map_tech_civil_6_ers_influence") or previous_faction:has_technology("phar_map_tech_civil_6_ers_influence")
			end,
			function(context)
				local region = context:region()
				local province = region:province()
				local new_faction = region:owning_faction()
				local previous_faction = context:previous_faction()
				if new_faction:has_technology("phar_map_tech_civil_6_ers_influence") then
					phar_royal_decrees_methods.check_province_for_faction_and_apply_bonus_influence(new_faction, province)
				end
				if previous_faction:has_technology("phar_map_tech_civil_6_ers_influence") then
					phar_royal_decrees_methods.check_province_for_faction_and_apply_bonus_influence(previous_faction, province)
				end
			end,
			true
		)


	end,

	--- @function has_alliance_with
	--- @desc returns if the faction has a military or defensive alliance with a faction
	--- @p faction_script_interface faction: the faction we're checking
	--- @p [opt=nil] string required_culture - an optional condition to only count alliances with a specific culture
	has_alliance_with = function(faction, required_culture)
		local factions_defensive_alliance_with = faction:factions_defensive_alliance_with()
		for i = 0, factions_defensive_alliance_with:num_items() - 1 do
			local faction_i = factions_defensive_alliance_with:item_at(i)
			if (not is_string(required_culture)) or
				faction_i:culture() == required_culture
			then
				return true
			end
		end
		local factions_military_alliance_with = faction:factions_military_alliance_with()
		for i = 0, factions_military_alliance_with:num_items() - 1 do
			local faction_i = factions_military_alliance_with:item_at(i)
			if (not is_string(required_culture)) or
				faction_i:culture() == required_culture
			then
				return true
			end
		end

		return false
	end,

	--method for phar_map_tech_military_22_tier_1_2_3_recruitment_cost_if_in_alliance_aegeans
	apply_recruitment_effect_to_all_characters_for_faction = function(faction)
		local effect_bundle_key = "phar_map_recruitment_cost_tier_1_2_3"
		local cust_effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)
		cust_effect_bundle:set_duration(0)
		local bonus_value_name = "scripted_bonus_tier_1_2_3_recruitment_cost_if_in_aegean_alliance"
		local effect = "phar_map_recruitment_cost_low_tier_if_alliance_aegeans"
		phar_royal_decrees_methods.add_effect_with_bonus_value_from_faction_to_custom_bundle(
			effect,
			bonus_value_name,
			faction:name(),
			cust_effect_bundle,
			"faction_to_force_own_factionwide"
		)
		cm:apply_custom_effect_bundle_to_faction(cust_effect_bundle, faction)
	end,

	--method for phar_map_tech_military_22_tier_1_2_3_recruitment_cost_if_in_alliance_aegeans
	check_alliances_and_apply_bonus_recruitment = function(faction, check_alliances, check_technology)
		if not faction or faction:is_null_interface() or type(faction) == "string" then
			script_error("ERROR: Faction is not of type faction_script_interface! check_alliances_and_apply_bonus_recruitment(...)");
			return
		end

		local faction_name = faction:name()

		local has_alliances
		if check_alliances then
			has_alliances = phar_royal_decrees_methods.has_alliance_with(faction, "troy_main_clt_danaans")
							or phar_royal_decrees_methods.has_alliance_with(faction, "troy_main_clt_trojans")
		else
			has_alliances = true
		end

		local has_technology
		if check_technology then
			has_technology = faction:has_technology("phar_map_tech_military_22_tier_1_2_3_recruitment_cost_if_in_alliance_aegeans")
		else
			has_technology = true
		end

		local should_apply = has_alliances and has_technology
		local effect_bundle_key = "phar_map_recruitment_cost_tier_1_2_3"
		local has_effect_bundle = faction:has_effect_bundle(effect_bundle_key)

		if should_apply then
			phar_royal_decrees_methods.apply_recruitment_effect_to_all_characters_for_faction(faction)
		elseif has_effect_bundle then
			cm:remove_effect_bundle(effect_bundle_key, faction:name())
		end
	end,

	--method for phar_map_tech_military_19_level_10_general_aura
	--method for phar_map_tech_military_20_level_10_general_melee_defence_morale
	--method for phar_map_tech_military_23_level_10_general_recruitment_cost_tier_4_5
	check_all_faction_character_levels_and_apply_bonus_effects = function(faction)
		local character_list = faction:character_list()
		for i=0, character_list:num_items() - 1 do
			local character = character_list:item_at(i)
			if character:rank() >= 10 then
				phar_royal_decrees_methods.check_character_level_decrees_and_apply_bonus_effect(character)
			end
		end
	end,

	--method for phar_map_tech_military_19_level_10_general_aura
	--method for phar_map_tech_military_20_level_10_general_melee_defence_morale
	--method for phar_map_tech_military_23_level_10_general_recruitment_cost_tier_4_5
	check_character_level_decrees_and_apply_bonus_effect = function(character)
		local effect_bundle_key = "phar_map_effect_bundle_scripted_general_level_10_or_more"
		local cust_effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)
		cust_effect_bundle:set_duration(0)
		local faction = character:faction()
		local faction_key = faction:name()

		if faction:has_technology("phar_map_tech_military_19_level_10_general_aura") then
			local effect_aura_size = "phar_main_general_aoe_mod_unit_sets_bodyguards"
			local effect_aura_morale = "phar_main_general_aoe_morale_effect_mod_unit_sets_phar_main_bodyguards"
			local bonus_value_size = "scripted_bonus_general_level_10_or_more_aura_size"
			local bonus_value_morale = "scripted_bonus_general_level_10_or_more_aura_morale"

			phar_royal_decrees_methods.add_effect_with_bonus_value_from_faction_to_custom_bundle(
				effect_aura_size,
				bonus_value_size,
				faction_key,
				cust_effect_bundle
			)
			phar_royal_decrees_methods.add_effect_with_bonus_value_from_faction_to_custom_bundle(
				effect_aura_morale,
				bonus_value_morale,
				faction_key,
				cust_effect_bundle
			)
		end
		if faction:has_technology("phar_map_tech_military_20_level_10_general_melee_defence_morale") then
			local effect_defence = "phar_main_army_effects_melee_defence_mod_all"
			local effect_morale = "phar_main_morale_basic"
			local bonus_value_defence = "scripted_bonus_general_level_10_or_more_melee_defence"
			local bonus_value_morale = "scripted_bonus_general_level_10_or_more_morale"

			phar_royal_decrees_methods.add_effect_with_bonus_value_from_faction_to_custom_bundle(
				effect_defence,
				bonus_value_defence,
				faction_key,
				cust_effect_bundle
			)
			phar_royal_decrees_methods.add_effect_with_bonus_value_from_faction_to_custom_bundle(
				effect_morale,
				bonus_value_defence,
				faction_key,
				cust_effect_bundle
			)
		end
		if faction:has_technology("phar_map_tech_military_23_level_10_general_recruitment_cost_tier_4_5") then
			local effect_tier_4 = "phar_main_recruitment_cost_tier_4_units"
			local effect_tier_5 = "phar_main_recruitment_cost_tier_5_units"
			local effect_tier_6 = "phar_main_recruitment_cost_tier_6_units"
			local bonus_value = "scripted_bonus_general_level_10_or_more_tier_4_5_6_recruitment_cost"
			phar_royal_decrees_methods.add_effect_with_bonus_value_from_faction_to_custom_bundle(
				effect_tier_4,
				bonus_value,
				faction_key,
				cust_effect_bundle
			)
			phar_royal_decrees_methods.add_effect_with_bonus_value_from_faction_to_custom_bundle(
				effect_tier_5,
				bonus_value,
				faction_key,
				cust_effect_bundle
			)
			phar_royal_decrees_methods.add_effect_with_bonus_value_from_faction_to_custom_bundle(
				effect_tier_6,
				bonus_value,
				faction_key,
				cust_effect_bundle
			)
		end
		cm:apply_custom_effect_bundle_to_character(cust_effect_bundle, character)
	end,

	--method for phar_map_tech_military_19_level_10_general_aura
	--method for phar_map_tech_military_20_level_10_general_melee_defence_morale
	--method for phar_map_tech_military_23_level_10_general_recruitment_cost_tier_4_5
	--method for phar_map_tech_military_22_tier_1_2_3_recruitment_cost_if_in_alliance_aegeans
	add_effect_with_bonus_value_from_faction_to_custom_bundle = function(effect, bonus_value, faction_key, bundle, scope)
		if not scope then
			scope = "faction_to_character_own_this_hero"
		end
		local value = cm:get_factions_bonus_value(faction_key, bonus_value)
		bundle:add_effect(effect, scope, value)
		return bundle
	end,


	add_effect_bundle_construction_time_all_buildings_in_region = function(region_name, turns)
		local effect_bundle_key = "phar_main_construction_time_mod_all"

		cm:apply_effect_bundle_to_region(effect_bundle_key, region_name, turns)
	end,

	call_check_for_alliance = function(proposer, recipient, apply)
		for technology, technology_config in dpairs(decree_constants.alliance_dependent_culture_technologies) do
			if proposer:has_technology(technology)
				and proposer:culture() == technology_config.culture
				and recipient:culture() == technology_config.culture
			then
				phar_royal_decrees_methods.check_alliance_and_apply_bonus(proposer, technology_config, apply)
			end

			if recipient:has_technology(technology)
				and proposer:culture() == technology_config.culture
				and recipient:culture() == technology_config.culture
			then
				phar_royal_decrees_methods.check_alliance_and_apply_bonus(recipient, technology_config, apply)
			end
		end
	end,

	--method for phar_main_tech_civil_4_growth_per_alliance
	check_alliances_and_apply_bonus_growth = function(faction, compensate_alliances_count_discrepancy)
		if not faction or faction:is_null_interface() or type(faction) == "string" then
			script_error("ERROR: Faction is not of type faction_script_interface! check_alliances_and_apply_bonus_growth(...)");
			return
		end

		local alliances_amount = faction:num_allies() + compensate_alliances_count_discrepancy

		local effect_bundle_key = "phar_main_effect_bundle_technology_growth_per_alliance"

		if alliances_amount > 0 then
			local cust_effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)
			local effect = "phar_effect_technology_growth_per_alliance"
			local base_value = cm:get_factions_bonus_value(faction, "growth_from_alliances")
			cust_effect_bundle:add_effect(effect, "faction_to_province_own_factionwide", alliances_amount * base_value)
			cust_effect_bundle:set_duration(0)

			cm:apply_custom_effect_bundle_to_faction(cust_effect_bundle, faction)
		else
			cm:remove_effect_bundle(effect_bundle_key, faction:name())
		end

	end,

	--method for phar_main_tech_civil_17_pillars_points
	check_pillars_and_apply_bonus_growth = function(faction)
		if not faction or faction:is_null_interface() or type(faction) == "string" then
			script_error("ERROR: Faction is not of type faction_script_interface! check_pillars_and_apply_bonus_growth(...)");
			return
		end

		local pillars_amount = 0
		local pillar_regions = pillars_civilization.config.regions
		for i = 1, #pillar_regions do
			if cm:is_region_owned_by_faction(pillar_regions[i], faction:name()) then
				pillars_amount = pillars_amount + 1
			end
		end

		local effect_bundle_key = "phar_main_effect_bundle_technology_growth_per_pillar"
		if pillars_amount > 0 then
			local cust_effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)
			local effect = "phar_effect_technology_growth_per_pillar" --phar_effect_scripted_technology_growth_per_pillar
			local base_value = cm:get_factions_bonus_value(faction, "growth_from_pillars")
			cust_effect_bundle:add_effect(effect, "faction_to_province_own_factionwide", pillars_amount * base_value)
			cust_effect_bundle:set_duration(0)

			cm:apply_custom_effect_bundle_to_faction(cust_effect_bundle, faction)
		else
			cm:remove_effect_bundle(effect_bundle_key, faction:name())
		end
	end,

	modify_port_region_income_by_percentage = function(faction)
		local technology_to_bundle_map = {
			{
				technology_key = "phar_sea_economic_1_port_income",
				effect_bundle_keys = {
					"phar_sea_effect_bundle_royal_decrees_resource_bronze_mod_percentage",
					"phar_sea_effect_bundle_royal_decrees_resource_food_mod_percentage",
					"phar_sea_effect_bundle_royal_decrees_resource_gold_mod_percentage",
					"phar_sea_effect_bundle_royal_decrees_resource_stones_mod_percentage",
					"phar_sea_effect_bundle_royal_decrees_resource_wood_mod_percentage",
				}
			},
			-- {	-- Redundant system. DaVe setup already handles this tech's effect
			-- 	technology_key = "phar_map_tech_economic_4_ports_food_income",
			-- 	effect_bundle_keys = {
			-- 		"phar_comb_effect_bundle_royal_decrees_resource_port_food_mod_percentage",
			-- 	}
			-- },
		}

		-- modify region's trading/production income by percentage
		for i = 1, #technology_to_bundle_map do
			if faction:has_technology(technology_to_bundle_map[i].technology_key) then
				local regions = faction:region_list()
				local last_region_index = regions:num_items() - 1
				for j = 0, last_region_index do
					local region = regions:item_at(j)
					if region:settlement():is_port() then
						local region_key = region:name()
						for k = 1, #technology_to_bundle_map[i].effect_bundle_keys do
							local effect_bundle_key = technology_to_bundle_map[i].effect_bundle_keys[k]
							if not region:has_effect_bundle(effect_bundle_key) then
								cm:apply_effect_bundle_to_region(effect_bundle_key, region_key, 0)
							end
						end
					end
				end
			end
		end
	end,

	modify_horde_forces_replenishment = function(faction)
		if not faction:has_technology("phar_sea_military_21_max_horde_surplus_buff") then
			return
		end

		local bundle_key = "phar_sea_effect_bundle_royal_decrees_horde_force_replenishment"
		local effect_key_1 = "phar_sea_unrestricted_replenishment_bonus"
		local effect_scope_1 = "force_to_force_own"
		local effect_value_1 = 10
		local effect_key_2 = "phar_sea_army_recruitment_points"
		local effect_scope_2 = "force_to_force_own"
		local effect_value_2 = 2

		local bundle = cm:create_new_custom_effect_bundle(bundle_key)
		bundle:add_effect(effect_key_1, effect_scope_1, effect_value_1)
		bundle:add_effect(effect_key_2, effect_scope_2, effect_value_2)
		bundle:set_duration(0)

		local needed_horde_development_points = 10	-- aka horde_surplus (design term)
		-- modify faction's horde forces replenishment if they have more than `needed_horde_development_points`
		local forces = faction:military_force_list()
		local last_force_index = forces:num_items() - 1
		for i = 0, last_force_index do
			local force = forces:item_at(i)
			if force:has_effect_bundle(bundle_key) and tribes_privileges.is_horde_type(force) and force:get_horde_development_points() < 10 then
				cm:remove_effect_bundle_from_force(bundle_key, force:command_queue_index())
			end
			if not force:has_effect_bundle(bundle_key) and tribes_privileges.is_horde_type(force) and force:get_horde_development_points() >= 10 then
				cm:apply_custom_effect_bundle_to_force(bundle, force)
			end
		end
	end,

	-- method for phar_sea_military_15_raiding_penalty_buff
	modify_horde_forces_raid_stance_happiness = function(faction)
		if not faction:has_technology("phar_sea_military_15_raiding_penalty_buff") then
			return
		end

		local bundle_key = "phar_sea_effect_bundle_royal_decrees_horde_force_military_presence_raiding"
		-- check for existing horde forces whether they are in the raiding stance
		local forces = faction:military_force_list()
		local last_force_index = forces:num_items() - 1
		for i = 0, last_force_index do
			local force = forces:item_at(i)
			local force_active_stance = force:active_stance()
			if not force:has_effect_bundle(bundle_key) and tribes_privileges.is_horde_type(force)
				and (force_active_stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_LAND_RAID" or force_active_stance == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_SET_CAMP_RAIDING")
			then
				cm:apply_effect_bundle_to_force(bundle_key, force:command_queue_index(), 0)
			end
		end
	end,

	--method for phar_main_tech_civil_22_gold_per_lvl_5_building --Lycia modding
	check_regions_and_apply_bonus_gold = function(faction)
		if not faction or type(faction) == "string" then
			script_error("ERROR: Faction is not of type faction_script_interface! check_regions_and_apply_bonus_gold(...)");
			return
		end

		local building_amount = 0
		local region_list = faction:region_list()

		for i=0, region_list:num_items() - 1 do
			local curr_region = region_list:item_at(i)
			local building_list = curr_region:settlement():building_list()
			for j = 0, building_list:num_items() - 1 do
				local curr_building = building_list:item_at(j)
				if curr_building:ui_level() >= 5 then
					building_amount = building_amount + 1
				end
			end
		end

		local effect_bundle_key = "phar_main_effect_bundle_technology_effect_add_gold_from_building_lvl_5"

		if building_amount > 0 then
			local cust_effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)
			local effect = "phar_main_gold_from_lvl_5_building"
			local base_value = cm:get_factions_bonus_value(faction, "gold_from_lvl_5_buildings")

			cust_effect_bundle:add_effect(effect, "faction_to_faction_own", building_amount * base_value)
			cm:apply_custom_effect_bundle_to_faction(cust_effect_bundle, faction)
		else
			cm:remove_effect_bundle(effect_bundle_key, faction:name())
		end
	end,

	--method for phar_main_tech_civil_22_gold_per_lvl_5_building
	update_bonus_gold = function(faction, change_value)
		if not faction or type(faction) == "string" then
			script_error("ERROR: Faction is not of type faction_script_interface! update_bonus_gold(...)");
			return
		end

		local effect_bundle_key = "phar_main_effect_bundle_technology_effect_add_gold_from_building_lvl_5"
		local gold_bundle = faction:get_effect_bundle(effect_bundle_key)
		local base_value = cm:get_factions_bonus_value(faction, "gold_from_lvl_5_buildings")
		local effect_key = "phar_main_gold_from_lvl_5_building"
		local cust_effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)

		if gold_bundle:is_null_interface() then
			cust_effect_bundle:add_effect(effect_key, "faction_to_faction_own", 1 * base_value)
			cm:apply_custom_effect_bundle_to_faction(cust_effect_bundle, faction)
		else
			local effect
			for i=0, gold_bundle:effects():num_items() - 1 do
				local effect_i = gold_bundle:effects():item_at(i)
				if effect_i:key() == effect_key then
					effect = effect_i
				end
			end

			local value = effect:value()
			cust_effect_bundle:add_effect(effect_key, "faction_to_faction_own", value + change_value * base_value)

			cm:apply_custom_effect_bundle_to_faction(cust_effect_bundle, faction)
			--gold_bundle:set_effect_value(effect, value + change_value * base_value)
		end
	end,

	check_workforce_and_apply_bonus = function(faction, wait_a_bit)
		if not faction or type(faction) == "string" then
			script_error("ERROR: Faction is not of type faction_script_interface! check_workforce_and_apply_bonus(...)");
			return
		end

		local effect_bundle_key = "phar_main_effect_bundle_technology_production_workforce"
		local custom_effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)
		local custom_effect_bundle_key = custom_effect_bundle:key()
		local region_list = faction:region_list()


		if not wait_a_bit then

			for i=0, region_list:num_items() - 1 do
				local curr_region = region_list:item_at(i)
				local workforce = curr_region:faction_province_development_points()

				if workforce >= decree_constants.max_population_surplus then
					cm:apply_custom_effect_bundle_to_faction_province(custom_effect_bundle, curr_region)
				else
					cm:remove_effect_bundle_from_faction_province(custom_effect_bundle_key, curr_region)
				end
			end
		elseif wait_a_bit > 0 then
			cm:callback(
				function()
					local effect_bundle_key = "phar_main_effect_bundle_technology_production_workforce"
					local custom_effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)
					for i=0, region_list:num_items() - 1 do
						local curr_region = region_list:item_at(i)
						local workforce = curr_region:faction_province_development_points()

						if workforce >= decree_constants.max_population_surplus then
							cm:apply_custom_effect_bundle_to_faction_province(custom_effect_bundle, curr_region)
						else
							cm:remove_effect_bundle_from_faction_province(custom_effect_bundle_key, curr_region)
						end
					end
				end,
				wait_a_bit
			)
		end
	end,

	--method for phar_main_tech_civil_9_bronze_alliance_hittites
	--method for phar_main_tech_civil_10_food_alliance_egyptians
	--method for phar_main_tech_civil_11_wood_alliance_canaanites
	check_alliance_and_apply_bonus = function(faction, technology_config, apply)
		if not faction or type(faction) == "string" then
			script_error("ERROR: Faction is not of type faction_script_interface! check_alliance_and_apply_bonus(...)");
			return
		end

		if not technology_config then
			script_error("ERROR: check_alliance_and_apply_bonus called with invalid technology_config!");
			return
		end

		local faction_name = faction:name()
		local bundle_key = technology_config.bundle_key
		if apply then
			cm:apply_effect_bundle(bundle_key, faction_name, 0)
			return
		end

		local has_alliance_with_culture = phar_royal_decrees_methods.has_alliance_with(faction, technology_config.culture)
		local has_effect_bundle = faction:has_effect_bundle(bundle_key)

		if has_alliance_with_culture then
			cm:apply_effect_bundle(bundle_key, faction_name, 0)
		elseif has_effect_bundle then
			cm:remove_effect_bundle(bundle_key, faction_name)
		end

	end,

	--method for phar_main_tech_civil_1_happiness_capital
	apply_happiness_bonus_to_capital = function (faction)
		if not faction or type(faction) == "string" then
			script_error("ERROR: Faction is not of type faction_script_interface! apply_happiness_bonus_to_capital(...)");
			return
		end

		local home_region = faction:home_region()

		if home_region:is_null_interface() then
			return
		end

		local effect_bundle_key = "phar_main_effect_bundle_technology_happiness_in_capital"

		cm:apply_effect_bundle_to_province(effect_bundle_key, home_region:name(), 0)

	end,



	--method for phar_main_tech_military_12_ers_destruction
	apply_influence_buff = function(faction)
		if not faction then
			script_error("ERROR: No faction passed as an argument! apply_influence_buff(...)");
			return
		end
		local effect_bundle_key = "phar_main_effect_bundle_influence_ers_destruction"

		cm:apply_effect_bundle(effect_bundle_key, faction:name(), 1)
	end,

	--method for phar_main_tech_civil_12_monument_influence
	--method for phar_main_tech_civil_19_monument_legitimacy
	check_monuments_and_apply_bonus = function(faction, bundle, remove)
		if not faction then
			script_error("ERROR: Faction is not of type faction_script_interface! check_monuments_and_apply_bonus(...)");
			return
		end

		local effect_bundle_key = nil


		local effect_bundle_key_influence = "phar_main_effect_bundle_influence_monument"

		if bundle == "influence" then
			effect_bundle_key = effect_bundle_key_influence
		end
		-->>>>> Use if other effect bundles are added to the monument <<<<<
		-- bonus now added through db
		-- local effect_bundle_key_legitimacy = "phar_main_effect_bundle_legitimacy_monument"
		-- if bundle == "legitimacy" then
		-- 	effect_bundle_key = effect_bundle_key_legitimacy
		-- end

		if not effect_bundle_key then
			script_error("ERROR: Effect bundle not recognized")
			return
		end

		local ers_building_chains_prefix = "phar_main_ers_monument"
		local ers_unique_building_chains_prefix = "phar_main_ers_unique"

		for i=0, faction:region_list():num_items() - 1 do
			local curr_region = faction:region_list():item_at(i)
			local region_has_monument = false

			for j=0, curr_region:slot_list():num_items() - 1 do
				local curr_slot = curr_region:slot_list():item_at(j)
				local curr_building = curr_slot:building()
				if not curr_building:is_null_interface() then
					if string.find(curr_building:chain(), ers_building_chains_prefix) or string.find(curr_building:chain(), ers_unique_building_chains_prefix) then
						region_has_monument = true
						break
					end
				end
			end

			if remove then
				if curr_region:has_effect_bundle(effect_bundle_key) then
					cm:remove_effect_bundle_from_region(effect_bundle_key, curr_region:name())
				end
			elseif region_has_monument and effect_bundle_key then
				cm:apply_effect_bundle_to_region(effect_bundle_key, curr_region:name(), 0)
			end
		end
	end,

	--method for phar_main_tech_civil_18_temple_happiness
	check_temples_and_apply_bonus_happiness = function(faction, remove)
		if not faction then
			script_error("ERROR: Faction is not of type faction_script_interface! check_temples_and_apply_bonus_happiness(...)");
			return
		end

		local effect_bundle_key = "phar_main_effect_bundle_happiness_temple"
		local temple_prefix = "temple"

		for i=0, faction:region_list():num_items() - 1 do
			local curr_region = faction:region_list():item_at(i)
			local region_has_temple = false

			for j=0, curr_region:slot_list():num_items() - 1 do
				local curr_slot = curr_region:slot_list():item_at(j)
				local curr_building = curr_slot:building()
				if not curr_building:is_null_interface() then
					if string.find(curr_building:name(), temple_prefix) then
						region_has_temple = true
						break
					end
				end
			end

			if remove then
				if curr_region:has_effect_bundle(effect_bundle_key) then
					cm:remove_effect_bundle_from_region(effect_bundle_key, curr_region:name())
				end
			elseif region_has_temple then
				cm:apply_effect_bundle_to_region(effect_bundle_key, curr_region:name(), 0)
			end
		end
	end,

	remove_occupation_decision_restrictions = function(faction)
		cm:remove_forced_occupation_decision_restrictions_for_faction(faction)
	end,

	check_royal_decrees_availability = function(faction_key)
		local current_turn = cm:model():turn_number()
		local feature_unlock_turn = feature_unlock.get_feature_unlock_turn_for_faction(faction_key, feature_ids_config.royal_decrees)

		-- do nothing if we're in FTUE mode
		if core:svr_load_bool("sbool_player_selected_first_turn_intro_on_frontend") or cm:get_saved_value("bool_is_tutorial_mode") then
			return
		end

		if current_turn < feature_unlock_turn then
			uim:override("technology_disabled"):lock()
		else
			uim:override("technology_disabled"):unlock()
		end
	end,

	apply_civil_tech_bundle_to_faction_leader = function(faction)
		local fl = faction:faction_leader()
		local bonus_happiness = cm:get_factions_bonus_value(faction, decree_constants.comb_civil_tech_setup.scripted_bonus_happiness)
		local bonus_influence = cm:get_factions_bonus_value(faction, decree_constants.comb_civil_tech_setup.scripted_bonus_influence)

		if fl and (bonus_happiness + bonus_influence) > 0 then
			local cust_bundle = cm:create_new_custom_effect_bundle(decree_constants.comb_civil_tech_setup.bundle_key)
			cust_bundle:add_effect(decree_constants.comb_civil_tech_setup.happiness_effect_key, decree_constants.comb_civil_tech_setup.scope, bonus_happiness)
			cust_bundle:add_effect(decree_constants.comb_civil_tech_setup.influence_effect_key, decree_constants.comb_civil_tech_setup.scope, bonus_influence)

			cm:apply_custom_effect_bundle_to_characters_force(cust_bundle, fl)
		end
	end,

	check_faction_regions_and_apply_bonus_influence = function(faction)
		if not faction then
			script_error("ERROR: Faction is not of type faction_script_interface! check_faction_regions_and_apply_bonus_influence(...)");
			return
		end

		local value = cm:get_factions_bonus_value(faction, decree_constants.comb_influence_tech_setup.scripted_bonus_influence)
		local province_list = faction:province_list()
		local faction_region = nil

		for k=0, province_list:num_items() - 1 do
			local curr_province = province_list:item_at(k)
			local region_list = curr_province:regions()
			local num_buildings = 0
			for i=0, region_list:num_items() - 1 do
				local curr_region = region_list:item_at(i)
				if curr_region:owning_faction() == faction then
					faction_region = curr_region
					local slot_list = curr_region:slot_list()
					for j = 0, slot_list:num_items() - 1 do
						local curr_slot = slot_list:item_at(j)
						if curr_slot:has_building() then
							local curr_building = curr_slot:building()
							if string.find(curr_building:chain(), decree_constants.comb_influence_tech_setup.building_chain_key) then
								num_buildings = num_buildings + 1
							end
						end
					end
				end
			end

			if num_buildings ~= 0 then
				local cust_bundle = cm:create_new_custom_effect_bundle(decree_constants.comb_influence_tech_setup.bundle_key)

				cust_bundle:set_duration(0)
				cust_bundle:add_effect(decree_constants.comb_influence_tech_setup.influence_effect_key, decree_constants.comb_influence_tech_setup.scope, value * num_buildings)

				cm:apply_custom_effect_bundle_to_faction_province(cust_bundle, faction_region)
			end

		end
	end,

	check_province_for_faction_and_apply_bonus_influence = function(faction, province, demolished_override)
		if not province or not faction then
			script_error("ERROR: province or faction is not of the correct type! check_province_for_faction_and_apply_bonus_influence(...)");
			return
		end

		local faction_key = faction:name()
		local region_list = province:regions()
		local num_buildings = 0
		local faction_region = nil

		if province:num_of_regions_owned_by_faction(faction_key) <= 0 then
			return
		end

		if demolished_override then
			num_buildings = num_buildings - 1
		end

		for i=0, region_list:num_items() - 1 do
			local curr_region = region_list:item_at(i)
			if curr_region:owning_faction() == faction then
				faction_region = curr_region
				local slot_list = curr_region:slot_list()
				for j = 0, slot_list:num_items() - 1 do
					local curr_slot = slot_list:item_at(j)
					if curr_slot:has_building() then
						local curr_building = curr_slot:building()
						if string.find(curr_building:chain(), decree_constants.comb_influence_tech_setup.building_chain_key) then
							num_buildings = num_buildings + 1
						end
					end
				end
			end
		end

		if num_buildings ~= 0 then

			local value = cm:get_factions_bonus_value(faction, decree_constants.comb_influence_tech_setup.scripted_bonus_influence)
			local cust_bundle = cm:create_new_custom_effect_bundle(decree_constants.comb_influence_tech_setup.bundle_key)

			cust_bundle:set_duration(0)
			cust_bundle:add_effect(decree_constants.comb_influence_tech_setup.influence_effect_key, decree_constants.comb_influence_tech_setup.scope, value * num_buildings)

			cm:apply_custom_effect_bundle_to_faction_province(cust_bundle, faction_region)
		else
			if province:has_effect_bundle(decree_constants.comb_influence_tech_setup.bundle_key, faction_key) then
				cm:remove_effect_bundle_from_province(decree_constants.comb_influence_tech_setup.bundle_key, faction_region:name())
			end
		end
	end,

}

cm:add_first_tick_callback(
	function()
		local local_faction_name = cm:get_local_faction_name(true)
		phar_royal_decrees_methods.check_royal_decrees_availability(local_faction_name)
	end
)


