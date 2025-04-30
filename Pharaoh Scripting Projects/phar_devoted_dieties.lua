--This file refers to the "Local deities" mechanic in Pharaoh, but below they will be called just "deities"
out("Loading phar_local_deities.lua")

deities =
{
	-- Following are some configurable values for the local deities in general
	config =
	{
		-- Favour needed to reach each effect tier // add balance
		favour_tiers =
		{
			0,
			300,
			800,
			950,
			1150,
			1400,
			1700,
		},

		-- Maximum number of slots for worshipping gods
		max_god_slots = 3,
		-- Initial number of slots for worshipping gods
		init_god_slots = 1,

		-- Table with tiers for unlocking bonuses
		unlock_tiers =
		{
			-- Tier at which shrines unlock
			shrines = 1,
			-- Tier at which dwellings unlock
			dwellings = 1,
			-- Tier at which idols unlock
			idols = 1,
			-- Tier at which prayers unlock
			prayers = 1,
			-- Tier at which devoted general unlocks
			devoted_generals = 2,
		},

		-- Duration of the effect granted by prayer in turns per god culture (Aten is separate)
		prayer_effect_turns =
		{
			phar_main_clt_kemets = 4,
			phar_main_clt_canaan = 6,
			phar_main_clt_hatti = 4,
			phar_main_clt_sea_peoples = 4,
			phar_map_clt_mesopotamian = 4,
			phar_map_clt_aegean = 4,
			aten = 4,
		},

		hecatomb_cooldown = 4,
		hecatomb_percentage_price_increase_per_army = 5,
--bookmark
		-- Negative effect bundle to apply to devoted general when the god is rededicated or the tier for it is lost
		devoted_general_negative_effect_bundle = "phar_main_effect_bundle_devoted_general_negative",
		-- Duration of the negative effect in turns
		devoted_general_negative_effect_bundle_duration = 5,

		-- Prefix of pray interaction records
		pray_interaction_prefixes = {
			"phar_ers_interaction_shrine_pray_",
			"phar_ers_interaction_idol_pray_",
		},

		-- Scripted bonus value for tracking extra god slots
		extra_god_slots_bonus_value = "local_deities_god_slots",

		-- Scripted bonus value for extending prayer duration
		extra_prayer_duration_bonus_value = "local_deities_prayer_duration",

		happiness_from_prayer_bonus_value = "scripted_prayer_happiness",
		happiness_from_prayer_character_effect = "phar_main_province_public_order_happiness_character_factor_basic",
		happiness_from_prayer_character_effect_scope = "force_to_province_own",

		-- Bundles that unlock extra god slots
		extra_god_slot_bundle_1 = "phar_local_deities_god_slot_bundle",
		extra_god_slot_bundle_2 = "phar_local_deities_god_slot_bundle_second",

		-- Effect granting favour
		favour_effect = "phar_main_local_deities_favour",

		-- Technologies that unlock god slots - used for UI
		technologies =
		{
			"phar_main_tech_economic_6_god_slot_2",
			"phar_main_tech_economic_10_god_slot_3",
		},

		-- List of cultures, currently used for displaying possible gods for creating Aten
		cultures =
		{
			"phar_main_clt_kemets",
			"phar_main_clt_canaan",
			"phar_main_clt_hatti",
			"phar_main_clt_sea_peoples",
			"phar_map_clt_mesopotamian",
			"phar_map_clt_aegean",
		},

		-- Legitimacy path to culture
		culture_for_legitimacy =
		{
			legitimacy = "phar_main_clt_kemets",
			hatti_legitimacy = "phar_main_clt_hatti",
			meso_legitimacy = "phar_map_clt_mesopotamian",
			aegean_legitimacy = "phar_map_clt_aegean",
		},

		-- Cultures of gods using a hecatomb
		cultures_with_hecatomb =
		{
			"phar_map_clt_aegean",
		},

		-- Hecatomb costs for unlocking tier 2 and tier 3
		hecatomb_costs =
		{
			"phar_map_hecatomb_tier_1",
			"phar_map_hecatomb_tier_2",
			"phar_map_hecatomb_tier_3",
		},

		bonus_value_building_conversion = "mod_conversion_cost",
		bonus_value_military_force_building_conversion = "military_force_building_conversion_cost_mod",

		resource_factor_gold_from_foreign_convesion = "troy_resource_factor_faction",
		bonus_value_foreign_shrine_converted_gold = "local_deities_foriegn_shrine_converted_gold",
		bonus_value_foreign_temple_converted_gold = "local_deities_foriegn_temple_converted_gold",
		bonus_value_foreign_dwelling_converted_gold = "local_deities_foriegn_dwelling_converted_gold",

		-------------------- Aten config ---------------------------------
		aten_god_key = "aten",
		aten_first_tier_with_unlockables = 3,
		aten_unlockable_choices = 3,
		aten_starting_devoted_generals = 2,

		-- Dummy bundles used for title/description of effects granted from Aten, e.g. in province panel
		aten_shrines_bundle = "phar_main_effect_bundle_local_deities_aten_shrine",
		aten_idols_bundle = "phar_main_effect_bundle_local_deities_aten_idol",
		aten_prayers_bundle = "phar_main_effect_bundle_local_deities_aten_prayer",
		aten_devoted_bundle = "phar_main_effect_bundle_local_deities_aten_devoted_general",

		-- Configuration for unique unlockables for Aten
		aten_unique_unlockables =
		{
			{
				bundle = "phar_main_effect_bundle_cost_mod_all_units_akhenaten",
				localised_flavour = "phar_main_al_akhenaten_unique_effects_upkeep_desc",
				aten_unlockable_random_weight = 10,
			},
			{
				bundle = "phar_main_effect_bundle_growth_per_turn_akhenaten",
				localised_flavour = "phar_main_al_akhenaten_unique_effects_growth_desc",
				aten_unlockable_random_weight = 10,
			},
			{
				bundle = "phar_main_effect_bundle_percentage_multiplier_mod_all_buildings_akhenaten",
				localised_flavour = "phar_main_al_akhenaten_unique_effects_production_desc",
				aten_unlockable_random_weight = 7,
			},
			{
				bundle = "phar_main_effect_bundle_recruitment_points_akhenaten",
				localised_flavour = "phar_main_al_akhenaten_unique_effects_recruitment_cap_desc",
				aten_unlockable_random_weight = 5,
			},
			{
				bundle = "phar_main_effect_bundle_recruitment_rank_all_units_akhenaten",
				localised_flavour = "phar_main_al_akhenaten_unique_effects_recruitment_rank_desc",
				aten_unlockable_random_weight = 7,
			},
			{
				bundle = "phar_main_effect_bundle_upkeep_all_units_akhenaten",
				localised_flavour = "phar_main_al_akhenaten_unique_effects_upkeep_desc",
				aten_unlockable_random_weight = 7,
			},
			{
				bundle = "phar_main_effect_bundle_construction_time_ers_akhenaten",
				localised_flavour = "phar_main_al_akhenaten_unique_effects_ers_desc",
				aten_unlockable_random_weight = 5,
			},
		},

		-- Configuration for extra general unlockable for Aten, should contain only one bundle
		aten_extra_general =
		{
			bundle = "phar_main_effect_bundle_devoted_general_cap_akhenaten",
			localised_flavour = "phar_main_al_akhenaten_unique_effects_devoted_cap_desc",
			aten_unlockable_random_weight = 7,
		},

		-- Configuration for how many effects of each category can be unlocked
		unlockable_categories_limits =
		{
			shrines = 10,
			idols = 10,
			prayer = 8,
			devoted_army = 8,
			-- extra generals fall in this category
			unique = 4,
		},

		-- For debugging purposes
		-- lower value means more messages get printed
		-- priority 10 - errors showing something is seriously broken
		-- no priority given - everything else, gods discovery and worship, favour tier changes, etc.
		min_priority_to_print = 10,
	},

	-- To check if we have just started a new campaign
	new_campaign_started = false,

	-- Following is the configuration of the gods
	gods =
	{
		--###Egyptian Gods###
		{
			-- Key to identify the god - use the god name
			key = "ra",
			-- Record of localised name in db
			localised_name = "phar_local_deities_ra",
			-- Record of localised flavour text in db
			localised_flavour = "phar_main_local_deities_localised_flavour_ra",
			-- Record of localised flavour text for undiscovered god in db
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_ra",
			-- Image on god selection screen
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_egypt_ra.png",
			-- Small god image on bottom of god info screen
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_ra.png",
			-- Round image in god slot
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_ra.png",
			-- Big image on god info screen
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_egypt_ra.png",
			-- Round image in pharaohs crown favoured deity UI
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_egypt_ra.png",
			-- Culture of the god
			culture = "phar_main_clt_kemets",
			-- Epithet of the god
			epithet = "phar_map_local_deities_epithet_ra",
			-- List of realms in which the god can be discovered. Currently realms are configured in phar_realms.lua
			realms =
			{
				"egyptian_lower_egypt_realm",
				"canaanite_sinai_realm",
			},
			-- Temple building chain
			temple_chain = "phar_main_religion_temple_kemet_type_b",
			-- Shrine building chain
			shrine_chain = "phar_main_ers_shrine_ra",
			-- Dwelling chain (for mesopotamian gods)
			dwelling_chain = "",
			-- Idol building chain (for sea peoples factions)
			idol_chain = "",
			-- Effect bundle for enabling/disabling prayer
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_ra",
			-- Cult centre region
			cult_centre_region_key = "phar_main_heliopolis_heliopolis",
			-- High temple chain
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_ra",
			-- Event ids that are god-specific
			event_message_id = 5016,
			-- Tiers with effect bundles granted by each favour tier of this god and other data per tier
			tiers =
			{
				-- Tier 1
				{
					-- Effects granted from shrines
					shrine_effect_bundles =
					{
						-- The inner table here is added to simplify the handling of Akhenaten and any future gods that have more than one bundle per effect category
						{
							-- Each bundle should hold a single effect, if a tier grants more effects split it into more bundles!
							-- This is done so Aten's unlockables only grant 1 effect each
							bundle = "phar_main_effect_bundle_ra_shrine_t1_effect_01",
							-- Flavour text for when this effect is displayed as an unlockable choice for Aten
							localised_flavour = "phar_local_deities_god_description_text",
							-- Random weight considered when determining the chance to give this bundle as an unlockable option for Akhenaten
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ra_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ra_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					-- nil means the effect is not applicable at this tier as it is not unlocked
					-- Effects granted from prayers
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ra_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ra_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 8,
						},
					},
					-- Effects granted for devoted general
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ra_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ra_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ra_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ra_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ra_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ra_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ra_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 0,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ra_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ra_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ra_shrine_t3_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ra_shrine_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ra_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ra_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ra_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ra_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},
		{
			key = "ptah",
			localised_name = "phar_local_deities_ptah",
			localised_flavour = "phar_main_local_deities_localised_flavour_ptah",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_ptah",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_egypt_ptah.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_ptah.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_ptah.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_egypt_ptah.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_egypt_ptah.png",
			culture = "phar_main_clt_kemets",
			epithet = "phar_map_local_deities_epithet_ptah",
			realms =
			{
				"egyptian_lower_egypt_realm",
				"canaanite_sinai_realm",
			},
			temple_chain = "phar_main_religion_temple_kemet_type_c",
			shrine_chain = "phar_main_ers_shrine_ptah",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_ptah",
			cult_centre_region_key = "phar_main_memphis_memphis",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_ptah",
			event_message_id = 5015,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t1_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_4_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ptah_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t2_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_4_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ptah_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ptah_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_4_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_shrine_t3_effect_05",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ptah_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_ptah_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_ptah_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "horus",
			localised_name = "phar_local_deities_horus",
			localised_flavour = "phar_main_local_deities_localised_flavour_horus",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_horus",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_egypt_horus.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_horus.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_horus.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_egypt_horus.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_egypt_horus.png",
			culture = "phar_main_clt_kemets",
			epithet = "phar_map_local_deities_epithet_horus",
			realms =
			{
				"egyptian_kush_realm",
				"egyptian_western_desert_realm",
			},
			temple_chain = "phar_main_religion_temple_kemet_type_h",
			shrine_chain = "phar_main_ers_shrine_horus",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_horus",
			cult_centre_region_key = "phar_main_kawa_kawa",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_horus",
			event_message_id = 5012,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_horus_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_horus_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_horus_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_horus_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_horus_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 7,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_horus_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_horus_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_horus_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_horus_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_horus_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_horus_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_horus_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_horus_army_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_horus_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_horus_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_horus_shrine_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_horus_shrine_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_4_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_horus_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_horus_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_horus_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_horus_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_horus_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "anubis",
			localised_name = "phar_local_deities_anubis",
			localised_flavour = "phar_main_local_deities_localised_flavour_anubis",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_anubis",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_egypt_anubis.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_anubis.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_anubis.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_egypt_anubis.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_egypt_anubis.png",
			culture = "phar_main_clt_kemets",
			epithet = "phar_map_local_deities_epithet_anubis",
			realms =
			{
				"egyptian_kush_realm",
				"egyptian_nubia_realm",
			},
			temple_chain = "phar_main_religion_temple_kemet_type_a",
			shrine_chain = "phar_main_ers_shrine_anubis",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_anubis",
			cult_centre_region_key = "phar_main_buhen_buhen",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_anubis",
			event_message_id = 5011,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_anubis_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_anubis_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_anubis_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_anubis_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_anubis_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_anubis_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_shrine_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_shrine_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_anubis_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_anubis_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_anubis_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "isis",
			localised_name = "phar_local_deities_isis",
			localised_flavour = "phar_main_local_deities_localised_flavour_isis",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_isis",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_egypt_isis.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_isis.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_isis.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_egypt_isis.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_egypt_isis.png",
			culture = "phar_main_clt_kemets",
			epithet = "phar_map_local_deities_epithet_isis",
			realms =
			{
				"egyptian_kush_realm",
				"egyptian_nubia_realm",
			},
			temple_chain = "phar_main_religion_temple_kemet_type_g",
			shrine_chain = "phar_main_ers_shrine_isis",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_isis",
			cult_centre_region_key = "phar_main_north_nubia_miam",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_isis",
			event_message_id = 5013,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_isis_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_isis_prayer_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_isis_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_isis_prayer_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_isis_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_isis_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_isis_army_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_isis_shrine_t3_effect_05",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_isis_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_isis_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_isis_prayer_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_isis_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_isis_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_isis_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "set",
			localised_name = "phar_local_deities_set",
			localised_flavour = "phar_main_local_deities_localised_flavour_set",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_set",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_egypt_set.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_set.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_set.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_egypt_set.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_egypt_set.png",
			culture = "phar_main_clt_kemets",
			epithet = "phar_map_local_deities_epithet_set",
			realms =
			{
				"egyptian_upper_egypt_realm",
				"egyptian_nubia_realm",
			},
			temple_chain = "phar_main_religion_temple_kemet_type_f",
			shrine_chain = "phar_main_ers_shrine_set",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_set",
			cult_centre_region_key = "phar_main_kom_ombo_kom_ombo",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_set",
			event_message_id = 5017,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_set_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_set_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_set_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_set_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_set_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_set_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_set_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_set_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_set_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_set_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_set_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_set_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_set_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_set_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_set_shrine_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_set_shrine_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_set_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_set_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_set_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_set_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "amun",
			localised_name = "phar_local_deities_amun",
			localised_flavour = "phar_main_local_deities_localised_flavour_amun",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_amun",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_egypt_amun.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_amun.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_amun.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_egypt_amun.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_egypt_amun.png",
			culture = "phar_main_clt_kemets",
			epithet = "phar_map_local_deities_epithet_amun",
			realms =
			{
				"egyptian_western_desert_realm",
				"egyptian_upper_egypt_realm",
			},
			temple_chain = "phar_main_religion_temple_kemet_type_i",
			shrine_chain = "phar_main_ers_shrine_amun",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_amun",
			cult_centre_region_key = "phar_main_thebes_thebes",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_amun",
			event_message_id = 5010,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_amun_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_amun_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_amun_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_amun_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_amun_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_amun_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_amun_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_amun_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_amun_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_amun_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_amun_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_amun_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_amun_army_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_amun_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_amun_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_amun_shrine_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_amun_shrine_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_amun_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_amun_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_amun_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_amun_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_amun_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "osiris",
			localised_name = "phar_local_deities_osiris",
			localised_flavour = "phar_main_local_deities_localised_flavour_osiris",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_osiris",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_egypt_osiris.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_osiris.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_osiris.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_egypt_osiris.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_egypt_osiris.png",
			culture = "phar_main_clt_kemets",
			epithet = "phar_map_local_deities_epithet_osiris",
			realms =
			{
				"egyptian_western_desert_realm",
				"egyptian_upper_egypt_realm",
			},
			temple_chain = "phar_main_religion_temple_kemet_type_e",
			shrine_chain = "phar_main_ers_shrine_osiris",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_osiris",
			cult_centre_region_key = "phar_main_abydos_abydos",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_osiris",
			event_message_id = 5014,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_osiris_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_osiris_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_osiris_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_osiris_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_osiris_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_osiris_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_shrine_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_shrine_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_osiris_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_osiris_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_osiris_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 0,
						},
					},
				},
			},
		},

		{
			key = "thoth",
			localised_name = "phar_local_deities_thoth",
			localised_flavour = "phar_main_local_deities_localised_flavour_thoth",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_thoth",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_egypt_thoth.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_thoth.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_thoth.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_egypt_thoth.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_egypt_thoth.png",
			culture = "phar_main_clt_kemets",
			epithet = "phar_map_local_deities_epithet_thoth",
			realms =
			{
				"egyptian_lower_egypt_realm",
			},
			temple_chain = "phar_main_religion_temple_kemet_type_d",
			shrine_chain = "phar_main_ers_shrine_thoth",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_thoth",
			cult_centre_region_key = "phar_main_hermopolis_hermopolis",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_thoth",
			event_message_id = 5018,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_thoth_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_thoth_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 7,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_thoth_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_thoth_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_thoth_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_thoth_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_shrine_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_shrine_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_4_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_thoth_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 7,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_thoth_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_thoth_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

			--### Canaanite Gods ###
		{
			key = "moloch",
			localised_name = "phar_local_deities_moloch",
			localised_flavour = "phar_main_local_deities_localised_flavour_moloch",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_moloch",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_canaan_chemosh.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_canaan_chemosh.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_canaan_chemosh.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_canaan_chemosh.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_canaan_chemosh.png",
			culture = "phar_main_clt_canaan",
			epithet = "phar_map_local_deities_epithet_moloch",
			realms =
			{
				--"canaanite_fenkhu_realm",
				"canaanite_retjenu_realm",
			},
			temple_chain = "phar_main_religion_temple_canaan_type_d",
			shrine_chain = "phar_main_ers_shrine_moloch",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_moloch",
			cult_centre_region_key = "phar_main_damascus_damascus",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_moloch",
			event_message_id = 5003,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_moloch_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_moloch_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_prayer_t1_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_moloch_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_moloch_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_prayer_t2_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_moloch_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_moloch_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_4_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_moloch_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_prayer_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_prayer_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_moloch_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_moloch_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "baal",
			localised_name = "phar_local_deities_baal",
			localised_flavour = "phar_main_local_deities_localised_flavour_baal",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_baal",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_canaan_baal.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_canaan_baal.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_canaan_baal.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_canaan_baal.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_canaan_baal.png",
			culture = "phar_main_clt_canaan",
			epithet = "phar_map_local_deities_epithet_baal",
			realms =
			{
				"canaanite_retjenu_realm",
				"canaanite_yamhad_realm",
			},
			temple_chain = "phar_main_religion_temple_canaan_type_a",
			shrine_chain = "phar_main_ers_shrine_baal",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_baal",
			cult_centre_region_key = "phar_main_emar_emar",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_baal",
			event_message_id = 5001,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_baal_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_baal_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_baal_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_baal_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_baal_prayer_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_baal_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_baal_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_baal_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_baal_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_baal_prayer_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_baal_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_baal_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_baal_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_baal_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_baal_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_baal_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_baal_prayer_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_baal_prayer_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 7,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_baal_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_baal_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_baal_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 0,
						},
					},
				},
			},
		},

		{
			key = "el",
			localised_name = "phar_local_deities_el",
			localised_flavour = "phar_main_local_deities_localised_flavour_el",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_el",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_canaan_el.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_canaan_el.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_canaan_el.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_canaan_el.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_canaan_el.png",
			culture = "phar_main_clt_canaan",
			epithet = "phar_map_local_deities_epithet_el",
			realms =
			{
				"canaanite_fenkhu_realm",
				"canaanite_yamhad_realm",
			},
			temple_chain = "phar_main_religion_temple_canaan_type_b",
			shrine_chain = "phar_main_ers_shrine_el",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_el",
			cult_centre_region_key = "phar_main_ugarit_ugarit",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_el",
			event_message_id = 5002,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_el_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_el_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_el_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_el_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_el_prayer_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_el_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_el_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_el_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_el_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_el_prayer_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_el_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_el_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_el_army_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_el_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_el_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_el_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_el_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_el_prayer_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_el_prayer_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_el_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_el_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_el_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "asherah",
			localised_name = "phar_local_deities_asherah",
			localised_flavour = "phar_main_local_deities_localised_flavour_asherah",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_asherah",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_canaan_asherah.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_canaan_asherah.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_canaan_asherah.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_canaan_asherah.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_canaan_asherah.png",
			culture = "phar_main_clt_canaan",
			epithet = "phar_map_local_deities_epithet_asherah",
			realms =
			{
				"canaanite_retjenu_realm",
				"canaanite_fenkhu_realm",
			},
			temple_chain = "phar_main_religion_temple_canaan_type_c",
			shrine_chain = "phar_main_ers_shrine_asherah",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_asherah",
			cult_centre_region_key = "phar_main_tyre_byblos",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_asherah",
			event_message_id = 5000,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_asherah_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t1_effect_05",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_asherah_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t2_effect_05",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_asherah_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_army_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_asherah_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_prayer_t3_effect_05",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_asherah_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_asherah_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "yamm",
			localised_name = "phar_local_deities_yamm",
			localised_flavour = "phar_main_local_deities_localised_flavour_yam",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_yam",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_canaan_yam.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_canaan_yam.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_canaan_yam.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_canaan_yam.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_canaan_yam.png",
			culture = "phar_main_clt_canaan",
			epithet = "phar_map_local_deities_epithet_yamm",
			realms =
			{
				"canaanite_fenkhu_realm",
				"canaanite_sinai_realm",
			},
			temple_chain = "phar_main_religion_temple_canaan_type_e",
			shrine_chain = "phar_main_ers_shrine_yamm",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_yamm",
			cult_centre_region_key = "phar_main_ashkelon_ashkelon",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_yamm",
			event_message_id = 5004,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_yamm_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_yamm_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_prayer_t1_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_yamm_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_yamm_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_prayer_t2_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_yamm_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_yamm_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_shrine_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_yamm_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_prayer_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_3_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_prayer_t3_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 7,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_yamm_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_yamm_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

			--### Hittite Gods ###
		{
			key = "kumarbi",
			localised_name = "phar_local_deities_kumarbi",
			localised_flavour = "phar_main_local_deities_localised_flavour_kumarbi",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_kumarbi",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_hittite_kumarbi.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_hittite_kumarbi.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_hittite_kumarbi.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_hittite_kumarbi.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_hittite_kumarbi.png",
			culture = "phar_main_clt_hatti",
			epithet = "phar_map_local_deities_epithet_kumarbi",
			realms =
			{
				"canaanite_yamhad_realm",
				"hittite_isuwa_realm",
			},
			temple_chain = "phar_main_religion_temple_hatti_type_e",
			shrine_chain = "phar_main_ers_shrine_kumarbi",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_kumarbi",
			cult_centre_region_key = "phar_main_carchemish_carchemish",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_kumarbi",
			event_message_id = 5006,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kumarbi_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kumarbi_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kumarbi_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kumarbi_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kumarbi_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_army_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_army_t1_effect_05",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kumarbi_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kumarbi_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kumarbi_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_army_t2_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kumarbi_army_t2_effect_05",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "kurunta",
			localised_name = "phar_local_deities_kurunta",
			localised_flavour = "phar_main_local_deities_localised_flavour_kurunta",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_kurunta",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_hittite_kurunta.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_hittite_kurunta.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_hittite_kurunta.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_hittite_kurunta.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_hittite_kurunta.png",
			culture = "phar_main_clt_hatti",
			epithet = "phar_map_local_deities_epithet_kurunta",
			realms =
			{
				"hittite_isuwa_realm",
				"hittite_lowlands_realm",
			},
			temple_chain = "phar_main_religion_temple_hatti_type_d",
			shrine_chain = "phar_main_ers_shrine_kurunta",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_kurunta",
			cult_centre_region_key = "phar_main_south_hatti_tarhuntassa",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_kurunta",
			event_message_id = 5007,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kurunta_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kurunta_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kurunta_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kurunta_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kurunta_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_army_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_army_t1_effect_05",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kurunta_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kurunta_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_kurunta_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_army_t2_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_kurunta_army_t2_effect_05",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "shaushka",
			localised_name = "phar_local_deities_shaushka",
			localised_flavour = "phar_main_local_deities_localised_flavour_shaushka",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_shaushka",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_hittite_zabbabba.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_hittite_zabbabba.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_hittite_zabbabba.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_hittite_zabbabba.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_hittite_zabbabba.png",
			culture = "phar_main_clt_hatti",
			epithet = "phar_map_local_deities_epithet_shaushka",
			realms =
			{
				"hittite_lowlands_realm",
				"hittite_highlands_realm",
			},
			temple_chain = "phar_main_religion_temple_hatti_type_c",
			shrine_chain = "phar_main_ers_shrine_shaushka",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_shaushka",
			cult_centre_region_key = "phar_main_west_hatti_gordion",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_shaushka",
			event_message_id = 5008,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_shaushka_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_shaushka_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_shaushka_shrine_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_shrine_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_shaushka_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_shaushka_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_army_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 7,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_shaushka_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_shaushka_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_shaushka_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 7,
						},
						{
							bundle = "phar_main_effect_bundle_shaushka_army_t2_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 7,
						},
					},
				},
			},
		},

		{
			key = "arinna",
			localised_name = "phar_local_deities_arinna",
			localised_flavour = "phar_main_local_deities_localised_flavour_arinna",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_arinna",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_hittite_arinna.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_hittite_arinna.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_hittite_arinna.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_hittite_arinna.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_hittite_arinna.png",
			culture = "phar_main_clt_hatti",
			epithet = "phar_map_local_deities_epithet_arinna",
			realms =
			{
				"hittite_highlands_realm",
				"hittite_lowlands_realm",
				"aegean_assuwa_realm",
			},
			temple_chain = "phar_main_religion_temple_hatti_type_b",
			shrine_chain = "phar_main_ers_shrine_arinna",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_arinna",
			cult_centre_region_key = "phar_main_hattussa_hattussa",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_arinna",
			event_message_id = 5005,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_arinna_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_shrine_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_arinna_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_arinna_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_shrine_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_3_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_arinna_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_arinna_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_army_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_arinna_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_shrine_t3_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_arinna_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_arinna_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_arinna_army_t2_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "tarhunz",
			localised_name = "phar_local_deities_tarhunz",
			localised_flavour = "phar_main_local_deities_localised_flavour_tarhunna",
			localised_undiscovered_flavour = "phar_main_local_deities_localised_flavour_unknown_tarhunna",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_hittite_tarhunt.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_hittite_tarhunt.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_hittite_tarhunt.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_hittite_tarhunt.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_hittite_tarhunt.png",
			culture = "phar_main_clt_hatti",
			epithet = "phar_map_local_deities_epithet_tarhunz",
			realms =
			{
				"hittite_highlands_realm",
				"hittite_isuwa_realm",
			},
			temple_chain = "phar_main_religion_temple_hatti_type_a",
			shrine_chain = "phar_main_ers_shrine_tarhunz",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_tarhunz",
			cult_centre_region_key = "phar_main_malidiya_malidiya",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_tarhunz",
			event_message_id = 5009,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_tarhunz_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_tarhunz_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_tarhunz_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_tarhunz_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_tarhunz_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_army_t1_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_tarhunz_shrine_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_shrine_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_tarhunz_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 5,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 5,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_main_effect_bundle_tarhunz_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_army_t2_effect_03",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_speed_fatigue_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_main_effect_bundle_tarhunz_army_t2_effect_04",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 0,
						},
					},
				},
			},
		},

		--###Sea Gods###
		{
			key = "kuvava",
			localised_name = "phar_sea_local_deities_kuvava",
			localised_flavour = "phar_sea_local_deities_localised_flavour_kuvava",
			localised_undiscovered_flavour = "phar_sea_local_deities_localised_flavour_kuvava",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_sea_people_god_kuvava.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_sea_people_god_kuvava.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_sea_people_god_kuvava.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_sea_people_god_kuvava.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_sea_people_god_kuvava.png",
			culture = "phar_main_clt_sea_peoples",
			epithet = "phar_map_local_deities_epithet_kuvava",
			realms = {
				-- no realms for sea peoples gods
			},
			temple_chain = "",
			shrine_chain = "",
			dwelling_chain = "",
			idol_chain = "phar_sea_religion_idol_peleset_type_a",
			prayer_effect_bundle = "phar_sea_effect_bundle_local_deities_activate_prayer_kuvava",
			cult_centre_region_key = "",	-- no cult centres for sea peoples gods
			cult_centre_chain = "",
			event_message_id = 5023,
			tiers = --TO DO
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{},
					-- Effects granted from shrines
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t1_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t1_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_kuvava_prayer_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_prayer_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_prayer_t1_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t2_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_kuvava_prayer_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_prayer_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_prayer_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_kuvava_army_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_army_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t3_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t3_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_shrine_t3_effect_05",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_kuvava_prayer_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_prayer_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_prayer_t3_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_kuvava_army_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_army_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_kuvava_army_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},
		{
			key = "levs",
			localised_name = "phar_sea_local_deities_levs",
			localised_flavour = "phar_sea_local_deities_localised_flavour_levs",
			localised_undiscovered_flavour = "phar_sea_local_deities_localised_flavour_levs",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_sea_people_god_levs.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_sea_people_god_levs.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_sea_people_god_levs.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_sea_people_god_levs.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_sea_people_god_levs.png",
			culture = "phar_main_clt_sea_peoples",
			epithet = "phar_map_local_deities_epithet_levs",
			realms = {},
			temple_chain = "",
			shrine_chain = "",
			dwelling_chain = "",
			idol_chain = "phar_sea_religion_idol_peleset_type_b",
			prayer_effect_bundle = "phar_sea_effect_bundle_local_deities_activate_prayer_levs",
			cult_centre_region_key = "",
			cult_centre_chain = "",
			event_message_id = 5019,
			tiers = --TO DO
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t1_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t1_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t1_effect_05",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},

					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_levs_prayer_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_prayer_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_prayer_t1_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t2_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t2_effect_05",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_levs_prayer_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_prayer_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_prayer_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_levs_army_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_army_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t3_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t3_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_shrine_t3_effect_05",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_levs_prayer_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_prayer_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_prayer_t3_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_levs_army_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_army_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_levs_army_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},
		{
			key = "alpanu",
			localised_name = "phar_sea_local_deities_alpanu",
			localised_flavour = "phar_sea_local_deities_localised_flavour_alpanu",
			localised_undiscovered_flavour = "phar_sea_local_deities_localised_flavour_alpanu",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_sea_people_god_alpani.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_sea_people_god_alpani.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/round/portrait_round_sea_people_god_alpani.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_sea_people_god_alpani.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_sea_people_god_alpani.png",
			culture = "phar_main_clt_sea_peoples",
			epithet = "phar_map_local_deities_epithet_alpanu",
			realms = {},
			temple_chain = "",
			shrine_chain = "",
			dwelling_chain = "",
			idol_chain = "phar_sea_religion_idol_sherden_type_b",
			prayer_effect_bundle = "phar_sea_effect_bundle_local_deities_activate_prayer_alpanu",
			cult_centre_region_key = "",
			cult_centre_chain = "",
			event_message_id = 5020,
			tiers = --TO DO
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_alpanu_shrine_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_shrine_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_shrine_t1_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},


					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_alpanu_prayer_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_prayer_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_alpanu_shrine_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_shrine_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_shrine_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},

					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_alpanu_prayer_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_prayer_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_alpanu_army_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_army_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_army_t1_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_alpanu_shrine_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_shrine_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_shrine_t3_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_alpanu_prayer_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_prayer_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_alpanu_army_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_army_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_alpanu_army_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},
		{
			key = "isul",
			localised_name = "phar_sea_local_deities_isul",
			localised_flavour = "phar_sea_local_deities_localised_flavour_isul",
			localised_undiscovered_flavour = "phar_sea_local_deities_localised_flavour_isul",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_sea_people_god_isul.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_sea_people_god_isul.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_sea_people_god_isul.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_sea_people_god_isul.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_sea_people_god_isul.png",
			culture = "phar_main_clt_sea_peoples",
			epithet = "phar_map_local_deities_epithet_isul",
			realms = {},
			temple_chain = "",
			shrine_chain = "",
			dwelling_chain = "",
			idol_chain = "phar_sea_religion_idol_sherden_type_a",
			prayer_effect_bundle = "phar_sea_effect_bundle_local_deities_activate_prayer_isul",
			cult_centre_region_key = "",
			cult_centre_chain = "",
			event_message_id = 5021,
			tiers = --TO DO
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_isul_shrine_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_shrine_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_shrine_t1_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_isul_prayer_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_prayer_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_isul_shrine_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_shrine_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_shrine_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_isul_prayer_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_prayer_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_isul_army_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_army_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_army_t1_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_isul_shrine_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_shrine_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_shrine_t3_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_isul_prayer_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_prayer_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_isul_army_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_army_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_army_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_isul_army_t2_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},
		{
			key = "larun",
			localised_name = "phar_sea_local_deities_larun",
			localised_flavour = "phar_sea_local_deities_localised_flavour_larun",
			localised_undiscovered_flavour = "phar_sea_local_deities_localised_flavour_larun",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_sea_people_god_larun.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_sea_people_god_larun.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_sea_people_god_larun.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_sea_people_god_larun.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_sea_people_god_larun.png",
			culture = "phar_main_clt_sea_peoples",
			epithet = "phar_map_local_deities_epithet_larun",
			realms = {},
			temple_chain = "",
			shrine_chain = "",
			dwelling_chain = "",
			idol_chain = "phar_sea_religion_idol_sherden_type_c",
			prayer_effect_bundle = "phar_sea_effect_bundle_local_deities_activate_prayer_larun",
			cult_centre_region_key = "",
			cult_centre_chain = "",
			event_message_id = 5022,
			tiers = --TO DO
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t1_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t1_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_larun_prayer_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_prayer_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t2_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_larun_prayer_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_prayer_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_larun_army_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_army_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_army_t1_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{},
					idol_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t3_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t3_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_shrine_t3_effect_05",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_larun_prayer_t3_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_prayer_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_sea_effect_bundle_larun_army_t2_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_army_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_army_t2_effect_03",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_sea_effect_bundle_larun_army_t2_effect_04",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},

					},
				},
			},
		},

		--### Mesopotamian Gods ###
		{
			key = "ashur",
			localised_name = "phar_local_deities_ashur",
			localised_flavour = "phar_map_local_deities_ashur_description_discovered",
			localised_undiscovered_flavour = "phar_map_local_deities_ashur_description_undiscovered",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_map_god_mesopotamian_ashur.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_mesopotamian_ashur.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_mesopotamian_ashur.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_map_god_mesopotamian_ashur.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_map_god_mesopotamian_ashur.png",
			culture = "phar_map_clt_mesopotamian",
			epithet = "phar_map_local_deities_epithet_ashur",
			realms =
			{
				"mesopotamia_aber_nahra_realm",
				"mesopotamia_mat_assur_realm",
				"mesopotamia_zagros_realm",
			},
			temple_chain = "phar_map_religion_temple_mesopotamian_ashur",
			shrine_chain = "phar_map_ers_shrine_ashur",
			dwelling_chain = "phar_map_religion_dwelling_ashur",
			idol_chain = "",
			prayer_effect_bundle = "phar_map_effect_bundle_local_deities_activate_prayer_ashur",
			cult_centre_region_key = "phar_map_aranzah_assur",
			cult_centre_chain = "phar_map_religion_cult_center_grand_temple_ashur",
			event_message_id = 5656,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_dwelling_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							-- Should be always 0 for dwelling effects as you don't get them for Aten blessings by design!
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_dwelling_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_dwelling_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_dwelling_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_dwelling_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_dwelling_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ashur_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ashur_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "ishtar",
			localised_name = "phar_local_deities_ishtar",
			localised_flavour = "phar_map_local_deities_ishtar_description_discovered",
			localised_undiscovered_flavour = "phar_map_local_deities_ishtar_description_undiscovered",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_map_god_mesopotamian_ishtar.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_mesopotamian_ishtar.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_mesopotamian_ishtar.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_map_god_mesopotamian_ishtar.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_map_god_mesopotamian_ishtar.png",
			culture = "phar_map_clt_mesopotamian",
			epithet = "phar_map_local_deities_epithet_ishtar",
			realms =
			{
				"mesopotamia_aber_nahra_realm",
				"mesopotamia_mat_assur_realm",
				"mesopotamia_zagros_realm",
				"mesopotamia_haltamti_realm",
			},
			temple_chain = "phar_map_religion_temple_mesopotamian_ishtar",
			shrine_chain = "phar_map_ers_shrine_ishtar",
			dwelling_chain = "phar_map_religion_dwelling_ishtar",
			idol_chain = "",
			prayer_effect_bundle = "phar_map_effect_bundle_local_deities_activate_prayer_ishtar",
			cult_centre_region_key = "phar_map_bit_peri_amurru_dur_kurigalzu",
			cult_centre_chain = "phar_map_religion_cult_center_grand_temple_ishtar",
			event_message_id = 5668,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_dwelling_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_dwelling_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_dwelling_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_dwelling_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_dwelling_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_dwelling_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ishtar_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ishtar_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "inshushinak",
			localised_name = "phar_local_deities_inshushinak",
			localised_flavour = "phar_map_local_deities_inshushinak_description_discovered",
			localised_undiscovered_flavour = "phar_map_local_deities_inshushinak_description_undiscovered",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_map_god_mesopotamian_inshushinak.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_mesopotamian_inshushinak.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_mesopotamian_inshushinak.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_map_god_mesopotamian_inshushinak.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_map_god_mesopotamian_inshushinak.png",
			culture = "phar_map_clt_mesopotamian",
			epithet = "phar_map_local_deities_epithet_inshushinak",
			realms =
			{
				"mesopotamia_mat_tamti_realm",
				"mesopotamia_haltamti_realm",
			},
			temple_chain = "phar_map_religion_temple_mesopotamian_inshushinak",
			shrine_chain = "phar_map_ers_shrine_inshushinak",
			dwelling_chain = "phar_map_religion_dwelling_inshushinak",
			idol_chain = "",
			prayer_effect_bundle = "phar_map_effect_bundle_local_deities_activate_prayer_inshushinak",
			cult_centre_region_key = "phar_map_northern_elam_susa",
			cult_centre_chain = "phar_map_religion_cult_center_grand_temple_inshushinak",
			event_message_id = 5662,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_dwelling_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_dwelling_t1_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_dwelling_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_dwelling_t2_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_dwelling_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_dwelling_t3_effect_02",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_inshushinak_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_inshushinak_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "marduk",
			localised_name = "phar_local_deities_marduk",
			localised_flavour = "phar_map_local_deities_marduk_description_discovered",
			localised_undiscovered_flavour = "phar_map_local_deities_marduk_description_undiscovered",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_map_god_mesopotamian_marduk.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_mesopotamian_marduk.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_mesopotamian_marduk.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_map_god_mesopotamian_marduk.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_map_god_mesopotamian_marduk.png",
			culture = "phar_map_clt_mesopotamian",
			epithet = "phar_map_local_deities_epithet_marduk",
			realms =
			{
				"mesopotamia_mat_tamti_realm",
				"mesopotamia_haltamti_realm",
				"mesopotamia_zagros_realm",
			},
			temple_chain = "phar_map_religion_temple_mesopotamian_marduk",
			shrine_chain = "phar_map_ers_shrine_marduk",
			dwelling_chain = "phar_map_religion_dwelling_marduk",
			idol_chain = "",
			prayer_effect_bundle = "phar_map_effect_bundle_local_deities_activate_prayer_marduk",
			cult_centre_region_key = "phar_map_kan_digirak_babylon",
			cult_centre_chain = "phar_map_religion_cult_center_grand_temple_marduk",
			event_message_id = 5662,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_dwelling_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_dwelling_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_dwelling_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_dwelling_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_dwelling_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_dwelling_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_marduk_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_marduk_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "ninurta",
			localised_name = "phar_local_deities_ninurta",
			localised_flavour = "phar_map_local_deities_ninurta_description_discovered",
			localised_undiscovered_flavour = "phar_map_local_deities_ninurta_description_undiscovered",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_map_god_mesopotamian_ninurta.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_mesopotamian_ninurta.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_mesopotamian_ninurta.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_map_god_mesopotamian_ninurta.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_map_god_mesopotamian_ninurta.png",
			culture = "phar_map_clt_mesopotamian",
			epithet = "phar_map_local_deities_epithet_ninurta",
			realms =
			{
				"mesopotamia_mat_tamti_realm",
				"mesopotamia_aber_nahra_realm",
				"mesopotamia_mat_assur_realm",
			},
			temple_chain = "phar_map_religion_temple_mesopotamian_ninurta",
			shrine_chain = "phar_map_ers_shrine_ninurta",
			dwelling_chain = "phar_map_religion_dwelling_ninurta",
			idol_chain = "",
			prayer_effect_bundle = "phar_map_effect_bundle_local_deities_activate_prayer_ninurta",
			cult_centre_region_key = "phar_map_karduniash_ishtananu_nippur",
			cult_centre_chain = "phar_map_religion_cult_center_grand_temple_ninurta",
			event_message_id = 5680,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_dwelling_t1_effect_01",
							localised_flavour = "phar_local_deities_god_description_text",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_dwelling_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_dwelling_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_dwelling_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					dwelling_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_dwelling_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 0,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_dwelling_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ninurta_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ninurta_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},
		--### Aegean Gods ###
		{
			key = "poseidon",
			localised_name = "phar_local_deities_poseidon",
			localised_flavour = "phar_map_local_deities_poseidon_description_discovered",
			localised_undiscovered_flavour = "phar_map_local_deities_poseidon_description_undiscovered",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_map_god_greek_poseidon.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_greek_poseidon.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_greek_poseidon.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_map_god_greek_poseidon.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_map_god_greek_poseidon.png",
			culture = "phar_map_clt_aegean",
			epithet = "phar_map_local_deities_epithet_poseidon",
			realms =
			{
				"aegean_achaea_realm",
			},
			temple_chain = "phar_map_religion_temple_aegean_poseidon",
			shrine_chain = "phar_map_ers_shrine_poseidon",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_map_effect_bundle_local_deities_activate_prayer_poseidon",
			cult_centre_region_key = "phar_map_kretes_knossos",
			cult_centre_chain = "phar_map_religion_cult_center_grand_temple_poseidon",
			event_message_id = 5644,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_poseidon_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_poseidon_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_poseidon_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_poseidon_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_poseidon_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_poseidon_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_poseidon_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_poseidon_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_poseidon_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_poseidon_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_poseidon_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_poseidon_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_poseidon_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_poseidon_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_poseidon_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_poseidon_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "zeus",
			localised_name = "phar_local_deities_zeus",
			localised_flavour = "phar_map_local_deities_zeus_description_discovered",
			localised_undiscovered_flavour = "phar_map_local_deities_zeus_description_undiscovered",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_map_god_greek_zeus.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_greek_zeus.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_greek_zeus.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_map_god_greek_zeus.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_map_god_greek_zeus.png",
			culture = "phar_map_clt_aegean",
			epithet = "phar_map_local_deities_epithet_zeus",
			realms =
			{
				"aegean_achaea_realm",
			},
			temple_chain = "phar_map_religion_temple_aegean_zeus",
			shrine_chain = "phar_map_ers_shrine_zeus",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_map_effect_bundle_local_deities_activate_prayer_zeus",
			cult_centre_region_key = "phar_map_mycenaeca_mycenae",
			cult_centre_chain = "phar_map_religion_cult_center_grand_temple_zeus",
			event_message_id = 5650,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_zeus_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_zeus_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_zeus_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_zeus_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_zeus_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_zeus_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_zeus_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_zeus_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_zeus_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_zeus_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_zeus_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_zeus_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_zeus_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_zeus_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_zeus_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_zeus_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "ares",
			localised_name = "phar_local_deities_ares",
			localised_flavour = "phar_map_local_deities_ares_description_discovered",
			localised_undiscovered_flavour = "phar_map_local_deities_ares_description_undiscovered",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_map_god_greek_ares.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_greek_ares.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_greek_ares.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_map_god_greek_ares.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_map_god_greek_ares.png",
			culture = "phar_map_clt_aegean",
			epithet = "phar_map_local_deities_epithet_ares",
			realms =
			{
				"aegean_achaea_realm",
				"aegean_thrace_realm",
			},
			temple_chain = "phar_map_religion_temple_aegean_ares",
			shrine_chain = "phar_map_ers_shrine_ares",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_map_effect_bundle_local_deities_activate_prayer_ares",
			cult_centre_region_key = "phar_map_sinticobisaltia_siris",
			cult_centre_chain = "phar_map_religion_cult_center_grand_temple_ares",
			event_message_id = 5638,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ares_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ares_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ares_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ares_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ares_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ares_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ares_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ares_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ares_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ares_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ares_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ares_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ares_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ares_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_ares_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_ares_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "apollo",
			localised_name = "phar_local_deities_apollo",
			localised_flavour = "phar_map_local_deities_apollo_description_discovered",
			localised_undiscovered_flavour = "phar_map_local_deities_apollo_description_undiscovered",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_map_god_greek_apollo.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_greek_apollo.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_greek_apollo.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_map_god_greek_apollo.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_map_god_greek_apollo.png",
			culture = "phar_map_clt_aegean",
			epithet = "phar_map_local_deities_epithet_apollo",
			realms =
			{
				"aegean_assuwa_realm",
				"aegean_thrace_realm",
			},
			temple_chain = "phar_map_religion_temple_aegean_apollo",
			shrine_chain = "phar_map_ers_shrine_apollo",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_map_effect_bundle_local_deities_activate_prayer_apollo",
			cult_centre_region_key = "phar_map_ilion_troy",
			cult_centre_chain = "phar_map_religion_cult_center_grand_temple_apollo",
			event_message_id = 5632,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_apollo_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_apollo_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_apollo_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_apollo_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_apollo_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_apollo_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_apollo_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_apollo_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_apollo_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_apollo_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_apollo_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_apollo_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_apollo_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_apollo_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_apollo_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_apollo_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		{
			key = "aphrodite",
			localised_name = "phar_local_deities_aphrodite",
			localised_flavour = "phar_map_local_deities_aphrodite_description_discovered",
			localised_undiscovered_flavour = "phar_map_local_deities_aphrodite_description_undiscovered",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_map_god_greek_aphrodite.png",
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_greek_aphrodite.png",
			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_map_god_greek_aphrodite.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_map_god_greek_aphrodite.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_map_god_greek_aphrodite.png",
			culture = "phar_map_clt_aegean",
			epithet = "phar_map_local_deities_epithet_aphrodite",
			realms =
			{
				"aegean_assuwa_realm",
				"aegean_thrace_realm",
			},
			temple_chain = "phar_map_religion_temple_aegean_aphrodite",
			shrine_chain = "phar_map_ers_shrine_aphrodite",
			dwelling_chain = "",
			idol_chain = "",
			prayer_effect_bundle = "phar_map_effect_bundle_local_deities_activate_prayer_aphrodite",
			cult_centre_region_key = "phar_map_isthmos_cibyra",
			cult_centre_chain = "phar_map_religion_cult_center_grand_temple_aphrodite",
			event_message_id = 5626,
			tiers =
			{
				-- Tier 1
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_aphrodite_shrine_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_aphrodite_shrine_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_aphrodite_prayer_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_aphrodite_prayer_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles = nil,
				},
				-- Tier 2
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_aphrodite_shrine_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_aphrodite_shrine_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_aphrodite_prayer_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_aphrodite_prayer_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_aphrodite_army_t1_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_aphrodite_army_t1_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
				-- Tier 3
				{
					shrine_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_aphrodite_shrine_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_aphrodite_shrine_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_province_2_desc",
							aten_unlockable_random_weight = 0,
						},
					},
					prayer_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_aphrodite_prayer_t3_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_1_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_aphrodite_prayer_t3_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_campaign_2_desc",
							aten_unlockable_random_weight = 10,
						},
					},
					devoted_effect_bundles =
					{
						{
							bundle = "phar_map_effect_bundle_aphrodite_army_t2_effect_01",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_combat_stats_desc",
							aten_unlockable_random_weight = 10,
						},
						{
							bundle = "phar_map_effect_bundle_aphrodite_army_t2_effect_02",
							localised_flavour = "phar_main_al_akhenaten_stolen_effects_morale_desc",
							aten_unlockable_random_weight = 10,
						},
					},
				},
			},
		},

		-- Special god Aten for the Akhenaten mechanic
		{
			key = "aten",
			localised_name = "phar_local_deities_aten",
			localised_flavour = "phar_local_deities_god_description_text",
			tab_image = "UI/skins/default/local_deities/portraits/listview/portrait_listview_god_aten.png",
			-- TODO: change when it is exported
			tab_image_small = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_aten.png",

			god_slot_image = "UI/skins/default/local_deities/portraits/tab_small/portrait_tab_small_god_egypt_aten.png",
			main_image = "UI/skins/default/local_deities/portraits/main/portrait_main_god_aten.png",
			round_portrait = "UI/skins/default/local_deities/portraits/round/portrait_round_god_aten.png",
			-- So far the culture of Aten is used only to determine his prayer duration
			culture = "aten",
			epithet = "phar_map_local_deities_epithet_aten",
			realms = nil,
			tiers = {},
			prayer_effect_bundle = "phar_main_effect_bundle_local_deities_activate_prayer_aten",
			cult_centre_region_key = "phar_main_amarna_amarna",
			cult_centre_chain = "phar_main_religion_cult_center_grand_temple_aten",
			temple_chain = "phar_main_religion_temple_kemet_type_j",
			shrine_chain = "phar_main_ers_shrine_aten",
			event_message_id = 0, -- currently no event feed messages for Aten, but rather alert icon in faction widget
		},
	},

	auto_discoverable_gods =
	{
		phar_sea_sherden = {
			"alpanu",
			"isul",
			"larun",
		},
		phar_sea_peleset = {
			"kuvava",
			"levs",
			"alpanu",
		}
	},

	-- Configuration for gods worshipped by AI
	ai_gods =
	{
	--Major Deities worshipped by AI
		phar_main_ramesses =
		{
			{
				god_key = "ra",
				starting_favour = 240,
			},
		},

		phar_main_seti =
		{
			{
				god_key = "set",
				starting_favour = 240,
			},
		},
		phar_main_tausret =
		{
			{
				god_key = "isis",
				starting_favour = 240,
			},
		},
		phar_main_amenmesse =
		{
			{
				god_key = "amun",
				starting_favour = 240,
			},
		},
		phar_main_bay =
		{
			{
				god_key = "thoth",
				starting_favour = 240,
			},
		},
		phar_main_kurunta =
		{
			{
				god_key = "kurunta",
				starting_favour = 240,
			},
		},
		phar_main_irsu =
		{
			{
				god_key = "moloch",
				starting_favour = 240,
			},
		},
		phar_main_suppiluliuma =
		{
			{
				god_key = "arinna",
				starting_favour = 240,
			},
		},
		phar_main_merneptah =
		{
			{
				god_key = "ptah",
				starting_favour = 0,
			}
		},
		phar_sea_sherden =
		{
			{
				god_key = "isul",
				starting_favour = 240,
			},
		},
		phar_sea_peleset =
		{
			{
				god_key = "kuvava",
				starting_favour = 240,
			},
		},
		troy_main_dan_mycenae =
		{
			{
				god_key = "zeus",
				starting_favour = 240,
			},
		},
		troy_main_trj_troy =
		{
			{
				god_key = "apollo",
				starting_favour = 240,

			},
		},
		phar_map_babylon =
		{
			{
				god_key = "marduk",
				starting_favour = 240,

			},
		},
		phar_map_ninurta =
		{
			{
				god_key = "ninurta",
				starting_favour = 240,

			},
		},

		--Minor Factions worshipped by AI
		phar_main_dakhla =
		{
			{
				god_key = "osiris",
				starting_favour = 50,
			},
		},
		phar_main_kharga =
		{
			{
				god_key = "horus",
				starting_favour = 20,
			},
		},
		phar_main_dungul =
		{
			{
				god_key = "amun",
				starting_favour = 150,
			},
		},
		phar_main_kerma =
		{
			{
				god_key = "isis",
				starting_favour = 50,
			},
		},
		phar_main_khet_pa =
		{
			{
				god_key = "anubis",
				starting_favour = 30,
			},
		},
		phar_main_kawa	 =
		{
			{
				god_key = "horus",
				starting_favour = 150,
			},
		},
		phar_main_miam	 =
		{
			{
				god_key = "set",
				starting_favour = 20,
			},
		},
		phar_main_waset	 =
		{
			{
				god_key = "amun",
				starting_favour = 50,
			},
		},
		phar_main_zawty	 =
		{
			{
				god_key = "set",
				starting_favour = 50,
			},
		},
		phar_main_mes =
		{
			{
				god_key = "osiris",
				starting_favour = 80,
			},
		},
		phar_main_setnakhte =
		{
			{
				god_key = "set",
				starting_favour = 150,
			},
		},
		phar_main_faiyum =
		{
			{
				god_key = "ptah",
				starting_favour = 150,
			},
		},
		phar_main_buto =
		{
			{
				god_key = "ra",
				starting_favour = 50,
			},
		},
		phar_main_khemenu =
		{
			{
				god_key = "thoth",
				starting_favour = 50,
			},
		},
		phar_main_ashkelon =
		{
			{
				god_key = "yamm",
				starting_favour = 150,
			},
		},
		phar_main_hetch =
		{
			{
				god_key = "ptah",
				starting_favour = 50,
			},
		},
		phar_main_beersheba =
		{
			{
				god_key = "ra",
				starting_favour = 50,
			},
		},
		phar_main_sakka =
		{
			{
				god_key = "moloch",
				starting_favour = 50,
			},
		},
		phar_main_emar =
		{
			{
				god_key = "asherah",
				starting_favour = 150,
			},
		},
		phar_main_damascus	 =
		{
			{
				god_key = "baal",
				starting_favour = 100,
			},
		},
		phar_main_amurru =
		{
			{
				god_key = "el",
				starting_favour = 100,
			},
		},
		phar_main_megiddo =
		{
			{
				god_key = "el",
				starting_favour = 50,
			},
		},
		phar_main_carchemish =
		{
			{
				god_key = "baal",
				starting_favour = 100,
			},
		},
		phar_main_kanesh =
		{
			{
				god_key = "tarhunz",
				starting_favour = 100,
			},
		},
		phar_main_kummanni =
		{
			{
				god_key = "kumarbi",
				starting_favour = 50,
			},
		},
		phar_main_ancyra =
		{
			{
				god_key = "arinna",
				starting_favour = 150,
			},
		},
		phar_main_cibyra =
		{
			{
				god_key = "kurunta",
				starting_favour = 50,
			},
		},
		phar_main_tuwana =
		{
			{
				god_key = "shaushka",
				starting_favour = 100,
			},
		},
		phar_main_kizzuwatna =
		{
			{
				god_key = "arinna",
				starting_favour = 50,
			},
		},
		phar_sea_denyen =
		{
			{
				god_key = "levs",	-- TODO: this should have Zeus as display name
				starting_favour = 50,
			},

		},
		phar_sea_ekwesh =
		{
			{
				god_key = "levs",	-- TODO: this should have Zeus as display name
				starting_favour = 50,
			},

		},
		phar_sea_weshesh =
		{
			{
				god_key = "levs",	-- TODO: this should have Zeus as display name
				starting_favour = 50,
			},

		},
		phar_sea_lukka =
		{
			{
				god_key = "levs",
				starting_favour = 50,
			},

		},
		phar_sea_teresh =
		{
			{
				god_key = "levs",
				starting_favour = 50,
			},

		},
		phar_sea_tjeker =
		{
			{
				god_key = "levs",
				starting_favour = 50,
			},

		},
		phar_sea_shekelesh =
		{
			{
				god_key = "larun",
				starting_favour = 50,
			},

		},
		phar_map_alum =
		{
			{
				god_key = "ishtar",
				starting_favour = 50,
			},

		},
		phar_map_assyria =
		{
			{
				god_key = "ashur",
				starting_favour = 150,
			},

		},
		phar_map_bit_zamani =
		{
			{
				god_key = "ninurta",
				starting_favour = 30,
			},

		},
		phar_map_duranki =
		{
			{
				god_key = "ninurta",
				starting_favour = 150,
			},

		},
		phar_map_ekurma =
		{
			{
				god_key = "marduk",
				starting_favour = 50,
			},

		},
		phar_map_gasham =
		{
			{
				god_key = "marduk",
				starting_favour = 50,
			},

		},
		phar_map_guedena =
		{
			{
				god_key = "inshushinak",
				starting_favour = 50,
			},

		},
		phar_map_gutium =
		{
			{
				god_key = "ashur",
				starting_favour = 30,
			},

		},
		phar_map_hurru =
		{
			{
				god_key = "ishtar",
				starting_favour = 70,
			},

		},
		phar_map_igihalkid =
		{
			{
				god_key = "inshushinak",
				starting_favour = 150,
			},

		},
		phar_map_ishtaran =
		{
			{
				god_key = "ninurta",
				starting_favour = 20,
			},

		},
		phar_map_kare =
		{
			{
				god_key = "ashur",
				starting_favour = 30,
			},

		},
		phar_map_kengir =
		{
			{
				god_key = "inshushinak",
				starting_favour = 20,
			},

		},
		phar_map_kingu =
		{
			{
				god_key = "marduk",
				starting_favour = 30,
			},

		},
		phar_map_kirata =
		{
			{
				god_key = "ishtar",
				starting_favour = 30,
			},

		},
		phar_map_kishu =
		{
			{
				god_key = "ninurta",
				starting_favour = 50,
			},

		},
		phar_map_kurbarnuna =
		{
			{
				god_key = "ishtar",
				starting_favour = 150,
			},

		},
		phar_map_lullubi =
		{
			{
				god_key = "ashur",
				starting_favour = 50,
			},

		},
		phar_map_maeonians =
		{
			{
				god_key = "aphrodite",
				starting_favour = 50,
			},

		},
		phar_map_maita =
		{
			{
				god_key = "ninurta",
				starting_favour = 20,
			},

		},
		phar_map_mari =
		{
			{
				god_key = "ishtar",
				starting_favour = 30,
			},

		},
		phar_map_namar =
		{
			{
				god_key = "marduk",
				starting_favour = 30,
			},

		},
		phar_map_nidr =
		{
			{
				god_key = "ishtar",
				starting_favour = 50,
			},

		},
		phar_map_nirbu =
		{
			{
				god_key = "ashur",
				starting_favour = 30,
			},

		},
		phar_map_nudimat =
		{
			{
				god_key = "ninurta",
				starting_favour = 30,
			},

		},
		phar_map_pala =
		{
			{
				god_key = "arinna",
				starting_favour = 50,
			},

		},
		phar_map_quiha =
		{
			{
				god_key = "kumarbi",
				starting_favour = 20,
			},

		},
		phar_map_sangarian_phrygians =
		{
			{
				god_key = "arinna",
				starting_favour = 50,
			},

		},
		phar_map_shubru =
		{
			{
				god_key = "kumarbi",
				starting_favour = 20,
			},

		},
		phar_map_shutrukid =
		{
			{
				god_key = "inshushinak",
				starting_favour = 50,
			},

		},
		phar_map_suhu =
		{
			{
				god_key = "ashur",
				starting_favour = 30,
			},

		},
		phar_map_sutu =
		{
			{
				god_key = "ishtar",
				starting_favour = 50,
			},

		},
		phar_map_tehenou =
		{
			{
				god_key = "horus",
				starting_favour = 20,
			},

		},
		phar_map_teisheba =
		{
			{
				god_key = "marduk",
				starting_favour = 20,
			},

		},
		phar_map_temen =
		{
			{
				god_key = "ninurta",
				starting_favour = 30,
			},

		},
		phar_map_ur =
		{
			{
				god_key = "marduk",
				starting_favour = 50,
			},

		},
		phar_map_urumu =
		{
			{
				god_key = "ishtar",
				starting_favour = 20,
			},

		},
		phar_map_utu =
		{
			{
				god_key = "ninurta",
				starting_favour = 20,
			},

		},
		phar_map_weila =
		{
			{
				god_key = "ashur",
				starting_favour = 30,
			},

		},
		troy_amazons_trj_hippolyta =
		{
			{
				god_key = "tarhunz",
				starting_favour = 30,
			},

		},
		troy_main_dan_abantes =
		{
			{
				god_key = "zeus",
				starting_favour = 30,
			},

		},
		troy_main_dan_achilles =
		{
			{
				god_key = "zeus",
				starting_favour = 50,
			},

		},
		troy_main_dan_aethaleia =
		{
			{
				god_key = "apollo",
				starting_favour = 30,
			},

		},
		troy_main_dan_aetolians =
		{
			{
				god_key = "ares",
				starting_favour = 20,
			},

		},
		troy_main_dan_anemoessa =
		{
			{
				god_key = "poseidon",
				starting_favour = 50,
			},

		},
		troy_main_dan_antheada =
		{
			{
				god_key = "aphrodite",
				starting_favour = 30,
			},

		},
		troy_main_dan_apaesos =
		{
			{
				god_key = "apollo",
				starting_favour = 20,
			},

		},
		troy_main_dan_arcadians =
		{
			{
				god_key = "zeus",
				starting_favour = 30,
			},

		},
		troy_main_dan_athina =
		{
			{
				god_key = "poseidon",
				starting_favour = 50,
			},

		},
		troy_main_dan_boeotians =
		{
			{
				god_key = "zeus",
				starting_favour = 50,
			},

		},
		troy_main_dan_cassopaei =
		{
			{
				god_key = "zeus",
				starting_favour = 30,
			},

		},
		troy_main_dan_chersonesos =
		{
			{
				god_key = "apollo",
				starting_favour = 20,
			},

		},
		troy_main_dan_corinthians =
		{
			{
				god_key = "poseidon",
				starting_favour = 30,
			},

		},
		troy_main_dan_curetes =
		{
			{
				god_key = "zeus",
				starting_favour = 20,
			},

		},
		troy_main_dan_dionysias =
		{
			{
				god_key = "poseidon",
				starting_favour = 50,
			},

		},
		troy_main_dan_dolopia =
		{
			{
				god_key = "ares",
				starting_favour = 30,
			},

		},
		troy_main_dan_dolopians =
		{
			{
				god_key = "aphrodite",
				starting_favour = 20,
			},

		},
		troy_main_dan_ephesos =
		{
			{
				god_key = "aphrodite",
				starting_favour = 50,
			},

		},
		troy_main_dan_ithaca =
		{
			{
				god_key = "poseidon",
				starting_favour = 50,
			},

		},
		troy_main_dan_knossos =
		{
			{
				god_key = "poseidon",
				starting_favour = 150,
			},

		},
		troy_main_dan_kyme =
		{
			{
				god_key = "apollo",
				starting_favour = 50,
			},

		},
		troy_main_dan_magnetes =
		{
			{
				god_key = "ares",
				starting_favour = 20,
			},

		},
		troy_main_dan_makaria =
		{
			{
				god_key = "apollo",
				starting_favour = 30,
			},

		},
		troy_main_dan_miletus =
		{
			{
				god_key = "aphrodite",
				starting_favour = 50,
			},

		},
		troy_main_dan_phlegra =
		{
			{
				god_key = "ares",
				starting_favour = 30,
			},

		},
		troy_main_dan_pylos =
		{
			{
				god_key = "zeus",
				starting_favour = 30,
			},

		},
		troy_main_dan_rhodes =
		{
			{
				god_key = "aphrodite",
				starting_favour = 50,
			},

		},
		troy_main_dan_teleboans =
		{
			{
				god_key = "poseidon",
				starting_favour = 20,
			},

		},
		troy_main_dan_triopion =
		{
			{
				god_key = "aphrodite",
				starting_favour = 50,
			},

		},
		troy_main_dan_vehinda =
		{
			{
				god_key = "arinna",
				starting_favour = 20,
			},

		},
		troy_main_trj_apsynthioi =
		{
			{
				god_key = "apollo",
				starting_favour = 30,
			},

		},
		troy_main_trj_bithyni =
		{
			{
				god_key = "apollo",
				starting_favour = 50,
			},

		},
		troy_main_trj_carians =
		{
			{
				god_key = "aphrodite",
				starting_favour = 150,
			},

		},
		troy_main_trj_cicones =
		{
			{
				god_key = "ares",
				starting_favour = 50,
			},

		},
		troy_main_trj_ilion =
		{
			{
				god_key = "apollo",
				starting_favour = 20,
			},

		},
		troy_main_trj_lelegia_min =
		{
			{
				god_key = "poseidon",
				starting_favour = 30,
			},

		},
		troy_main_trj_lycia =
		{
			{
				god_key = "aphrodite",
				starting_favour = 50,
			},

		},
		troy_main_trj_paeonians =
		{
			{
				god_key = "ares",
				starting_favour = 50,
			},

		},
		troy_main_trj_paphlagonians =
		{
			{
				god_key = "arinna",
				starting_favour = 50,
			},

		},
		troy_main_trj_pelasgiotes =
		{
			{
				god_key = "apollo",
				starting_favour = 30,
			},

		},
		troy_main_trj_tereia =
		{
			{
				god_key = "aphrodite",
				starting_favour = 20,
			},

		},
		troy_main_trj_thrakes =
		{
			{
				god_key = "apollo",
				starting_favour = 20,
			},

		},
		troy_main_trj_thyni =
		{
			{
				god_key = "ares",
				starting_favour = 30,
			},

		},
		troy_main_trj_tlawa =
		{
			{
				god_key = "aphrodite",
				starting_favour = 20,
			},

		},
		troy_rem_trj_thrace =
		{
			{
				god_key = "ares",
				starting_favour = 150,
			},

		},
	},

	-- Configuration for starting gods for playable factions if they are played by a human
	human_gods =
	{
		phar_main_kurunta = "kurunta",
		phar_main_seti = "set",
		phar_main_tausret = "isis",
		phar_main_amenmesse = "amun",
		phar_main_bay = "thoth",
		phar_main_ramesses = "ra",
		phar_main_irsu = "moloch",
		phar_main_suppiluliuma = "arinna",
		phar_sea_sherden = "isul",
		phar_sea_peleset = "kuvava",
		troy_main_dan_mycenae = "zeus",
		troy_main_trj_troy = "apollo",
		phar_map_babylon = "marduk",
		phar_map_ninurta = "ninurta",
		troy_main_dan_achilles = "ares",
		troy_main_dan_ithaca = "poseidon",
		troy_main_trj_lycia = "aphrodite",
		troy_rem_trj_thrace = "ares",
		troy_main_dan_boeotians = "zeus",
		phar_main_ugarit = "el",
		phar_main_ashkelon = "yamm",
		phar_main_byblos = "asherah",
		phar_main_damascus = "moloch",
		phar_main_emar = "baal",
		phar_main_merneptah = "ptah",
		phar_main_setnakhte = "thoth",
		phar_main_napata = "horus",
		phar_main_dungul = "amun",
		phar_main_bahariya = "osiris",
		phar_main_carchemish = "kumarbi",
		phar_main_malidiya = "tarhunz",
		troy_amazons_trj_hippolyta = "shaushka",
		phar_main_alashiya = "baal",
		phar_map_sangarian_phrygians = "arinna",
		phar_map_assyria = "ashur",
		phar_map_igihalkid = "inshushinak",
		phar_map_shubru = "kurunta",
		phar_map_lullubi = "ishtar",
		phar_map_sutu = "ninurta",
	},

--------------------------------------------------------------
-----------------UI CONFIG -----------------------------------
--------------------------------------------------------------

	component_ids =
	{
		panel = "local_deities",
		background = "background",
		culture_property = "culture",
		culture_tabs_holder = "god_culture_tabs_new",
		tab_buttons =
		{
			"aten_tab_button",
			"egyptian_tab_button",
			"canaanites_tab_button",
			"hittites_tab_button",
			"sea_peoples_tab_button",
			"mesopotamian_tab_button",
			"greek_tab_button",
		},

		gods_list = "gods_list",
		culture_tabs =
		{
			"aten_tab_content",
			"egyptian_tab_content",
			"canaan_tab_content",
			"hittite_tab_content",
			"sea_peoples_tab_content",
			"mesopotamian_tab_content",
			"greek_tab_content",
		},
		culture_new_god_available = "new_god_available",
		god_culture_tab_holder = "holder",
		god_template = "god_template",
		god_key_property = "god_key",
		god_instance_prefix = "god_instance_",
		god_portrait = "god_portrait",
		god_name = "effects_holder",
		god_culture = "god_culture",
		god_new = "dy_new",
		worshipped_indicator = "worshipped_indicator",

		worshipped_all_gods_panel = "worshipped_all_gods_panel",
		worshipped_gods_holder = "worshipped_gods_holder",
		all_gods_hodler = "all_gods_holder",
		gods_holder = "gods_holder",
		worshipped_gods_inner_holder = "worshipped_gods",
		god_slot_template = "worshipped_god_template",
		aten_god_slot_template = "aten_template",
		god_slot_portrait = "god_portrait",
		god_slot_portrait_button = "btn_god_portrait",
		god_slot_army_favour_holder = "army_favour_holder",
		god_slot_favour_bar = "favour_bar",
		god_slot_tier = "tier",
		god_slot_favour_amount_text = "favour_txt",
		god_slot_army_holder = "army_holder",
		god_slot_army_button = "army_button",
		god_slot_index_property = "god_slot_index_property",
		god_slot_name = "god_name_holder",
		god_slot_available_btn = "available_btn",
		devoted_general_index_property = "army_index_property",
		devoted_general_instance_prefix = "devoted_general_",

		worshipped_tab = "worshipped_tab",
		all_gods_tab = "all_gods_tab",

		selected_god = "selected_god_template",
		selected_god_name = "god_name",
		selected_god_flavour = "dy_favor",
		god_button_template = "god_button_template",
		god_button_template_name = "god_name",
		god_button_template_portrait = "god_portrait",
		god_button_template_portrait_image_index = 0,
		god_illustration = "god_illustration",
		cult_centre_holder = "cult_center_holder",
		cult_cenre_txt = "cult_center_txt",
		cult_centre_zoom_button = "button_zoom_location",
		cult_centre_undiscovered_key = "phar_main_local_deities_undiscovered_cult_centre",
		realms_list_holder = "realm_holder",
		realms_list = "realm_names_list",
		realm_name_template = "template_dy_name",

		tier_holder = "tier_holder",
		tier_template = "tier_template",
		tier_indicator = "tier_indicator",
		tier_property = "tier",
		hecatomb_tier_template = "tier_template_v2",
		lock_favour_amount = "favour_amount",
		lock_favour_txt = "favour_txt",
		lock_instance_prefix = "lock_",
		hecatomb_button = "btn_hecatomb",
		hecatomb_ring = "outer_ring",
		hecatomb_cooldown_holder = "indicator_hecatomb_status",
		hecatomb_cooldown_text = "tx_turns",
		hecatomb_effect_text = "dy_effect_text",
		hecatomb_cost = "dy_cost",

		effects_title = "effects_title",
		tier_bonuses = "tier_bonuses",
		shrines_holder = "shrines_holder",
		shrines_icon = "tier_1",
		prayer_holder = "prayer_holder",
		prayer_icon = "tier_2",
		prayer_description = "prayer_desc",
		devoted_holder = "army_holder",
		devoted_icon = "tier_3",
		dwellings_holder = "dwellings_holder",
		dwellings_icon = "tier_3",
		hecatomb_holder = "hecatomb",
		hecatomb_icon = "tier_3",
		idols_holder = "idols_holder",
		idols_icon = "tier_1",
		unique_holder = "unique_holder",
		unique_holder_title = "dy_text",
		blessing_effect_key = "phar_sea_local_deities_blessing_effect",
		no_effect_text = "tx_no_effect",
		bonus_holder = "bonus_holder",
		inactive_bonus_icon = "inactive_icon",
		bonuses_list = "effects_list_dark",
		bonuses_list_light = "effects_list",

		hecatomb_decorations =
		{
			"bulls_decoration",
			"bulls_decoration2",
		},

		tier_icon_component_names =
		{
			"tier_1",
			"tier_2",
			"tier_3",
		},

		tier_unlock_warnings =
		{
			"shrines_alert_text",
			"idols_alert_text",
			"prayer_alert_text",
			"army_alert_text",
			"dwelling_alert_text",
		},

		unlock_category_key = "phar_main_local_deities_unlock_category",
		upgrade_category_key = "phar_main_local_deities_upgrade_category",

		worship_button = "worship_button",
		previous_button = "previous_button",
		next_button = "next_button",

		worship_dialogue_box_id = "worship_dialogue_box_id",
		worship_dialogue_title = "phar_local_deities_confirm_worship_title",
		worship_dialogue_desc = "phar_local_deities_confirm_worship_desc",
		worship_dialogue_shrines = "phar_local_deities_confirm_worship_shrine",
		worship_dialogue_idols = "phar_local_deities_confirm_worship_idol",
		worship_dialogue_prayers = "phar_local_deities_confirm_worship_prayer",
		worship_dialogue_prayers_nomad_outpost = "phar_sea_local_deities_confirm_worship_prayers_nomad_outpost",
		worship_dialogue_devoted = "phar_local_deities_confirm_worship_devoted",
		worship_dialogue_construct = "phar_local_deities_confirm_worship_construct",
		worship_dialogue_construct_shrines = "phar_map_local_deities_confirm_worship_shrines",
		worship_dialogue_construct_shrines_dwellings = "phar_map_local_deities_confirm_worship_shrines_dwellings",
		worship_dialogue_construct_shrines_temples = "phar_map_local_deities_confirm_worship_shrines_temples",
		worship_dialogue_construct_shrines_temples_dwellings = "phar_map_local_deities_confirm_worship_shrines_temples_dwellings",
		worship_dialogue_construct_idols = "phar_local_deities_confirm_worship_construct_idols",
		worship_dialogue_cost_text = "tx_cost",
		worship_result_template = "dy_results_template",
		worhip_results_holder = "results_holder",
		worship_result_prefix = "worship_result_",

		bar_holder = "bar_holder",
		bar_base = "bar_base",
		bar_fill = "bar_fill",

		army_selector = "army_selector",
		army_selector_holder = "army_selector_holder",
		army_template = "army_template",
		army_prefix = "general_instance_",
		general_family_member_cqi_property = "general_family_member_cqi_property",
		army_selector_open_property = "army_selector_open_property",
		no_general_txt = "tx_no_generals",

		shrines_and_temples_holder = "shrines_and_temples_holder",
		shrines_button = "button_round_basic",
		shrines_content = "shrines_content",
		shrines_gods_holder = "god_portraits_holder",
		shrines_god_template = "god_portrait_template",
		shrines_god_portrait = "god_portrait",
		shrines_god_template_shrines_holder = "shrines",
		shrines_god_template_temples_holder = "temples",
		shrines_god_template_dwellings_holder = "dwellings",
		shrines_god_template_idols_holder = "idols",
		shrines_god_template_shrines_count = "dy_number",
		shrines_god_template_temples_count = "dy_number",
		shrines_god_template_dwellings_count = "dy_number",
		shrines_god_template_idols_count = "dy_number",
		shrines_listview = "listview",
		shrines_listbox = "listbox",
		shrines_parent = "shrines_parent",
		temples_parent = "temples_parent",
		dwellings_parent = "dwellings_parent",
		idols_parent = "idols_parent",
		shrines_expanding_list_items = "expanding_list_items",
		temples_expanding_list_items = "expanding_list_items",
		dwellings_expanding_list_items = "expanding_list_items",
		idols_expanding_list_items = "expanding_list_items",
		shrines_location_template = "location_template",
		shrines_location_text = "dy_name",
		shrines_toggles = "toggles",
		shrines_toggle_holder = "toggle_holder",
		shrines_toggle_template = "toggle_template",
		shrines_toggle_template_radio_button = "form_radio",
		shrines_toggle_instance_prefix = "shrines_toggle_",
		temples_toggle_instance_prefix = "temples_toggle_",
		dwellings_toggle_instance_prefix = "dwelling_toggle_",
		idols_toggle_instance_prefix = "idols_toggle_",
		shrines_god_instance_prefix = "shrines_god_instance_",
		shrine_list_item_prefix = "shrine_",
		temple_list_item_prefix = "temple_",
		dwelling_list_item_prefix = "dwelling_",
		idol_list_item_prefix = "idol_",
		radio_button_god_key_property = "god_key",
		shrines_sorting_porperty = "sorting_porperty",
		no_shrines_text = "tx_shrines_none",
		no_temples_text = "tx_temples_none",
		no_dwellings_text = "tx_dwellings_none",
		no_idols_text = "tx_idols_none",
		select_buildings_tooltip_key = "phar_main_local_deities_select_buildings",

		resources_holder = "resources",
		resources_template = "template_resource",
		resources_prefix = "resource_",
		resources_cost = "tx_cost",
		resources_cost_holder = "cost_holder",
		resources_cost_container = "cost_container",
		conversion_turns = "turns",

		shrines_button_apply = "button_shrines_apply",
		shrines_button_cancel = "button_shrines_cancel",

		rededicate_dialogue = "dialogue_worship",
		rededicate_dialogue_title = "dy_title",
		rededicate_dialogue_text = "dy_text",
		rededicate_dialogue_gods_holder = "gods_holder",
		rededicate_dialogue_god_template = "button_god_template",
		rededicate_dialogue_button_confirm = "button_worship_dialogue",
		rededicate_dialogue_button_cancel = "button_cancel_dialogue",
		rededicate_god_template_instance_prefix = "rededicate_god_button_",
		rededicate_god_template_god_slot_property = "god_slot",
		rededicate_god_template_portrait_image_index = 10,
		rededicate_dialogue_worship_tooltip_insufficient_resources = "phar_main_local_deities_insufficient_resources_conversion",
		rededicate_dialogue_armies_key = "phar_main_local_deities_rededicate_army",
		rededicate_dialogue_buildings_key = "phar_main_local_deities_rededicate_buildings",
		rededicate_dialogue_buildings_sea_core = "phar_sea_local_deities_rededicate_buildings_sea_core",
		rededicate_dialogue_buildings_core_sea = "phar_sea_local_deities_rededicate_buildings_core_sea",

		worship_slot_choose_god = "phar_local_deities_choose_god",
		worship_slot_tech_warning = "phar_main_local_deities_technology_required_god_slot",
		worship_slot_label_key = "phar_local_deities_worshipped_god_slot",
		worhip_slot_faction_summary_redirect_key = "phar_main_fac_sum_redir_local_deities_panel",

		god_tooltip_undiscovered_warning_key = "phar_main_local_deities_undiscovered_god_warning",
		undiscovered_warning = "tx_not_discovered",
		effects_alert_key = "phar_main_local_deities_effects_alert",

		favour_tooltip_worshipped_god = "phar_local_deities_worshipped_god",
		favour_tooltip_progress_to_next_tier = "phar_local_deities_progress",
		favour_tooltip_positive_factors = "phar_local_deities_positive_factors",
		favour_tooltip_favour = "phar_local_deities_favour",
		favour_tooltip_favour_description = "phar_local_deities_favour_description",

		army_tooltip_title = "dy_title",
		army_tooltip_text = "dy_text",
		army_tooltip_warning = "dy_warning",

		tier_tooltip_tier = "dy_tier",
		tier_tooltip_favour = "favour_txt",
		tier_tooltip_shrines = "shrines_bonus",
		tier_tooltip_army = "devoted_army_bonus",
		tier_tooltip_prayer = "prayer_bonus",
		tier_tooltip_unique = "unique_bonus",
		tier_tooltip_bonus_holder = "bonus_holder",
		tier_tooltip_favour_requirement = "favour_requirement",
		tier_tooltip_favour_value = "dy_value",

		aten_creation = "aten_polymerization",
		aten_pool_and_effects_holder = "pool_and_effects_holder",
		aten_pool_and_effects_list_box = "list_box",
		aten_creation_god_holder = "gods_holder_template",
		aten_creation_god_template = "god_card_template",
		aten_creation_god_template_name = "dy_god_name",
		aten_creation_god_template_portrait = "god_portrait",
		culture_title_instance_prefix = "culture_title_",
		aten_creation_god_holder_prefix = "aten_god_holder_",
		aten_creation_god_prefix = "aten_creation_god_",
		aten_god_1 = "aten_god_1",
		aten_god_1_slot_holder = "slot_1_holder",
		aten_god_2 = "aten_god_2",
		aten_god_2_slot_holder = "slot_2_holder",
		aten_bonus_effects_holder = "bonus_effects_holder",
		aten_bonus_effects_list_holder = "list_holder",
		aten_bonus_effects_inner_list_holder = "list_holder_inner",
		aten_bonus_effects_holder_list_box = "list_box",
		aten_bonus_effects_shrines_holder = "shrines_effects_holder",
		aten_bonus_effects_shrines_holder_prefix = "shrines_effects_holder_",
		aten_bonus_effects_prayers_holder = "prayers_effects_holder",
		aten_bonus_effects_prayers_holder_prefix = "prayers_effects_holder_",
		aten_bonus_effects_devoted_armies_holder = "devoted_armies_effects_holder",
		aten_bonus_effects_devoted_armies_holder_prefix = "devoted_armies_effects_holder_",
		aten_bonus_effects_god_title_template = "dy_god_name_title",
		aten_bonus_effects_god_title = "dy_name",
		aten_bonus_effects_not_enough_gods_selected = "tx_no_gods_selected",
		aten_unlockables_holder = "unlocks",
		aten_unlockables_holder_list_box = "list_box",
		aten_unlockable_template = "unlock_template",
		aten_unlockable_category = "dy_category",
		aten_unlockable_effect = "bonus_holder",
		aten_unlockable_flavour = "dy_flavor",
		aten_unlockable_prefix = "unlockable_",
		aten_unlockable_locked_overlay = "locked_overlay",
		aten_unlockable_portrait = "icon_holder",
		aten_bonus_holder = "aten_bonus_holder",
		aten_bonus_template = "aten_bonus_template",

		aten_panel = "aten_god_template",

		akhenaten_fm_button = "button_fm_phar_akhenaten",

		local_deities_container = "local_deities_container",
		local_deities_button = "button_local_deities",

		dev_button_discover_god = "dev_button_discover_god",
		dev_button_unlock_god_slot = "dev_button_unlock_god_slot",
		dev_button_add_favour =  "dev_button_add_favour",
		dev_button_remove_favour = "dev_button_remove_favour",
		dev_button_add_favour_aten =  "dev_button_add_favour_aten",
		dev_button_remove_favour_aten = "dev_button_remove_favour_aten",
		dev_button_pray = "dev_button_pray",
		dev_button_pray_prefix = "dev_button_pray_prefix_",

		local_deities_alert = "local_deities_alert_icon",

		discovered_layout_path = "UI/Campaign UI/discovered_god_notification",
	},

	text_ids =
	{
		tiers =
		{
			"phar_local_deities_favour_income_tier_1",
			"phar_local_deities_favour_income_tier_2",
			"phar_local_deities_favour_income_tier_3",
			"phar_local_deities_favour_income_tier_4",
			"phar_local_deities_favour_income_tier_5",
			"phar_local_deities_favour_income_tier_6",
			"phar_local_deities_favour_income_tier_7",
		},
		roman_numerals =
		{
			"I",
			"II",
			"III",
			"IV",
			"V",
			"VI",
			"VII",
		},
		favour_factors =
		{
			shrine_favour = "phar_local_deities_favour_income_shrines",
			temple_favour = "phar_local_deities_favour_income_temples",
			dwelling_favour = "phar_map_local_deities_favour_income_dwellings",
			idol_favour = "phar_local_deities_favour_income_idols",
			cult_centre_favour = "phar_local_deities_favour_income_cult_centre",
			court = "phar_local_deities_favour_income_court",
			wonder = "phar_local_deities_favour_income_wonder"
		},

		unlockable_categories =
		{
			shrines = "phar_local_deities_shrines",
			idols = "phar_local_deities_idols",
			prayer = "phar_local_deities_prayers",
			devoted_army = "phar_local_deities_devoted_army",
			unique = "phar_main_local_deities_other_effects",
			extra_general = "phar_main_local_deities_other_effects",
		},

		rededication = "phar_local_deities_rededicate_02",
		culture_format = "phar_main_local_deities_god_culture_format",
		cultures =
		{
			phar_main_clt_kemets = "phar_local_deities_cultures_egyptian",
			phar_main_clt_canaan = "phar_local_deities_cultures_canaanite",
			phar_main_clt_hatti = "phar_local_deities_cultures_hittite",
			phar_main_clt_sea_peoples = "phar_local_deities_cultures_sea_peoples",
			phar_map_clt_mesopotamian = "phar_local_deities_cultures_mesopotamian",
			phar_map_clt_aegean = "phar_local_deities_cultures_aegean",
		},
		god_from_culture =
		{
			phar_main_clt_kemets = "phar_main_local_deities_god_hover_category_egy",
			phar_main_clt_canaan = "phar_main_local_deities_god_hover_category_can",
			phar_main_clt_hatti = "phar_main_local_deities_god_hover_category_hat",
			phar_main_clt_sea_peoples = "phar_sea_local_deities_god_hover_category_sea",
			phar_map_clt_mesopotamian = "phar_map_local_deities_god_hover_category_mes",
			phar_map_clt_aegean = "phar_map_local_deities_god_hover_category_aeg",
		},

		army_slot_tooltip =
		{
			title = "phar_local_deities_army_slot_title",
			text = "phar_local_deities_army_slot_text",
			low_tier = "phar_local_deities_army_slot_low_tier",
			choose = "phar_local_deities_army_slot_choose",
			unlock = "phar_local_deities_army_slot_unlock",
			worship = "phar_local_deities_army_slot_worship",
		},

		shrine_or_temple_tooltip =
		{
			click = "phar_main_local_deities_shrine_tooltip_click",
			shrine_conversion = "phar_main_local_deities_shrine_tooltip_conversion",
			temple_conversion = "phar_main_local_deities_temple_tooltip_conversion",
			dwelling_conversion = "phar_map_local_deities_dwelling_tooltip_conversion",
			idol_conversion = "phar_sea_local_deities_temple_tooltip_conversion",
		},

		event_message_ids =
		{
			shrine = "phar_local_deities_shrine",
			temple = "phar_local_deities_temple",
			idol = "phar_local_deities_idol",
			dwelling = "phar_local_deities_dwelling",
		},

		confirmation_boxes =
		{
			devote_general_title = "phar_main_local_deities_devote_hero_title",
			devote_general_text = "phar_main_local_deities_devote_hero_confirmation",

			create_aten_title = "phar_main_local_deities_create_aten_title",
			create_aten_text = "phar_main_local_deities_create_aten_confirmation",

			unlockable_title = "phar_main_local_deities_aten_unlockable_title",
			unlockable_text = "phar_main_local_deities_aten_unlockable_confirmation",

			conversion_title = "phar_main_local_deities_conversion_title",
			conversion_text = "phar_main_local_deities_conversion_confirmation",
		},

		alert_tooltip =
		{
			title = "phar_main_local_deities_hud_tooltip_new_events_title",
			new_events = "phar_main_local_deities_hud_tooltip_new_events",
			god_slot_available = "phar_main_local_deities_hud_tooltip_new_god",
			devoted_general = "phar_main_local_deities_hud_tooltip_devoted_general_unlocked",
			new_gods = "phar_main_local_deities_hud_tooltip_discovered_gods",
			unlockables = "phar_main_local_deities_hud_tooltip_unlockables",
		},

		religious_building_unavailable =
		{
			shrine = "phar_sea_local_deities_shrines_unavailable",
			temple = "phar_sea_local_deities_temples_unavailable",
			dwelling = "phar_map_local_deities_dwellings_unavailable",
			idol = "phar_sea_local_deities_idols_unavailable",
		},

		favoured_deity =
		{
			tooltip_title = "ui_text_replacements_localised_text_phar_map_deity_legitimacy_patron_deity_tooltip_title",
			tooltip_text = "ui_text_replacements_localised_text_phar_map_deity_legitimacy_patron_deity_tooltip_text",
		},

		click_discovered_god_tooltip = "phar_sea_local_deities_click_discovered_god",
		hecatomb_confirmation = "phar_map_local_deities_hecatomb_confirmation",
		hecatomb_effect = "phar_map_local_deities_hecatomb_effect",
		hecatomb_flavour = "phar_map_local_deities_hecatomb_flavour",
		hecatomb_cooldown_warning = "phar_map_local_deities_hecatomb_cooldown_warning",
		hecatomb_resources_warning = "phar_map_local_deities_hecatomb_resources_warning",
	},

	tooltips =
	{
		worship_slot = "UI/Common UI/tooltip_title_description_warning",
		army_slot = "UI/Common UI/tooltip_title_description_warning",
		cult_centre = "UI/Common UI/tooltip_title_description_warning",
		realm_name = "UI/Common UI/tooltip_title_description_warning",
		shrine_or_temple_row = "UI/Common UI/tooltip_title_description_warning",
		tier = "UI/Common UI/tooltip_effects_deities_container",
		favour = "UI/Common UI/tooltip_value_breakdown_new",
		god = "UI/Common UI/tooltip_effects_deities_container",
		discovered_god = "UI/Common UI/tooltip_title_description_warning",
		hecatomb = "UI/Common UI/tooltip_hecatomb"
	},

	context_values =
	{
		show_shrine_button = "deities_show_shrine_button",
		show_culture_tabs = "deities_show_culture_tabs",
		show_worshipped_gods_tabs = "deities_show_worshipped_gods_tabs",
		show_gods_description = "deities_show_gods_description",
		switch_all_gods_description = "deities_all_gods_description",

		show_aten_notification = "deities_show_aten_notification",
		show_create_aten_button = "deities_show_create_aten_button",
		show_aten_panel = "deities_show_aten_panel",
		show_aten_unlocks = "deities_aten_unlocks",
		show_create_aten_panel = "deities_show_create_aten_panel",
		show_god_slots = "deities_show_god_slots",
		show_all_gods = "deities_show_all_gods",
		show_favour_cheats = "deities_show_favour_cheats",

		confirm_create_aten_active = "deities_confirm_create_aten_active",
		create_aten_god_table_prefix = "deities_create_aten_",
		aten_god_1_portrait = "deities_aten_god_1",
		aten_god_2_portrait = "deities_aten_god_2",
		aten_effects_god_title_prefix = "deities_aten_effects_god_title_",
		aten_unlockable_prefix = "deities_unlockable_",
		aten_selected_unlockable = "deities_aten_selected_unlockable",

		aten_potential_favour = "deities_aten_potential_favour",
		aten_potential_tier = "deities_aten_potential_tier",

		culture_prefix = "deities_culture_",
	},

	commands =
	{
		open_create_aten = "open_create_aten",
		open_aten = "open_aten",
		confirm_create_aten = "confirm_create_aten",
		aten_god_prefix = "aten_god_",
		aten_god_1 = "aten_god_1",
		aten_god_2 = "aten_god_2",
		confirm_select_unlockable = "confirm_select_unlockable",
		deselect_all = "deselect_all",
		cult_centre = "cult_centre",
		zoom_to_realm = "zoom_to_realm",
		unlockables = "unlockables",
		back_unlockables = "back_unlockables",
		back_selected = "back_selected",
		back_aten_creation = "back_aten_creation",
		god_slot = "god_slot",
		god_selected = "god_selected",
		discovered_animation_god_selected = "discovered_animation_god_selected",
		religious_building_radio_button = "religious_building_radio_button",
		hecatomb = "hecatomb",
	},

	unlockable_categories =
	{
		shrines = "shrines",
		idols = "idols",
		prayer = "prayer",
		devoted_army = "devoted_army",
		unique = "unique",
		-- Extra general will be displayed in the unique category but has a different behaviour regarding random chance weights
		extra_general = "extra_general",
	},

	conversion_sources =
	{
		-- Conversion issued from the settlement panel or the Local deities panel, conversion will take a few turns
		-- Favour and effects from the old building will remain active until the new building is completed.
		settlement_panel = "settlement_panel",
		-- TODO: deities sea ui, maybe add a horde_settlement_panel or sth for idols
		local_deities_panel = "local_deities_panel",
		-- Rededicating a god, conversion will be completed instantly
		rededication = "rededication",
		-- Creating Aten, conversion will be completed instantly and for free
		create_aten = "create_aten",
		cheat = "cheat",
	},

	-- Changing these can break some UI elements, only do so if you know what you're doing.
	script_ids =
	{
		favoured_god_table_script_id = "local_deities_favoured_god_info",
	},

--------------------------------------------------------------
----------------------- END OF CONFIGURATION! ----------------
--------------------------------------------------------------

	--saved data goes in persistent, separated per faction
	persistent = {},
	--temp data for UI
	ui_data =
	{
		active_tab = nil,
		templates = {},
		god_slot_army_button_components = {},
		shrine_radio_groups = {},
		temple_radio_groups = {},
		dwelling_radio_groups = {},
		idol_radio_groups = {},
		aten_god_1 = nil,
		aten_god_2 = nil,
		aten_creation_god_components = {},
		aten_unlockables_components = {},
		aten_selected_unlockable = "0",
	},
	--saved data for UI
	ui_persistent =
	{
		newly_discovered_gods = {},
	},

	--template for persistent data per faction
	faction_persistent_template =
	{
		discovered_gods = {},
		god_slots = {},
		claimed_akhenaten = false,
		aten_slot = nil,
		--[[ temples are in the form
		{
			region_key = "X",
			level = Y,
		} ]]--
		-- temples and shrines that are of gods not currently worshipped are stored here, acquired by taking control of settlements
		-- separated in tables by god key
		inactive_temples = {
			-- format:
			--{
			--	deities.inactive_building_template
			--},
		},
		inactive_shrine_regions = {},
		inactive_dwelling_regions = {},
		inactive_idols = {
			-- format:
			--{
			--	deities.inactive_building_template
			--},
		},
		-- same for cult centres, but this table holds god keys directly as there is 1 cult centre per god
		inactive_cult_centres = {},
		-- temples, shrines, idols currently under conversion are stored here, as their effects are still active
		-- separated in tables by god key
		shrines_under_conversion = {},
		temples_under_conversion = {},
		dwellings_under_conversion = {},
		idols_under_conversion = {},	-- elements of idols_under_conversion_template
	},

	--template for inactive shrines, temples, idols
	inactive_building_template =
	{
		god_key = nil,
		data = {},
	},

	shrines_under_conversion_template =
	{
		god_key = nil,
		--[[ the data is in the form:
		{
			region_key = X,
			favour = Y,
		} --]]
		data = {}
	},

	temples_under_conversion_template =
	{
		god_key = nil,
		--[[ the data is on the form:
		{
			region_key = X,
			level = Y,
			favour = Z,
		} --]]
		data = {}
	},

	dwellings_under_conversion_template =
	{
		god_key = nil,
		--[[ the data is in the form:
		{
			region_key = X,
			favour = Y,
		} --]]
		data = {}
	},

	idols_under_conversion_template =
	{
		god_key = nil,
		data = {
		--[[ Format:
			force_cqi = X, -- X is integer
			level = Y,
			favour = Z,
		} --]]
		},
	},

	--template for unlocked slots for worshipping gods
	god_slot_persistent_template =
	{
		god_key = nil,
		favour =
		{
			-- Favour from other systems such as the court is also saved here, see grant_favour()
			shrine_favour = 0,
			temple_favour = 0,
			dwelling_favour = 0,
			idol_favour = 0,
			cult_centre_favour = 0,
			-- 0 favour falls into the first tier, so we start with -1
			total_favour = -1,
		},
		devoted_generals_family_member_cqi = {},
		shrine_regions = {},
		--[[ temples are in the form
		{
			region_key = "X",
			level = Y,
		} ]]--
		temples = {},
		--[[ idols are in the form
		{
			force_cqi = X,
			level = Y,
		} ]]--
		dwelling_regions = {},
		--[[ dwellings are in the form
		{
			region_key = "X",
			level = Y,
		} ]]--
		idols = {
		},
		--[[ armies_with_prayer_effects are in the form
		{
			force_cqi = X,
			turns_left = Y,
		} --]]
		armies_with_prayer_effects = {},
		cult_centre_owned = false,
	},

	-- Set by the tutorial to skip filling the initial gods of the player
	should_fill_initial_gods = true,

	-- will be populated with temple, shrine and idol building chains for the purposes of restricting access to only those that correspond to a worshipped god
	all_religious_buildings_chains = {},

	-- some gods may be excluded for the local faction only
	-- this table is saved separately from the `persistent` table
	excluded_god_keys = {},

	religious_building_types =
	{
		shrine = "shrine",
		temple = "temple",
		dwelling = "dwelling",
		idol = "idol",
	},

	-- messages only get printed if their priority is at least min_priority_to_print
	-- or if min_priority_to_print is negative
	output = function (str, priority)
		if not str then
			return
		end

		if deities.config.min_priority_to_print > 0 then
			if not priority or deities.config.min_priority_to_print > priority then
				return
			end
		end

		out("*** _LOCAL_DEITIES_ ***: " .. str)
	end,

	get_god = function(key)
		return table_find(deities.gods, function(e) return e.key == key end)
	end,

	get_favoured_god = function(faction_key)
		local legitimacy_path = legitimacy_choice:get_unlocked_legitimacy(faction_key)
		if not legitimacy_path then
			return
		end

		return legitimacy_path.persistent.favoured_deity_key
	end,

	god_requires_hecatomb = function(key)
		local god = deities.get_god(key)
		if not god then
			return false
		end
		return to_bool(table_find(deities.config.cultures_with_hecatomb, god.culture))
	end,

	get_god_slots = function(faction_key)
		if is_table(deities.persistent[faction_key]) then
			if deities.has_faction_created_aten(faction_key) then
				return { deities.persistent[faction_key].aten_slot }
			else
				return deities.persistent[faction_key].god_slots
			end
		else
			deities.output("Could not get deities data for faction " .. tostring(faction_key) .. "!", 10)
			return nil
		end
	end,

	get_aten_slot = function(faction_key)
		local aten_slot = deities.get_god_slot(faction_key, deities.config.aten_god_key)
		if not aten_slot then
			deities.output("Faction " .. tostring(faction_key) .. " tried to select an unlockable but Aten slot not found", 10)
			return nil
		end
		return aten_slot
	end,

	init_aten_slot = function(slot)
		-- Tiers for Aten are saved in the slot rather than the config as they can be different for different factions
		slot.tiers = {}
		local aten_effects_template =
		{
			shrine_effect_bundles = {},
			idol_effect_bundles = {},
			prayer_effect_bundles = {},
			devoted_effect_bundles = {},
			unique_effect_bundles = {},
		}

		for i = 1, #deities.config.favour_tiers do
			table.insert(slot.tiers, table_deep_copy(aten_effects_template))
		end

		slot.pending_choices = 0
		slot.max_tier_reached = 0
		slot.max_tier_selected_unlockable = 0
		slot.unlockables_per_tier = {}
		slot.max_unlocked_devoted_generals = deities.config.aten_starting_devoted_generals
	end,

	get_gods_from_culture = function(culture)
		local result = {}
		for _, god_data in ipairs(deities.gods) do
			if god_data.culture == culture then
				table.insert(result, god_data)
			end
		end
		return result
	end,

	get_filtered_gods_from_culture = function(culture, faction_key, worshipped, discovered)
		local result = {}
		for _, god_data in ipairs(deities.gods) do
			if god_data.culture == culture then
				-- First check in the gods for the current faction as gods can be shared
				local show_god = true
				if is_table(deities.auto_discoverable_gods[faction_key])
					and table_find(deities.auto_discoverable_gods[faction_key], god_data.key)
				then
					show_god = true
				else
					for faction, gods in pairs(deities.auto_discoverable_gods) do
						if table_find(gods, god_data.key) then
							show_god = faction == faction_key
							break
						end
					end
				end
				if show_god then
					local god_slot = deities.get_god_slot(faction_key, god_data.key)
					local current_worshipped = not not god_slot
					local current_discovered = deities.has_faction_discovered_god(faction_key, god_data.key)
					if current_worshipped == worshipped and current_discovered == discovered then
						table.insert(result, god_data)
					end
				end
			end
		end
		return result
	end,

	get_god_temple_chain = function(key)
		return deities.get_god(key).temple_chain
	end,

	get_god_shrine_chain = function(key)
		return deities.get_god(key).shrine_chain
	end,

	get_god_dwelling_chain = function(key)
		return deities.get_god(key).dwelling_chain
	end,

	get_god_idol_chain = function(key)
		return deities.get_god(key).idol_chain
	end,

	get_god_data_for_shrine_chain = function(building_chain_key)
		if not building_chain_key or building_chain_key == "" then
			return nil
		end
		for _, god_data in ipairs(deities.gods) do
			if god_data.shrine_chain == building_chain_key then
				return god_data
			end
		end
		return nil
	end,

	get_god_shrine_effects = function(faction_key, god_key)
		local tier = deities.get_tier(faction_key, god_key)
		if tier <= 0 then
			return nil
		end

		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return nil
		end

		local shrine_effect_bundles = tiers[tier].shrine_effect_bundles
		local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_shrines_bundle or nil
		return deities.get_combined_custom_effect_bundle(shrine_effect_bundles, init_bundle)
	end,

	get_shrine_effects = function(faction_key, building_chain_key)
		local god_data = deities.get_god_data_for_shrine_chain(building_chain_key)
		if not god_data then
			return nil
		end
		return deities.get_god_shrine_effects(faction_key, god_data.key)
	end,

	get_god_data_for_dwelling_chain = function(building_chain_key)
		if not building_chain_key or building_chain_key == "" then
			return nil
		end
		for _, god_data in ipairs(deities.gods) do
			if god_data.dwelling_chain == building_chain_key then
				return god_data
			end
		end
		return nil
	end,

	get_god_dwelling_effects = function(faction_key, god_key)
		local tier = deities.get_tier(faction_key, god_key)
		if tier <= 0 then
			return nil
		end

		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return nil
		end

		local dwelling_effect_bundles = tiers[tier].dwelling_effect_bundles
		-- no dwellings for Aten
		return deities.get_combined_custom_effect_bundle(dwelling_effect_bundles, nil)
	end,

	get_dwelling_effects = function(faction_key, building_chain_key)
		local god_data = deities.get_god_data_for_dwelling_chain(building_chain_key)
		if not god_data then
			return nil
		end
		return deities.get_god_dwelling_effects(faction_key, god_data.key)
	end,

	get_god_data_for_idol_chain = function(building_chain_key)
		if not building_chain_key or building_chain_key == "" then
			return nil
		end
		for _, god_data in ipairs(deities.gods) do
			if god_data.idol_chain == building_chain_key then
				return god_data
			end
		end
		return nil
	end,

	get_god_idol_effects = function(faction_key, god_key, tier)
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return nil
		end

		local idol_effect_bundles = tiers[tier].idol_effect_bundles
		local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_idols_bundle or nil
		return deities.get_combined_custom_effect_bundle(idol_effect_bundles, init_bundle)
	end,

	get_idol_effects = function(faction_key, building_chain_key, building_key)
		local god_data = deities.get_god_data_for_idol_chain(building_chain_key)
		if not god_data then
			return nil
		end

		local tiers = deities.get_god_tiers(faction_key, god_data.key)
		if not is_table(tiers) then
			return nil
		end

		for tier = 1, #tiers do
			-- building levels start from 0
			if building_key == cm:get_building_from_building_chain(building_chain_key, tier - 1) then
				return deities.get_god_idol_effects(faction_key, god_data.key, tier)
			end
		end
		return deities.get_god_idol_effects(faction_key, god_data.key, 1)
	end,

	get_god_cult_centre_chain = function(key)
		return deities.get_god(key).cult_centre_chain
	end,

	get_god_cult_centre_region = function(key)
		return deities.get_god(key).cult_centre_region_key
	end,

	get_god_slot = function(faction_key, god_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get god slot for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		if not god_key then
			return nil
		end

		if god_key == deities.config.aten_god_key then
			return deities.persistent[faction_key].aten_slot
		else
			return table_find(deities.persistent[faction_key].god_slots, function(e) return e.god_key == god_key end)
		end
	end,

	get_god_event_message_id = function(key)
		return deities.get_god(key).event_message_id or 0
	end,

	has_faction_discovered_god = function(faction_key, god_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not check if faction " .. tostring(faction_key) .. " discovered god " .. tostring(god_key), 10)
		end

		if god_key == deities.config.aten_god_key then
			return deities.has_faction_claimed_akhenaten(faction_key)
		end

		return table_find(deities.persistent[faction_key].discovered_gods, god_key) ~= nil
	end,

	get_faction_god_slots_count = function(faction_key)
		if deities.has_faction_created_aten(faction_key) then
			return 1
		end

		local bonus_slots_unlocked = cm:get_factions_bonus_value(faction_key, deities.config.extra_god_slots_bonus_value)
		if is_number(bonus_slots_unlocked) then
			local slot_number = deities.config.init_god_slots + bonus_slots_unlocked
			local god_slots = deities.get_god_slots(faction_key)
			if slot_number > #god_slots then
				slot_number = #god_slots
			end
			return slot_number
		else
			deities.output("Could not get god slots for faction " .. tostring(faction_key), 10)
			return deities.config.init_god_slots
		end
	end,

	get_faction_prayer_duration = function(faction_key, god_key, force)
		local bonus_prayer_duration_for_character = 0
		if force then
			local praying_character = force:general_character()
			local praying_character_cqi = praying_character:cqi()

			bonus_prayer_duration_for_character = cm:get_characters_bonus_value(praying_character, deities.config.extra_prayer_duration_bonus_value)
		end

		local god = deities.get_god(god_key)
		if not god then
			return
		end
		local base_prayer_duration = deities.config.prayer_effect_turns[god.culture]
		local bonus_prayer_duration_for_faction = cm:get_factions_bonus_value(faction_key, deities.config.extra_prayer_duration_bonus_value)
		if is_number(bonus_prayer_duration_for_faction) then
			base_prayer_duration = base_prayer_duration + bonus_prayer_duration_for_faction
		end
		if is_number(bonus_prayer_duration_for_character) then
			base_prayer_duration = base_prayer_duration + bonus_prayer_duration_for_character
		end

		return base_prayer_duration
	end,

	has_faction_god_slot_available = function(faction_name)
		if not feature_unlock.is_feature_unlocked_for_faction(faction_name, feature_ids_config.local_deities) then
			return false
		end

		local god_slots = deities.get_god_slots(faction_name)
		for i = 1, deities.get_faction_god_slots_count(faction_name) do
			local god_slot = god_slots[i]
			if god_slot and not god_slot.god_key then
				return true
			end
		end
		return false
	end,

	add_deities_event_message = function(...)
		local faction_key = arg[2]
		local is_feature_unlocked = feature_unlock.is_feature_unlocked_for_faction(faction_key, feature_ids_config.local_deities)

		if is_feature_unlocked then
			cm:add_event_feed_event(unpack(arg))
		end
	end,

--------------------------------------------------------------
--------------------SHRINES-----------------------------------
--------------------------------------------------------------
	is_using_shrines_or_idols = function(faction_key, god_key)
		use_shrines = false
		use_idols = false

		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return result
		end

		if not is_table(tiers[deities.config.unlock_tiers.idols].idol_effect_bundles) then
			use_idols = false
		else
			use_idols = #tiers[deities.config.unlock_tiers.idols].idol_effect_bundles > 0
		end
		use_shrines = not use_idols
		return use_shrines, use_idols
	end,

	add_shrine = function(faction_key, god_key, region_key)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		--Check if we converted from an inactive god
		if deities.get_inactive_shrine_in_region(faction_key, region_key) then
			local bonus_value_foreign_shrine_converted_gold = cm:get_factions_bonus_value(faction_key, deities.config.bonus_value_foreign_shrine_converted_gold)
			if bonus_value_foreign_shrine_converted_gold > 0 then
				local resource_cost_object = cm:create_new_custom_resource_cost()
				resource_cost_object:add_resource_cost("troy_gold", deities.config.resource_factor_gold_from_foreign_convesion, bonus_value_foreign_shrine_converted_gold)
				local faction = cm:get_faction(faction_key)
				cm:faction_apply_resource_transaction(faction, resource_cost_object)
			end
		end

		-- When a shrine is converted from another one from the province panel we don't receive a BuildingDemolished event to remove it, so we need to remove it manually
		-- Favour from the replaced shrine stays until the new building is completed
		local converted_shrine, converted_god = deities.get_shrine_under_conversion_by_region(faction_key, region_key)
		if converted_shrine then
			deities.send_shrine_converted_event_message(faction_key, god_key, region_key)
			deities.remove_shrine(faction_key, converted_god, converted_shrine.region_key)
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			-- save the shrine in inactive_shrine_regions so it may be used if the faction starts worshipping its god
			deities.add_inactive_shrine(faction_key, god_key, region_key)
			return
		end

		table.insert(god_slot.shrine_regions, region_key)
		deities.output("Shrine added to faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
		deities.update_shrine_favour(faction_key, god_key)

		-- Apply effect from new shrine to region
		local tier = deities.get_tier(faction_key, god_key)
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return
		end

		local region = cm:get_region(region_key)
		if not region then
			deities.output("Error: Invalid region key " .. region_key, 10)
			return
		end

		local new_shrine_effect_bundles = tiers[tier].shrine_effect_bundles
		if new_shrine_effect_bundles then
			local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_shrines_bundle or nil
			local combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(new_shrine_effect_bundles, init_bundle)
			if combined_custom_effect_bundle then
				cm:apply_custom_effect_bundle_to_region(combined_custom_effect_bundle, region)
				deities.output("Applying shrine effect from god " .. tostring(god_key) .. " for region " .. region_key)
			end
		end
	end,

	remove_shrine = function(faction_key, god_key, region_key)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			--remove from inactive shrines list - completed shrines of gods that are not worshipped
			local inactive_shrines_table = deities.get_inactive_shrines(faction_key, god_key)
			if inactive_shrines_table then
				local index = table_find(inactive_shrines_table, region_key, true)
				if index then
					table.remove(inactive_shrines_table, index)
					deities.output("Inactive shrine removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
					return
				end
			end
		end

		-- Remove effect from shrine for region
		local current_tier = deities.get_tier(faction_key, god_key)
		if current_tier ~= -1 then
			deities.remove_shrine_effects_for_tier(faction_key, god_key, region_key, current_tier)
		else
			-- Removing a shrine under conversion from a god that is no longer worshipped
			-- Try to remove effects from all tiers since we do not keep favour and tiers of such gods
			for i = 1, #deities.config.favour_tiers do
				deities.remove_shrine_effects_for_tier(faction_key, god_key, region_key, i)
			end
		end

		local index = god_slot and table_find(god_slot.shrine_regions, region_key, true)
		if index then
			table.remove(god_slot.shrine_regions, index)
			deities.output("Shrine removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
			deities.update_shrine_favour(faction_key, god_key)
		else
			local shrines_under_conversion = deities.get_shrines_under_conversion(faction_key, god_key)
			if is_table(shrines_under_conversion) then
				index = table_find(shrines_under_conversion, function(e) return e.region_key == region_key end, true)
				if index then
					table.remove(shrines_under_conversion, index)
					deities.output("Shrine under conversion removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
					deities.update_shrine_favour(faction_key, god_key)
				end
			end
		end
	end,

	remove_shrine_effects_for_tier = function(faction_key, god_key, region_key, tier)
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) or tier > #tiers then
			return
		end

		local shrine_effect_bundles = tiers[tier].shrine_effect_bundles
		-- the custom effect bundle for Aten's shrine has a special key
		if god_key == deities.config.aten_god_key then
			shrine_effect_bundles =
			{
				{
					bundle = deities.config.aten_shrines_bundle
				}
			}
		end

		if shrine_effect_bundles then
			local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_shrines_bundle or nil
			local combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(shrine_effect_bundles, init_bundle)
			if combined_custom_effect_bundle then
				cm:remove_effect_bundle_from_region(combined_custom_effect_bundle:key(), region_key)
				deities.output("Removing shrine effects from god " .. tostring(god_key) .. " for region " .. region_key)
			end
		end
	end,

	send_shrine_converted_event_message = function(faction_key, god_key, region_key)
		local shrine_string = "ui_text_replacements_localised_text_" .. deities.text_ids.event_message_ids.shrine
		local shrine_slot = region_key .. ":" .. deities.find_region_slot_index_by_shrine_god_key(region_key, god_key)
		local god_name_loc_key = deities.get_localised_text(god_key).name_source
		deities.add_deities_event_message("local_deity_temples_shrines_rededicated", faction_key, 0, shrine_slot, shrine_string, god_name_loc_key)
	end,

	find_and_change_shrine_god = function(faction_key, new_god_key, region_key)
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slots = deities.get_god_slots(faction_key)
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			if god_slots[i].god_key then
				local index = table_find(god_slots[i].shrine_regions, function(e) return e == region_key end, true)
				if index then
					deities.change_shrine_god(faction_key, region_key, god_slots[i].god_key, new_god_key, deities.conversion_sources.settlement_panel)
					break
				end
			end
		end
	end,

	change_shrine_god = function(faction_key, region_key, old_god_key, new_god_key, source)
		local old_god_slot = deities.get_god_slot(faction_key, old_god_key)

		local shrine
		if old_god_slot then
			shrine = table_find(old_god_slot.shrine_regions, function(e) return e == region_key end)
		else
		-- Check in the inactive shrines
			shrine = deities.get_inactive_shrine(faction_key, old_god_key, region_key)
		end

		if shrine and old_god_key then
			deities.output("Changing shrine for faction " .. tostring(faction_key) .. " from god " .. old_god_key .. " to god " .. new_god_key)

			local old_building_chain = deities.get_god_shrine_chain(old_god_key)
			local new_building_chain = deities.get_god_shrine_chain(new_god_key)
			local old_building_key = cm:get_building_from_building_chain(old_building_chain, 0)
			local new_building_key = cm:get_building_from_building_chain(new_building_chain, 0)

			local slot_index = deities.find_region_slot_index_by_building_key(region_key, old_building_key)
			if slot_index then
				-- Save the old building
				local building = deities.find_building_by_building_chain(region_key, old_building_chain, 0)
				if building then
					-- Save favour for buildings that are converted - they still give favour until the new building is completed, but their building interface is gone and the favour cannot be accessed through it
					if source ~= deities.conversion_sources.create_aten
					and source ~= deities.conversion_sources.cheat then
						local favour = building:get_effect_value(deities.config.favour_effect)
						deities.put_shrine_under_conversion(faction_key, old_god_key, region_key, favour)
					end
				end
				if source == deities.conversion_sources.settlement_panel then
					--do nothing, construction already handled
				elseif source == deities.conversion_sources.local_deities_panel
					or source == deities.conversion_sources.rededication
				then
					-- cm:queue_building_construction_in_region decrements this index by 1
					-- replace_building_in_region_slot doesn't expend resources
					cm:queue_building_construction_in_region(region_key, slot_index + 1, new_building_key)
				elseif source == deities.conversion_sources.create_aten or source == deities.conversion_sources.cheat then
					-- do not expend resources
					-- cm:replace_building_in_region_slot decrements this index by 1
					cm:replace_building_in_region_slot(region_key, slot_index + 1, new_building_key)
				end

				deities.update_shrine_favour(faction_key, old_god_key)
				deities.update_shrine_favour(faction_key, new_god_key)
			end
		else
			deities.output("Could not change shrine for faction " .. tostring(faction_key) .. " from god " .. tostring(old_god_key) .. " to god " .. new_god_key, 10)
		end
	end,

	get_shrines_under_conversion = function(faction_key, god_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get shrines under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local result = is_table(deities.persistent[faction_key].shrines_under_conversion)
			and table_find(deities.persistent[faction_key].shrines_under_conversion, function(e) return e.god_key == god_key end)
		if result then
			return result.data
		else
			return nil
		end
	end,

	get_shrine_under_conversion = function(faction_key, god_key, region_key)
		local shrines_table = deities.get_shrines_under_conversion(faction_key, god_key)
		if is_table(shrines_table) then
			return table_find(shrines_table, function(e) return e.region_key == region_key end)
		else
			return nil
		end
	end,

	get_shrine_under_conversion_by_region = function(faction_key, region_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get shrines under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local shrines_table = deities.persistent[faction_key].shrines_under_conversion
		if is_table(shrines_table) then
			for _, shrines_per_god in ipairs(shrines_table) do
				local shrine = table_find(shrines_per_god.data, function(e) return e.region_key == region_key end)
				if shrine then
					return shrine, shrines_per_god.god_key
				end
			end
		else
			return nil
		end
	end,

	put_shrine_under_conversion = function(faction_key, god_key, region_key, favour)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could put shrine under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local shrines_under_conversion = deities.get_shrines_under_conversion(faction_key, god_key)
		-- Add entry for this god if there isn't one
		if not shrines_under_conversion then
			table.insert(deities.persistent[faction_key].shrines_under_conversion, table_deep_copy(deities.shrines_under_conversion_template))
			shrines_under_conversion = deities.persistent[faction_key].shrines_under_conversion[#deities.persistent[faction_key].shrines_under_conversion]
			shrines_under_conversion.god_key = god_key
			shrines_under_conversion = shrines_under_conversion.data
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not put shrine under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local index = table_find(god_slot.shrine_regions, function(e) return e == region_key end, true)
		if index then
			-- Effects of this shrine will still remain active
			table.remove(god_slot.shrine_regions, index)
			table.insert(shrines_under_conversion, {region_key = region_key, favour = favour})
		else
			deities.output("Could not find shrine to put under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " for region " .. region_key, 10)
		end
	end,

	cancel_shrine_conversion = function(faction_key, god_key, region_key)
		-- Remove from shrines under conversion
		deities.remove_shrine(faction_key, god_key, region_key)
		-- Add back as either inactive or completed
		deities.add_shrine(faction_key, god_key, region_key)
	end,

	update_shrine_favour = function(faction_key, god_key)
		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not update favour from shrines for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		--Check if there are shrines for a god that was not worshipped but now is and transfer them to the god slot
		local inactive_shrine_regions_table = deities.get_inactive_shrines(faction_key, god_key)

		if is_table(inactive_shrine_regions_table) then
			for i = #inactive_shrine_regions_table, 1, -1 do
				deities.output("Faction " .. tostring(faction_key) .. " now gains favour for god " .. tostring(god_key) .. " from pre-existing shrine in " .. inactive_shrine_regions_table[i])
				table.insert(god_slot.shrine_regions, table_deep_copy(inactive_shrine_regions_table[i]))
				table.remove(inactive_shrine_regions_table, i)
			end
		end

		god_slot.favour.shrine_favour = 0

		local building_chain = deities.get_god_shrine_chain(god_key)

		for _, shrine_region in ipairs(god_slot.shrine_regions) do
			local building = deities.find_building_by_building_chain(shrine_region, building_chain, 0)
			if building then
				local favour = building:get_effect_value(deities.config.favour_effect)
				god_slot.favour.shrine_favour = god_slot.favour.shrine_favour + favour
			end
		end

		-- Add favour from shrines under conversion
		local shrines_under_conversion = deities.get_shrines_under_conversion(faction_key, god_key)
		if is_table(shrines_under_conversion) then
			for _, shrine in ipairs(shrines_under_conversion) do
				god_slot.favour.shrine_favour = god_slot.favour.shrine_favour + shrine.favour
			end
		end

		deities.output("Shrine favour for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " is now " .. god_slot.favour.shrine_favour)
		deities.update_total_favour(faction_key, god_key)
		return god_slot.favour.shrine_favour
	end,

--------------------------------------------------------------
--------------------DWELLINGS---------------------------------
--------------------------------------------------------------
	has_dwellings = function(god_key)
		local dwelling_chain = deities.get_god_dwelling_chain(god_key)
		return to_bool(dwelling_chain and dwelling_chain ~= "")
	end,

	faction_has_dwelling_gods = function(faction_key)
		local god_slots = deities.get_god_slots(faction_key)
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			local god_key = god_slots[i].god_key
			if god_key and deities.has_dwellings(god_key) then
				return true
			end
		end
		return false
	end,

	add_dwelling = function(faction_key, god_key, region_key)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		--Check if we converted from an inactive god
		if deities.get_inactive_dwelling_in_region(faction_key, region_key) then
			local bonus_value_foreign_dwelling_converted_gold = cm:get_factions_bonus_value(faction_key, deities.config.bonus_value_foreign_dwelling_converted_gold)
			if bonus_value_foreign_dwelling_converted_gold > 0 then
				local resource_cost_object = cm:create_new_custom_resource_cost()
				resource_cost_object:add_resource_cost("troy_gold", deities.config.resource_factor_gold_from_foreign_convesion, bonus_value_foreign_dwelling_converted_gold)
				local faction = cm:get_faction(faction_key)
				cm:faction_apply_resource_transaction(faction, resource_cost_object)
			end
		end

		-- When a dwelling is converted from another one from the province panel we don't receive a BuildingDemolished event to remove it, so we need to remove it manually
		-- Favour from the replaced dwelling stays until the new building is completed
		local converted_dwelling, converted_god = deities.get_dwelling_under_conversion_by_region(faction_key, region_key)
		if converted_dwelling then
			deities.send_dwelling_converted_event_message(faction_key, god_key, region_key)
			deities.remove_dwelling(faction_key, converted_god, converted_dwelling.region_key)
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			-- save the dwelling in inactive_dwelling_regions so it may be used if the faction starts worshipping its god
			deities.add_inactive_dwelling(faction_key, god_key, region_key)
			return
		end

		table.insert(god_slot.dwelling_regions, region_key)
		deities.output("Dwelling added to faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
		deities.update_dwelling_favour(faction_key, god_key)

		-- Apply effect from new dwelling to region
		local tier = deities.get_tier(faction_key, god_key)
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return
		end

		local region = cm:get_region(region_key)
		if not region then
			deities.output("Error: Invalid region key " .. region_key, 10)
			return
		end

		local new_dwelling_effect_bundles = tiers[tier].dwelling_effect_bundles
		if new_dwelling_effect_bundles then
			-- no dwellings for Aten
			local combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(new_dwelling_effect_bundles, nil)
			if combined_custom_effect_bundle then
				cm:apply_custom_effect_bundle_to_region(combined_custom_effect_bundle, region)
				deities.output("Applying dwelling effect from god " .. tostring(god_key) .. " for region " .. region_key)
			end
		end
	end,

	remove_dwelling = function(faction_key, god_key, region_key)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			--remove from inactive dwellings list - completed dwellings of gods that are not worshipped
			local inactive_dwellings_table = deities.get_inactive_dwellings(faction_key, god_key)
			if inactive_dwellings_table then
				local index = table_find(inactive_dwellings_table, region_key, true)
				if index then
					table.remove(inactive_dwellings_table, index)
					deities.output("Inactive dwelling removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
					return
				end
			end
		end

		-- Remove effect from dwelling for region
		local current_tier = deities.get_tier(faction_key, god_key)
		if current_tier ~= -1 then
			deities.remove_dwelling_effects_for_tier(faction_key, god_key, region_key, current_tier)
		else
			-- Removing a dwelling under conversion from a god that is no longer worshipped
			-- Try to remove effects from all tiers since we do not keep favour and tiers of such gods
			for i = 1, #deities.config.favour_tiers do
				deities.remove_dwelling_effects_for_tier(faction_key, god_key, region_key, i)
			end
		end

		local index = god_slot and table_find(god_slot.dwelling_regions, region_key, true)
		if index then
			table.remove(god_slot.dwelling_regions, index)
			deities.output("Dwelling removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
			deities.update_dwelling_favour(faction_key, god_key)
		else
			local dwellings_under_conversion = deities.get_dwellings_under_conversion(faction_key, god_key)
			if is_table(dwellings_under_conversion) then
				index = table_find(dwellings_under_conversion, function(e) return e.region_key == region_key end, true)
				if index then
					table.remove(dwellings_under_conversion, index)
					deities.output("Dwelling under conversion removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
					deities.update_dwelling_favour(faction_key, god_key)
				end
			end
		end
	end,

	remove_dwelling_effects_for_tier = function(faction_key, god_key, region_key, tier)
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) or tier > #tiers then
			return
		end

		local dwelling_effect_bundles = tiers[tier].dwelling_effect_bundles

		if dwelling_effect_bundles then
			-- no dwellings for Aten
			local combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(dwelling_effect_bundles, nil)
			if combined_custom_effect_bundle then
				cm:remove_effect_bundle_from_region(combined_custom_effect_bundle:key(), region_key)
				deities.output("Removing dwelling effects from god " .. tostring(god_key) .. " for region " .. region_key)
			end
		end
	end,

	send_dwelling_converted_event_message = function(faction_key, god_key, region_key)
		local dwelling_string = "ui_text_replacements_localised_text_" .. deities.text_ids.event_message_ids.dwelling
		local dwelling_chain = deities.get_god_dwelling_chain(god_key)
		local dwelling_slot = region_key .. ":" .. deities.find_building_by_building_chain(region_key, dwelling_chain, 0, true)
		local god_name_loc_key = deities.get_localised_text(god_key).name_source
		deities.add_deities_event_message("local_deity_temples_shrines_rededicated", faction_key, 0, dwelling_slot, dwelling_string, god_name_loc_key)
	end,

	find_and_change_dwelling_god = function(faction_key, new_god_key, region_key)
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slots = deities.get_god_slots(faction_key)
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			if god_slots[i].god_key then
				local index = table_find(god_slots[i].dwelling_regions, function(e) return e == region_key end, true)
				if index then
					deities.change_dwelling_god(faction_key, region_key, god_slots[i].god_key, new_god_key, deities.conversion_sources.settlement_panel)
					break
				end
			end
		end
	end,

	change_dwelling_god = function(faction_key, region_key, old_god_key, new_god_key, source)
		local old_god_slot = deities.get_god_slot(faction_key, old_god_key)

		local dwelling
		if old_god_slot then
			dwelling = table_find(old_god_slot.dwelling_regions, function(e) return e == region_key end)
		else
		-- Check in the inactive dwellings
		dwelling = deities.get_inactive_dwelling(faction_key, old_god_key, region_key)
		end

		if dwelling and old_god_key then
			deities.output("Changing dwelling for faction " .. tostring(faction_key) .. " from god " .. old_god_key .. " to god " .. new_god_key)

			local old_building_chain = deities.get_god_dwelling_chain(old_god_key)
			local new_building_chain = deities.get_god_dwelling_chain(new_god_key)
			local old_building_key = cm:get_building_from_building_chain(old_building_chain, 0)
			local new_building_key = cm:get_building_from_building_chain(new_building_chain, 0)

			local slot_index = deities.find_region_slot_index_by_building_key(region_key, old_building_key)
			if slot_index then
				-- Save the old building
				local building = deities.find_building_by_building_chain(region_key, old_building_chain, 0)
				if building then
					-- Save favour for buildings that are converted - they still give favour until the new building is completed, but their building interface is gone and the favour cannot be accessed through it
					if source ~= deities.conversion_sources.create_aten
					and source ~= deities.conversion_sources.cheat then
						local favour = building:get_effect_value(deities.config.favour_effect)
						deities.put_dwelling_under_conversion(faction_key, old_god_key, region_key, favour)
					end
				end
				if source == deities.conversion_sources.settlement_panel then
					--do nothing, construction already handled
				elseif source == deities.conversion_sources.local_deities_panel
					or source == deities.conversion_sources.rededication
				then
					-- cm:queue_building_construction_in_region decrements this index by 1
					-- replace_building_in_region_slot doesn't expend resources
					cm:queue_building_construction_in_region(region_key, slot_index + 1, new_building_key)
				elseif source == deities.conversion_sources.create_aten or source == deities.conversion_sources.cheat then
					-- do not expend resources
					-- cm:replace_building_in_region_slot decrements this index by 1
					cm:replace_building_in_region_slot(region_key, slot_index + 1, new_building_key)
				end

				deities.update_dwelling_favour(faction_key, old_god_key)
				deities.update_dwelling_favour(faction_key, new_god_key)
			end
		else
			deities.output("Could not change dwelling for faction " .. tostring(faction_key) .. " from god " .. tostring(old_god_key) .. " to god " .. new_god_key, 10)
		end
	end,

	get_dwellings_under_conversion = function(faction_key, god_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get dwellings under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local result = is_table(deities.persistent[faction_key].dwellings_under_conversion)
			and table_find(deities.persistent[faction_key].dwellings_under_conversion, function(e) return e.god_key == god_key end)
		if result then
			return result.data
		else
			return nil
		end
	end,

	get_dwelling_under_conversion = function(faction_key, god_key, region_key)
		local dwellings_table = deities.get_dwellings_under_conversion(faction_key, god_key)
		if is_table(dwellings_table) then
			return table_find(dwellings_table, function(e) return e.region_key == region_key end)
		else
			return nil
		end
	end,

	get_dwelling_under_conversion_by_region = function(faction_key, region_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get dwellings under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local dwellings_table = deities.persistent[faction_key].dwellings_under_conversion
		if is_table(dwellings_table) then
			for _, dwellings_per_god in ipairs(dwellings_table) do
				local dwelling = table_find(dwellings_per_god.data, function(e) return e.region_key == region_key end)
				if dwelling then
					return dwelling, dwellings_per_god.god_key
				end
			end
		else
			return nil
		end
	end,

	put_dwelling_under_conversion = function(faction_key, god_key, region_key, favour)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could put dwelling under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local dwellings_under_conversion = deities.get_dwellings_under_conversion(faction_key, god_key)
		-- Add entry for this god if there isn't one
		if not dwellings_under_conversion then
			table.insert(deities.persistent[faction_key].dwellings_under_conversion, table_deep_copy(deities.dwellings_under_conversion_template))
			dwellings_under_conversion = deities.persistent[faction_key].dwellings_under_conversion[#deities.persistent[faction_key].dwellings_under_conversion]
			dwellings_under_conversion.god_key = god_key
			dwellings_under_conversion = dwellings_under_conversion.data
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not put dwelling under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local index = table_find(god_slot.dwelling_regions, function(e) return e == region_key end, true)
		if index then
			-- Effects of this dwelling will still remain active
			table.remove(god_slot.dwelling_regions, index)
			table.insert(dwellings_under_conversion, {region_key = region_key, favour = favour})
		else
			deities.output("Could not find dwelling to put under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " for region " .. region_key, 10)
		end
	end,

	cancel_dwelling_conversion = function(faction_key, god_key, region_key)
		-- Remove from dwellings under conversion
		deities.remove_dwelling(faction_key, god_key, region_key)
		-- Add back as either inactive or completed
		deities.add_dwelling(faction_key, god_key, region_key)
	end,

	update_dwelling_favour = function(faction_key, god_key)
		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not update favour from dwellings for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		--Check if there are dwellings for a god that was not worshipped but now is and transfer them to the god slot
		local inactive_dwelling_regions_table = deities.get_inactive_dwellings(faction_key, god_key)

		if is_table(inactive_dwelling_regions_table) then
			for i = #inactive_dwelling_regions_table, 1, -1 do
				deities.output("Faction " .. tostring(faction_key) .. " now gains favour for god " .. tostring(god_key) .. " from pre-existing dwelling in " .. inactive_dwelling_regions_table[i])
				table.insert(god_slot.dwelling_regions, table_deep_copy(inactive_dwelling_regions_table[i]))
				table.remove(inactive_dwelling_regions_table, i)
			end
		end

		god_slot.favour.dwelling_favour = 0

		local building_chain = deities.get_god_dwelling_chain(god_key)

		for _, dwelling_region in ipairs(god_slot.dwelling_regions) do
			local building = deities.find_building_by_building_chain(dwelling_region, building_chain, 0)
			if building then
				local favour = building:get_effect_value(deities.config.favour_effect)
				god_slot.favour.dwelling_favour = god_slot.favour.dwelling_favour + favour
			end
		end

		-- Add favour from dwellings under conversion
		local dwellings_under_conversion = deities.get_dwellings_under_conversion(faction_key, god_key)
		if is_table(dwellings_under_conversion) then
			for _, dwelling in ipairs(dwellings_under_conversion) do
				god_slot.favour.dwelling_favour = god_slot.favour.dwelling_favour + dwelling.favour
			end
		end

		deities.output("dwelling favour for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " is now " .. god_slot.favour.dwelling_favour)
		deities.update_total_favour(faction_key, god_key)
		return god_slot.favour.dwelling_favour
	end,

--------------------------------------------------------------
--------------------TEMPLES-----------------------------------
--------------------------------------------------------------

	add_or_upgrade_temple = function(faction_key, god_key, region_key, level)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		--Check if we converted from an inactive god
		local temple = deities.get_inactive_temple_in_region(faction_key, region_key)
		if temple then
			local bonus_value_foreign_temple_converted_gold = cm:get_factions_bonus_value(faction_key, deities.config.bonus_value_foreign_temple_converted_gold)
			if bonus_value_foreign_temple_converted_gold > 0 then
				local resource_cost_object = cm:create_new_custom_resource_cost()
				resource_cost_object:add_resource_cost("troy_gold", deities.config.resource_factor_gold_from_foreign_convesion, bonus_value_foreign_temple_converted_gold)
				resource_cost_object:multiply_by(temple.data[1].level + 1)
				local faction = cm:get_faction(faction_key)
				cm:faction_apply_resource_transaction(faction, resource_cost_object)
			end
		end

		-- When a temple is converted from another one from the province panel we don't receive a BuildingDemolished event to remove it, so we need to remove it manually
		-- Favour from the replaced temple stays until the new building is completed
		local converted_temple, converted_god = deities.get_temple_under_conversion_by_region(faction_key, region_key)
		if converted_temple then
			deities.send_temple_converted_event_message(faction_key, god_key, region_key, level)
			deities.remove_temple(faction_key, converted_god, converted_temple.region_key)
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			-- save the temple in inactive_temples so it may be used if the faction starts worshipping its god
			local temple = { region_key = region_key, level = level }
			deities.add_inactive_temple(faction_key, god_key, temple)
			return
		end

		local temple = table_find(god_slot.temples, function(e) return e.region_key == region_key end)
		if temple then
			temple.level = level
			deities.output("Temple in faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. "is now level " .. temple.level)
		else
			table.insert(god_slot.temples, { region_key = region_key, level = level })
			local event_data =
			{
				faction_key = faction_key,
				god_key = god_key,
				count = #god_slot.temples
			}
			core:trigger_event("ScriptEventTempleCountChanged", event_data)
			deities.output("Temple added to faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
		end
		deities.update_temple_favour(faction_key, god_key)
	end,

	remove_temple = function(faction_key, god_key, region_key)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			--remove from inactive temples list - completed temples of gods that are not worshipped
			local inactive_temples_table = deities.get_inactive_temples(faction_key, god_key)
			if inactive_temples_table then
				local index = table_find(inactive_temples_table, function(e) return e.region_key == region_key end, true)
				if index then
					table.remove(inactive_temples_table, index)
					deities.output("Inactive temple removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
					return
				end
			end
		end

		local index = god_slot and table_find(god_slot.temples, function(e) return e.region_key == region_key end, true)
		if index then
			table.remove(god_slot.temples, index)
			local event_data =
			{
				faction_key = faction_key,
				god_key = god_key,
				count = #god_slot.temples
			}
			core:trigger_event("ScriptEventTempleCountChanged", event_data)
			deities.output("Temple removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
			deities.update_temple_favour(faction_key, god_key)
		else
			local temples_under_conversion = deities.get_temples_under_conversion(faction_key, god_key)
			if is_table(temples_under_conversion) then
				index = table_find(temples_under_conversion, function(e) return e.region_key == region_key end, true)
				if index then
					table.remove(temples_under_conversion, index)
					deities.output("Temple under conversion removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
					deities.update_temple_favour(faction_key, god_key)
				end
			end
		end
	end,

	send_temple_converted_event_message = function(faction_key, god_key, region_key, level)
		local temple_string = "ui_text_replacements_localised_text_" .. deities.text_ids.event_message_ids.temple
		local temple_chain = deities.get_god_temple_chain(god_key)
		local temple_slot = region_key .. ":" .. deities.find_building_by_building_chain(region_key, temple_chain, level, true)
		local god_name_loc_key = deities.get_localised_text(god_key).name_source
		deities.add_deities_event_message("local_deity_temples_shrines_rededicated", faction_key, 0, temple_slot, temple_string, god_name_loc_key)
	end,

	find_and_change_temple_god = function(faction_key, new_god_key, region_key)
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slots = deities.get_god_slots(faction_key)
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			if god_slots[i].god_key then
				local index = table_find(god_slots[i].temples, function(e) return e.region_key == region_key end, true)
				if index then
					deities.change_temple_god(faction_key, region_key, god_slots[i].god_key, new_god_key, deities.conversion_sources.settlement_panel)
					break
				end
			end
		end
	end,

	get_temple_level = function(faction_key, region_key)
		if not is_table(deities.persistent[faction_key]) then
			return -1
		end

		local god_slots = deities.get_god_slots(faction_key)
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			if god_slots[i].god_key then
				local temple = table_find(god_slots[i].temples, function(e) return e.region_key == region_key end)
				if temple then
					return temple.level
				end
			end
		end

		return -1
	end,

	-- Queues a temple of the new god for construction in place of the old temple
	change_temple_god = function(faction_key, region_key, old_god_key, new_god_key, source)
		local old_god_slot = deities.get_god_slot(faction_key, old_god_key)

		local temple
		if old_god_slot then
			temple = table_find(old_god_slot.temples, function(e) return e.region_key == region_key end)
		else
		-- Check in the inactive temples
			temple = deities.get_inactive_temple(faction_key, old_god_key, region_key)
		end

		if temple and old_god_key then
			deities.output("Changing temple for faction " .. tostring(faction_key) .. " from god " .. old_god_key .. " to god " .. new_god_key)

			local old_building_chain = deities.get_god_temple_chain(old_god_key)
			local new_building_chain = deities.get_god_temple_chain(new_god_key)
			local old_building_key = cm:get_building_from_building_chain(old_building_chain, temple.level)
			local new_building_key = cm:get_building_from_building_chain(new_building_chain, temple.level)

			local slot_index = deities.find_region_slot_index_by_building_key(region_key, old_building_key)
			if slot_index then
				-- Save the old building
				local building = deities.find_building_by_building_chain(region_key, old_building_chain, temple.level)
				if building then
					-- Save favour for buildings that are converted - they still give favour until the new building is completed, but their building interface is gone and the favour cannot be accessed through it
					if source ~= deities.conversion_sources.create_aten
					and source ~= deities.conversion_sources.cheat then
						local favour = building:get_effect_value(deities.config.favour_effect)
						deities.put_temple_under_conversion(faction_key, old_god_key, region_key, favour, temple.level)
					end
				end
				if source == deities.conversion_sources.settlement_panel then
					--do nothing, construction already handled
				elseif source == deities.conversion_sources.local_deities_panel
					or source == deities.conversion_sources.rededication
				then
					-- cm:queue_building_construction_in_region decrements this index by 1
					-- replace_building_in_region_slot doesn't expend resources
					cm:queue_building_construction_in_region(region_key, slot_index + 1, new_building_key)
				elseif source == deities.conversion_sources.create_aten or source == deities.conversion_sources.cheat then
					-- do not expend resources
					-- cm:replace_building_in_region_slot decrements this index by 1
					cm:replace_building_in_region_slot(region_key, slot_index + 1, new_building_key)
				end

				deities.update_temple_favour(faction_key, old_god_key)
				deities.update_temple_favour(faction_key, new_god_key)
			end
		else
			deities.output("Could not change temple for faction " .. tostring(faction_key) .. " from god " .. tostring(old_god_key) .. " to god " .. new_god_key, 10)
		end
	end,

	get_temples_under_conversion = function(faction_key, god_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get temples under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local result = is_table(deities.persistent[faction_key].temples_under_conversion)
			and table_find(deities.persistent[faction_key].temples_under_conversion, function(e) return e.god_key == god_key end)
		if result then
			return result.data
		else
			return nil
		end
	end,

	get_temple_under_conversion = function(faction_key, god_key, region_key)
		local temples_table = deities.get_temples_under_conversion(faction_key, god_key)
		if is_table(temples_table) then
			return table_find(temples_table, function(e) return e.region_key == region_key end)
		else
			return nil
		end
	end,

	get_temple_under_conversion_by_region = function(faction_key, region_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get temples under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local temples_table = deities.persistent[faction_key].temples_under_conversion
		if is_table(temples_table) then
			for _, temples_per_god in ipairs(temples_table) do
				local temple = table_find(temples_per_god.data, function(e) return e.region_key == region_key end)
				if temple then
					return temple, temples_per_god.god_key
				end
			end
		else
			return nil
		end
	end,

	put_temple_under_conversion = function(faction_key, god_key, region_key, favour, level)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not put temple under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local temples_under_conversion_table = deities.get_temples_under_conversion(faction_key, god_key)
		-- Add entry for this god if there isn't one
		if not temples_under_conversion_table  then
			table.insert(deities.persistent[faction_key].temples_under_conversion, table_deep_copy(deities.temples_under_conversion_template))
			temples_under_conversion_table = deities.persistent[faction_key].temples_under_conversion[#deities.persistent[faction_key].temples_under_conversion]
			temples_under_conversion_table.god_key = god_key
			temples_under_conversion_table = temples_under_conversion_table.data
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not put temple under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local index = table_find(god_slot.temples, function(e) return e.region_key == region_key end, true)
		if index then
			-- Effects of this temple will still remain active
			table.remove(god_slot.temples, index)
			local event_data =
			{
				faction_key = faction_key,
				god_key = god_key,
				count = #god_slot.temples
			}
			core:trigger_event("ScriptEventTempleCountChanged", event_data)
			table.insert(temples_under_conversion_table, {region_key = region_key, favour = favour, level = level})
		else
			deities.output("Could not find temple to put under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " for region " .. region_key, 10)
		end
	end,

	cancel_temple_conversion = function(faction_key, god_key, region_key)
		local temple_under_conversion = deities.get_temple_under_conversion(faction_key, god_key, region_key)
		if not temple_under_conversion then
			deities.output("Could not find temple under conversion for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " for region " .. region_key, 10)
			return
		end
		-- Remove from temples under conversion
		deities.remove_temple(faction_key, god_key, region_key)
		-- Add back as either inactive or completed
		deities.add_or_upgrade_temple(faction_key, god_key, region_key, temple_under_conversion.level)
	end,

	update_temple_favour = function(faction_key, god_key)
		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not update favour from temples for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		god_slot.favour.temple_favour =  0

		--Check if there are temples for a god that was not worshipped but now is and transfer them to the god slot
		local inactive_temples_table = deities.get_inactive_temples(faction_key, god_key)

		if is_table(inactive_temples_table) then
			for i = #inactive_temples_table, 1, -1 do
				deities.output("Faction " .. tostring(faction_key) .. " now gains favour for god " .. tostring(god_key) .. " from pre-existing temple in " .. inactive_temples_table[i].region_key)
				table.insert(god_slot.temples, table_deep_copy(inactive_temples_table[i]))
				local event_data =
				{
					faction_key = faction_key,
					god_key = god_key,
					count = #god_slot.temples
				}
				core:trigger_event("ScriptEventTempleCountChanged", event_data)
				table.remove(inactive_temples_table, i)
			end
		end

		local building_chain = deities.get_god_temple_chain(god_key)

		for temple, temple_data in ipairs(god_slot.temples) do
			local building = deities.find_building_by_building_chain(temple_data.region_key, building_chain, temple_data.level)
			if building then
				local favour = building:get_effect_value(deities.config.favour_effect)
				god_slot.favour.temple_favour = god_slot.favour.temple_favour + favour
			end
		end

		-- Add favour from temples under conversion
		local temples_under_conversion = deities.get_temples_under_conversion(faction_key, god_key)
		if is_table(temples_under_conversion) then
			for _, temple in ipairs(temples_under_conversion) do
				god_slot.favour.temple_favour = god_slot.favour.temple_favour + temple.favour
			end
		end

		deities.output("Temple favour for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " is now " .. god_slot.favour.temple_favour)
		deities.update_total_favour(faction_key, god_key)
		return god_slot.favour.temple_favour
	end,

	get_inactive_temples = function(faction_key, god_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get inactive temples for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local result = table_find(deities.persistent[faction_key].inactive_temples, function(e) return e.god_key == god_key end)
		if result then
			return result.data
		else
			return nil
		end
	end,

	get_inactive_temple_in_region = function(faction_key, region_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get inactive temples for faction " .. tostring(faction_key) .. " for region " .. tostring(region_key), 10)
			return
		end

		return table_find(deities.persistent[faction_key].inactive_temples,
			function(inactive_temple)
				return table_find(inactive_temple.data,
					function(inactive_temple_data)
						return inactive_temple_data.region_key == region_key
					end)
			end)
	end,

	get_inactive_temple = function(faction_key, god_key, region_key)
		local inactive_temples_table = deities.get_inactive_temples(faction_key, god_key)
		return table_find(inactive_temples_table, function(e) return e.region_key == region_key end)
	end,

	add_inactive_temple = function(faction_key, god_key, temple_data)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not add inactive temples for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local inactive_temples_table = deities.get_inactive_temples(faction_key, god_key)
		-- Add entry for this god if there isn't one
		if not inactive_temples_table then
			table.insert(deities.persistent[faction_key].inactive_temples, table_deep_copy(deities.inactive_building_template))
			inactive_temples_table = deities.persistent[faction_key].inactive_temples[#deities.persistent[faction_key].inactive_temples]
			inactive_temples_table.god_key = god_key
			inactive_temples_table = inactive_temples_table.data
		end

		table.insert(inactive_temples_table, temple_data)
	end,

	get_inactive_shrines = function(faction_key, god_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get inactive shrines for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local result = table_find(deities.persistent[faction_key].inactive_shrine_regions, function(e) return e.god_key == god_key end)
		if result then
			return result.data
		else
			return nil
		end
	end,

	get_inactive_shrine_in_region = function(faction_key, region_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get inactive shrines for faction " .. tostring(faction_key) .. " for region " .. tostring(region_key), 10)
			return
		end

		return table_find(deities.persistent[faction_key].inactive_shrine_regions, function(e) return table_find(e.data, region_key) end)
	end,

	get_inactive_shrine = function(faction_key, god_key, region_key)
		local inactive_shrines_table = deities.get_inactive_shrines(faction_key, god_key)
		return table_find(inactive_shrines_table, region_key)
	end,

	add_inactive_shrine = function(faction_key, god_key, shrine_region_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not add inactive shrines for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local inactive_shrines_table = deities.get_inactive_shrines(faction_key, god_key)
		-- Add entry for this god if there isn't one
		if not inactive_shrines_table  then
			table.insert(deities.persistent[faction_key].inactive_shrine_regions, table_deep_copy(deities.inactive_building_template))
			inactive_shrines_table = deities.persistent[faction_key].inactive_shrine_regions[#deities.persistent[faction_key].inactive_shrine_regions]
			inactive_shrines_table.god_key = god_key
			inactive_shrines_table = inactive_shrines_table.data
		end

		table.insert(inactive_shrines_table, shrine_region_key)
	end,

	get_inactive_dwellings = function(faction_key, god_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get inactive dwellings for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local result = table_find(deities.persistent[faction_key].inactive_dwelling_regions, function(e) return e.god_key == god_key end)
		if result then
			return result.data
		else
			return nil
		end
	end,

	get_inactive_dwelling_in_region = function(faction_key, region_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get inactive dwellings for faction " .. tostring(faction_key) .. " for region " .. tostring(region_key), 10)
			return
		end

		return table_find(deities.persistent[faction_key].inactive_dwelling_regions, function(e) return table_find(e.data, region_key) end)
	end,

	get_inactive_dwelling = function(faction_key, god_key, region_key)
		local inactive_dwellings_table = deities.get_inactive_dwellings(faction_key, god_key)
		return table_find(inactive_dwellings_table, region_key)
	end,

	add_inactive_dwelling = function(faction_key, god_key, dwelling_region_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not add inactive dwellings for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local inactive_dwellings_table = deities.get_inactive_dwellings(faction_key, god_key)
		-- Add entry for this god if there isn't one
		if not inactive_dwellings_table  then
			table.insert(deities.persistent[faction_key].inactive_dwelling_regions, table_deep_copy(deities.inactive_building_template))
			inactive_dwellings_table = deities.persistent[faction_key].inactive_dwelling_regions[#deities.persistent[faction_key].inactive_dwelling_regions]
			inactive_dwellings_table.god_key = god_key
			inactive_dwellings_table = inactive_dwellings_table.data
		end

		table.insert(inactive_dwellings_table, dwelling_region_key)
	end,

	find_region_slot_index_by_building_key = function(region_key, building_key)
		local region = cm:get_region(region_key)
		if not region or region:is_null_interface() then
			deities.output("Could not find region " .. region_key, 10)
			return nil
		end

		local region_slots = region:slot_list()
		for i=0, region_slots:num_items() - 1 do
			local slot = region_slots:item_at(i)
			local building = slot:building()
			if building and not building:is_null_interface() and building:name() == building_key then
				return i
			end
		end

		deities.output("Could not find building " .. building_key .. " in region " .. region_key, 10)
		return nil
	end,

	find_force_slot_index_by_building_key = function(force_cqi, building_key)
		local force = cm:get_military_force_by_cqi(force_cqi)
		if not force or force:is_null_interface() then
			deities.output("Could not find military force with cqi " .. tostring(force_cqi), 10)
			return nil
		end

		local force_buildings = force:buildings()
		if not force_buildings then
			return nil
		end

		local last_building_index = force_buildings:num_items() - 1
		for i = 0, last_building_index do
			local force_building = force_buildings:item_at(i)
			if force_building:name() == building_key then
				return i
			end
		end

		deities.output("Could not find building " .. building_key .. " of force with cqi " .. tostring(force_cqi), 10)
		return nil
	end,

	find_building_by_building_chain = function(region_key, building_chain, level, return_slot_index)
		local building_key = cm:get_building_from_building_chain(building_chain, level)
		local region = cm:get_region(region_key)
		if not region or region:is_null_interface() then
			deities.output("Could not find region " .. region_key, 10)
			return nil
		end

		local region_slots = region:slot_list()
		for i=0, region_slots:num_items() - 1 do
			local slot = region_slots:item_at(i)
			local building = slot:building()
			if building and not building:is_null_interface() and building:name() == building_key then
				if return_slot_index then
					return i
				end
				return building
			end
		end

		deities.output("Could not find building " .. tostring(building_key) .. " in region " .. tostring(region_key), 10)
		return nil
	end,

	find_force_building_by_building_chain = function(force_cqi, building_chain, level, return_slot_index)
		local force = cm:get_military_force_by_cqi(force_cqi)
		if not force or force:is_null_interface() then
			deities.output("Could not find military force with cqi " .. tostring(force_cqi), 10)
			return nil
		end

		local building_key = cm:get_building_from_building_chain(building_chain, level)
		local force_buildings = force:buildings()
		if not force_buildings then
			deities.output("ERROR: Could not find building " .. building_key .. " of force with cqi " .. tostring(force_cqi) .. ", it has no buildings at all", 100)
			return
		end
		local last_building_index = force_buildings:num_items() - 1
		for i = 0, last_building_index do
			local force_building = force_buildings:item_at(i)
			if force_building:name() == building_key then
				if return_slot_index then
					return i
				end
				return force_building
			end
		end

		deities.output("Could not find building " .. building_key .. " of force with cqi " .. tostring(force_cqi), 10)
		return nil
	end,

	-- unused
	find_force_building_by_building_key = function(force, building_key, return_slot_index)
		local force_buildings = force:buildings()
		if not force_buildings then
			return nil
		end
		local last_building_index = force_buildings:num_items() - 1
		for i = 0, last_building_index do
			local force_building = force_buildings:item_at(i)
			if force_building:name() == building_key then
				if return_slot_index then
					return i
				end
				return force_building
			end
		end
	end,

	get_building_slots_with_ongoing_contruction = function(faction_key)
		local faction = cm:get_faction(faction_key)
		local slots_table = {}

		if not faction then
			return slots_table
		end
		local region_list = faction:region_list()
		for i = 0, region_list:num_items() - 1 do
			local region = region_list:item_at(i)
			local slot_list = region:slot_list()
			for slot_index = 0, slot_list:num_items() - 1 do
				local slot = slot_list:item_at(slot_index)
				if slot:is_there_construction() then
					table.insert(slots_table, {slot = slot, index = slot_index})
				end
			end
		end
		return slots_table
	end,

	find_region_slot_index_by_shrine_god_key = function(region_key, god_key)
		local building_key = cm:get_building_from_building_chain(deities.get_god_shrine_chain(god_key), 0)
		return deities.find_region_slot_index_by_building_key(region_key, building_key)
	end,

	set_religious_buildings_chain_restriction = function(faction_key, god_key, should_restrict)
		local faction = cm:get_faction(faction_key)
		if not faction or faction:is_null_interface() or not faction:is_pharaoh_game_faction() then
			return
		end

		local restrictable_building_chains = {}

		local temple_chain = deities.get_god_temple_chain(god_key)
		if is_string(temple_chain) and temple_chain ~= "" then
			table.insert(restrictable_building_chains, temple_chain)
		end

		local shrine_chain = deities.get_god_shrine_chain(god_key)
		if is_string(shrine_chain) and shrine_chain ~= "" then
			table.insert(restrictable_building_chains, shrine_chain)
		end

		local dwelling_chain = deities.get_god_dwelling_chain(god_key)
		if is_string(dwelling_chain) and dwelling_chain ~= "" then
			table.insert(restrictable_building_chains, dwelling_chain)
		end

		local idol_chain = deities.get_god_idol_chain(god_key)
		if is_string(idol_chain) and idol_chain ~= "" then
			table.insert(restrictable_building_chains, idol_chain)
		end

		cm:restrict_building_chains_for_faction_with_manual_conversion(faction_key, restrictable_building_chains, should_restrict)
	end,

	set_all_religious_buildings_chain_restrictions = function(factions_list)
		deities.all_religious_buildings_chains = {}
		for _, god_data in ipairs(deities.gods) do
			table.insert(deities.all_religious_buildings_chains, god_data.temple_chain)
			table.insert(deities.all_religious_buildings_chains, god_data.shrine_chain)
			if god_data.dwelling_chain then
				table.insert(deities.all_religious_buildings_chains, god_data.dwelling_chain)
			end
			if god_data.idol_chain then
				table.insert(deities.all_religious_buildings_chains, god_data.idol_chain)
			end
		end

		for i=0, factions_list:num_items() -1 do
			local curr_faction = factions_list:item_at(i)
			local curr_faction_name = curr_faction:name()
			if curr_faction:is_pharaoh_game_faction() then
				cm:restrict_building_chains_for_faction_with_manual_conversion(curr_faction_name, deities.all_religious_buildings_chains, true)
				local worshipped_gods_buildings = {}
				if deities.persistent[curr_faction_name] then
					local god_slots = deities.get_god_slots(curr_faction_name)
					local god_slots_count = deities.get_faction_god_slots_count(curr_faction_name)
					for i = 1, god_slots_count do
						local god_key = god_slots[i].god_key
						-- if god is worshipped
						if god_key then
							local temple_chain = deities.get_god(god_key).temple_chain
							if temple_chain then
								table.insert(worshipped_gods_buildings, temple_chain)
							end

							local shrine_chain = deities.get_god(god_key).shrine_chain
							if shrine_chain then
								table.insert(worshipped_gods_buildings, shrine_chain)
							end

							local dwelling_chain = deities.get_god(god_key).dwelling_chain
							if dwelling_chain then
								table.insert(worshipped_gods_buildings, dwelling_chain)
							end

							local idol_chain = deities.get_god(god_key).idol_chain
							if is_string(idol_chain) and idol_chain ~= "" then
								table.insert(worshipped_gods_buildings, idol_chain)
						end
						end
					end
				else
					deities.output("Error:" .. curr_faction_name .. " does not have a persistent table with god slots!")
				end
				cm:restrict_building_chains_for_faction_with_manual_conversion(curr_faction_name, worshipped_gods_buildings, false)
			end
		end
	end,

	set_aten_cult_centre_chain_restrictions = function(faction_key)
		local cult_centre_chains = {}
		for _, god_data in ipairs(deities.gods) do
			if god_data.key ~= deities.config.aten_god_key and god_data.cult_centre_chain ~= "" then
				table.insert(cult_centre_chains, god_data.cult_centre_chain)
			end
		end

		cm:restrict_building_chains_for_faction_with_manual_conversion(faction_key, cult_centre_chains, true)
	end,

	set_aten_cult_centre_occupation_restrictions = function()
		local aten = deities.get_god(deities.config.aten_god_key)
		if not aten then
			return
		end

		local region = cm:get_region(aten.cult_centre_region_key)
		if not region or region:is_null_interface() then
			deities.output("Could not find Aten's cult centre region!", 10)
			return
		end

		cm:set_script_state(region, "akhenaten_special_occupation_options", true)
	end,


--------------------------------------------------------------
---------------------------IDOLS------------------------------
--------------------------------------------------------------

	is_sea_god = function(god_key)
		local sea_culture_key = deities.config.cultures[4]
		return table_find(deities.gods, function(e) return e.key == god_key and e.culture == sea_culture_key end) ~= nil
	end,

	faction_has_access_to_idols = function(faction_key)
		local sea_peoples_culture_key = deities.config.cultures[4]
		local faction_culture = cm:get_faction(faction_key):culture()

		return faction_culture == sea_peoples_culture_key and not deities.has_faction_claimed_akhenaten(faction_key)
	end,


	add_or_upgrade_idol = function(faction_key, god_key, force_cqi, level)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		-- When an idol is converted from another one from the province panel we don't receive a CharacterMilitaryForceBuildingDemolished event to remove it, so we need to remove it manually
		-- Favour from the replaced idol stays until the new building is completed
		local converted_idol, converted_god = deities.get_idol_under_conversion_by_force(faction_key, force_cqi)
		if converted_idol then
			deities.send_idol_converted_event_message(faction_key, god_key, force_cqi, level)
			deities.remove_idol(faction_key, converted_god, converted_idol.force_cqi)
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			-- save the idol in inactive_idols so it may be used if the faction starts worshipping its god
			local idol_data = {
				force_cqi = force_cqi,
				level = level
			}
			deities.add_inactive_idol(faction_key, god_key, idol_data)
			return
		end

		local idol = table_find(god_slot.idols, function(e) return e.force_cqi == force_cqi end)
		if idol then
			idol.level = level
			deities.output("Idol in faction " .. faction_key .. " for god " .. god_key .. " is now at level " .. idol.level)
		else
			table.insert(god_slot.idols, { force_cqi = force_cqi, level = level })
			deities.output("Idol added to faction " .. faction_key .. " for force with cqi " .. tostring(force_cqi) .. ", for god " .. god_key)
		end
		deities.update_idol_favour(faction_key, god_key)

		-- apply effects from new idol to army
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return
		end

		local force = cm:get_military_force_by_cqi(force_cqi)
		if not force or force:is_null_interface() then
			deities.output("Error: Invalid force cqi " .. tostring(force_cqi), 10)
			return
		end

		local tier = deities.get_tier(faction_key, god_key)
		local new_idol_effect_bundles = tiers[tier].idol_effect_bundles
		if not new_idol_effect_bundles then
			return
		end

		local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_idols_bundle or nil
		local combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(new_idol_effect_bundles, init_bundle)
		if combined_custom_effect_bundle then
			cm:apply_custom_effect_bundle_to_force(combined_custom_effect_bundle, force)
			deities.output("Applying idol effect from god " .. god_key .. " for force with cqi " .. tostring(force_cqi))
		end
	end,

	-- remove idol instances from inactive_idols, idols_under_conversion or god_slot.idols where applicable
	-- and remove its applied effects if applicable
	remove_idol = function(faction_key, god_key, force_cqi)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			local inactive_idols_table = deities.get_inactive_idols(faction_key, god_key)
			if inactive_idols_table then
				local index = table_find(inactive_idols_table, function(e) return e.force_cqi == force_cqi end, true)
				if index then
					table.remove(inactive_idols_table, index)
					deities.output("Inactive idol removed from faction " .. faction_key .. " for god " .. god_key)
					return
				end
			end
		end

		-- remove idol effects
		local current_tier = deities.get_tier(faction_key, god_key)
		if current_tier ~= -1 then
			deities.remove_idol_effects_for_tier(faction_key, god_key, force_cqi, current_tier)
		else
			-- Removing an idol under conversion from a god that is no longer worshipped:
			-- Try to remove effects from all tiers since we do not keep favour and tiers of such gods
			for i = 1, #deities.config.favour_tiers do
				deities.remove_idol_effects_for_tier(faction_key, god_key, force_cqi, i)
			end
		end

		local index = god_slot and table_find(god_slot.idols, function(e) return e.force_cqi == force_cqi end, true)
		if index then
			table.remove(god_slot.idols, index)
			deities.output("Idol removed from faction " .. faction_key .. " for god " .. god_key)
			deities.update_idol_favour(faction_key, god_key)
		else
			local idols_under_conversion = deities.get_idols_under_conversion(faction_key, god_key)
			if is_table(idols_under_conversion) then
				index = table_find(idols_under_conversion, function(e) return e.force_cqi == force_cqi end, true)
				if index then
					table.remove(idols_under_conversion, index)
					deities.output("Idol under conversion removed from faction " .. faction_key .. " for god " .. god_key)
					deities.update_idol_favour(faction_key, god_key)
				end
			end
		end
	end,

	remove_idol_effects_for_tier = function(faction_key, god_key, force_cqi, tier)
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) or tier > #tiers then
			return
		end

		local idol_effect_bundles = tiers[tier].idol_effect_bundles
		-- the custom effect bundle for Aten's idol has a special key
		if god_key == deities.config.aten_god_key then
			idol_effect_bundles =
			{
				{
					bundle = deities.config.aten_idols_bundle
				}
			}
		end

		if not idol_effect_bundles then
			return
		end

		local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_idols_bundle or nil
		local combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(idol_effect_bundles, init_bundle)
		if combined_custom_effect_bundle then
			cm:remove_effect_bundle_from_force(combined_custom_effect_bundle:key(), force_cqi)
			deities.output("Removing idol effects from god " .. god_key .. " for force with cqi " .. tostring(force_cqi))
		end
	end,

	send_idol_converted_event_message = function(faction_key, god_key, force_cqi, level)
		local idol_string = "ui_text_replacements_localised_text_" .. deities.text_ids.event_message_ids.idol
		local idol_chain = deities.get_god_idol_chain(god_key)
		local idol_slot = deities.find_force_building_by_building_chain(force_cqi, idol_chain, level, true)
		local god_name_loc_key = deities.get_localised_text(god_key).name_source
		cm:add_event_feed_event("local_deity_idols_rededicated", faction_key, 0, tostring(idol_slot), idol_string, god_name_loc_key, force_cqi)
	end,

	find_and_change_idol_god = function(faction_key, new_god_key, force_cqi)
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slots = deities.get_god_slots(faction_key)
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			if god_slots[i].god_key then
				local index = table_find(god_slots[i].idols, function(e) return e.force_cqi == force_cqi end, true)
				if index then
					deities.change_idol_god(faction_key, force_cqi, god_slots[i].god_key, new_god_key, deities.conversion_sources.settlement_panel)
					break
				end
			end
		end
	end,

	get_idol_level = function(faction_key, force_cqi)
		if not is_table(deities.persistent[faction_key]) then
			return -1
		end

		local god_slots = deities.get_god_slots(faction_key)
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			if god_slots[i].god_key then
				local idol = table_find(god_slots[i].idols, function(e) return e.force_cqi == force_cqi end)
				if idol then
					return idol.level
				end
			end
		end

		return -1
	end,

	-- Queues an idol of the new god for construction in place of the old idol
	change_idol_god = function(faction_key, force_cqi, old_god_key, new_god_key, source)
		local old_god_slot = deities.get_god_slot(faction_key, old_god_key)

		local idol
		if old_god_slot then
			idol = table_find(old_god_slot.idols, function(e) return e.force_cqi == force_cqi end)
		else
			-- Check in the inactive idols
			idol = deities.get_inactive_idol(faction_key, old_god_key, force_cqi)
		end

		local new_building_chain = deities.get_god_idol_chain(new_god_key)
		if not is_string(new_building_chain) or new_building_chain == ""  then
			deities.output("Could not change idol for faction " .. faction_key .. ", force with cqi " .. tostring(force_cqi) .. " from god " .. old_god_key .. " to god " .. new_god_key, 10)
			return
		end

		if idol and old_god_key then
			deities.output("Changing idol for faction " .. faction_key .. " for force with cqi: " .. tostring(force_cqi) .. " from god " .. old_god_key .. " to god " .. new_god_key)

			local old_building_chain = deities.get_god_idol_chain(old_god_key)
			local old_building_key = cm:get_building_from_building_chain(old_building_chain, idol.level)
			local new_building_key = cm:get_building_from_building_chain(new_building_chain, idol.level)

			local slot_index = deities.find_force_slot_index_by_building_key(force_cqi, old_building_key)
			if slot_index then
				-- Save the old building
				local building = deities.find_force_building_by_building_chain(force_cqi, old_building_chain, idol.level)
				if building then
					-- Save favour for buildings that are converted - they still give favour until the new building is completed, but their building interface is gone and the favour cannot be accessed through it
					if source ~= deities.conversion_sources.create_aten and source ~= deities.conversion_sources.cheat then
						local favour = building:get_effect_value(deities.config.favour_effect)
						deities.put_idol_under_conversion(faction_key, old_god_key, force_cqi, favour, idol.level)
					end
				end
				if source == deities.conversion_sources.settlement_panel then
					--do nothing, construction already handled
				elseif source == deities.conversion_sources.local_deities_panel
					or source == deities.conversion_sources.rededication
				then
					-- queue_building_construction_in_force here does not expend resources
					cm:queue_building_construction_in_force(force_cqi, slot_index + 1, new_building_key)
				elseif source == deities.conversion_sources.create_aten or source == deities.conversion_sources.cheat then
					-- cm:replace_building_in_force_slot does not expend resources
					cm:replace_building_in_force_slot(force_cqi, slot_index + 1, new_building_key, false)
					-- in this special case we have to manually add and remove the idol as cm:replace_building_in_force_slot will not trigger the construction/demolition listeners
					deities.remove_idol(faction_key, old_god_key, force_cqi)
					deities.add_or_upgrade_idol(faction_key, deities.config.aten_god_key, force_cqi, idol.level)
				end

				deities.update_idol_favour(faction_key, old_god_key)
				deities.update_idol_favour(faction_key, new_god_key)
			end
		else
			deities.output("Could not change idol for faction " .. faction_key .. ", force with cqi " .. tostring(force_cqi) .. " from god " .. old_god_key .. " to god " .. new_god_key, 10)
		end
	end,

	get_idols_under_conversion = function(faction_key, god_key)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get idols under conversion for faction " .. faction_key .. " for god " .. god_key, 10)
			return
		end

		local result = is_table(deities.persistent[faction_key].idols_under_conversion)
			and table_find(deities.persistent[faction_key].idols_under_conversion, function(e) return e.god_key == god_key end)
		return result and result.data or nil
	end,

	get_idol_under_conversion = function(faction_key, god_key, force_cqi)
		local idols_table = deities.get_idols_under_conversion(faction_key, god_key)
		return is_table(idols_table) and table_find(idols_table, function(e) return e.force_cqi == force_cqi end) or nil
	end,

	get_idol_under_conversion_by_force = function(faction_key, force_cqi)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get idols under conversion for faction " .. faction_key .. " for god " .. god_key, 10)
			return
		end

		local idols_table = deities.persistent[faction_key].idols_under_conversion
		if is_table(idols_table) then
			for _, idols_per_god in ipairs(idols_table) do
				local idol = table_find(idols_per_god.data, function(e) return e.force_cqi == force_cqi end)
				if idol then
					return idol, idols_per_god.god_key
				end
			end
		else
			return nil
		end
	end,

	put_idol_under_conversion = function(faction_key, god_key, force_cqi, favour, level)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not put idol under conversion for faction " .. faction_key .. " for god " .. god_key, 10)
			return
		end

		local idols_under_conversion_table = deities.get_idols_under_conversion(faction_key, god_key)
		-- Add entry for this god if there isn't one
		if not idols_under_conversion_table then
			table.insert(deities.persistent[faction_key].idols_under_conversion, table_deep_copy(deities.idols_under_conversion_template))
			idols_under_conversion_table = deities.persistent[faction_key].idols_under_conversion[#deities.persistent[faction_key].idols_under_conversion]
			idols_under_conversion_table.god_key = god_key
			idols_under_conversion_table = idols_under_conversion_table.data
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not put idol under conversion for faction " .. faction_key .. " for god " .. god_key, 10)
			return
		end

		local index = table_find(god_slot.idols, function(e) return e.force_cqi == force_cqi end, true)
		if index then
			-- effects of this idol will still remain active
			table.remove(god_slot.idols, index)
			table.insert(idols_under_conversion_table, {force_cqi = force_cqi, favour = favour, level = level})
		else
			deities.output("Could not find idol to put under conversion for faction " .. faction_key .. " for god " .. god_key .. " for force with cqi " .. force_cqi, 10)
		end
	end,

	cancel_idol_conversion = function(faction_key, force_cqi)
		local idol_under_conversion, god_key = deities.get_idol_under_conversion_by_force(faction_key, force_cqi)
		if not idol_under_conversion or not god_key then
			return-- this can happen if we instructed the cancelation of a building whom construction was just instructed
		end

		-- Remove from idols under conversion
		deities.remove_idol(faction_key, god_key, force_cqi)
		-- Add back as either inactive or completed
		deities.add_or_upgrade_idol(faction_key, god_key, force_cqi, idol_under_conversion.level)
	end,

	update_idol_favour = function(faction_key, god_key)
		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not update favour from idols for faction " .. faction_key .. " for god " .. god_key, 10)
			return
		end

		god_slot.favour.idol_favour =  0

		-- Check if there are idols for a god that was not worshipped and transfer them to the god slot
		local inactive_idols_table = deities.get_inactive_idols(faction_key, god_key)
		if is_table(inactive_idols_table) then
			for i = #inactive_idols_table, 1, -1 do
				deities.output("Faction " .. faction_key .. " now gains favour for god " .. god_key .. " from pre-existing idol in force with cqi: " .. tostring(inactive_idols_table[i].force_cqi))
				table.insert(god_slot.idols, table_deep_copy(inactive_idols_table[i]))
				table.remove(inactive_idols_table, i)
			end
		end

		local idol_building_chain = deities.get_god_idol_chain(god_key)
		if not god_slot.idols then
			god_slot.idols = {}
		end
		for idol, idol_data in ipairs(god_slot.idols) do
			local building = deities.find_force_building_by_building_chain(idol_data.force_cqi, idol_building_chain, idol_data.level)
			if building then
				local favour = building:get_effect_value(deities.config.favour_effect)
				god_slot.favour.idol_favour = god_slot.favour.idol_favour + favour
			end
		end

		-- Add favour from idols under conversion
		local idols_under_conversion = deities.get_idols_under_conversion(faction_key, god_key)
		if is_table(idols_under_conversion) then
			for _, idol in ipairs(idols_under_conversion) do
				god_slot.favour.idol_favour = god_slot.favour.idol_favour + idol.favour
			end
		end

		deities.output("Idol favour for faction " .. faction_key .. " for god " .. god_key .. " is now " .. god_slot.favour.idol_favour)
		deities.update_total_favour(faction_key, god_key)
		return god_slot.favour.idol_favour
	end,

	-- get inactive idols data for specified god
	get_inactive_idols = function(faction_key, god_key)
		local faction_table = deities.persistent[faction_key]
		if (not is_table(faction_table))
			or (not is_table(faction_table.inactive_idols))
		then
			deities.output("Could not get inactive idols for faction " .. faction_key .. " for god " .. god_key, 10)
			return
		end

		local result = table_find(faction_table.inactive_idols, function(e) return e.god_key == god_key end)
		return result and result.data or nil
	end,

	get_inactive_idol = function(faction_key, god_key, force_cqi)
		local inactive_idols_table = deities.get_inactive_idols(faction_key, god_key)
		return is_table(inactive_idols_table) and table_find(inactive_idols_table, function(e) return e.force_cqi == force_cqi end)
	end,

	add_inactive_idol = function(faction_key, god_key, idol_data)
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not add inactive idols for faction " .. faction_key .. " for god " .. god_key, 10)
			return
		end

		local inactive_idols_table = deities.get_inactive_idols(faction_key, god_key)
		-- Add entry for this god if there isn't one
		if not inactive_idols_table then
			table.insert(deities.persistent[faction_key].inactive_idols, table_deep_copy(deities.inactive_building_template))
			inactive_idols_table = deities.persistent[faction_key].inactive_idols[#deities.persistent[faction_key].inactive_idols]
			inactive_idols_table.god_key = god_key
			inactive_idols_table = inactive_idols_table.data
		end

		table.insert(inactive_idols_table, idol_data)
	end,


--------------------------------------------------------------
--------------------CULT CENTRES------------------------------
--------------------------------------------------------------
	add_cult_centre = function(faction_key, god_key)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			-- save the cult centre in inactive_cult_centres so it may be used if the faction starts worshipping its god
			if not is_table(deities.persistent[faction_key].inactive_cult_centres) then
				deities.persistent[faction_key].inactive_cult_centres = {}
			end
			table.insert(deities.persistent[faction_key].inactive_cult_centres, god_key)
			return
		end

		god_slot.cult_centre_owned = true
		deities.output("Cult centre added to faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
		deities.update_cult_centre_favour(faction_key, god_key)
	end,

	remove_cult_centre = function(faction_key, god_key)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			--remove from inactive cult centres list - cult centres of gods that are not worshipped
			local inactive_cult_centres_table = deities.persistent[faction_key].inactive_cult_centres

			if is_table(inactive_cult_centres_table) then
				local index = table_find(inactive_cult_centres_table, god_key, true)
				if index then
					table.remove(inactive_cult_centres_table, index)
					deities.output("Inactive cult centre removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
				end
			end
			return
		end

		god_slot.cult_centre_owned = false
		deities.output("Cult centre removed from faction " .. tostring(faction_key) .. " for god " .. tostring(god_key))
		deities.update_cult_centre_favour(faction_key, god_key)
	end,

	update_cult_centre_favour = function(faction_key, god_key)
		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not update favour from cult centres for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		--Check if there are cult centres for a god that was not worshipped but now is and transfer them to the god slot
		if not deities.persistent[faction_key].inactive_cult_centres then
			deities.persistent[faction_key].inactive_cult_centres = {}
		end

		local inactive_cult_centres_table = deities.persistent[faction_key].inactive_cult_centres

		local index = table_find(inactive_cult_centres_table, god_key, true)
		if index then
			table.remove(inactive_cult_centres_table, index)
			god_slot.cult_centre_owned = true
		end

		god_slot.favour.cult_centre_favour = 0
		if god_slot.cult_centre_owned then
			local building_chain = deities.get_god_cult_centre_chain(god_key)
			local region_key = deities.get_god_cult_centre_region(god_key)
			if building_chain ~= "" and region_key ~= "" then
			local building = deities.find_building_by_building_chain(region_key, building_chain, 0)
			if building then
				local favour = building:get_effect_value(deities.config.favour_effect)
				god_slot.favour.cult_centre_favour = god_slot.favour.cult_centre_favour + favour
			end
		end
		end
		deities.output("Cult centre favour for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " is now " .. god_slot.favour.cult_centre_favour)
		deities.update_total_favour(faction_key, god_key)
		return god_slot.favour.cult_centre_favour
	end,

	find_cult_centre_god_for_region = function(region_key)
		local god = table_find(deities.gods, function(e) return e.cult_centre_region_key == region_key end)
		if god then
			return god.key
		else
			return nil
		end
	end,

	get_cult_centre_regions = function()
		local region_keys = {}
		for _, god_data in ipairs(deities.gods) do
			if #god_data.cult_centre_region_key > 0 then
				table.insert(region_keys, god_data.cult_centre_region_key)
			end
		end
		return region_keys
	end,

--------------------------------------------------------------
----------------------- TIERS AND FAVOUR ---------------------
--------------------------------------------------------------

	-- Does not account for max tier for different gods, use get_tier for that
	get_tier_from_favour_amount = function(amount)
		for i = #deities.config.favour_tiers, 1, -1 do
			if amount >= deities.config.favour_tiers[i] then
				return i
			end
		end
		return -1
	end,

	get_tier = function(faction_key, god_key)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			deities.output("Could not get tier for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return -1
		end

		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			deities.output("Could not get tier for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return -1
		end

		local tier = math.min(#tiers, deities.get_tier_from_favour_amount(god_slot.favour.total_favour))
		return tier
	end,

	is_max_tier = function(faction_key, god_key, tier)
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			deities.output("Could not get tier for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return false
		end

		return tier == #tiers
	end,

	get_god_tiers = function(faction_key, god_key)
		if god_key == deities.config.aten_god_key then
			local aten_slot = deities.get_aten_slot(faction_key)
			if aten_slot then
				return aten_slot.tiers
			else
				return nil
			end
		else
			local god = deities.get_god(god_key)
			if god then
				return god.tiers
			else
				return nil
			end
		end
	end,

	get_max_favour_for_god = function(god_key)
		local god = deities.get_god(god_key)
		if #god.tiers <= 0 then
			-- aten is a special case that doesn't have tiers configured, so we return the last in the tiers configuration
			return deities.config.favour_tiers[#deities.config.favour_tiers]
		end

		return deities.config.favour_tiers[#god.tiers]
	end,

	-- For granting favour from other systems, e.g. court
	grant_favour = function(faction_key, god_key, amount, source)
		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not grant favour to faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " from " .. source, 10)
			return
		end

		if not god_slot.favour[source] then
			god_slot.favour[source] = 0
		end
		god_slot.favour[source] = god_slot.favour[source] + amount
		if god_slot.favour[source] < 0 then
			god_slot.favour[source] = 0
		end

		deities.output("Granted " .. amount .. " favour to faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " from source: " .. source)
		deities.output("Favour from this source is now " .. god_slot.favour[source])
		deities.update_total_favour(faction_key, god_key)
	end,

	-- grant favour from cheat
	cheat_grant_favour = function(god_key, amount)
		local local_faction_key = cm:get_local_faction_name(true)
		local local_faction_cqi = cm:get_faction(local_faction_key):command_queue_index()
		CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "PharLocalDeities_GrantFavour:" .. deities.ui_data.selected_god .. ":" .. amount .. ":dev_ui" )
		end,

	-- Combine a set of bundles into 1 bundle so that their effects are visualised together
	get_combined_custom_effect_bundle = function(bundles, init_bundle)
		if not is_table(bundles) then
			return nil
		end

		local combined_custom_effect_bundle
		if init_bundle then
			combined_custom_effect_bundle = cm:create_new_custom_effect_bundle(init_bundle)
			if combined_custom_effect_bundle:is_null_interface() then
				deities.output("Error: Unable to init combined custom effect bundle from bundle" .. tostring(init_bundle), 10)
				return nil
			end
		end
		for _, bundle in ipairs(bundles) do
			-- in the case of Aten we use the init_bundle for its title/description, otherwise take them from the first bundle
			if not combined_custom_effect_bundle then
				combined_custom_effect_bundle = cm:create_new_custom_effect_bundle(bundle.bundle or bundle)
				if combined_custom_effect_bundle:is_null_interface() then
					deities.output("Error: Unable to init combined custom effect bundle from bundle" .. tostring(bundle.bundle), 10)
					return nil
				end
			else
				local temp_custom_effect_bundle = cm:create_new_custom_effect_bundle(bundle.bundle or bundle)
				if temp_custom_effect_bundle and not temp_custom_effect_bundle:is_null_interface() then
					-- There should be one effect per bundle, but iterate them just in case
					for i = 0, temp_custom_effect_bundle:effects():num_items() - 1 do
						local effect = temp_custom_effect_bundle:effects():item_at(i)
						combined_custom_effect_bundle:add_effect(effect:key(), effect:scope(), effect:value())
					end
				else
					deities.output("Error: Unable to find effect bundle" .. tostring(bundle.bundle or bundle), 10)
				end
			end
		end
		return combined_custom_effect_bundle
	end,

	apply_effects_for_tier_change = function(faction_key, god_key, old_tier, new_tier, apply_negative_effects)
		deities.output("Favour tier for " .. tostring(god_key) .. " for faction " .. tostring(faction_key) .. " changed from " .. old_tier .. " to " .. new_tier)

		-- Handle new unlockables for Aten
		local aten_slot = deities.get_aten_slot(faction_key)
		if aten_slot then
			if god_key == deities.config.aten_god_key and new_tier > aten_slot.max_tier_reached then
				if new_tier >= deities.config.aten_first_tier_with_unlockables then
					aten_slot.pending_choices = aten_slot.pending_choices
						+ math.min(new_tier - aten_slot.max_tier_reached, new_tier - deities.config.aten_first_tier_with_unlockables + 1)
					aten_slot.max_tier_reached = new_tier
				end
			end
		end

		deities.update_prayer_active(faction_key, god_key, old_tier, new_tier)
		deities.update_shrine_effects(faction_key, god_key, old_tier, new_tier)
		deities.update_dwelling_effects(faction_key, god_key, old_tier, new_tier)
		deities.update_idol_effects(faction_key, god_key, old_tier, new_tier)
		deities.update_armies_prayer_effects(faction_key, god_key, old_tier, new_tier)
		deities.update_devoted_armies_effects(faction_key, god_key, old_tier, new_tier, apply_negative_effects)

		if deities.has_faction_created_aten(faction_key) then
			deities.update_unique_effects(faction_key, old_tier, new_tier)
		end

		if faction_key == cm:get_local_faction_name(true) then
			deities.update_local_deities_notification()
			deities.update_akhenaten_notification()
		end
	end,

	-- disable or enable worshipped god's prayer_effect_bundles depending on the new_tier
	update_prayer_active = function(faction_key, god_key, old_tier, new_tier)
		local god = deities.get_god(god_key)
		if not god then
			return
		end

		if new_tier > old_tier then
			if new_tier >= deities.config.unlock_tiers.prayers and old_tier < deities.config.unlock_tiers.prayers then
				cm:apply_effect_bundle(god.prayer_effect_bundle, faction_key, -1)
				deities.output("Making prayers is now enabled for " .. god.key .. " with tier " .. tostring(new_tier) .. " for faction " .. tostring(faction_key))
			end
		elseif new_tier < old_tier then
			if new_tier < deities.config.unlock_tiers.prayers and old_tier >= deities.config.unlock_tiers.prayers then
				cm:remove_effect_bundle(god.prayer_effect_bundle, faction_key)
				deities.output("Making prayers is now disabled for " .. god.key .. " with tier " .. tostring(new_tier) .. " for faction " .. tostring(faction_key))
			end
		end
	end,

	update_shrine_effects = function(faction_key, god_key, old_tier, new_tier)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			return
		end

		if #god_slot.shrine_regions > 0 then
			local old_shrine_effect_bundles = nil
			local new_shrine_effect_bundles = nil
			local tiers = deities.get_god_tiers(faction_key, god_key)
			if not is_table(tiers) then
				return
			end

			if old_tier >= deities.config.unlock_tiers.shrines then
				old_shrine_effect_bundles = tiers[old_tier].shrine_effect_bundles
			end
			if new_tier > 0 then
				new_shrine_effect_bundles = tiers[new_tier].shrine_effect_bundles
			end

			local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_shrines_bundle or nil
			local old_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(old_shrine_effect_bundles, init_bundle)
			local new_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(new_shrine_effect_bundles, init_bundle)
			for i = 1, #god_slot.shrine_regions do
				local region_key = god_slot.shrine_regions[i]
				local region = cm:get_region(region_key)
				if region then
					if old_combined_custom_effect_bundle then
						cm:remove_effect_bundle_from_region(old_combined_custom_effect_bundle:key(), region_key)
					end
					if new_combined_custom_effect_bundle then
						cm:apply_custom_effect_bundle_to_region(new_combined_custom_effect_bundle, region)
					end
				else
					deities.output("Error: Invalid region key " .. region_key, 10)
				end
			end
		end
	end,

	update_dwelling_effects = function(faction_key, god_key, old_tier, new_tier)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			return
		end

		if #god_slot.dwelling_regions > 0 then
			local old_dwelling_effect_bundles = nil
			local new_dwelling_effect_bundles = nil
			local tiers = deities.get_god_tiers(faction_key, god_key)
			if not is_table(tiers) then
				return
			end

			if old_tier >= deities.config.unlock_tiers.dwellings then
				old_dwelling_effect_bundles = tiers[old_tier].dwelling_effect_bundles
			end
			if new_tier > 0 then
				new_dwelling_effect_bundles = tiers[new_tier].dwelling_effect_bundles
			end

			local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_dwellings_bundle or nil
			local old_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(old_dwelling_effect_bundles, init_bundle)
			local new_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(new_dwelling_effect_bundles, init_bundle)
			for i = 1, #god_slot.dwelling_regions do
				local region_key = god_slot.dwelling_regions[i]
				local region = cm:get_region(region_key)
				if region then
					if old_combined_custom_effect_bundle then
						cm:remove_effect_bundle_from_region(old_combined_custom_effect_bundle:key(), region_key)
					end
					if new_combined_custom_effect_bundle then
						cm:apply_custom_effect_bundle_to_region(new_combined_custom_effect_bundle, region)
					end
				else
					deities.output("Error: Invalid region key " .. region_key, 10)
				end
			end
		end
	end,

	-- update_idol_effects_for_tier_change (tier change is a given)
	update_idol_effects = function(faction_key, god_key, old_tier, new_tier)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			return
		end

		if not is_table(god_slot.idols) or table_size(god_slot.idols) < 1 then
			return
		end

		local old_idol_effect_bundles = nil
		local new_idol_effect_bundles = nil
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return
		end

		if old_tier >= deities.config.unlock_tiers.idols then
			old_idol_effect_bundles = tiers[old_tier].idol_effect_bundles
		end
		if new_tier > 0 then
			new_idol_effect_bundles = tiers[new_tier].idol_effect_bundles
		end
		local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_idols_bundle or nil
		local old_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(old_idol_effect_bundles, init_bundle)
		local new_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(new_idol_effect_bundles, init_bundle)

		for _, idol in ipairs(god_slot.idols) do
			local force_cqi = idol.force_cqi
			local force = cm:get_military_force_by_cqi(force_cqi)
			if force and not force:is_null_interface() and force:has_general() then
				if old_combined_custom_effect_bundle then
					cm:remove_effect_bundle_from_force(old_combined_custom_effect_bundle:key(), force_cqi)
				end
				if new_combined_custom_effect_bundle then
					cm:apply_custom_effect_bundle_to_force(new_combined_custom_effect_bundle, force)
				end
			else
				deities.output("Error: Invalid force command queue index " .. force_cqi, 10)
			end
		end
	end,

	update_armies_prayer_effects = function(faction_key, god_key, old_tier, new_tier)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			return
		end

		if #god_slot.armies_with_prayer_effects > 0 then
			local old_prayer_effect_bundles = nil
			local new_prayer_effect_bundles = nil
			local tiers = deities.get_god_tiers(faction_key, god_key)
			if not is_table(tiers) then
				return
			end

			if old_tier >= deities.config.unlock_tiers.prayers then
				old_prayer_effect_bundles = tiers[old_tier].prayer_effect_bundles
			end
			if new_tier > 0 then
				new_prayer_effect_bundles = tiers[new_tier].prayer_effect_bundles
			end

			local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_prayers_bundle or nil
			local old_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(old_prayer_effect_bundles, init_bundle)
			local new_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(new_prayer_effect_bundles, init_bundle)
			for i = #god_slot.armies_with_prayer_effects, 1, -1 do
				local force_cqi = god_slot.armies_with_prayer_effects[i].force_cqi
				local force = cm:get_military_force_by_cqi(force_cqi)
				if force and not force:is_null_interface() then
					if old_combined_custom_effect_bundle then
						cm:remove_effect_bundle_from_character(old_combined_custom_effect_bundle:key(), force:general_character():command_queue_index())
					end
					if new_combined_custom_effect_bundle then
						-- duration is kept track of on FactionTurnEnd for the cases when the tier changes and the prayer effects need to change, but keep the remaining duration
						new_combined_custom_effect_bundle:set_is_from_ERS(true)
						new_combined_custom_effect_bundle:set_duration(god_slot.armies_with_prayer_effects[i].turns_left)
						cm:apply_custom_effect_bundle_to_character(new_combined_custom_effect_bundle, force:general_character())
					else
						-- remove the entry if we are not applying new effect bundle
						table.remove(god_slot.armies_with_prayer_effects, i)
					end
				else --force is no longer around, remove it
					table.remove(god_slot.armies_with_prayer_effects, i)
				end
			end
		end
	end,

	update_devoted_armies_effects = function(faction_key, god_key, old_tier, new_tier, apply_negative_effects)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			return
		end

		for index, family_member_cqi in ipairs(god_slot.devoted_generals_family_member_cqi) do
			if family_member_cqi then
				local old_devoted_effect_bundles = nil
				local new_devoted_effect_bundles = nil
				local tiers = deities.get_god_tiers(faction_key, god_key)
				if not is_table(tiers) then
					return
				end

				if old_tier >= deities.config.unlock_tiers.devoted_generals then
					old_devoted_effect_bundles = tiers[old_tier].devoted_effect_bundles
				end
				if new_tier > 0 then
					new_devoted_effect_bundles = tiers[new_tier].devoted_effect_bundles
				end

				local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_devoted_bundle or nil
				local old_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(old_devoted_effect_bundles, init_bundle)
				local new_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(new_devoted_effect_bundles, init_bundle)

				local general = deities.get_devoted_general(faction_key, god_key, index)
				if general and not general:is_null_interface() then
					if old_combined_custom_effect_bundle then
						local general_cqi = general:command_queue_index()

						cm:remove_effect_bundle_from_character(old_combined_custom_effect_bundle:key(), general_cqi)
					end
					if new_combined_custom_effect_bundle then
						cm:apply_custom_effect_bundle_to_character(new_combined_custom_effect_bundle, general)
					end
					if old_tier >= deities.config.unlock_tiers.devoted_generals and new_tier < deities.config.unlock_tiers.devoted_generals then
						local general_slot_count = deities.get_devoted_general_slots(faction_key)
						for i = 1, general_slot_count do
							deities.remove_devoted_general(faction_key, god_key, i, apply_negative_effects, old_tier)
						end
					end
				end
			end
		end
	end,

	-- for Aten God
	update_unique_effects = function(faction_key, old_tier, new_tier)
		local tiers = deities.get_god_tiers(faction_key, deities.config.aten_god_key)
		if not is_table(tiers) then
			return
		end

		local aten = deities.get_god(deities.config.aten_god_key)
		if not aten then
			return
		end

		local aten_slot = deities.get_aten_slot(faction_key)
		if not aten_slot then
			return
		end

		local region_key = aten.cult_centre_region_key
		local region = cm:get_region(region_key)

		-- Update Aten cult centre-effects only if currently owned by the faction
		if region:owning_faction():name() == faction_key then
			local old_unique_effect_bundles
			local new_unique_effect_bundles

			if old_tier >= deities.config.aten_first_tier_with_unlockables then
				old_unique_effect_bundles = tiers[old_tier].unique_effect_bundles
			end
			if new_tier > 0 then
				new_unique_effect_bundles = tiers[new_tier].unique_effect_bundles
			end

			if old_unique_effect_bundles then
				for _, bundle_to_remove in ipairs(old_unique_effect_bundles) do
					-- Extra general slot needs special handling, all other effects are applied to Aten's cult centre
					if bundle_to_remove.bundle ~= deities.config.aten_extra_general.bundle then
						cm:remove_effect_bundle_from_region(bundle_to_remove.bundle, region_key)
					end
				end
			end
			if new_unique_effect_bundles then
				for _, new_bundle in ipairs(new_unique_effect_bundles) do
					-- Extra general slot needs special handling, all other effects are applied to Aten's cult centre
					if new_bundle.bundle ~= deities.config.aten_extra_general.bundle then
						cm:apply_effect_bundle_to_region(new_bundle.bundle, region_key, 0)
					end
				end
			end
		end

		-- Extra general slots
		local previous_general_slots = deities.get_aten_devoted_general_slots_at_tier(faction_key, old_tier)
		local new_general_slots = deities.get_aten_devoted_general_slots_at_tier(faction_key, new_tier)
		if new_general_slots < previous_general_slots then
			for i = previous_general_slots, new_general_slots + 1, -1 do
				deities.remove_devoted_general(faction_key, deities.config.aten_god_key, i, true)
			end
		end
	end,

	remove_aten_cult_centre_effects = function(previous_owner_faction_key)
		local tiers = deities.get_god_tiers(previous_owner_faction_key, deities.config.aten_god_key)
		if not is_table(tiers) then
			return
		end

		local aten = deities.get_god(deities.config.aten_god_key)
		if not aten then
			return
		end

		local aten_slot = deities.get_aten_slot(previous_owner_faction_key)
		if not aten_slot then
			return
		end

		local region_key = aten.cult_centre_region_key

		local current_tier = deities.get_tier(previous_owner_faction_key, deities.config.aten_god_key)
		if current_tier <= 0 then
			return
		end

		local effect_bundles = tiers[current_tier].unique_effect_bundles
		if effect_bundles then
			for _, bundle_to_remove in ipairs(effect_bundles) do
				-- Extra general slot needs special handling, all other effects are applied to Aten's cult centre
				if bundle_to_remove.bundle ~= deities.config.aten_extra_general.bundle then
					cm:remove_effect_bundle_from_region(bundle_to_remove.bundle, region_key)
				end
			end
		end
	end,

	update_all_favour_factors = function(faction_key, god_key)
		deities.update_shrine_favour(faction_key, god_key)
		deities.update_temple_favour(faction_key, god_key)
		deities.update_idol_favour(faction_key, god_key)
		deities.update_dwelling_favour(faction_key, god_key)
		deities.update_cult_centre_favour(faction_key, god_key)
	end,

	update_total_favour = function(faction_key, god_key)
		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not god_slot then
			deities.output("Could not update total favour for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local old_tier = deities.get_tier(faction_key, god_key)

		local old_total_favour = god_slot.favour.total_favour
		god_slot.favour.total_favour = 0
		for factor, value in pairs(god_slot.favour) do
			if factor ~= "total_favour" then
				god_slot.favour.total_favour = god_slot.favour.total_favour + value
			end
		end

		deities.output("Total favour for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. " is now " .. god_slot.favour.total_favour)

		local new_tier = deities.get_tier(faction_key, god_key)
		if old_tier ~= new_tier then
			deities.apply_effects_for_tier_change(faction_key, god_key, old_tier, new_tier, true)

			-- Do not throw this event if we just started worshipping this god
			if old_tier > 0 then
				if new_tier > old_tier then
					local msg_index = deities.get_god_event_message_id(god_key)
					local god_name_loc_key = deities.get_localised_text(god_key).name_source
					deities.add_deities_event_message("local_deity_tier_up", faction_key, msg_index, god_name_loc_key)

					if deities.is_max_tier(faction_key, god_key, new_tier) then
						core:trigger_event("ScriptEventLocalDeitiesGodMaxTierReached", { faction = cm:get_faction(faction_key), god_key = god_key })
					end
				else
					local msg_index = deities.get_god_event_message_id(god_key)
					local god_name_loc_key = deities.get_localised_text(god_key).name_source
					deities.add_deities_event_message("local_deity_tier_down", faction_key, msg_index, god_name_loc_key)
				end
			end
		end

		if old_total_favour ~= god_slot.favour.total_favour then
			core:trigger_event("LocalDeitiesGodTotalFavourChanged",
				{
					faction_key = faction_key,
					god_key = god_key,
					total_favour = god_slot.favour.total_favour,
					old_tier = old_tier,
					new_tier = new_tier,
				})
		end

		return god_slot.favour.total_favour
	end,

	-- Recalculate favour in case some configurable favour values have been changed
	recalculate_favour = function(factions_list)
		for i=0, factions_list:num_items() -1 do
			local curr_faction = factions_list:item_at(i)
			local curr_faction_name = curr_faction:name()

			if curr_faction:is_pharaoh_game_faction() then
				if deities.persistent[curr_faction_name] then
					local god_slots = deities.persistent[curr_faction_name].god_slots
					local god_slots_count = deities.get_faction_god_slots_count(curr_faction_name)
					for j = 1, god_slots_count do
						local god_slot = god_slots[j]
						local god_key = god_slot.god_key
						-- if god is worshipped
						if god_key then
							deities.update_all_favour_factors(curr_faction_name, god_key)
						end
					end
				else
					deities.output("Error:" .. curr_faction_name .. " does not have a persistent table with god slots!")
				end
			end
		end
	end,

	fill_initial_gods = function(factions_list)
		if not deities.new_campaign_started then
			deities.should_fill_initial_gods = true
			return
		end

		-- the following will only happen once when the campaign is started
		deities.new_campaign_started = false
		local local_faction_key = cm:get_local_faction_name(true)

		local sea_peoples_culture_key = deities.config.cultures[4]

		for i=0, factions_list:num_items() -1 do
			local curr_faction = factions_list:item_at(i)
			if curr_faction:is_pharaoh_game_faction() then
				local curr_faction_name = curr_faction:name()

				if curr_faction:is_human() then
					if curr_faction:culture() == sea_peoples_culture_key then
						-- auto-discover specific Sea gods for each Sea playable faction
						for _, god_name in ipairs(deities.auto_discoverable_gods[curr_faction_name]) do
							deities.discover_god(curr_faction_name, god_name, nil, true)
						end
					else
						-- exclude discovery of all Sea gods by non-Sea factions
						for _, god_data in ipairs(deities.gods) do
							if god_data.culture == sea_peoples_culture_key then
								deities.prevent_god_discovery(curr_faction_name, god_data.key)
							end
						end
					end
				end

				-- gods worshipped by AI are defined by designers and do not change
				if not curr_faction:is_human() then
					local gods = deities.ai_gods[curr_faction_name]
					if gods then
						for j = 1, #gods do
							if j > deities.config.init_god_slots then
								deities.unlock_god_slot(curr_faction_name)
							end
							deities.worship_god(curr_faction_name, j, gods[j].god_key)
							deities.grant_favour(curr_faction_name, gods[j].god_key, gods[j].starting_favour, "ai_starting_favour")
						end
					end
				-- human players starting factions
				else
					local god_key = deities.human_gods[curr_faction_name]
					if god_key then
						local god_data = deities.get_god(god_key)
						if curr_faction_name ~= local_faction_key
							or not deities.is_god_restricted_by_modular_difficulty(god_data.key, god_data.culture)
						then
							deities.discover_god(curr_faction_name, god_key, nil, true)
							-- Do not fill initial gods for player in the tutorial
							if curr_faction_name ~= local_faction_key or deities.should_fill_initial_gods then
								deities.worship_god(curr_faction_name, 1, god_key)
							end
						end
					end
				end
				local region_list = curr_faction:region_list()

				-- Do not show the discover animation for the gods discovered from the start of the campaign
				for j = 0, region_list:num_items() - 1 do
					local curr_region = region_list:item_at(j);
					deities.discover_gods_for_region(curr_faction_name, curr_region:name(), true)
				end
			end
		end

		deities.should_fill_initial_gods = true
	end,

	-- regular buildings only
	transfer_building = function(building, region_name, previous_faction, new_faction, slot_num)
		local chain = building:chain()
		local god_table = table_find(deities.gods, function(e) return chain == e.temple_chain end)

		-- found temple
		if god_table then
			deities.remove_temple(previous_faction, god_table.key, region_name)
			deities.add_or_upgrade_temple(new_faction, god_table.key, region_name, building:level())
			return
		end

		god_table = table_find(deities.gods, function(e) return chain == e.shrine_chain end)
		-- found shrine
		if god_table then
			-- Remove startpos shrines for excluded gods
			if slot_num and cm:get_faction(new_faction):is_human()
				and deities.is_god_restricted_by_modular_difficulty(god_table.key, god_table.culture)
			then
				cm:instantly_downgrade_building_in_region(region_name, slot_num, true, true)
			else
				deities.remove_shrine(previous_faction, god_table.key, region_name)
				deities.add_shrine(new_faction, god_table.key, region_name)
			end
			return
		end

		god_table = table_find(deities.gods, function(e) return chain == e.dwelling_chain end)
		-- found dwelling
		if god_table then
			deities.remove_dwelling(previous_faction, god_table.key, region_name)
			deities.add_dwelling(new_faction, god_table.key, region_name)
			return
		end

		local cult_centre_god = table_find(deities.gods, function(e) return chain == e.cult_centre_chain end)
		-- found cult centre grand temple
		if cult_centre_god then
			deities.add_cult_centre(new_faction, cult_centre_god.key)
			deities.remove_cult_centre(previous_faction, cult_centre_god.key)
		end
	end,

	add_bonus_values_favour = function(faction_key, god_key)
		local local_deities_favour_all_gods = cm:get_factions_bonus_value(faction_key, scripted_bonus_values.bonus_value_keys.local_deities_favour_all_gods)
		deities.grant_favour(faction_key, god_key, local_deities_favour_all_gods, "wonder")
	end,

--------------------------------------------------------------
----------------------- DISCOVER AND WORSHIP -----------------
--------------------------------------------------------------

	discover_all_gods = function()
		local faction_key = cm:get_local_faction_name(true)
		for _, god in ipairs(deities.gods) do
			deities.discover_god(faction_key, god.key)
		end
	end,

	discover_gods_for_region = function(faction_key, region_key, is_initial_god)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return {}
		end

		local discovered_gods = {}
		for _, god_data in ipairs(deities.gods) do
			if god_data.realms and not table_find(deities.persistent[faction_key].discovered_gods, god_data.key) then
				for i = 1, #god_data.realms do
					local realm = phar_realms.get_realm(god_data.realms[i])
					if realm then
						if table_find(realm.regions, region_key) then
							if deities.discover_god(faction_key, god_data.key, god_data.culture, is_initial_god) then
								table.insert(discovered_gods, god_data.key)
							end
							break
						end
					else
						deities.output("discover_gods_for_region could not find realm '" .. tostring(god_data.realms[i]) .. "'", 10)
					end
				end
			end
		end

		return discovered_gods
	end,

	--- @function	discover_god
	--- @desc		the function that ultimately performs god discovery
	--- @p string	faction_key			the faction key that will discover the god
	--- @p string	god_key				the god key to be discovered
	--- @p [opt=nil] god_culture_key	the god's culture key, if god_culture_key is provided then the Deities UI must also be updated
	--- @p [opt=nil] is_initial_god	bool	is the god from the initially discovered gods
	discover_god = function(faction_key, god_key, god_culture_key, is_initial_god)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return false
		end

		-- Do not check for modular difficulty restrictions for AI
		if not cm:get_faction(faction_key):is_human() then
			if not table_find(deities.persistent[faction_key].discovered_gods, god_key) then
				table.insert(deities.persistent[faction_key].discovered_gods, god_key)
			end

			return false
		end

		if not cm:get_local_faction(true) then
			deities.output("ERROR: No local faction available - May be running in autotests.")
			return false
		end

		local local_faction_key = cm:get_local_faction(true):name()
		if local_faction_key == faction_key and deities.is_god_restricted_by_modular_difficulty(god_key, god_culture_key)
		then
			deities.output("The god " .. tostring(god_key) .. " has been excluded specifically for your faction " .. tostring(faction_key))
			return false
		end

		if table_find(deities.persistent[faction_key].discovered_gods, god_key) ~= nil then
			return-- god already discovered
		end

			table.insert(deities.persistent[faction_key].discovered_gods, god_key)

		if god_culture_key ~= nil and local_faction_key == faction_key then
			table.insert(deities.ui_persistent.newly_discovered_gods, god_key)
			deities.ui_persistent.last_round_god_discovered = cm:model():turn_number()
			deities.update_local_deities_notification()
		end

		if god_key ~= deities.config.aten_god_key then
			local msg_index = deities.get_god_event_message_id(god_key)

			local god_name_loc_key = deities.get_localised_text(god_key).name_source
			deities.add_deities_event_message("local_deity_discovered", faction_key, msg_index, god_name_loc_key)

			local event_data =
			{
				faction_key = faction_key,
				is_initial_god = is_initial_god,
				god_loc_key = god_name_loc_key,
			}
			core:trigger_event("ScriptedEventNewLocalDeityDiscovered", event_data)
		end

		deities.ai_attempt_to_worship_new_god(faction_key)

		return true
	end,

	cheat_discover_god = function(god_key)
		local local_faction_key = cm:get_local_faction_name(true)
		local local_faction_cqi = cm:get_faction(local_faction_key):command_queue_index()
		CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "PharLocalDeities_DiscoverGod:" .. tostring(god_key))
	end,

	is_god_restricted_by_modular_difficulty = function(god_key, god_culture_key)
		return (table_contains(deities.excluded_god_keys, god_key) or modular_difficulty_campaign.utility_functions.is_god_culture_excluded(god_culture_key))
	end,

	prevent_god_discovery = function(faction_key, god_key)
		if not cm:get_local_faction(true) then
			return
		end
		local local_faction_key = cm:get_local_faction(true):name()
		if local_faction_key ~= faction_key then
			deities.output("A god can be excluded for discovery only for the local player faction! (not for " .. tostring(faction_key) .. ")", 10)
			return
		end

		table.insert(deities.excluded_god_keys, god_key)
	end,

	autodiscover_gods_of_culture = function(culture_key)
		if not cm:get_local_faction(true) then
			return
		end
		local local_faction_key = cm:get_local_faction(true):name()

		for _, god_data in ipairs(deities.gods) do
			if god_data.culture == culture_key then
				deities.discover_god(local_faction_key, god_data.key, culture_key)
			end
		end
	end,

	-- Tracking of how many slots are unlocked is done via deities.config.extra_god_slots_bonus_value script bonus value
	populate_faction_god_slots = function(faction_key)
		deities.persistent[faction_key].god_slots = {}

		for i = 1, deities.config.max_god_slots do
			table.insert(deities.persistent[faction_key].god_slots, table_deep_copy(deities.god_slot_persistent_template))
		end

		deities.persistent[faction_key].aten_slot = table_deep_copy(deities.god_slot_persistent_template)

		deities.output("God slots populated for faction " .. tostring(faction_key))
	end,

	-- Used for testing and unlocking the slots of the AI, the player unlocks slots through having the bonus value applied through the tech tree
	unlock_god_slot = function(faction_key)
		local bonus_slots_unlocked = cm:get_factions_bonus_value(faction_key, deities.config.extra_god_slots_bonus_value)
		if bonus_slots_unlocked == 0 then
			cm:apply_effect_bundle(deities.config.extra_god_slot_bundle_1, faction_key, -1)
			deities.output("Unlocked second god slot for faction " .. tostring(faction_key))
		elseif bonus_slots_unlocked == 1 then
			cm:apply_effect_bundle(deities.config.extra_god_slot_bundle_2, faction_key, -1)
			deities.output("Unlocked third god slot for faction " .. tostring(faction_key))
		end
	end,

	cheat_unlock_god_slot = function()
		local local_faction_cqi = cm:get_faction(cm:get_local_faction_name(true)):command_queue_index()
		CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "PharLocalDeities_UnlockSlot")
	end,

	worship_god = function(faction_key, slot_num, god_key)
		if deities.get_faction_god_slots_count(faction_key) < slot_num then
			deities.output("Invalid slot " .. slot_num .. " for worshiped god for faction " .. tostring(faction_key), 10)
			return
		end

		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			if deities.persistent[faction_key].god_slots[i].god_key == god_key then
				deities.output("Faction " .. tostring(faction_key)  .. " attempted to worship god " .. tostring(god_key) .. ", but it is already worshiped on slot " .. i, 10)
				return
			end
		end

		local god_slot = deities.persistent[faction_key].god_slots[slot_num]

		local old_god_key = god_slot.god_key

		local event_data =
		{
			faction_key = faction_key,
			new_god_key = god_key,
			old_god_key = nil,
		}

		-- Rededicating god
		if god_slot.god_key then
			event_data.old_god_key = old_god_key

			local tier = deities.get_tier(faction_key, old_god_key)

			event_data.old_god_tier = tier

			table.insert(deities.persistent[faction_key].god_slots, slot_num + 1, table_deep_copy(deities.god_slot_persistent_template))
			local new_god_slot = deities.persistent[faction_key].god_slots[slot_num + 1]
			new_god_slot.god_key = god_key

			-- Transfer completed religious buildings. If the new god doesn't have this type of building - demolish + refund it
			if deities.is_sea_god(god_key) and not deities.is_sea_god(old_god_key) then
				deities.demolish_temples_and_shrines(faction_key, old_god_key)
			elseif deities.is_sea_god(old_god_key) and not deities.is_sea_god(god_key) then
				deities.demolish_idols(faction_key, old_god_key)
			end

			if deities.has_dwellings(old_god_key) and not deities.has_dwellings(god_key) then
				deities.demolish_dwellings(faction_key, old_god_key)
			end

			deities.set_religious_buildings_chain_restriction(faction_key, god_key, false)
			deities.convert_completed_religious_buildings(faction_key, god_slot, god_key, deities.conversion_sources.rededication)
			deities.output("Faction " .. tostring(faction_key) .. " now worships god " .. tostring(god_key) .. " in slot " .. slot_num .. " instead of god " .. god_slot.god_key)

			deities.apply_effects_for_tier_change(faction_key, old_god_key, tier, 0, true)
			--TODO: Effect Bonuses from Shrines will be disabled for X turns (TBD)
			--TODO: Temples will decrease the public happiness by X for Y turns (TBD)

			deities.set_religious_buildings_chain_restriction(faction_key, old_god_key, true)

			-- there can be temples, shrines and/or a cult centre for this god from conquered settlements
			deities.update_all_favour_factors(faction_key, god_key)
			deities.add_bonus_values_favour(faction_key, god_key)

			local handle_cult_centre = god_slot.cult_centre_owned

			table.remove(deities.persistent[faction_key].god_slots, slot_num)

			-- Adding the cult centre for a god after we've removed its god slot will cause the cult centre to be saved as an inactive cult centre
			if handle_cult_centre then
				deities.add_cult_centre(faction_key, old_god_key)
			end

			local old_god_name_loc_key = deities.get_localised_text(old_god_key).name_source
			local new_god_name_loc_key = deities.get_localised_text(god_key).name_source
			deities.add_deities_event_message("local_deity_rededicated", faction_key, 0, old_god_name_loc_key, new_god_name_loc_key)
		else
			god_slot.god_key = god_key
			deities.output("Faction " .. tostring(faction_key) .. " now worships god " .. tostring(god_key) .. " in slot " .. slot_num)

			-- there can be temples, shrines and/or a cult centre for this god from conquered settlements
			deities.update_all_favour_factors(faction_key, god_key)
			deities.add_bonus_values_favour(faction_key, god_key)

			deities.set_religious_buildings_chain_restriction(faction_key, god_key, false)

			local msg_index = deities.get_god_event_message_id(god_key)

			local god_name_loc_key = deities.get_localised_text(god_key).name_source
			deities.add_deities_event_message("local_deity_worshiped", faction_key, msg_index, god_name_loc_key)

			if faction_key == cm:get_local_faction_name(true) then
				deities.update_local_deities_notification()
			end
		end

		core:trigger_event("ScriptEventWorshipGod", event_data)
	end,

	clear_god_slot = function(faction_key, index)
		local god_slot = deities.persistent[faction_key].god_slots[index]

		local old_god_key = god_slot.god_key

		local tier = deities.get_tier(faction_key, old_god_key)
		deities.apply_effects_for_tier_change(faction_key, old_god_key, tier, 0, true)

		deities.set_religious_buildings_chain_restriction(faction_key, old_god_key, true)

		table.remove(deities.persistent[faction_key].god_slots, index)
		table.insert(deities.persistent[faction_key].god_slots, table_deep_copy(deities.god_slot_persistent_template))
	end,

	ai_attempt_to_worship_new_god = function(faction_key)
		local faction = cm:get_faction(faction_key)
		if faction:is_human() then
			return
		end

		-- Can be called before we have set up the initial gods (from setting up legitimacy paths for factions)!
		if deities.persistent[faction_key].god_slots[1].god_key == nil and deities.ai_gods[faction_key] then
			return
		end

		--Check if all possible god slots are full
		local empty_slot_index = -1
		local god_slots = deities.get_god_slots(faction_key)
		for i = 1, #god_slots do
			if god_slots[i].god_key == nil then
				empty_slot_index = i
				break
			end
		end
		if empty_slot_index == -1 then
			return
		end

		local legitimacy_path_obj = legitimacy_choice:get_unlocked_legitimacy(faction_key)
		if not legitimacy_path_obj then
			return
		end

		-- Try to worship the favoured deity
		local unlocked_slots_count = deities.get_faction_god_slots_count(faction_key)
		local favoured_deity = legitimacy_path_obj:get_favoured_deity_key()
		if deities.has_faction_discovered_god(faction_key, favoured_deity) and not deities.get_god_slot(faction_key, favoured_deity) then
			local worship_slot_index = empty_slot_index
			if worship_slot_index > unlocked_slots_count then
				deities.unlock_god_slot(faction_key)
			end
			deities.worship_god(faction_key, worship_slot_index, favoured_deity)
			return
		end

		-- Try to worship a random discovered god from the culture if we do not worship any
		local god_culture = deities.config.culture_for_legitimacy[legitimacy_path_obj.config.id]
		if not god_culture then
			return
		end

		for i = 1, unlocked_slots_count do
			local god_data = deities.get_god(deities.persistent[faction_key].god_slots[i].god_key)
			if god_data and god_data.culture == god_culture then
				return
			end
		end

		local discovered_gods_from_culture = deities.get_filtered_gods_from_culture(god_culture, faction_key, false, true)
		if #discovered_gods_from_culture == 0 then
			return
		end
		local random_index = cm:model():random_int(1, #discovered_gods_from_culture)
		local chosen_god_key = discovered_gods_from_culture[random_index].key
		local worship_slot_index = empty_slot_index
		if worship_slot_index > unlocked_slots_count then
			deities.unlock_god_slot(faction_key)
		end
		deities.worship_god(faction_key, worship_slot_index, chosen_god_key)
	end,
--------------------------------------------------------------
-------------------HECATOMB-----------------------------------
--------------------------------------------------------------
	perform_hecatomb = function(faction_key, god_key)
		if not deities.god_requires_hecatomb(god_key) then
			deities.output("Faction " .. tostring(faction_key) .. " cannot perform hecatomb for god " .. tostring(god_key) .. " because it does not support it!", 10)
			return
		end

		local cost = deities.get_hecatomb_cost(faction_key, god_key)
		local faction = cm:get_faction(faction_key)
		cm:faction_apply_resource_transaction(faction, cost)

		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			deities.output("Faction " .. tostring(faction_key) .. " cannot perform hecatomb for god " .. tostring(god_key) .. " because it does not worship it!", 10)
			return
		end

		deities.update_total_favour(faction_key, god_key)

		deities.persistent[faction_key].last_hecatomb_turn = cm:model():turn_number()

		local faction = cm:get_faction(faction_key)
		local force_list = faction:military_force_list()
		for i = 0, force_list:num_items() - 1 do
			local force = force_list:item_at(i)
			if not force:is_armed_citizenry() then
				local force_cqi = force_list:item_at(i):command_queue_index()
				deities.make_prayer(faction_key, god_key, force_cqi)
			end
		end
	end,

	get_hecatomb_cooldown_remaining = function(faction_key)
		if not deities.persistent[faction_key].last_hecatomb_turn then
			return 0
		end
		local bonus_from_effects = deities.get_hecatomb_cooldown_bonus(faction_key)
		return math.max((deities.config.hecatomb_cooldown + bonus_from_effects) - (cm:model():turn_number() - deities.persistent[faction_key].last_hecatomb_turn), 0)
	end,

	get_hecatomb_cooldown_bonus = function(faction_key)
		return cm:get_faction(faction_key):bonus_values():basic_value("hecatomb_cooldown_add")
	end,

	get_hecatomb_cost = function(faction_key, god_key)
		local hecatomb_cost = cm:create_new_custom_resource_cost()

		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			return hecatomb_cost
		end

		local cost_record_key = deities.config.hecatomb_costs[math.min(deities.get_tier(faction_key, god_key), #deities.config.hecatomb_costs)]
		hecatomb_cost:get_cost_from_record(cost_record_key)

		local faction = cm:get_faction(faction_key)
		local bonus_from_effects = faction:bonus_values():basic_value("hecatomb_cost_mod_royal_decree")
		local army_count = faction:num_generals()
		hecatomb_cost:multiply_by(1.0 + (deities.config.hecatomb_percentage_price_increase_per_army * army_count) / 100.0)
		hecatomb_cost:multiply_by(1.0 + bonus_from_effects / 100.0)
		return hecatomb_cost
	end,
--------------------------------------------------------------
-------------------PRAYER AND GENERAL-------------------------
--------------------------------------------------------------

	make_prayer = function(faction_key, god_key, force_cqi)
		local faction = cm:get_faction(faction_key)
		local force = cm:get_military_force_by_cqi(force_cqi)
		if force:is_null_interface() then
			deities.output("Cannot pray, force with CQI " .. force_cqi .. " is null!", 10)
			return
		end

		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			deities.output("Faction " .. tostring(faction_key) .. " cannot pray to god " .. tostring(god_key) .. " because it does not worship it!", 10)
			return
		end

		local current_tier = deities.get_tier(faction_key, god_key)
		if current_tier >= deities.config.unlock_tiers.prayers then
			local tiers = deities.get_god_tiers(faction_key, god_key)
			if not is_table(tiers) then
				return
			end

			local prayer_effect_bundles = tiers[current_tier].prayer_effect_bundles
			local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_prayers_bundle or nil
			local combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(prayer_effect_bundles, init_bundle)

			local prayer_effect_duration = deities.get_faction_prayer_duration(faction_key, god_key, force)
			if combined_custom_effect_bundle and prayer_effect_duration > 0 then
				combined_custom_effect_bundle:set_is_from_ERS(true)

				-- Add bonus happiness from prayer since we have researched such a tech
				local bonus_happiness_from_prayer = cm:get_forces_bonus_value(
					force,
					deities.config.happiness_from_prayer_bonus_value
				)
				if bonus_happiness_from_prayer ~= 0 then
					combined_custom_effect_bundle:add_effect(deities.config.happiness_from_prayer_character_effect, deities.config.happiness_from_prayer_character_effect_scope, bonus_happiness_from_prayer)
				end
				combined_custom_effect_bundle:set_duration(prayer_effect_duration)
				cm:apply_custom_effect_bundle_to_character(combined_custom_effect_bundle, force:general_character())

				-- TODO: Delete the following line and update few lines below the next time you see this and the refactoring of lua table function enxtensions is done
				local table_find_func = table_find or table.find

				-- duration is kept track of on FactionTurnEnd for the cases when the tier changes and the prayer effects need to change, but keep the remaining duration
				-- update with new duration if the force already exists in this god_slot or add new entry, otherwise the effect bundle will be removed prematurely
				local found_index = table_find_func(god_slot.armies_with_prayer_effects, function(obj) return obj.force_cqi == force_cqi end, true)
				if found_index then
					god_slot.armies_with_prayer_effects[found_index].turns_left = math.max(prayer_effect_duration, god_slot.armies_with_prayer_effects[found_index].turns_left)
				else
					table.insert(god_slot.armies_with_prayer_effects, { force_cqi = force_cqi, turns_left = prayer_effect_duration })
				end

				-- Scripted event triggered when the prayer is Successful
				local event_data =
				{
					force = force,
					faction = faction,
					god_key = god_key,
				}
				core:trigger_event("ScriptEventPrayerMade", event_data)

				deities.output("Faction " .. tostring(faction_key) .. " prayed to god " .. tostring(god_key))
			end
		else
			deities.output("Faction " .. tostring(faction_key) .. " is trying to make a prayer to god " .. tostring(god_key) .. " on tier " .. current_tier .. " but it needs tier " .. deities.config.unlock_tiers.prayers, 10)
		end
	end,

	assign_devoted_general = function(faction_key, god_key, index, family_member_cqi)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			deities.output("Cannot assign devoted general for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		local tier = deities.get_tier(faction_key, god_key)
		if tier >= deities.config.unlock_tiers.devoted_generals then
			god_slot.devoted_generals_family_member_cqi[index] = family_member_cqi

			local general = deities.get_devoted_general(faction_key, god_key, index)
			if general and not general:is_null_interface() then
				local localised_text = deities.get_localised_text(god_key)
				cm:set_script_state(general, "devoted_god_display_name_key", localised_text.name_source)
				local god_data = deities.get_god(god_key)
				if god_data then
					cm:set_script_state(general, "devoted_god_image", god_data.god_slot_image)
				end
			end
			deities.output("Faction " .. tostring(faction_key) .. " assigned devoted general with family member CQI " .. family_member_cqi .. " to god ".. tostring(god_key))
		else
			deities.output ("Faction " .. tostring(faction_key) .. " is trying to assign devoted general to god " .. tostring(god_key) .. " on tier " .. tier .. " but it needs tier " .. deities.config.unlock_tiers.devoted_generals, 10)
		end

		-- Apply effect
		local god = deities.get_god(god_key)
		local current_tier = deities.get_tier(faction_key, god_key)
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return
		end

		local new_devoted_effect_bundles = tiers[current_tier].devoted_effect_bundles
		if new_devoted_effect_bundles then
			local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_devoted_bundle or nil
			local new_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(new_devoted_effect_bundles, init_bundle)
			local general = deities.get_devoted_general(faction_key, god_key, index)
			if general and not general:is_null_interface() then
				cm:apply_custom_effect_bundle_to_character(new_combined_custom_effect_bundle, general)
			end
		else
			deities.output("No effect bundle set for a devoted army god " ..  god_key .. " at tier " .. current_tier, 10)
		end

		if god_key ~= deities.config.aten_god_key then
			local msg_index = deities.get_god_event_message_id(god_key)

			local god_name_loc_key = deities.get_localised_text(god_key).name_source
			deities.add_deities_event_message("local_deity_hero_devoted", faction_key, msg_index, god_name_loc_key)
		end

		if faction_key == cm:get_local_faction_name(true) then
			deities.update_local_deities_notification()
			deities.update_akhenaten_notification()
		end

		deities.ui_on_devoted_general(faction_key, family_member_cqi, god_key)
	end,

	remove_devoted_general = function(faction_key, god_key, index, apply_negative_effects, old_tier)
		local general = deities.get_devoted_general(faction_key, god_key, index)
		local god_slot = deities.get_god_slot(faction_key, god_key)

		if not general then
			return
		end
		cm:remove_script_state(general, "devoted_god_display_name_key")
		cm:remove_script_state(general, "devoted_god_image")

		local family_member_cqi = god_slot.devoted_generals_family_member_cqi[index]
		god_slot.devoted_generals_family_member_cqi[index] = nil
--bookmark removing penalty temporarily
		if apply_negative_effects then
			--cm:apply_effect_bundle_to_character(deities.config.devoted_general_negative_effect_bundle, general:command_queue_index(), deities.config.devoted_general_negative_effect_bundle_duration)
		end

		local god = deities.get_god(god_key)
		local current_tier = deities.get_tier(faction_key, god_key)
		if old_tier and old_tier > current_tier then
			current_tier = old_tier
		end
		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return
		end

		local devoted_effect_bundles = tiers[current_tier].devoted_effect_bundles
		local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_devoted_bundle or nil
		local old_combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(devoted_effect_bundles, init_bundle)
		if old_combined_custom_effect_bundle then
			cm:remove_effect_bundle_from_character(old_combined_custom_effect_bundle:key(), general:command_queue_index())
		else
			deities.output("Cannot remove the old effect bundle for a devoted army for faction" .. force:faction():name() .. "for god " .. tostring(god_key), 10)
		end

		local msg_index = deities.get_god_event_message_id(god_key)

		local god_name_loc_key = deities.get_localised_text(god_key).name_source
		deities.add_deities_event_message("local_deity_hero_devotion_suffers", faction_key, msg_index, god_name_loc_key, cm:char_lookup_str(general:command_queue_index()))

		if faction_key == cm:get_local_faction_name(true) then
			deities.update_local_deities_notification()
			deities.update_akhenaten_notification()
		end

		deities.ui_on_remove_devoted_general(faction_key, family_member_cqi)
	end,

	get_devoted_general_family_cqi = function(faction_key, god_key, index)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			deities.output("Cannot get devoted general for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		return god_slot.devoted_generals_family_member_cqi[index]
	end,

	-- returns character, not family member
	get_devoted_general = function(faction_key, god_key, index)
		local devoted_generals_family_member_cqi = deities.get_devoted_general_family_cqi(faction_key, god_key, index)
		if not devoted_generals_family_member_cqi then
			return nil
		end

		local family_member = cm:get_family_member_by_cqi(devoted_generals_family_member_cqi)
		if family_member then
			return family_member:character()
		end
		return nil
	end,

	get_aten_devoted_general_slots_at_tier = function(faction_key, tier)
		local result = (tier >= deities.config.unlock_tiers.devoted_generals) and deities.config.aten_starting_devoted_generals or 0
		if not deities.has_faction_created_aten then
			return result
		end

		local tiers = deities.get_god_tiers(faction_key, deities.config.aten_god_key)
		if not tiers then
			deities.output("Could not get tiers for Aten for faction " .. tostring(faction_key), 10)
			return result
		end

		if is_table(tiers[tier]) and is_table(tiers[tier].unique_effect_bundles) then
			for _, bundle in ipairs(tiers[tier].unique_effect_bundles) do
				if bundle.bundle == deities.config.aten_extra_general.bundle then
					result = result + 1
				end
			end
		end
		return result
	end,

	get_devoted_general_slots = function(faction_key)
		if not deities.has_faction_created_aten(faction_key) then
			return 1
		end

		local aten_slot = deities.get_aten_slot(faction_key)
		if aten_slot then
			return aten_slot.max_unlocked_devoted_generals
		else
			return 1
		end
	end,

	devoted_general_died = function(faction_key, god_key, index)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			deities.output("Cannot remove dead devoted general for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return
		end

		god_slot.devoted_generals_family_member_cqi[index] = nil
	end,

	is_devoted_general_unlocked = function(faction_key, god_key, index)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			deities.output("Checking is devoted general unlocked for faction " .. tostring(faction_key) .. " for god " .. tostring(god_key) .. "but the god is not worshipped!", 10)
			return false
		end

		local tier = deities.get_tier(faction_key, god_key)
		if god_key ~= deities.config.aten_god_key then
			return tier >= deities.config.unlock_tiers.devoted_generals
		end

		return index <= deities.get_aten_devoted_general_slots_at_tier(faction_key, tier)
	end,

	is_devoted_general = function(faction_key, general_family_member_cqi)
		local god_slots = deities.get_god_slots(faction_key)
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			local god_slot = god_slots[i]
			local devoted_general_index = table_find(god_slot.devoted_generals_family_member_cqi, general_family_member_cqi, true)

			if devoted_general_index then
				return true
			end
		end
		return false
	end,

	get_bundle_for_prayer = function(agent_action_key, character)
		if not agent_action_key or agent_action_key == "" or not character then
			return nil
		end

		local index
		for i, prefix in ipairs(deities.config.pray_interaction_prefixes) do
			if string.find(agent_action_key, prefix) then
				index = i
			end
		end

		if not index then
			return
		end

		local string_element = deities.config.pray_interaction_prefixes[index]
		local _, last = string.find(agent_action_key, string_element)
			local god_key = string.sub(agent_action_key, last + 1)

			local faction = character:faction()
			local faction_key = faction:name()
			local force = character:military_force()

			if force:is_null_interface() then
				return nil
			end

			local god_slot = deities.get_god_slot(faction_key, god_key)
			if not god_slot then
				return nil
			end

			local current_tier = deities.get_tier(faction_key, god_key)
			if current_tier >= deities.config.unlock_tiers.prayers then
				local tiers = deities.get_god_tiers(faction_key, god_key)
				if not is_table(tiers) then
					return nil
				end

				local prayer_effect_bundles = tiers[current_tier].prayer_effect_bundles
				local init_bundle = (god_key == deities.config.aten_god_key) and deities.config.aten_prayers_bundle or nil
				local combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(prayer_effect_bundles, init_bundle)

				-- Display bonus happiness to be added from prayer since we have researched such a tech
				local bonus_happiness_from_prayer = cm:get_forces_bonus_value(
					force,
					deities.config.happiness_from_prayer_bonus_value
				)
				if bonus_happiness_from_prayer ~= 0 then
					combined_custom_effect_bundle:add_effect(deities.config.happiness_from_prayer_character_effect, deities.config.happiness_from_prayer_character_effect_scope, bonus_happiness_from_prayer)
				end

				local prayer_effect_duration = deities.get_faction_prayer_duration(faction_key, god_key, force)
				if combined_custom_effect_bundle and prayer_effect_duration > 0 then
					combined_custom_effect_bundle:set_duration(prayer_effect_duration)
					return combined_custom_effect_bundle
				end
			end
	end,

	has_faction_devoted_general_slot_available = function(faction_name)
		if not feature_unlock.is_feature_unlocked_for_faction(faction_name, feature_ids_config.local_deities) then
			return false
		end

		local god_slots = deities.get_god_slots(faction_name)
		local general_slots = deities.get_devoted_general_slots(faction_name)
		for i = 1, deities.get_faction_god_slots_count(faction_name) do
			local god_slot = god_slots[i]
			if god_slot and god_slot.god_key then
				local god_key = god_slot.god_key
				for j = 1, general_slots do
					if deities.is_devoted_general_unlocked(faction_name, god_key, j) then
						local devoted_general_family_member_cqi = deities.get_devoted_general_family_cqi(faction_name, god_key, j)
						if not devoted_general_family_member_cqi then
							return true
						end
					end
				end
			end
		end
		return false
	end,

--------------------------------------------------------------
--------------------AKHENATEN---------------------------------
--------------------------------------------------------------
	claim_akhenaten = function(faction_key)
		local sea_peoples_culture_key = deities.config.cultures[4]

		local god_slots = deities.get_god_slots(faction_key)
		if god_slots then
			local cleared_slots = 0
			for i = 1, deities.get_faction_god_slots_count(faction_key) do
				local god_key = god_slots[i - cleared_slots].god_key
				if god_key then
					if deities.has_dwellings(god_key) then
						deities.demolish_dwellings(faction_key, god_key, true)
					end
					local god_config = deities.get_god(god_key)
					if god_config.culture == sea_peoples_culture_key then
						deities.demolish_idols(faction_key, god_key, true)
						deities.clear_god_slot(faction_key, i - cleared_slots)
						-- Deleted the slot and shifted the rest to the left
						cleared_slots = cleared_slots + 1
					end
				end
			end
		end

		deities.output("Faction " .. tostring(faction_key) .. " has claimed the Akhenaten ancient legacy")
		deities.persistent[faction_key].claimed_akhenaten = true

		deities.discover_god(faction_key, deities.config.aten_god_key)

		-- Used for Amarna's occupation options
		local faction =  cm:get_faction(faction_key)
		cm:set_script_state(faction, "has_faction_claimed_akhenaten", true)

		-- First tab is Aten
		deities.ui_data.active_tab = deities.component_ids.tab_buttons[1]
	end,

	has_faction_claimed_akhenaten = function(faction_key)
		-- this can occur for factions like "rebels"
		if not is_table(deities.persistent[faction_key]) then
			return false
		end
		return deities.persistent[faction_key].claimed_akhenaten
	end,

	has_faction_created_aten = function(faction_key)
		local aten_slot = deities.get_aten_slot(faction_key)
		if not aten_slot then
			return false
		end
		-- Will be nil if not created
		return aten_slot.god_key == deities.config.aten_god_key
	end,

	demolish_temples_and_shrines = function(faction_key, god_key)
		local god_data = deities.get_god_slot(faction_key, god_key)
		if not god_data then
			return
		end

		local temple_chain = deities.get_god_temple_chain(god_key)
		for _, temple in ipairs(god_data.temples) do
			local region_key = temple.region_key
			local building_key = cm:get_building_from_building_chain(temple_chain, temple.level)

			local slot_index = deities.find_region_slot_index_by_building_key(region_key, building_key)
			if slot_index then
				cm:instantly_dismantle_building_in_region(region_key, slot_index + 1, true)
			end
		end

		local shrine_chain = deities.get_god_shrine_chain(god_key)
		for _, shrine_region_key in ipairs(god_data.shrine_regions) do
			local building_key = cm:get_building_from_building_chain(shrine_chain, 0)

			local slot_index = deities.find_region_slot_index_by_building_key(shrine_region_key, building_key)
			if slot_index then
				cm:instantly_dismantle_building_in_region(shrine_region_key, slot_index + 1, true)
			end
		end
	end,

	demolish_idols = function(faction_key, god_key, in_construction)
		local god_data = deities.get_god_slot(faction_key, god_key)
		if not god_data then
			return
		end

		local idol_chain = deities.get_god_idol_chain(god_key)
		for _, idol in ipairs(god_data.idols) do
			local force_cqi = idol.force_cqi
			local building_key = cm:get_building_from_building_chain(idol_chain, idol.level)

			local slot_index = deities.find_force_slot_index_by_building_key(force_cqi, building_key)
			if slot_index then
				cm:instantly_dismantle_building_in_force(force_cqi, slot_index + 1, true)
			end
		end

		if not in_construction then
			return
		end
		-- Go through every force building slot and check for idols in construction
		local faction = cm:get_faction(faction_key)
		local force_list = faction:military_force_list()
		for i = 0, force_list:num_items() - 1 do
			local force = force_list:item_at(i)
			local force_slots = force:slots()
			if force_slots then
				local last_slot_index = force_slots:num_items() - 1
				for i = 0, last_slot_index do
					local slot = force_slots:item_at(i)
					if slot:is_there_construction() then
						local chain = slot:construction_building_chain_key()
						local idol_chain_god = table_find(deities.gods, function(e) return e.idol_chain == chain end)
						-- Check if the building god matches god_key
						if idol_chain_god and idol_chain_god.key == god_key then
							local force_cqi = force:command_queue_index()
							cm:instantly_dismantle_building_in_force(force_cqi, i + 1, true)
						end
					end
				end
			end-- for all military force buildings
		end-- for all military forces
	end,

	demolish_dwellings = function(faction_key, god_key, in_construction)
		local god_data = deities.get_god_slot(faction_key, god_key)
		if not god_data then
			return
		end

		local dwelling_chain = deities.get_god_dwelling_chain(god_key)
		for _, dwelling_region_key in ipairs(god_data.dwelling_regions) do
			local building_key = cm:get_building_from_building_chain(dwelling_chain, 0)

			local slot_index = deities.find_region_slot_index_by_building_key(dwelling_region_key, building_key)
			if slot_index then
				cm:instantly_dismantle_building_in_region(dwelling_region_key, slot_index + 1, true)
			end
		end

		if not in_construction then
			return
		end
		-- Go through every building slot and check for dwellings in construction
		local slots_with_construction = deities.get_building_slots_with_ongoing_contruction(faction_key)
		for _, slot_data in ipairs(slots_with_construction) do
			local chain = slot_data.slot:construction_building_chain_key()
			local dwellings_chain_god = table_find(deities.gods, function(e) return e.dwelling_chain == chain end)
			if dwellings_chain_god and dwellings_chain_god.key == god_key then
				cm:instantly_dismantle_building_in_region(slot_data.slot:region():name(), slot_data.index + 1, true)
			end
		end
	end,

	get_idol_refund_cost = function(faction_key)
		local sea_peoples_culture_key = deities.config.cultures[4]

		local total_resource_cost = cm:create_new_custom_resource_cost()

		local salvage_modifier = cm:model():get_campaign_variable_by_name("building_salvage_cost_modifier")
		local salvage_modifier_damaged = cm:model():get_campaign_variable_by_name("building_salvage_cost_modifier_damaged")
		local salvage_modifier_ruined = cm:model():get_campaign_variable_by_name("building_salvage_cost_modifier_ruined")

		local god_slots = deities.get_god_slots(faction_key)
		if not god_slots then
			return total_resource_cost
		end

		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			local god_key = god_slots[i].god_key
			if god_key then
				local god_config = deities.get_god(god_key)
				if god_config.culture == sea_peoples_culture_key then

					local idol_chain_key = deities.get_god_idol_chain(god_key)
					local god_slot = god_slots[i]

					-- completed idols
					for _, idol in ipairs(god_slot.idols) do
						local idol_level = idol.level
						local building = deities.find_force_building_by_building_chain(idol.force_cqi, idol_chain_key, idol_level)
						if building and not building:is_null_interface() then
							total_resource_cost:add(cm:get_building_refund_cost(building))
						end
					end

					-- Go through every force building slot and check for idols in construction
					local faction = cm:get_faction(faction_key)
					local force_list = faction:military_force_list()
					for i = 0, force_list:num_items() - 1 do
						local force = force_list:item_at(i)
						local force_slots = force:slots()
						if force_slots then
							local last_slot_index = force_slots:num_items() - 1
							for i = 0, last_slot_index do
								local slot = force_slots:item_at(i)
								if slot:is_there_construction() then
									local chain = slot:construction_building_chain_key()
									local idol_chain_god = table_find(deities.gods, function(e) return e.idol_chain == chain end)
									-- Check if the building god matches god_key
									if idol_chain_god and idol_chain_god.key == god_key then
										local level = slot:construction_building_level_record_level()
										local force_cqi = force:command_queue_index()
										local idol_building_key = cm:get_building_from_building_chain(chain, level)

										local current_resource_cost = cm:create_new_custom_resource_cost()
										local creation_cost_record_key = cm:get_building_create_cost_record_key(idol_building_key)
										current_resource_cost:get_cost_from_record(creation_cost_record_key)
										total_resource_cost:add(current_resource_cost)
									end
								end
							end
						end-- for all military force buildings
					end-- for all military forces
				end
			end
		end

		total_resource_cost:multiply_by(-1)
		return total_resource_cost
	end,

	get_dwellings_refund_cost = function(faction_key)
		local total_resource_cost = cm:create_new_custom_resource_cost()

		local salvage_modifier = cm:model():get_campaign_variable_by_name("building_salvage_cost_modifier")
		local salvage_modifier_damaged = cm:model():get_campaign_variable_by_name("building_salvage_cost_modifier_damaged")
		local salvage_modifier_ruined = cm:model():get_campaign_variable_by_name("building_salvage_cost_modifier_ruined")

		local faction = cm:get_faction(faction_key)
		if not faction then
			return
		end
		local god_slots = deities.get_god_slots(faction_key)

		if not god_slots then
			return total_resource_cost
		end

		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			local god_key = god_slots[i].god_key
			if god_key and deities.has_dwellings(god_key) then
				local dwelling_chain_key = deities.get_god_dwelling_chain(god_key)
				local god_slot = god_slots[i]

				-- completed dwellings
				for _, dwelling_region in ipairs(god_slot.dwelling_regions) do
					local building = deities.find_building_by_building_chain(dwelling_region, dwelling_chain_key, 0)
					if building and not building:is_null_interface() then
						total_resource_cost:add(cm:get_building_refund_cost(building))
					end
				end

				-- Go through every building slot and check for dwellings in construction
				local slots_with_construction = deities.get_building_slots_with_ongoing_contruction(faction_key)
				for _, slot_data in ipairs(slots_with_construction) do
					local chain = slot_data.slot:construction_building_chain_key()
					local dwellings_chain_god = table_find(deities.gods, function(e) return e.dwelling_chain == chain end)
					if dwellings_chain_god then
						local level = slot_data.slot:construction_building_level_record_level()
						local dwelling_building_key = cm:get_building_from_building_chain(chain, level)

						local current_resource_cost = cm:create_new_custom_resource_cost()
						local creation_cost_record_key = cm:get_building_create_cost_record_key(dwelling_building_key)
						current_resource_cost:get_cost_from_record(creation_cost_record_key)
						total_resource_cost:add(current_resource_cost)
					end
				end
			end
		end

		total_resource_cost:multiply_by(-1)
		return total_resource_cost
	end,

	-- Convert inactive shrines and temples and idols to Aten
	convert_inactive_religious_buildings_to_aten = function(faction_key)
		if is_table(deities.persistent[faction_key].inactive_temples) then
			for _, temples in ipairs(deities.persistent[faction_key].inactive_temples) do
				-- change_temple_god, change_shrine_god and change_idol_god remove from the collections, so a copy is needed for iterating
				local temples_copy = table_deep_copy(temples.data)
				for _, temple in ipairs(temples_copy) do
					deities.change_temple_god(faction_key, temple.region_key, temples.god_key, deities.config.aten_god_key, deities.conversion_sources.create_aten)
				end
			end
		end

		if is_table(deities.persistent[faction_key].inactive_shrine_regions) then
			for old_god_key, shrine_regions in pairs(deities.persistent[faction_key].inactive_shrine_regions) do
				local shrines_copy = table_deep_copy(shrine_regions)
				for _, shrine_region in ipairs(shrines_copy) do
					deities.change_shrine_god(faction_key, shrine_region, shrine_regions.god_key, deities.config.aten_god_key, deities.conversion_sources.create_aten)
				end
			end
		end
	end,

	-- Convert completed shrines, temples, dwellings and idols (for any god)
	convert_completed_religious_buildings = function(faction_key, old_god_slot, new_god_key, source)
		-- Transfer temples, shrines and idols
		-- change_temple_god, change_shrine_god and change_idol_god remove from the collections, so a copy is needed for iterating
		local temples_copy = table_deep_copy(old_god_slot.temples)
		for _, temple in ipairs(temples_copy) do
			deities.change_temple_god(faction_key, temple.region_key, old_god_slot.god_key, new_god_key, source)
		end

		local shrines_copy = table_deep_copy(old_god_slot.shrine_regions)
		for _, shrine_region_key in ipairs(shrines_copy) do
			deities.change_shrine_god(faction_key, shrine_region_key, old_god_slot.god_key, new_god_key, source)
		end

		local dwellings_copy = table_deep_copy(old_god_slot.dwelling_regions)
		for _, dwelling_region_key in ipairs(dwellings_copy) do
			deities.change_dwelling_god(faction_key, dwelling_region_key, old_god_slot.god_key, new_god_key, source)
		end

		local idols_copy = table_deep_copy(old_god_slot.idols)
		for _, idol in ipairs(idols_copy) do
			deities.change_idol_god(faction_key, idol.force_cqi, old_god_slot.god_key, new_god_key, source)
		end
	end,

	-- Convert shrines and temples in construction (for any god). It is used when creating Aten so it doesn't concern idols and dwellings.
	convert_religious_buildings_in_construction = function(faction_key, old_god_key, new_god_key)
		local faction = cm:get_faction(faction_key)
		if not faction then
			return
		end

		-- Go through every building slot and check for temples and shrines in construction
		local slots_with_construction = deities.get_building_slots_with_ongoing_contruction(faction_key)
		for _, slot_data in ipairs(slots_with_construction) do
			local chain = slot_data.slot:construction_building_chain_key()
			local temple_chain_god = table_find(deities.gods, function(e) return e.temple_chain == chain end)
			local shrine_chain_god = table_find(deities.gods, function(e) return e.shrine_chain == chain end)
			-- Check if the building god matches old_god_key
			-- No god specified means changing the buildings of all gods
			if (temple_chain_god or shrine_chain_god)
				and (not old_god_key or (temple_chain_god and temple_chain_god.key == old_god_key) or (shrine_chain_god and shrine_chain_god.key == old_god_key))
			then
				local level = slot_data.slot:construction_building_level_record_level()
				local time_remaining = slot_data.slot:construction_building_time_to_completion()
				local region_key = slot_data.slot:region():name()

				local new_god = deities.get_god(new_god_key)

				-- Prevent convert_completed_religious_buildings from converting the building to a completed building of a lower level
				-- Shrines have only 1 level
				if level >= 1 and temple_chain_god then
					-- Complete the second to last level, so that the last can be started on top of it
					local new_building_key = cm:get_building_from_building_chain(new_god.temple_chain, level - 1)
					cm:replace_building_in_region_slot(region_key, slot_data.index + 1, new_building_key)
					new_building_key = cm:get_building_from_building_chain(new_god.temple_chain, level)
					cm:queue_building_construction_in_region(region_key, slot_data.index + 1, new_building_key, time_remaining, true)

					-- remove old one so it is not handled by convert_completed_religious_buildings
					deities.remove_temple(faction_key, temple_chain_god.key, region_key)
				else
					local new_building_key = cm:get_building_from_building_chain(temple_chain_god and new_god.temple_chain or new_god.shrine_chain, level)
					cm:instantly_dismantle_building_in_region(region_key, slot_data.index + 1, false)
					cm:queue_building_construction_in_region(region_key, slot_data.index + 1, new_building_key, time_remaining, true)
				end
			end
		end
	end,

	create_aten_from_gods = function(faction_key, god_keys)
		local god_key = deities.config.aten_god_key

		if deities.has_faction_created_aten(faction_key) then
			deities.output("Faction " .. tostring(faction_key) .. " has already created Aten but tried again!" , 10)
			return
		end

		local aten_god_slot = deities.get_god_slot(faction_key, deities.config.aten_god_key)
		deities.init_aten_slot(aten_god_slot)

		-- Copy effects from chosen gods, these will be saved and loaded
		-- Fill the extra Aten tiers with copies of effects of the last tier of regular gods
		for _, old_god_key in ipairs(god_keys) do
			if old_god_key then
				local tiers = deities.get_god_tiers(faction_key, old_god_key)
				if tiers then
					for i = 1, #deities.config.favour_tiers do
						local tier_to_copy = math.min(i, #tiers)
						if is_table(tiers[tier_to_copy].shrine_effect_bundles) then
							for j = 1, #tiers[tier_to_copy].shrine_effect_bundles do
								table.insert(aten_god_slot.tiers[i].shrine_effect_bundles, table_deep_copy(tiers[tier_to_copy].shrine_effect_bundles[j]))
							end
						end

						if is_table(tiers[tier_to_copy].idol_effect_bundles) then
							for j = 1, #tiers[tier_to_copy].idol_effect_bundles do
								table.insert(aten_god_slot.tiers[i].idol_effect_bundles, table_deep_copy(tiers[tier_to_copy].idol_effect_bundles[j]))
							end
						end

						if is_table(tiers[tier_to_copy].prayer_effect_bundles) then
							for j = 1, #tiers[tier_to_copy].prayer_effect_bundles do
								table.insert(aten_god_slot.tiers[i].prayer_effect_bundles, table_deep_copy(tiers[tier_to_copy].prayer_effect_bundles[j]))
							end
						end

						if is_table(tiers[tier_to_copy].devoted_effect_bundles) then
							for j = 1, #tiers[tier_to_copy].devoted_effect_bundles do
								table.insert(aten_god_slot.tiers[i].devoted_effect_bundles, table_deep_copy(tiers[tier_to_copy].devoted_effect_bundles[j]))
							end
						end
					end
				end
			end
		end

		deities.set_religious_buildings_chain_restriction(faction_key, god_key, false)

		deities.convert_inactive_religious_buildings_to_aten(faction_key)
		deities.convert_religious_buildings_in_construction(faction_key, nil, deities.config.aten_god_key)

		-- Remove other worshipped gods
		local god_slots = deities.get_god_slots(faction_key)
		if god_slots then
			for i = 1, deities.get_faction_god_slots_count(faction_key) do
				if god_slots[i].god_key then
					local god_slot = god_slots[i]
					local old_god_key = god_slots[i].god_key
					local tier = deities.get_tier(faction_key, old_god_key)

					deities.convert_completed_religious_buildings(faction_key, god_slot, deities.config.aten_god_key, deities.conversion_sources.create_aten)

					deities.apply_effects_for_tier_change(faction_key, old_god_key, tier, 0, false)

					deities.set_religious_buildings_chain_restriction(faction_key, old_god_key, true)
					god_slot.god_key = nil

					core:trigger_event("LocalDeitiesGodTotalFavourChanged",
						{
							faction_key = faction_key,
							god_key = old_god_key,
							total_favour = 0,
							old_tier = tier,
							new_tier = 0,
						})
				end
			end
		end

		deities.update_all_favour_factors(faction_key, god_key)
		deities.add_bonus_values_favour(faction_key, god_key)

		-- No longer be able to build cult centre chains of the other gods
		deities.set_aten_cult_centre_chain_restrictions(faction_key)

		-- Mark Aten as created in the slot
		aten_god_slot.god_key = god_key

		deities.output("Faction " .. tostring(faction_key) .. " created Aten from gods: " .. tostring(god_keys[1]) .. ", " .. tostring(god_key[2]))

		deities.init_aten_unlockables(faction_key)
		deities.set_next_random_aten_unlockables(faction_key)

		local local_faction_key = cm:get_local_faction_name(true)
		if faction_key == local_faction_key then
			deities.open_aten()
		end
	end,

	-- Favour that Aten would have when he is created
	get_potential_aten_favour = function()
		local potential_favour = 0

		local faction_key = cm:get_local_faction_name(true)
		local god_slots = deities.get_god_slots(faction_key)

		-- Add favour from all religious buildings of worshipped gods
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			if god_slots[i].god_key then
				local god_slot = god_slots[i]
				local god_key = god_slot.god_key

				local temple_building_chain = deities.get_god_temple_chain(god_key)
				for _, temple_data in ipairs(god_slot.temples) do
					local building = deities.find_building_by_building_chain(temple_data.region_key, temple_building_chain, temple_data.level)
					if building then
						local favour = building:get_effect_value(deities.config.favour_effect)
						potential_favour = potential_favour + favour
					end
				end

				local shrine_building_chain = deities.get_god_shrine_chain(god_key)
				for _, shrine_region in ipairs(god_slot.shrine_regions) do
					local building = deities.find_building_by_building_chain(shrine_region, shrine_building_chain, 0)
					if building then
						local favour = building:get_effect_value(deities.config.favour_effect)
						potential_favour = potential_favour + favour
					end
				end

				local idol_building_chain = deities.get_god_idol_chain(god_key)
				for _, idol_data in ipairs(god_slot.idols) do
					local force = cm:get_military_force_by_cqi(idol_data.force_cqi)
					if force and not force:is_null_interface() and force:has_general() then
						local building = deities.find_force_building_by_building_chain(idol_data.force_cqi, idol_building_chain, idol_data.level)
						if building then
							local favour = building:get_effect_value(deities.config.favour_effect)
							potential_favour = potential_favour + favour
						end
					end
				end
			end
		end

		-- Add favour from owned religious buildings that are not of worshipped gods, as they will be converted to Aten
		if is_table(deities.persistent[faction_key].inactive_temples) then
			for _, entry in ipairs(deities.persistent[faction_key].inactive_temples) do
				local god_key = entry.god_key
				temple_building_chain = deities.get_god_temple_chain(god_key)
				for _, temple_data in ipairs(entry.data) do
					local building = deities.find_building_by_building_chain(temple_data.region_key, temple_building_chain, temple_data.level)
					if building then
						local favour = building:get_effect_value(deities.config.favour_effect)
						potential_favour = potential_favour + favour
					end
				end
			end
		end

		if is_table(deities.persistent[faction_key].inactive_shrine_regions) then
			for _, entry in ipairs(deities.persistent[faction_key].inactive_shrine_regions) do
				local god_key = entry.god_key
				shrine_building_chain = deities.get_god_shrine_chain(god_key)
				for _, shrine_region in ipairs(entry.data) do
					local building = deities.find_building_by_building_chain(shrine_region, shrine_building_chain, 0)
					if building then
						local favour = building:get_effect_value(deities.config.favour_effect)
						potential_favour = potential_favour + favour
					end
				end
			end
		end

		if is_table(deities.persistent[faction_key].inactive_idols) then
			for _, entry in ipairs(deities.persistent[faction_key].inactive_idols) do
				local god_key = entry.god_key
				idol_building_chain = deities.get_god_idol_chain(god_key)
				for _, idol_data in ipairs(entry.data) do
					local building = deities.find_force_building_by_building_chain(idol_data.force_cqi, idol_building_chain, idol_data.level)
					if building then
						local favour = building:get_effect_value(deities.config.favour_effect)
						potential_favour = potential_favour + favour
					end
				end
			end
		end

		-- Add favour from Aten's cult centre
		local god_key = deities.config.aten_god_key
		if is_table(deities.persistent[faction_key].inactive_cult_centres) and table_find(deities.persistent[faction_key].inactive_cult_centres, god_key) then
			local building_chain = deities.get_god_cult_centre_chain(god_key)
			local region_key = deities.get_god_cult_centre_region(god_key)
			if building_chain ~= "" and region_key ~= "" then
			local building = deities.find_building_by_building_chain(region_key, building_chain, 0)
			if building then
				local favour = building:get_effect_value(deities.config.favour_effect)
				potential_favour = potential_favour + favour
			end
		end
		end

		return potential_favour
	end,

	get_aten_pending_choices = function(faction_key)
		if not is_table(deities.persistent[faction_key]) then
			return 0
		end

		local aten_slot = deities.get_aten_slot(faction_key)
		if not aten_slot or not aten_slot.pending_choices then
			return 0
		end

		return aten_slot.pending_choices
	end,

	init_aten_unlockables = function(faction_key)
		local aten_slot = deities.get_aten_slot(faction_key)
		if not aten_slot then
			return
		end

		aten_slot.weighted_unlockables = weighted_list:new()
		for _, god in ipairs(deities.gods) do
			if god.key ~= deities.config.aten_god_key then
				local tiers = deities.get_god_tiers(faction_key, god.key)
				for _, tier in ipairs(tiers) do
					if is_table(tier.shrine_effect_bundles) then
						for _, bundle in ipairs(tier.shrine_effect_bundles) do
							bundle.god_key = god.key
							aten_slot.weighted_unlockables:add_item({bundle = bundle, category = deities.unlockable_categories.shrines}, bundle.aten_unlockable_random_weight)
						end
					end

					if is_table(tier.idol_effect_bundles) then
						for _, bundle in ipairs(tier.idol_effect_bundles) do
							bundle.god_key = god.key
							aten_slot.weighted_unlockables:add_item({bundle = bundle, category = deities.unlockable_categories.idols}, bundle.aten_unlockable_random_weight)
						end
					end

					if is_table(tier.prayer_effect_bundles) then
						for _, bundle in ipairs(tier.prayer_effect_bundles) do
							bundle.god_key = god.key
							aten_slot.weighted_unlockables:add_item({bundle = bundle, category = deities.unlockable_categories.prayer}, bundle.aten_unlockable_random_weight)
						end
					end

					if is_table(tier.devoted_effect_bundles) then
						for _, bundle in ipairs(tier.devoted_effect_bundles) do
							bundle.god_key = god.key
							aten_slot.weighted_unlockables:add_item({bundle = bundle, category = deities.unlockable_categories.devoted_army}, bundle.aten_unlockable_random_weight)
						end
					end
				end
			end
		end

		-- Add unique effects
		for _, bundle in ipairs(deities.config.aten_unique_unlockables) do
			aten_slot.weighted_unlockables:add_item({bundle = bundle, category = deities.unlockable_categories.unique}, bundle.aten_unlockable_random_weight)
		end

		-- Add extra devoted generals
		local bundle = deities.config.aten_extra_general
		aten_slot.weighted_unlockables:add_item({bundle = bundle, category = deities.unlockable_categories.extra_general}, bundle.aten_unlockable_random_weight)
	end,

	--TODO: design is not finalised, possibly the only restriction will be that extra devoted general slots cannot be presented twice in the same choice
	remove_unlockables_from_category = function(list, category)
		for i = #list.items, 1, -1 do
			if list.items[i].item.category == category then
				list:remove_item(i)
			end
		end
	end,

	get_next_random_aten_unlockables = function(faction_key)
		local aten_slot = deities.get_aten_slot(faction_key)
		if not aten_slot then
			return
		end
		if is_table(aten_slot.pending_unlockables) then
			return aten_slot.pending_unlockables
		end
		return nil
	end,

	-- Roll randoms for Aten choices on creation of Aten and every time a choice is made
	set_next_random_aten_unlockables = function(faction_key)
		local aten_slot = deities.get_aten_slot(faction_key)
		if not aten_slot then
			return
		end
		if not is_table(aten_slot.pending_unlockables) then
			aten_slot.pending_unlockables = {}
		end

		if not aten_slot or not aten_slot.weighted_unlockables then
			deities.output("Error trying to get random unlockable for faction " .. tostring(faction_key), 10)
			return
		end

		for i = #aten_slot.pending_unlockables, 1, -1 do
			aten_slot.pending_unlockables[i] = nil
		end

		-- The weighted list must be re-initialised after loading, or it will not find its methods
		aten_slot.weighted_unlockables = weighted_list:new(aten_slot.weighted_unlockables)
		local unlockables_copy = aten_slot.weighted_unlockables:make_copy()

		-- Enforce max number of effects per category
		local current_tier = deities.get_tier(faction_key, deities.config.aten_god_key)
		local tiers = deities.get_god_tiers(faction_key, deities.config.aten_god_key)
		if is_table(tiers) then
			for category, value in pairs(deities.config.unlockable_categories_limits) do
				local effects_count
				if category == deities.unlockable_categories.shrines then
					effects_count = #tiers[current_tier].shrine_effect_bundles
				elseif category == deities.unlockable_categories.idols then
					effects_count = #tiers[current_tier].idol_effect_bundles
				elseif category == deities.unlockable_categories.prayer then
					effects_count = #tiers[current_tier].prayer_effect_bundles
				elseif category == deities.unlockable_categories.devoted_army then
					effects_count = #tiers[current_tier].devoted_effect_bundles
				elseif category == deities.unlockable_categories.unique then
					effects_count = #tiers[current_tier].unique_effect_bundles
				end

				if effects_count >= deities.config.unlockable_categories_limits[category] then
					deities.remove_unlockables_from_category(unlockables_copy, category)
					-- Extra general slots are counted towards the unique category limit
					if category == deities.unlockable_categories.unique then
						deities.remove_unlockables_from_category(unlockables_copy, deities.unlockable_categories.extra_general)
					end
				end
			end
		end

		for i = 1, deities.config.aten_unlockable_choices do
			local choice, _ = unlockables_copy:weighted_select()
			if choice then
				table.insert(aten_slot.pending_unlockables, choice)
				-- By design there should be max one choice per category (TBD)
				if i < deities.config.aten_unlockable_choices then
					deities.remove_unlockables_from_category(unlockables_copy, choice.category)
				end
			end
		end
	end,

	select_aten_unlockable = function(faction_key, bundle_key, category)
		local aten_slot = deities.get_aten_slot(faction_key)
		if not aten_slot then
			return
		end

		local bundle_data = deities.get_effect_bundle_data(faction_key, bundle_key, category)
		if not bundle_data then
			deities.output(" Could not find bundle for key " .. bundle_key .. " for category " .. category, 10)
			return
		end

		-- There is only one record for an extra general slot that can be chosen multiple times, other unlockables are removed after being chosen
		if category ~= deities.unlockable_categories.extra_general then
			local index_to_remove = table_find(aten_slot.weighted_unlockables.items, function(e) return bundle_data.bundle == e.item.bundle.bundle end, true)
			-- The weighted list must be re-initialised after loading, or it will not find its methods
			aten_slot.weighted_unlockables = weighted_list:new(aten_slot.weighted_unlockables)
			if index_to_remove then
				aten_slot.weighted_unlockables:remove_item(index_to_remove)
			end
		end

		aten_slot.max_tier_selected_unlockable = aten_slot.max_tier_selected_unlockable + 1
		if aten_slot.max_tier_selected_unlockable < deities.config.aten_first_tier_with_unlockables then
			aten_slot.max_tier_selected_unlockable = deities.config.aten_first_tier_with_unlockables
			for i = 1, deities.config.aten_first_tier_with_unlockables - 1 do
				aten_slot.unlockables_per_tier[i] = {}
			end
		end

		aten_slot.unlockables_per_tier[aten_slot.max_tier_selected_unlockable] =
		{
			bundle = bundle_data,
			category = category,
		}

		local tiers = deities.get_god_tiers(faction_key, deities.config.aten_god_key)
		if not tiers then
			return
		end

		for i = aten_slot.max_tier_selected_unlockable, #tiers do
			if category == deities.unlockable_categories.shrines then
				table.insert(tiers[i].shrine_effect_bundles, bundle_data)
			elseif category == deities.unlockable_categories.idols then
				table.insert(tiers[i].idol_effect_bundles, bundle_data)
			elseif category == deities.unlockable_categories.prayer then
				table.insert(tiers[i].prayer_effect_bundles, bundle_data)
			elseif category == deities.unlockable_categories.devoted_army then
				table.insert(tiers[i].devoted_effect_bundles, bundle_data)
			elseif category == deities.unlockable_categories.unique or category == deities.unlockable_categories.extra_general then
				table.insert(tiers[i].unique_effect_bundles, bundle_data)
			end
		end

		aten_slot.pending_choices = aten_slot.pending_choices - 1
		local tier = deities.get_tier(faction_key, deities.config.aten_god_key)
		if aten_slot.max_tier_selected_unlockable < #tiers then
			deities.set_next_random_aten_unlockables(faction_key)
		end

		-- Update the max number of generals ever unlocked, used for UI
		local general_slot_count = deities.get_aten_devoted_general_slots_at_tier(faction_key, tier)
		if aten_slot.max_unlocked_devoted_generals < general_slot_count then
			aten_slot.max_unlocked_devoted_generals = general_slot_count
		end

		-- Apply new effects immediately
		deities.apply_effects_for_tier_change(faction_key, deities.config.aten_god_key, 0, aten_slot.max_tier_selected_unlockable, false)

		deities.output("Faction " .. tostring(faction_key) .. " selected Aten unlockable " .. bundle_key .. " from category " .. category)

		-- Refresh UI
		local local_faction_key = cm:get_local_faction_name(true)
		if faction_key == local_faction_key then
			deities.ui_data.aten_selected_unlockable = "0"
			common:set_context_value(deities.context_values.aten_selected_unlockable, deities.ui_data.aten_selected_unlockable)
			deities.open_aten()
			deities.update_akhenaten_notification()
		end
	end,

	get_effect_bundle_data = function(faction_key, bundle_key, category)
		if category == deities.unlockable_categories.extra_general then
			return deities.config.aten_extra_general
		end

		if category == deities.unlockable_categories.unique then
			local bundle = table_find(deities.config.aten_unique_unlockables, function(e) return e.bundle == bundle_key end)
			if bundle then
				return bundle
			end
		end

		for _, god in ipairs(deities.gods) do
			if god.key ~= deities.config.aten_god_key then
				local tiers = deities.get_god_tiers(faction_key, god.key)
				if tiers then
					for _, current_tier in ipairs(tiers) do
						if category == deities.unlockable_categories.shrines then
							if is_table(current_tier.shrine_effect_bundles) then
								local bundle = table_find(current_tier.shrine_effect_bundles, function(e) return e.bundle == bundle_key end)
								if bundle then
									return bundle
								end
							end
						elseif category == deities.unlockable_categories.idols then
							if is_table(current_tier.idol_effect_bundles) then
								local bundle = table_find(current_tier.idol_effect_bundles, function(e) return e.bundle == bundle_key end)
								if bundle then
									return bundle
								end
							end
						elseif category == deities.unlockable_categories.prayer then
							if is_table(current_tier.prayer_effect_bundles) then
								local bundle = table_find(current_tier.prayer_effect_bundles, function(e) return e.bundle == bundle_key end)
								if bundle then
									return bundle
								end
							end
						elseif category == deities.unlockable_categories.devoted_army then
							if is_table(current_tier.devoted_effect_bundles) then
								local bundle = table_find(current_tier.devoted_effect_bundles, function(e) return e.bundle == bundle_key end)
								if bundle then
									return bundle
								end
							end
						end
					end
				end
			end
		end
	end,

	has_faction_aten_unlockable_available = function(faction_name)
		if not feature_unlock.is_feature_unlocked_for_faction(faction_name, feature_ids_config.local_deities) then
			return false
		end

		local aten_pending_unlocks = deities.get_aten_pending_choices(faction_name)
		if aten_pending_unlocks > 0 then
			return true
		end
		return false
	end,

--------------------------------------------------------------
----------------------- UI -----------------------------------
--------------------------------------------------------------

	get_localised_text = function(god_key)
		local result =
		{
			name = "",
			name_source = "",
			flavour = "",
			flavour_source = "",
		}

		local god = deities.get_god(god_key)
		if not god then
			return result
		end

		if god.localised_name then
			result.name_source = "ui_text_replacements_localised_text_" .. god.localised_name
			result.name = common.get_localised_string(result.name_source)
		end
		if god.localised_flavour then
			result.flavour_source = "ui_text_replacements_localised_text_" .. god.localised_flavour
			result.flavour = common.get_localised_string(result.flavour_source)
		end
		if god.localised_undiscovered_flavour then
			result.undiscovered_flavour_source = "ui_text_replacements_localised_text_" .. god.localised_undiscovered_flavour
			result.undiscovered_flavour = common.get_localised_string(result.undiscovered_flavour_source)
		end
		return result
	end,

	get_localised_culture_title = function(culture)
		local format_string = "ui_text_replacements_localised_text_" .. deities.text_ids.culture_format
		local localised_format_string = common.get_localised_string(format_string)
		if deities.text_ids.cultures[culture] then
			local localised_culture_string = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.text_ids.cultures[culture])
			return common.string_safe_format(localised_format_string, localised_culture_string), format_string
		end

		deities.output("could not get localisation for culture " .. tostring(culture), 10)
		return "", ""
	end,

	get_localised_unlockable_text = function(bundle)
		local result =
		{
			flavour_localised = "",
			flavour_source = "",
		}

		if bundle.localised_flavour then
			result.flavour_source = "ui_text_replacements_localised_text_" .. bundle.localised_flavour
			result.flavour_localised = common.get_localised_string(result.flavour_source)
		end
		return result
	end,

	display_all_gods = function()
		deities.toggle_gods_description(true)
		deities.toggle_gods_list_visibility(true)
		deities.toggle_culture_tabs_visibility(true)
		deities.toggle_aten_creation_panel_visibility(false)

		deities.toggle_aten_background(false)

		local worshipped_tab = deities.panel:SequentialFind(deities.component_ids.worshipped_tab)
		if worshipped_tab then
			worshipped_tab:SetState("active")
		end
		local all_gods_tab = deities.panel:SequentialFind(deities.component_ids.all_gods_tab)
		if all_gods_tab then
			all_gods_tab:SetState("selected")
		end

		common.set_context_value(deities.context_values.show_all_gods, 1)

		local tabs_holder = deities.panel:SequentialFind(deities.component_ids.culture_tabs_holder)
		local active_tab_index

		if tabs_holder then
			tabs_holder:SetVisible(true)

			local faction_key = cm:get_local_faction_name(true)

			if not deities.ui_data.active_tab then
				local culture_index = 1
				if faction_key then
					local main_god = deities.get_god(deities.human_gods[faction_key])
					culture_index = table_find(deities.config.cultures, main_god.culture, true)
					if not culture_index then
						culture_index = 1
					end
				end
				-- Aten is missing in deities.config.cultures
				culture_index = culture_index + 1
				deities.ui_data.active_tab = deities.component_ids.tab_buttons[culture_index]
			end


			for i = 1, #deities.component_ids.tab_buttons do
				local tab_component = tabs_holder:SequentialFind(deities.component_ids.tab_buttons[i])
				local tab_parent = UIComponent(tab_component:Parent())
				if tab_component then
					-- Show/hide Aten tab
					if i == 1 then
						tab_parent:SetVisible(deities.has_faction_claimed_akhenaten(faction_key))
					-- Sea gods are only visible to sea factions that have not claimed Akhenaten
					elseif deities.component_ids.tab_buttons[i] == "sea_peoples_tab_button" then
						tab_parent:SetVisible(deities.faction_has_access_to_idols(faction_key))
					end
					if deities.component_ids.tab_buttons[i] == deities.ui_data.active_tab then
						tab_parent:SetState("selected")
						active_tab_index = i
					end

					local new_god_component = tab_parent:SequentialFind(deities.component_ids.culture_new_god_available)
					if new_god_component then
						new_god_component:SetVisible(false)
					end

					-- Check for new gods in this tab
					local culture = tab_parent:GetProperty(deities.component_ids.culture_property)
					local gods = deities.get_gods_from_culture(culture)

					for j = 1, #gods do
						local god_key = gods[j].key
						if table_find(deities.ui_persistent.newly_discovered_gods, god_key) ~= nil then
							new_god_component:SetVisible(true)
							break
						end
					end
				end
			end
		end

		local gods_list = deities.panel:SequentialFind(deities.component_ids.gods_list)

		deities.toggle_gods_list_visibility(true)
		deities.toggle_aten_panel_visibility(false)

		deities.display_all_gods_list(gods_list)
	end,

	display_all_gods_list = function(gods_list)
		if not gods_list then
			return
		end

		deities.ui_data.selected_god = nil

		local faction_key = cm:get_local_faction_name(true)

		common:set_context_value(deities.context_values.switch_all_gods_description, "hide")

		for i = 1, #deities.component_ids.culture_tabs do
			local god_card_template = deities.ui_data.templates.god_card_templates[i]
			local current_tab_content = deities.component_ids.culture_tabs[i]

			current_tab_content_component = gods_list:SequentialFind(current_tab_content)

			if current_tab_content_component then
				-- Aten is a special case
				-- Sea gods are only visible to sea factions that have not claimed Akhenaten
				if (i == 1 and not deities.has_faction_claimed_akhenaten(faction_key))
					or (deities.component_ids.tab_buttons[i] == "sea_peoples_tab_button"
					and not deities.faction_has_access_to_idols(faction_key))
				then
					current_tab_content_component:SetVisible(false)
				else
					current_tab_content_component:SetVisible(true)
					if god_card_template then
						local holder_component = current_tab_content_component:SequentialFind(deities.component_ids.god_culture_tab_holder)
						if holder_component then
							holder_component:DestroyChildren()
							local culture = current_tab_content_component:GetProperty(deities.component_ids.culture_property)
							-- Order: worshipped, discovered, undiscovered
							local gods = deities.get_ordered_gods(faction_key, culture)

							local favoured_god = deities.get_favoured_god(faction_key)
							for j = 1, #gods do
								local god_key = gods[j].key

								local new_god_component = UIComponent(holder_component:CreateFromComponent(god_card_template:Address(), string.format(deities.component_ids.god_instance_prefix .. tostring(god_key))))
								local god_name_component = new_god_component:SequentialFind(deities.component_ids.god_name)
								if god_name_component then
									local localised_text = deities.get_localised_text(god_key)
									god_name_component:SetText(localised_text.name, localised_text.name_source)
									local god_new_component = god_name_component:SequentialFind(deities.component_ids.god_new)
									if god_new_component then
										local is_new = table_find(deities.ui_persistent.newly_discovered_gods, god_key) ~= nil
										god_new_component:SetVisible(is_new)
									end
								end

								local worshipped_indicator = new_god_component:SequentialFind(deities.component_ids.worshipped_indicator)
								if worshipped_indicator then
									if god_key == deities.config.aten_god_key then
										worshipped_indicator:SetVisible(deities.has_faction_created_aten(faction_key))
										worshipped_indicator:SetState("worshipped")
									else
										local is_worshipped = deities.get_god_slot(faction_key, god_key) ~= nil
										local is_favoured = (god_key == favoured_god)
										worshipped_indicator:SetVisible(is_worshipped or is_favoured)
										if is_favoured then
											if is_worshipped then
												worshipped_indicator:SetState("worshipped_patron")
											else
												worshipped_indicator:SetState("patron")
											end
										elseif is_worshipped then
											worshipped_indicator:SetState("worshipped")
										end
									end
								end

								local god_portrait_component = new_god_component:SequentialFind(deities.component_ids.god_portrait)
								-- Set if god is discovered
								if god_portrait_component then
									god_portrait_component:SetProperty(deities.component_ids.god_key_property, god_key)

									if deities.has_faction_discovered_god(faction_key, god_key) then
										god_portrait_component:SetState("default")
									else
										god_portrait_component:SetState("undiscovered")

										--DEV_UI: discover the god
										local dev_button_discover_god = new_god_component:SequentialFind(deities.component_ids.dev_button_discover_god)
										if dev_button_discover_god then
											local lua_cmd = "dev_ui#deities.cheat_discover_god(\"" .. tostring(god_key) .. "\")"
											dev_button_discover_god:SetProperty("lua_cmd", lua_cmd)
										end
									end

									local god = deities.get_god(god_key)
									if god and god.tab_image then
										god_portrait_component:SetImagePath(god.tab_image)
									end
								end
							end
						end
					end
				end
			end
		end

		local all_gods_holder = deities.panel:SequentialFind(deities.component_ids.all_gods_hodler)
		if all_gods_holder then
			all_gods_holder:InterfaceFunction("initialise", deities.ui_data.active_tab)
		end
	end,

	set_god_tooltip = function(god_key, component)
		-- Currently a custom effect bundle can only be set using set_cco_effect_bundle_from_custom_bundle, hence why the tooltip is
		-- initialised in the OnMouseOn event so that the correct components can be found sequentially
		component:SetTooltipText("{{tt:" .. deities.tooltips.tier .. "}}", "", true)
		local tooltip_component = core:get_ui_root():SequentialFind("tooltip_effects_deities_container")
		if not tooltip_component then
			return
		end

		local cco_table = {}

		local localised_text = deities.get_localised_text(god_key)
		cco_table.Name = localised_text.name

		local god = deities.get_god(god_key)
		if god then
			cco_table.Type = common.get_localised_string("ui_text_replacements_localised_text_" .. god.epithet)
		end

		local faction_key = cm:get_local_faction_name(true)
		if not deities.has_faction_discovered_god(faction_key, god_key) then
			cco_table.Warning = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.god_tooltip_undiscovered_warning_key)
		end

		-- Check if worshipped
		local god_slot = deities.get_god_slot(faction_key, god_key)
		local is_worshipped = not not god_slot

		local shrines_holder_component = tooltip_component:SequentialFind(deities.component_ids.shrines_holder)
		local idols_holder_component = tooltip_component:SequentialFind(deities.component_ids.idols_holder)
		local prayer_holder_component = tooltip_component:SequentialFind(deities.component_ids.prayer_holder)
		local devoted_holder_component = tooltip_component:SequentialFind(deities.component_ids.devoted_holder)
		local dwellings_holder_component = tooltip_component:SequentialFind(deities.component_ids.dwellings_holder)
		local unique_holder_component = tooltip_component:SequentialFind(deities.component_ids.unique_holder)

		if god_key == deities.config.aten_god_key and unique_holder_component then
			unique_holder_component:SetVisible(true)
		end

		local has_dwellings = deities.has_dwellings(god_key)
		if dwellings_holder_component then
			dwellings_holder_component:SetVisible(has_dwellings)
		end

		local bonuses
		-- Show max tier effects
		local tiers = deities.get_god_tiers(faction_key, god_key)
		bonuses = deities.get_bonuses_for_tier(faction_key, god_key, tiers and #tiers or -1, false, true)
		if tiers and (not is_worshipped or deities.get_tier(faction_key, god_key) ~= #tiers) then
			cco_table.Alert = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.effects_alert_key)
		end

		deities.instantiate_tooltip_bonuses(shrines_holder_component, bonuses.shrine_bonuses)
		deities.instantiate_tooltip_bonuses(idols_holder_component, bonuses.idol_bonuses)
		deities.instantiate_tooltip_bonuses(prayer_holder_component, bonuses.prayer_bonuses)
		deities.instantiate_tooltip_bonuses(devoted_holder_component, bonuses.devoted_bonuses)
		deities.instantiate_tooltip_bonuses(dwellings_holder_component, bonuses.dwelling_bonuses)
		if has_dwellings then
			deities.instantiate_tooltip_bonuses(devoted_holder_component, bonuses.devoted_bonuses)
		end
		deities.instantiate_tooltip_bonuses(unique_holder_component, bonuses.unique_bonuses)

		local script_id = "god_tooltip_" .. tostring(god_key)
		tooltip_component:SetProperty("script_id", script_id)
		common.set_context_value(script_id, cco_table)
	end,

	toggle_culture_tabs_visibility = function(visible)
		common.set_context_value(deities.context_values.show_culture_tabs, visible and 1 or 0)
	end,

	toggle_worshipped_gods_tabs_visibility = function(visible)
		common.set_context_value(deities.context_values.show_worshipped_gods_tabs, visible and 1 or 0)
	end,

	toggle_gods_list_visibility = function(visible)
		common.set_context_value(deities.context_values.show_all_gods, visible and 1 or 0)
	end,

	toggle_gods_description = function(visible)
		common.set_context_value(deities.context_values.show_gods_description, visible and 1 or 0)
	end,

	-- use display_god_slots to show god slots, otherwise issues with favour tooltips occur
	hide_god_slots = function()
		common.set_context_value(deities.context_values.show_god_slots, 0)
	end,

	hide_all_gods = function()
		local all_gods_holder = deities.panel:SequentialFind(deities.component_ids.all_gods_hodler)
		if all_gods_holder then
			all_gods_holder:InterfaceFunction("save_starting_slider_value")
		end

		common.set_context_value(deities.context_values.show_all_gods, 0)
	end,

	toggle_worship_button_active = function(active)
		local selected_god_component = deities.panel:SequentialFind(deities.component_ids.selected_god)
		if not selected_god_component then
			return
		end

		local worship_button_component = selected_god_component:SequentialFind(deities.component_ids.worship_button)
		if worship_button_component then
			if active then
				worship_button_component:SetState("active")
			else
				worship_button_component:SetState("inactive")
			end
		end
	end,

	toggle_worship_button_visible = function(visible)
		local selected_god_component = deities.panel:SequentialFind(deities.component_ids.selected_god)
		if not selected_god_component then
			return
		end

		local worship_button_component = selected_god_component:SequentialFind(deities.component_ids.worship_button)
		if worship_button_component then
			worship_button_component:SetVisible(visible)
		end
	end,

	toggle_aten_background = function(is_aten)
		local background_component = deities.panel:SequentialFind(deities.component_ids.background)
		if not background_component then
			return
		end

		background_component:SetState(is_aten and "aten" or "default")
	end,

	toggle_selected_god = function(visible)
		local selected_god_component = deities.panel:SequentialFind(deities.component_ids.selected_god)
		if selected_god_component then
			selected_god_component:SetVisible(visible)
		end
	end,

	display_god_slots = function()
		local faction_key = cm:get_local_faction_name(true)

		local worshipped_tab = deities.panel:SequentialFind(deities.component_ids.worshipped_tab)
		if worshipped_tab then
			worshipped_tab:SetState("selected")
		end
		local all_gods_tab = deities.panel:SequentialFind(deities.component_ids.all_gods_tab)
		if all_gods_tab then
			all_gods_tab:SetState("active")
		end

		--DEV_UI: unlock a god slot
		local dev_button_unlock_god_slot = deities.panel:SequentialFind(deities.component_ids.dev_button_unlock_god_slot)
		if dev_button_unlock_god_slot and deities.get_faction_god_slots_count(faction_key) < deities.config.max_god_slots then
			local lua_cmd = "dev_ui#deities.cheat_unlock_god_slot()"
			dev_button_unlock_god_slot:SetProperty("lua_cmd", lua_cmd)
		end

		common.set_context_value(deities.context_values.show_god_slots, 1)
		common:set_context_value(deities.context_values.switch_all_gods_description, deities.has_faction_claimed_akhenaten(faction_key) and "aten" or "default")
		deities.toggle_gods_description(true)
		deities.toggle_worshipped_gods_tabs_visibility(true)
		deities.toggle_gods_list_visibility(false)
		deities.toggle_aten_panel_visibility(false)
		deities.toggle_aten_creation_panel_visibility(false)

		deities.toggle_aten_background(deities.has_faction_created_aten(faction_key))
		deities.toggle_aten_unlocks_visibility(deities.has_faction_aten_unlockable_available(faction_key))

		local worshipped_gods_holder = deities.panel:SequentialFind(deities.component_ids.worshipped_all_gods_panel)
		if not worshipped_gods_holder then
			return
		end
		worshipped_gods_holder:SetVisible(true)

		local worshipped_gods_inner_holder = worshipped_gods_holder:SequentialFind(deities.component_ids.worshipped_gods_inner_holder)
		if not worshipped_gods_inner_holder then
			return
		end

		worshipped_gods_inner_holder:DestroyChildren()

		local god_slot_template = deities.has_faction_created_aten(faction_key) and deities.ui_data.templates.aten_god_slot_template or deities.ui_data.templates.god_slot_template
		if not god_slot_template then
			return
		end

		for i = #deities.ui_data.god_slot_army_button_components, 1 , -1 do
			table.remove(deities.ui_data.god_slot_army_button_components, i)
		end

		local god_slots
		if deities.has_faction_created_aten(faction_key) then
			god_slots = { deities.persistent[faction_key].aten_slot }
		else
			god_slots = deities.persistent[faction_key].god_slots
		end

		for i = 1, #god_slots do
			-- Modify the script_id for the prayer dev ui cheat
			local dev_button_pray_from_template = god_slot_template:SequentialFind(deities.component_ids.dev_button_pray)
			if dev_button_pray_from_template then
				dev_button_pray_from_template:SetProperty("script_id", deities.component_ids.dev_button_pray_prefix .. i)
			end

			local new_god_slot_component = UIComponent(worshipped_gods_inner_holder:CreateFromComponent(god_slot_template:Address(), string.format("god_slot" .. i)))

			local god_name_component = new_god_slot_component:SequentialFind(deities.component_ids.god_slot_name)
			if god_name_component then
				if god_slots[i].god_key then
					local localised_text = deities.get_localised_text(god_slots[i].god_key)
					god_name_component:SetText(localised_text.name, localised_text.name_source)
				else
					god_name_component:SetVisible(false)
				end
			end

			-- Get the instance of dev_button_pray
			local dev_button_pray = new_god_slot_component:SequentialFind(deities.component_ids.dev_button_pray)

			local army_favour_holder_component = new_god_slot_component:SequentialFind(deities.component_ids.god_slot_army_favour_holder)
			local favour_bar_component
			local army_holder_component
			if army_favour_holder_component then
				favour_bar_component = army_favour_holder_component:SequentialFind(deities.component_ids.god_slot_favour_bar)
				army_holder_component = new_god_slot_component:SequentialFind(deities.component_ids.god_slot_army_holder)
			end

			local god = deities.get_god(god_slots[i].god_key)
			deities.init_god_slot_components(new_god_slot_component, god_slots[i], god, i)

			if favour_bar_component then
				deities.init_god_slot_favour_bar_component(favour_bar_component, god_slots[i])
			end

			if army_holder_component and deities.ui_data.templates.army_button_template then
				if i <= deities.get_faction_god_slots_count(faction_key) then
					army_holder_component:SetState("default")
				else
					army_holder_component:SetState("locked")
				end

				-- Regular gods have 1 devoted general slot, Aten can have multiple
				local general_slots = deities.get_devoted_general_slots(faction_key)
				--if deities.has_faction_created_aten(faction_key) then
				--	army_holder_component:DestroyChildren()
				--end
				for j = 1, general_slots do
					deities.init_army_button_component(army_holder_component, dev_button_pray, i, j)
				end
			end
		end
	end,

	init_god_slot_components = function(god_slot_component, god_slot, god, slot_index, is_from_faction_summary)
		local is_from_faction_summary = not not is_from_faction_summary
		local god_portrait_holder_component = god_slot_component:SequentialFind(deities.component_ids.god_slot_portrait)
		if not god_portrait_holder_component then
			return
		end

		local god_slot_portrait_button = god_portrait_holder_component:SequentialFind(deities.component_ids.god_slot_portrait_button)
		if not god_slot_portrait_button then
			return
		end

		local faction_key = cm:get_local_faction_name(true)

		if god_slot and slot_index <= deities.get_faction_god_slots_count(faction_key) then
			if god_slot.god_key then
				local available_btn = god_portrait_holder_component:SequentialFind(deities.component_ids.god_slot_available_btn)
				if available_btn then
					available_btn:SetVisible(false)
				end

				god_slot_portrait_button:SetProperty(deities.component_ids.god_key_property, god_slot.god_key)

				god_portrait_holder_component:SetState("selected")

				deities.init_favour_tooltip(god_slot_portrait_button, god_slot, is_from_faction_summary)

				local favour_bar_component = god_slot_component:SequentialFind(deities.component_ids.god_slot_favour_bar)
				if favour_bar_component then
					deities.init_favour_tooltip(favour_bar_component, god_slot, is_from_faction_summary)
				end

				if god and god.god_slot_image then
					god_slot_portrait_button:SetVisible(true)
					god_slot_portrait_button:SetImagePath(god.main_image, 0)

					god_slot_portrait_button:SetState(god.key == deities.ui_data.selected_god and "selected" or "default")
				end

				local shrines_button = god_slot_component:SequentialFind(deities.component_ids.shrines_button)
				if shrines_button then
					shrines_button:SetVisible(true)
				end
			else
				god_portrait_holder_component:SetState("available")
				god_slot_portrait_button:SetVisible(false)
				deities.init_worship_slot_tooltip(god_portrait_holder_component, "unlocked", slot_index, is_from_faction_summary)

				local shrines_button = god_slot_component:SequentialFind(deities.component_ids.shrines_button)
				if shrines_button then
					shrines_button:SetVisible(false)
				end
			end
		else
			god_portrait_holder_component:SetState("locked")
			local available_btn = god_portrait_holder_component:SequentialFind(deities.component_ids.god_slot_available_btn)
			if available_btn then
				available_btn:SetVisible(false)
			end
			god_slot_portrait_button:SetVisible(false)
			deities.init_worship_slot_tooltip(god_portrait_holder_component, "locked", slot_index, is_from_faction_summary)

			local shrines_button = god_slot_component:SequentialFind(deities.component_ids.shrines_button)
			if shrines_button then
				shrines_button:SetVisible(false)
			end
		end
	end,

	init_god_slot_favour_bar_component = function(favour_bar_component, god_slot)
		if god_slot and god_slot.god_key then
			favour_bar_component:SetVisible(true)
			local favour_tier_component = favour_bar_component:SequentialFind(deities.component_ids.god_slot_tier)
			local favour_amount_text_component = favour_bar_component:SequentialFind(deities.component_ids.god_slot_favour_amount_text)

			local faction_key = cm:get_local_faction_name(true)
			local tier = deities.get_tier(faction_key, god_slot.god_key)
			if favour_tier_component then
				favour_tier_component:SetText(tier)
			end
			if favour_amount_text_component then
				local tiers = deities.get_god_tiers(faction_key, god_slot.god_key)
				local txt = god_slot.favour.total_favour .. "/"
				if tier < #tiers then
					tier = tier + 1
				end
				txt = txt .. deities.config.favour_tiers[tier]
				favour_amount_text_component:SetText(txt)
			end
		else
			favour_bar_component:SetVisible(false)
		end
	end,

	init_army_button_component = function(army_holder_component, dev_button_pray, god_slot_index, devoted_general_index)
		local army_button_component = UIComponent(army_holder_component:CreateFromComponent(deities.ui_data.templates.army_button_template:Address(), deities.component_ids.devoted_general_instance_prefix .. devoted_general_index))
		-- Save for replacing with selected general
		deities.ui_data.god_slot_army_button_components[god_slot_index] = army_button_component
		army_button_component:SetProperty(deities.component_ids.god_slot_index_property, god_slot_index)
		army_button_component:SetProperty(deities.component_ids.devoted_general_index_property, devoted_general_index)
		army_button_component:SetProperty(deities.component_ids.army_selector_open_property, "false")

		local set_army_button_tooltip = true

		local army_portrait_component = army_button_component:SequentialFind("army_portrait")
		if army_portrait_component then
			army_portrait_component:SetVisible(false)
			army_portrait_component:SetTooltipText("{{tt:" .. deities.tooltips.army_slot .. "}}", "", true)
		end

		local cco_table = {}

		local title_source = "ui_text_replacements_localised_text_" .. deities.text_ids.army_slot_tooltip.title
		local title_localised = common:get_localised_string(title_source)
		cco_table.Title = title_localised

		local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.army_slot_tooltip.text
		local text_localised = common:get_localised_string(text_source)
		cco_table.Text = text_localised

		local faction_key = cm:get_local_faction_name(true)
		local god_slots = deities.get_god_slots(faction_key)
		if god_slots[god_slot_index] then
			if god_slots[god_slot_index].god_key then
				local god_key = god_slots[god_slot_index].god_key
				--DEV_UI
				if dev_button_pray then
					common.set_context_value(deities.component_ids.dev_button_pray_prefix .. god_slot_index, 0)
					local lua_cmd = "dev_ui#" .. god_slot_index
					dev_button_pray:SetProperty("lua_cmd", lua_cmd)
				end

				if not deities.is_devoted_general_unlocked(faction_key, god_key, devoted_general_index) then
					local low_tier_source = "ui_text_replacements_localised_text_" .. deities.text_ids.army_slot_tooltip.low_tier
					local low_tier_localised = common:get_localised_string(low_tier_source)
					cco_table.Warning = low_tier_localised

					army_button_component:SetState("locked_tier")
				else
					local devoted_general_family_member_cqi = deities.get_devoted_general_family_cqi(faction_key, god_key, devoted_general_index)
					if devoted_general_family_member_cqi then
						army_button_component:SetState("devoted")
						local general = deities.get_devoted_general(faction_key, god_key, devoted_general_index)
						local cco_character = cco("CcoCampaignCharacter", general:command_queue_index())
						army_button_component:SetContextObject(cco_character)
						if army_portrait_component then
							army_portrait_component:SetVisible(true)
						end

						set_army_button_tooltip = false

						if dev_button_pray then
							if general then
								local force_cqi = general:military_force():command_queue_index()
								local lua_cmd = "dev_ui#deities.make_prayer(\"" .. tostring(faction_key) .. "\", \"" .. tostring(god_key) ..  "\", " .. force_cqi ..")"
								dev_button_pray:SetProperty("lua_cmd", lua_cmd)
							end
							common.set_context_value(deities.component_ids.dev_button_pray_prefix .. god_slot_index, 1)
						end
					else
						local choose_source = "ui_text_replacements_localised_text_" .. deities.text_ids.army_slot_tooltip.choose
						local choose_localised = common:get_localised_string(choose_source)
						cco_table.Action = choose_localised

						army_button_component:SetState("available")
					end
				end
			else
				if god_slot_index > deities.get_faction_god_slots_count(faction_key) then
					local unlock_source = "ui_text_replacements_localised_text_" .. deities.text_ids.army_slot_tooltip.unlock
					local unlock_localised = common:get_localised_string(unlock_source)
					cco_table.Warning = unlock_localised

					army_button_component:SetState("locked")
				else
					local worship_source = "ui_text_replacements_localised_text_" .. deities.text_ids.army_slot_tooltip.worship
					local worship_localised = common:get_localised_string(worship_source)
					cco_table.Warning = worship_localised

					army_button_component:SetState("locked_empty")
				end
			end
		end

		local script_id = "army_tooltip_" .. god_slot_index
		if set_army_button_tooltip then
			army_button_component:SetTooltipText("{{tt:" .. deities.tooltips.army_slot .. "}}", "", true)
			army_button_component:SetProperty("script_id", script_id)
		end
		army_portrait_component:SetProperty("script_id", script_id)
		common.set_context_value(script_id, cco_table)
	end,

	init_worship_slot_tooltip = function(component, state, slot_index, is_from_faction_summary)
		local is_from_faction_summary = not not is_from_faction_summary
		component:SetTooltipText("{{tt:" .. deities.tooltips.worship_slot .. "}}", "", true)

		local cco_table = {}

		cco_table.Title = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.worship_slot_label_key)

		if state == "unlocked" then
			cco_table.Text = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.worship_slot_choose_god)
		elseif state == "locked" then
			-- this technology will increase the deities.config.extra_god_slots_bonus_value, unlocking the slot
			local tech_key_index = slot_index - deities.config.init_god_slots
			-- If already researched the tech for the 3rd slot, show the tech for the 2nd slot on the remaining one
			if cm:get_local_faction(true):has_technology(deities.config.technologies[tech_key_index]) then
				for index, technology in ipairs(deities.config.technologies) do
					if not cm:get_local_faction(true):has_technology(technology) then
						tech_key_index = index
						break
					end
				end
			end
			cco_table.TechKey = deities.config.technologies[tech_key_index]
			cco_table.Warning = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.worship_slot_tech_warning)
		end

		if is_from_faction_summary and feature_unlock.is_feature_unlocked_for_faction(cm:get_local_faction_name(true), feature_ids_config.local_deities) then
			cco_table.Action = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.worhip_slot_faction_summary_redirect_key)
		end

		local script_id = "worship_tooltip_" .. slot_index

		component:SetProperty("script_id", script_id)
		common.set_context_value(script_id, cco_table)
	end,

	init_favour_tooltip = function(component, god_slot, is_from_faction_summary)
		local is_from_faction_summary = not not is_from_faction_summary
		component:SetTooltipText("{{tt:" .. deities.tooltips.favour .. "}}", "", true)

		local cco_table = {}

		local localised_text = deities.get_localised_text(god_slot.god_key)
		cco_table.Title = localised_text.name

		local god = deities.get_god(god_slot.god_key)
		if god and god.god_slot_image then
			cco_table.IconPath = god.god_slot_image
		end

		local faction_key = cm:get_local_faction_name(true)
		local tiers = deities.get_god_tiers(faction_key, god_slot.god_key)
		local tier = deities.get_tier(faction_key, god_slot.god_key)
		if tiers and tier then
			cco_table.Value = god_slot.favour.total_favour
			if tier < #tiers then
				tier = tier + 1
			end
			cco_table.Total = deities.config.favour_tiers[tier]
		end

		local worshipped_god_text = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.favour_tooltip_worshipped_god)
		cco_table.Type = worshipped_god_text

		local progress_text = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.favour_tooltip_progress_to_next_tier)
		cco_table.ProgressName = progress_text

		local positive_factors_text = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.favour_tooltip_positive_factors)
		cco_table.PositiveFactorsName = positive_factors_text

		cco_table.PositiveFactors = {}

		for factor_name, value in pairs(god_slot.favour) do
			if value > 0 and factor_name ~= "total_favour" and deities.text_ids.favour_factors[factor_name]then
				local factor_source = "ui_text_replacements_localised_text_" .. deities.text_ids.favour_factors[factor_name]
				local factor_localised = common.get_localised_string(factor_source)
				table.insert(cco_table.PositiveFactors, { Name = factor_localised, Value = value})
			end
		end

		local favour_text = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.favour_tooltip_favour)
		cco_table.TotalList =
		{
			{
				Name = favour_text,
				Value = god_slot.favour.total_favour,
			}
		}

		cco_table.Description = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.favour_tooltip_favour_description);

		if is_from_faction_summary and feature_unlock.is_feature_unlocked_for_faction(cm:get_local_faction_name(true), feature_ids_config.local_deities) then
			cco_table.Action = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.component_ids.worhip_slot_faction_summary_redirect_key)
		end

		local script_id = "favour_tooltip_" .. god_slot.god_key

		component:SetProperty("script_id", script_id)
		common.set_context_value(script_id, cco_table)
	end,

	init_god_card_templates = function()
		if deities.ui_data.templates.god_card_templates	then
			return
		end

		deities.ui_data.templates.god_card_templates = {}

		-- get the god templates for each culture
		local gods_list_component = deities.panel:SequentialFind(deities.component_ids.gods_list)
		if gods_list_component then
			for i = 1, #deities.component_ids.culture_tabs do
				local current_tab_content = gods_list_component:SequentialFind(deities.component_ids.culture_tabs[i])
				if current_tab_content then
					local god_template = current_tab_content:SequentialFind(deities.component_ids.god_culture_tab_holder,
						deities.component_ids.god_template)
					if god_template then
						god_template:DivorceFromParent()
						deities.ui_data.templates.god_card_templates[i] = god_template
					end
				end
			end
		end
	end,

	init_god_slot_ui_template = function()
		if deities.ui_data.templates.god_slot_template
			and deities.ui_data.templates.army_button_template
			and deities.ui_data.templates.aten_god_slot_template
		then
			return
		end

		local god_slot_template = deities.panel:SequentialFind(deities.component_ids.god_slot_template)
		if not god_slot_template then
			return
		end

		local army_button_component = deities.panel:SequentialFind(deities.component_ids.god_slot_army_button)
		if not army_button_component then
			return
		end

		local aten_god_slot_template = deities.panel:SequentialFind(
			deities.component_ids.worshipped_gods_holder,
			deities.component_ids.aten_god_slot_template)

		if not aten_god_slot_template then
			return
		end

		local aten_army_button = aten_god_slot_template:SequentialFind(deities.component_ids.god_slot_army_button)
		if aten_army_button then
			aten_army_button:DivorceFromParent()
		end

		army_button_component:DivorceFromParent()
		deities.ui_data.templates.army_button_template = army_button_component

		god_slot_template:DivorceFromParent()
		deities.ui_data.templates.god_slot_template = god_slot_template

		aten_god_slot_template:DivorceFromParent()
		deities.ui_data.templates.aten_god_slot_template = aten_god_slot_template
	end,

	init_lock_ui_template = function()
		if deities.ui_data.templates.tier_template and
			deities.ui_data.templates.hecatomb_tier_template then
			return
		end

		local selected_god_component = deities.panel:SequentialFind(deities.component_ids.selected_god)
		if not selected_god_component then
			return
		end

		local tier_holder_component = selected_god_component:SequentialFind(deities.component_ids.tier_holder)
		if not tier_holder_component then
			return
		end

		local tier_template = selected_god_component:SequentialFind(deities.component_ids.tier_template)
		if not tier_template then
			return
		end
		tier_holder_component:Divorce(tier_template:Address())

		deities.ui_data.templates.tier_template = tier_template

		local hecatomb_tier_template = selected_god_component:SequentialFind(deities.component_ids.hecatomb_tier_template)
		if not hecatomb_tier_template then
			return
		end
		tier_holder_component:Divorce(hecatomb_tier_template:Address())

		deities.ui_data.templates.hecatomb_tier_template = hecatomb_tier_template
	end,

	init_aten_bonus_template = function()
		if deities.ui_data.templates.aten_bonus_template then
			return
		end

		local aten_bonus_template = deities.panel:SequentialFind(
			deities.component_ids.aten_panel,
			deities.component_ids.aten_bonus_template)

		if not aten_bonus_template then
			return
		end

		aten_bonus_template:DivorceFromParent()
		deities.ui_data.templates.aten_bonus_template = aten_bonus_template
	end,

	init_army_template = function()
		if deities.ui_data.templates.army_template and
			deities.ui_data.templates.no_generals_template
		then
			return
		end

		local army_template = deities.panel:SequentialFind(deities.component_ids.army_template)
		if not army_template then
			return
		end

		army_template:DivorceFromParent()
		deities.ui_data.templates.army_template = army_template

		local no_generals_template = deities.panel:SequentialFind(deities.component_ids.no_general_txt)
		if not no_generals_template then
			return
		end

		no_generals_template:DivorceFromParent()
		deities.ui_data.templates.no_generals_template = no_generals_template
	end,

	init_god_for_shrines_template = function()
		if deities.ui_data.templates.god_for_shrines then
			return
		end

		local shrines_and_temples_holder = deities.panel:SequentialFind(deities.component_ids.shrines_and_temples_holder)
		if not shrines_and_temples_holder then
			return
		end

		local shrines_content = shrines_and_temples_holder:SequentialFind(deities.component_ids.shrines_content)
		if not shrines_content then
			return
		end

		local shrines_gods_holder = shrines_content:SequentialFind(deities.component_ids.shrines_gods_holder)
		if not shrines_gods_holder then
			return
		end

		local shrines_god_template = shrines_gods_holder:SequentialFind(deities.component_ids.shrines_god_template)
		if not shrines_god_template then
			return
		end

		shrines_gods_holder:Divorce(shrines_god_template:Address())

		deities.ui_data.templates.god_for_shrines = shrines_god_template
	end,

	init_shrine_location_and_toggle_template = function()
		if deities.ui_data.templates.shrines_toggle_template
			and deities.ui_data.templates.shrines_location_template
			and deities.ui_data.no_shrines_template
			and deities.ui_data.no_temples_template
			and deities.ui_data.no_dwellings_template
			and deities.ui_data.no_idols_template then
			return
		end

		local location_template = deities.panel:SequentialFind(
			deities.component_ids.shrines_and_temples_holder,
			deities.component_ids.shrines_content,
			deities.component_ids.shrines_parent,
			deities.component_ids.shrines_expanding_list_items,
			deities.component_ids.shrines_location_template)

		if not location_template then
			return
		end

		local shrines_toggle_template = location_template:SequentialFind(
			deities.component_ids.shrines_toggles,
			deities.component_ids.shrines_toggle_holder,
			deities.component_ids.shrines_toggle_template)

		if not shrines_toggle_template then
			return
		end

		local no_shrines_template = deities.panel:SequentialFind(deities.component_ids.no_shrines_text)
		if not no_shrines_template then
			return
		end

		local no_temples_template = deities.panel:SequentialFind(deities.component_ids.no_temples_text)
		if not no_temples_template then
			return
		end

		local no_dwellings_template = deities.panel:SequentialFind(deities.component_ids.no_dwellings_text)
		if not no_dwellings_template then
			return
		end

		local no_idols_template = deities.panel:SequentialFind(deities.component_ids.no_idols_text)
		if not no_idols_template then
			return
		end

		no_shrines_template:DivorceFromParent()
		deities.ui_data.templates.no_shrines_template = no_shrines_template

		no_temples_template:DivorceFromParent()
		deities.ui_data.templates.no_temples_template = no_temples_template

		no_dwellings_template:DivorceFromParent()
		deities.ui_data.templates.no_dwellings_template = no_dwellings_template

		no_idols_template:DivorceFromParent()
		deities.ui_data.templates.no_idols_template = no_idols_template

		shrines_toggle_template:DivorceFromParent()
		deities.ui_data.templates.shrines_toggle_template = shrines_toggle_template

		location_template:DivorceFromParent()
		deities.ui_data.templates.shrines_location_template = location_template
	end,

	init_rededicate_god_button_template = function()
		if deities.ui_data.templates.rededicate_god_template then
			return
		end

		local dialogue_component = deities.panel:SequentialFind(deities.component_ids.rededicate_dialogue)
		if not dialogue_component then
			return
		end

		local gods_holder = dialogue_component:SequentialFind(deities.component_ids.rededicate_dialogue_gods_holder)
		if not gods_holder then
			return
		end

		local god_template = gods_holder:SequentialFind(deities.component_ids.rededicate_dialogue_god_template)
		if not god_template then
			return
		end

		gods_holder:Divorce(god_template:Address())
		deities.ui_data.templates.rededicate_god_template = god_template
	end,

	init_aten_creation_god_templates = function()
		if deities.ui_data.templates.aten_creation_god_template
			and deities.ui_data.templates.aten_god_creation_god_holder then
			return
		end

		local aten_creation_component = deities.panel:SequentialFind(deities.component_ids.aten_creation)
		if not aten_creation_component then
			return
		end

		local pool_and_effects_holder = aten_creation_component:SequentialFind(deities.component_ids.aten_pool_and_effects_holder)
		if not pool_and_effects_holder then
			return
		end

		local aten_pool_and_effects_list_box = pool_and_effects_holder:SequentialFind(deities.component_ids.aten_pool_and_effects_list_box)
		if not aten_pool_and_effects_list_box then
			return
		end

		local holder_component = aten_creation_component:SequentialFind(deities.component_ids.aten_creation_god_holder)
		if not holder_component then
			return
		end

		local god_template_component = holder_component:SequentialFind(deities.component_ids.aten_creation_god_template)
		if not god_template_component then
			return
		end

		holder_component:Divorce(god_template_component:Address())
		deities.ui_data.templates.aten_creation_god_template = god_template_component

		aten_pool_and_effects_list_box:Divorce(holder_component:Address())
		deities.ui_data.templates.aten_god_creation_god_holder = holder_component
	end,

	init_aten_creation_god_bonus_effect_templates = function()
		if deities.ui_data.templates.aten_shrines_effects_holder_template
			and deities.ui_data.templates.aten_prayers_effects_holder_template
			and deities.ui_data.templates.aten_devoted_armies_effects_holder_template
		then
			return
		end

		local aten_bonus_effects_holder = deities.panel:SequentialFind(deities.component_ids.aten_bonus_effects_holder)
		if not aten_bonus_effects_holder then
			return
		end

		local aten_bonus_effects_holder_list_box = aten_bonus_effects_holder:SequentialFind(deities.component_ids.aten_bonus_effects_holder_list_box)
		if not aten_bonus_effects_holder_list_box then
			return
		end

		local shrines_effects_holder_template = aten_bonus_effects_holder_list_box:SequentialFind(deities.component_ids.aten_bonus_effects_shrines_holder)
		if shrines_effects_holder_template then
			shrines_effects_holder_template:DivorceFromParent()
			deities.ui_data.templates.aten_shrines_effects_holder_template = shrines_effects_holder_template
		end

		local prayers_effects_holder_template = aten_bonus_effects_holder_list_box:SequentialFind(deities.component_ids.aten_bonus_effects_prayers_holder)
		if prayers_effects_holder_template then
			prayers_effects_holder_template:DivorceFromParent()
			deities.ui_data.templates.aten_prayers_effects_holder_template = prayers_effects_holder_template
		end

		local devoted_armies_effects_holder_template = aten_bonus_effects_holder_list_box:SequentialFind(deities.component_ids.aten_bonus_effects_devoted_armies_holder)
		if devoted_armies_effects_holder_template then
			devoted_armies_effects_holder_template:DivorceFromParent()
			deities.ui_data.templates.aten_devoted_armies_effects_holder_template = devoted_armies_effects_holder_template
		end
	end,

	init_aten_unlockable_template = function()
		if deities.ui_data.templates.aten_unlockable then
			return
		end

		local unlockable_template = deities.panel:SequentialFind(deities.component_ids.aten_unlockable_template)
		if not unlockable_template then
			return
		end

		unlockable_template:DivorceFromParent()
		deities.ui_data.templates.aten_unlockable = unlockable_template
	end,

	init_resource_template = function()
		if deities.ui_data.templates.resource_template then
			return
		end

		local resource_template = deities.panel:SequentialFind(
			deities.component_ids.shrines_and_temples_holder,
			deities.component_ids.resources_template)

		if not resource_template then
			return
		end

		resource_template:DivorceFromParent()
		deities.ui_data.templates.resource_template = resource_template
	end,

	init_realm_name_template = function()
		if deities.ui_data.templates.realm_name_template then
			return
		end

		local realm_name_template = deities.panel:SequentialFind(
			deities.component_ids.realms_list_holder,
			deities.component_ids.realm_name_template)

		if not realm_name_template then
			return
		end

		realm_name_template:DivorceFromParent()
		deities.ui_data.templates.realm_name_template = realm_name_template
	end,

	init_rededication_result_template = function()
		if deities.ui_data.templates.rededication_result then
			return
		end

		local result_template = deities.panel:SequentialFind(deities.component_ids.rededicate_dialogue,
			deities.component_ids.worship_result_template)

		if not result_template then
			return
		end

		result_template:DivorceFromParent()
		deities.ui_data.templates.rededication_result = result_template
	end,

	init_ui_templates = function()
		deities.init_army_template()
		deities.init_god_card_templates()
		deities.init_god_slot_ui_template()
		deities.init_lock_ui_template()
		deities.init_aten_bonus_template()
		deities.init_god_for_shrines_template()
		deities.init_shrine_location_and_toggle_template()
		deities.init_rededicate_god_button_template()
		deities.init_aten_creation_god_templates()
		deities.init_aten_creation_god_bonus_effect_templates()
		deities.init_aten_unlockable_template()
		deities.init_resource_template()
		deities.init_realm_name_template()
		deities.init_rededication_result_template()
	end,

	delete_ui_templates = function()
		for name, template in pairs(deities.ui_data.templates) do
			if is_table(template) then
				for nested_name, nested_template in pairs(template) do
					nested_template:Destroy()
					deities.ui_data.templates[name][nested_name] = nil
				end
			else
				template:Destroy()
			end
			deities.ui_data.templates[name] = nil
		end
	end,

	get_selected_god_component = function()
		local god_key = deities.ui_data.selected_god
		local selected_god_component
		if god_key == deities.config.aten_god_key then
			return deities.panel:SequentialFind(deities.component_ids.aten_panel)
		else
			return deities.panel:SequentialFind(deities.component_ids.selected_god)
		end
	end,

	hide_not_selected_god_component = function()
		local god_key = deities.ui_data.selected_god
		local not_selected_component
		if god_key == deities.config.aten_god_key then
			not_selected_component = deities.panel:SequentialFind(deities.component_ids.selected_god)
		else
			not_selected_component = deities.panel:SequentialFind(deities.component_ids.aten_panel)
		end
		if not_selected_component then
			not_selected_component:SetVisible(false)
		end
	end,

	display_discovered_god_animation = function(gods)
		if not is_table(gods) or #gods == 0 then
			return
		end

		local discovered_god_animation = core:get_or_create_component("discovered_god_animation", deities.component_ids.discovered_layout_path)
		local god_template = discovered_god_animation:SequentialFind(deities.component_ids.god_portrait)
		if not god_template then
			return
		end

		god_template:DivorceFromParent()

		local gods_holder = discovered_god_animation:SequentialFind(deities.component_ids.gods_holder)
		if not gods_holder then
			return
		end

		for _, god_key in ipairs(gods) do
			local new_god_component = UIComponent(gods_holder:CreateFromComponent(god_template:Address(), string.format(deities.component_ids.god_instance_prefix .. god_key)))
			local portrait_component = new_god_component:SequentialFind(deities.component_ids.god_slot_portrait_button)
			if portrait_component then
				local god_data = deities.get_god(god_key)
				if god_data then
					portrait_component:SetImagePath(god_data.god_slot_image, 0)
					local button_component = portrait_component:SequentialFind(deities.component_ids.god_slot_portrait_button)
					button_component:SetProperty(deities.component_ids.god_key_property, god_key)

					cco_table = {}
					local script_id = "discovered_god_" .. god_key
					button_component:SetTooltipText("{{tt:" .. deities.tooltips.discovered_god .. "}}", "", true)
					cco_table.Title = deities.get_localised_text(god_key).name

					local local_faction = cm:get_local_faction_name(true)
					if feature_unlock.is_feature_unlocked_for_faction(local_faction, feature_ids_config.local_deities) then
						cco_table.Action = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.text_ids.click_discovered_god_tooltip)
					else
						button_component:SetState("inactive")
					end

					button_component:SetProperty("script_id", script_id)
					common.set_context_value(script_id, cco_table)
				end
			end
		end
	end,

	hide_discovered_god_animation = function()
		local discovered_god_animation = core:get_or_create_component("discovered_god_animation", deities.component_ids.discovered_layout_path)
		if discovered_god_animation then
			discovered_god_animation:SetVisible(false)
		end
	end,

	open_selected_god = function(god_key)
		deities.ui_data.selected_god = god_key

		local selected_god_component = deities.get_selected_god_component()
		if not selected_god_component then
			return
		end
		deities.hide_not_selected_god_component()
		deities.hide_god_slots()
		deities.hide_all_gods()

		deities.toggle_aten_background(false)

		local faction_key = cm:get_local_faction_name(true)
		local is_discovered = deities.has_faction_discovered_god(faction_key, god_key)

		common:set_context_value(deities.context_values.switch_all_gods_description, "hide")

		deities.refresh_favour_cheat_ui(faction_key, god_key)

		deities.toggle_worshipped_gods_tabs_visibility(false)

		local undiscovered_warning = selected_god_component:SequentialFind(deities.component_ids.undiscovered_warning)
		if deities.get_god_slot(faction_key, god_key) or deities.has_faction_created_aten(faction_key) then
			deities.toggle_worship_button_visible(false)

			if undiscovered_warning then
				undiscovered_warning:SetVisible(false)
			end
		else
			deities.toggle_worship_button_visible(true)

			if not is_discovered then
				deities.toggle_worship_button_visible(false)

				if undiscovered_warning then
					undiscovered_warning:SetVisible(true)
					local warning_source = "ui_text_replacements_localised_text_" .. deities.component_ids.god_tooltip_undiscovered_warning_key
					local warning_localised =  common.get_localised_string(warning_source)
					undiscovered_warning:SetText(warning_localised, warning_source)
				end
			else
				deities.toggle_worship_button_active(true)

				if undiscovered_warning then
					undiscovered_warning:SetVisible(false)
				end
			end
		end

		local index = table_find(deities.ui_persistent.newly_discovered_gods, god_key, true)
		if index then
			table.remove(deities.ui_persistent.newly_discovered_gods, index)
			deities.update_local_deities_notification()
		end

		deities.toggle_culture_tabs_visibility(false)
		deities.toggle_gods_list_visibility(false)

		selected_god_component:SetVisible(true)
		local localised_text = deities.get_localised_text(god_key)

		local god_name_component = selected_god_component:SequentialFind(deities.component_ids.selected_god_name)
		if god_name_component then
			god_name_component:SetText(localised_text.name, localised_text.name_source)
		end

		local god = deities.get_god(god_key)
		local god_culture_component = selected_god_component:SequentialFind(deities.component_ids.god_culture)
		if god_culture_component then
			local localised_god_culture, text_source = deities.get_localised_culture_title(god.culture)
			god_culture_component:SetText(localised_god_culture, text_source)
			god_culture_component:SetVisible(true)
		end

		local is_worshipped = (deities.get_god_slot(faction_key, god_key) ~= nil)
		local is_favoured = (god_key == deities.get_favoured_god(faction_key))

		local manage_buildings_button
		if deities.is_sea_god(god_key) then
			manage_buildings_button = selected_god_component:SequentialFind(deities.component_ids.idols_holder,
			deities.component_ids.shrines_button)
		else
			manage_buildings_button = selected_god_component:SequentialFind(deities.component_ids.shrines_holder,
			deities.component_ids.shrines_button)
		end

		if manage_buildings_button then
			manage_buildings_button:SetVisible(is_worshipped)
		end

		local god_flavour_component = selected_god_component:SequentialFind(deities.component_ids.selected_god_flavour)
		if god_flavour_component then
			god_flavour_component:SetVisible(true)
			if is_worshipped then
				god_flavour_component:SetVisible(true)
				god_flavour_component:SetText(localised_text.flavour, localised_text.flavour_source)
			elseif not is_discovered then
				god_flavour_component:SetVisible(true)
				god_flavour_component:SetText(localised_text.undiscovered_flavour, localised_text.undiscovered_flavour_source)
			else
				god_flavour_component:SetVisible(false)
			end
		end

		local worshipped_indicator = selected_god_component:SequentialFind(deities.component_ids.worshipped_indicator)
		if worshipped_indicator then
			worshipped_indicator:SetVisible(is_worshipped or is_favoured)
			if is_favoured then
				if is_worshipped then
					worshipped_indicator:SetState("worshipped_patron")
				else
					worshipped_indicator:SetState("patron")
				end
			elseif is_worshipped then
				worshipped_indicator:SetState("worshipped")
			end
		end

		local god_illustration_component = selected_god_component:SequentialFind(deities.component_ids.god_illustration)
		if god_illustration_component then
			if god and god.main_image then
				god_illustration_component:SetImagePath(god.main_image)
			end
		end

		deities.display_favour_bar()
		deities.display_current_bonuses()
		deities.display_cult_centre()
		deities.display_realm_names()
	end,

	display_cult_centre = function()
		local selected_god_component = deities.get_selected_god_component()
		if not selected_god_component then
			return
		end

		local cult_centre_holder_component = selected_god_component:SequentialFind(deities.component_ids.cult_centre_holder)
		if not cult_centre_holder_component then
			return
		end

		local faction_key = cm:get_local_faction_name(true)
		local god_key = deities.ui_data.selected_god
		local is_discovered = deities.has_faction_discovered_god(faction_key, god_key)

		local cult_centre_text_component = cult_centre_holder_component:SequentialFind(deities.component_ids.cult_cenre_txt)
		local cult_centre_zoom_button = cult_centre_holder_component:SequentialFind(deities.component_ids.cult_centre_zoom_button)

		local god = deities.get_god(god_key)
		if cult_centre_holder_component then
			cult_centre_holder_component:SetVisible(god.cult_centre_chain and god.cult_centre_chain ~= "")
		end

		if is_discovered then
			local region_key =  deities.get_god(deities.ui_data.selected_god).cult_centre_region_key
			if region_key then
				if cult_centre_text_component then
					cult_centre_text_component:SetState("default")
				end
				if cult_centre_zoom_button then
					cult_centre_zoom_button:SetVisible(true)
				end
				local region = cm:get_region(region_key)
				if region and not region:is_null_interface() then
					cult_centre_text_component:SetText("[[url]]" .. region:localised_display_name() .. "[[/url]]")
					cult_centre_text_component:SetTooltipText("{{tt:" .. deities.tooltips.cult_centre .. "}}", "", true)

					local cco_table = {}
					cco_table.Title = region:localised_display_name()
					cco_table.Action = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.text_ids.shrine_or_temple_tooltip.click)
					local script_id = "cult_centre_tooltip"
					cult_centre_text_component:SetProperty("script_id", script_id)
					common.set_context_value(script_id, cco_table)
				end
			end
		else
			if cult_centre_text_component then
				cult_centre_text_component:SetState("undiscovered")
				local cult_centre_undiscovered_source = "ui_text_replacements_localised_text_" .. deities.component_ids.cult_centre_undiscovered_key
				local cult_centre_undiscovered_localised = common:get_localised_string(cult_centre_undiscovered_source)
				cult_centre_text_component:SetStateText(cult_centre_undiscovered_localised, cult_centre_undiscovered_source)
			end
			if cult_centre_zoom_button then
				cult_centre_zoom_button:SetVisible(false)
			end
		end
	end,

	display_realm_names = function()
		local selected_god_component = deities.get_selected_god_component()
		if not selected_god_component then
			return
		end

		local realm_holder_component = selected_god_component:SequentialFind(deities.component_ids.realms_list_holder)
		if not realm_holder_component then
			return
		end

		local realm_names_list_component = selected_god_component:SequentialFind(deities.component_ids.realms_list)
		if not realm_names_list_component then
			return
		end

		local god_key = deities.ui_data.selected_god
		local god = deities.get_god(god_key)
		local has_realms = is_table(god.realms) and #god.realms > 0
		realm_holder_component:SetVisible(has_realms)

		if not has_realms then
			return
		end

		realm_names_list_component:DestroyChildren()
		for i = 1, #god.realms do
			local realm_key = god.realms[i]
			local realm_name_component = UIComponent(realm_names_list_component:CreateFromComponent(deities.ui_data.templates.realm_name_template:Address(), realm_key))

			local localised_name = get_localised_random_string_and_source(realm_key)
			realm_name_component:SetText("[[url]]" .. localised_name .. "[[/url]]" .. (i < #god.realms and " ," or ""))
			realm_name_component:SetTooltipText("{{tt:" .. deities.tooltips.realm_name .. "}}", "", true)
			realm_name_component:SetProperty("realm_key", realm_key)

			local cco_table = {}
			cco_table.Title = localised_name
			cco_table.Action = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.text_ids.shrine_or_temple_tooltip.click)
			local script_id = "realm_tooltip_" .. realm_key
			realm_name_component:SetProperty("script_id", script_id)
			common.set_context_value(script_id, cco_table)
		end

	end,

	zoom_to_cult_centre = function()
		local region_key =  deities.get_god(deities.ui_data.selected_god).cult_centre_region_key
		if region_key then
			deities.panel:InterfaceFunction("close_panel")
			cm:scroll_camera_to_settlement(region_key)
		end
	end,

	zoom_to_realm = function(realm_key)
		local regions = phar_realms.get_regions_for_realm(realm_key)

		local min_region_x = nil
		local min_region_y = nil
		local max_region_x = nil
		local max_region_y = nil

		for _, region_key in ipairs(regions) do
			local region = cm:get_region(region_key)
			if region and not region:is_null_interface() then
				local settlement = region:settlement()
				local settlement_x, settlement_y = cm:settlement_display_pos(settlement:key())
				if min_region_x == nil or min_region_x > settlement_x then
					min_region_x = settlement_x
				end

				if min_region_y == nil or min_region_y > settlement_y then
					min_region_y = settlement_y
				end

				if max_region_x == nil or max_region_x < settlement_x then
					max_region_x = settlement_x
				end

				if max_region_y == nil or max_region_y < settlement_y then
					max_region_y = settlement_y
				end
			end
		end

		if min_region_x and min_region_y and max_region_x and max_region_y then
			local realm_mid_x = min_region_x + (max_region_x - min_region_x) / 2
			local realm_mid_y = min_region_y + (max_region_y - min_region_y) / 2

			-- the realm mid point might be over the water or a mountain - basically nothing interesting to the player, so we find the closest settlement
			local closest_region_key = nil
			local closest_distance_squared = nil
			for _, region_key in ipairs(regions) do
				local region = cm:get_region(region_key)
				if region and not region:is_null_interface() then
					local settlement = region:settlement()
					local settlement_x, settlement_y = cm:settlement_display_pos(settlement:key())
					local camera_to_settlement_distance_squared = distance_squared(realm_mid_x, realm_mid_y, settlement_x, settlement_y)

					if closest_distance_squared == nil or camera_to_settlement_distance_squared < closest_distance_squared then
						closest_distance_squared = camera_to_settlement_distance_squared
						closest_region_key = region_key
					end
				end
			end

			deities.panel:InterfaceFunction("close_panel")
			cm:scroll_camera_to_settlement(closest_region_key)
		end
	end,

	display_favour_bar = function()
		local selected_god_component = deities.get_selected_god_component()
		if not selected_god_component then
			return
		end

		local bar_holder_component = selected_god_component:SequentialFind(deities.component_ids.bar_holder)
		if not bar_holder_component then
			return
		end

		bar_holder_component:SetVisible(true)

		local faction_key = cm:get_local_faction_name(true)
		local god_key = deities.ui_data.selected_god

		local bar_base_component = bar_holder_component:SequentialFind(deities.component_ids.bar_base)
		if not bar_base_component then
			return
		end

		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return
		end

		local current_tier = deities.get_tier(faction_key, god_key)

		local total_width, height = bar_base_component:Dimensions()
		local bar_fill_component = selected_god_component:SequentialFind(deities.component_ids.bar_fill)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if bar_fill_component then
			deities.set_favour_bar_fill(total_width, height, bar_fill_component, god_slot, tiers)
		end

		local tier_holder_component = selected_god_component:SequentialFind(deities.component_ids.tier_holder)
		if not tier_holder_component then
			return
		end

		tier_holder_component:DestroyChildren()
		local requires_hecatomb = deities.god_requires_hecatomb(god_key)
		local tier_template = requires_hecatomb and deities.ui_data.templates.hecatomb_tier_template or deities.ui_data.templates.tier_template
		if not tier_template then
			return
		end

		local spacing = total_width / (#tiers - 1) - tier_template:Width()
		tier_holder_component:SetSpacing(spacing, 0)

		-- Hecatomb indicator ended up being hardcoded above the second tier
		local next_hecatomb_index = requires_hecatomb and god_slot and 2 or -1

		for _, component_name in ipairs(deities.component_ids.hecatomb_decorations) do
			local hecatomb_decoration = selected_god_component:SequentialFind(component_name)
			if hecatomb_decoration then
				hecatomb_decoration:SetVisible(requires_hecatomb)
			end
		end

		local faction = cm:get_faction(faction_key)
		for i = 1, #tiers do
			local new_lock_component = UIComponent(tier_holder_component:CreateFromComponent(tier_template:Address(), string.format(deities.component_ids.lock_instance_prefix .. i)))

			local tier_indicator
			if requires_hecatomb then
				tier_indicator = new_lock_component:SequentialFind(deities.component_ids.tier_indicator)
			else
				tier_indicator = new_lock_component
			end

			tier_indicator:SetProperty(deities.component_ids.tier_property, i)

			local hecatomb_button = new_lock_component:SequentialFind(deities.component_ids.hecatomb_button)
			if hecatomb_button then
				if requires_hecatomb and i == next_hecatomb_index then
					hecatomb_button:SetVisible(true)
					deities.set_hecatomb_tooltip(hecatomb_button, faction_key, god_key)
				else
					hecatomb_button:SetVisible(false)
				end

				local hecatomb_cooldown_holder = hecatomb_button:SequentialFind(deities.component_ids.hecatomb_cooldown_holder)
				local cooldown_remaining = deities.get_hecatomb_cooldown_remaining(faction_key)
				if requires_hecatomb
					and (cooldown_remaining > 0
					or not faction:can_afford_resource_cost_object(deities.get_hecatomb_cost(faction_key, god_key)))
				then
					hecatomb_button:SetState("inactive")
					if cooldown_remaining > 0 and hecatomb_cooldown_holder then
						hecatomb_cooldown_holder:SetVisible(true)
						local hecatomb_cooldown_text = hecatomb_cooldown_holder:SequentialFind(deities.component_ids.hecatomb_cooldown_text)
						if hecatomb_cooldown_text then
							hecatomb_cooldown_text:SetText(cooldown_remaining)
						end
					end
				else
					hecatomb_button:SetState("active")
					if hecatomb_cooldown_holder then
						hecatomb_cooldown_holder:SetVisible(false)
					end
				end
			end

			local lock_favour_amount_component = new_lock_component:SequentialFind(deities.component_ids.lock_favour_amount)
			local lock_favour_txt_component
			if lock_favour_amount_component then
				lock_favour_txt_component = lock_favour_amount_component:SequentialFind(deities.component_ids.lock_favour_txt)
			end

			if god_slot then
				if i <= current_tier then
					tier_indicator:SetState("unlocked")
				else
					tier_indicator:SetState("locked")
				end

				if lock_favour_amount_component then
					-- by design we show this only for the next tier to be unlocked
					if i == current_tier + 1 then
						lock_favour_amount_component:SetVisible(true)
						if lock_favour_txt_component then
							lock_favour_txt_component:SetVisible(true)
							lock_favour_txt_component:SetText(god_slot.favour.total_favour .. "/" .. deities.config.favour_tiers[i])
						end
					else
						lock_favour_amount_component:SetVisible(false)
					end
				end
			else
				if lock_favour_amount_component then
					lock_favour_amount_component:SetVisible(false)
				end

				tier_indicator:SetState("locked")
			end

			tier_indicator:SetText(deities.text_ids.roman_numerals[i])
		end
	end,

	set_favour_bar_fill = function(total_width, height, bar_fill_component, god_slot, tiers)
		local fill_width = 0
		if god_slot and god_slot.favour.total_favour > 0 then
			-- Tiers are the same lenght in the UI, but take different favour amounts to fill up
			local tier_fill_width = total_width / (#tiers - 1)
			local faction_key = cm:get_local_faction_name(true)
			local current_tier = deities.get_tier(faction_key, god_slot.god_key)
			if current_tier == #tiers then
				fill_width = total_width
			else
				local current_tier_favour
				if current_tier == 1 then
					current_tier_favour = 0
				else
					current_tier_favour = deities.config.favour_tiers[current_tier]
				end
				local next_tier_favour = deities.config.favour_tiers[current_tier + 1]
				-- Fill completed tiers
				fill_width = (current_tier - 1) * tier_fill_width
				-- Fill progress towards next tier
				local total_favour = god_slot.favour.total_favour
				fill_width = fill_width + ((total_favour - current_tier_favour) / (next_tier_favour - current_tier_favour)) * tier_fill_width
			end

			bar_fill_component:SetVisible(true)
			bar_fill_component:Resize(fill_width, height)
		else
			bar_fill_component:SetVisible(false)
		end
	end,

	init_tier_tooltip = function(component, god_key, tier)
		local god = deities.get_god(god_key)
		if not god then
			return
		end

		local faction_key = cm:get_local_faction_name(true)
		local god_slot = deities.get_god_slot(faction_key, god_key)

		local cco_table = {}

		local tier_source = "ui_text_replacements_localised_text_" .. deities.text_ids.tiers[tier]
		local tier_localised = common.get_localised_string(tier_source)

		cco_table.Name = tier_localised

		-- Currently a custom effect bundle can only be set using set_cco_effect_bundle_from_custom_bundle, hence why the tooltip is
		-- initialised in the OnMouseOn event so that the correct components can be found sequentially
		component:SetTooltipText("{{tt:" .. deities.tooltips.tier .. "}}", "", true)

		local script_id = "tier_tooltip_" .. tostring(god_key) .. tostring(tier)
		component:SetProperty("script_id", script_id)
		common.set_context_value(script_id, cco_table)

		local tooltip_component = core:get_ui_root():SequentialFind("tooltip_effects_deities_container")
		if not tooltip_component then
			return
		end

		local shrines_holder_component = tooltip_component:SequentialFind(deities.component_ids.shrines_holder)
		local idols_holder_component = tooltip_component:SequentialFind(deities.component_ids.idols_holder)
		local prayer_holder_component = tooltip_component:SequentialFind(deities.component_ids.prayer_holder)
		local devoted_holder_component = tooltip_component:SequentialFind(deities.component_ids.devoted_holder)
		local dwellings_holder_component = tooltip_component:SequentialFind(deities.component_ids.dwellings_holder)

		local has_dwellings = deities.has_dwellings(god_key)
		dwellings_holder_component:SetVisible(has_dwellings)

		bonuses = deities.get_bonuses_for_tier(faction_key, god_key, tier, false, false)

		if tier <= deities.config.aten_first_tier_with_unlockables then
			deities.instantiate_tooltip_bonuses(shrines_holder_component, bonuses.shrine_bonuses)
			deities.instantiate_tooltip_bonuses(idols_holder_component, bonuses.idol_bonuses)
			deities.instantiate_tooltip_bonuses(prayer_holder_component, bonuses.prayer_bonuses)
			deities.instantiate_tooltip_bonuses(devoted_holder_component, bonuses.devoted_bonuses)
			deities.instantiate_tooltip_bonuses(dwellings_holder_component, bonuses.dwelling_bonuses)

			local effects_tooltips = tooltip_component:SequentialFind("effects_tooltips")
			if effects_tooltips then
				local all_bonuses = {}
				table_append(all_bonuses, bonuses.shrine_bonuses)
				table_append(all_bonuses, bonuses.idol_bonuses)
				table_append(all_bonuses, bonuses.prayer_bonuses)
				table_append(all_bonuses, bonuses.devoted_bonuses)
				table_append(all_bonuses, bonuses.dwelling_bonuses)
				table_append(all_bonuses, bonuses.unique_bonuses)

				local custom_effect_bundle = deities.get_combined_custom_effect_bundle(all_bonuses)
				effects_tooltips:InterfaceFunction("set_cco_effect_bundle_from_custom_bundle", custom_effect_bundle)
			end
		else
			if shrines_holder_component then
				shrines_holder_component:SetVisible(false)
			end
			if idols_holder_component then
				idols_holder_component:SetVisible(false)
			end
			if prayer_holder_component then
				prayer_holder_component:SetVisible(false)
			end
			if devoted_holder_component then
				devoted_holder_component:SetVisible(false)
			end
		end

		if god_key == deities.config.aten_god_key then
			local unique_holder = tooltip_component:SequentialFind(deities.component_ids.unique_holder)
			if unique_holder then
				if tier >= deities.config.aten_first_tier_with_unlockables then
					unique_holder:SetVisible(true)
					local aten_slot = deities.get_aten_slot(faction_key)

					local no_effect_text = unique_holder:SequentialFind(deities.component_ids.no_effect_text)
					if tier <= #aten_slot.unlockables_per_tier and aten_slot.unlockables_per_tier[tier].bundle then
						if no_effect_text then
							no_effect_text:SetVisible(false)
						end
						local effects_list = unique_holder:SequentialFind("effects_list")
						if effects_list then
							effects_list:SetVisible(true)
						end
						local bundle = cm:create_new_custom_effect_bundle(aten_slot.unlockables_per_tier[tier].bundle.bundle)
						unique_holder:InterfaceFunction("set_cco_effect_bundle_from_custom_bundle", bundle)

						local unique_holder_title_component = unique_holder:SequentialFind(deities.component_ids.unique_holder_title)
						if unique_holder_title_component then
							local category = aten_slot.unlockables_per_tier[tier].category
							local blessing_effect_source = deities.component_ids.blessing_effect_key
							local blessing_effect_key_localised = common:get_localised_string("ui_text_replacements_localised_text_" .. blessing_effect_source)

							local unique_category_source = deities.text_ids.unlockable_categories[category]
							local unique_category_localised = common:get_localised_string("ui_text_replacements_localised_text_" .. unique_category_source)
							unique_holder_title_component:SetText(common.string_safe_format(blessing_effect_key_localised, unique_category_localised), blessing_effect_source)
						end
					elseif no_effect_text then
						no_effect_text:SetVisible(true)
					end
				else
					unique_holder:SetVisible(false)
				end
			end
		end

		local favour_requirement_component = tooltip_component:SequentialFind(deities.component_ids.tier_tooltip_favour_requirement)
		if favour_requirement_component then
			favour_requirement_component:SetVisible(true)
		else
			return
		end
		local favour_value_component = favour_requirement_component:SequentialFind(deities.component_ids.tier_tooltip_favour_value)
		if favour_value_component then
			local tiers = deities.get_god_tiers(faction_key, god_key)
			if not is_table(tiers) then
				return
			end

			local favour_value = tostring(deities.config.favour_tiers[tier])
			favour_value_component:SetText(favour_value)
		end
	end,

	display_current_bonuses = function()
		local selected_god_component = deities.get_selected_god_component()
		if not selected_god_component then
			return
		end

		local faction_key = cm:get_local_faction_name(true)
		local god_key = deities.ui_data.selected_god

		local tier_bonuses_component = selected_god_component:SequentialFind(deities.component_ids.tier_bonuses)
		if not tier_bonuses_component then
			return
		end

		-- Check if worshipped
		local god_slot = deities.get_god_slot(faction_key, god_key)
		local is_worshipped = not not god_slot

		local effects_title_component = selected_god_component:SequentialFind(deities.component_ids.effects_title)
		if effects_title_component then
			effects_title_component:SetVisible(not is_worshipped)
		end

		tier_bonuses_component:SetVisible(true)

		local use_shrines, use_idols = deities.is_using_shrines_or_idols(faction_key, god_key)
		local use_dwellings = deities.has_dwellings(god_key)
		local use_hecatomb = deities.god_requires_hecatomb(god_key)

		local shrines_holder_component = tier_bonuses_component:SequentialFind(deities.component_ids.shrines_holder)
		if shrines_holder_component then
			shrines_holder_component:SetVisible(use_shrines)
		end
		local idols_holder_component = tier_bonuses_component:SequentialFind(deities.component_ids.idols_holder)
		if idols_holder_component then
			idols_holder_component:SetVisible(use_idols)
		end
		local prayer_holder_component = tier_bonuses_component:SequentialFind(deities.component_ids.prayer_holder)
		local devoted_holder_component = tier_bonuses_component:SequentialFind(deities.component_ids.devoted_holder)
		local dwellings_holder_component = tier_bonuses_component:SequentialFind(deities.component_ids.dwellings_holder)
		local hecatomb_holder_component = tier_bonuses_component:SequentialFind(deities.component_ids.hecatomb_holder)
		if hecatomb_holder_component then
			if use_hecatomb then
				hecatomb_holder_component:SetVisible(true)
				deities.display_hecatomb_bonuses(hecatomb_holder_component)
			else
				hecatomb_holder_component:SetVisible(false)
			end
		end

		-- Aten only
		local unique_holder_component = tier_bonuses_component:SequentialFind(deities.component_ids.unique_holder)

		local tier = 0
		local bonuses =
		{
			shrine_bonuses = {},
			idol_bonuses = {},
			prayer_bonuses = {},
			devoted_bonuses = {},
			dwelling_bonuses = {},
			unique_bonuses = {},
		}

		if is_worshipped then
			tier = deities.get_tier(faction_key, god_key)
			bonuses = deities.get_bonuses_for_tier(faction_key, god_key, tier, true, god_key ~= deities.config.aten_god_key)
		elseif god_key == deities.config.aten_god_key then
			bonuses = deities.get_inactive_aten_bonuses(faction_key)
		else
			bonuses = deities.get_bonuses_for_tier(faction_key, god_key, 0, true, false)
		end

		if use_shrines then
			deities.instantiate_bonuses(shrines_holder_component, bonuses.shrine_bonuses, tier >= deities.config.unlock_tiers.shrines)
		end
		if use_idols then
			deities.instantiate_bonuses(idols_holder_component, bonuses.idol_bonuses, tier >= deities.config.unlock_tiers.idols)
		end
		deities.instantiate_bonuses(prayer_holder_component, bonuses.prayer_bonuses, tier >= deities.config.unlock_tiers.prayers)
		deities.instantiate_bonuses(devoted_holder_component, bonuses.devoted_bonuses, tier >= deities.config.unlock_tiers.devoted_generals)
		if use_dwellings then
			dwellings_holder_component:SetVisible(true)
			deities.instantiate_bonuses(dwellings_holder_component, bonuses.dwelling_bonuses, tier >= deities.config.unlock_tiers.dwellings)
		elseif dwellings_holder_component then
			dwellings_holder_component:SetVisible(false)
		end

		if unique_holder_component then
			if #bonuses.unique_bonuses > 0 then
				unique_holder_component:SetVisible(true)
			else
				unique_holder_component:SetVisible(false)
			end
		end

		if god_key == deities.config.aten_god_key then
			deities.instantiate_unlockable_bonuses(shrines_holder_component, prayer_holder_component, devoted_holder_component, unique_holder_component)
		end

		local shrines_icon = shrines_holder_component:SequentialFind(deities.component_ids.shrines_icon)
		if shrines_icon then
			shrines_icon:SetState(tier >= deities.config.unlock_tiers.shrines and "unlocked" or "locked")
		end

		local idols_icon = idols_holder_component:SequentialFind(deities.component_ids.idols_icon)
		if idols_icon then
			idols_icon:SetState(tier >= deities.config.unlock_tiers.idols and "unlocked" or "locked")
		end
		local prayer_icon = prayer_holder_component:SequentialFind(deities.component_ids.prayer_icon)
		if prayer_icon then
			prayer_icon:SetState(tier >= deities.config.unlock_tiers.prayers and "unlocked" or "locked")
		end
		local prayer_description = prayer_holder_component:SequentialFind(deities.component_ids.prayer_description)
		if prayer_description then
			prayer_description:SetState(deities.is_sea_god(god_key) and "sea" or "default")
		end
		local devoted_icon = devoted_holder_component:SequentialFind(deities.component_ids.devoted_icon)
		if devoted_icon then
			devoted_icon:SetState(tier >= deities.config.unlock_tiers.devoted_generals and "unlocked" or "locked")
		end
		if use_dwellings then
			local dwellings_icon = dwellings_holder_component:SequentialFind(deities.component_ids.dwellings_icon)
			if dwellings_icon then
				dwellings_icon:SetState(tier >= deities.config.unlock_tiers.dwellings and "unlocked" or "locked")
			end
		end

		local unlock_tiers = {}
		table.insert(unlock_tiers, deities.config.unlock_tiers.shrines)
		table.insert(unlock_tiers, deities.config.unlock_tiers.idols)
		table.insert(unlock_tiers, deities.config.unlock_tiers.prayers)
		table.insert(unlock_tiers, deities.config.unlock_tiers.devoted_generals)
		table.insert(unlock_tiers, deities.config.unlock_tiers.dwellings)

		local tiers = deities.get_god_tiers(faction_key, god_key)
		local unlock_text_source = "ui_text_replacements_localised_text_" .. deities.component_ids.unlock_category_key
		local unlock_text_localised = common.get_localised_string(unlock_text_source)

		local upgrade_text_source = "ui_text_replacements_localised_text_" .. deities.component_ids.upgrade_category_key
		local upgrade_text_localised = common.get_localised_string(upgrade_text_source)

		local is_discovered = deities.has_faction_discovered_god(faction_key, god_key)
		for index, component_name in ipairs(deities.component_ids.tier_unlock_warnings) do
			local tier_warning = tier_bonuses_component:SequentialFind(component_name)
			if tier_warning then
				local tier_warning_parent = UIComponent(tier_warning:Parent())
				if is_discovered then
					if tier < unlock_tiers[index] then
						tier_warning:SetVisible(true)
						tier_warning_parent:SetVisible(true)
						tier_warning:SetState("unlock")
						tier_warning:SetStateText(string.format(unlock_text_localised, deities.text_ids.roman_numerals[unlock_tiers[index]]), "")
					-- effects won't improve beyond tier 3 for both Aten and the other gods
					elseif tier < deities.config.aten_first_tier_with_unlockables then
						tier_warning:SetVisible(true)
						tier_warning_parent:SetVisible(true)
						tier_warning:SetState("upgrade")
						tier_warning:SetStateText(string.format(upgrade_text_localised, deities.text_ids.roman_numerals[tier + 1]), "")
					else
						tier_warning:SetVisible(false)
						tier_warning_parent:SetVisible(false)
					end
				else
					tier_warning:SetVisible(false)
					tier_warning_parent:SetVisible(false)
				end
			end
		end
	end,

	display_hecatomb_bonuses = function(hecatomb_holder_component)
		local faction_key = cm:get_local_faction_name(true)
		local god_key = deities.ui_data.selected_god

		local cost_component = hecatomb_holder_component:SequentialFind(deities.component_ids.hecatomb_cost)
		if cost_component then
			local cost = deities.get_hecatomb_cost(faction_key, god_key)
			cost:multiply_by(-1)
			cost_component:SetText(cost:to_string())
		end

		local effect_component = hecatomb_holder_component:SequentialFind(deities.component_ids.hecatomb_effect_text)
		if effect_component then
			local localised_text, text_source = deities.get_hecatomb_description()
			effect_component:SetText(localised_text, text_source)
		end
	end,

	get_hecatomb_description = function()
		local faction_key = cm:get_local_faction_name(true)
		local god_key = deities.ui_data.selected_god

		local localised_god_name = deities.get_localised_text(god_key).name

		local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.hecatomb_effect
		local prayer_duration = deities.get_faction_prayer_duration(faction_key, god_key)
		local localised_text = common.string_safe_format(common.get_localised_string(text_source), localised_god_name, tostring(prayer_duration))
		return localised_text, text_source
	end,

	set_hecatomb_tooltip = function(component, faction_key, god_key)
		component:SetTooltipText("{{tt:" .. deities.tooltips.hecatomb .. "}}", "", true)

		local cco_table = {}

		local cost = deities.get_hecatomb_cost(faction_key, god_key)
		local faction = cm:get_local_faction(true)
		cco_table.SufficientResources = faction:can_afford_resource_cost_object(cost)
		cost:multiply_by(-1)
		cco_table.Cost = cost:to_string()

		local bonus_cooldown = deities.get_hecatomb_cooldown_bonus(faction_key)
		cco_table.Cooldown = tostring(deities.config.hecatomb_cooldown + bonus_cooldown)

		cco_table.Warning = ""
		local current_cooldown = deities.get_hecatomb_cooldown_remaining(faction_key)
		if current_cooldown > 0 then
			local warning_source = "ui_text_replacements_localised_text_" .. deities.text_ids.hecatomb_cooldown_warning
			cco_table.Warning = common.get_localised_string(warning_source)
		end
		if not cco_table.SufficientResources then
			if cco_table.Warning ~= "" then
				cco_table.Warning = cco_table.Warning .. "\n"
			end
			local warning_source = "ui_text_replacements_localised_text_" .. deities.text_ids.hecatomb_resources_warning
			cco_table.Warning = cco_table.Warning .. common.get_localised_string(warning_source)
		end

		cco_table.Description = deities.get_hecatomb_description()
		local hecatomb_flavour_source = "ui_text_replacements_localised_text_" .. deities.text_ids.hecatomb_flavour
		cco_table.Flavour = common.get_localised_string(hecatomb_flavour_source)

		local script_id = "hecatomb_tooltip_" .. god_key
		component:SetProperty("script_id", script_id)
		common.set_context_value(script_id, cco_table)
	end,

	instantiate_bonuses = function(holder, bonus_list, active)
		if not holder then
			return
		end

		local bonuses_holder = holder:SequentialFind(deities.component_ids.bonus_holder)
		if not bonuses_holder then
			return
		end

		local custom_effect_bundle = deities.get_combined_custom_effect_bundle(bonus_list)
		bonuses_holder:SetProperty("show_effects_as_active", active and "1" or "0")
		bonuses_holder:InterfaceFunction("set_cco_effect_bundle_from_custom_bundle", custom_effect_bundle)

		local bonus_list_component = bonuses_holder:SequentialFind(deities.component_ids.bonuses_list)
		if bonus_list_component then
			bonus_list_component:SetVisible(#bonus_list > 0)
		end
	end,

	instantiate_unlockable_bonuses = function(shrines_holder, prayers_holder, devoted_holder, unique_holder)
		local aten_bonus_template = deities.ui_data.templates.aten_bonus_template
		if not aten_bonus_template then
			return
		end

		local shrines_aten_bonus_holder = shrines_holder:SequentialFind(deities.component_ids.aten_bonus_holder)
		if shrines_aten_bonus_holder then
			shrines_aten_bonus_holder:DestroyChildren()
		end

		local prayers_aten_bonus_holder = prayers_holder:SequentialFind(deities.component_ids.aten_bonus_holder)
		if prayers_aten_bonus_holder then
			prayers_aten_bonus_holder:DestroyChildren()
		end

		local devoted_aten_bonus_holder = devoted_holder:SequentialFind(deities.component_ids.aten_bonus_holder)
		if devoted_aten_bonus_holder then
			devoted_aten_bonus_holder:DestroyChildren()
		end

		local uniqie_aten_bonus_holder = unique_holder:SequentialFind(deities.component_ids.aten_bonus_holder)
		if uniqie_aten_bonus_holder then
			uniqie_aten_bonus_holder:DestroyChildren()
		end

		local faction_key = cm:get_local_faction_name(true)
		local aten_slot = deities.get_aten_slot(faction_key)
		local aten_tier = deities.get_tier(faction_key, deities.config.aten_god_key)
		if is_table(aten_slot.unlockables_per_tier) then
			for i = 1, #aten_slot.unlockables_per_tier do
				local current_unlockable = aten_slot.unlockables_per_tier[i]
				local new_unlockable_component
				if current_unlockable then
					if current_unlockable.category == deities.unlockable_categories.shrines and shrines_aten_bonus_holder then
						new_unlockable_component = UIComponent(shrines_aten_bonus_holder:CreateFromComponent(aten_bonus_template:Address(), deities.component_ids.aten_unlockable_prefix .. i))
					elseif current_unlockable.category == deities.unlockable_categories.prayer and prayers_aten_bonus_holder then
						new_unlockable_component = UIComponent(prayers_aten_bonus_holder:CreateFromComponent(aten_bonus_template:Address(), deities.component_ids.aten_unlockable_prefix .. i))
					elseif current_unlockable.category == deities.unlockable_categories.devoted_army and devoted_aten_bonus_holder then
						new_unlockable_component = UIComponent(devoted_aten_bonus_holder:CreateFromComponent(aten_bonus_template:Address(), deities.component_ids.aten_unlockable_prefix .. i))
					elseif (current_unlockable.category == deities.unlockable_categories.unique
						or current_unlockable.category == deities.unlockable_categories.extra_general)
						and uniqie_aten_bonus_holder
					then
						new_unlockable_component = UIComponent(uniqie_aten_bonus_holder:CreateFromComponent(aten_bonus_template:Address(), deities.component_ids.aten_unlockable_prefix .. i))
					end

					if new_unlockable_component then
						local tier_holder = new_unlockable_component:SequentialFind(deities.component_ids.tier_holder)
						if tier_holder then
							tier_holder:SetText(deities.text_ids.roman_numerals[i])
						end

						local bonus_holder = new_unlockable_component:SequentialFind(deities.component_ids.bonus_holder)
						if bonus_holder then
							bonus_holder:SetProperty("show_effects_as_active", i <= aten_tier and "1" or "0")
							local bundle = cm:create_new_custom_effect_bundle(current_unlockable.bundle.bundle)
							bonus_holder:InterfaceFunction("set_cco_effect_bundle_from_custom_bundle", bundle)
						end
					end
				end
			end
		end
	end,

	instantiate_tooltip_bonuses = function(holder, bonus_list)
		if not holder then
			return
		end

		if #bonus_list == 0 then
			holder:SetVisible(false)
			return
		end

		local custom_effect_bundle = deities.get_combined_custom_effect_bundle(bonus_list)
		holder:InterfaceFunction("set_cco_effect_bundle_from_custom_bundle", custom_effect_bundle)

		local bonus_list_component = holder:SequentialFind(deities.component_ids.bonuses_list_light)
		if bonus_list_component then
			bonus_list_component:SetVisible(#bonus_list > 0)
		end
	end,

	-- Use include_min_tiers to get the lowest effects for categories that are not yet unlocked
	get_bonuses_for_tier = function(faction_key, god_key, tier, include_min_tiers, include_unlockables)
		local result =
		{
			shrine_bonuses = {},
			idol_bonuses = {},
			prayer_bonuses = {},
			devoted_bonuses = {},
			dwelling_bonuses = {},
			unique_bonuses = {},
		}
		local faction_key = cm:get_local_faction_name(true)

		local tiers = deities.get_god_tiers(faction_key, god_key)
		if not is_table(tiers) then
			return result
		end

		if tier > #tiers then
			deities.output("Could not get bonuses for tier " .. tier .. " for faction" .. tostring(faction_key) .. " for god " .. tostring(god_key), 10)
			return result
		end

		local shrine_tier = tier
		local idol_tier = tier
		local prayer_tier = tier
		local devoted_tier = tier
		local dwelling_tier = tier

		if include_min_tiers then
			shrine_tier = math.max(deities.config.unlock_tiers.shrines, tier)
			idol_tier = math.max(deities.config.unlock_tiers.idols, tier)
			prayer_tier = math.max(deities.config.unlock_tiers.prayers, tier)
			devoted_tier = math.max(deities.config.unlock_tiers.devoted_generals, tier)
			dwelling_tier = math.max(deities.config.unlock_tiers.dwellings, tier)
		end

		local use_shrines, use_idols = deities.is_using_shrines_or_idols(faction_key, god_key)
		local use_dwellings = deities.has_dwellings(god_key)

		if use_shrines and tiers[shrine_tier].shrine_effect_bundles then
			for _, shrine_bundle in ipairs(tiers[shrine_tier].shrine_effect_bundles) do
				table.insert(result.shrine_bonuses, shrine_bundle.bundle)
			end
		end

		if use_idols and tiers[shrine_tier].idol_effect_bundles then
			for _, idol_bundle in ipairs(tiers[idol_tier].idol_effect_bundles) do
				table.insert(result.idol_bonuses, idol_bundle.bundle)
			end
		end
		if tiers[prayer_tier].prayer_effect_bundles then
			for _, prayer_bundle in ipairs(tiers[prayer_tier].prayer_effect_bundles) do
				table.insert(result.prayer_bonuses, prayer_bundle.bundle)
			end
		end
		if tiers[devoted_tier].devoted_effect_bundles then
			for _, devoted_bundle in ipairs(tiers[devoted_tier].devoted_effect_bundles) do
				table.insert(result.devoted_bonuses, devoted_bundle.bundle)
			end
		end

		if use_dwellings and tiers[dwelling_tier].dwelling_effect_bundles then
			for _, dwelling_bundle in ipairs(tiers[dwelling_tier].dwelling_effect_bundles) do
				table.insert(result.dwelling_bonuses, dwelling_bundle.bundle)
			end
		end

		if tier > 0 and tiers[tier].unique_effect_bundles and include_unlockables then
			for _, unique_bundle in ipairs(tiers[tier].unique_effect_bundles) do
				table.insert(result.unique_bonuses, unique_bundle.bundle)
			end
		end

		local aten_slot = deities.get_aten_slot(faction_key)
		if not include_unlockables and is_table(aten_slot.unlockables_per_tier) then
			for i = 1, #aten_slot.unlockables_per_tier do
				local current_unlockable = aten_slot.unlockables_per_tier[i]
				-- TODO: consider idols
				if current_unlockable then
					if current_unlockable.category == deities.unlockable_categories.shrines then
						local index = table_find(result.shrine_bonuses, function(e) return e == current_unlockable.bundle.bundle end, true)
						if index then
							table.remove(result.shrine_bonuses, index)
						end
					elseif current_unlockable.category == deities.unlockable_categories.prayer then
						local index = table_find(result.prayer_bonuses, function(e) return e == current_unlockable.bundle.bundle end, true)
						if index then
							table.remove(result.prayer_bonuses, index)
						end
					elseif current_unlockable.category == deities.unlockable_categories.devoted_army then
						local index = table_find(result.devoted_bonuses, function(e) return e == current_unlockable.bundle.bundle end, true)
						if index then
							table.remove(result.devoted_bonuses, index)
						end
					end
				end
			end
		end
		return result
	end,

	get_inactive_aten_bonuses = function(faction_key)
		local result =
		{
			shrine_bonuses = {},
			idol_bonuses = {},
			prayer_bonuses = {},
			devoted_bonuses = {},
			unique_bonuses = {},
		}

		local aten_slot = deities.get_aten_slot(faction_key)
		if not aten_slot then
			return result
		end

		local tier = deities.get_tier(faction_key, deities.config.aten_god_key)
		if is_table(aten_slot.unlockables_per_tier) then
			for i = tier + 1, #aten_slot.unlockables_per_tier do
				local current_unlockable = aten_slot.unlockables_per_tier[i]
				if current_unlockable.category == deities.unlockable_categories.shrines then
					table.insert(result.shrine_bonuses, current_unlockable.bundle.bundle)
				elseif current_unlockable.category == deities.unlockable_categories.idols then
					table.insert(result.idol_bonuses, current_unlockable.bundle.bundle)
				elseif current_unlockable.category == deities.unlockable_categories.prayer then
					table.insert(result.prayer_bonuses, current_unlockable.bundle.bundle)
				elseif current_unlockable.category == deities.unlockable_categories.devoted_army then
					table.insert(result.devoted_bonuses, current_unlockable.bundle.bundle)
				elseif current_unlockable.category == deities.unlockable_categories.unique or
					current_unlockable.category == deities.unlockable_categories.extra_general then
						table.insert(result.unique_bonuses, current_unlockable.bundle.bundle)
				end
			end
		end

		return result
	end,

	display_religious_buildings = function()
		local apply_button = deities.panel:SequentialFind(
			deities.component_ids.shrines_and_temples_holder,
			deities.component_ids.shrines_button_apply)
		if apply_button then
			apply_button:SetState("inactive")
		end

		for i = #deities.ui_data.shrine_radio_groups, 1, -1 do
			local nested_table = deities.ui_data.shrine_radio_groups[i]
			for j = #nested_table, 1, -1 do
				table.remove(nested_table, j)
			end
			table.remove(deities.ui_data.shrine_radio_groups, i)
		end

		for i = #deities.ui_data.temple_radio_groups, 1, -1 do
			local nested_table = deities.ui_data.temple_radio_groups[i]
			for j = #nested_table, 1, -1 do
				table.remove(nested_table, j)
			end
			table.remove(deities.ui_data.temple_radio_groups, i)
		end

		for i = #deities.ui_data.dwelling_radio_groups, 1, -1 do
			local nested_table = deities.ui_data.dwelling_radio_groups[i]
			for j = #nested_table, 1, -1 do
				table.remove(nested_table, j)
			end
			table.remove(deities.ui_data.dwelling_radio_groups, i)
		end

		for i = #deities.ui_data.idol_radio_groups, 1, -1 do
			local nested_table = deities.ui_data.idol_radio_groups[i]
			for j = #nested_table, 1, -1 do
				table.remove(nested_table, j)
			end
			table.remove(deities.ui_data.idol_radio_groups, i)
		end

		local shrines_and_temples_holder = deities.panel:SequentialFind(deities.component_ids.shrines_and_temples_holder)
		if not shrines_and_temples_holder then
			return
		end

		local shrines_holder = shrines_and_temples_holder:SequentialFind(deities.component_ids.shrines_content)
		if not shrines_holder then
			return
		end

		shrines_and_temples_holder:SetVisible(true)
		shrines_holder:SetVisible(true)

		local shrines_god_holder = shrines_holder:SequentialFind(deities.component_ids.shrines_gods_holder)
		if not shrines_god_holder then
			return
		end
		shrines_god_holder:DestroyChildren()

		local god_ui_template = deities.ui_data.templates.god_for_shrines
		local faction_key = cm:get_local_faction_name(true)
		local god_slots = deities.get_god_slots(faction_key)

		for _, god_data in ipairs(god_slots) do
			if god_data.god_key and shrines_god_holder then
				local new_god_component = UIComponent(shrines_god_holder:CreateFromComponent(god_ui_template:Address(), string.format(deities.component_ids.shrines_god_instance_prefix .. god_data.god_key)))
				local god_portrait_component = new_god_component:SequentialFind(deities.component_ids.shrines_god_portrait)
				local god = deities.get_god(god_data.god_key)
				if god_portrait_component and god and god.god_slot_image then
					god_portrait_component:SetImagePath(god.god_slot_image, 1)
				end

				deities.set_religious_building_counters(new_god_component, god_data)
			end
		end

		local location_template = deities.ui_data.templates.shrines_location_template
		if not location_template then
			return
		end

		local toggle_template = deities.ui_data.templates.shrines_toggle_template
		if not toggle_template then
			return
		end

		local shrines_parent = shrines_holder:SequentialFind(deities.component_ids.shrines_parent)
		if shrines_parent then
			local shrines_expanding_list_items = shrines_parent:SequentialFind(deities.component_ids.shrines_expanding_list_items)
			if shrines_expanding_list_items then
				shrines_expanding_list_items:DestroyChildren()

				local has_shrines = false
				for i, god_data in ipairs(god_slots) do
					if god_data.god_key then
						for _, shrine_region in ipairs(god_data.shrine_regions) do
							deities.populate_religious_building_row(deities.religious_building_types.shrine, shrines_expanding_list_items, shrine_region, nil, god_slots, i, false)
							has_shrines = true
						end

						local shrines_under_conversion = deities.get_shrines_under_conversion(faction_key, god_data.god_key)
						if is_table(shrines_under_conversion) then
							for _, shrine in ipairs(shrines_under_conversion) do
								deities.populate_religious_building_row(deities.religious_building_types.shrine, shrines_expanding_list_items, shrine.region_key, nil, god_slots, i, true)
								has_shrines = true
							end
						end
					end
				end
				if not has_shrines then
					UIComponent(shrines_expanding_list_items:CreateFromComponent(deities.ui_data.templates.no_shrines_template:Address(), deities.component_ids.no_shrines_text))
				end
				shrines_expanding_list_items:SortChildrenByProperties({deities.component_ids.shrines_sorting_porperty, false})
			end
		end

		local temples_parent = shrines_holder:SequentialFind(deities.component_ids.temples_parent)
		if temples_parent then
			local temples_expanding_list_items = temples_parent:SequentialFind(deities.component_ids.temples_expanding_list_items)
			if temples_expanding_list_items then
				temples_expanding_list_items:DestroyChildren()

				local has_temples = false
				for i, god_data in ipairs(god_slots) do
					if god_data.god_key then
						for _, temple in ipairs(god_data.temples) do
							deities.populate_religious_building_row(deities.religious_building_types.temple, temples_expanding_list_items, temple.region_key, nil, god_slots, i, false)
							has_temples = true
						end

						local temples_under_conversion = deities.get_temples_under_conversion(faction_key, god_data.god_key)
						if is_table(temples_under_conversion) then
							for _, temple in ipairs(temples_under_conversion) do
								deities.populate_religious_building_row(deities.religious_building_types.temple, temples_expanding_list_items, temple.region_key, nil, god_slots, i, true)
								has_temples = true
							end
						end
					end
				end
				if not has_temples then
					UIComponent(temples_expanding_list_items:CreateFromComponent(deities.ui_data.templates.no_temples_template:Address(), deities.component_ids.no_temples_text))
				end
				temples_expanding_list_items:SortChildrenByProperties({deities.component_ids.shrines_sorting_porperty, false})
			end
		end

		local dwellings_parent = shrines_holder:SequentialFind(deities.component_ids.dwellings_parent)
		if dwellings_parent then
			if deities.faction_has_dwelling_gods(faction_key) then
				dwellings_parent:SetVisible(true)
				local dwellings_expanding_list_items = dwellings_parent:SequentialFind(deities.component_ids.dwellings_expanding_list_items)
				if dwellings_expanding_list_items then
					dwellings_expanding_list_items:DestroyChildren()

					local has_dwellings = false
					for i, god_data in ipairs(god_slots) do
						if god_data.god_key then
							for _, dwelling_region in ipairs(god_data.dwelling_regions) do
								deities.populate_religious_building_row(deities.religious_building_types.dwelling, dwellings_expanding_list_items, dwelling_region, nil, god_slots, i, false)
								has_dwellings = true
							end

							local dwellings_under_conversion = deities.get_dwellings_under_conversion(faction_key, god_data.god_key)
							if is_table(dwellings_under_conversion) then
								for _, dwelling in ipairs(dwellings_under_conversion) do
									deities.populate_religious_building_row(deities.religious_building_types.dwelling, dwellings_expanding_list_items, dwelling.region_key, nil, god_slots, i, true)
									has_dwellings = true
								end
							end
						end
					end
					if not has_dwellings then
						UIComponent(dwellings_expanding_list_items:CreateFromComponent(deities.ui_data.templates.no_dwellings_template:Address(), deities.component_ids.no_dwellings_text))
					end
					dwellings_expanding_list_items:SortChildrenByProperties({deities.component_ids.shrines_sorting_porperty, false})
				end
			else
				dwellings_parent:SetVisible(false)
			end
		end

		local idols_parent = shrines_holder:SequentialFind(deities.component_ids.idols_parent)
		if idols_parent then
			if deities.faction_has_access_to_idols(cm:get_local_faction_name(true)) then
				idols_parent:SetVisible(true)
				local idols_expanding_list_items = idols_parent:SequentialFind(deities.component_ids.idols_expanding_list_items)
				if idols_expanding_list_items then
					idols_expanding_list_items:DestroyChildren()

					local has_idols = false
					for i, god_data in ipairs(god_slots) do
						if god_data.god_key then
							for _, idol in ipairs(god_data.idols) do
								deities.populate_religious_building_row(deities.religious_building_types.idol, idols_expanding_list_items, nil, idol.force_cqi, god_slots, i, false)
								has_idols = true
							end

							local idols_under_conversion = deities.get_idols_under_conversion(faction_key, god_data.god_key)
							if is_table(idols_under_conversion) then
								for _, idol in ipairs(idols_under_conversion) do
									deities.populate_religious_building_row(deities.religious_building_types.idol, idols_expanding_list_items, nil, idol.force_cqi, god_slots, i, true)
									has_idols = true
								end
							end
						end
					end
					if not has_idols then
						UIComponent(idols_expanding_list_items:CreateFromComponent(deities.ui_data.templates.no_idols_template:Address(), deities.component_ids.no_idols_text))
					end
					idols_expanding_list_items:SortChildrenByProperties({deities.component_ids.shrines_sorting_porperty, false})

					deities.update_idols_radio_buttons()
				end
			else
				idols_parent:SetVisible(false)
			end
		end

		deities.religious_buildings_refresh_cost_and_time()
	end,

	-- there can be only 1 idol per god, so disable some of the radio buttons to not violate this
	update_idols_radio_buttons = function()
		local local_faction_key = cm:get_local_faction_name(true)
		local colummns = deities.get_faction_god_slots_count(local_faction_key)
		-- By column
		local selected_rows = {}
		local original_selection_changed = {}
		for column_index = 1, colummns do
			table.insert(selected_rows, -1)
			table.insert(original_selection_changed, false)
		end

		for row_index = 1, #deities.ui_data.idol_radio_groups do
			local row = deities.ui_data.idol_radio_groups[row_index].components
			local _, selected_god_column = deities.get_selected_god_from_radio_group(row)
			selected_rows[selected_god_column] = row_index
		end

		local god_slots = deities.get_god_slots(local_faction_key)

		-- Check if we have currently selected for idols to be converted from a god
		for row_index = 1, #deities.ui_data.idol_radio_groups do
			local row = deities.ui_data.idol_radio_groups[row_index].components
			local originally_selected_god_key = deities.ui_data.idol_radio_groups[row_index].originally_selected_god_key
			local currently_selected_god_key = deities.get_selected_god_from_radio_group(row)
			if currently_selected_god_key ~= originally_selected_god_key then
				for i = 1, deities.get_faction_god_slots_count(local_faction_key) do
					if god_slots[i].god_key == originally_selected_god_key then
						original_selection_changed[i] = true
						break
					end
				end
			end
		end

		for column_index = 1, colummns do
			if god_slots[column_index].god_key then
				local idol_chain = deities.get_god_idol_chain(god_slots[column_index].god_key)
				if idol_chain and idol_chain ~= "" then
					local selected_row = selected_rows[column_index]
					local set_inactive = selected_row ~= -1 or original_selection_changed[column_index]

					-- Check for idols for the same god that are in construction
					local faction = cm:get_faction(local_faction_key)
					local force_list = faction:military_force_list()
					for i = 0, force_list:num_items() - 1 do
						if set_inactive then
							break
						end
						local force = force_list:item_at(i)
						local force_slots = force:slots()
						if force_slots then
							local last_slot_index = force_slots:num_items() - 1
							for i = 0, last_slot_index do
								local slot = force_slots:item_at(i)
								if slot:is_there_construction() then
									local chain = slot:construction_building_chain_key()
									local idol_chain_god = table_find(deities.gods, function(e) return e.idol_chain == chain end)
									-- Check if the building god matches god_key
									if idol_chain_god and idol_chain_god.key == god_slots[column_index].god_key then
										set_inactive = true
										break
									end
								end
							end
						end
					end

					-- Check for idols being converted from this god
					local conversion_table = deities.get_idols_under_conversion(local_faction_key, god_slots[column_index].god_key)
					if is_table(conversion_table) and not table.is_empty(conversion_table) then
						set_inactive = true
					end

					for row_index = 1, #deities.ui_data.idol_radio_groups do
						local row = deities.ui_data.idol_radio_groups[row_index].components
						if row_index ~= selected_row then
							row[column_index]:SetState(set_inactive and "inactive" or "active")
						end
					end
				end
			end
		end
	end,

	set_religious_building_counters = function(god_component, god_data)
		local god_config = deities.get_god(god_data.god_key)

		local shrines_god_template_shrines_holder = god_component:SequentialFind(deities.component_ids.shrines_god_template_shrines_holder)
		if shrines_god_template_shrines_holder then
			if god_config.shrine_chain and god_config.shrine_chain ~= "" then
				shrines_god_template_shrines_holder:SetVisible(true)
				local shrines_god_template_shrines_count = shrines_god_template_shrines_holder:SequentialFind(deities.component_ids.shrines_god_template_shrines_count)
				if shrines_god_template_shrines_count then
					shrines_god_template_shrines_count:SetText(#god_data.shrine_regions)
				end
			else
				shrines_god_template_shrines_holder:SetVisible(false)
			end
		end

		local shrines_god_template_temples_holder = god_component:SequentialFind(deities.component_ids.shrines_god_template_temples_holder)
		if shrines_god_template_temples_holder then
			if god_config.temple_chain and god_config.temple_chain ~= "" then
				shrines_god_template_temples_holder:SetVisible(true)
				local shrines_god_template_temples_count = shrines_god_template_temples_holder:SequentialFind(deities.component_ids.shrines_god_template_temples_count)
				if shrines_god_template_temples_count then
					shrines_god_template_temples_count:SetText(#god_data.temples)
				end
			else
				shrines_god_template_temples_holder:SetVisible(false)
			end
		end

		local shrines_god_template_dwellings_holder = god_component:SequentialFind(deities.component_ids.shrines_god_template_dwellings_holder)
		if shrines_god_template_dwellings_holder then
			if god_config.dwelling_chain and god_config.dwelling_chain ~= "" then
				shrines_god_template_dwellings_holder:SetVisible(true)
				local dwellings_god_template_temples_count = shrines_god_template_dwellings_holder:SequentialFind(deities.component_ids.shrines_god_template_dwellings_count)
				if dwellings_god_template_temples_count then
					dwellings_god_template_temples_count:SetText(#god_data.dwelling_regions)
				end
			else
				shrines_god_template_dwellings_holder:SetVisible(false)
			end
		end

		local shrines_god_template_idols_holder = god_component:SequentialFind(deities.component_ids.shrines_god_template_idols_holder)
		if shrines_god_template_idols_holder then
			if god_config.idol_chain and god_config.idol_chain ~= "" then
				shrines_god_template_idols_holder:SetVisible(true)
				local shrines_god_template_idols_count = shrines_god_template_idols_holder:SequentialFind(deities.component_ids.shrines_god_template_idols_count)
				if shrines_god_template_idols_count then
					shrines_god_template_idols_count:SetText(#god_data.idols)
				end
			else
				shrines_god_template_idols_holder:SetVisible(false)
			end
		end
	end,

	populate_religious_building_row = function(building_type, expanding_list_items, region_key, force_cqi, god_slots, selected_god_slot_index, is_converting)
		local list_item_prefix
		if building_type == deities.religious_building_types.shrine then
			list_item_prefix = deities.component_ids.shrine_list_item_prefix
		elseif building_type == deities.religious_building_types.temple then
			list_item_prefix = deities.component_ids.temple_list_item_prefix
		elseif building_type == deities.religious_building_types.dwelling then
			list_item_prefix = deities.component_ids.dwelling_list_item_prefix
		elseif building_type == deities.religious_building_types.idol then
			list_item_prefix = deities.component_ids.idol_list_item_prefix
		end

		local new_id
		if region_key then
			new_id = list_item_prefix .. region_key
		else
			new_id = list_item_prefix .. force_cqi
		end

		local new_component = UIComponent(expanding_list_items:CreateFromComponent(deities.ui_data.templates.shrines_location_template:Address(), new_id))
		local index = expanding_list_items:ChildCount()

		local selected_god_key = god_slots[selected_god_slot_index].god_key

		local location_text = new_component:SequentialFind(deities.component_ids.shrines_location_text)
		if location_text then
			if building_type == deities.religious_building_types.shrine
				or building_type == deities.religious_building_types.temple
				or building_type == deities.religious_building_types.dwelling
			then
				location_text:InterfaceFunction("init_region", region_key)
				local slot_index = deities.find_region_slot_index_by_shrine_god_key(region_key, selected_god_key)
				if slot_index then
					location_text:InterfaceFunction("init_region_slot", slot_index)
				else
					deities.output("Error: Did not find shrine for god " .. tostring(selected_god_key) .. " in region " .. tostring(region_key) , 10)
				end
			elseif building_type == deities.religious_building_types.idol then
				location_text:InterfaceFunction("init_force", force_cqi)
			end
		end

		local sorting_property_string = selected_god_slot_index .. (location_text:GetStateText())
		new_component:SetProperty(deities.component_ids.shrines_sorting_porperty, sorting_property_string)
		local location_name = new_component:SequentialFind(deities.component_ids.shrines_location_text)
		if location_name then
			location_name:SetTooltipText("{{tt:" .. deities.tooltips.shrine_or_temple_row .. "}}", "", true)

			local cco_table = {}
			if region_key then
				local region = cm:get_region(region_key)
				if region and not region:is_null_interface() then
					cco_table.Title = region:localised_display_name()
				end
			elseif force_cqi then
				local force = cm:get_military_force_by_cqi(force_cqi)
				local general
				if force then
					general = force:general_character()
				end
				if general then
					cco_table.Title = general:onscreen_name()
				end
			end
			cco_table.Action = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.text_ids.shrine_or_temple_tooltip.click)
			if is_converting then
				if building_type == deities.religious_building_types.shrine then
					cco_table.Alert = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.text_ids.shrine_or_temple_tooltip.shrine_conversion)
				elseif building_type == deities.religious_building_types.temple then
					cco_table.Alert = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.text_ids.shrine_or_temple_tooltip.temple_conversion)
				elseif building_type == deities.religious_building_types.dwelling then
					cco_table.Alert = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.text_ids.shrine_or_temple_tooltip.dwelling_conversion)
				elseif building_type == deities.religious_building_types.idol then
					cco_table.Alert = common.get_localised_string("ui_text_replacements_localised_text_" .. deities.text_ids.shrine_or_temple_tooltip.idol_conversion)
				end
			end
			local script_id
			if building_type == deities.religious_building_types.shrine then
				script_id = "shrine_row_" .. index
			elseif building_type == deities.religious_building_types.temple then
				script_id = "temple_row" .. index
			elseif building_type == deities.religious_building_types.dwelling then
				script_id = "dwelling_row" .. index
			elseif building_type == deities.religious_building_types.idol then
				script_id = "idol_row" .. index
			end
			location_name:SetProperty("script_id", script_id)
			common.set_context_value(script_id, cco_table)
		end

		if is_converting then
			local location_text_component = new_component:SequentialFind(deities.component_ids.shrines_location_text)
			if location_text_component then
				location_text_component:SetState("converting")
			end

			return
		end

		-- Radio buttons
		local radio_button_template = deities.ui_data.templates.shrines_toggle_template:SequentialFind(deities.component_ids.shrines_toggle_template_radio_button)
		if not radio_button_template then
			return
		end

		local new_id
		if region_key then
			new_id = list_item_prefix .. region_key
		elseif force_cqi then
			new_id = list_item_prefix .. force_cqi
		end
		radio_button_template:SetProperty("button_group_parent", new_id)

		local toggle_holder_component = new_component:SequentialFind(deities.component_ids.shrines_toggle_holder)
		if toggle_holder_component then
			-- Save component and region/force for processing when religious building changes are applied
			local radio_groups_table
			if building_type == deities.religious_building_types.shrine then
				radio_groups_table = deities.ui_data.shrine_radio_groups
			elseif building_type == deities.religious_building_types.temple then
				radio_groups_table = deities.ui_data.temple_radio_groups
			elseif building_type == deities.religious_building_types.dwelling then
				radio_groups_table = deities.ui_data.dwelling_radio_groups
			elseif building_type == deities.religious_building_types.idol then
				radio_groups_table = deities.ui_data.idol_radio_groups
			end
			local radio_group =
			{
				region_key = region_key,
				force_cqi = force_cqi,
				originally_selected_god_key = selected_god_key,
				components = {},
			}
			table.insert(radio_groups_table, radio_group)

			local toggle_intance_prefix = ""
			if building_type == deities.religious_building_types.shrine then
				toggle_intance_prefix = deities.component_ids.shrines_toggle_instance_prefix
			elseif building_type == deities.religious_building_types.temple then
				toggle_intance_prefix = deities.component_ids.temples_toggle_instance_prefix
			elseif building_type == deities.religious_building_types.dwellings then
				toggle_intance_prefix = deities.component_ids.dwellings_toggle_instance_prefix
			elseif building_type == deities.religious_building_types.idol then
				toggle_intance_prefix = deities.component_ids.idols_toggle_instance_prefix
			end

			for _, god_data in ipairs(god_slots) do
				if god_data.god_key then
					local new_toggle_component = UIComponent(toggle_holder_component:CreateFromComponent(deities.ui_data.templates.shrines_toggle_template:Address(), string.format(toggle_intance_prefix .. god_data.god_key)))
					local radio_button = new_toggle_component:SequentialFind(deities.component_ids.shrines_toggle_template_radio_button)
					if radio_button then
						radio_button:SetProperty(deities.component_ids.radio_button_god_key_property, god_data.god_key)
						table.insert(radio_groups_table[#radio_groups_table].components, radio_button)
						if god_data.god_key == selected_god_key then
							radio_button:SetState("selected")
						end

						local is_active = false
						if building_type == deities.religious_building_types.shrine or building_type == deities.religious_building_types.temple then
							is_active = not deities.is_sea_god(god_data.god_key)
						elseif building_type == deities.religious_building_types.dwelling then
							local dwelling_chain = deities.get_god_dwelling_chain(god_data.god_key)
							is_active = dwelling_chain and dwelling_chain ~= ""
						elseif building_type == deities.religious_building_types.idol then
							is_active = deities.is_sea_god(god_data.god_key)
						end
						if not is_active then
							radio_button:SetState("inactive")
							local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.religious_building_unavailable[building_type]
							local localised_text = common:get_localised_string(text_source)
							radio_button:SetTooltipText(localised_text, false)
						end
					end
				end
			end
		end
	end,

	update_religious_buildings_group_cost_and_time = function(radio_group, get_chain_function, get_level_function, building_id, total_resource_cost, max_conversion_time)
		local local_faction_key = cm:get_local_faction_name(true)

		for index, current_radio_group in ipairs(radio_group) do
			local selected_god_key = deities.get_selected_god_from_radio_group(current_radio_group.components)

			if selected_god_key ~= current_radio_group.originally_selected_god_key then
				local chain_key = get_chain_function(selected_god_key)
				local level =  0
				if get_level_function then
					level = get_level_function(local_faction_key, current_radio_group[building_id])
				end
				local building_key = cm:get_building_from_building_chain(chain_key, level)
				local convertion_cost_record_key = cm:get_building_conversion_cost_record_key(building_key)

				local current_resource_cost = cm:create_new_custom_resource_cost()

				local bonus_values_list
				local bonus_value_key
				if current_radio_group.force_cqi then
					local force = cm:get_military_force_by_cqi(current_radio_group.force_cqi)
					bonus_values_list = force:bonus_values()
					bonus_value_key = deities.config.bonus_value_military_force_building_conversion
				else
					local region = cm:get_region(current_radio_group.region_key)
					bonus_values_list = region:bonus_values()
					bonus_value_key = deities.config.bonus_value_building_conversion
				end

				local bonus_value = bonus_values_list:building_chain_value(chain_key, bonus_value_key)

				current_resource_cost:get_cost_from_record(convertion_cost_record_key)
				if bonus_value ~= 0 then
					current_resource_cost:multiply_by((100.0 + bonus_value) / 100.0)
				end
				total_resource_cost:add(current_resource_cost)

				-- There are no bonuses that increase/decrease convertion time, so it is equal to the create time
				max_conversion_time = math.max(max_conversion_time, cm:get_building_create_time(building_key))
			end
		end
		return total_resource_cost, max_conversion_time
	end,

	religious_buildings_refresh_cost_and_time = function()
		local resources_holder = deities.panel:SequentialFind(
			deities.component_ids.shrines_and_temples_holder,
			deities.component_ids.resources_holder)

		if not (resources_holder and deities.ui_data.templates.resource_template)then
			return
		end

		local shrines_radio_groups = deities.ui_data.shrine_radio_groups
		local temple_radio_groups = deities.ui_data.temple_radio_groups
		local dwelling_radio_groups = deities.ui_data.dwelling_radio_groups
		local idols_radio_groups = deities.ui_data.idol_radio_groups

		local total_resource_cost = cm:create_new_custom_resource_cost()
		local max_conversion_time = 0

		total_resource_cost, max_conversion_time = deities.update_religious_buildings_group_cost_and_time(shrines_radio_groups, deities.get_god_shrine_chain, nil, nil,total_resource_cost, max_conversion_time)
		total_resource_cost, max_conversion_time = deities.update_religious_buildings_group_cost_and_time(temple_radio_groups, deities.get_god_temple_chain, deities.get_temple_level, "region_key", total_resource_cost, max_conversion_time)
		total_resource_cost, max_conversion_time = deities.update_religious_buildings_group_cost_and_time(dwelling_radio_groups, deities.get_god_dwelling_chain, nil, nil, total_resource_cost, max_conversion_time)
		total_resource_cost, max_conversion_time = deities.update_religious_buildings_group_cost_and_time(idols_radio_groups, deities.get_god_idol_chain, deities.get_idol_level, "force_cqi", total_resource_cost, max_conversion_time)

		local resources = total_resource_cost:resources()
		resources_holder:DestroyChildren()

		local faction = cm:get_local_faction(true)
		local can_afford = faction:can_afford_resource_cost_object(total_resource_cost)

		for index, resource in ipairs(resources) do
			local new_resource_component = UIComponent(resources_holder:CreateFromComponent(deities.ui_data.templates.resource_template:Address(), deities.component_ids.resources_prefix .. index))
			new_resource_component:SetText(-resource[2])
			new_resource_component:SetImagePath(resource[3])
			new_resource_component:SetState(can_afford and "default" or "insufficient")
		end
		UIComponent(resources_holder:Parent()):SetVisible(not table.is_empty(resources))

		local cost_container = deities.panel:SequentialFind(
			deities.component_ids.shrines_and_temples_holder,
			deities.component_ids.resources_cost_container)
		if cost_container then
			cost_container:SetVisible((not table.is_empty(resources)) and max_conversion_time > 0)
		end

		local turns_component = deities.panel:SequentialFind(
			deities.component_ids.shrines_and_temples_holder,
			deities.component_ids.conversion_turns)
		if turns_component then
			turns_component:SetText(max_conversion_time)
		end

		local apply_button = deities.panel:SequentialFind(
		deities.component_ids.shrines_and_temples_holder,
		deities.component_ids.shrines_button_apply)
		if not apply_button then
			return
		end

		if not can_afford then
			apply_button:SetState("inactive")
			local text_source = "ui_text_replacements_localised_text_" .. deities.component_ids.rededicate_dialogue_worship_tooltip_insufficient_resources
			local localised_text = common:get_localised_string(text_source)
			apply_button:SetTooltipText(localised_text, false)
		else
			apply_button:SetState("active")
		end
	end,

	get_selected_god_from_radio_group = function(components)
		local selected_god_key
		local selected_god_index
		for index = 1, #components do
			local radio_button = components[index]
			-- If a button was just clicked it will be in the "down" state, and the old selected button will be in the "selected" state
			local button_state = radio_button:CurrentState()
			if (not selected_god_key) and button_state == "selected" then
				selected_god_key = radio_button:GetProperty(deities.component_ids.radio_button_god_key_property)
				selected_god_index = index
			elseif button_state == "down" or button_state == "selected_down" then
				selected_god_key = radio_button:GetProperty(deities.component_ids.radio_button_god_key_property)
				selected_god_index = index
				break
			end
		end

		return selected_god_key, selected_god_index
	end,

	close_religious_buidings = function()
		local shrines_and_temples_holder = deities.panel:SequentialFind(deities.component_ids.shrines_and_temples_holder)
		if shrines_and_temples_holder then
			shrines_and_temples_holder:SetVisible(false)
		end
	end,

	deselect_all = function()
		deities.close_religious_buidings()
	end,

	refresh_god_info = function()
		deities.open_selected_god(deities.ui_data.selected_god)
		deities.display_favour_bar()
		deities.display_current_bonuses()
	end,

	setup_favoured_god_ui_script_object = function()
		local faction_key = cm:get_local_faction_name(true)

		if not faction_key then
			-- Auto tests safety
			return
		end

		local legitimacy_object = legitimacy_choice:get_unlocked_legitimacy(faction_key)

		if not legitimacy_object then
			-- No legitimacy unlocked yet
			return
		end

		local favoured_god_key = legitimacy_object:get_favoured_deity_key()

		if not favoured_god_key then
			-- Legitimacy path does not support favoured deities or there just isn't one for whatever reason
			return
		end

		local god = deities.get_god(favoured_god_key)

		if not god then
			-- It is alright for this to happen during loading before the favoured god was set
			return
		end

		local tooltip_title = common.get_localised_string(deities.text_ids.favoured_deity.tooltip_title)

		local legitimacy_path_region_name = legitimacy_object.config.sources.local_deities.legitimacy_path_region_name
		local localised_god_info = deities.get_localised_text(favoured_god_key)
		local god_name = localised_god_info.name

		tooltip_title = string.gsub(tooltip_title, "%%1%%", legitimacy_path_region_name)
		tooltip_title = string.gsub(tooltip_title, "%%2%%", god_name)

		local tooltip_text = common:get_localised_string(deities.text_ids.favoured_deity.tooltip_text)
		local icon = god.round_portrait

		local ui_table = {
			god_key = favoured_god_key,
			tooltip_title = tooltip_title,
			tooltip_text = tooltip_text,
			icon = icon,
		}

		local script_id = deities.script_ids.favoured_god_table_script_id
		common.set_context_value(script_id, ui_table)
	end,

--------------------------------------------------------------
------------------------------DEV UI -------------------------
--------------------------------------------------------------

	--DEV_UI: add and remove favour
	refresh_favour_cheat_ui = function(faction_key, god_key)
		if deities.get_god_slot(faction_key, god_key) then
			common.set_context_value(deities.context_values.show_favour_cheats, 1)
		else
			common.set_context_value(deities.context_values.show_favour_cheats, 0)
		end

		local dev_button_add_favour
		if god_key == deities.config.aten_god_key then
			dev_button_add_favour = deities.panel:SequentialFind(deities.component_ids.dev_button_add_favour_aten)
		else
			dev_button_add_favour = deities.panel:SequentialFind(deities.component_ids.dev_button_add_favour)
		end

		if dev_button_add_favour then
			local lua_cmd = "dev_ui#deities.cheat_grant_favour(\"" .. tostring(god_key) .. "\", 10)"
			dev_button_add_favour:SetProperty("lua_cmd", lua_cmd)
		end

		local dev_button_remove_favour
		if god_key == deities.config.aten_god_key then
			dev_button_remove_favour = deities.panel:SequentialFind(deities.component_ids.dev_button_remove_favour_aten)
		else
			dev_button_remove_favour = deities.panel:SequentialFind(deities.component_ids.dev_button_remove_favour)
		end
		if dev_button_remove_favour then
			local lua_cmd = "dev_ui#deities.cheat_grant_favour(\"" .. tostring(god_key) .. "\", -10)"
			dev_button_remove_favour:SetProperty("lua_cmd", lua_cmd)
		end
	end,

	--DEV_UI: prayer
	refresh_pray_cheat = function(faction_key, god_key, dev_button_pray)
		if dev_button_pray then
			local general = deities.get_devoted_general(faction_key, god_key)
			if not general then
				return
			end
			local force_cqi = general:military_force():command_queue_index()
			local lua_cmd = "dev_ui#deities.make_prayer(\"" .. tostring(faction_key) .. "\", \"" .. tostring(god_key) ..  "\", \"" .. force_cqi .."\")"
			dev_button_pray:SetProperty("lua_cmd", lua_cmd)
		end
	end,

--------------------------------------------------------------
------------------------AKHENATEN UI -------------------------
--------------------------------------------------------------
	toggle_aten_creation_panel_visibility = function(visible)
		common.set_context_value(deities.context_values.show_create_aten_panel, visible and 1 or 0)
	end,

	toggle_aten_panel_visibility = function(visible)
		common.set_context_value(deities.context_values.show_aten_panel, visible and 1 or 0)
	end,

	toggle_aten_unlocks_visibility = function(visible)
		common.set_context_value(deities.context_values.show_aten_unlocks, visible and 1 or 0)
	end,

	open_create_aten = function()
		deities.toggle_aten_creation_panel_visibility(true)
		deities.toggle_culture_tabs_visibility(false)
		deities.toggle_gods_list_visibility(false)
		deities.toggle_worshipped_gods_tabs_visibility(false)
		deities.toggle_gods_description(false)
		deities.toggle_selected_god(false)
		deities.hide_god_slots()
		common:set_context_value(deities.context_values.switch_all_gods_description, "hide")

		deities.fill_create_aten_gods()
		deities.update_aten_gods()

		local potential_favour = deities.get_potential_aten_favour()
		common.set_context_value(deities.context_values.aten_potential_favour, tostring(potential_favour))

		local faction_key = cm:get_local_faction_name(true)
		local potential_tier = deities.get_tier_from_favour_amount(potential_favour)
		local txt = tostring(potential_tier) .. "/" .. tostring(#deities.config.favour_tiers)
		common.set_context_value(deities.context_values.aten_potential_tier, txt)
	end,

	fill_create_aten_gods = function()
		if not (deities.ui_data.templates.aten_creation_god_template
			and deities.ui_data.templates.aten_god_creation_god_holder) then
			return
		end
		local aten_creation_component = deities.panel:SequentialFind(deities.component_ids.aten_creation)
		if not aten_creation_component then
			return
		end

		local pool_and_effects_holder = aten_creation_component:SequentialFind(deities.component_ids.aten_pool_and_effects_holder)
		if not pool_and_effects_holder then
			return
		end

		local aten_pool_and_effects_list_box = pool_and_effects_holder:SequentialFind(deities.component_ids.aten_pool_and_effects_list_box)
		if not aten_pool_and_effects_list_box then
			return
		end

		for i = #deities.ui_data.aten_creation_god_components, 1 , -1 do
			table.remove(deities.ui_data.aten_creation_god_components, i)
		end

		aten_pool_and_effects_list_box:DestroyChildren()

		local potential_favour = deities.get_potential_aten_favour()
		local potential_tier = deities.get_tier_from_favour_amount(potential_favour)

		local faction_key = cm:get_local_faction_name(true)
		local discovered_gods = deities.persistent[faction_key].discovered_gods
		local aten_index = table_find(discovered_gods, deities.config.aten_god_key, true)
		if aten_index then
			table.remove(discovered_gods, aten_index)
		end

		if #discovered_gods > 0 then
			local last_god_holder
			local god_counter = 1
			for i, god_key in ipairs(discovered_gods) do
				-- Gods are displayed in 5 columns, the god_holder holds 5 gods horizontally
				if god_counter % 5 == 1 then
					last_god_holder = UIComponent(aten_pool_and_effects_list_box:CreateFromComponent(deities.ui_data.templates.aten_god_creation_god_holder:Address(), deities.component_ids.aten_creation_god_holder_prefix .. i))
				end
				local god = deities.get_god(god_key)
				if god and not deities.is_sea_god(god_key) then
					local cco_god_table = {}
					cco_god_table.key = god
					cco_god_table.portrait = god.god_slot_image
					cco_god_table.name = deities.get_localised_text(god_key).name_source

					deities.ui_data.templates.aten_creation_god_template:SetProperty("script_id", deities.context_values.create_aten_god_table_prefix .. tostring(god_key))
					common.set_context_value(deities.context_values.create_aten_god_table_prefix .. tostring(god_key), cco_god_table)

					local new_god_component = UIComponent(last_god_holder:CreateFromComponent(deities.ui_data.templates.aten_creation_god_template:Address(), deities.component_ids.aten_creation_god_prefix .. tostring(god_key)))
					table.insert(deities.ui_data.aten_creation_god_components, new_god_component)

					-- to be used to determine which god was clicked on
					new_god_component:SetProperty(deities.component_ids.god_key_property, god_key)

					local tiers = deities.get_god_tiers(faction_key, god_key)
					god_counter = god_counter + 1
				end
			end
		end
	end,

	open_aten = function()
		local faction_key = cm:get_local_faction_name(true)
		if not deities.has_faction_created_aten(faction_key) then
			deities.open_create_aten()
			return
		end

		local pending_choices = deities.get_aten_pending_choices(faction_key)
		deities.toggle_aten_panel_visibility(true)
		deities.toggle_aten_unlocks_visibility(pending_choices > 0)

		deities.toggle_aten_creation_panel_visibility(false)
		deities.open_selected_god(deities.config.aten_god_key)
		deities.hide_unlockables()

		deities.refresh_favour_cheat_ui(faction_key, deities.config.aten_god_key)
	end,

	choose_aten_god = function(context)
		local god_component = UIComponent(context.component)
		if not god_component then
			return
		end

		local god_key = god_component:GetProperty(deities.component_ids.god_key_property)
		if not deities.ui_data.aten_god_1 and god_key ~= deities.ui_data.aten_god_2 then
			deities.ui_data.aten_god_1 = god_key
		elseif not deities.ui_data.aten_god_2 and god_key ~= deities.ui_data.aten_god_1 then
			deities.ui_data.aten_god_2 = god_key
		end
		deities.update_aten_gods()
	end,

	set_god_card_active = function(component, active)
		if component then
			if active then
				local god_key = component:GetProperty(deities.component_ids.god_key_property)
				if god_key == deities.ui_data.aten_god_1 or god_key == deities.ui_data.aten_god_2 then
					component:SetState("selected")
				else
					component:SetState("default")
				end
			else
				component:SetState("inactive")
			end

			local name_component = component:SequentialFind(deities.component_ids.aten_creation_god_template_name)
			if name_component then
				name_component:SetState(active and "default" or "inactive")
			end

			local portrait_component = component:SequentialFind(deities.component_ids.aten_creation_god_template_portrait)
			if portrait_component then
				portrait_component:SetState(active and "default" or "inactive")
			end
		end
	end,

	update_aten_gods = function(context)
		local aten_god_1 = deities.panel:SequentialFind(deities.component_ids.aten_god_1)
		if not aten_god_1 then
			return
		end

		local aten_god_2 = deities.panel:SequentialFind(deities.component_ids.aten_god_2)
		if not aten_god_2 then
			return
		end

		local slot_1_component = deities.panel:SequentialFind(deities.component_ids.aten_god_1_slot_holder)
		local slot_2_component = deities.panel:SequentialFind(deities.component_ids.aten_god_2_slot_holder)

		if deities.ui_data.aten_god_1 then
			local god = deities.get_god(deities.ui_data.aten_god_1)
			if god then
				common.set_context_value(deities.context_values.aten_god_1_portrait, god.god_slot_image)
				aten_god_1:SetState("selected_god")
				if slot_1_component then
					slot_1_component:SetState("selected")
				end
			end
		else
			-- for changing the visibility of the X button
			common.set_context_value(deities.context_values.aten_god_1_portrait, "")

			aten_god_1:SetState("default")
			if slot_1_component then
				slot_1_component:SetState("default")
			end
		end

		if deities.ui_data.aten_god_2 then
			local god = deities.get_god(deities.ui_data.aten_god_2)
			if god then
				common.set_context_value(deities.context_values.aten_god_2_portrait, god.god_slot_image)
				aten_god_2:SetState("selected_god")
				if slot_2_component then
					slot_2_component:SetState("selected")
				end
			end
		else
			-- for changing the visibility of the X button
			common.set_context_value(deities.context_values.aten_god_2_portrait, "")

			aten_god_2:SetState("default")
			if slot_2_component then
				slot_2_component:SetState("default")
			end
		end

		-- Change state of the confirm button and gods
		if deities.ui_data.aten_god_1 and deities.ui_data.aten_god_2 then
			common.set_context_value(deities.context_values.confirm_create_aten_active, 1)

			for _, button in ipairs(deities.ui_data.aten_creation_god_components) do
				deities.set_god_card_active(button, false)
			end
		else
			common.set_context_value(deities.context_values.confirm_create_aten_active, 0)

			for _, button in ipairs(deities.ui_data.aten_creation_god_components) do
				deities.set_god_card_active(button, true)
			end
		end

		for _, button in ipairs(deities.ui_data.aten_creation_god_components) do
			local god_key = button:GetProperty(deities.component_ids.god_key_property)
			if god_key == deities.ui_data.aten_god_1 or god_key == deities.ui_data.aten_god_2 then
				button:SetVisible(false)
			else
				button:SetVisible(true)
			end
		end

		deities.update_aten_gods_effects()
	end,

	update_aten_gods_effects = function()
		local aten_bonus_effects_holder = deities.panel:SequentialFind(deities.component_ids.aten_bonus_effects_holder)
		if not aten_bonus_effects_holder then
			return
		end

		local aten_bonus_effects_list_holder = aten_bonus_effects_holder:SequentialFind(deities.component_ids.aten_bonus_effects_list_holder)
		if not aten_bonus_effects_list_holder then
			return
		end

		local aten_bonus_effects_holder_list_box = aten_bonus_effects_list_holder:SequentialFind(deities.component_ids.aten_bonus_effects_holder_list_box,
		deities.component_ids.aten_bonus_effects_inner_list_holder,
		deities.component_ids.aten_bonus_effects_holder_list_box)
		if not aten_bonus_effects_holder_list_box then
			return
		end

		if not (deities.ui_data.templates.aten_shrines_effects_holder_template
			and deities.ui_data.templates.aten_prayers_effects_holder_template
			and deities.ui_data.templates.aten_devoted_armies_effects_holder_template)
		then
			return
		end

		aten_bonus_effects_holder_list_box:DestroyChildren()

		local potential_favour = deities.get_potential_aten_favour()
		local potential_tier = deities.get_tier_from_favour_amount(potential_favour)

		local gods = {}

		gods[1] = deities.get_god(deities.ui_data.aten_god_1)
		gods[2] = deities.get_god(deities.ui_data.aten_god_2)

		local not_enough_gods_warning = aten_bonus_effects_holder:SequentialFind(deities.component_ids.aten_bonus_effects_not_enough_gods_selected)
		if not_enough_gods_warning then
			not_enough_gods_warning:SetVisible(not to_bool(gods[1] and gods[2]))
		end

		local faction_key = cm:get_local_faction_name(true)
		local combined_shrine_effect_bundles = {}
		local combined_idol_effect_bundles = {}
		local combined_prayer_effect_bundles = {}
		local combined_devoted_effect_bundles = {}

		for i = 1, 2 do
			local god = gods[i]
			if god then
				local tiers = deities.get_god_tiers(faction_key, god.key)
				if potential_tier > #tiers then
					potential_tier = #tiers
				end

				if is_table(tiers[potential_tier].shrine_effect_bundles) then
					table_append(combined_shrine_effect_bundles, tiers[potential_tier].shrine_effect_bundles)
				end

				if is_table(tiers[potential_tier].idol_effect_bundles) then
					table_append(combined_idol_effect_bundles, tiers[potential_tier].idol_effect_bundles)
				end

				if is_table(tiers[potential_tier].prayer_effect_bundles) then
					table_append(combined_prayer_effect_bundles, tiers[potential_tier].prayer_effect_bundles)
				end

				if is_table(tiers[potential_tier].devoted_effect_bundles) then
					table_append(combined_devoted_effect_bundles, tiers[potential_tier].devoted_effect_bundles)
				end
			end
		end

		if deities.ui_data.templates.aten_shrines_effects_holder_template and #combined_shrine_effect_bundles > 0 then
			local new_shrine_effects_holder = UIComponent(aten_bonus_effects_holder_list_box:CreateFromComponent(deities.ui_data.templates.aten_shrines_effects_holder_template:Address(), deities.component_ids.aten_bonus_effects_shrines_holder_prefix))
			local bonus_holder = new_shrine_effects_holder:SequentialFind(deities.component_ids.bonus_holder)
			if bonus_holder then
				local custom_effect_bundle = deities.get_combined_custom_effect_bundle(combined_shrine_effect_bundles)
				bonus_holder:InterfaceFunction("set_cco_effect_bundle_from_custom_bundle", custom_effect_bundle)
			end
		end

		if deities.ui_data.templates.aten_prayers_effects_holder_template and #combined_prayer_effect_bundles > 0 then
			local new_prayer_effects_holder = UIComponent(aten_bonus_effects_holder_list_box:CreateFromComponent(deities.ui_data.templates.aten_prayers_effects_holder_template:Address(), deities.component_ids.aten_bonus_effects_prayers_holder_prefix))
			local bonus_holder = new_prayer_effects_holder:SequentialFind(deities.component_ids.bonus_holder)
			if bonus_holder then
				local custom_effect_bundle = deities.get_combined_custom_effect_bundle(combined_prayer_effect_bundles)
				bonus_holder:InterfaceFunction("set_cco_effect_bundle_from_custom_bundle", custom_effect_bundle)
			end
		end

		if deities.ui_data.templates.aten_devoted_armies_effects_holder_template and #combined_devoted_effect_bundles > 0 then
			local new_devoted_armies_effects_holder = UIComponent(aten_bonus_effects_holder_list_box:CreateFromComponent(deities.ui_data.templates.aten_devoted_armies_effects_holder_template:Address(), deities.component_ids.aten_bonus_effects_devoted_armies_holder_prefix ))
			local bonus_holder = new_devoted_armies_effects_holder:SequentialFind(deities.component_ids.bonus_holder)
			if bonus_holder then
				local custom_effect_bundle = deities.get_combined_custom_effect_bundle(combined_devoted_effect_bundles)
				bonus_holder:InterfaceFunction("set_cco_effect_bundle_from_custom_bundle", custom_effect_bundle)
			end
		end
	end,

	on_aten_god_to_remove = function(id)
		if id == deities.component_ids.aten_god_1 then
			deities.ui_data.aten_god_1 = nil
		elseif id == deities.component_ids.aten_god_2 then
			deities.ui_data.aten_god_2 = nil
		end

		deities.update_aten_gods()
	end,

	confirm_create_aten = function()
		if not (deities.ui_data.aten_god_1 and deities.ui_data.aten_god_2) then
			deities.output("Confirmed creating Aten but 2 gods are not selected!", 10)
			return
		end

		local title_source = "ui_text_replacements_localised_text_" .. deities.text_ids.confirmation_boxes.create_aten_title
		local title_localised = common:get_localised_string(title_source)

		local description_source = "ui_text_replacements_localised_text_" .. deities.text_ids.confirmation_boxes.create_aten_text
		local description_localised = common:get_localised_string(description_source)

		create_confirmation_box_with_text_from_script("confirmation_box",
			description_localised,
			description_source,
			--Confirm
			function()
				local local_faction_cqi = cm:get_faction(cm:get_local_faction_name(true)):command_queue_index()
				CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "PharLocalDeities_CreateAten_" .. deities.ui_data.aten_god_1 .. "_" .. deities.ui_data.aten_god_2)
			end,
			--Cancel
			nil,
			nil, title_localised, title_source
		)
	end,

	confirm_select_unlockable = function()
		if not deities.ui_data.aten_selected_unlockable then
			return
		end

		local faction_key = cm:get_local_faction_name(true)
		local choices = deities.get_next_random_aten_unlockables(faction_key)
		local selected_choice = choices[tonumber(deities.ui_data.aten_selected_unlockable)]
		deities.ui_data.aten_selected_unlockable = nil

		local title_source = "ui_text_replacements_localised_text_" .. deities.text_ids.confirmation_boxes.unlockable_title
		local title_localised = common:get_localised_string(title_source)

		local description_source = "ui_text_replacements_localised_text_" .. deities.text_ids.confirmation_boxes.unlockable_text
		local description_localised = common:get_localised_string(description_source)

		create_confirmation_box_with_text_from_script("confirmation_box",
			description_localised,
			description_source,
			--Confirm
			function()
				local local_faction_cqi = cm:get_faction(cm:get_local_faction_name(true)):command_queue_index()
				CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "PharLocalDeities_SelectUnlockable:" .. selected_choice.bundle.bundle .. ":" .. selected_choice.category)
			end,
			--Cancel
			function()
				deities.display_unlockables()
			end,
			nil, title_localised, title_source
		)
	end,

	display_unlockables = function()
		if not deities.ui_data.templates.aten_unlockable then
			return
		end

		local aten_unlockables_holder = deities.panel:SequentialFind(deities.component_ids.aten_unlockables_holder)
		if not aten_unlockables_holder then
			return
		end

		local aten_unlockables_holder_list_box = aten_unlockables_holder:SequentialFind(deities.component_ids.aten_unlockables_holder_list_box)
		if not aten_unlockables_holder_list_box then
			return
		end

		deities.toggle_aten_panel_visibility(false)

		aten_unlockables_holder:SetVisible(true)

		aten_unlockables_holder_list_box:DestroyChildren()

		deities.ui_data.aten_selected_unlockable = "0"

		for i = #deities.ui_data.aten_unlockables_components, 1 , -1 do
			table.remove(deities.ui_data.aten_unlockables_components, i)
		end

		local faction_key = cm:get_local_faction_name(true)

		local choices = deities.get_next_random_aten_unlockables(faction_key)
		if is_table(choices) then
			for i, choice in ipairs(choices) do
				local unlockable_component = UIComponent(aten_unlockables_holder_list_box:CreateFromComponent(deities.ui_data.templates.aten_unlockable:Address(), deities.component_ids.aten_unlockable_prefix .. i))
				unlockable_component:SetProperty("index", i)
				table.insert(deities.ui_data.aten_unlockables_components, unlockable_component)

				local locked_overlay = unlockable_component:SequentialFind(deities.component_ids.aten_unlockable_locked_overlay)
				if locked_overlay then
					locked_overlay:SetProperty("index", i)
				end

				local portrait_component = unlockable_component:SequentialFind(deities.component_ids.aten_unlockable_portrait)
				if portrait_component then
					local god = deities.get_god(choice.bundle.god_key)
					if god then
						portrait_component:SetImagePath(god.god_slot_image)
					else
						portrait_component:SetVisible(false)
					end
				end

				local unlockable_category_component = unlockable_component:SequentialFind(deities.component_ids.aten_unlockable_category)
				if unlockable_category_component and deities.text_ids.unlockable_categories[choice.category] then
					local category_source = "ui_text_replacements_localised_text_" .. deities.text_ids.unlockable_categories[choice.category]
					local category_localised = common:get_localised_string(category_source)
					unlockable_category_component:SetStateText(category_localised, category_source)
				end

				local unlockable_effect_component = unlockable_component:SequentialFind(deities.component_ids.aten_unlockable_effect)
				if unlockable_effect_component then
					local custom_effect_bundle = deities.get_combined_custom_effect_bundle({choice.bundle.bundle})
					unlockable_effect_component:SetProperty("show_effects_as_active", "1")
					unlockable_effect_component:InterfaceFunction("set_cco_effect_bundle_from_custom_bundle", custom_effect_bundle)
				end

				local flavour_text = unlockable_component:SequentialFind(deities.component_ids.aten_unlockable_flavour)
				if flavour_text then
					local localised_text = deities.get_localised_unlockable_text(choice.bundle)
					if localised_text then
						flavour_text:SetText(localised_text.flavour_localised, localised_text.flavour_source)
					end
				end
			end
		end

		common:set_context_value(deities.context_values.aten_selected_unlockable, deities.ui_data.aten_selected_unlockable)
	end,

	hide_unlockables = function()
		local aten_unlockables_holder = deities.panel:SequentialFind(deities.component_ids.aten_unlockables_holder)
		if not aten_unlockables_holder then
			return
		end

		aten_unlockables_holder:SetVisible(false)
	end,

	update_local_deities_notification = function()
		local alert_component = core:get_ui_root():SequentialFind(deities.component_ids.local_deities_alert)
		if not alert_component then
			return
		end

		local faction_key = cm:get_local_faction_name(true)
		-- no local faction means autorun
		if faction_key == false then
			return
		end

		local has_general_slot_available = deities.has_faction_devoted_general_slot_available(faction_key)
		local has_created_aten = deities.has_faction_created_aten(faction_key)
		local has_god_slot_available = deities.has_faction_god_slot_available(faction_key)
		local faction_has_unlocked_feature = feature_unlock.is_feature_unlocked_for_faction(faction_key, feature_ids_config.local_deities)

		if faction_has_unlocked_feature then
			local is_tutorial = cm:get_saved_value("bool_is_tutorial_mode")
			if is_tutorial and not tn_listeners_triggered.per_amun_conquered then
				return
			end

			local tooltip_text = ""
			local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.alert_tooltip.title
			tooltip_text = common:get_localised_string(text_source)

			text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.alert_tooltip.new_events
			tooltip_text = tooltip_text .. "\n" .. common:get_localised_string(text_source)

			local show = false

			if has_god_slot_available then
				local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.alert_tooltip.god_slot_available
				localised_text = common:get_localised_string(text_source)
				tooltip_text = tooltip_text .. "\n - " .. localised_text
				show = true
			end
			if has_general_slot_available and not has_created_aten then
				local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.alert_tooltip.devoted_general
				localised_text = common:get_localised_string(text_source)
				tooltip_text = tooltip_text .. "\n - " .. localised_text
				show = true
			end
			if not table.is_empty(deities.ui_persistent.newly_discovered_gods) then
				local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.alert_tooltip.new_gods
				localised_text = common:get_localised_string(text_source)
				tooltip_text = tooltip_text .. "\n - " .. localised_text
				show = true
			end

			if show then
				alert_component:SetVisible(true)
				alert_component:SetTooltipText(tooltip_text, "", true)
				return
			end
		end

		alert_component:SetVisible(false)
	end,

	update_akhenaten_notification = function()
		local alert_component = core:get_ui_root():SequentialFind(deities.component_ids.local_deities_alert)	-- aten alert should appear in the local deities faction widget button
		if not alert_component then
			return
		end

		local faction_key = cm:get_local_faction_name(true)
		-- no local faction means autorun
		if faction_key == false then
			return
		end

		local tooltip_text = ""
		local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.alert_tooltip.title
		tooltip_text = common:get_localised_string(text_source)

		text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.alert_tooltip.new_events
		tooltip_text = tooltip_text .. "\n" .. common:get_localised_string(text_source)

		local show = false

		if deities.has_faction_devoted_general_slot_available(faction_key) then
			local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.alert_tooltip.devoted_general
			localised_text = common:get_localised_string(text_source)
			tooltip_text = tooltip_text .. "\n - " .. localised_text
			show = true
		end

		if deities.has_faction_aten_unlockable_available(faction_key) then
			local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.alert_tooltip.unlockables
			localised_text = common:get_localised_string(text_source)
			tooltip_text = tooltip_text .. "\n - " .. localised_text
			show = true
		end

		if show then
			alert_component:SetVisible(true)
			alert_component:SetTooltipText(tooltip_text, "", true)
		else
			alert_component:SetVisible(false)
		end
	end,

	on_unlockable_clicked = function(context)
		local unlockable_component = UIComponent(context.component)
		local id = unlockable_component:Id()
		local index = unlockable_component:GetProperty("index")

		local state = unlockable_component:CurrentState()
		if state ~= "locked" then

			if index ~= deities.ui_data.aten_selected_unlockable then
				deities.ui_data.aten_selected_unlockable = index
			else
				deities.ui_data.aten_selected_unlockable = "0"
			end
			common:set_context_value(deities.context_values.aten_selected_unlockable, deities.ui_data.aten_selected_unlockable)
		end
	end,

--------------------------------------------------------------
--------------------ON CLICK FUNCTIONS------------------------
--------------------------------------------------------------

	on_god_clicked = function(god_key)
		if not god_key or god_key == "" then
			return
		end

		deities.deselect_all()
		if god_key == deities.config.aten_god_key then
			deities.open_aten()
		else
			deities.open_selected_god(god_key)
		end
	end,

	on_god_slot_clicked = function(god_key)
		deities.deselect_all()

		if not god_key or god_key == "" then
			return
		end
		if god_key == deities.config.aten_god_key then
			deities.open_aten()
		else
			deities.open_selected_god(god_key)
		end
	end,

	on_back_selected_clicked = function()
		deities.deselect_all()

		deities.toggle_selected_god(false)

		deities.display_all_gods()
		deities.toggle_worshipped_gods_tabs_visibility(true)

		deities.toggle_aten_creation_panel_visibility(false)
	end,

	on_back_unlockables_clicked = function()
		deities.open_aten()
	end,

	on_back_aten_creation = function()
		deities.display_god_slots()
	end,

	on_previous_clicked = function()
		deities.cycle_selected_god(-1)
	end,

	on_next_clicked = function()
		deities.cycle_selected_god(1)
	end,

	on_hecatomb_clicked = function()
		local local_faction_cqi = cm:get_local_faction(true):command_queue_index()

		local faction_key = cm:get_local_faction_name(true)
		local god_key = deities.ui_data.selected_god
		local cost = deities.get_hecatomb_cost(faction_key, god_key)
		cost:multiply_by(-1)

		local text_source = "ui_text_replacements_localised_text_" .. deities.text_ids.hecatomb_confirmation
		local localised_text = common.string_safe_format(common:get_localised_string(text_source), cost:to_string())

		create_confirmation_box_with_text_from_script("confirmation_box",
		localised_text,
		text_source,
		--Confirm
		function()
			CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "PharLocalDeities_Hecatomb:" .. deities.ui_data.selected_god)
		end,
		--Cancel
		nil,
		nil, "", ""
	)
	end,

	get_ordered_gods = function(faction_key, culture)
		local gods = deities.get_filtered_gods_from_culture(culture, faction_key, true, true)
		table_append(gods, deities.get_filtered_gods_from_culture(culture, faction_key, false, true))
		table_append(gods, deities.get_filtered_gods_from_culture(culture, faction_key, false, false))
		return gods
	end,

	cycle_selected_god = function(offset)
		local faction_key = cm:get_local_faction_name(true)
		local all_ordered_gods = {}

		if deities.has_faction_created_aten(faction_key) then
			table.insert(all_ordered_gods, deities.get_god(deities.config.aten_god_key))
		end

		for _, culture in ipairs(deities.config.cultures) do
			table_append(all_ordered_gods, deities.get_ordered_gods(faction_key, culture))
		end

		local index = table_find(all_ordered_gods, function(e) return e.key == deities.ui_data.selected_god end, true)
		index = index + offset
		if index < 1 then
			index = #all_ordered_gods
		elseif index > #all_ordered_gods then
			index = 1
		end

		deities.open_selected_god(all_ordered_gods[index].key)
	end,

	on_worship_clicked = function(context)
		deities.deselect_all()

		local faction_key = cm:get_local_faction_name(true)

		-- Check if there if a free god slot
		if not is_table(deities.persistent[faction_key]) then
			deities.output("Could not get deities data for faction " .. tostring(faction_key) .. "!", 10)
		end

		local free_slot_index
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			if not deities.persistent[faction_key].god_slots[i].god_key then
				free_slot_index = i
				break
			end
		end

		if free_slot_index then
			deities.display_worship_dialogue(free_slot_index)
		else
			deities.display_rededication_dialogue()
		end
	end,

	display_worship_dialogue = function(free_slot_index)
		local localised_god_name = deities.get_localised_text(deities.ui_data.selected_god).name

		local title_source = "ui_text_replacements_localised_text_" .. deities.component_ids.worship_dialogue_title
		local localised_title = string.format(common.get_localised_string(title_source), localised_god_name)

		local description_source = "ui_text_replacements_localised_text_" .. deities.component_ids.worship_dialogue_desc
		local localised_description = string.format(common.get_localised_string(description_source))
		create_confirmation_box_with_text_from_script(deities.component_ids.worship_dialogue_box_id, localised_description, description_source,
			-- Confirm
			function(context)
				local local_faction_key = cm:get_local_faction_name(true)
				local local_faction_cqi = cm:get_faction(local_faction_key):command_queue_index()
				CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "PharLocalDeities_WorshipGod_" .. deities.ui_data.selected_god .. "_slot_" .. free_slot_index)
				CampaignUI.TriggerCampaignFactionVO(vo_events.worship, local_faction_key)

				deities.toggle_worship_button_visible(false)
			end,
			-- Cancel
			function(context)
				deities.toggle_worship_button_visible(true)
			end,
			panel, localised_title, title_source
		)

		local dialogue_component = core:get_ui_root():SequentialFind(deities.component_ids.worship_dialogue_box_id)
		local result_template = dialogue_component:SequentialFind(deities.component_ids.worship_result_template)

		if result_template then
			local result_index = 0

			local result_parent = UIComponent(result_template:Parent())
			result_parent:SetVisible(true)
			result_template:DivorceFromParent()

			local add_result = function(text_record, additional_text_record)
				local source = "ui_text_replacements_localised_text_" .. text_record
				local localised_text
				if additional_text_record then
					additional_text_source = "ui_text_replacements_localised_text_" .. additional_text_record
					localised_text = common.string_safe_format(common.get_localised_string(source), common.get_localised_string(additional_text_source), localised_god_name)
				else
					localised_text = common.string_safe_format(common.get_localised_string(source), localised_god_name)
				end
				local new_result_component = UIComponent(result_parent:CreateFromComponent(result_template:Address(), deities.component_ids.worship_result_prefix .. result_index))
				new_result_component:SetText(localised_text, source)
				new_result_component:SetState("positive")
				result_index = result_index + 1
			end

			local shrine_chain = deities.get_god_shrine_chain(deities.ui_data.selected_god)
			if is_string(shrine_chain) and shrine_chain ~= "" then	-- Has shrines and prays at them.
				if deities.has_dwellings(deities.ui_data.selected_god) then
					add_result(deities.component_ids.worship_dialogue_construct, deities.component_ids.worship_dialogue_construct_shrines_temples_dwellings)
				else
					add_result(deities.component_ids.worship_dialogue_construct, deities.component_ids.worship_dialogue_construct_shrines_temples)
				end

				if deities.config.unlock_tiers.shrines == 1 then
					if deities.has_dwellings(deities.ui_data.selected_god) then
						add_result(deities.component_ids.worship_dialogue_shrines, deities.component_ids.worship_dialogue_construct_shrines_dwellings)
					else
						add_result(deities.component_ids.worship_dialogue_shrines, deities.component_ids.worship_dialogue_construct_shrines)
					end
				end

				if deities.config.unlock_tiers.prayers == 1 then
					add_result(deities.component_ids.worship_dialogue_prayers)
				end
			end

			local idol_chain = deities.get_god_idol_chain(deities.ui_data.selected_god)
			if is_string(idol_chain) and idol_chain ~= "" then	-- Has idols and prays at nomad outposts.
				add_result(deities.component_ids.worship_dialogue_construct_idols)

				if deities.config.unlock_tiers.idols == 1 then
					add_result(deities.component_ids.worship_dialogue_idols)
				end

				if deities.config.unlock_tiers.prayers == 1 then
					add_result(deities.component_ids.worship_dialogue_prayers_nomad_outpost)
				end
			end

			if deities.config.unlock_tiers.devoted_generals == 1 then
				add_result(deities.component_ids.worship_dialogue_devoted)
			end
		end
	end,

	display_rededication_dialogue = function()
		local localised_god_name = deities.get_localised_text(deities.ui_data.selected_god).name

		local title_source = "ui_text_replacements_localised_text_" .. deities.component_ids.worship_dialogue_title
		local localised_title = string.format(common.get_localised_string(title_source), localised_god_name)

		local dialogue_component = deities.panel:SequentialFind(deities.component_ids.rededicate_dialogue)
		if not dialogue_component then
			return
		end

		cm:steal_user_input(true)
		cm:steal_escape_key_with_callback(deities.component_ids.rededicate_dialogue .. "_confirmation_box_esc", deities.on_rededication_cancel)

		cm:steal_key_with_callback(deities.component_ids.rededicate_dialogue .. "_confirmation_box_enter", "NUMPADENTER", deities.on_rededication_confirm)
		cm:steal_key_with_callback(deities.component_ids.rededicate_dialogue .. "_confirmation_box_enter2", "RETURN", deities.on_rededication_confirm)

		dialogue_component:SetVisible(true)
		dialogue_component:RegisterTopMost()
		dialogue_component:PropagatePriority(5000)
		dialogue_component:LockPriority(5000)

		local title_component = dialogue_component:SequentialFind(deities.component_ids.rededicate_dialogue_title)
		if title_component then
			title_component:SetText(localised_title, title_source)
		end

		deities.ui_data.selected_god_for_rededication = nil

		local god_template = deities.ui_data.templates.rededicate_god_template
		local gods_holder = dialogue_component:SequentialFind(deities.component_ids.rededicate_dialogue_gods_holder)

		deities.ui_data.gods_for_rededication = {}
		if gods_holder and god_template then
			gods_holder:DestroyChildren()

			local faction_key = cm:get_local_faction_name(true)
			for i, god_data in ipairs(deities.persistent[faction_key].god_slots) do
				if god_data.god_key then
					local new_god_component = UIComponent(gods_holder:CreateFromComponent(god_template:Address(), deities.component_ids.rededicate_god_template_instance_prefix .. i))
					new_god_component:SetProperty(deities.component_ids.rededicate_god_template_god_slot_property, i)

					local god = deities.get_god(god_data.god_key)
					if god and god.tab_image then
						new_god_component:SetImagePath(god.god_slot_image, deities.component_ids.rededicate_god_template_portrait_image_index)
					end

					table.insert(deities.ui_data.gods_for_rededication, new_god_component)
				end
			end

			-- If there is only 1 god, select it by default
			if #deities.ui_data.gods_for_rededication == 1 then
				deities.ui_data.gods_for_rededication[1]:SetState("selected")
				deities.ui_data.selected_god_for_rededication = deities.ui_data.gods_for_rededication[1]:GetProperty(deities.component_ids.rededicate_god_template_god_slot_property)
			end
		end

		local god_key
		if deities.ui_data.selected_god_for_rededication then
			local faction_key = cm:get_local_faction_name(true)
			local selected_god_component = deities.ui_data.gods_for_rededication[tonumber(deities.ui_data.selected_god_for_rededication)]
			local slot_index = tonumber(selected_god_component:GetProperty(deities.component_ids.rededicate_god_template_god_slot_property))
			local god_slot = deities.persistent[faction_key].god_slots[slot_index]

			god_key = god_slot.god_key
		end

		local result_template = deities.ui_data.templates.rededication_result

		local current_god_key = deities.ui_data.selected_god
		if result_template then
			local result_index = 0
			local result_parent = dialogue_component:SequentialFind(deities.component_ids.worhip_results_holder)
			result_parent:DestroyChildren()

			local add_result = function(text_record, state)
				if not result_parent then
					return
				end
				local source = "ui_text_replacements_localised_text_" .. text_record
				local localised_text = string.format(common.get_localised_string(source), localised_god_name)
				local new_result_component = UIComponent(result_parent:CreateFromComponent(result_template:Address(), deities.component_ids.worship_result_prefix .. result_index))
				new_result_component:SetText(localised_text, source)
				new_result_component:SetState(state)
				result_index = result_index + 1
			end

			if deities.is_sea_god(current_god_key) == deities.is_sea_god(god_key) then
				add_result(deities.component_ids.rededicate_dialogue_buildings_key, "positive")
			elseif deities.is_sea_god(current_god_key) then
				add_result(deities.component_ids.rededicate_dialogue_buildings_sea_core, "positive")
			else
				add_result(deities.component_ids.rededicate_dialogue_buildings_core_sea, "positive")
			end
			add_result(deities.component_ids.rededicate_dialogue_armies_key, "negative")
		end

		local cost_text = dialogue_component:SequentialFind(deities.component_ids.worship_dialogue_cost_text)
		if cost_text then
			cost_text:SetState(deities.is_sea_god(current_god_key) == deities.is_sea_god(god_key) and "default" or "refund")
		end

		deities.display_rededication_cost_and_time(dialogue_component, god_key)
	end,

	display_rededication_cost_and_time = function(dialogue_component, selected_god_key)
		local faction = cm:get_local_faction(true)
		local faction_key = faction:name()
		local conversion_cost, conversion_time = deities.get_rededication_cost_and_time(faction_key, selected_god_key)
		local worship_button = dialogue_component:SequentialFind(deities.component_ids.rededicate_dialogue_button_confirm)
		if worship_button then
			worship_button:SetState(selected_god_key and "active" or "inactive")
		end

		local resources_cost_holder = dialogue_component:SequentialFind(deities.component_ids.resources_cost_holder)
		local resources_label = dialogue_component:SequentialFind(deities.component_ids.resources_cost)
		if not conversion_cost or #conversion_cost:resources() == 0 then
			-- Should only get here if no god is selected
			if resources_cost_holder then
				resources_cost_holder:SetVisible(false)
			end
			if resources_label then
				resources_label:SetVisible(false)
			end
			return
		else
			if resources_cost_holder then
				resources_cost_holder:SetVisible(true)
			end
			if resources_label then
				resources_label:SetVisible(true)
			end
		end

		local resources_holder = dialogue_component:SequentialFind(deities.component_ids.resources_holder)
		if not resources_holder then
			return
		end


		local can_afford = faction:can_afford_resource_cost_object(conversion_cost)
		local resources = conversion_cost:resources()
		if #resources > 0 then
			resources_holder:DestroyChildren()

			for index, resource in ipairs(resources) do
				local new_resource_component = UIComponent(resources_holder:CreateFromComponent(deities.ui_data.templates.resource_template:Address(), deities.component_ids.resources_prefix .. index))
				if can_afford then
					new_resource_component:SetState("default")
				else
					new_resource_component:SetState("insufficient")
				end

				new_resource_component:SetStateText(-resource[2])
				new_resource_component:SetImagePath(resource[3])
			end
		else
			resources_holder:SetVisible(false)
		end

		local turns_component = dialogue_component:SequentialFind(deities.component_ids.conversion_turns)
		if turns_component then
			turns_component:SetText(conversion_time)
		end

		if worship_button then
			if not can_afford then
				worship_button:SetState("inactive")
				local text_source = "ui_text_replacements_localised_text_" .. deities.component_ids.rededicate_dialogue_worship_tooltip_insufficient_resources
				local localised_text = common:get_localised_string(text_source)
				worship_button:SetTooltipText(localised_text, false)
			else
				worship_button:SetState("active")
			end
		end
	end,

	get_rededication_cost_and_time = function(faction_key, god_key)
		local god_slot = deities.get_god_slot(faction_key, god_key)
		if not god_slot then
			return nil, 0
		end

		local new_god_key = deities.ui_data.selected_god
		local refund = deities.is_sea_god(god_key) ~= deities.is_sea_god(new_god_key)

		local total_resource_cost = cm:create_new_custom_resource_cost()
		local max_conversion_time = 0

		local salvage_modifier = cm:model():get_campaign_variable_by_name("building_salvage_cost_modifier")
		local salvage_modifier_damaged = cm:model():get_campaign_variable_by_name("building_salvage_cost_modifier_damaged")
		local salvage_modifier_ruined = cm:model():get_campaign_variable_by_name("building_salvage_cost_modifier_ruined")

		local temple_chain_key = deities.get_god_temple_chain(god_key)
		for _, temple in ipairs(god_slot.temples) do
			local temple_level = temple.level
			local temple_building_key = cm:get_building_from_building_chain(temple_chain_key, temple_level)

			local current_resource_cost = cm:create_new_custom_resource_cost()

			local region = cm:get_region(temple.region_key)
			local bonus_values_list = region:bonus_values()

			local bonus_value = bonus_values_list:building_chain_value(temple_chain_key, deities.config.bonus_value_building_conversion)

			if refund then
				local creation_cost_record_key = cm:get_building_create_cost_record_key(temple_building_key)
				current_resource_cost:get_cost_from_record(creation_cost_record_key)

				local building = deities.find_building_by_building_chain(temple.region_key, temple_chain_key, temple.level)
				if building and not building:is_null_interface() then
					local hp = building:percent_health()

					if hp == 100 then
						current_resource_cost:multiply_by(salvage_modifier)
					elseif hp == 0 then
						current_resource_cost:multiply_by(salvage_modifier_ruined)
					else
						current_resource_cost:multiply_by(salvage_modifier_damaged)
					end
				end
				if bonus_value ~= 0 then
					current_resource_cost:multiply_by((100.0 + bonus_value) / 100.0)
				end
				total_resource_cost:add(current_resource_cost)
			else
				local convertion_cost_record_key = cm:get_building_conversion_cost_record_key(temple_building_key)

				current_resource_cost:get_cost_from_record(convertion_cost_record_key)
				if bonus_value ~= 0 then
					current_resource_cost:multiply_by((100.0 + bonus_value) / 100.0)
				end
				total_resource_cost:add(current_resource_cost)

				-- There are no bonuses that increase/decrease convertion time, so it is equal to the create time
				max_conversion_time = math.max(max_conversion_time, cm:get_building_create_time(temple_building_key))
			end
		end

		local shrine_chain_key = deities.get_god_shrine_chain(god_key)
		for _, shrine_region in ipairs(god_slot.shrine_regions) do
			local shrine_building_key = cm:get_building_from_building_chain(shrine_chain_key, 0)

			local current_resource_cost = cm:create_new_custom_resource_cost()

			local region = cm:get_region(shrine_region)
			local bonus_values_list = region:bonus_values()

			local bonus_value = bonus_values_list:building_chain_value(shrine_chain_key, deities.config.bonus_value_building_conversion)

			if refund then
				local creation_cost_record_key = cm:get_building_create_cost_record_key(shrine_building_key)
				current_resource_cost:get_cost_from_record(creation_cost_record_key)

				local building = deities.find_building_by_building_chain(shrine_region, shrine_chain_key, 0)
				if building and not building:is_null_interface() then
					local hp = building:percent_health()

					if hp == 100 then
						current_resource_cost:multiply_by(salvage_modifier)
					elseif hp == 0 then
						current_resource_cost:multiply_by(salvage_modifier_ruined)
					else
						current_resource_cost:multiply_by(salvage_modifier_damaged)
					end
				end
				if bonus_value ~= 0 then
					current_resource_cost:multiply_by((100.0 + bonus_value) / 100.0)
				end
				total_resource_cost:add(current_resource_cost)
			else
				local convertion_cost_record_key = cm:get_building_conversion_cost_record_key(shrine_building_key)

				current_resource_cost:get_cost_from_record(convertion_cost_record_key)
				if bonus_value ~= 0 then
					current_resource_cost:multiply_by((100.0 + bonus_value) / 100.0)
				end
				total_resource_cost:add(current_resource_cost)

				-- There are no bonuses that increase/decrease convertion time, so it is equal to the create time
				max_conversion_time = math.max(max_conversion_time, cm:get_building_create_time(shrine_building_key))
			end
		end

		local dwelling_chain_key = deities.get_god_dwelling_chain(god_key)
		for _, dwelling_region in ipairs(god_slot.dwelling_regions) do
			local dwelling_building_key = cm:get_building_from_building_chain(dwelling_chain_key, 0)

			local current_resource_cost = cm:create_new_custom_resource_cost()

			local region = cm:get_region(dwelling_region)
			local bonus_values_list = region:bonus_values()

			local bonus_value = bonus_values_list:building_chain_value(dwelling_chain_key, deities.config.bonus_value_building_conversion)

			if refund then
				local creation_cost_record_key = cm:get_building_create_cost_record_key(dwelling_building_key)
				current_resource_cost:get_cost_from_record(creation_cost_record_key)

				local building = deities.find_building_by_building_chain(dwelling_region, dwelling_chain_key, 0)
				if building and not building:is_null_interface() then
					local hp = building:percent_health()

					if hp == 100 then
						current_resource_cost:multiply_by(salvage_modifier)
					elseif hp == 0 then
						current_resource_cost:multiply_by(salvage_modifier_ruined)
					else
						current_resource_cost:multiply_by(salvage_modifier_damaged)
					end
				end
				if bonus_value ~= 0 then
					current_resource_cost:multiply_by((100.0 + bonus_value) / 100.0)
				end
				total_resource_cost:add(current_resource_cost)
			else
				local convertion_cost_record_key = cm:get_building_conversion_cost_record_key(dwelling_building_key)

				current_resource_cost:get_cost_from_record(convertion_cost_record_key)
				if bonus_value ~= 0 then
					current_resource_cost:multiply_by((100.0 + bonus_value) / 100.0)
				end
				total_resource_cost:add(current_resource_cost)

				-- There are no bonuses that increase/decrease convertion time, so it is equal to the create time
				max_conversion_time = math.max(max_conversion_time, cm:get_building_create_time(dwelling_building_key))
			end
		end

		local idol_chain_key = deities.get_god_idol_chain(god_key)
		for _, idol in ipairs(god_slot.idols) do
			local idol_level = idol.level
			local idol_building_key = cm:get_building_from_building_chain(idol_chain_key, idol_level)

			local current_resource_cost = cm:create_new_custom_resource_cost()

			local force = cm:get_military_force_by_cqi(idol.force_cqi)
			local bonus_values_list = force:bonus_values()

			local bonus_value = bonus_values_list:building_chain_value(idol_chain_key, deities.config.bonus_value_military_force_building_conversion)

			if refund then
				local creation_cost_record_key = cm:get_building_create_cost_record_key(idol_building_key)
				current_resource_cost:get_cost_from_record(creation_cost_record_key)

				local building = deities.find_force_building_by_building_chain(idol.force_cqi, idol_chain_key, idol_level)
				if building and not building:is_null_interface() then
					local hp = building:percent_health()

					if hp == 100 then
						current_resource_cost:multiply_by(salvage_modifier)
					elseif hp == 0 then
						current_resource_cost:multiply_by(salvage_modifier_ruined)
					else
						current_resource_cost:multiply_by(salvage_modifier_damaged)
					end
				end
				if bonus_value ~= 0 then
					current_resource_cost:multiply_by((100.0 + bonus_value) / 100.0)
				end
				total_resource_cost:add(current_resource_cost)
			else
				local convertion_cost_record_key = cm:get_building_conversion_cost_record_key(idol_building_key)

				current_resource_cost:get_cost_from_record(convertion_cost_record_key)
				if bonus_value ~= 0 then
					current_resource_cost:multiply_by((100.0 + bonus_value) / 100.0)
				end
				total_resource_cost:add(current_resource_cost)

				-- There are no bonuses that increase/decrease convertion time, so it is equal to the create time
				max_conversion_time = math.max(max_conversion_time, cm:get_building_create_time(idol_building_key))
			end
		end

		return total_resource_cost, max_conversion_time
	end,

	on_culture_tab_clicked = function(context)
		deities.deselect_all()
	end,

	on_worshipped_tab_clicked = function()
		deities.hide_all_gods()
		deities.display_god_slots()
	end,

	on_all_gods_tab_clicked = function()
		deities.hide_god_slots()
		deities.display_all_gods()
	end,

	on_army_button_clicked = function(context)
		local clicked_component = UIComponent(context.component)
		if not clicked_component then
			return
		end

		local state = clicked_component:CurrentState()
		if string.find(clicked_component:CurrentState(), "locked") then
			return
		end

		local army_button_holder = UIComponent(UIComponent(clicked_component:Parent()):Parent())

		local army_selector_holder = army_button_holder:SequentialFind(deities.component_ids.army_selector_holder)
		if not army_selector_holder then
			return
		end

		army_selector_holder:SetVisible(true)

		local army_selector_component = UIComponent(UIComponent(clicked_component:Parent()):Parent()):SequentialFind(deities.component_ids.army_selector)
		if not army_selector_component then
			return
		end

		army_selector_component:DestroyChildren()
		army_selector_component:SetVisible(true)

		local army_ui_template = deities.ui_data.templates.army_template
		if not army_ui_template then
			return
		end


		if not string.find(clicked_component:CurrentState(), "available") then
			return
		end

		local this_army_selector_open = clicked_component:GetProperty(deities.component_ids.army_selector_open_property)
		if this_army_selector_open == "true" then
			clicked_component:SetProperty(deities.component_ids.army_selector_open_property, "false")
			army_selector_component:SetVisible(false)
			return
		end
		-- Set all other as closed and this one as opened
		deities.hide_army_selectors()
		clicked_component:SetProperty(deities.component_ids.army_selector_open_property, "true")
		army_selector_component:SetVisible(true)

		local god_slot_index = clicked_component:GetProperty(deities.component_ids.god_slot_index_property)
		local devoted_general_index = clicked_component:GetProperty(deities.component_ids.devoted_general_index_property)

		local faction = cm:get_faction(cm:get_local_faction_name(true))
		local characters_list = faction:character_list()
		local characters_displayed = 0
		for i = 0, characters_list:num_items() - 1 do
			local character = characters_list:item_at(i)
			if character:character_type("general") and not character:family_member():is_convalescing() then
				local family_member_cqi = character:family_member():command_queue_index()

				-- Check if not already devoted to a god
				local faction_key = cm:get_local_faction_name(true)
				local god_slots = deities.get_god_slots(faction_key)

				local already_devoted = false
				local general_slots = deities.get_devoted_general_slots(faction_key)
				for slot_index = 1, deities.get_faction_god_slots_count(faction_key) do
					if already_devoted then
						break
					end
					if god_slots[slot_index].god_key then
						for general_index = 1, general_slots do
							local cqi = deities.get_devoted_general_family_cqi(faction_key, god_slots[slot_index].god_key, general_index)
							if cqi == family_member_cqi then
								already_devoted = true
								break
							end
						end
					end
				end
				if not already_devoted then
					-- In order for the character to lead an Obedience army, they must currently lead an army, as Obedience armies have irreplaceable generals.
					local is_obedience_army = character:has_military_force() and character:military_force():force_type() == eminence.config.obedience.spawned_army_force_type
					if not is_obedience_army then
						local cco_character = cco("CcoCampaignCharacter", character:command_queue_index())
						local new_army_component = UIComponent(army_selector_component:CreateFromComponent(army_ui_template:Address(), deities.component_ids.army_prefix .. i))
						new_army_component:SetContextObject(cco_character)
						new_army_component:SetProperty(deities.component_ids.general_family_member_cqi_property, family_member_cqi)
						new_army_component:SetProperty(deities.component_ids.god_slot_index_property, god_slot_index)
						new_army_component:SetProperty(deities.component_ids.devoted_general_index_property, devoted_general_index)

						characters_displayed = characters_displayed + 1
					end
				end
			end
		end

		local no_generals_text_template = 	deities.ui_data.templates.no_generals_template
		if no_generals_text_template and characters_displayed == 0 then
			local no_generals_text = UIComponent(army_selector_component:CreateFromComponent(no_generals_text_template:Address(), deities.component_ids.no_general_txt))
			no_generals_text:SetVisible(true)
		end
	end,

	hide_army_selectors = function()
		for _, component in ipairs(deities.ui_data.god_slot_army_button_components) do
			component:SetProperty(deities.component_ids.army_selector_open_property, "false")
			local current_army_selector_component = UIComponent(UIComponent(component:Parent()):Parent()):SequentialFind(deities.component_ids.army_selector)
			if current_army_selector_component then
				current_army_selector_component:SetVisible(false)
			end
		end
	end,

	on_general_clicked = function(context)
		deities.deselect_all()

		local general_component = UIComponent(context.component)
		if not general_component then
			return
		end

		local family_member_cqi = general_component:GetProperty(deities.component_ids.general_family_member_cqi_property)
		if not family_member_cqi then
			return
		end
		local family_member_cqi = tonumber(family_member_cqi)

		local god_slot_index = general_component:GetProperty(deities.component_ids.god_slot_index_property)
		if not god_slot_index then
			return
		end
		god_slot_index = tonumber(god_slot_index)

		local devoted_general_index = general_component:GetProperty(deities.component_ids.devoted_general_index_property)
		if not devoted_general_index then
			return
		end
		devoted_general_index = tonumber(devoted_general_index)

		local faction_key = cm:get_local_faction_name(true)

		local god_key
		if deities.has_faction_created_aten(faction_key) then
			god_key = deities.config.aten_god_key
		else
			god_key = deities.persistent[faction_key].god_slots[god_slot_index].god_key
		end

		local parent_component = UIComponent(general_component:Parent())
		parent_component:DestroyChildren()

		local local_faction_cqi = cm:get_faction(cm:get_local_faction_name(true)):command_queue_index()

		local title_source = "ui_text_replacements_localised_text_" .. deities.text_ids.confirmation_boxes.devote_general_title
		local title_localised = common:get_localised_string(title_source)

		local description_source = "ui_text_replacements_localised_text_" .. deities.text_ids.confirmation_boxes.devote_general_text
		local description_localised = common:get_localised_string(description_source)

		deities.hide_army_selectors()
		create_confirmation_box_with_text_from_script("confirmation_box",
			description_localised,
			description_source,
			--Confirm
			function()
				CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "PharLocalDeities_AssignDevotedGeneral:" .. tostring(god_key) .. ":" .. devoted_general_index .. ":" .. family_member_cqi)

				local character_cqi = cm:get_character_by_fm_cqi(family_member_cqi):command_queue_index()
				CampaignUI.TriggerCampaignCharacterVO(vo_events.assign_devotee, character_cqi)
			end,
			--Cancel
			nil,
			nil, title_localised, title_source
		)
	end,

	on_religious_buildings_button_clicked = function(context)
		local button_component = UIComponent(context.component)
		if not button_component then
			return
		end

		local shrines_and_temples_holder = deities.panel:SequentialFind(deities.component_ids.shrines_and_temples_holder)
		if not shrines_and_temples_holder then
			return
		end

		local shrines_content = shrines_and_temples_holder:SequentialFind(deities.component_ids.shrines_content)
		if not shrines_content then
			return
		end

		deities.display_religious_buildings()
	end,

	apply_radio_group_changes = function(radio_groups, event)
		for _, current_radio_group in ipairs(radio_groups) do
			local selected_god_key
			for _, radio_button in ipairs(current_radio_group.components) do
				if radio_button:CurrentState() == "selected" then
					selected_god_key = radio_button:GetProperty(deities.component_ids.radio_button_god_key_property)
					break
				end
			end
			if selected_god_key and selected_god_key ~= current_radio_group.originally_selected_god_key then
				local local_faction_cqi = cm:get_faction(cm:get_local_faction_name(true)):command_queue_index()
				local location = (current_radio_group.region_key or current_radio_group.force_cqi)
				CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, event .. ":" .. location .. ":" .. current_radio_group.originally_selected_god_key .. ":" .. selected_god_key)
			end
		end
	end,

	on_religious_buildings_apply_changes = function(context)
		local title_source = "ui_text_replacements_localised_text_" .. deities.text_ids.confirmation_boxes.conversion_title
		local title_localised = common:get_localised_string(title_source)

		local description_source = "ui_text_replacements_localised_text_" .. deities.text_ids.confirmation_boxes.conversion_text
		local description_localised = common:get_localised_string(description_source)

		create_confirmation_box_with_text_from_script("confirmation_box",
			description_localised,
			description_source,
			--Confirm
			function()
				deities.apply_radio_group_changes(deities.ui_data.shrine_radio_groups, "PharLocalDeities_ChangeShrineGod")
				deities.apply_radio_group_changes(deities.ui_data.temple_radio_groups, "PharLocalDeities_ChangeTempleGod")
				deities.apply_radio_group_changes(deities.ui_data.dwelling_radio_groups, "PharLocalDeities_ChangeDwellingGod")
				deities.apply_radio_group_changes(deities.ui_data.idol_radio_groups, "PharLocalDeities_ChangeIdolGod")
			end,
			--Cancel
			nil,
			nil, title_localised, title_source
		)

		deities.close_religious_buidings()
	end,

	rededication_panel_close = function()
		local dialogue_component = deities.panel:SequentialFind(deities.component_ids.rededicate_dialogue)
		if dialogue_component then
			dialogue_component:SetVisible(false)
		end
		deities.ui_data.selected_god_for_rededication = nil

		dialogue_component:UnLockPriority()
		cm:steal_user_input(false)

		cm:release_escape_key_with_callback(deities.component_ids.rededicate_dialogue .. "_confirmation_box_esc", deities.on_rededication_cancel)

		cm:release_key_with_callback(deities.component_ids.rededicate_dialogue .. "_confirmation_box_enter", "NUMPADENTER", deities.on_rededication_confirm)
		cm:release_key_with_callback(deities.component_ids.rededicate_dialogue .. "_confirmation_box_enter2", "RETURN", deities.on_rededication_confirm)
	end,

	on_rededication_cancel = function()
		deities.rededication_panel_close()
		deities.toggle_worship_button_active(true)
	end,

	on_god_for_rededication_clicked = function(context)
		local dialogue_component = deities.panel:SequentialFind(deities.component_ids.rededicate_dialogue)
		if not dialogue_component then
			return
		end

		local component = UIComponent(context.component)
		if not component then
			return
		end

		deities.ui_data.selected_god_for_rededication = component:GetProperty(deities.component_ids.rededicate_god_template_god_slot_property)

		local faction_key = cm:get_local_faction_name(true)
		local selected_god_component = deities.ui_data.gods_for_rededication[tonumber(deities.ui_data.selected_god_for_rededication)]
		local slot_index = tonumber(selected_god_component:GetProperty(deities.component_ids.rededicate_god_template_god_slot_property))
		local god_slot = deities.persistent[faction_key].god_slots[slot_index]
		local god_key = god_slot.god_key

		deities.display_rededication_cost_and_time(dialogue_component, god_key)

		-- Deselect any other gods
		for _, god_component in ipairs(deities.ui_data.gods_for_rededication) do
			if god_component ~= component then
				god_component:SetState("active")
			end
		end
	end,

	on_rededication_confirm = function()
		if deities.ui_data.selected_god_for_rededication then
			local local_faction_cqi = cm:get_faction(cm:get_local_faction_name(true)):command_queue_index()
			CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "PharLocalDeities_WorshipGod_" .. deities.ui_data.selected_god .. "_slot_" .. deities.ui_data.selected_god_for_rededication)
		end
		deities.rededication_panel_close()
		deities.toggle_worship_button_visible(false)

		deities.ui_data.gods_for_rededication = nil
	end,

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
	-- used to perform various sanity checks
	-- like if faction has a valid number of god slots
	check_data_consistency = function()
		for faction_key,data in pairs(deities.persistent) do
			local god_slots_number = #(data.god_slots)
			if god_slots_number > deities.config.max_god_slots then
				script_error(string.format("ERROR: in phar_local_deities.lua, faction %s has more than the max god slots", faction_key))
			end
		end
	end,

	save_data = function(context)
		deities.check_data_consistency()

		if cm:is_game_running() then
			local faction_keys_list = cm:get_factions_at_campaign_start()
			if is_table(faction_keys_list) then
				for _, faction_key in ipairs(faction_keys_list) do
					cm:save_named_value("Local_deities_" .. tostring(faction_key), deities.persistent[faction_key], context)
				end
			else
				deities.output("Unable to save persistent data, was not able to get factions_at_campaign_start!" , 10)
			end
		end

		cm:save_named_value("Local_deities_UI_data", deities.ui_persistent, context)

		if is_table(deities.excluded_god_keys) then
			cm:save_named_value("Local_deities_excluded_god_keys", deities.excluded_god_keys, context)
		else
			deities.output("Unable to save `excluded_god_keys` table!", 10)
		end
	end,

	load_data = function(context)
		local faction_keys_list = cm:load_named_value("factions_at_campaign_start", {}, context)
		if is_table(faction_keys_list) then
			for _, faction_key in ipairs(faction_keys_list) do
				deities.persistent[faction_key] = cm:load_named_value("Local_deities_" .. tostring(faction_key), {}, context)
			end
		else
			deities.output("Unable to load persistent data, was not able to get factions_at_campaign_start!" , 10)
		end

		deities.ui_persistent = cm:load_named_value("Local_deities_UI_data", deities.ui_persistent, context)

		deities.excluded_god_keys = cm:load_named_value("Local_deities_excluded_god_keys", deities.excluded_god_keys, context)
		deities.excluded_god_keys = deities.excluded_god_keys or {}

		deities.check_data_consistency()
	end,
}

deities.SetCultCentersVFX = function()
	for k,v in pairs(deities.gods) do
		if v.cult_centre_region_key then
			local region = cm:get_region(v.cult_centre_region_key)
			if region and not region:is_null_interface() then
				local garrison_residence_cqi = region:garrison_residence():command_queue_index()
				cm:add_garrison_residence_vfx(garrison_residence_cqi, "cults_ring_decal", true, false, true)
			end
		end
	end
end

deities.ui_set_army_id_devoted_icon = function(family_member_cqi, visible, god_key)
	local character_family_member = cm:model():family_member_for_command_queue_index(family_member_cqi)
	if character_family_member:is_null_interface() then out("Family member with CQI " .. family_member_cqi .. " does not exist!") return end

	local character = character_family_member:character()
	if character:is_null_interface() then out("character with Family member with CQI " .. family_member_cqi .. " does not exist!") return end

	local military_force = character:military_force()
	if military_force:is_null_interface() then out("military force for character with Family member with CQI " .. family_member_cqi .. " does not exist!") return end

	local cqi = military_force:command_queue_index()
	if visible then
		local god_name_loc_key = deities.get_localised_text(god_key).name_source
		cm:set_custom_army_info_icon(
			cqi,
			"icon_devoted",
			"",
			"devoted_general",
			"devoted_general_descr_format",
			0,
			0,
			0,
			god_name_loc_key)
	else
		cm:set_custom_army_info_icon_visibility(cqi, "icon_devoted", false)
	end
end

deities.ui_on_devoted_general = function(faction_key, family_member_cqi, god_key)
	deities.ui_set_army_id_devoted_icon(family_member_cqi, true, god_key)
end

deities.ui_on_remove_devoted_general = function(faction_key, family_member_cqi)
	deities.ui_set_army_id_devoted_icon(family_member_cqi, false)
end

deities.ui_init_army_ids_devoted_general_icon = function()
	for faction_key, v in pairs(deities.persistent) do
		local god_slots = deities.get_god_slots(faction_key)
		for god_slot_idx, god_slot in ipairs(god_slots) do
			for idx, cqi in pairs(god_slot.devoted_generals_family_member_cqi) do
				if cqi then
					deities.ui_set_army_id_devoted_icon(cqi, true, god_slot.god_key)
				end
			end
		end
	end
end

deities.check_and_update_UI_button = function(faction_key)
	local turn_number = cm:model():turn_number()
	local feature_turn = feature_unlock.get_feature_unlock_turn_for_faction(faction_key, feature_ids_config.local_deities)

	-- do nothing if we're in FTUE mode
	if core:svr_load_bool("sbool_player_selected_first_turn_intro_on_frontend") or cm:get_saved_value("bool_is_tutorial_mode") then
		return
	end

	if turn_number < feature_turn then
		uim:override("disable_local_deities"):lock()
		local title_key_when_inactive = "uied_component_texts_localised_string_title_tx_default_Text_314ba9d2"
		local description_key = "ui_text_replacements_localised_text_button_phar_map_feature_locked_local_deities"
		local feature_available_turn = feature_unlock.get_feature_unlock_turn_for_faction(faction_key, feature_ids_config.local_deities)
		local description_param = {
			{
				text = description_key,
				params = {
					feature_available_turn
				}
			}
		}
		local local_deities_button = core:get_ui_root():SequentialFind(deities.component_ids.local_deities_container, deities.component_ids.local_deities_button)
		if local_deities_button then
			local_deities_button:SetState("inactive")
			local_deities_button:SetTooltipWithTitle(title_key_when_inactive, description_param)
		end
	else
		uim:override("disable_local_deities"):unlock()
	end
end

vo_events =
{
	worship = "campaign_vo_localdeities_worship",
	assign_devotee = "campaign_vo_localdeities_devote_assign"
}

cm:add_saving_game_callback(function(context) deities.save_data(context) end)
cm:add_loading_game_callback(function(context) deities.load_data(context) end)

cm:add_first_tick_callback(
	function()
		local local_faction_name = cm:get_local_faction_name(true)
		deities.check_and_update_UI_button(local_faction_name)
	end
)

--------------------------------------------------------------
----------------------- EVENT LISTENERS  ---------------------
--------------------------------------------------------------

-- Fill starting gods
core:add_listener (
	"PharLocalDeities_NewCampaignStarted",
	"NewCampaignStarted",
	true,
	function(context)
		deities.new_campaign_started = true

		local factions_list = context:model():world():faction_list()
		for i = 0, factions_list:num_items() - 1 do
			local curr_faction = factions_list:item_at(i)
			if curr_faction:is_pharaoh_game_faction() then
				local curr_faction_name = curr_faction:name()
				deities.persistent[curr_faction_name] = {}
				for field_name, value in pairs(deities.faction_persistent_template) do
					if is_table(deities.faction_persistent_template[field_name]) then
						deities.persistent[curr_faction_name][field_name] = {}
					else
						deities.persistent[curr_faction_name][field_name] = value
					end
				end

				-- Take account of startpos buildings
				local region_list = curr_faction:region_list()
				for j = 0, region_list:num_items() - 1 do
					local curr_region = region_list:item_at(j)
					local region_slots = curr_region:slot_list()
					for k = 0, region_slots:num_items() - 1 do
						local slot = region_slots:item_at(k)
						local building = slot:building()
						if building and not building:is_null_interface() then
							deities.transfer_building(building, curr_region:name(), "rebels", curr_faction_name, k)
						end
					end
				end

				-- no startpos force religious buildings are planned for now
			end
		end

		local factions_list = context:model():world():faction_list()
		for i = 0, factions_list:num_items() - 1 do
			local curr_faction = factions_list:item_at(i)
			if curr_faction:is_pharaoh_game_faction() then
				local curr_faction_name = curr_faction:name()
				deities.populate_faction_god_slots(curr_faction_name)
			end
		end

		deities.SetCultCentersVFX()
	end,
	true
)

core:add_listener (
	"PharLocalDeities_FirstTickAfterWorldCreated",
	"FirstTickAfterWorldCreated",
	true,
	function(context)
		local factions_list = context:world():faction_list()

		deities.fill_initial_gods(factions_list)

		deities.recalculate_favour(factions_list)

		deities.set_all_religious_buildings_chain_restrictions(factions_list)
		deities.set_aten_cult_centre_occupation_restrictions()

		deities.check_and_update_UI_button(cm:get_local_faction_name(true))
		deities.update_local_deities_notification()
		deities.update_akhenaten_notification()
		deities.ui_init_army_ids_devoted_general_icon()

		-- Mark all cult centre regions so that C++ code can distinguish them.
		for _, god in ipairs(deities.gods) do
			if is_string(god.cult_centre_region_key) then
				local region = context:world():region_manager():region_by_key(god.cult_centre_region_key)
				if region ~= nil and not region:is_null_interface() then
					cm:set_script_state(region, "is_cult_centre", true)
					deities.output(region:name() .. " is a cult centre.")
				end
			end
		end
	end,
	true
)

-- discover gods from settlement occupation
core:add_listener (
	"PharLocalDeities_SettlementOccupation",
	"CharacterPerformsSettlementOccupationDecision",
	function(context)
		return context:character():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local occupation_decision = context:occupation_decision_option()

		local region = context:garrison_residence():region()
		if not region or region:is_null_interface() then
			return
		end

		if context:character():faction():is_allowed_to_capture_territory() == false
			or (occupation_decision == "occupation_decision_occupy"
			or occupation_decision == "occupation_decision_loot"
			or occupation_decision == "occupation_decision_colonise") then
			local discovered_gods = deities.discover_gods_for_region(context:character():faction():name(), region:name())
			if context:character():faction():name() == cm:get_local_faction_name(true) then
				deities.display_discovered_god_animation(discovered_gods)
			end
		end
	end,
	true
)

-- Discover gods after subjugation - both sides discover the gods from each other's regions
-- include vassalage for completeness
core:add_listener(
	"PharLocalDeities_PositiveDiplomaticEvent",
	"PositiveDiplomaticEvent",
	function(context)
		return context:is_vassalage()
			or context:is_subjugation()
	end,
	function(context)
		local proposer_faction = context:proposer()
		local recipient_faction = context:recipient()

		local recepient_region_list = recipient_faction:region_list()
		for i = 0, recepient_region_list:num_items() - 1 do
			local discovered_gods = deities.discover_gods_for_region(proposer_faction:name(), recepient_region_list:item_at(i):name())
			if proposer_faction:name() == cm:get_local_faction_name(true) then
				deities.display_discovered_god_animation(discovered_gods)
			end
		end

		local proposer_region_list = proposer_faction:region_list()
		for i = 0, proposer_region_list:num_items() - 1 do
			local discovered_gods = deities.discover_gods_for_region(recipient_faction:name(), proposer_region_list:item_at(i):name())
			if recipient_faction:name() == cm:get_local_faction_name(true) then
				deities.display_discovered_god_animation(discovered_gods)
			end
		end
	end,
	true
)

core:add_listener (
	"PharLocalDeities_SettlementOccupationDecisionBeforeOutcomeApplication",
	"CharacterPerformsSettlementOccupationDecisionBeforeOutcomeApplication",
	function(context)
		return context:character():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local occupation_decision = context:occupation_decision_option()
		local cult_centre_region_key = deities.get_god_cult_centre_region(deities.config.aten_god_key)

		local region = context:garrison_residence():region()
		if not region or region:is_null_interface() then
			return
		end

		if (occupation_decision == "occupation_decision_occupy"
			or occupation_decision == "occupation_decision_loot"
			or occupation_decision == "occupation_decision_colonise")
			and region:name() == deities.get_god_cult_centre_region(deities.config.aten_god_key)
		then
			local new_owner_key = context:character():faction():name()
			local old_owner_key = region:owning_faction():name()

			if deities.has_faction_claimed_akhenaten(old_owner_key) then
				deities.add_deities_event_message("ancient_legacy_aten_amarna_lost", old_owner_key, 0, region:name(), cm:char_lookup_str(context:character():command_queue_index()))
			end
			if deities.has_faction_claimed_akhenaten(new_owner_key) then
				deities.add_deities_event_message("ancient_legacy_aten_amarna_captured", new_owner_key, 0, region:name(), cm:char_lookup_str(context:character():command_queue_index()))
				core:trigger_event("ScriptEventAkhenatenAmarnaCaptured", { faction = context:character():faction() })
			end
		end
	end,
	true
)

core:add_listener (
	"PharLocalDeities_RegionFactionChangeEvent",
	"RegionFactionChangeEvent",
	function(context)
		return context:region():owning_faction():is_pharaoh_game_faction()
	end,
	function(context)
		local region = context:region()
		local new_faction = region:owning_faction():name()
		-- discover gods from settlement trade and confederation in diplomacy
		-- or by using the console to take control of a region
		local reason = context:reason()
		if reason == "diplomacy trade" or reason == "campaign director" then
			local discovered_gods = deities.discover_gods_for_region(new_faction, region:name())
			if new_faction == cm:get_local_faction_name(true) then
				deities.display_discovered_god_animation(discovered_gods)
			end
		end

		-- transfer favour from religious buildings to new owner
		local previous_faction = context:previous_faction():name()
		local region_key = region:name()

		local region_slots = region:slot_list()
		for i=0, region_slots:num_items() - 1 do
			local slot = region_slots:item_at(i)
			local building = slot:building()
			if building and not building:is_null_interface() then
				deities.transfer_building(building, region_key, previous_faction, new_faction)
			end
		end

		-- Update Aten's cult centre effects based on owner
		local cult_centre_region_key = deities.get_god_cult_centre_region(deities.config.aten_god_key)
		if cult_centre_region_key ~= "" and region:name() == cult_centre_region_key then
			local new_owner_aten_tier = deities.get_tier(new_faction, deities.config.aten_god_key)
			if new_owner_aten_tier > 0 then
				deities.update_unique_effects(new_faction, 0, new_owner_aten_tier)
			end

			local previous_owner_aten_tier = deities.get_tier(previous_faction, deities.config.aten_god_key)
			if previous_owner_aten_tier > 0 then
				deities.remove_aten_cult_centre_effects(previous_faction)
			end
		end
	end,
	true
)

core:add_listener (
	"PharLocalDeities_ResearchCompleted",
	"ResearchCompleted",
	function(context)
		return context:faction():name() == cm:get_local_faction_name(true)
	end,
	function(context)
		deities.update_local_deities_notification()
	end,
	true
)

core:add_listener (
	"PharLocalDeities_FactionTurnEnd",
	"FactionTurnEnd",
	function(context)
		return context:faction():is_pharaoh_game_faction()
	end,
	function(context)
		local faction_key = context:faction():name()

		-- reduce timers for prayer effects
		if deities.persistent[faction_key] then
			local god_slots = deities.get_god_slots(faction_key)
			for _, god_slot in ipairs(god_slots) do
				for j=#god_slot.armies_with_prayer_effects, 1, -1 do
					if god_slot.armies_with_prayer_effects[j].turns_left == 1 then
						table.remove(god_slot.armies_with_prayer_effects, j)
					else
						god_slot.armies_with_prayer_effects[j].turns_left = god_slot.armies_with_prayer_effects[j].turns_left - 1
					end
				end
			end
		end
	end,
	true
)

core:add_listener (
	"PharLocalDeities_FactionTurnStart",
	"FactionTurnStart",
	function(context)
		local faction = context:faction()
		local faction_key = faction:name()
		local local_faction_key = cm:get_local_faction_name(true)
		return faction:is_human() and faction_key == local_faction_key
	end,
	function(context)
		local faction_key = context:faction():name()
		-- this check should not be needed, but it's here for extra safety
		if not is_number(deities.ui_persistent.last_round_god_discovered) then
			-- for save migration
			deities.ui_persistent.last_round_god_discovered = cm:model():turn_number()
		elseif deities.ui_persistent
			and is_table(deities.ui_persistent.newly_discovered_gods)
			and #deities.ui_persistent.newly_discovered_gods > 0
		then
			local current_turn = cm:model():turn_number()
			local unlock_turn = feature_unlock.get_feature_unlock_turn_for_faction(faction_key, feature_ids_config.local_deities)
			local turns_visible = 2
			-- for both of these, 0 means 'was discovered/unlocked this turn'
			-- 1 means 'last turn'. this is why if the value becomes 2, this means there was an entire turn the player saw the notification from start to finish, and chose not to open it
			-- then we clear the array, to remove the notification
			local turns_since_last_discovered = current_turn - deities.ui_persistent.last_round_god_discovered
			local turns_since_unlocked = current_turn - unlock_turn
			if turns_since_last_discovered >= turns_visible
				and turns_since_unlocked >= turns_visible
			then
				deities.ui_persistent.newly_discovered_gods = {}
			end
		end
		deities.check_and_update_UI_button(faction_key)
		deities.update_local_deities_notification()
	end,
	true
)

-- start building temples. shrines and dwellings
core:add_listener (
	"PharLocalDeities_BuildingConstructionStarted",
	"BuildingConstructionStarted",
	function(context)
		return context:garrison_residence():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local garrison_residence = context:garrison_residence()
		if not garrison_residence:is_slot() then
			return
		end
		local slot = garrison_residence:slot_interface()

		local old_building = slot:building()
		-- If we are building in place of another religious building (conversion) - remove the old building
		-- If we come here from changing a religious building due to rededication, old_building will be null due to insta-completion
		if not (old_building and not old_building:is_null_interface()) then
			return
		end
		local region_key = garrison_residence:region():name()
		local faction_key = garrison_residence:faction():name()
		local old_building_chain = slot:building():chain()
		-- Check for shrine
		local old_shrine_god = table_find(deities.gods, function(e) return old_building_chain == e.shrine_chain end)
		if old_shrine_god then
			local god_slot = deities.get_god_slot(faction_key, old_shrine_god.key)
			if not god_slot then
				return
			end

			-- Check if the old building is under conversion, then we got here due to changing the shrine from the Local deities panel and we do not need to handle this
			local shrine_under_conversion = deities.get_shrine_under_conversion(faction_key, old_shrine_god.key, region_key)
			if not shrine_under_conversion then
				local new_building_chain = context:building_chain()
				local new_shrine_god = table_find(deities.gods, function(e) return new_building_chain == e.shrine_chain end)
				if new_shrine_god then
					deities.find_and_change_shrine_god(faction_key, new_shrine_god.key, region_key)
					return
				end
			end
		end
		-- Check for temple
		local old_temple_god = table_find(deities.gods, function(e) return old_building_chain == e.temple_chain end)
		if old_temple_god then
			local god_slot = deities.get_god_slot(faction_key, old_temple_god.key)
			if not god_slot then
				return
			end

			-- Check if the old building is under conversion, then we got here due to changing the temple from the Local deities panel and we do not need to handle this
			local temple_under_conversion = deities.get_temple_under_conversion(faction_key, old_temple_god.key, region_key)
			if not temple_under_conversion then
				local new_building_chain = context:building_chain()
				local new_temple_god = table_find(deities.gods, function(e) return new_building_chain == e.temple_chain end)
				-- If the gods are the same we are upgrading, not converting
				if new_temple_god and new_temple_god ~= old_temple_god then
					deities.find_and_change_temple_god(faction_key, new_temple_god.key, region_key)
					return
				end
			end
		end
		-- Check for dwelling
		local old_dwelling_god = table_find(deities.gods, function(e) return old_building_chain == e.dwelling_chain end)
		if old_dwelling_god then
			local god_slot = deities.get_god_slot(faction_key, old_dwelling_god.key)
			if not god_slot then
				return
			end

			-- Check if the old building is under conversion, then we got here due to changing the dwelling from the Local deities panel and we do not need to handle this
			local dwelling_under_conversion = deities.get_dwelling_under_conversion(faction_key, old_dwelling_god.key, region_key)
			if not dwelling_under_conversion then
				local new_building_chain = context:building_chain()
				local new_dwelling_god = table_find(deities.gods, function(e) return new_building_chain == e.dwelling_chain end)
				if new_dwelling_god then
					deities.find_and_change_dwelling_god(faction_key, new_dwelling_god.key, region_key)
					return
				end
			end
		end
	end,
	true
)

core:add_listener(
	"PharLocalDeities_CharacterMilitaryForceBuildingConstructionStarted",
	"CharacterMilitaryForceBuildingConstructionStarted",
	function(context)
		return context:character():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local character = context:character()
		local force = character:military_force()
		if not force or force:is_null_interface() or not tribes_privileges.is_horde_type(force) then
			return
		end

		local old_building_chain = context:old_building_chain()
		if old_building_chain == "" then
			return
		end

		-- check if we're building on top of an idol building
		local old_idol_god = table_find(deities.gods, function(e) return old_building_chain == e.idol_chain end)
		if old_idol_god then
			local faction_key = character:faction():name()
			local god_slot = deities.get_god_slot(faction_key, old_idol_god.key)
			if not god_slot then
				return
			end

			-- If we are building in place of another idol (conversion) - remove the old building
			-- Check if the old building is under conversion, then we got here due to changing the idol from the Local deities panel and we do not need to handle this
			local force_cqi = force:command_queue_index()
			local idol_under_conversion = deities.get_idol_under_conversion(faction_key, old_idol_god.key, force_cqi)
			if not idol_under_conversion then
				local new_building_chain = context:building_chain()
				local new_idol_god = table_find(deities.gods, function(e) return new_building_chain == e.idol_chain end)
				-- If the gods are the same we are upgrading, not converting
				if new_idol_god and new_idol_god ~= old_idol_god then
					deities.find_and_change_idol_god(faction_key, new_idol_god.key, force_cqi)
				end
			end
		end
	end,
	true,
	true
)

-- cancel building temples, shrines and dwellings
core:add_listener (
	"PharLocalDeities_BuildingConstructionCanceled",
	"BuildingConstructionCanceled",
	function(context)
		return context:garrison_residence():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local garrison_residence = context:garrison_residence()
		if garrison_residence:is_slot() then
			local slot = garrison_residence:slot_interface()
			local building = slot:building()
			-- If we cancel construction that is in place of a religious building and it is a conversion - add back the previous building
			if building and not building:is_null_interface() then
				local region_key = garrison_residence:region():name()
				local faction_key = garrison_residence:faction():name()
				local building_chain = slot:building():chain()

				-- Check for shrine
				local shrine_god = table_find(deities.gods, function(e) return building_chain == e.shrine_chain end)
				if shrine_god then
					deities.cancel_shrine_conversion(faction_key, shrine_god.key, region_key)
					return
				end

				-- Check for temple
				local temple_god = table_find(deities.gods, function(e) return building_chain == e.temple_chain end)
				if temple_god then
					-- If it a conversion - cancel it
					local temple_under_conversion = deities.get_temple_under_conversion(faction_key, temple_god.key, region_key)
					if temple_under_conversion then
						deities.cancel_temple_conversion(faction_key, temple_god.key, region_key)
					end
				end

				-- Check for dwelling
				local dwelling_god = table_find(deities.gods, function(e) return building_chain == e.dwelling_chain end)
				if dwelling_god then
					deities.cancel_dwelling_conversion(faction_key, dwelling_god.key, region_key)
					return
				end
			end
		end
	end,
	true
)

-- cancel building idols
core:add_listener(
	"PharLocalDeities_CharacterMilitaryForceBuildingConstructionCanceled",
	"CharacterMilitaryForceBuildingConstructionCanceled",
	function(context)
		return context:character():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local character = context:character()
		local force = character:military_force()
		if not force or force:is_null_interface() or not tribes_privileges.is_horde_type(force) then
			return
		end

		local force_cqi = force:command_queue_index()
		local faction_key = character:faction():name()
		local building_chain = context:building_chain()
		if building_chain == "" then
			return
		end
		-- if we cancel construction that is in place of an idol (conversion) - add back the previous building
		local idol_god = table_find(deities.gods, function(e) return building_chain == e.idol_chain end)
		if idol_god then
			deities.cancel_idol_conversion(faction_key, force_cqi)
		end
	end,
	true,
	true
)

-- build (or upgrade) temples, shrines and dwellings
core:add_listener (
	"PharLocalDeities_BuildingCompleted",
	"BuildingCompleted",
	function(context)
		return context:building():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local building = context:building()
		local building_chain = building:chain()
		local faction_key = building:faction():name()
		local god = table_find(deities.gods, function(e) return building_chain == e.temple_chain end)
		-- building is a temple
		if god then
			local region = context:garrison_residence():region():name()
			local level = building:level()
			deities.add_or_upgrade_temple(faction_key, god.key, region, level)
			return
		end

		god = table_find(deities.gods, function(e) return building_chain == e.shrine_chain end)
		-- building is a shrine
		if god then
			local region = context:garrison_residence():region():name()
			deities.add_shrine(faction_key, god.key, region)
			return
		end

		god = table_find(deities.gods, function(e) return building_chain == e.dwelling_chain end)
		-- building is a dwelling
		if god then
			local region = context:garrison_residence():region():name()
			deities.add_dwelling(faction_key, god.key, region)
			return
		end

		local cult_centre_god = table_find(deities.gods, function(e) return building_chain == e.cult_centre_chain end)
		-- building is a cult centre grand temple
		if cult_centre_god then
			deities.add_cult_centre(faction_key, cult_centre_god.key)
		end
	end,
	true
)

-- build (or upgrade) idols
core:add_listener(
	"PharLocalDeities_CharacterMilitaryForceBuildingCompleted",
	"CharacterMilitaryForceBuildingCompleted",
	function(context)
		return context:character():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local character = context:character()
		local force = character:military_force()
		if not force or force:is_null_interface() or not tribes_privileges.is_horde_type(force) then
			return
		end

		local building = context:building()
		local faction_key = character:faction():name()
		if faction_key ~= building:faction():name() then-- this if is a sanity check, TODO: remove it at some point
			deities.output("Error: Invalid building faction!")
			return
		end

		-- check if the building is an Idol
		local building_chain = building:chain()
		local idol_god = table_find(deities.gods, function(e) return building_chain == e.idol_chain end)
		if idol_god then
			local god_slot = deities.get_god_slot(faction_key, idol_god.key)
			if not god_slot then
				deities.output("Faction " .. faction_key .. " built idol for god " .. idol_god.key .. " but does not worship it!", 10)
				return
			end

			local level = building:level()
			local force_cqi = force:command_queue_index()
			deities.add_or_upgrade_idol(faction_key, idol_god.key, force_cqi, level)
		end
	end,
	true
)

-- demolish temples, shrines and dwellings
core:add_listener (
	"PharLocalDeities_BuildingDemolished",
	"BuildingDemolished",
	function(context)
		return context:building():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local building = context:building()
		local building_chain = building:chain()
		local faction_key = building:faction():name()
		local god = table_find(deities.gods, function(e) return building_chain == e.temple_chain end)
		local region = context:garrison_residence():region():name()
		-- building is a temple
		if god then
			deities.remove_temple(faction_key, god.key, region)
			return
		end

		god = table_find(deities.gods, function(e) return building_chain == e.shrine_chain end)
		-- building is a shrine
		if god then
			deities.remove_shrine(faction_key, god.key, region)
			return
		end

		god = table_find(deities.gods, function(e) return building_chain == e.dwelling_chain end)
		-- building is a dwelling
		if god then
			deities.remove_dwelling(faction_key, god.key, region)
			return
		end

		local cult_centre_god = table_find(deities.gods, function(e) return building_chain == e.cult_centre_chain end)
		-- building is a cult centre grand temple
		if cult_centre_god then
			deities.remove_cult_centre(faction_key, cult_centre_god.key)
		end
	end,
	true
)

-- demolish idols
core:add_listener (
	"PharLocalDeities_CharacterMilitaryForceBuildingDemolished",
	"CharacterMilitaryForceBuildingDemolished",
	function(context)
		return context:character():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local character = context:character()
		local force = character:military_force()
		if not force or force:is_null_interface() or not tribes_privileges.is_horde_type(force) then
			return
		end

		local building = context:building()
		local faction_key = character:faction():name()
		if faction_key ~= building:faction():name() then-- this if is a sanity check, TODO: remove it at some point
			deities.output("Error: Invalid building faction!")
			return
		end

		-- check if the building is an Idol
		local building_chain = building:chain()
		local god = table_find(deities.gods, function(e) return building_chain == e.idol_chain end)
		if god then
			local force_cqi = force:command_queue_index()
			deities.remove_idol(faction_key, god.key, force_cqi)
			end
	end,
	true,
	true
)

-- building repaired
core:add_listener (
	"PharLocalDeities_BuildingRepaired",
	"CampaignBuildingRepaired",
	true,
	function(context)
		local garrison_residence = context:garrison_residence()
		if garrison_residence:is_slot() then
			local slot = garrison_residence:slot_interface()
			local region_key = garrison_residence:region():name()
			local faction_key = garrison_residence:faction():name()
			local building_chain = slot:building():chain()
			-- Check for shrine
			local shrine_god = table_find(deities.gods, function(e) return building_chain == e.shrine_chain end)
			if shrine_god then
				deities.update_shrine_favour(faction_key, shrine_god.key)
				return
			end
			-- Check for temple
			local temple_god = table_find(deities.gods, function(e) return building_chain == e.temple_chain end)
			if temple_god then
				deities.update_temple_favour(faction_key, temple_god.key)
				return
			end
			-- Check for dwelling
			local dwelling_god = table_find(deities.gods, function(e) return building_chain == e.dwelling_chain end)
			if dwelling_god then
				deities.update_dwelling_favour(faction_key, dwelling_god.key)
				return
			end
			-- Check for cult centre high temple
			local cult_centre_god = table_find(deities.gods, function(e) return building_chain == e.cult_centre_chain end)
			if cult_centre_god then
				deities.update_cult_centre_favour(faction_key, cult_centre_god.key)
			end
		end
	end,
	true
)

-- force building repaired
core:add_listener(
	"PharLocalDeities_CharacterMilitaryForceBuildingRepaired",
	"CharacterMilitaryForceBuildingRepaired",
	function(context)
		return context:character():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local character = context:character()
		local force = character:military_force()
		if not force or force:is_null_interface() or not tribes_privileges.is_horde_type(force) then
			return
		end

		local building = context:building()
		local faction_key = character:faction():name()
		if faction_key ~= building:faction():name() then-- this if is a sanity check, TODO: remove it at some point
			deities.output("Error: Invalid building faction!")
			return
		end

		-- check if the building is an Idol
		local building_chain = building:chain()
		local idol_god = table_find(deities.gods, function(e) return building_chain == e.idol_chain end)
		if idol_god then
			deities.update_idol_favour(faction_key, idol_god.key)
		end
	end,
	true,
	true
)

-- building damaged
core:add_listener (
	"PharLocalDeities_BuildingDamaged",
	"CampaignBuildingDamaged",
	true,
	function(context)
		local garrison_residence = context:garrison_residence()
		if garrison_residence:is_slot() then
			local slot = garrison_residence:slot_interface()
			local region_key = garrison_residence:region():name()
			local faction_key = garrison_residence:faction():name()
			local building_chain = slot:building():chain()
			-- Check for shrine
			local shrine_god = table_find(deities.gods, function(e) return building_chain == e.shrine_chain end)
			if shrine_god then
				deities.update_shrine_favour(faction_key, shrine_god.key)
				return
			end
			-- Check for temple
			local temple_god = table_find(deities.gods, function(e) return building_chain == e.temple_chain end)
			if temple_god then
				deities.update_temple_favour(faction_key, temple_god.key)
				return
			end
			-- Check for dwelling
			local dwelling_god = table_find(deities.gods, function(e) return building_chain == e.dwelling_chain end)
			if dwelling_god then
				deities.update_dwelling_favour(faction_key, dwelling_god.key)
				return
			end
			-- Check for cult centre high temple
			local cult_centre_god = table_find(deities.gods, function(e) return building_chain == e.cult_centre_chain end)
			if cult_centre_god then
				deities.update_cult_centre_favour(faction_key, cult_centre_god.key)
			end
		end
	end,
	true
)

core:add_listener (
	"PharLocalDeities_RegionAboutToBeAbandoned",
	"RegionAboutToBeAbandoned",
	true,
	function(context)
		local region = context:region()
		local faction_key = region:owning_faction():name()

		local region_slots = region:slot_list()
		for i = 0, region_slots:num_items() - 1 do
			local slot = region_slots:item_at(i)
			local building = slot:building()
			if building and not building:is_null_interface() then
				deities.transfer_building(building, region:name(), faction_key, "rebels")
			end
		end
	end,
	true
)

-- force building damaged
core:add_listener(
	"PharLocalDeities_CharacterCampaignBuildingDamaged",
	"CharacterMilitaryForceBuildingDamaged",
	function(context)
		return context:character():faction():is_pharaoh_game_faction()
	end,
	function(context)
		local character = context:character()
		local force = character:military_force()
		if not force or force:is_null_interface() or not tribes_privileges.is_horde_type(force) then
			return
		end

		local building = context:building()
		local faction_key = character:faction():name()
		if faction_key ~= building:faction():name() then-- this if is a sanity check, TODO: remove it at some point
			deities.output("Error: Invalid building faction!")
			return
		end

		-- check if the building is an Idol
		local building_chain = building:chain()
		local idol_god = table_find(deities.gods, function(e) return building_chain == e.idol_chain end)
		if idol_god then
			deities.update_idol_favour(faction_key, idol_god.key)
		end
	end,
	true,
	true
)

-- general recruited
core:add_listener (
	"PharLocalDeities_NewCharacterRecruited",
	"NewCharacterRecruited",
	true,
	function(context)
		local faction_key = context:character():faction():name()

		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slots = deities.get_god_slots(faction_key)
		local general_family_member_cqi = context:character():family_member():command_queue_index()
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			local god_slot = god_slots[i]
			local devoted_general_index = table_find(god_slot.devoted_generals_family_member_cqi, general_family_member_cqi, true)
			if devoted_general_index then
				local general = deities.get_devoted_general(faction_key, god_slot.god_key, devoted_general_index)
				if general and not general:is_null_interface() then
					local localised_text = deities.get_localised_text(god_slot.god_key)
					cm:set_script_state(general, "devoted_god_display_name_key", localised_text.name_source)
					local god_data = deities.get_god(god_slot.god_key)
					if god_data then
						cm:set_script_state(general, "devoted_god_image", god_data.god_slot_image)
					end
				end
			end
		end
	end,
	true
)

-- Check if a devoted general changes their faction. Remove them from the list of devoted generals if they do.
core:add_listener (
	"PharLocalDeities_CharacterFactionChange",
	"CharacterFactionChange",
	true,
	function(context)
		local faction_key = context:old_faction():name()
		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slots = deities.get_god_slots(faction_key)
		local general_family_member_cqi = context:character():family_member():command_queue_index()
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			local god_slot = god_slots[i]
			local devoted_general_index = table_find(god_slot.devoted_generals_family_member_cqi, general_family_member_cqi, true)

			if devoted_general_index then
				deities.remove_devoted_general(faction_key, god_slots[i].god_key, devoted_general_index, false)
			end
		end
	end,
	true
)

-- general died
core:add_listener (
	"PharLocalDeities_FactionCharacterDiedOrWounded",
	"FactionCharacterDiedOrWounded",
	function(context)
		-- wounded general still remains devoted
		return not context:family_member():is_alive()
	end,
	function(context)
		local faction_key = context:family_member():character():faction():name()

		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local god_slots = deities.get_god_slots(faction_key)
		local general_family_member_cqi = context:family_member():command_queue_index()
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			local god_slot = god_slots[i]
			local devoted_general_index = table_find(god_slot.devoted_generals_family_member_cqi, general_family_member_cqi, true)

			if devoted_general_index then
				deities.devoted_general_died(faction_key, god_slots[i].god_key, devoted_general_index)
			end
		end
	end,
	true
)

-- horde general died
-- a wounded general that dies maintains his buildings intact, but if it has any religious buildings in his army those should not give favour for the time he's wounded
-- when he recovers said religious buildings should immediately become reactivated
core:add_listener(
	"PharLocalDeities_FactionCharacterDiedOrWoundedHorde",
	"FactionCharacterDiedOrWounded",
	function(context)
		return is_sea_playable_faction(context:faction():name())
	end,
	function(context)
		local character = context:family_member():character()
		local force = character:military_force()
		if not force or force:is_null_interface() then
			deities.output("ERROR: Can't query for force cqi after general's death!")
			return
		end

		if not tribes_privileges.is_horde_type(force) then
			return
		end

		if not is_table(deities.persistent[faction_key]) then
			return
		end

		-- remove any idols that the general had in his army
		local faction_key = character:faction():name()
		local god_slots = deities.get_god_slots(faction_key)
		for i = 1, deities.get_faction_god_slots_count(faction_key) do
			local god_slot = god_slots[i]
			if god_slot.god_key then
				local index = table_find(god_slot.idols, function(e) return e.force_cqi == god_slot.force_cqi end, true)
				if index then
					deities.remove_idol(faction_key, god_slot.god_key, god_slot.force_cqi)
					break
				end
			end
		end
	end,
	true
)

-- horde general is begotten
core:add_listener(
	"PharLocalDeities_CharacterEntersMilitaryForceHorde",
	"CharacterEntersMilitaryForce",
	true,
	function(context)
		local character = context:character()
		local force = character:military_force()
		if not force or force:is_null_interface() or not tribes_privileges.is_horde_type(force) then
			return
		end

		local faction_key = character:faction():name()
		local force_cqi = force:command_queue_index()

		-- check if the force has any Idol buildings
		local force_slots = force:buildings()
		if not force_slots then
			return
		end

		local last_slot_index = force_slots:num_items() - 1
		for i = 0, last_slot_index do
			local building = force_slots:item_at(i)
			local building_chain = building:chain()
			local idol_god = table_find(deities.gods, function(e) return building_chain == e.idol_chain end)
			if idol_god then
				local god_slot = deities.get_god_slot(faction_key, idol_god.key)
				if not god_slot then
					deities.output("Faction " .. faction_key .. " built idol for god " .. idol_god.key .. " but does not worship it!", 10)
					return
				end

				local level = building:level()
				deities.add_or_upgrade_idol(faction_key, idol_god.key, force_cqi, level)
			end
		end
	end,
	true
)

core:add_listener(
	"PharLocalDeities_MilitaryForceHordeStatusAboutToChange",
	"MilitaryForceHordeStatusAboutToChange",
	true,
	function(context)
		local force = context:military_force()
		local from_type = context:from_type()
		local to_type = context:to_type()
		if not force or force:is_null_interface() then
			return
		end

		-- only handle changing from horde to settled
		if not (tribes_privileges.is_horde_type_string(from_type) and not tribes_privileges.is_horde_type_string(to_type)) then
			return
		end

		local force_slots = force:buildings()
		if not force_slots then
			return
		end

		local faction_key = force:faction():name()
		local force_cqi = force:command_queue_index()

		local last_slot_index = force_slots:num_items() - 1
		for i = 0, last_slot_index do
			local building = force_slots:item_at(i)
			local building_chain = building:chain()
			local idol_god = table_find(deities.gods, function(e) return building_chain == e.idol_chain end)
			if idol_god then
				local god_slot = deities.get_god_slot(faction_key, idol_god.key)
				if not god_slot then
					deities.output("Faction " .. faction_key .. " built idol for god " .. idol_god.key .. " but does not worship it!", 10)
				end

				deities.remove_idol(faction_key, idol_god.key, force_cqi)
			end
		end
	end,
	true
)

core:add_listener(
	"PharLocalDeities_MilitaryForceHordeStatusChanged",
	"MilitaryForceHordeStatusChanged",
	true,
	function(context)
		local force = context:military_force()
		local from_type = context:from_type()
		local to_type = context:to_type()
		if not force or force:is_null_interface() then
			return
		end

		-- only handle changing from settled to horde
		if not (not tribes_privileges.is_horde_type_string(from_type) and tribes_privileges.is_horde_type_string(to_type)) then
			return
		end

		local force_slots = force:buildings()
		if not force_slots then
			return
		end

		local faction_key = force:faction():name()
		local force_cqi = force:command_queue_index()

		local last_slot_index = force_slots:num_items() - 1
		for i = 0, last_slot_index do
			local building = force_slots:item_at(i)
			local building_chain = building:chain()
			local idol_god = table_find(deities.gods, function(e) return building_chain == e.idol_chain end)
			if idol_god then
				local god_slot = deities.get_god_slot(faction_key, idol_god.key)
				if not god_slot then
					deities.output("Faction " .. faction_key .. " built idol for god " .. idol_god.key .. " but does not worship it!", 10)
				end

				local level = building:level()
				deities.add_or_upgrade_idol(faction_key, idol_god.key, force_cqi, level)
			end
		end
	end,
	true
)

core:add_listener (
	"PharLocalDeities_CharacterLeavesMilitaryForce",
	"CharacterLeavesMilitaryForce",
	true,
	function(context)
		local faction_key = context:character():faction():name()

		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local general_family_member_cqi = context:character():family_member():command_queue_index()
		if deities.is_devoted_general(faction_key, general_family_member_cqi) then
			deities.ui_set_army_id_devoted_icon(general_family_member_cqi, false)
		end
	end,
	true
)

core:add_listener (
	"PharLocalDeities_CharacterEntersMilitaryForce",
	"CharacterEntersMilitaryForce",
	true,
	function(context)
		local faction_key = context:character():faction():name()

		if not is_table(deities.persistent[faction_key]) then
			return
		end

		local general_family_member_cqi = context:character():family_member():command_queue_index()
		if deities.is_devoted_general(faction_key, general_family_member_cqi) then
			deities.ui_set_army_id_devoted_icon(general_family_member_cqi, true)
		end
	end,
	true
)

-- prayer performed
-- horde Sea character forces pray on nomad outposts, the rest pray on shrine outposts
core:add_listener (
	"PharLocalDeities_MadePrayer",
	"CharacterGarrisonTargetAction",
	true,
	function(context)
		local agent_action_key = context:agent_action_key()
		local index
		for i, prefix in ipairs(deities.config.pray_interaction_prefixes) do
			if string.find(agent_action_key, prefix) then
				index = i
			end
		end

		if not index then
			return
		end

		local string_element = deities.config.pray_interaction_prefixes[index]
		local _, last = string.find(agent_action_key, string_element)
		local god_key = string.sub(agent_action_key, last + 1)

		local faction_key = context:character():faction():name()
		local force_cqi = context:character():military_force():command_queue_index()
		deities.make_prayer(faction_key, god_key, force_cqi)
	end,
	true
)

-- Won the campaign, do not show the discovered god animation over the win cinematic
core:add_listener (
	"PharLocalDeities_FactionAchievedVictoryEvent",
	"FactionAchievedVictoryEvent",
	function(context)
		return context:faction():name() == cm:get_local_faction_name(true)
	end,
	function(context)
		deities.hide_discovered_god_animation()
	end,
	true
)

core:add_listener (
	"PharLocalDeities_LegitimacyPathUnlocked",
	"LegitimacyPathUnlocked",
	true,
	function(context)
		deities.ai_attempt_to_worship_new_god(context.stored_table.faction_key)
	end,
	true
)

core:add_listener (
	"PharLocalDeities_ScriptEventFavouredGodUpdated",
	"ScriptEventFavouredGodUpdated",
	true,
	function(context)
		local factions = legitimacy_choice:get_factions_with_legitimacy_object(context.stored_table.legitimacy_path_obj)
		for faction_key, _ in dpairs(factions) do
			deities.ai_attempt_to_worship_new_god(faction_key)
		end
	end,
	true
)

--------------------------------------------------------------
-----------------------UI EVENT LISTENERS  -------------------
--------------------------------------------------------------

-- panel opened
core:add_listener (
	"PharLocalDeities_PanelOpenedCampaign",
	"PanelOpenedCampaign",
	function(context)
 		return context.string == deities.component_ids.panel
	end,
	function(context)
		deities.panel = core:get_ui_root():SequentialFind(deities.component_ids.panel)
		if not deities.panel then
			script_error("ERROR: Local deities panel is not found!");
			return
		end

		deities.init_ui_templates()

		deities.display_god_slots()

		core:add_listener (
			"PharLocalDeities_ButtonClicked",
			"ComponentLClickUp",
			true,
			function(context)
				-- Slot available button
				if context.string == deities.component_ids.god_slot_available_btn then
					deities.on_all_gods_tab_clicked()
				-- Previous god button
				elseif context.string == deities.component_ids.previous_button then
					deities.on_previous_clicked(context)
				-- Previous god button
				elseif context.string == deities.component_ids.next_button then
					deities.on_next_clicked(context)
				-- Worship button
				elseif context.string == deities.component_ids.worship_button then
					deities.on_worship_clicked(context)
				-- Culture tab button
				elseif table_find(deities.component_ids.tab_buttons, context.string) then
					deities.on_culture_tab_clicked(context)
				-- Worshipped tab
				elseif context.string == deities.component_ids.worshipped_tab then
					deities.on_worshipped_tab_clicked()
				-- All gods tab
				elseif context.string == deities.component_ids.all_gods_tab then
					deities.on_all_gods_tab_clicked()
				-- Devoted general slot
				elseif string.find(context.string, deities.component_ids.devoted_general_instance_prefix) then
					deities.on_army_button_clicked(context)
				-- General that can become devoted
				elseif string.find(context.string, deities.component_ids.army_prefix) then
					deities.on_general_clicked(context)
				-- Religious buildings button
				elseif context.string == deities.component_ids.shrines_button then
					deities.on_religious_buildings_button_clicked(context)
				-- Religious buildings cancel changes
				elseif context.string == deities.component_ids.shrines_button_cancel then
					deities.close_religious_buidings()
				-- Religious buildings apply changes
				elseif context.string == deities.component_ids.shrines_button_apply then
					deities.on_religious_buildings_apply_changes()
				-- Religious buildings radio buttons
				elseif context.string == deities.component_ids.shrines_toggle_template_radio_button then
					deities.religious_buildings_refresh_cost_and_time()
					deities.update_idols_radio_buttons()
				-- Rededicate cancel
				elseif context.string == deities.component_ids.rededicate_dialogue_button_cancel then
					deities.on_rededication_cancel()
				-- Rededicate confirm
				elseif context.string == deities.component_ids.rededicate_dialogue_button_confirm then
					deities.on_rededication_confirm()
				-- God for rededication
				elseif string.find(context.string, deities.component_ids.rededicate_god_template_instance_prefix) then
					deities.on_god_for_rededication_clicked(context)
				-- God for creation of Aten
				elseif string.find(context.string, deities.component_ids.aten_creation_god_prefix) then
					deities.choose_aten_god(context)
				-- Unlockable chosen for Aten
				elseif string.find(context.string, deities.component_ids.aten_unlockable_prefix) then
					deities.on_unlockable_clicked(context)
				end
			end,
			true
		)

		-- For buttons that use TriggerLocalContextEvent from the layout
		core:add_listener (
			"PharLocalDeities_ButtonClicked_UI",
			"ContextTriggerEvent",
			function(context)
				return context.string:split(":")[1] == "DeitiesButton"
			end,
			function(context)
				local splits = context.string:split(":")
				local button_key = splits[2]
				if button_key == deities.commands.open_create_aten then
					deities.open_create_aten()
				elseif button_key == deities.commands.open_aten then
					deities.open_aten()
				elseif button_key == deities.commands.confirm_create_aten then
					deities.confirm_create_aten()
				elseif string.find(button_key, deities.commands.aten_god_prefix) then
					deities.on_aten_god_to_remove(button_key)
				elseif button_key == deities.commands.confirm_select_unlockable then
					deities.confirm_select_unlockable()
				elseif button_key == deities.commands.deselect_all then
					deities.deselect_all()
				elseif button_key == deities.commands.cult_centre then
					deities.zoom_to_cult_centre()
				elseif button_key == deities.commands.zoom_to_realm then
					deities.zoom_to_realm(splits[3])
				elseif button_key == deities.commands.unlockables then
					deities.display_unlockables()
				elseif button_key == deities.commands.back_selected then
					deities.on_back_selected_clicked()
				elseif button_key == deities.commands.back_unlockables then
					deities.on_back_unlockables_clicked()
				elseif button_key == deities.commands.back_aten_creation then
					deities.on_back_aten_creation()
				elseif button_key == deities.commands.god_slot then
					deities.on_god_slot_clicked(splits[3])
				elseif button_key == deities.commands.god_selected then
					deities.on_god_clicked(splits[3])
				elseif button_key == deities.commands.hecatomb then
					deities.on_hecatomb_clicked()
				else
					deities.output("Error: unknown button '".. button_key .. "'")
				end
			end,
			true
		)
	end,
	true
)

-- For buttons in the discovered gods animation
core:add_listener (
	"PharLocalDeitiesDiscoveredGods_ButtonClicked_UI",
	"ContextTriggerEvent",
	function(context)
		return context.string:split(":")[1] == "DeitiesButton"
	end,
	function(context)
		local splits = context.string:split(":")
		local button_key = splits[2]
		if button_key == deities.commands.discovered_animation_god_selected then
			local god_key = splits[3]

			-- Open Local deities and select the god if the mechanic is unlocked
			if not deities.panel then
				local local_deities_button = core:get_ui_root():SequentialFind(deities.component_ids.local_deities_container, deities.component_ids.local_deities_button)
				if local_deities_button and not local_deities_button:CurrentState():find("inactive") then
					local_deities_button:SimulateLClick()
				end
			end
			if deities.panel then
				deities.open_selected_god(god_key)
			end
		else
			deities.output("Error: unknown button '".. button_key .. "'")
		end
	end,
	true
)

core:add_listener (
	"PharLocalDeities_AkhenatenButtonClicked",
	"ComponentLClickUp",
	function(context)
		return context.string == deities.component_ids.akhenaten_fm_button
	end,
	function(context)
		-- Open/close the Local deities UI after clicking on the Akhenaten button in the faction widget
		if not deities.panel then
			local local_deities_button = core:get_ui_root():SequentialFind(deities.component_ids.local_deities_container, deities.component_ids.local_deities_button)
			if local_deities_button and not local_deities_button:CurrentState():find("inactive") then
				local_deities_button:SimulateLClick()
				local faction_key = cm:get_local_faction_name(true)
				if not deities.has_faction_created_aten(faction_key) then
					deities.open_create_aten()
				else
					deities.open_selected_god(deities.config.aten_god_key)
				end
			end
		else
			local akhenaten_button = UIComponent(context.component)
			local state = akhenaten_button:CurrentState()
			if state == "selected_down" then
				deities.panel:InterfaceFunction("close_panel")
				local restore_button_state = function()
					akhenaten_button:SetState("active")
				end
				-- Need to restore the button to active state after a bit because the system for FM buttons is not meant to handle 2 buttons opening the same panel
				cm:callback(restore_button_state, 0.1)
				return
			end

			local faction_key = cm:get_local_faction_name(true)
			if not deities.has_faction_created_aten(faction_key) then
				deities.open_create_aten()
			else
				deities.open_selected_god(deities.config.aten_god_key)
			end
		end
	end,
	true
)

-- Worship a god
core:add_listener(
	"PharLocalDeities_WorshipGod",
	"UITriggerScriptEvent",
	function(context)
		return string.find(context:trigger(), "PharLocalDeities_WorshipGod")
	end,
	function(context)
		local faction_cqi = context:faction_cqi()
		local faction = cm:model():faction_for_command_queue_index(faction_cqi)
		local faction_key = faction:name()

		local _, event_last = string.find(context:trigger(), "PharLocalDeities_WorshipGod_")
		local slot_first, slot_last = string.find(context:trigger(), "slot_")
		local god_key = string.sub(context:trigger(), event_last + 1, slot_first - 2)
		local slot = tonumber(string.sub(context:trigger(), slot_last + 1))
		deities.worship_god(faction_key, slot, god_key)

		-- Update UI if triggered by local faction
		if faction_key == cm:get_local_faction_name(true) then
			deities.refresh_god_info()
			deities.refresh_favour_cheat_ui(faction_key, deities.ui_data.selected_god)
		end
	end,
	true
)

-- Unlock a god slot via cheat
-- Worship a god
core:add_listener(
	"PharLocalDeities_UnlockSlot",
	"UITriggerScriptEvent",
	function(context)
		return string.find(context:trigger(), "PharLocalDeities_UnlockSlot")
	end,
	function(context)
		local faction_cqi = context:faction_cqi()
		local faction = cm:model():faction_for_command_queue_index(faction_cqi)
		local faction_key = faction:name()

		deities.unlock_god_slot(faction_key)

		-- Update UI if triggered by local faction
		if faction_key == cm:get_local_faction_name(true) then
			deities.display_god_slots()
		end
	end,
	true
)

-- Create Aten
core:add_listener(
	"PharLocalDeities_CreateAten",
	"UITriggerScriptEvent",
	function(context)
		return string.find(context:trigger(), "PharLocalDeities_CreateAten")
	end,
	function(context)
		local faction_cqi = context:faction_cqi()
		local faction = cm:model():faction_for_command_queue_index(faction_cqi)
		local faction_key = faction:name()

		if deities.has_faction_created_aten(faction_key) then
			deities.output("WARNING! Repeated attempt to create Atten ancient legacy for faction " .. tostring(faction_key) .. "!", 10)
			return
		end

		local params = context:trigger():split("_")
		local god_1 = params[3]
		local god_2 = params[4]

		deities.create_aten_from_gods(faction_key, {god_1, god_2})

		local event_data =
		{
			faction_key = faction_key,
			aten_key = deities.config.aten_god_key,
		}
		core:trigger_event("ScriptEventOnAtenCreated", event_data)

		-- Update UI if triggered by local faction
		if faction_key == cm:get_local_faction_name(true) then
			deities.refresh_god_info()
		end
	end,
	true
)

-- Select Aten unlockable
core:add_listener(
	"PharLocalDeities_SelectUnlockable",
	"UITriggerScriptEvent",
	function(context)
		return string.find(context:trigger(), "PharLocalDeities_SelectUnlockable")
	end,
	function(context)
		local faction_cqi = context:faction_cqi()
		local faction = cm:model():faction_for_command_queue_index(faction_cqi)
		local faction_key = faction:name()

		local params = context:trigger():split(":")
		local bundle_key = params[2]
		local category = params[3]

		deities.select_aten_unlockable(faction_key, bundle_key, category)
	end,
	true
)

-- Assign a devoted general
core:add_listener(
	"PharLocalDeities_AssignDevotedGeneral",
	"UITriggerScriptEvent",
	function(context)
		return string.find(context:trigger(), "PharLocalDeities_AssignDevotedGeneral")
	end,
	function(context)
		local faction_cqi = context:faction_cqi()
		local faction = cm:model():faction_for_command_queue_index(faction_cqi)
		local faction_key = faction:name()

		local params = context:trigger():split(":")
		local god_key = params[2]
		local index = tonumber(params[3])
		local cqi = tonumber(params[4])
		deities.assign_devoted_general(faction_key, god_key, index, cqi)

		-- Update UI if triggered by local faction
		if faction_key == cm:get_local_faction_name(true) then
			deities.display_god_slots()
		end
	end,
	true
)

-- Change a religious building's god
-- handles PharLocalDeities_ChangeShrineGod, PharLocalDeities_ChangeTempleGod, PharLocalDeities_ChangeIdolGod PharLocalDeities_ChangeDwellingGod
core:add_listener(
	"PharLocalDeities_ChangeGod",
	"UITriggerScriptEvent",
	function(context)
		return string.find(context:trigger(), "PharLocalDeities_Change")
	end,
	function(context)
		local faction_cqi = context:faction_cqi()
		local faction = cm:model():faction_for_command_queue_index(faction_cqi)
		local faction_key = faction:name()

		local params = context:trigger():split(":")
		local location = params[2]
		local old_god_key = params[3]
		local new_god_key = params[4]

		if string.find(context:trigger(), "ChangeShrineGod") then
			deities.change_shrine_god(faction_key, location, old_god_key, new_god_key, deities.conversion_sources.local_deities_panel)
		elseif string.find(context:trigger(), "ChangeTempleGod") then
			deities.change_temple_god(faction_key, location, old_god_key, new_god_key, deities.conversion_sources.local_deities_panel)
		elseif string.find(context:trigger(), "ChangeDwellingGod") then
			deities.change_dwelling_god(faction_key, location, old_god_key, new_god_key, deities.conversion_sources.local_deities_panel)
		elseif string.find(context:trigger(), "ChangeIdolGod") then
			deities.change_idol_god(faction_key, tonumber(location), old_god_key, new_god_key, deities.conversion_sources.local_deities_panel)
		end

		-- Update UI if triggered by local faction
		if faction_key == cm:get_local_faction_name(true) then
			deities.display_religious_buildings()
		end
	end,
	true
)

-- Grant favour through cheat
core:add_listener(
	"PharLocalDeities_GrantFavour",
	"UITriggerScriptEvent",
	function(context)
		return string.find(context:trigger(), "PharLocalDeities_GrantFavour")
	end,
	function(context)
		local faction_cqi = context:faction_cqi()
		local faction = cm:model():faction_for_command_queue_index(faction_cqi)
		local faction_key = faction:name()

		local params = context:trigger():split(":")
		local god_key = params[2]
		local amount = tonumber(params[3])
		local source = params[4]
		deities.grant_favour(faction_key, god_key, amount, source)

		-- Update UI if triggered by local faction
		if faction_key == cm:get_local_faction_name(true) then
			deities.open_selected_god(deities.ui_data.selected_god)
		end
	end,
	true
)

-- Discover god through cheat
core:add_listener(
	"PharLocalDeities_DiscoverGod",
	"UITriggerScriptEvent",
	function(context)
		return string.find(context:trigger(), "PharLocalDeities_DiscoverGod")
	end,
	function(context)
		local faction_cqi = context:faction_cqi()
		local faction = cm:model():faction_for_command_queue_index(faction_cqi)
		local faction_key = faction:name()

		local params = context:trigger():split(":")
		local god_key = params[2]
		deities.discover_god(faction_key, god_key)

		-- Update UI if triggered by local faction
		if faction_key == cm:get_local_faction_name(true) then
			deities.display_all_gods()
		end
	end,
	true
)

core:add_listener(
	"PharLocalDeities_Hecatomb",
	"UITriggerScriptEvent",
	function(context)
		return string.find(context:trigger(), "PharLocalDeities_Hecatomb")
	end,
	function(context)
		local faction_cqi = context:faction_cqi()
		local faction = cm:model():faction_for_command_queue_index(faction_cqi)
		local faction_key = faction:name()

		local params = context:trigger():split(":")
		local god_key = params[2]
		deities.perform_hecatomb(faction_key, god_key)

		-- Update UI if triggered by local faction
		if faction_key == cm:get_local_faction_name(true) then
			deities.open_selected_god(deities.ui_data.selected_god)
		end
	end,
	true
)

-- panel closed
core:add_listener (
	"PharLocalDeities_PanelClosedCampaign",
	"PanelClosedCampaign",
	function(context) return context.string == deities.component_ids.panel end,
	function(context)
		deities.panel = nil
		deities.delete_ui_templates()
		core:remove_listener("PharLocalDeities_ButtonClicked")
		core:remove_listener("PharLocalDeities_ButtonClicked_UI")
	end,
	true
)

-- OnInitBuildingInfo (handles shrines and dwellings)
core:add_listener (
	"PharLocalDeities_PopulateShrineEffects",
	"OnInitBuildingInfo",
	true,
	function(context)
		local building_chain_key = context:building_chain_key()
		local faction_key = context:faction_key()

		-- visualize the additional religion effects for a building
		local custom_effect_bundle = deities.get_shrine_effects(faction_key, building_chain_key)
		if not custom_effect_bundle then
			custom_effect_bundle = deities.get_dwelling_effects(faction_key, building_chain_key)
		end

		if not custom_effect_bundle then
			local building_key = context:building_key()
			custom_effect_bundle = deities.get_idol_effects(faction_key, building_chain_key, building_key)
		end
		if not custom_effect_bundle then
			return
		end

		local building_information = UIComponent(context.component)
		building_information:InterfaceFunction("set_additional_building_effects", custom_effect_bundle)
	end,
	true
)

-- RequestAdditionalAgentActionEffects
core:add_listener (
	"PharLocalDeities_RequestAdditionalAgentActionEffects",
	"RequestAdditionalAgentActionEffects",
	true,
	function(context)
		local agent_action_key = context:agent_action_key()
		local character = context:character()

		local additional_effects_bundle = deities.get_bundle_for_prayer(agent_action_key, character)
		if not additional_effects_bundle then
			return
		end

		cm:set_info_additional_agent_action_effect_bundle(additional_effects_bundle)
	end,
	true
)

core:add_listener (
	"PharLocalDeities_RequestAdditionalERSEffects",
	"RequestAdditionalERSEffects",
	true,
	function(context)
		local garrison_residence = context:garrison_residence()
		if garrison_residence:is_slot() then
			local slot = garrison_residence:slot_interface()
			local faction_key = garrison_residence:faction():name()
			local building_chain = slot:building():chain()
			-- Check for shrine
			local shrine_god = table_find(deities.gods, function(e) return building_chain == e.shrine_chain end)
			if shrine_god then
				local god_key = shrine_god.key
				local god_slot = deities.get_god_slot(faction_key, god_key)
				if not god_slot then
					return nil
				end

				local current_tier = deities.get_tier(faction_key, god_key)
				local tiers = deities.get_god_tiers(faction_key, god_key)
				if not is_table(tiers) then
					return
				end

				local shrine_effect_bundles = tiers[current_tier].shrine_effect_bundles
				local combined_custom_effect_bundle = deities.get_combined_custom_effect_bundle(shrine_effect_bundles, nil)
				cm:set_info_additional_ers_effect_bundle(combined_custom_effect_bundle)
			end
		end
	end,
	true
)

core:add_listener(
	"PharLocalDeities_notify_god_total_favour_changed",
	"LocalDeitiesGodTotalFavourChanged",
	function(context)
		return context.stored_table.faction_key == cm:get_local_faction_name(true)
	end,
	function(context)
		cm:notify_god_total_favour_changed(context.stored_table.faction_key, context.stored_table.god_key, context.stored_table.total_favour)
	end,
	true
)

core:add_listener(
	"PharLocalDeities_TierEntry_OnMouseOn",
	"ComponentMouseOn",
	function(context)
		local parent_of_hovered_component = UIComponent(context.component):Parent()
		return (parent_of_hovered_component and UIComponent(parent_of_hovered_component):Id() == "tier_holder" and string.find(UIComponent(context.component):Id(), "lock_"))
			or string.find(UIComponent(context.component):Id(), deities.component_ids.tier_indicator)
	end,
	function(context)
		local faction_key = cm:get_local_faction_name(true)
		local god_key = deities.ui_data.selected_god
		if god_key == "" or god_key == nil then
			return
		end

		-- get the index of the tier component we are hovering right now
		local tier_index = UIComponent(context.component):GetProperty(deities.component_ids.tier_property)
		if tier_index == nil or tier_index == "" then
			return
		end

		deities.init_tier_tooltip(UIComponent(context.component), god_key, tonumber(tier_index))
	end,
	true
)

core:add_listener(
	"PharLocalDeities_GodPortrait_OnMouseOn",
	"ComponentMouseOn",
	function(context)
		local id = UIComponent(context.component):Id()
		return id == deities.component_ids.god_portrait or string.find(id, deities.component_ids.aten_creation_god_prefix)
	end,
	function(context)
		local god_key =  UIComponent(context.component):GetProperty(deities.component_ids.god_key_property)
		if god_key == "" or god_key == nil then
			return
		end

		deities.set_god_tooltip(god_key, UIComponent(context.component))
	end,
	true
)

core:add_listener(
	"PharLocalDeities_LegitimacyPathPatronData_PanelOpenedCampaign",
	"PanelOpenedCampaign",
	function(context)
		return context.string == crown.config.ui.crown_panel
	end,
	function(context)
		deities.setup_favoured_god_ui_script_object()
	end,
	true
)

core:add_listener(
	"PharLocalDeities_LegitimacyPathUnlocked",
	"LegitimacyPathUnlocked",
	function(context)
		return context.stored_table.faction_key == cm:get_local_faction_name(true)
	end,
	function(context)
		deities.setup_favoured_god_ui_script_object()
	end,
	true
)

--------------------------------------------------------------
----------------------- TESTS  -------------------------------
--------------------------------------------------------------
-- For easy testing with the local faction
deities_tests =
{
	worship_god = function()
		local faction_key = cm:get_local_faction_name(true)
		deities.discover_god(faction_key, "amun")
		deities.worship_god(faction_key, 1, "amun")
	end,

	discover_gods = function()
		local faction_key = cm:get_local_faction_name(true)
		deities.discover_god(faction_key, "amun")
		deities.discover_god(faction_key, "ra")
		deities.discover_god(faction_key, "ptah")
	end,

	worship_gods = function()
		local faction_key = cm:get_local_faction_name(true)
		deities.discover_god(faction_key, "amun")
		deities.worship_god(faction_key, 1, "amun")
		deities.unlock_god_slot(faction_key)
		deities.discover_god(faction_key, "ra")
		deities.worship_god(faction_key, 2, "ra")
	end,

	rededicate_god = function()
		local faction_key = cm:get_local_faction_name(true)
		deities.worship_god(faction_key, 1, "ptah")
	end,

	grant_favour = function()
		local faction_key = cm:get_local_faction_name(true)
		deities.grant_favour(faction_key, "amun", 75, "court")
	end,

	test_shrines = function()
		local faction_key = cm:get_local_faction_name(true)
		deities.add_shrine(faction_key, "amun", "region1")
		deities.add_shrine(faction_key, "amun", "region2")
		deities.remove_shrine(faction_key, "amun", "region2")
		deities.change_shrine_god(faction_key, "region1", "amun", "ra", deities.conversion_sources.cheat)
	end,

	test_idols = function()
		local faction_key = cm:get_local_faction_name(true)
		local local_faction_leader_cqi = cm:get_local_faction():faction_leader():cqi()
		local second_faction_leader_cqi
		if faction_key == "phar_sea_sherden" then
			second_faction_leader_cqi = cm:get_faction("phar_sea_peleset"):faction_leader():cqi()
		elseif faction_key == "phar_sea_peleset" then
			second_faction_leader_cqi = cm:get_faction("phar_sea_sherden"):faction_leader():cqi()
		else
			return
		end
		deities.add_or_upgrade_idol(faction_key, "isul", local_faction_leader_cqi, 1)
		deities.add_or_upgrade_idol(faction_key, "isul", second_faction_leader_cqi, 1)
		deities.add_or_upgrade_idol(faction_key, "isul", local_faction_leader_cqi, 2)
		deities.remove_idol(faction_key, "isul", second_faction_leader_cqi)
		deities.change_idol_god(faction_key, local_faction_leader_cqi, "isul", "kuvava", deities.conversion_sources.cheat)
	end,

	test_temples = function()
		local faction_key = cm:get_local_faction_name(true)
		deities.add_or_upgrade_temple(faction_key, "amun", "region1", 1)
		deities.add_or_upgrade_temple(faction_key, "amun", "region2", 1)
		deities.add_or_upgrade_temple(faction_key, "amun", "region1", 2)
		deities.remove_temple(faction_key, "amun", "region2")
		deities.change_temple_god(faction_key, "region1", "amun", "ra", deities.conversion_sources.cheat)
	end,

	make_prayer = function()
		local faction_key = cm:get_local_faction_name(true)
		deities.make_prayer(faction_key, "asherah", cm:get_faction(cm:get_local_faction_name(true)):faction_leader():military_force():command_queue_index())
	end,

	assign_devoted_general = function()
		local faction_key = cm:get_local_faction_name(true)
		deities.assign_devoted_general(faction_key, "amun", 1, cm:get_faction(cm:get_local_faction_name(true)):faction_leader():family_member():command_queue_index())
		--deities.assign_devoted_general(faction_key, "amun", 1, cm:get_faction(cm:get_local_faction_name(true)):character_list():item_at(3):family_member():command_queue_index())
	end,

	remove_devoted_general = function()
		local faction_key = cm:get_local_faction_name(true)
		deities.remove_devoted_general(faction_key, "amun", true)
	end,

	test_all = function()
		deities_tests.discover_gods()
		deities_tests.worship_gods()
		deities_tests.grant_favour()
		deities_tests.assign_devoted_general()
		deities_tests.make_prayer()
		deities_tests.test_shrines()
		deities_tests.test_idols()
		deities_tests.test_temples()
		deities_tests.remove_devoted_general()
		deities_tests.rededicate_god()
	end,

	print_gods_favour_for_faction = function(faction_key)
		local god_slots = deities.get_god_slots(faction_key)
		if not god_slots then
			return
		end

		local unlocked_slots_count = deities.get_faction_god_slots_count(faction_key)
		for i = 1, unlocked_slots_count do
			local god_slot = god_slots[i]
			if god_slot.god_key then
				out(god_slot.god_key .. " : " .. tostring(god_slot.favour.total_favour))
			end
		end
	end,
}
