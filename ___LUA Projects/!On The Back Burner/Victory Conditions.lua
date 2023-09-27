victory_objectives_ie = {
	victory_type = {
		multiplayer = "wh3_combi_victory_type_multiplayer",
		faction = "wh3_combi_victory_type_faction",
		subculture = "wh3_combi_victory_type_subculture",
		domination = "wh3_combi_victory_type_domination"
	},
	multiplayer = {
		objectives = {
			{
				type = "ALL_PLAYERS_RAZE_OR_OWN_X_SETTLEMENTS",
				conditions = {
					"total 35"
				}
			}
		}
	},
	alignments = {
		default = "destruction",
		order = {
			wh_main_short_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 15"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_order_short"
			},
			wh_main_long_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 35"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_order_long"
			}
		},
		destruction = {
			wh_main_short_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 15"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_destruction_short"
			},
			wh_main_long_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 35"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_destruction_long"
			}
		},
		death = {
			wh_main_short_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 15"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_death_short"
			},
			wh_main_long_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 35"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_death_long"
			}
		},
		chaos = {
			wh_main_short_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 20"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_chaos_short"
			},
			wh_main_long_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 35"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_chaos_long"
			}
		},
		dark_elves = {
			wh_main_short_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 15"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_destruction_short"
			},
			wh_main_long_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 35"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_def_long"
			}
		},
		khorne = {
			wh_main_short_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 35"
						}
					}
				},
				payload_ancillary = "wh3_main_anc_weapon_chainsword"
			},
			wh_main_long_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 80"
						}
					}
				},
				payload_bundle = "wh3_main_ie_victory_objective_chaos_long"
			}
		},
		chaos_dwarfs = {
			wh_main_short_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 35"
						}
					}
				},
				payload_bundle = "wh3_dlc23_ie_victory_objective_chaos_dwarfs_short"
			},
			wh_main_long_victory = {
				objectives = {
					{
						type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
						conditions = {
							"total 80"
						}
					}
				},
				payload_ancillary = {
					"wh3_dlc23_anc_armour_lesser_relic_of_skavor",
					"wh3_dlc23_anc_enchanted_item_lesser_relic_of_morgrim",
					"wh3_dlc23_anc_weapon_lesser_relic_of_smednir"
				}
			}
		}
	},
	subcultures = {
		wh_main_sc_emp_empire = {
			alignment = "order",
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 13",
						"override_text mission_text_text_wh_main_objective_override_empire_control",
						"province wh3_main_combi_province_nordland",
						"province wh3_main_combi_province_ostland",
						"province wh3_main_combi_province_hochland",
						"province wh3_main_combi_province_middenland",
						"province wh3_main_combi_province_talabecland",
						"province wh3_main_combi_province_ostermark",
						"province wh3_main_combi_province_reikland",
						"province wh3_main_combi_province_stirland",
						"province wh3_main_combi_province_averland",
						"province wh3_main_combi_province_wissenland",
						"province wh3_main_combi_province_the_wasteland",
						"province wh3_main_combi_province_northern_sylvania",
						"province wh3_main_combi_province_southern_sylvania"
					}
				}
			}
		},
		wh_dlc05_sc_wef_wood_elves = {
			alignment = "order",
			objectives = {
				{
					type = "FIGHT_SET_PIECE_BATTLE",
					conditions = {
						"set_piece_battle wh_dlc05_qb_wef_grand_defense_of_the_oak"
					}
				},
				{
					type = "PERFORM_RITUAL",
					conditions = {
						"ritual wh2_dlc16_ritual_rebirth_athel_loren"
					}
				},
				{
					type = "PERFORM_RITUAL",
					conditions = {
						"ritual_category WORLDROOTS_HEALING",
						"total 8"
					}
				}
			}
		},
		wh2_main_sc_hef_high_elves = {
			alignment = "order",
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 15",
						"province wh3_main_combi_province_eataine",
						"province wh3_main_combi_province_caledor",
						"province wh3_main_combi_province_tiranoc",
						"province wh3_main_combi_province_ellyrion",
						"province wh3_main_combi_province_nagarythe",
						"province wh3_main_combi_province_avelorn",
						"province wh3_main_combi_province_chrace",
						"province wh3_main_combi_province_cothique",
						"province wh3_main_combi_province_saphery",
						"province wh3_main_combi_province_northern_yvresse",
						"province wh3_main_combi_province_southern_yvresse",
						"province wh3_main_combi_province_eagle_gate",
						"province wh3_main_combi_province_griffon_gate",
						"province wh3_main_combi_province_unicorn_gate",
						"province wh3_main_combi_province_phoenix_gate"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_def_cult_of_pleasure",
						"faction wh2_main_def_hag_graef",
						"faction wh2_main_def_naggarond",
						"faction wh2_dlc11_def_the_blessed_dread",
						"faction wh2_twa03_def_rakarth",
						"confederation_valid"
					}
				}
			}
		},
		wh_main_sc_brt_bretonnia = {
			alignment = "order",
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"script_key max_chivalry",
						"override_text mission_text_text_mis_activity_attain_chivalry_1000"
					}
				},
				{
					type = "SCRIPTED",
					conditions = {
						"script_key win_errantry_war",
						"override_text mission_text_text_mis_activity_win_errantry_war"
					}
				}
			}
		},
		wh_main_sc_dwf_dwarfs = {
			alignment = "order",
			objectives = {
				{
					type = "AQUIRE_MISSION_CATEGORY_WEIGHT",
					conditions = {
						"event_category Grudges",
						"value 9.0",
						"value_minimum false",
						"override_text mission_text_text_wh_main_objective_override_dwarfs_grudges_threshold"
					}
				}
			}
		},
		wh2_main_sc_lzd_lizardmen = {
			alignment = "order",
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 19",
						"override_text mission_text_text_wh_main_objective_override_mazdamundi_control",
						"province wh3_main_combi_province_culchan_plains",
						"province wh3_main_combi_province_headhunters_jungle",
						"province wh3_main_combi_province_spine_of_sotek",
						"province wh3_main_combi_province_the_lost_valley",
						"province wh3_main_combi_province_river_qurveza",
						"province wh3_main_combi_province_mosquito_swamps",
						"province wh3_main_combi_province_the_gwangee_valley",
						"province wh3_main_combi_province_the_turtle_isles",
						"province wh3_main_combi_province_scorpion_coast",
						"province wh3_main_combi_province_the_creeping_jungle",
						"province wh3_main_combi_province_jungles_of_green_mist",
						"province wh3_main_combi_province_aymara_swamps",
						"province wh3_main_combi_province_jungles_of_pahualaxa",
						"province wh3_main_combi_province_the_isthmus_coast",
						"province wh3_main_combi_province_isthmus_of_lustria",
						"province wh3_main_combi_province_copper_desert",
						"province wh3_main_combi_province_the_night_forest_road",
						"province wh3_main_combi_province_the_capes",
						"province wh3_main_combi_province_volcanic_islands"
					}
				}
			}
		},
		wh3_main_sc_ksl_kislev = {
			alignment = "order",
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_chs_chaos",
						"faction wh3_main_dae_daemon_prince",
						"faction wh3_dlc20_chs_azazel",
						"faction wh3_dlc20_chs_festus",
						"confederation_valid"
					}
				}
			}
		},
		wh3_main_sc_cth_cathay = {
			alignment = "order",
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_cth_rebel_lords_of_nan_yang",
						"faction wh3_main_cth_dissenter_lords_of_jinshen",
						"faction wh3_dlc20_chs_vilitch",
						"faction wh3_dlc20_chs_kholek",
						"faction wh2_dlc11_def_the_blessed_dread",
						"faction wh2_main_skv_clan_eshin",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 3",
						"province wh3_main_combi_province_western_great_bastion",
						"province wh3_main_combi_province_central_great_bastion",
						"province wh3_main_combi_province_eastern_great_bastion"
					}
				}
			}
		},
		wh_main_sc_vmp_vampire_counts = {
			alignment = "death",
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 13",
						"override_text mission_text_text_wh_main_objective_override_empire_control",
						"province wh3_main_combi_province_nordland",
						"province wh3_main_combi_province_ostland",
						"province wh3_main_combi_province_hochland",
						"province wh3_main_combi_province_middenland",
						"province wh3_main_combi_province_talabecland",
						"province wh3_main_combi_province_ostermark",
						"province wh3_main_combi_province_reikland",
						"province wh3_main_combi_province_stirland",
						"province wh3_main_combi_province_averland",
						"province wh3_main_combi_province_wissenland",
						"province wh3_main_combi_province_the_wasteland",
						"province wh3_main_combi_province_northern_sylvania",
						"province wh3_main_combi_province_southern_sylvania"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_emp_empire",
						"confederation_valid"
					}
				}
			}
		},
		wh_main_sc_grn_greenskins = {
			alignment = "destruction",
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_grn_black_venom",
						"faction wh_main_grn_bloody_spearz",
						"faction wh_main_grn_broken_nose",
						"faction wh_main_grn_necksnappers",
						"faction wh_main_grn_red_eye",
						"faction wh_main_grn_red_fangs",
						"faction wh_main_grn_scabby_eye",
						"faction wh_main_grn_skullsmasherz",
						"faction wh_main_grn_teef_snatchaz",
						"faction wh_main_grn_top_knotz",
						"confederation_valid"
					}
				}
			}
		},
		wh2_main_sc_skv_skaven = {
			alignment = "destruction",
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 7",
						"region wh3_main_combi_region_karag_orrud",
						"region wh3_main_combi_region_karak_eight_peaks",
						"region wh3_main_combi_region_skavenblight",
						"region wh3_main_combi_region_nagashizzar",
						"region wh3_main_combi_region_crookback_mountain",
						"region wh3_main_combi_region_hell_pit",
						"region wh3_main_combi_region_altdorf",
						"region wh3_main_combi_region_mount_gunbad",
						"region wh3_main_combi_region_iron_rock",
						"region wh3_main_combi_region_altar_of_the_horned_rat",
						"region wh3_main_combi_region_oyxl",
						"region wh3_main_combi_region_galbaraz",
						"region wh3_main_combi_region_karak_izor",
						"override_text mission_text_text_mis_activity_control_n_regions_satrapy_including_at_least_n"
					}
				}
			}
		},
		wh2_dlc09_sc_tmb_tomb_kings = {
			alignment = "death",
			objectives = {
				{
					type = "OWN_N_REGIONS_INCLUDING",
					conditions = {
						"total 11",
						"region wh3_main_combi_region_black_pyramid_of_nagash",
						"region wh3_main_combi_region_black_tower_of_arkhan",
						"region wh3_main_combi_region_khemri",
						"region wh3_main_combi_region_wizard_caliphs_palace",
						"region wh3_main_combi_region_al_haikk",
						"region wh3_main_combi_region_numas",
						"region wh3_main_combi_region_ka_sabar",
						"region wh3_main_combi_region_galbaraz",
						"region wh3_main_combi_region_karag_orrud",
						"region wh3_main_combi_region_lahmia",
						"region wh3_main_combi_region_rasetra"
					}
				},
				{
					type = "CONSTRUCT_N_BUILDINGS_FROM",
					conditions = {
						"total 7",
						"building_level wh2_dlc09_special_pyramid_alcadizaar",
						"building_level wh2_dlc09_special_pyramid_amenemhetum",
						"building_level wh2_dlc09_special_pyramid_khatep",
						"building_level wh2_dlc09_special_pyramid_phar",
						"building_level wh2_dlc09_special_pyramid_settra",
						"building_level wh2_dlc09_special_pyramid_tutankhanut",
						"building_level wh2_main_special_pyramid_of_nagash_other"
					}
				}
			}
		},
		wh2_dlc11_sc_cst_vampire_coast = {
			alignment = "death",
			objectives = {
				{
					type = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
					conditions = {
						"pooled_resource cst_infamy",
						"total 25000"
					}
				}
			}
		},
		wh2_main_sc_def_dark_elves = {
			alignment = "dark_elves",
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_shrine_of_khaine"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_hef_avelorn",
						"faction wh2_main_hef_eataine",
						"faction wh2_main_hef_nagarythe",
						"faction wh2_main_hef_order_of_loremasters",
						"faction wh2_main_hef_yvresse",
						"faction wh2_dlc15_hef_imrik",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 1",
						"province wh3_main_combi_province_eataine"
					}
				}
			}
		},
		wh_dlc08_sc_nor_norsca = {
			alignment = "chaos",
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"script_key attain_chaos_god_favour",
						"override_text mission_text_text_mis_activity_attain_chaos_god_favour"
					}
				},
				{
					type = "SCRIPTED",
					conditions = {
						"script_key defeat_chaos_gods_challengers",
						"override_text mission_text_text_mis_activity_defeat_chaos_gods_challengers"
					}
				}
			}
		},
		wh_dlc03_sc_bst_beastmen = {
			alignment = "chaos",
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_emp_empire",
						"faction wh_main_brt_bretonnia",
						"faction wh_main_emp_averland",
						"faction wh_main_emp_hochland",
						"faction wh_main_emp_middenland",
						"faction wh_main_emp_nordland",
						"faction wh_main_emp_ostland",
						"faction wh_main_emp_ostermark",
						"faction wh_main_emp_stirland",
						"faction wh_main_emp_talabecland",
						"faction wh_main_emp_wissenland",
						"confederation_valid"
					}
				},
				{
					type = "RAZE_OR_OWN_SETTLEMENTS",
					conditions = {
						"region wh3_main_combi_region_the_oak_of_ages"
					}
				}
			}
		},
		wh3_main_sc_ogr_ogre_kingdoms = {
			alignment = "destruction",
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 8",
						"region wh3_main_combi_region_nan_gau",
						"region wh3_main_combi_region_wei_jin",
						"region wh3_main_combi_region_hanyu_port",
						"region wh3_main_combi_region_black_crag",
						"region wh3_main_combi_region_crookback_mountain",
						"region wh3_main_combi_region_galbaraz",
						"region wh3_main_combi_region_grom_peak",
						"region wh3_main_combi_region_karak_ungor",
						"region wh3_main_combi_region_massif_orcal",
						"region wh3_main_combi_region_ekrund",
						"region wh3_main_combi_region_sabre_mountain",
						"override_text mission_text_text_mis_activity_control_n_regions_satrapy_including_at_least_n"
					}
				}
			}
		},
		wh3_main_sc_nur_nurgle = {
			alignment = "chaos",
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_tze_oracles_of_tzeentch",
						"faction wh3_main_tze_flaming_scribes",
						"confederation_valid"
					}
				}
			}
		},
		wh3_main_sc_sla_slaanesh = {
			alignment = "chaos",
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 15",
						"province wh3_main_combi_province_eataine",
						"province wh3_main_combi_province_caledor",
						"province wh3_main_combi_province_tiranoc",
						"province wh3_main_combi_province_ellyrion",
						"province wh3_main_combi_province_nagarythe",
						"province wh3_main_combi_province_avelorn",
						"province wh3_main_combi_province_chrace",
						"province wh3_main_combi_province_cothique",
						"province wh3_main_combi_province_saphery",
						"province wh3_main_combi_province_northern_yvresse",
						"province wh3_main_combi_province_southern_yvresse",
						"province wh3_main_combi_province_eagle_gate",
						"province wh3_main_combi_province_griffon_gate",
						"province wh3_main_combi_province_unicorn_gate",
						"province wh3_main_combi_province_phoenix_gate"
					}
				}
			}
		},
		wh3_main_sc_kho_khorne = {
			alignment = "khorne",
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_sla_seducers_of_slaanesh",
						"confederation_valid"
					}
				}
			}
		},
		wh3_main_sc_tze_tzeentch = {
			alignment = "chaos",
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_nur_poxmakers_of_nurgle",
						"faction wh3_main_nur_bubonic_swarm",
						"confederation_valid"
					}
				}
			}
		},
		wh3_main_sc_dae_daemons = {
			alignment = "chaos",
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_chs_chaos",
						"faction wh3_dlc20_chs_kholek",
						"faction wh3_dlc20_chs_sigvald",
						"faction wh3_dlc20_chs_azazel",
						"faction wh3_dlc20_chs_valkia",
						"confederation_valid"
					}
				}
			}
		},
		wh_main_sc_chs_chaos = {
			alignment = "chaos",
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 13",
						"region wh3_main_combi_region_ancient_city_of_quintex",
						"region wh3_main_combi_region_altar_of_the_crimson_harvest",
						"region wh3_main_combi_region_black_rock",
						"region wh3_main_combi_region_black_fortress",
						"region wh3_main_combi_region_brass_keep",
						"region wh3_main_combi_region_bloodwind_keep",
						"region wh3_main_combi_region_daemons_gate",
						"region wh3_main_combi_region_dagraks_end",
						"region wh3_main_combi_region_doomkeep",
						"region wh3_main_combi_region_fortress_of_the_damned",
						"region wh3_main_combi_region_karak_dum",
						"region wh3_main_combi_region_karak_vlag",
						"region wh3_main_combi_region_konquata",
						"region wh3_main_combi_region_middenheim",
						"region wh3_main_combi_region_monolith_of_borkill_the_bloody_handed",
						"region wh3_main_combi_region_nuln",
						"region wh3_main_combi_region_okkams_forever_maze",
						"region wh3_main_combi_region_praag",
						"region wh3_main_combi_region_red_fortress",
						"region wh3_main_combi_region_tower_of_gorgoth",
						"region wh3_main_combi_region_zanbaijin",
						"region wh3_main_combi_region_the_challenge_stone",
						"region wh3_main_combi_region_the_crystal_spires",
						"region wh3_main_combi_region_the_godless_crater",
						"region wh3_main_combi_region_the_forbidden_citadel",
						"region wh3_main_combi_region_the_frozen_city",
						"region wh3_main_combi_region_the_howling_citadel",
						"region wh3_main_combi_region_the_lost_palace",
						"region wh3_main_combi_region_the_monolith_of_katam",
						"region wh3_main_combi_region_the_palace_of_ruin",
						"region wh3_main_combi_region_the_silvered_tower_of_sorcerers",
						"region wh3_main_combi_region_the_tower_of_khrakk",
						"region wh3_main_combi_region_the_twisted_towers",
						"region wh3_main_combi_region_the_writhing_fortress",
						"override_text mission_text_text_mis_activity_control_n_regions_satrapy_including_at_least_n"
					}
				}
			}
		},
		wh3_dlc23_sc_chd_chaos_dwarfs = {
			alignment = "chaos_dwarfs",
			objectives = {
				{
					type = "OWN_N_REGIONS_INCLUDING",
					conditions = {
						"region wh3_main_combi_region_zharr_naggrund",
						"total 1"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_dwf_dwarfs",
						"faction wh_main_dwf_karak_kadrin",
						"faction wh_main_grn_greenskins",
						"confederation_valid"
					}
				}
			}
		}
	},
	factions = {
		wh_main_emp_empire = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_emp_empire_separatists",
						"faction wh2_dlc11_vmp_the_barrow_legion",
						"faction wh_main_vmp_schwartzhafen",
						"confederation_valid"
					}
				}
			}
		},
		wh3_main_emp_cult_of_sigmar = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_tze_oracles_of_tzeentch",
						"faction wh_main_vmp_vampire_counts",
						"confederation_valid"
					}
				}
			}
		},
		wh2_dlc13_emp_the_huntmarshals_expedition = {
			objectives = {
				{
					type = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
					conditions = {
						"pooled_resource emp_progress",
						"total 100"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_lzd_hexoatl",
						"faction wh2_main_lzd_itza",
						"faction wh2_main_skv_clan_pestilens",
						"faction wh2_dlc11_cst_vampire_coast",
						"faction wh2_dlc11_cst_noctilus",
						"confederation_valid"
					}
				}
			},
			long_objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 19",
						"override_text mission_text_text_wh_main_objective_override_mazdamundi_control",
						"province wh3_main_combi_province_culchan_plains",
						"province wh3_main_combi_province_headhunters_jungle",
						"province wh3_main_combi_province_spine_of_sotek",
						"province wh3_main_combi_province_the_lost_valley",
						"province wh3_main_combi_province_river_qurveza",
						"province wh3_main_combi_province_mosquito_swamps",
						"province wh3_main_combi_province_the_gwangee_valley",
						"province wh3_main_combi_province_the_turtle_isles",
						"province wh3_main_combi_province_scorpion_coast",
						"province wh3_main_combi_province_the_creeping_jungle",
						"province wh3_main_combi_province_jungles_of_green_mist",
						"province wh3_main_combi_province_aymara_swamps",
						"province wh3_main_combi_province_jungles_of_pahualaxa",
						"province wh3_main_combi_province_the_isthmus_coast",
						"province wh3_main_combi_province_isthmus_of_lustria",
						"province wh3_main_combi_province_copper_desert",
						"province wh3_main_combi_province_the_night_forest_road",
						"province wh3_main_combi_province_the_capes",
						"province wh3_main_combi_province_volcanic_islands"
					}
				}
			},
			no_subculture_objective = true
		},
		wh2_dlc13_emp_golden_order = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_vmp_schwartzhafen",
						"confederation_valid"
					}
				}
			}
		},
		wh_dlc05_wef_wood_elves = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_athel_healed",
						"script_key athel_healed"
					}
				}
			}
		},
		wh_dlc05_wef_argwylon = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc11_vmp_the_barrow_legion",
						"confederation_valid"
					}
				}
			}
		},
		wh2_dlc16_wef_sisters_of_twilight = {
			objectives = {
				{
					type = "PERFORM_RITUAL",
					conditions = {
						"ritual_category WORLDROOTS_HEALING",
						"total 2"
					}
				}
			}
		},
		wh2_dlc16_wef_drycha = {
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 5",
						"province wh3_main_combi_province_argwylon",
						"province wh3_main_combi_province_wydrioth",
						"province wh3_main_combi_province_yn_edri_eternos",
						"province wh3_main_combi_province_talsyn",
						"province wh3_main_combi_province_torgovann"
					}
				}
			}
		},
		wh2_main_hef_eataine = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_def_cult_of_pleasure",
						"faction wh2_main_def_naggarond",
						"confederation_valid"
					}
				}
			}
		},
		wh2_main_hef_order_of_loremasters = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_tze_sarthoraels_watchers",
						"faction wh3_main_skv_clan_morbidus",
						"faction wh3_main_tze_oracles_of_tzeentch",
						"faction wh3_main_nur_bubonic_swarm",
						"confederation_valid"
					}
				}
			},
			long_objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 6",
						"region wh3_main_combi_region_fortress_of_dawn",
						"region wh3_main_combi_region_tower_of_the_sun",
						"region wh3_main_combi_region_tower_of_the_stars",
						"region wh3_main_combi_region_tor_elasor",
						"region wh3_main_combi_region_gronti_mingol",
						"region wh3_main_combi_region_citadel_of_dusk",
						"region wh3_main_combi_region_the_star_tower",
						"region wh3_main_combi_region_great_turtle_isle",
						"region wh3_main_combi_region_arnheim",
						"override_text mission_text_text_mis_activity_control_n_regions_satrapy_including_at_least_n"
					}
				}
			},
			no_subculture_objective = true
		},
		wh2_main_hef_avelorn = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_def_scourge_of_khaine",
						"faction wh2_main_def_cult_of_excess",
						"faction wh3_main_sla_seducers_of_slaanesh",
						"confederation_valid"
					}
				}
			}
		},
		wh2_main_hef_nagarythe = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_def_naggarond",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 1",
						"province wh3_main_combi_province_nagarythe"
					}
				}
			}
		},
		wh2_main_hef_yvresse = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_upgrade_athel_tamarha_victory",
						"script_key athel_tamarha_upgrades_attained"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc15_grn_broken_axe",
						"faction wh2_main_def_scourge_of_khaine",
						"faction wh3_main_sla_seducers_of_slaanesh",
						"faction wh2_dlc11_cst_noctilus",
						"confederation_valid"
					}
				}
			},
			long_objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_upgrade_max_athel_tamarha_victory",
						"script_key athel_tamarha_max_upgrades_attained"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_def_naggarond",
						"faction wh2_main_def_cult_of_pleasure",
						"faction wh3_main_chs_shadow_legion",
						"faction wh2_main_def_har_ganeth",
						"faction wh2_dlc11_cst_vampire_coast",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_tor_yvresse",
						"override_text mission_text_text_mis_upgrade_tor_yvresse_safe"
					}
				}
			},
			no_subculture_objective = true
		},
		wh2_dlc15_hef_imrik = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc09_skv_clan_rictus",
						"faction wh3_main_nur_poxmakers_of_nurgle",
						"confederation_valid"
					}
				},
				{
					type = "SCRIPTED",
					conditions = {
						"script_key dragon_encounters",
						"override_text mission_text_text_mis_activity_encounter_special_dragons"
					}
				}
			},
			long_objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_skv_clan_mors",
						"faction wh_main_grn_orcs_of_the_bloody_hand",
						"faction wh3_main_kho_exiles_of_khorne",
						"confederation_valid"
					}
				},
				{
					type = "SCRIPTED",
					conditions = {
						"script_key dragon_encounters_all",
						"override_text  mission_text_text_mis_activity_encounter_special_dragons_all"
					}
				}
			},
			no_subculture_objective = true
		},
		wh_main_dwf_karak_izor = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_grn_necksnappers",
						"faction wh_main_grn_crooked_moon",
						"faction wh2_main_skv_clan_mors",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_karak_eight_peaks"
					}
				}
			}
		},
		wh_main_dwf_dwarfs = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"script_key thorgrim_one_grudge_short_victory",
						"override_text mission_text_text_mis_activity_complete_one_grudge"
					}
				}
			}
		},
		wh2_dlc17_dwf_thorek_ironbrow = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"script_key artefacts_crafted_victory_objective_me_0",
						"override_text mission_text_text_mis_activity_craft_artefacts_some"
					}
				}
			}
		},
		wh_main_dwf_karak_kadrin = {
			objectives = {
				{
					type = "CONSTRUCT_N_BUILDINGS_INCLUDING",
					conditions = {
						"total 1",
						"building_level wh_main_special_great_slayer_shrine"
					}
				},
				{
					type = "ACHIEVE_CHARACTER_RANK",
					conditions = {
						"total 1",
						"total2 25",
						"start_pos_character 724031729",
						"include_generals"
					}
				}
			}
		},
		wh3_main_dwf_the_ancestral_throng = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_def_naggarond",
						"confederation_valid"
					}
				}
			}
		},
		wh_main_brt_bretonnia = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_vmp_mousillon",
						"confederation_valid"
					}
				}
			}
		},
		wh_main_brt_bordeleaux = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_complete_grail_vow_alberic",
						"script_key alberic_grail_vow_success"
					}
				}
			}
		},
		wh_main_brt_carcassonne = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_complete_troth_of_virute_vow_enchantress",
						"script_key enchantress_virtue_success"
					}
				}
			}
		},
		wh2_dlc14_brt_chevaliers_de_lyonesse = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_vmp_vampire_counts",
						"faction wh2_dlc09_tmb_followers_of_nagash",
						"confederation_valid"
					}
				}
			}
		},
		wh2_main_lzd_hexoatl = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_dlc20_sla_keepers_of_bliss",
						"faction wh2_main_nor_skeggi",
						"confederation_valid"
					}
				}
			}
		},
		wh2_main_lzd_last_defenders = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_skv_clan_morbidus",
						"faction wh2_main_skv_clan_mordkin",
						"faction wh2_main_vmp_the_silver_host",
						"faction wh_main_vmp_vampire_counts",
						"faction wh2_dlc12_grn_leaf_cutterz_tribe",
						"confederation_valid"
					}
				}
			},
			long_objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_vmp_vampire_counts",
						"faction wh3_main_kho_exiles_of_khorne",
						"faction wh2_main_skv_clan_mors",
						"faction wh_main_grn_orcs_of_the_bloody_hand",
						"faction wh2_dlc17_bst_malagor",
						"faction wh3_main_nur_poxmakers_of_nurgle",
						"faction wh3_main_tze_oracles_of_tzeentch",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 5",
						"province wh3_main_combi_province_the_golden_pass",
						"province wh3_main_combi_province_central_jungles",
						"province wh3_main_combi_province_western_jungles",
						"province wh3_main_combi_province_southern_jungles",
						"province wh3_main_combi_province_the_jungles_of_the_gods",
						"province wh3_main_combi_province_kingdom_of_beasts",
						"province wh3_main_combi_province_the_dragon_isles",
						"override_text mission_text_text_mis_activity_control_n_southern_jungle_provinces"
					}
				}
			},
			no_subculture_objective = true
		},
		wh2_main_lzd_tlaqua = {
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 2",
						"province wh3_main_combi_province_western_jungles",
						"province wh3_main_combi_province_central_jungles"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_tze_oracles_of_tzeentch",
						"confederation_valid"
					}
				}
			}
		},
		wh2_main_lzd_itza = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_skv_clan_pestilens",
						"faction wh3_dlc20_nur_pallid_nurslings",
						"faction wh3_dlc20_kho_blood_keepers",
						"faction wh2_main_skv_clan_spittel",
						"confederation_valid"
					}
				}
			}
		},
		wh2_dlc12_lzd_cult_of_sotek = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_skv_clan_pestilens",
						"faction wh2_main_skv_clan_spittel",
						"faction wh3_main_skv_clan_skrat",
						"confederation_valid"
					}
				},
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_sotek_stage_one",
						"script_key prophecy_of_sotek_one"
					}
				}
			}
		},
		wh2_dlc13_lzd_spirits_of_the_jungle = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc11_def_the_blessed_dread",
						"faction wh3_dlc21_cst_dead_flag_fleet",
						"faction wh3_dlc21_vmp_jiangshi_rebels",
						"confederation_valid"
					}
				}
			},
			long_objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc11_def_the_blessed_dread",
						"faction wh3_dlc21_cst_dead_flag_fleet",
						"faction wh3_dlc21_vmp_jiangshi_rebels",
						"faction wh2_main_skv_clan_eshin",
						"faction wh3_dlc20_chs_vilitch",
						"faction wh3_main_vmp_caravan_of_blue_roses",
						"faction wh3_main_nur_poxmakers_of_nurgle",
						"faction wh2_main_skv_clan_pestilens",
						"confederation_valid"
					}
				}
			},
			no_subculture_objective = true
		},
		wh2_dlc17_lzd_oxyotl = {
			objectives = {
				{
					type = "COMPLETE_N_MISSIONS_OF_CATEGORY",
					conditions = {
						"event_category Chaos_Map_Medium",
						"event_category Chaos_Map_Hard",
						"total 6"
					}
				}
			},
			long_objectives = {
				{
					type = "COMPLETE_N_MISSIONS_OF_CATEGORY",
					conditions = {
						"event_category Chaos_Map_Medium",
						"event_category Chaos_Map_Hard",
						"total 25"
					}
				}
			},
			no_subculture_objective = true
		},
		wh3_main_ksl_the_ice_court = {
			objectives = {
				{
					type = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
					conditions = {
						"pooled_resource wh3_main_ksl_followers",
						"total 600"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_skv_clan_moulder",
						"faction wh3_dlc20_chs_azazel",
						"confederation_valid"
					}
				}
			},
			long_objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_chs_chaos",
						"faction wh3_main_dae_daemon_prince",
						"faction wh3_dlc20_chs_festus",
						"confederation_valid"
					}
				}
			},
			no_subculture_objective = true
		},
		wh3_main_ksl_the_great_orthodoxy = {
			objectives = {
				{
					type = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
					conditions = {
						"pooled_resource wh3_main_ksl_followers",
						"total 600"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_skv_clan_moulder",
						"faction wh3_dlc20_chs_azazel",
						"confederation_valid"
					}
				}
			},
			long_objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_chs_chaos",
						"faction wh3_main_dae_daemon_prince",
						"faction wh3_dlc20_chs_festus",
						"confederation_valid"
					}
				}
			},
			no_subculture_objective = true
		},
		wh3_main_ksl_ursun_revivalists = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_chs_chaos",
						"faction wh3_main_kho_bloody_sword",
						"confederation_valid"
					}
				}
			},
			long_objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_dae_daemon_prince",
						"faction wh_dlc08_nor_wintertooth",
						"faction wh3_dlc20_chs_kholek",
						"confederation_valid"
					}
				}
			},
			no_subculture_objective = true
		},
		wh_main_vmp_vampire_counts = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc09_tmb_khemri",
						"faction wh3_main_emp_cult_of_sigmar",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_black_pyramid_of_nagash"
					}
				}
			}
		},
		wh2_dlc11_vmp_the_barrow_legion = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_dlc05_wef_argwylon",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 3",
						"province wh3_main_combi_province_bastonne",
						"province wh3_main_combi_province_forest_of_chalons",
						"province wh3_main_combi_province_carcassonne"
					}
				}
			}
		},
		wh_main_vmp_schwartzhafen = {
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 2",
						"province wh3_main_combi_province_northern_sylvania",
						"province wh3_main_combi_province_southern_sylvania"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_altdorf"
					}
				}
			}
		},
		wh3_main_vmp_caravan_of_blue_roses = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_nur_poxmakers_of_nurgle",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_nagashizzar"
					}
				}
			}
		},
		wh2_dlc09_tmb_khemri = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc09_tmb_followers_of_nagash",
						"faction wh3_main_emp_cult_of_sigmar",
						"faction wh_main_vmp_vampire_counts",
						"confederation_valid"
					}
				}
			}
		},
		wh2_dlc09_tmb_exiles_of_nehek = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_legions_of_legends_all",
						"script_key mortuary_cult_all_victory"
					}
				}
			}
		},
		wh2_dlc09_tmb_followers_of_nagash = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc09_tmb_khemri",
						"faction wh2_dlc09_tmb_lybaras",
						"confederation_valid"
					}
				}
			}
		},
		wh2_dlc09_tmb_lybaras = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_vmp_the_silver_host",
						"faction wh2_main_vmp_necrarch_brotherhood",
						"faction wh_main_vmp_vampire_counts",
						"faction wh3_main_ie_vmp_sires_of_mourkain",
						"confederation_valid"
					}
				}
			},
			long_objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc09_tmb_followers_of_nagash",
						"confederation_valid"
					}
				}
			},
			no_subculture_objective = false
		},
		wh3_main_ogr_goldtooth = {
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 3",
						"province wh3_main_combi_province_mountains_of_mourn",
						"province wh3_main_combi_province_ivory_road",
						"province wh3_main_combi_province_bone_road"
					}
				}
			}
		},
		wh3_main_ogr_disciples_of_the_maw = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_cauldron_of_maw",
						"script_key cauldron_of_maw_obtained"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_teb_border_princes",
						"confederation_valid"
					}
				}
			}
		},
		wh3_main_cth_the_northern_provinces = {
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 6",
						"province wh3_main_combi_province_gunpowder_road",
						"province wh3_main_combi_province_lands_of_stone_and_steel",
						"province wh3_main_combi_province_imperial_road",
						"province wh3_main_combi_province_western_great_bastion",
						"province wh3_main_combi_province_central_great_bastion",
						"province wh3_main_combi_province_eastern_great_bastion"
					}
				}
			}
		},
		wh3_main_cth_the_western_provinces = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_cth_dissenter_lords_of_jinshen",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 3",
						"province wh3_main_combi_province_warpstone_desert",
						"province wh3_main_combi_province_wastelands_of_jinshen",
						"province wh3_main_combi_province_ivory_road"
					}
				}
			}
		},
		wh_main_grn_greenskins = {
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 5",
						"region wh3_main_combi_region_great_hall_of_greasus",
						"region wh3_main_combi_region_black_crag",
						"region wh3_main_combi_region_crookback_mountain",
						"region wh3_main_combi_region_nan_gau",
						"region wh3_main_combi_region_karak_eight_peaks",
						"region wh3_main_combi_region_karaz_a_karak",
						"region wh3_main_combi_region_castle_drakenhof",
						"region wh3_main_combi_region_kislev",
						"region wh3_main_combi_region_hell_pit",
						"region wh3_main_combi_region_khazid_irkulaz",
						"region wh3_main_combi_region_hanyu_port",
						"region wh3_main_combi_region_the_fortress_of_vorag",
						"region wh3_main_combi_region_the_tower_of_torment",
						"region wh3_main_combi_region_the_challenge_stone",
						"region wh3_main_combi_region_uzkulak",
						"region wh3_main_combi_region_black_fortress",
						"override_text mission_text_text_mis_activity_control_n_regions_satrapy_including_at_least_n"
					}
				}
			}
		},
		wh2_dlc15_grn_bonerattlaz = {
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 5",
						"province wh3_main_combi_province_northern_worlds_edge_mountains",
						"province wh3_main_combi_province_ostermark",
						"province wh3_main_combi_province_river_urskoy",
						"province wh3_main_combi_province_ostland",
						"province wh3_main_combi_province_peak_pass"
					}
				}
			}
		},
		wh_main_grn_orcs_of_the_bloody_hand = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_complete_wuurzag_any_quest_battle",
						"script_key baleful_squiggly_bonewood_obtained"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 3",
						"province wh3_main_combi_province_western_badlands",
						"province wh3_main_combi_province_southern_badlands",
						"province wh3_main_combi_province_eastern_badlands"
					}
				}
			}
		},
		wh2_dlc15_grn_broken_axe = {
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_tor_yvresse"
					}
				}
			}
		},
		wh_dlc03_bst_beastmen = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_emp_middenland",
						"confederation_valid"
					}
				}
			}
		},
		wh2_dlc17_bst_malagor = {
			objectives = {
				{
					type = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
					conditions = {
						"pooled_resource bst_ruination",
						"total 220"
					}
				}
			}
		},
		wh_dlc05_bst_morghur_herd = {
			objectives = {
				{
					type = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
					conditions = {
						"pooled_resource bst_ruination",
						"total 220"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_teb_estalia",
						"faction wh_main_brt_carcassonne",
						"faction wh_dlc05_wef_wood_elves",
						"confederation_valid"
					}
				}
			}
		},
		wh_main_grn_crooked_moon = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_grn_necksnappers",
						"faction wh_main_dwf_karak_izor",
						"faction wh2_main_skv_clan_mors",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_karak_eight_peaks"
					}
				}
			}
		},
		wh2_dlc17_bst_taurox = {
			objectives = {
				{
					type = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
					conditions = {
						"pooled_resource bst_ruination",
						"total 220"
					}
				}
			}
		},
		wh_dlc08_nor_norsca = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_attain_god_favour_2",
						"script_key attain_chaos_god_favour_lvl_2"
					}
				}
			}
		},
		wh_dlc08_nor_wintertooth = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_dwf_kraka_drak",
						"faction wh3_main_ksl_ropsmenn_clan",
						"faction wh3_main_ksl_the_ice_court",
						"faction wh3_main_ksl_the_great_orthodoxy",
						"confederation_valid"
					}
				}
			}
		},
		wh2_dlc11_cst_vampire_coast = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_restore_harkons_mind",
						"script_key restore_harkon_mind"
					}
				}
			}
		},
		wh2_dlc11_cst_noctilus = {
			objectives = {
				{
					type = "HAVE_AT_LEAST_X_OF_A_POOLED_RESOURCE",
					conditions = {
						"pooled_resource cst_infamy",
						"total 8000"
					}
				}
			}
		},
		wh2_dlc11_cst_pirates_of_sartosa = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc11_cst_noctilus",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_the_galleons_graveyard"
					}
				}
			}
		},
		wh2_dlc11_cst_the_drowned = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_gain_first_shanty",
						"script_key shanty_one_obtained"
					}
				}
			}
		},
		wh2_main_skv_clan_mors = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_grn_necksnappers",
						"faction wh_main_grn_crooked_moon",
						"faction wh_main_dwf_karak_izor",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_karak_eight_peaks"
					}
				}
			}
		},
		wh2_main_skv_clan_pestilens = {
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 4",
						"region wh3_main_combi_region_itza",
						"region wh3_main_combi_region_hexoatl",
						"region wh3_main_combi_region_tlaxtlan",
						"region wh3_main_combi_region_xlanhuapec"
					}
				}
			}
		},
		wh2_main_skv_clan_skryre = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_workshop_rank_achieved",
						"script_key workshop_rank_3_victory"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh_main_teb_estalia",
						"faction wh_main_teb_tilea",
						"faction wh_main_brt_carcassonne",
						"confederation_valid"
					}
				}
			}
		},
		wh2_dlc09_skv_clan_rictus = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_grn_moon_howlerz",
						"faction wh2_dlc15_hef_imrik",
						"confederation_valid"
					}
				}
			}
		},
		wh2_main_skv_clan_eshin = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_perform_eshin_actions",
						"script_key snikch_eshin_actions_complete"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_grn_dimned_sun",
						"faction wh3_main_cth_celestial_loyalists",
						"faction wh3_main_cth_the_northern_provinces",
						"confederation_valid"
					}
				}
			}
		},
		wh2_main_skv_clan_moulder = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_ksl_the_great_orthodoxy",
						"faction wh3_main_ksl_the_ice_court",
						"confederation_valid"
					}
				}
			}
		},
		wh2_main_def_naggarond = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_hef_eataine",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_lothern"
					}
				}
			}
		},
		wh2_main_def_cult_of_pleasure = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_def_har_ganeth",
						"confederation_valid"
					}
				}
			}
		},
		wh2_main_def_har_ganeth = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_def_cult_of_pleasure",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_ancient_city_of_quintex",
						"override_text mission_text_text_mis_activity_control_n_regions_quintex"
					}
				}
			}
		},
		wh2_dlc11_def_the_blessed_dread = {
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 5",
						"region wh3_main_combi_region_shi_long",
						"region wh3_main_combi_region_bridge_of_heaven",
						"region wh3_main_combi_region_hanyu_port",
						"region wh3_main_combi_region_haichai",
						"region wh3_main_combi_region_beichai",
						"region wh3_main_combi_region_zhanshi",
						"region wh3_main_combi_region_li_zhu",
						"override_text mission_text_text_mis_activity_control_n_regions_cathayan_ports"
					}
				}
			}
		},
		wh2_main_def_hag_graef = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"override_text mission_text_text_mis_activity_complete_warpsword_of_khaine",
						"script_key warpsword_of_khaine_obtained"
					}
				}
			}
		},
		wh2_twa03_def_rakarth = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"script_key whip_of_agony_obtained",
						"override_text mission_text_text_mis_activity_complete_whip_of_agony"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 1",
						"province wh3_main_combi_province_the_turtle_isles"
					}
				}
			}
		},
		wh3_main_dae_daemon_prince = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"script_key daemon_prince_ascend_ritual",
						"override_text mission_text_text_wh3_main_narrative_mission_description_ascend"
					}
				}
			}
		},
		wh_main_chs_chaos = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_ksl_the_ice_court",
						"confederation_valid",
						"vassalization_valid"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 2",
						"province wh3_main_combi_province_the_blood_marshes",
						"province wh3_main_combi_province_the_skull_road"
					}
				}
			}
		},
		wh3_dlc20_chs_kholek = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_cth_imperial_wardens",
						"faction wh3_main_cth_the_northern_provinces",
						"confederation_valid",
						"vassalization_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 2",
						"region wh3_main_combi_region_the_challenge_stone",
						"region wh3_main_combi_region_fortress_of_eyes"
					}
				}
			}
		},
		wh3_dlc20_chs_sigvald = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"script_key sliverslash_obtained",
						"override_text mission_text_text_mis_activity_complete_sliverslash"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 3",
						"province wh3_main_combi_province_the_shard_lands",
						"province wh3_main_combi_province_deadwood",
						"province wh3_main_combi_province_the_road_of_skulls"
					}
				}
			}
		},
		wh3_main_chs_shadow_legion = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_sla_seducers_of_slaanesh",
						"faction wh3_dlc20_chs_sigvald",
						"faction wh3_dlc20_tze_the_sightless",
						"confederation_valid",
						"vassalization_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 4",
						"region wh3_main_combi_region_konquata",
						"region wh3_main_combi_region_fortress_of_the_damned",
						"region wh3_main_combi_region_monolith_of_borkill_the_bloody_handed",
						"region wh3_main_combi_region_the_monolith_of_katam",
						"region wh3_main_combi_region_the_frozen_city",
						"region wh3_main_combi_region_altar_of_the_crimson_harvest",
						"region wh3_main_combi_region_the_silvered_tower_of_sorcerers",
						"region wh3_main_combi_region_doomkeep",
						"region wh3_main_combi_region_the_palace_of_ruin",
						"region wh3_main_combi_region_dagraks_end",
						"override_text mission_text_text_mis_activity_control_n_regions_satrapy_including_at_least_n"
					}
				}
			}
		},
		wh3_main_tze_oracles_of_tzeentch = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_lzd_zlatan",
						"faction wh2_main_hef_order_of_loremasters",
						"faction wh2_main_lzd_last_defenders",
						"confederation_valid"
					}
				}
			}
		},
		wh3_main_sla_seducers_of_slaanesh = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_main_hef_avelorn",
						"faction wh2_main_hef_eataine",
						"faction wh2_main_hef_yvresse",
						"confederation_valid",
						"vassalization_valid"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 1",
						"region wh3_main_combi_region_shrine_of_asuryan"
					}
				}
			}
		},
		wh3_main_nur_poxmakers_of_nurgle = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc15_dwf_clan_helhein",
						"faction wh_main_dwf_karak_azul",
						"faction wh3_main_vmp_caravan_of_blue_roses",
						"confederation_valid"
					}
				},
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 1",
						"province wh3_main_combi_province_the_dragon_isles"
					}
				}
			}
		},
		wh3_main_kho_exiles_of_khorne = {
			objectives = {
				{
					type = "SCRIPTED",
					conditions = {
						"script_key slaughter_carnage_obtained",
						"override_text mission_text_text_mis_activity_complete_slaughter_carnage"
					}
				}
			}
		},
		wh3_dlc20_chs_festus = {
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 3",
						"region wh3_main_combi_region_middenheim",
						"region wh3_main_combi_region_praag",
						"region wh3_main_combi_region_kislev"
					}
				}
			}
		},
		wh3_dlc20_chs_azazel = {
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 5",
						"province wh3_main_combi_province_trollheim_mountains",
						"province wh3_main_combi_province_gianthome_mountains",
						"province wh3_main_combi_province_mountains_of_hel",
						"province wh3_main_combi_province_vanaheim_mountains",
						"province wh3_main_combi_province_mountains_of_naglfari"
					}
				}
			}
		},
		wh3_dlc20_chs_valkia = {
			objectives = {
				{
					type = "CONTROL_N_PROVINCES_INCLUDING",
					conditions = {
						"total 2",
						"province wh3_main_combi_province_spiteful_peaks",
						"province wh3_main_combi_province_iron_foothills"
					}
				},
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 2",
						"region wh3_main_combi_region_the_palace_of_ruin",
						"region wh3_main_combi_region_the_frozen_city"
					}
				}
			}
		},
		wh3_dlc20_chs_vilitch = {
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 5",
						"region wh3_main_combi_region_red_fortress",
						"region wh3_main_combi_region_bloodwind_keep",
						"region wh3_main_combi_region_fortress_of_eyes",
						"region wh3_main_combi_region_wei_jin",
						"region wh3_main_combi_region_nan_gau"
					}
				}
			}
		},
		wh3_dlc23_chd_legion_of_azgorh = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh2_dlc09_skv_clan_rictus",
						"faction wh2_dlc15_hef_imrik",
						"confederation_valid"
					}
				}
			}
		},
		wh3_dlc23_chd_astragoth = {
			objectives = {
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_vmp_lahmian_sisterhood",
						"faction wh_main_dwf_kraka_drak",
						"confederation_valid"
					}
				}
			}
		},
		wh3_dlc23_chd_zhatan = {
			objectives = {
				{
					type = "CONTROL_N_REGIONS_FROM",
					conditions = {
						"total 3",
						"region wh3_main_combi_region_turtle_gate",
						"region wh3_main_combi_region_dragon_gate",
						"region wh3_main_combi_region_snake_gate"
					}
				},
				{
					type = "DESTROY_FACTION",
					conditions = {
						"faction wh3_main_cth_the_northern_provinces",
						"confederation_valid"
					}
				}
			}
		}
	}
};
function victory_objectives_ie:initialise_victory_missions(faction_key, multiplayer)
	local faction_subculture_key = (cm:get_faction(faction_key)):subculture();
	local faction_alignment = self.alignments.default;
	if self.subcultures[faction_subculture_key] then
		faction_alignment = self.subcultures[faction_subculture_key].alignment;
	end;
	if multiplayer then
		self:create_multiplayer_mission(faction_key);
	end;
	self:create_faction_mission(faction_key, faction_alignment);
	self:create_long_mission(faction_key, faction_subculture_key, faction_alignment);
	self:create_domination_mission(faction_key);
end;
function victory_objectives_ie:create_multiplayer_mission(faction_key)
	local mission_key = "wh3_main_mp_victory";
	local mm = mission_manager:new(faction_key, mission_key);
	self:create_multiplayer_objective(mm, faction_key);
	self:trigger_mission(mm, self.victory_type.multiplayer);
end;
function victory_objectives_ie:create_faction_mission(faction_key, faction_alignment)
	local mission_key = "wh_main_short_victory";
	local mm = mission_manager:new(faction_key, mission_key);
	self:create_faction_objective(mm, faction_key);
	self:create_alignment_objective(mm, faction_alignment, mission_key, faction_key);
	self:trigger_mission(mm, self.victory_type.faction, mission_key, faction_alignment);
end;
function victory_objectives_ie:create_long_mission(faction_key, faction_subculture_key, faction_alignment)
	local mission_key = "wh_main_long_victory";
	local mm = mission_manager:new(faction_key, mission_key);
	mm:add_new_objective("SCRIPTED");
	mm:add_condition("script_key complete_faction_victory");
	mm:add_condition("override_text mission_text_text_ie_attain_faction_victory");
	self:create_alignment_objective(mm, faction_alignment, mission_key, faction_key);
	self:create_long_objective(mm, faction_subculture_key, faction_key);
	self:trigger_mission(mm, self.victory_type.subculture, mission_key, faction_alignment);
end;
function victory_objectives_ie:create_domination_mission(faction_key)
	local mission_key = "wh_main_domination_victory";
	local mm = mission_manager:new(faction_key, mission_key);
	self:create_domination_objective(mm, faction_key);
	self:trigger_mission(mm, self.victory_type.domination);
end;
function victory_objectives_ie:trigger_mission(mm, victory_type, mission_key, faction_alignment)
	local bundle = nil;
	if mission_key ~= nil and faction_alignment ~= nil then
		bundle = self.alignments[faction_alignment][mission_key].payload_bundle;
		if is_table(bundle) then
			for i = 1, #bundle do
				if bundle[i] ~= nil then
					mm:add_payload("effect_bundle{bundle_key " .. bundle[i] .. ";turns 0;}");
				end;
			end;
		elseif bundle ~= nil then
			mm:add_payload("effect_bundle{bundle_key " .. bundle .. ";turns 0;}");
		end;
		ancillary = self.alignments[faction_alignment][mission_key].payload_ancillary;
		if is_table(ancillary) then
			for i = 1, #ancillary do
				if ancillary[i] ~= nil then
					mm:add_payload("add_ancillary_to_faction_pool{ancillary_key " .. ancillary[i] .. ";}");
				end;
			end;
		elseif ancillary ~= nil then
			mm:add_payload("add_ancillary_to_faction_pool{ancillary_key " .. ancillary .. ";}");
		end;
	end;
	if bundle == nil and ancillary == nil or victory_type == self.victory_type.multiplayer or victory_type == self.victory_type.domination then
		mm:add_payload("text_display dummy_wh3_main_survival_forge_of_souls");
		mm:add_payload("game_victory");
	end;
	mm:set_victory_type(victory_type);
	mm:set_victory_mission(true);
	mm:set_show_mission(false);
	mm:trigger();
end;
function victory_objectives_ie:create_multiplayer_objective(mm, faction_key)
	local objectives = self.multiplayer.objectives;
	if objectives ~= nil then
		self:add_objectives(mm, objectives, faction_key);
	end;
end;
function victory_objectives_ie:create_faction_objective(mm, faction_key)
	if self.factions[faction_key] then
		local objectives = self.factions[faction_key].objectives;
		if objectives ~= nil then
			self:add_objectives(mm, objectives, faction_key);
		end;
	end;
end;
function victory_objectives_ie:create_alignment_objective(mm, faction_alignment, mission_key, faction_key)
	local objectives = self.alignments[faction_alignment][mission_key].objectives;
	if objectives ~= nil then
		self:add_objectives(mm, objectives, faction_key);
	end;
end;
function victory_objectives_ie:create_long_objective(mm, faction_subculture_key, faction_key)
	local objectives = {};
	if self.factions[faction_key] and self.factions[faction_key].long_objectives then
		for _, objective in pairs(self.factions[faction_key].long_objectives) do
			table.insert(objectives, objective);
		end;
	end;
	if self.subcultures[faction_subculture_key] and (self.factions[faction_key] and self.factions[faction_key].no_subculture_objective ~= true) then
		for _, objective in pairs(self.subcultures[faction_subculture_key].objectives) do
			table.insert(objectives, objective);
		end;
	end;
	if #objectives > 0 then
		self:add_objectives(mm, objectives, faction_key);
	end;
end;
function victory_objectives_ie:create_domination_objective(mm, faction_key)
	local objectives = {
		{
			type = "OCCUPY_LOOT_RAZE_OR_SACK_X_SETTLEMENTS",
			conditions = {
				"total 272"
			}
		}
	};
	self:add_objectives(mm, objectives, faction_key);
end;
function victory_objectives_ie:add_objectives(mm, objectives, faction_key)
	for i1 = 1, #objectives do
		if objectives[i1].type ~= nil then
			mm:add_new_objective(objectives[i1].type);
			for i2 = 1, #objectives[i1].conditions do
				mm:add_condition(objectives[i1].conditions[i2]);
			end;
			if objectives[i1].type == "CONSTRUCT_N_BUILDINGS_FROM" or objectives[i1].type == "CONSTRUCT_N_BUILDINGS_INCLUDING" then
				mm:add_condition("faction " .. faction_key);
			end;
		end;
	end;
end;
cm:add_first_tick_callback_new(function()
	local human_factions = cm:get_human_factions();
	local multiplayer = false;
	if #human_factions > 1 then
		multiplayer = true;
	end;
	for i = 1, #human_factions do
		local faction_key = human_factions[i];
		victory_objectives_ie:initialise_victory_missions(faction_key, multiplayer);
	end;
end);
function victory_objectives_ie:trigger_victory_incident(faction, mission_key, incident_key)
	local faction_subculture_key = faction:subculture();
	local faction_alignment = self.alignments.default;
	if self.subcultures[faction_subculture_key] then
		faction_alignment = self.subcultures[faction_subculture_key].alignment;
	end;
	local bundle = self.alignments[faction_alignment][mission_key].payload_bundle;
	local incident_builder = cm:create_incident_builder(incident_key);
	local payload = cm:create_new_custom_effect_bundle(bundle);
	payload:set_duration(0);
	local payload_builder = cm:create_payload();
	payload_builder:effect_bundle_to_faction(payload);
	incident_builder:set_payload(payload_builder);
	cm:launch_custom_incident_from_builder(incident_builder, cm:get_faction(faction:name()));
end;
function victory_objectives_ie:add_scripted_victory_listeners()
	core:add_listener("IEVictoryConditionShortVictoryAttained", "MissionSucceeded", function(context)
		return (context:mission()):mission_record_key() == "wh_main_short_victory";
	end, function(context)
		local faction = context:faction();
		cm:complete_scripted_mission_objective(faction:name(), "wh_main_long_victory", "complete_faction_victory", true);
		self:trigger_victory_incident(faction, "wh_main_short_victory", "wh3_main_ie_victory_short");
	end, true);
	core:add_listener("IEVictoryConditionLongVictoryAttained", "MissionSucceeded", function(context)
		return (context:mission()):mission_record_key() == "wh_main_long_victory";
	end, function(context)
		self:trigger_victory_incident(context:faction(), "wh_main_long_victory", "wh3_main_ie_victory_long");
	end, true);
	local thorgrim_faction_key = "wh_main_dwf_dwarfs";
	if (cm:get_faction(thorgrim_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionThorgrimFirstGrudge", "MissionSucceeded", function(context)
			return (context:faction()):name() == thorgrim_faction_key and ((context:mission()):mission_record_key() == "wh2_dlc17_grudge_legendary_enemy_skarsnik" or (context:mission()):mission_record_key() == "wh2_dlc17_grudge_legendary_enemy_queek" or (context:mission()):mission_record_key() == "wh2_dlc17_grudge_legendary_settlement_black_crag" or (context:mission()):mission_record_key() == "wh2_dlc17_grudge_legendary_settlement_karak_azgal");
		end, function()
			cm:complete_scripted_mission_objective(thorgrim_faction_key, "wh_main_short_victory", "thorgrim_one_grudge_short_victory", true);
		end, true);
	end;
	local alberic_faction_key = "wh_main_brt_bordeleaux";
	if (cm:get_faction(alberic_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionAlbericGrailVowCompleted", "ScriptEventBretonniaGrailVowCompleted", function(context)
			return (context:character()):character_subtype("wh_dlc07_brt_alberic");
		end, function()
			cm:complete_scripted_mission_objective(alberic_faction_key, "wh_main_short_victory", "alberic_grail_vow_success", true);
		end, true);
	end;
	local fay_enchantress_faction_key = "wh_main_brt_carcassonne";
	if (cm:get_faction(fay_enchantress_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionFayEnchantressTrotheCompleted", "ScriptEventBretonniaVirtueTrothCompleted", function(context)
			return (context:character()):character_subtype("wh_dlc07_brt_fay_enchantress");
		end, function()
			cm:complete_scripted_mission_objective(fay_enchantress_faction_key, "wh_main_short_victory", "enchantress_virtue_success", true);
		end, true);
	end;
	local daemon_prince_faction_key = "wh3_main_dae_daemon_prince";
	if (cm:get_faction(daemon_prince_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionDaemonPrinceAscendRitualListener", "RitualCompletedEvent", function(context)
			local ritual_key = (context:ritual()):ritual_key();
			return (context:performing_faction()):name() == daemon_prince_faction_key and (ritual_key == "wh3_main_ritual_dae_ascend_khorne" or ritual_key == "wh3_main_ritual_dae_ascend_nurgle" or ritual_key == "wh3_main_ritual_dae_ascend_slaanesh" or ritual_key == "wh3_main_ritual_dae_ascend_tzeentch" or ritual_key == "wh3_main_ritual_dae_ascend_undivided");
		end, function()
			cm:complete_scripted_mission_objective(daemon_prince_faction_key, "wh_main_short_victory", "daemon_prince_ascend_ritual", true);
		end, true);
	end;
	local khatep_faction_key = "wh2_dlc09_tmb_exiles_of_nehek";
	if (cm:get_faction(khatep_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionKhatepAwakenLegionsofLegendAll", "RitualCompletedEvent", function(context)
			local ritual_key = (context:ritual()):ritual_key();
			return (context:performing_faction()):name() == khatep_faction_key and (ritual_key == "wh2_dlc09_ritual_crafting_tmb_carrion" or ritual_key == "wh2_dlc09_ritual_crafting_tmb_nehekhara_warriors" or ritual_key == "wh2_dlc09_ritual_crafting_tmb_necropolis_knights" or ritual_key == "wh2_dlc09_ritual_crafting_tmb_nehekhara_horsemen");
		end, function()
			local awakened_ritual_count = cm:get_saved_value("khatep_short_victory_count") or 0;
			awakened_ritual_count = awakened_ritual_count + 1;
			cm:set_saved_value("khatep_short_victory_count", awakened_ritual_count);
			if awakened_ritual_count == 4 then
				cm:complete_scripted_mission_objective(khatep_faction_key, "wh_main_short_victory", "mortuary_cult_all_victory", true);
			end;
		end, true);
	end;
	local cylostra_faction_key = "wh2_dlc11_cst_the_drowned";
	if (cm:get_faction(cylostra_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionCylostraVerseOneObtained", "MissionSucceeded", function(context)
			return (context:faction()):name() == cylostra_faction_key and ((context:mission()):mission_record_key() == "wh2_dlc11_mission_sea_shanty_1" or (context:mission()):mission_record_key() == "wh2_dlc11_mission_sea_shanty_player_1");
		end, function()
			cm:complete_scripted_mission_objective(cylostra_faction_key, "wh_main_short_victory", "shanty_one_obtained", true);
		end, true);
	end;
	local skrag_faction_key = "wh3_main_ogr_disciples_of_the_maw";
	if (cm:get_faction(skrag_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionSkragCauldronOfMaw", "MissionSucceeded", function(context)
			return (context:faction()):name() == skrag_faction_key and (context:mission()):mission_record_key() == "wh3_main_ie_qb_ogr_skrag_cauldron_of_the_great_maw";
		end, function()
			cm:complete_scripted_mission_objective(skrag_faction_key, "wh_main_short_victory", "cauldron_of_maw_obtained", true);
		end, true);
	end;
	local wurrzag_faction_key = "wh_main_grn_orcs_of_the_bloody_hand";
	if (cm:get_faction(wurrzag_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionWuurzagBalefulSquigglyBonewood", "MissionSucceeded", function(context)
			local mission_key = (context:mission()):mission_record_key();
			return (context:faction()):name() == wurrzag_faction_key and (mission_key == "wh3_main_ie_qb_grn_wurrzag_da_great_green_prophet_baleful_mask" or mission_key == "wh3_main_ie_qb_grn_wurrzag_da_great_green_prophet_bonewood_staff" or mission_key == "wh3_main_ie_qb_grn_wurrzag_da_great_green_prophet_squiggly_beast");
		end, function()
			cm:complete_scripted_mission_objective(wurrzag_faction_key, "wh_main_short_victory", "baleful_squiggly_bonewood_obtained", true);
		end, true);
	end;
	local rakarth_faction_key = "wh2_twa03_def_rakarth";
	if (cm:get_faction(rakarth_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionRakarthWhipOfAgony", "MissionSucceeded", function(context)
			return (context:faction()):name() == rakarth_faction_key and (context:mission()):mission_record_key() == "wh3_main_ie_qb_def_rakarth_whip_of_agony";
		end, function()
			cm:complete_scripted_mission_objective(rakarth_faction_key, "wh_main_short_victory", "whip_of_agony_obtained", true);
		end, true);
	end;
	local skarbrand_faction_key = "wh3_main_kho_exiles_of_khorne";
	if (cm:get_faction(skarbrand_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionSkarbrandObtainsCarnage", "MissionSucceeded", function(context)
			return (context:faction()):name() == skarbrand_faction_key and (context:mission()):mission_record_key() == "wh3_main_ie_qb_kho_skarbrand_slaughter_and_carnage";
		end, function()
			cm:complete_scripted_mission_objective(skarbrand_faction_key, "wh_main_short_victory", "slaughter_carnage_obtained", true);
		end, true);
	end;
	local sigvald_faction_key = "wh3_dlc20_chs_sigvald";
	if (cm:get_faction(sigvald_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionSkarbrandObtainsCarnage", "MissionSucceeded", function(context)
			return (context:faction()):name() == sigvald_faction_key and (context:mission()):mission_record_key() == "wh3_main_ie_qb_chs_prince_sigvald_sliverslash";
		end, function()
			cm:complete_scripted_mission_objective(sigvald_faction_key, "wh_main_short_victory", "sliverslash_obtained", true);
		end, true);
	end;
	local ikit_claw_faction_key = "wh2_main_skv_clan_skryre";
	if (cm:get_faction(ikit_claw_faction_key)):is_human() then
		core:add_listener("Ikit_Claw_Incident_Workshop_3", "IncidentOccuredEvent", function(context)
			return (context:faction()):name() == ikit_claw_faction_key and context:dilemma() == "wh2_dlc12_incident_skv_workshop_upgrade_3";
		end, function()
			cm:complete_scripted_mission_objective(ikit_claw_faction_key, "wh_main_short_victory", "workshop_rank_3_victory", true);
		end, true);
	end;
	local imrik_faction_key = "wh2_dlc15_hef_imrik";
	if (cm:get_faction(imrik_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionImrikDragonEncounterDilemmaIssued", "DilemmaIssuedEvent", function(context)
			return (context:faction()):name() == imrik_faction_key and (context:dilemma()):starts_with("wh2_dlc15_dilemma_dragon_encounter_special_");
		end, function()
			local dragon_encounter_count = cm:get_saved_value("imrik_short_victory_count") or 0;
			dragon_encounter_count = dragon_encounter_count + 1;
			cm:set_saved_value("imrik_short_victory_count", dragon_encounter_count);
			if dragon_encounter_count == 5 then
				cm:complete_scripted_mission_objective(imrik_faction_key, "wh_main_long_victory", "dragon_encounters_all", true);
			elseif dragon_encounter_count == 2 then
				cm:complete_scripted_mission_objective(imrik_faction_key, "wh_main_short_victory", "dragon_encounters", true);
			end;
		end, true);
	end;
	local tehenhauin_faction_key = "wh2_dlc12_lzd_cult_of_sotek";
	if (cm:get_faction(tehenhauin_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionTehenhauinProphecyCompleted", "MissionIssued", function(context)
			return (context:faction()):name() == tehenhauin_faction_key and ((context:mission()):mission_record_key()):starts_with("wh2_dlc12_prophecy_of_sotek_2_");
		end, function()
			cm:complete_scripted_mission_objective(tehenhauin_faction_key, "wh_main_short_victory", "prophecy_of_sotek_one", true);
		end, true);
	end;
	local malus_faction_key = "wh2_main_def_hag_graef";
	if (cm:get_faction(malus_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionMalusWarpswordOfKhaine", "MissionSucceeded", function(context)
			return (context:faction()):name() == malus_faction_key and (context:mission()):mission_record_key() == "wh3_main_ie_qb_def_malus_warpsword_of_khaine";
		end, function()
			cm:complete_scripted_mission_objective(malus_faction_key, "wh_main_short_victory", "warpsword_of_khaine_obtained", true);
		end, true);
	end;
	local snikch_faction_key = "wh2_main_skv_clan_eshin";
	if (cm:get_faction(snikch_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionSnikchEshinActionsr", "RitualCompletedEvent", function(context)
			return (context:performing_faction()):name() == snikch_faction_key and ((context:ritual()):ritual_key()):starts_with("wh2_dlc14_eshin_actions_");
		end, function()
			local performed_clan_ritual_count = cm:get_saved_value("snikch_short_victory_count") or 0;
			performed_clan_ritual_count = performed_clan_ritual_count + 1;
			cm:set_saved_value("snikch_short_victory_count", performed_clan_ritual_count);
			if performed_clan_ritual_count >= 8 then
				cm:complete_scripted_mission_objective(snikch_faction_key, "wh_main_short_victory", "snikch_eshin_actions_complete", true);
			end;
		end, true);
	end;
	local eltharion_faction_key = "wh2_main_hef_yvresse";
	if (cm:get_faction(eltharion_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionEltharionTamarhaUpgrade", "RitualCompletedEvent", function(context)
			return (context:ritual()):ritual_category() == "ATHEL_TAMARHA_RITUAL";
		end, function()
			local athel_tamarha_upgrade_count = cm:get_saved_value("eltharion_upgrade_short_victory_count") or 0;
			athel_tamarha_upgrade_count = athel_tamarha_upgrade_count + 1;
			cm:set_saved_value("eltharion_upgrade_short_victory_count", athel_tamarha_upgrade_count);
			if athel_tamarha_upgrade_count >= 18 then
				cm:complete_scripted_mission_objective(eltharion_faction_key, "wh_main_long_victory", "athel_tamarha_max_upgrades_attained", true);
			elseif athel_tamarha_upgrade_count == 12 then
				cm:complete_scripted_mission_objective(eltharion_faction_key, "wh_main_short_victory", "athel_tamarha_upgrades_attained", true);
			end;
		end, true);
	end;
	local nakai_faction_key = "wh2_dlc13_lzd_spirits_of_the_jungle";
	local pestilens_faction_key = "wh2_main_skv_clan_pestilens";
	if (cm:get_faction("wh2_dlc13_lzd_spirits_of_the_jungle")):is_human() then
		core:add_listener("IEVictoryConditionNakaiShortVictoryDilemma", "MissionSucceeded", function(context)
			return (context:faction()):name() == nakai_faction_key and (context:mission()):mission_record_key() == "wh_main_short_victory";
		end, function()
			if (cm:get_faction(pestilens_faction_key)):is_dead() == false then
				cm:trigger_dilemma(nakai_faction_key, "wh3_dlc21_lzd_lingering_pestilence_dilemma_nakai");
			end;
		end, true);
	end;
	if (cm:get_faction(nakai_faction_key)):is_human() then
		core:add_listener("IEVictoryConditionNakaiDilemmaChoiceMadeEvent", "DilemmaChoiceMadeEvent", function(context)
			return context:dilemma() == "wh3_dlc21_lzd_lingering_pestilence_dilemma_nakai";
		end, function(context)
			local choice = context:choice();
			if choice == 0 then
				local units = "wh2_main_lzd_inf_saurus_spearmen_1,wh2_main_lzd_inf_saurus_spearmen_1,wh2_main_lzd_mon_kroxigors,wh2_main_lzd_mon_kroxigors,wh2_main_lzd_inf_saurus_warriors_1,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_mon_stegadon_1,wh2_main_lzd_mon_carnosaur_0,wh2_main_lzd_mon_bastiladon_2";
				local agents = {
					wh2_main_lzd_saurus_scar_veteran = "champion",
					wh2_main_lzd_skink_chief = "spy",
					wh2_main_lzd_skink_priest_heavens = "wizard"
				};
				if (cm:get_faction(nakai_faction_key)):at_war_with(cm:get_faction(pestilens_faction_key)) == false then
					cm:force_declare_war(nakai_faction_key, pestilens_faction_key, false, false);
				end;
				local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_settlement(nakai_faction_key, "wh3_main_combi_region_itza", false, true, 10);
				cm:create_force(nakai_faction_key, units, "wh3_main_combi_region_itza", pos_x, pos_y, false, function(cqi)
					local force = (cm:get_character_by_cqi(cqi)):military_force();
					for subtype, type in pairs(agents) do
						local agent_x, agent_y = cm:find_valid_spawn_location_for_character_from_settlement(nakai_faction_key, "wh3_main_combi_region_itza", false, true, 10);
						local agent = cm:create_agent(nakai_faction_key, type, subtype, agent_x, agent_y);
						cm:add_agent_experience(cm:char_lookup_str(agent:command_queue_index()), cm:random_number(16, 10), true);
						cm:embed_agent_in_force(agent, force);
					end;
					local character = cm:char_lookup_str(cqi);
					cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force_endgame", cqi, 8);
					cm:add_experience_to_units_commanded_by_character(character, 7);
					cm:add_growth_points_to_horde(force, 8);
					cm:add_building_to_force(force:command_queue_index(), {
						"wh2_dlc13_horde_lizardmen_ziggurat_minor_1",
						"wh2_dlc13_horde_lizardmen_support_upkeep_1",
						"wh2_dlc13_horde_lizardmen_portal_quetzl_1"
					});
				end);
			end;
		end, true);
	end;
end;
