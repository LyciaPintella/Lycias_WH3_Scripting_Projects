out("Loading phar_pillars_civilization.lua")

local function output(str)
     if str then
          out("*** _PILLARS OF CIVILIZATION_ ***: " .. str)
     end
end

pillars_civilization = {
     config = {
          regions = {
               "phar_main_memphis_memphis",
               "phar_main_heliopolis_heliopolis",
               "phar_main_kawa_kawa",
               "phar_main_buhen_buhen",
               "phar_main_north_nubia_miam",
               "phar_main_kom_ombo_kom_ombo",
               "phar_main_thebes_thebes",
               "phar_main_abydos_abydos",
               "phar_main_hermopolis_hermopolis",
               "phar_main_damascus_damascus",
               "phar_main_emar_emar",
               "phar_main_ugarit_ugarit",
               "phar_main_tyre_byblos",
               "phar_main_ashkelon_ashkelon",
               "phar_main_carchemish_carchemish",
               "phar_main_south_hatti_tarhuntassa",
               "phar_main_west_hatti_gordion",
               "phar_main_hattussa_hattussa",
               "phar_main_malidiya_malidiya",
               "phar_main_amarna_amarna",
               "phar_map_sinticobisaltia_siris",
               "phar_map_mycenaeca_mycenae",
               "phar_map_kretes_knossos",
               "phar_map_ilion_troy",
               "phar_map_isthmos_cibyra",
               "phar_map_aranzah_assur",
               "phar_map_bit_peri_amurru_dur_kurigalzu",
               "phar_map_kan_digirak_babylon",
               "phar_map_karduniash_ishtananu_nippur",
               "phar_map_northern_elam_susa"
          },

          points_per_level = {
               [0] = 0,
               [1] = 5,
               [2] = 10,
               [3] = 15,
               [4] = 30,
               [5] = 45,
          },

          levels = {
               -- we map the level to the min civilization score needed to be on this level
               -- this needs to match enum CIVILIZATION_LEVEL in EmpireCommon.h
               -- method that translates between the two is set_new_civilization_level
               [1] = {
                    lower_bound = -99999,
                    name = "collapse",
                    settled_factions_effect_bundle_key =
                    "phar_main_effect_bundle_pillars_civilization_collapse_settled_faction",
                    nomads_effect_bundle_key = "phar_main_effect_bundle_pillars_civilization_collapse_nomads",
                    nomads_red_crown_effect_bundle_key =
                    "phar_main_effect_bundle_pillars_civilization_collapse_nomads_red_crown",
                    sea_peoples_effect_bundle_key = "phar_main_effect_bundle_pillars_civilization_collapse_sea_peoples",
                    sea_peoples_playable_effect_bundle_key =
                    "phar_sea_effect_bundle_pillars_civilization_collapse_sea_peoples_playable",
                    sea_peoples_red_crown_effect_bundle_key =
                    "phar_main_effect_bundle_pillars_civilization_collapse_sea_peoples_red_crown",
                    blessing_chance = 0,
                    disaster_chance = 19,
                    incident_cooldown = 4,
               },
               [2] = {
                    lower_bound = 450,
                    name = "crisis",
                    settled_factions_effect_bundle_key =
                    "phar_main_effect_bundle_pillars_civilization_crisis_settled_faction",
                    nomads_effect_bundle_key = "phar_main_effect_bundle_pillars_civilization_crisis_nomads",
                    nomads_red_crown_effect_bundle_key =
                    "phar_main_effect_bundle_pillars_civilization_crisis_nomads_red_crown",
                    sea_peoples_effect_bundle_key = "phar_main_effect_bundle_pillars_civilization_crisis_sea_peoples",
                    sea_peoples_playable_effect_bundle_key =
                    "phar_sea_effect_bundle_pillars_civilization_crisis_sea_peoples_playable",
                    sea_peoples_red_crown_effect_bundle_key =
                    "phar_main_effect_bundle_pillars_civilization_crisis_sea_peoples_red_crown",
                    blessing_chance = 6,
                    disaster_chance = 13,
                    incident_cooldown = 4,
               },
               [3] = {
                    lower_bound = 640,
                    name = "prosperity",
                    settled_factions_effect_bundle_key =
                    "phar_main_effect_bundle_pillars_civilization_prosperity_settled_faction",
                    nomads_effect_bundle_key = "phar_main_effect_bundle_pillars_civilization_prosperity_nomads",
                    nomads_red_crown_effect_bundle_key =
                    "phar_main_effect_bundle_pillars_civilization_prosperity_nomads_red_crown",
                    sea_peoples_effect_bundle_key = "phar_main_effect_bundle_pillars_civilization_prosperity_sea_peoples",
                    sea_peoples_playable_effect_bundle_key =
                    "phar_sea_effect_bundle_pillars_civilization_prosperity_sea_peoples_playable",
                    sea_peoples_red_crown_effect_bundle_key =
                    "phar_main_effect_bundle_pillars_civilization_prosperity_sea_peoples_red_crown",
                    blessing_chance = 13,
                    disaster_chance = 4,
                    incident_cooldown = 4,
               },
          },

          index_of_level_to_use_for_mood_when_system_is_disabled = 3,

          nomads_factions = {
               "phar_main_bahariya",
               "phar_main_dakhla",
               "phar_main_dungul",
               "phar_main_farafra",
               "phar_main_habiru",
               "phar_main_hetch",
               "phar_main_kharga",
               "phar_main_libu",
               "phar_main_meshwesh",
               "phar_main_nekhel",
               "phar_main_kaska",
               "phar_main_libu_invaders",
               "phar_main_phrygian_invaders",
               "phar_map_ahlamu_invaders",
               "phar_map_elamite_invaders",
               "phar_map_urartu_invaders",
          },
          sea_peoples_factions = {
               "phar_sea_denyen",
               "phar_sea_ekwesh",
               "phar_sea_lukka",
               "phar_sea_shekelesh",
               "phar_sea_teresh",
               "phar_sea_tjeker",
               "phar_sea_weshesh",
          },

          province_groups = {
               ["Upper Assuwa"] = {
                    "phar_map_arzawa",
                    "phar_map_boreas_nesoi",
                    "phar_map_karkisha",
                    "phar_map_masha",
                    "phar_map_seha",
                    "phar_map_wilusha",
               },
               ["Lower Assuwa"] = {
                    "phar_map_caria",
                    "phar_map_isthmos",
                    "phar_map_lazpa",
                    "phar_map_lycia",
                    "phar_map_mira",
                    "phar_map_rhodes",
               },
               ["Upper Achaea"] = {
                    "phar_map_achaea",
                    "phar_map_cephallenia",
                    "phar_map_cyclades",
                    "phar_map_kaftiu",
                    "phar_map_laconia",
               },
               ["Lower Achaea"] = {
                    "phar_map_aetolia",
                    "phar_map_attica",
                    "phar_map_epirus",
                    "phar_map_peonia",
                    "phar_map_thessaly",
               },
               ["Thrace"] = {
                    "phar_map_mygdonia",
                    "phar_map_thrace",
                    "phar_map_thynia",
               },
               ["Lowlands"] = {
                    "phar_main_central_hatti",
                    "phar_main_parha",
                    "phar_main_south_hatti",
                    "phar_main_tarsus",
                    "phar_main_tuwana",
               },
               ["Highlands"] = {
                    "phar_main_ancyra",
                    "phar_main_hattusa",
                    "phar_main_north_hatti",
                    "phar_map_pala",
                    "phar_main_purushanda",
                    "phar_main_west_hatti",
               },
               ["Isuwa"] = {
                    "phar_map_kammanu",
                    "phar_main_kanesh",
                    "phar_main_malidiya",
                    "phar_map_zalpuwa",
                    "phar_main_zippalanda",
               },
               ["Yamhad and Retjenu"] = {
                    "phar_main_aleppo",
                    "phar_main_alashiya",
                    "phar_main_carchemish",
                    "phar_main_damascus",
                    "phar_main_emar",
                    "phar_main_shechem",
                    "phar_main_ugarit",
               },
               ["Fenkhu"] = {
                    "phar_main_ashkelon",
                    "phar_main_kadesh",
                    "phar_main_megiddo",
                    "phar_main_tyre",
               },
               ["Sinai"] = {
                    "phar_main_sinai",
                    "phar_main_east_sinai",
                    "phar_main_north_sinai",
               },
               ["Coastal Lower Egypt"] = {
                    "phar_main_buto",
                    "phar_main_heliopolis",
                    "phar_main_pi_ramesses",
                    "phar_main_rhacotis",
                    "phar_main_faiyum",
               },
               ["Inland Lower Egypt"] = {
                    "phar_main_amarna",
                    "phar_main_herakleopolis",
                    "phar_main_hardai",
                    "phar_main_hermopolis",
                    "phar_main_memphis",
               },
               ["Upper Egypt"] = {
                    "phar_main_abydos",
                    "phar_main_akhmim",
                    "phar_main_asyut",
                    "phar_main_elephantine",
                    "phar_main_kom_ombo",
                    "phar_main_saww",
                    "phar_main_thebes",
               },
               ["Nubia"] = {
                    "phar_main_buhen",
                    "phar_main_east_nubia",
                    "phar_main_north_nubia",
                    "phar_main_north_east_nubia",
               },
               ["Kush"] = {
                    "phar_main_kawa",
                    "phar_main_kerma",
                    "phar_main_napata",
                    "phar_main_per_ramesses_meri_amon",
               },
               ["Aber Nahra and Elam"] = {
                    "phar_map_ashtata",
                    "phar_map_balihu",
                    "phar_map_northern_elam",
               },
               ["Mat-Assur"] = {
                    "phar_map_aranzah",
                    "phar_map_azalzi",
                    "phar_map_hanigalbat",
                    "phar_map_mari",
                    "phar_map_suhum_elu",
               },
               ["Zagros"] = {
                    "phar_map_hayasa_azzi",
                    "phar_map_kadmuhu",
                    "phar_map_qutu",
                    "phar_map_radanu",
                    "phar_map_uruatri",
                    "phar_map_zabu",
               },
               ["Mat-tamti"] = {
                    "phar_map_ashnunnak",
                    "phar_map_bit_peri_amurru",
                    "phar_map_kan_digirak",
                    "phar_map_karduniash_ishtananu",
                    "phar_map_karduniash_shutaiu",
                    "phar_map_suhum_shaplu",
               },

          },
          province_group_templates = {
               [1] = {
                    "Upper Assuwa",
                    "Thrace",
                    "Lowlands",
                    "Yamhad and Retjenu",
                    "Coastal Lower Egypt",
                    "Kush",
                    "Zagros",
               },
               [2] = {
                    "Lower Assuwa",
                    "Lower Achaea",
                    "Highlands",
                    "Fenkhu",
                    "Nubia",
                    "Upper Egypt",
                    "Mat-tamti",
               },
               [3] = {
                    "Upper Achaea",
                    "Thrace",
                    "Isuwa",
                    "Sinai",
                    "Inland Lower Egypt",
                    "Nubia",
                    "Aber Nahra and Elam",
                    "Mat-assur",
               }
          },

          max_war_duration_penalty = 0,
          penalty_per_turn_from_legitimacy_war = 0,
          recovery_per_turn_after_legitimacy_war = 0,
          penalty_per_pretender = 0,
          incident_compensation_per_turn = 0,
          civilization_state_transition_cooldown_turns = 5,

          war_types = {
               "egyptian",
               "hatti",
          },

          incident_vfx_positive = "settlement_blessing",
          incident_vfx_negative = "settlement_disaster",
          incident_vfx_show_in_shroud = true,

          incidents = {
               [1] = {
                    name = "Earthquake",
                    civ_points_change = 0,
                    is_positive_with_0_points_change = false,
                    weight_per_civ_level = {
                         10, -- collapse
                         10, -- crisis
                         10, -- prosperity
                    },
                    bundle_keys = {
                         "phar_main_effect_bundle_incident_disaster_earthquake",
                    },
                    bundle_duration = 4,
                    event_info = {
                         title = "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_title",
                         primary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_earthquake_primary_detail",
                         secondary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_earthquake_secondary_detail_poc_update",
                         index = 5602,
                         persistent = true,
                    },
                    -- apply = function()
                    damage_amount_percentage = 20,
                    num_buildings_to_damage = 5, -- not counting main building
               },

               [2] = {
                    name = "Flood", -- All Group Templates
                    civ_points_change = 0,
                    is_positive_with_0_points_change = false,
                    weight_per_civ_level = {
                         10, -- collapse
                         10, -- crisis
                         10, -- prosperity
                    },
                    bundle_keys = {
                         "phar_main_effect_bundle_incident_disaster_flood",
                    },
                    bundle_duration = 4,
                    event_info = {
                         title = "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_title",
                         primary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_flood_primary_detail_poc_update",
                         secondary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_flood_secondary_detail_poc_update",
                         index = 5604,
                         persistent = true,
                    },
                    -- apply = function()
                    damage_amount_percentage = 40,
                    num_buildings_to_damage = 2, -- not counting main building
                    template_options = {
                         [1] = { weight = 10 },
                         [2] = { weight = 10 },
                         [3] = { weight = 10 },
                    },
               },

               [3] = {
                    name = "Drought", -- All Group Templates
                    civ_points_change = 0,
                    is_positive_with_0_points_change = false,
                    weight_per_civ_level = {
                         10, -- collapse
                         10, -- crisis
                         10, -- prosperity
                    },
                    bundle_keys = {
                         "phar_main_effect_bundle_incident_disaster_drought_food_production",
                         "phar_main_effect_bundle_incident_disaster_drought_growth",
                    },
                    bundle_duration = 4,
                    event_info = {
                         title = "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_title",
                         primary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_drought_primary_detail_poc_update",
                         secondary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_drought_secondary_detail_poc_update",
                         index = 5601,
                         persistent = true,
                    },
                    -- apply = function()
                    applicable_season_keys = {
                         "season_spring",
                         "season_summer",
                         "season_winter",
                         "season_autumn",
                         "season_high_tide",
                         "season_low_tide",
                    },
                    template_options = {
                         [1] = { weight = 10 },
                         [2] = { weight = 10 },
                         [3] = { weight = 10 },
                    },
               },

               [4] = {
                    name = "Plague", -- All Group Templates
                    civ_points_change = 0,
                    is_positive_with_0_points_change = false,
                    weight_per_civ_level = {
                         10, -- collapse
                         10, -- crisis
                         10, -- prosperity
                    },
                    bundle_keys = {
                         "phar_main_effect_bundle_incident_disaster_plague_growth",
                         "phar_main_effect_bundle_incident_disaster_plague_recruitment_slots",
                    },
                    bundle_duration = 4,
                    event_info = {
                         title = "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_title",
                         primary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_plague_primary_detail_poc_update",
                         secondary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_incident_plague_secondary_detail_poc_update",
                         index = 5606,
                         persistent = true,
                    },
                    -- apply = function()
                    template_options = {
                         [1] = { weight = 10 },
                         [2] = { weight = 10 },
                         [3] = { weight = 10 },
                    },
               },

               [5] = {
                    name = "Fertility", -- All Group Templates
                    civ_points_change = 0,
                    is_positive_with_0_points_change = true,
                    weight_per_civ_level = {
                         10, -- collapse
                         10, -- crisis
                         10, -- prosperity
                    },
                    bundle_keys = {
                         "phar_main_effect_bundle_incident_blessing_fertility",
                    },
                    bundle_duration = 4,
                    event_info = {
                         title = "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_blessing_title",
                         primary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_blessing_fertility_primary_detail_poc_update",
                         secondary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_blessing_fertility_secondary_detail_poc_update",
                         index = 5603,
                         persistent = true,
                    },
                    -- apply = function()
                    template_options = {
                         [1] = { weight = 10 },
                         [2] = { weight = 10 },
                         [3] = { weight = 10 },
                    },
               },

               [6] = {
                    name = "NaturesBounty", -- All Group Templates. Former "Blessings of the Nile"
                    civ_points_change = 0,
                    is_positive_with_0_points_change = true,
                    weight_per_civ_level = {
                         10, -- collapse
                         10, -- crisis
                         10, -- prosperity
                    },
                    bundle_keys = {
                         "phar_main_effect_bundle_incident_blessing_natures_bounty",
                    },
                    bundle_duration = 4,
                    event_info = {
                         title = "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_blessing_title",
                         primary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_natures_bounty_primary_detail_poc_update",
                         secondary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_natures_bounty_secondary_detail_poc_update",
                         index = 5605,
                         persistent = true,
                    },
                    -- apply = function()
                    template_options = {
                         [1] = { weight = 10 },
                         [2] = { weight = 10 },
                         [3] = { weight = 10 },
                    },
               },

               [7] = {
                    name = "WonderfulWeather", -- All Group Templates
                    civ_points_change = 0,
                    is_positive_with_0_points_change = true,
                    weight_per_civ_level = {
                         10, -- collapse
                         10, -- crisis
                         10, -- prosperity
                    },
                    bundle_keys = {
                         "phar_map_effect_bundle_incident_blessing_weather",
                    },
                    bundle_duration = 4,
                    event_info = {
                         title = "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_blessing_title",
                         primary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_wonderful_weather_primary_detail_poc_update",
                         secondary_detail =
                         "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_wonderful_weather_secondary_detail_poc_update",
                         index = 5605,
                         persistent = true,
                    },
                    -- apply = function()
                    template_options = {
                         [1] = { weight = 10 },
                         [2] = { weight = 10 },
                         [3] = { weight = 10 },
                    },
               },
          },

          -- A list of technologies that give additional points per PoC settlement owned by a faction with said technology.
          technologies = {
               -- Example use of a technology with key and bonus points.
               --[[
			[1] = {
				key = "phar_main_tech_civil_17_pillars_points",
				bonus_points_per_pillars_region_owned_by_faction_with_technology = 1,
				-- get_points = function(),
			},
			--]]
               -- add other technologies that affect the civilization level/points BELOW this line
          },

          landmark_buldings_bonus_key = "pillars_of_civilization_points",
          landmark_buldings = {
               "phar_main_all_landmark_legitimacy_influence_amarna_1",
          },

          red_crown = {
               ancillary_key = "phar_main_crown_deshret",
               civilization_meter_boost = 10,
          },

          ui = {
               settlement_bar_component_name = "icon_pillar_of_civilization",
               settlement_bar_icon_path = "UI/skins/default/settlement_id/phar_main_icon_cult_center.png",
               settlement_bar_icon_tooltip = "phar_main_pilllar_of_civilization_city_info_bar_tooltip",
               rebels_icon_path = "UI/Buildings/Icons/phar_main_building_icon_main_ruins.png",

               tooltip_layout_path = "UI/Campaign UI/tooltip_pillars_of_civilization",

               component_ids = {
                    -- component names in "faction_widget_phar" layout:
                    pillars_tracker = "pillars_tracker",
                    panel_frame = "poc_frame",
                    civilization_tracker = "pillars_tracker_pointer",

                    -- component names in "poc_panel" layout:
                    panel = "poc_panel",
                    tracker_container = "pillars_tracker",
                    tracker_pointer = "pillars_tracker_pointer",
                    title_with_states = "poc_states",
                    remaining_turns = "dy_turns",
                    total_points = "dy_score",
                    chances_container = "predicted_events",
                    blessing_chance = "dy_blessing_chance",
                    disaster_chance = "dy_disaster_chance",
                    point_source_empty = "empty_list_message",
                    point_source_template = "poc_points_template",
                    points_source_text = "dy_points_source",
                    points_source_points = "dy_points",
                    points_source_icon = "modifier_icon",
                    points_source_icon_level_container = "BuildingFrame",
                    points_source_icon_level = "building_level",
                    incident_parent = "active_events",
                    incident_effect_duration = "dy_effect_duration",
                    ongoing_incident_name_text = "dy_event_name",
                    ongoing_incident_blessing_or_disaster_text = "dy_event_type",
                    ongoing_incident_realm_name = "dy_realm_name",
                    incident_effects_list = "events_effects_list",
                    effect_template_incident = "effect_template_incident",
                    regions_list = "list_box",
                    realm_template = "row_header",
                    realm_name_text = "dy_realm_name",
                    province_template = "province_template",
                    province_template_faction_flag = "mon",
                    province_name_text = "dy_province_name",

                    factions_effects_list = "global_events_holder",
                    own_faction_picture = "dy_culture",
                    own_faction_name = "dy_culture_name",
                    effect_template_own_faction = "effect_template_dy_culture",
                    effect_template_nomads = "effect_template_nomads",
                    effect_template_sea_peoples = "effect_template_sea_peoples",

                    forecast_panel = "forecast_panel",
                    button_toggle_forecast_panel = "button_toggle_forecast_panel",
                    forecast_blessing_chance = "value_blessing",
                    forecast_disaster_chance = "value_disaster",
                    forecast_effects_container = "container_effect_bundles",

                    -- shared components names
                    effect_icon = "dy_effect_icon",
                    effect_name = "dy_effect_name",
               },

               text_ids = {
                    incident_duration = "phar_pillars_civilization_incident_duration",
                    blessing = "phar_pillars_civilization_blessing",
                    disaster = "phar_pillars_civilization_disaster",
                    num_points = "phar_pillars_civilization_num_points",
                    total_points = "phar_pillars_civilization_total_points",
                    building_points = "phar_pillars_civilization_building_points",
                    landmark_building_points = "phar_pillars_civilization_landmark_building_points",
                    war_penalty_recent = "phar_pillars_civilization_war_penalty_recent",
                    war_penalty_ongoing = "phar_pillars_civilization_war_penalty_ongoing",
                    pretenders_penalty = "phar_pillars_civilization_pretenders_penalty",
                    technology_points = "phar_pillars_civilization_technology_points",
                    cheat_points = "phar_pillars_civilization_cheat_points",
                    ancillary_points = "phar_pillars_civilization_ancillary_points",
                    civilization_level_prefix = "civilization_level_",
                    incident_wonderful_weather = "phar_pillars_civilization_incident_wonderful_weather",
                    incident_natures_bounty = "phar_pillars_civilization_incident_natures_bounty",
                    incident_drought = "phar_pillars_civilization_incident_drought",
                    incident_earthquake = "phar_pillars_civilization_incident_earthquake",
                    incident_fertility = "phar_pillars_civilization_incident_fertility",
                    incident_flood = "phar_pillars_civilization_incident_flood",
                    incident_plague = "phar_pillars_civilization_incident_plague",
               },

               changed_civilization_level_message = {
                    title = "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_change_title",
                    primary_detail =
                    "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_change_primary_detail_",
                    secondary_detail =
                    "event_feed_strings_text_phar_event_feed_string_pillars_of_civilization_change_secondary_detail",
                    pic = 5600,
                    show_immediately = true,
               },
          },
     },

     persistent = {
          -- here -1 means not calculated yet
          current_meter = -1,
          breakdown_cities_and_points_per_level = {},
          wars = {
               -- example format:
               --[1] = {
               --	name = "Egyptian",
               --	war_duration_penalty = 0,
               --	recovering_from_war = false,
               --},
          },
          -- -1 means no incident is currently active
          current_incident_index = -1,
          turn_last_incident_was_spawned = -1,
          turn_last_civilization_state_transition_occurred = 0,
          incident_meter = 0,
          pretenders_meter = 0,
          commands_meter_sources = {}, -- Table of format { text_id = number_of_points, ... }
          landmark_buildings_meter = 0,
          landmark_buildings_count = 0,
          technology_points = 0,
          ancillary_points = 0,
          -- if we have cheats enabled this tracks how many cheat points have been added/subtracted to the real civilization meter
          cheat_meter_points = nil,
          is_system_enabled = true,
          is_hidden_by_ui_override = false,
          earthquake_region_hit_name = "",
          disabled_incident_names = {
               -- example format:
               -- "Earthquake",
               -- "Flood",
               -- "Fertility",
          },
          red_crown_wearer_cqi = -1,
          overriding_level_effect_bundles = {}, -- Table with keys being faction keys and table obj: { level_bundles = { level_name = bundle_key, ... }, remaining_turns = 6 }
          chosen_template_index = 0,
          visual_level_override_index = 0, -- Override the actual PoC level only for the visuals on the campaign map. 0-3, 0 means no override.
     },

     --here -1 means not calculated yet
     current_level_index = -1,
     panel_is_shown = false,
     point_sources_list_is_empty = true,
     component_cache = {
     },
     effect_bundle_icon_path = "UI/Campaign UI/Effect_bundles/",
     faction_picture_path = "UI/skins/default/maat/banners/",

     --------------------------------------------------
     --------------------------------------------------
     -- functions

     -- a little helper method
     max_civilization_meter = function()
          return pillars_civilization.config.points_per_level[5] * #pillars_civilization.config.regions
     end,

     get_incident_localization_key = function(incident_name)
          if incident_name == "Earthquake" then
               return pillars_civilization.config.ui.text_ids.incident_earthquake
          elseif incident_name == "Flood" then
               return pillars_civilization.config.ui.text_ids.incident_flood
          elseif incident_name == "Drought" then
               return pillars_civilization.config.ui.text_ids.incident_drought
          elseif incident_name == "Plague" then
               return pillars_civilization.config.ui.text_ids.incident_plague
          elseif incident_name == "Fertility" then
               return pillars_civilization.config.ui.text_ids.incident_fertility
          elseif incident_name == "NaturesBounty" then
               return pillars_civilization.config.ui.text_ids.incident_natures_bounty
          elseif incident_name == "WonderfulWeather" then
               return pillars_civilization.config.ui.text_ids.incident_wonderful_weather
          else
               output("ERROR @ pillars_civilization.get_incident_localization_key() - invalid incident name '" ..
               incident_name .. "'!")
          end
     end,

     get_incident_index_by_event_name = function(incident_event_name)
          -- design naming discrepancy: both "Sea Storm" and "Flood" are implemented as "Flood"s in the code
          for incident_index, incident in ipairs(pillars_civilization.config.incidents) do
               if incident.incident_event_name == incident_event_name then
                    return incident_index
               end
          end
     end,

     get_localized_civilization_level_name_text_and_source = function(civilization_level_name)
          local civilization_key = pillars_civilization.config.ui.text_ids.civilization_level_prefix ..
          civilization_level_name
          return get_localised_random_string_and_source(civilization_key)
     end,

     is_nomad_or_sea_peoples_faction = function(faction_key)
          return is_sea_playable_faction(faction_key) or pillars_civilization.is_nomad_faction(faction_key) or
          pillars_civilization.is_sea_peoples_faction(faction_key)
     end,

     is_nomad_faction = function(faction_key)
          return table_find(pillars_civilization.config.nomads_factions, faction_key, false) ~= nil
     end,

     is_sea_peoples_faction = function(faction_key)
          return table_find(pillars_civilization.config.sea_peoples_factions, faction_key, false) ~= nil
     end,

     --------------------------------------------------
     -- HUD UI functions

     init_ui = function()
          if not core.ui_is_created or not is_function(core.get_ui_root) then
               output("ERROR @ pillars_civilization.init_ui() - ui hasn't been created yet.")
               return
          end

          pillars_civilization.cache_components()

          if not pillars_civilization.component_cache.civilization_container_component then
               output("ERROR @ pillars_civilization.init_ui() - the civilization container component was not found!")
               return
          end

          local civilization_container_component = pillars_civilization.component_cache.civilization_container_component

          local is_system_enabled = pillars_civilization.persistent.is_system_enabled
          civilization_container_component:SetVisible(is_system_enabled)
          uim:override("hide_pillars_tracker"):set_allowed(is_system_enabled);
          if not is_system_enabled then
               return
          end

          pillars_civilization.init_civilization_tracker()

          pillars_civilization.init_civilization_tooltip()

          pillars_civilization.update_ui()

          pillars_civilization.update_all_settlement_info_bars()
     end,

     --- @function cache_components
     --- @desc a helper function that caches components upfront for smoother retrieval later on
     cache_components = function()
          local civilization_container_component = core:get_ui_root():SequentialFind(pillars_civilization.config.ui
          .component_ids.pillars_tracker)
          pillars_civilization.component_cache.civilization_container_component = civilization_container_component

          local civilization_tracker_component = civilization_container_component:SequentialFind(pillars_civilization
          .config.ui.component_ids.civilization_tracker)
          pillars_civilization.component_cache.civilization_tracker_component = civilization_tracker_component
     end,

     on_open_panel = function()
          pillars_civilization.panel_is_shown = true

          pillars_civilization.component_cache.civilization_panel_component = core:get_ui_root():SequentialFind(
          pillars_civilization.config.ui.component_ids.panel)
          pillars_civilization.component_cache.forecast_panel_component = pillars_civilization.component_cache
          .civilization_panel_component:SequentialFind(pillars_civilization.config.ui.component_ids.forecast_panel)

          core:add_listener(
               "pillars_civilization_panel_ComponentLClickUp",
               "ComponentLClickUp",
               function(context) return context.string ==
                    pillars_civilization.config.ui.component_ids.button_toggle_forecast_panel end,
               function(context)
                    pillars_civilization.toggle_forecast_panel()
               end,
               true
          )

          pillars_civilization.update_ui_panel()
     end,

     on_close_panel = function()
          pillars_civilization.panel_is_shown = false

          core:remove_listener("pillars_civilization_panel_ComponentLClickUp")
     end,

     --- @function init_civilization_tooltip
     --- @desc attaches tooltip to civilization_container_component, which must have the "ScriptPopulatedTooltip" callback for this to work
     init_civilization_tooltip = function()
          local tooltip_holder_component = pillars_civilization.component_cache.civilization_container_component
          tooltip_holder_component:InterfaceFunction("set_tooltip_path",
               pillars_civilization.config.ui.tooltip_layout_path)

          local tooltip_component = tooltip_holder_component:SequentialFind(tooltip_holder_component:Id() .. "_tooltip")
          pillars_civilization.component_cache.civilization_tooltip_component = tooltip_component

          for i = 1, #pillars_civilization.config.levels do
               local level = pillars_civilization.config.levels[i]
               local points_range_component = tooltip_component:SequentialFind("dy_" .. level.name .. "_range")
               if points_range_component then
                    points_range_component:SetText(pillars_civilization.get_level_points_range_text(i))
               end
          end
     end,

     init_civilization_tracker = function()
          pillars_civilization.add_civilization_tracker_listeners()

          -- Initial state of meter is contracted
          pillars_civilization.set_civilization_tracker_expanded_state(false)
     end,

     add_civilization_tracker_listeners = function()
          -- Add listeners for opening/closing of the panel
          core:add_listener(
               "poc_panel_opened",
               "PanelOpenedCampaign",
               function(context)
                    return context.string == pillars_civilization.config.ui.component_ids.panel
               end,
               function(context)
                    pillars_civilization.on_open_panel()
               end,
               true, true
          )

          core:add_listener(
               "poc_panel_closed",
               "PanelClosedCampaign",
               function(context)
                    return context.string == pillars_civilization.config.ui.component_ids.panel
               end,
               function(context)
                    pillars_civilization.on_close_panel()
               end,
               true, true
          )
     end,

     remove_civilization_tracker_listeners = function()
          core:remove_listener("poc_panel_opened")
          core:remove_listener("poc_panel_closed")
     end,

     update_ui = function()
          pillars_civilization.update_civilization_tracker()
          pillars_civilization.update_civilization_tooltip()
     end,

     update_civilization_tracker = function()
          -- update picture representing the current civilization level (state)
          local civilization_container_component = pillars_civilization.component_cache.civilization_container_component
          if civilization_container_component then
               local is_system_visible = cm:model():turn_number() >=
               feature_unlock.get_feature_unlock_turn_for_faction(cm:get_local_faction_name(true),
                    feature_ids_config.pillars_of_civilization)
               local is_system_enabled = pillars_civilization.persistent.is_system_enabled
               local is_hidden_by_ui_override = pillars_civilization.persistent.is_hidden_by_ui_override

               local tracker_is_visible = is_system_visible and is_system_enabled and not is_hidden_by_ui_override
               uim:override("hide_pillars_tracker"):set_allowed(tracker_is_visible);

               if tracker_is_visible then
                    local current_level = pillars_civilization.config.levels[pillars_civilization.current_level_index]
                    civilization_container_component:SetState(current_level.name)
               end
          end

          -- update tracker
          local civilization_tracker_component = pillars_civilization.component_cache.civilization_tracker_component
          if civilization_tracker_component then
               pillars_civilization.update_tracker(civilization_tracker_component)
          end
     end,

     update_tracker = function(pointer_component)
          -- calculate the width of the central level in civ points
          local levels = pillars_civilization.config.levels
          local central_level_index = math.ceil(#levels / 2)
          local cental_level_min = levels[central_level_index].lower_bound
          local cental_level_max = levels[central_level_index + 1].lower_bound
          local cental_level_points = cental_level_max - cental_level_min

          -- calculate range of visible civ points and clamp current_meter in this range
          -- range contains the central level and bands of the same width from left and right
          local displayed_points_min = cental_level_min - cental_level_points
          local displayed_points_max = cental_level_max + cental_level_points
          local displayed_points = math.clamp(pillars_civilization.persistent.current_meter, displayed_points_min,
               displayed_points_max)

          -- set pointer's position on the bar according to the clamped displayed_points
          local parent_width, _ = UIComponent(pointer_component:Parent()):Dimensions()
          local width, _ = pointer_component:Dimensions()
          local pixels_per_point = parent_width / (displayed_points_max - displayed_points_min)
          local x = (displayed_points - displayed_points_min) * pixels_per_point - 0.5 * width
          local _, y_orig = pointer_component:GetDockOffset()
          pointer_component:SetDockOffset(math.round(x), y_orig)
     end,

     update_civilization_tooltip = function()
          local tooltip_component = pillars_civilization.component_cache.civilization_tooltip_component
          if not tooltip_component then
               return
          end

          local current_level = pillars_civilization.config.levels[pillars_civilization.current_level_index]

          -- Update state of score container
          local score_container_component = tooltip_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.title_with_states)
          score_container_component:SetState(current_level.name)

          -- Update current score (points)
          local score_component = score_container_component:SequentialFind(pillars_civilization.config.ui.component_ids
          .total_points)
          local points_str, points_src = get_localised_text_replacement_and_source_formatted(
          pillars_civilization.config.ui.text_ids.num_points, pillars_civilization.persistent.current_meter)
          score_component:SetText(points_str, points_src)
     end,

     ui_panel_is_visible = function()
          local civilization_panel_component = pillars_civilization.component_cache.civilization_panel_component
          return civilization_panel_component:Visible()
     end,

     update_ui_panel = function()
          local civilization_panel_component = pillars_civilization.component_cache.civilization_panel_component
          local current_level = pillars_civilization.config.levels[pillars_civilization.current_level_index]

          -- update panel frame
          local panel_frame_component = civilization_panel_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.panel_frame)
          panel_frame_component:SetState(current_level.name)

          -- update tracker
          local tracker_container_component = civilization_panel_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.tracker_container)
          local tracker_pointer_component = tracker_container_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.tracker_pointer)
          pillars_civilization.update_tracker(tracker_pointer_component)

          -- update level title
          local title_with_states_component = tracker_container_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.title_with_states)
          title_with_states_component:SetState(current_level.name)

          -- update turns remaining till civilization transition can happen
          local turns_component = tracker_container_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.remaining_turns)
          local remaining_turns = pillars_civilization.get_remaining_turns_until_civilization_transition_can_happen()
          turns_component:SetText(tostring(remaining_turns))
          turns_component:SetVisible(remaining_turns > 0)

          -- update total points
          local total_points_component = tracker_container_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.total_points)
          total_points_component:SetState("default") -- restore state which is broken from changing the state of title_with_states_component
          total_points_component:SetText(tostring(pillars_civilization.persistent.current_meter))

          -- update point sources
          pillars_civilization.update_ui_panel_point_sources()

          -- update blessing and disaster chances
          local chances_container_component = civilization_panel_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.chances_container)
          local current_incident = pillars_civilization.get_current_incident()
          if not current_incident then
               chances_container_component:SetVisible(true)

               local blessing_chance_text, disaster_chance_text = pillars_civilization
               .get_blessing_and_disaster_chances_texts(pillars_civilization.current_level_index)

               local blessing_chance_component = chances_container_component:SequentialFind(pillars_civilization.config
               .ui.component_ids.blessing_chance)
               blessing_chance_component:SetText(blessing_chance_text)

               local disaster_chance_component = chances_container_component:SequentialFind(pillars_civilization.config
               .ui.component_ids.disaster_chance)
               disaster_chance_component:SetText(disaster_chance_text)
          else
               chances_container_component:SetVisible(false)
          end

          -- update current incident
          pillars_civilization.update_ui_panel_incident()

          -- update effects for own faction, nomads and sea peoples
          pillars_civilization.update_ui_panel_faction_effects()
     end,

     ui_panel_add_point_source_entry = function(container, template, points, text, building_level)
          local source_entry = UIComponent(container:CreateFromComponent(template:Address(),
               string.format("point_source_%d", building_level)))
          source_entry:SetVisible(true)

          local text_component = source_entry:SequentialFind(pillars_civilization.config.ui.component_ids
          .points_source_text)
          text_component:SetText(text)

          local points_component = source_entry:SequentialFind(pillars_civilization.config.ui.component_ids
          .points_source_points)
          points_component:SetState(points > 0 and "positive" or "negative")
          points_component:SetText((points > 0 and "+" or "") .. tostring(points))

          local icon_component = source_entry:SequentialFind(pillars_civilization.config.ui.component_ids
          .points_source_icon)
          icon_component:SetState(points > 0 and "building" or "negative")

          if building_level > 0 then
               local level_container_component = source_entry:SequentialFind(pillars_civilization.config.ui
               .component_ids.points_source_icon_level_container)
               level_container_component:SetVisible(true)

               local level_component = level_container_component:SequentialFind(pillars_civilization.config.ui
               .component_ids.points_source_icon_level)
               level_component:SetText(tostring(building_level))
          end

          pillars_civilization.point_sources_list_is_empty = false
     end,

     update_ui_panel_point_sources = function()
          local civilization_panel_component = pillars_civilization.component_cache.civilization_panel_component
          local empty_list_message_component = civilization_panel_component:SequentialFind(pillars_civilization.config
          .ui.component_ids.point_source_empty)
          local point_source_template = civilization_panel_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.point_source_template)
          local point_sources_container = UIComponent(point_source_template:Parent())

          point_source_template:SetVisible(false)

          -- Clean previus points-source entries
          point_source_template:DivorceFromParent()
          point_sources_container:DestroyChildren()
          point_sources_container:Adopt(point_source_template:Address())

          pillars_civilization.point_sources_list_is_empty = true

          -- Create entries for points coming from buildings
          for i = 0, #pillars_civilization.persistent.breakdown_cities_and_points_per_level do
               local level = pillars_civilization.persistent.breakdown_cities_and_points_per_level[i]
               if level.cities_by_level > 0 and level.points_by_level ~= 0 then
                    local entry_text = get_localised_text_replacement_and_source_formatted(
                    pillars_civilization.config.ui.text_ids.building_points, level.cities_by_level, i)
                    pillars_civilization.ui_panel_add_point_source_entry(point_sources_container, point_source_template,
                         level.points_by_level, entry_text, i)
               end
          end

          -- Create entry for points coming from landmark buildings
          local landmark_points = pillars_civilization.persistent.landmark_buildings_meter or 0
          if landmark_points > 0 then
               local buldings_count = pillars_civilization.persistent.landmark_buildings_count;
               local entry_text = get_localised_text_replacement_and_source_formatted(
               pillars_civilization.config.ui.text_ids.landmark_building_points, buldings_count)
               pillars_civilization.ui_panel_add_point_source_entry(point_sources_container, point_source_template,
                    landmark_points, entry_text, 0)
          end

          -- Create entry for points coming from technologies
          local tech_points = pillars_civilization.persistent.technology_points
          if tech_points > 0 then
               local entry_text = get_localised_text_replacement(pillars_civilization.config.ui.text_ids
               .technology_points)
               pillars_civilization.ui_panel_add_point_source_entry(point_sources_container, point_source_template,
                    tech_points, entry_text, 0)
          end

          -- Create entry for points coming from ancillaries
          local ancillary_points = pillars_civilization.persistent.ancillary_points
          if ancillary_points > 0 then
               local entry_text = get_localised_text_replacement(pillars_civilization.config.ui.text_ids
               .ancillary_points)
               pillars_civilization.ui_panel_add_point_source_entry(point_sources_container, point_source_template,
                    ancillary_points, entry_text, 0)
          end

          -- Create entries for points coming from Commands
          for entry_text_id, entry_points in pairs(pillars_civilization.persistent.commands_meter_sources) do
               if entry_points ~= 0 then
                    local entry_text = get_localised_text_replacement(entry_text_id)
                    pillars_civilization.ui_panel_add_point_source_entry(point_sources_container, point_source_template,
                         entry_points, entry_text, 0)
               end
          end

          -- Create entries for points coming from war
          for _, war in ipairs(pillars_civilization.persistent.wars) do
               if war.war_duration_penalty ~= 0 then
                    local entry_text = war.recovering_from_war and
                        get_localised_text_replacement(pillars_civilization.config.ui.text_ids.war_penalty_recent)
                        or get_localised_text_replacement(pillars_civilization.config.ui.text_ids.war_penalty_ongoing)
                    pillars_civilization.ui_panel_add_point_source_entry(point_sources_container, point_source_template,
                         -war.war_duration_penalty, entry_text, 0)
               end
          end

          -- Create entry for penalty points coming from pretenders
          if pillars_civilization.persistent.pretenders_meter ~= 0 then
               local entry_text = get_localised_text_replacement(pillars_civilization.config.ui.text_ids
               .pretenders_penalty)
               pillars_civilization.ui_panel_add_point_source_entry(point_sources_container, point_source_template,
                    -pillars_civilization.persistent.pretenders_meter, entry_text, 0)
          end

          -- deprecated because by latest design, incidents do not affect the Civilization meter
          --if pillars_civilization.persistent.incident_meter ~= 0 then
          --	result = result .. ((pillars_civilization.is_incident_negative(pillars_civilization.get_current_incident()) and "") or "+") .. pillars_civilization.persistent.incident_meter .. " due to " .. pillars_civilization.get_current_incident().name .. ";\n"
          --end

          -- Create entry for points coming from cheats
          if pillars_civilization.persistent.cheat_meter_points and pillars_civilization.persistent.cheat_meter_points ~= 0 then
               local entry_text = get_localised_text_replacement(pillars_civilization.config.ui.text_ids.cheat_points)
               pillars_civilization.ui_panel_add_point_source_entry(point_sources_container, point_source_template,
                    pillars_civilization.persistent.cheat_meter_points, entry_text, 0)
          end

          if empty_list_message_component then
               empty_list_message_component:SetVisible(pillars_civilization.point_sources_list_is_empty)
          end
     end,

     does_effect_bundle_have_any_effect = function(effect_bundle)
          local effects = effect_bundle:effects()
          local num_effects = effects:num_items()
          if num_effects > 0 then
               for i = 0, num_effects - 1 do
                    local effect = effects:item_at(i)
                    if effect:value() ~= 0 then
                         return true
                    end
               end
          end

          return false
     end,

     update_ui_panel_faction_effect = function(faction_key, effect_bundle_key, effect_component)
          local effect_bundle = cm:clone_or_create_custom_effect_bundle(faction_key, effect_bundle_key)

          if pillars_civilization.does_effect_bundle_have_any_effect(effect_bundle) then
               local effect_template_icon_component = effect_component:SequentialFind(pillars_civilization.config.ui
               .component_ids.effect_icon)

               if effect_bundle and is_function(effect_bundle.icon_path) then
                    local bundle_icon_path = pillars_civilization.effect_bundle_icon_path .. effect_bundle:icon_path()
                    effect_template_icon_component:SetImagePath(bundle_icon_path)
               end

               -- set an Effect-Visualization component as tooltip to the effect component
               effect_component:SetVisible(true)
               effect_component:SetTooltipText("{{tt:ui/common ui/tooltip_effects_container}}", true)
               effect_component:SetContextObject(cco("CcoEffectBundle", effect_bundle_key))
          else
               effect_component:SetVisible(false)
          end
     end,

     update_ui_panel_faction_effects = function()
          local civilization_panel_component = pillars_civilization.component_cache.civilization_panel_component
          if not civilization_panel_component then
               return
          end

          local factions_effects_list_component = civilization_panel_component:SequentialFind(pillars_civilization
          .config.ui.component_ids.factions_effects_list)

          pillars_civilization.update_faction_effects(pillars_civilization.current_level_index,
               factions_effects_list_component, true)
     end,

     update_faction_effects = function(civ_level_index, factions_effects_list_component, update_own_faction_pic)
          -- populate own faction's effect
          local own_faction = cm:get_local_faction(true)
          local own_faction_effect_bundle_key = pillars_civilization.get_level_effect_bundle_key(civ_level_index,
               own_faction:name())
          local effect_template_own_faction_component = factions_effects_list_component:SequentialFind(
          pillars_civilization.config.ui.component_ids.effect_template_own_faction)
          pillars_civilization.update_ui_panel_faction_effect(own_faction:name(), own_faction_effect_bundle_key,
               effect_template_own_faction_component)

          -- populate own faction's name and picture
          local own_faction_name_component = factions_effects_list_component:SequentialFind(pillars_civilization.config
          .ui.component_ids.own_faction_name)
          own_faction_name_component:SetText(own_faction:localised_display_name())

          if update_own_faction_pic then
               local own_faction_pic_component = factions_effects_list_component:SequentialFind(pillars_civilization
               .config.ui.component_ids.own_faction_picture)
               own_faction_pic_component:SetImagePath(pillars_civilization.faction_picture_path ..
               own_faction:name() .. ".png")
          end

          -- populate the Nomads effect
          local effect_template_nomads_component = factions_effects_list_component:SequentialFind(pillars_civilization
          .config.ui.component_ids.effect_template_nomads)
          local nomad_faction_key = pillars_civilization.config.nomads_factions[1]
          local nomads_effect_bundle_key = pillars_civilization.get_level_effect_bundle_key(civ_level_index,
               nomad_faction_key)
          pillars_civilization.update_ui_panel_faction_effect(nomad_faction_key, nomads_effect_bundle_key,
               effect_template_nomads_component)

          -- populate the Sea-Peoples effect
          local effect_template_sea_peoples_component = factions_effects_list_component:SequentialFind(
          pillars_civilization.config.ui.component_ids.effect_template_sea_peoples)
          local sea_peoples_faction_key = pillars_civilization.config.sea_peoples_factions[1]
          local sea_peoples_effect_bundle_key = pillars_civilization.get_level_effect_bundle_key(civ_level_index,
               sea_peoples_faction_key)
          pillars_civilization.update_ui_panel_faction_effect(sea_peoples_faction_key, sea_peoples_effect_bundle_key,
               effect_template_sea_peoples_component)
     end,

     update_ui_panel_incident = function()
          local civilization_panel_component = pillars_civilization.component_cache.civilization_panel_component
          if not civilization_panel_component then
               return
          end

          local incident_parent_component = civilization_panel_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.incident_parent)
          local current_incident = pillars_civilization.get_current_incident()
          if not current_incident then
               incident_parent_component:SetVisible(false)
               return
          end

          incident_parent_component:SetVisible(true)
          if not current_incident or not is_table(current_incident.bundle_keys) or table.is_empty(current_incident.bundle_keys) then
               output("ERROR @ pillars_civilization.update_ui_panel_incident() - Invalid incident!")
               return
          end

          ----------------------------------------------
          -- update ui incident name, type, realm and duration
          local incident_name_component = incident_parent_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.ongoing_incident_name_text)
          local incident_title_localized_text, incident_title_localized_source = get_localised_random_string_and_source(
          pillars_civilization.get_incident_localization_key(current_incident.name))
          incident_name_component:SetText(incident_title_localized_text, incident_title_localized_source)

          local incident_type_component = incident_parent_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.ongoing_incident_blessing_or_disaster_text)
          local incident_type_text = ""
          local incident_type_source = ""
          if pillars_civilization.is_incident_negative(current_incident) then
               incident_type_text, incident_type_source = get_localised_text_replacement_and_source(pillars_civilization
               .config.ui.text_ids.disaster)
          else
               incident_type_text, incident_type_source = get_localised_text_replacement_and_source(pillars_civilization
               .config.ui.text_ids.blessing)
          end
          incident_type_component:SetText(incident_type_text, incident_type_source)

          local affected_region_keys = pillars_civilization.get_incident_affected_regions(current_incident)
          local first_affected_region_key = ""
          local first_affected_region = nil
          local first_affected_region_faction_key = ""
          local first_affected_province = nil

          -- Try to find a region not owned by rebels. We need a valid faction to get bundle interfaces further below, in order to get the icon paths from them.
          for i, region_key in ipairs(affected_region_keys) do
               local region = cm:get_region(region_key)
               if region:owning_faction():name() ~= "rebels" then
                    first_affected_region_key = region_key
                    first_affected_region = region
                    first_affected_region_faction_key = region:owning_faction():name()
                    first_affected_province = region:province()
                    break
               end
          end

          local incident_realm_component = incident_parent_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.ongoing_incident_realm_name)
          local realm_key = phar_realms.get_realm_for_region(first_affected_region_key)
          incident_realm_component:SetText(get_localised_random_string_and_source(realm_key))

          local incident_effect_duration_component = incident_parent_component:SequentialFind(pillars_civilization
          .config.ui.component_ids.incident_effect_duration)
          incident_effect_duration_component:SetText(get_localised_text_replacement_and_source_formatted(
          pillars_civilization.config.ui.text_ids.incident_duration,
               pillars_civilization.get_current_incident_remaining_turns()))

          -------------------------------------------
          -- populate the incident's effects
          local incident_effects_list_component = incident_parent_component:SequentialFind(pillars_civilization.config
          .ui.component_ids.incident_effects_list)
          local incident_effect_template_component = incident_parent_component:SequentialFind(pillars_civilization
          .config.ui.component_ids.effect_template_incident)
          if not incident_effect_template_component then
               output("pillars_civilization.update_ui_panel_incident: incident effect template component is invalid!")
               return
          end

          incident_effect_template_component:DivorceFromParent()
          incident_effects_list_component:DestroyChildren()

          for i, bundle_key in ipairs(current_incident.bundle_keys) do
               local incident_effect_component = UIComponent(incident_effects_list_component:CreateFromComponent(
               incident_effect_template_component:Address(), string.format("effect_%d", i)))

               local incident_effect_icon_component = incident_effect_component:SequentialFind(pillars_civilization
               .config.ui.component_ids.effect_icon)
               local incident_effect_name_component = incident_effect_component:SequentialFind(pillars_civilization
               .config.ui.component_ids.effect_name)

               local bundle_localized_title_text, bundle_localized_title_source =
               common.get_localised_string("effect_bundles_localised_title_" .. bundle_key),
                   "effect_bundles_localised_title_" .. bundle_key
               incident_effect_name_component:SetText(bundle_localized_title_text, bundle_localized_title_source)

               -- To get the icon, we need a bundle interface. We try to get it from the first affected region's faction, if it exists, otherwise from the region itself.
               local incident_effect_bundle = first_affected_province:get_effect_bundle(bundle_key,
                    first_affected_region_faction_key)
               if (not incident_effect_bundle) or (not is_function(incident_effect_bundle.icon_path)) then
                    incident_effect_bundle = first_affected_region:get_effect_bundle(bundle_key)
               end
               if incident_effect_bundle and is_function(incident_effect_bundle.icon_path) then
                    local bundle_icon_path = pillars_civilization.effect_bundle_icon_path ..
                    incident_effect_bundle:icon_path()
                    incident_effect_icon_component:SetImagePath(bundle_icon_path)
               end

               -- set an Effect-Visualization component as tooltip to the incident component
               incident_effect_component:SetVisible(true)
               incident_effect_component:SetTooltipText("{{tt:ui/common ui/tooltip_effects_container}}", true)
               incident_effect_component:SetContextObject(cco("CcoEffectBundle", bundle_key))
          end

          -------------------------------------------
          -- update ui incident affected regions list
          local incident_regions_list_component = incident_parent_component:SequentialFind(pillars_civilization.config
          .ui.component_ids.regions_list)

          local realm_template_component = incident_regions_list_component:SequentialFind(pillars_civilization.config.ui
          .component_ids.realm_template)
          if not realm_template_component and not pillars_civilization.component_cache.realm_template then
               output("pillars_civilization.update_ui_panel_incident: realm effect template component is invalid!")
               return
          end

          local province_template_component = incident_regions_list_component:SequentialFind(pillars_civilization.config
          .ui.component_ids.province_template)
          if not province_template_component and not pillars_civilization.component_cache.province_template then
               output("pillars_civilization.update_ui_panel_incident: province effect template component is invalid!")
               return
          end

          if not pillars_civilization.component_cache.realm_template then
               pillars_civilization.component_cache.realm_template = realm_template_component
               realm_template_component:DivorceFromParent()
          end

          if not pillars_civilization.component_cache.province_template then
               pillars_civilization.component_cache.province_template = province_template_component
               province_template_component:DivorceFromParent()
          end

          incident_regions_list_component:DestroyChildren()

          -- Create a UI component for each province and assign it to the header component for the province's realm, creating it if it doesn't exist
          local affected_province_keys = pillars_civilization.get_incident_affected_provinces(current_incident)
          for _, province_key in ipairs(affected_province_keys) do
               local province = cm:get_province(province_key)
               local first_region = province:regions():item_at(0)
               local realm_key = phar_realms.get_realm_for_region(first_region:name())
               local realm_component = incident_regions_list_component:SequentialFind(realm_key)

               if not realm_component then
                    realm_component = UIComponent(incident_regions_list_component:CreateFromComponent(
                    pillars_civilization.component_cache.realm_template:Address(), realm_key))
                    realm_component:SetVisible(true)

                    local realm_name_component = realm_component:SequentialFind(pillars_civilization.config.ui
                    .component_ids.realm_name_text)
                    realm_name_component:SetText(get_localised_random_string_and_source(realm_key))
               end

               local province_component = UIComponent(incident_regions_list_component:CreateFromComponent(
               pillars_civilization.component_cache.province_template:Address(), province_key))
               province_component:SetVisible(true)

               local province_name_component = province_component:SequentialFind(pillars_civilization.config.ui
               .component_ids.province_name_text)
               local province_name_localized_text, province_name_localized_source =
               common.get_localised_string("provinces_onscreen_" .. province_key), "provinces_onscreen_" .. province_key
               province_name_component:SetText(province_name_localized_text, province_name_localized_source)

               realm_component:InterfaceFunction("add_item", province_component:Address())
          end

          incident_regions_list_component:Layout()
     end,

     toggle_forecast_panel = function()
          local forecast_panel = pillars_civilization.component_cache.forecast_panel_component
          forecast_panel:SetVisible(not forecast_panel:Visible())

          if forecast_panel:Visible() then
               pillars_civilization.update_forecast_panel()
          end
     end,

     update_forecast_panel = function()
          local forecast_panel = pillars_civilization.component_cache.forecast_panel_component
          local current_level = pillars_civilization.config.levels[pillars_civilization.current_level_index]

          -- update panel frame
          forecast_panel:SetState(current_level.name)

          for i = 1, #pillars_civilization.config.levels do
               local level = pillars_civilization.config.levels[i]
               local level_container = forecast_panel:SequentialFind("panel_" .. level.name)
               if level_container then
                    -- Update civ level's points range
                    local points_range_component = level_container:SequentialFind("treshold")
                    if points_range_component then
                         points_range_component:SetText(pillars_civilization.get_level_points_range_text(i))
                    end

                    -- Update civ level's blessing and disaster chances
                    local blessing_chance_text, disaster_chance_text = pillars_civilization
                    .get_blessing_and_disaster_chances_texts(i)

                    local blessing_chance_component = level_container:SequentialFind(pillars_civilization.config.ui
                    .component_ids.forecast_blessing_chance)
                    blessing_chance_component:SetText(blessing_chance_text)

                    local disaster_chance_component = level_container:SequentialFind(pillars_civilization.config.ui
                    .component_ids.forecast_disaster_chance)
                    disaster_chance_component:SetText(disaster_chance_text)

                    -- Update civ level's effects
                    local factions_effects_list_component = level_container:SequentialFind(pillars_civilization.config
                    .ui.component_ids.forecast_effects_container)
                    pillars_civilization.update_faction_effects(i, factions_effects_list_component, false)
               end
          end
     end,

     -- end of HUD UI functions
     --------------------------------------------------
     -- Settlement bar UI functions

     --- @function update_all_settlement_info_bars
     --- @desc Shows an icon on settlements that are civilization pillars
     update_all_settlement_info_bars = function()
          if not is_table(pillars_civilization.config) then
               script_error("For some reason pillars_civilization.config is not a table")
               return
          end

          if not is_table(pillars_civilization.config.regions) then
               script_error("For some reason pillars_civilization.config.regions is not a table")
               return
          end

          for _, pillar_region_key in ipairs(pillars_civilization.config.regions) do
               pillars_civilization.update_settlement_info_bar(pillar_region_key)
          end
     end,

     --- @function update_settlement_info_bar
     --- @desc Shows an icon on the region's settlement nameplate indicating it is a pillar of civilization
     --- @p string pillar_region_key
     update_settlement_info_bar = function(pillar_region_key)
          -- this check is only needed for the error message... C++ does not crash but does not give an error either
          local pillar_region = cm:get_region(pillar_region_key)
          if not pillar_region then
               script_error("Provided civilization pillar key:'" .. pillar_region_key .. "' does not give valid region")
               return
          end

          cm:set_custom_settlement_info_icon(pillar_region_key,
               pillars_civilization.config.ui.settlement_bar_component_name,
               pillars_civilization.config.ui.settlement_bar_icon_path,
               pillars_civilization.config.ui.settlement_bar_icon_tooltip
          )
     end,

     -- end of Settlement bar UI functions
     --------------------------------------------------
     -- Event functions

     --- @function trigger_pillars_civilization_message_event
     --- @desc Shows an icon on the region indicating it is a pillar of civilization
     --- @p table event_info
     --- @p [opt=nil] object zoom_region_obj: region object to zoom to. By default it's nil meaning we use a message event. If it's not nil then a located message event will be used instead.
     --- @p [opt=nil] string new_civilization_level_name : the name of the new civilization state (when this is set `zoom_region_obj` will be nil)
     trigger_pillars_civilization_message_event = function(event_info, zoom_region_obj, new_civilization_level_name)
          local human_factions = cm:get_human_factions()
          for i = 1, #human_factions do
               local faction_name = human_factions[i]
               if zoom_region_obj then
                    -- We have a region to zoom to but since these events encompass large territories, we redirect to the Pillars of Civilisation panel which will show the event details
                    -- (rather than to a particular region)
                    cm:add_event_feed_event("pillars_of_civilisation_event", faction_name, event_info.index,
                         event_info.title, event_info.primary_detail, event_info.secondary_detail)
               else
                    if event_info.show_immediately == true then
                         local primary_detail_key = event_info.primary_detail .. new_civilization_level_name
                         cm:show_message_event(faction_name, event_info.title, primary_detail_key,
                              event_info.secondary_detail, true, event_info.pic, nil, nil, true)
                    else
                         cm:show_configurable_message_event(faction_name, event_info.title, event_info.primary_detail,
                              event_info.secondary_detail, event_info.pic)
                    end
               end
          end
     end,

     -- end of Event functions
     --------------------------------------------------
     -- Non-UI functions

     is_pillar_region = function(region_key)
          for _, v in ipairs(pillars_civilization.config.regions) do
               if region_key == v then
                    return true
               end
          end
          return false
     end,

     update_civilization_meter = function(do_update_incidents)
          local new_meter = pillars_civilization.calculate_civilization_meter()
          pillars_civilization.set_civilization_state(new_meter)

          if do_update_incidents then
               pillars_civilization.update_incidents()
          end

          pillars_civilization.update_ui()
     end,

     --- @function calculate_civilization_meter
     --- @desc Calculates the civilization meter, from buildings (Adds up all the main building levels in the pillars of civilization), wars & other events
     --- @return integer representing the civilization meter
     calculate_civilization_meter = function()
          local cheat_points = pillars_civilization.persistent.cheat_meter_points or 0

          return pillars_civilization.calculate_building_civilization_meter() +
              pillars_civilization.calculate_landmark_buildings_meter() +
              pillars_civilization.calculate_commands_meter() +
              pillars_civilization.calculate_legitimacy_wars_meter() +
              pillars_civilization.calculate_pretenders_meter() +
              pillars_civilization.persistent.incident_meter +
              pillars_civilization.calculate_technology_meter() +
              pillars_civilization.calculate_ancillaries_meter() +
              cheat_points
     end,

     calculate_building_civilization_meter = function()
          if not is_table(pillars_civilization.config) then
               script_error("For some reason pillars_civilization.config is not a table")
               return
          end

          if not is_table(pillars_civilization.config.regions) then
               script_error("For some reason pillars_civilization.config.regions is not a table")
               return
          end

          pillars_civilization.persistent.breakdown_cities_and_points_per_level = {}
          -- we don't use ipairs here because it misses the 0th element, which is important for ruins, and we don't need order of iteration
          for index, level in pairs(pillars_civilization.config.points_per_level) do
               pillars_civilization.persistent.breakdown_cities_and_points_per_level[index] = {
                    cities_by_level = 0,
                    points_by_level = 0
               }
          end

          local building_civilization_score = 0
          for _, pillar_region_key in ipairs(pillars_civilization.config.regions) do
               local building = pillars_civilization.get_main_building_of_region(pillar_region_key)
               if building and building:percent_health() == 100 then
                    local level = building:level()
                    if level then
                         pillars_civilization.persistent.breakdown_cities_and_points_per_level[level].cities_by_level =
                         pillars_civilization.persistent.breakdown_cities_and_points_per_level[level].cities_by_level + 1
                         local new_points = pillars_civilization.config.points_per_level[level]
                         building_civilization_score = building_civilization_score + new_points
                         pillars_civilization.persistent.breakdown_cities_and_points_per_level[level].points_by_level =
                         pillars_civilization.persistent.breakdown_cities_and_points_per_level[level].points_by_level +
                         new_points
                    end
               end
          end

          return building_civilization_score
     end,

     calculate_landmark_buildings_meter = function()
          if not is_table(pillars_civilization.config) then
               return
          end

          local points_counter = 0
          local buildings_counter = 0

          -- Go through all regions and check if their settlements contain landmark buildings
          for _, pillar_region_key in ipairs(pillars_civilization.config.regions) do
               for _, landmark_building_key in ipairs(pillars_civilization.config.landmark_buldings) do
                    local building = pillars_civilization.get_building_in_region(pillar_region_key, landmark_building_key)
                    if building then
                         points_counter = points_counter +
                         pillars_civilization.get_bonus_value_for_region(pillar_region_key,
                              pillars_civilization.config.landmark_buldings_bonus_key)
                         buildings_counter = buildings_counter + 1
                    end
               end
          end

          pillars_civilization.persistent.landmark_buildings_meter = points_counter
          pillars_civilization.persistent.landmark_buildings_count = buildings_counter

          return points_counter
     end,

     calculate_commands_meter = function()
          if not is_table(pillars_civilization.config) then
               return
          end

          local total_points = 0;
          for _, entry_points in pairs(pillars_civilization.persistent.commands_meter_sources) do
               total_points = total_points + entry_points
          end

          return total_points
     end,

     --- @function set_commands_meter
     --- @desc Adds an entry to the point-sources list
     --- @p string entry_text_id, Key of entry's text
     --- @p number entry_points, Number of points (positive or negative); Set to 0 to remove the entry (not display it)
     set_commands_meter = function(entry_text_id, entry_points)
          pillars_civilization.persistent.commands_meter_sources[entry_text_id] = entry_points
          pillars_civilization.update_civilization_meter(false)
     end,

     --- @function override_level_effect_bundles
     --- @desc Sets effect bundles that override the default effect bundles for some civilization level(s)
     --- @p string faction_key, Key of faction for which to override the default bundles
     --- @p table level_bundles, Table of format { level_name = bundle_key, ... }; Supply an empty table to restore the default level bundles
     --- @p number effect_bundle_duration, Number of turns the effect bundle should last
     override_level_effect_bundles = function(faction_key, level_bundles, effect_bundle_duration)
          local lindex = pillars_civilization.current_level_index

          -- Clear current effect bundle (till we know which one it is) before setting overriding one
          pillars_civilization.apply_factions_effects(lindex, lindex, false, true, faction_key)

          -- save remaining turns which will be updated by PoC, originally I did it with storing at which turn it should end and
          -- calculated the duration every time the bundle was reapplied but that way we lose 1 turn since reappliying was done on round start, but after that when
          -- faction turn starts it will reduce the duration ( adding +1 doesn't work because on the turn it's activated it will show one more turns )
          pillars_civilization.persistent.overriding_level_effect_bundles[faction_key] = { level_bundles = level_bundles, remaining_turns =
          effect_bundle_duration }

          pillars_civilization.apply_factions_effects(lindex, lindex, true, false, faction_key)
     end,

     --- @function get_main_building_of_region
     --- @desc Returns a reference to the main building of a region's settlement
     --- @p string region_key Key of region
     get_main_building_of_region = function(region_key)
          return pillars_civilization.get_building_in_region(region_key)
     end,

     --- @function get_building_in_region
     --- @desc Returns a reference to the main building of a region's settlement or to a building with the supplied key
     --- @p string region_key Key of region the settlement of which is to be searched for the required building
     --- @p string building_key Key of the building we are looking for; If missing or empty, will return the main building
     get_building_in_region = function(region_key, building_key)
          if not is_string(region_key) then
               script_error("passed argument region_key '" .. region_key .. "'' is not a string!")
               return nil
          end

          local region = cm:get_region(region_key)
          if not region or region:is_null_interface() then
               script_error("Could not resolve region with key '" .. region_key .. "'")
               return nil
          end

          local settlement = region:settlement()
          if not settlement or settlement:is_null_interface() then
               script_error("Could not resolve settlement in region with key '" .. region_key .. "'")
               return nil
          end

          local slot_list = settlement:slot_list()
          if slot_list:num_items() <= 0 then
               script_error("Settlement in region with key '" .. region_key .. " has no slots!")
               return nil
          end

          local get_main_building = not building_key or not building_key == ""
          if get_main_building then
               local slot = slot_list:item_at(0)
               if not slot or slot:is_null_interface() then
                    script_error("Slot in region with key: '" .. region_key .. " has no first slot!")
                    return nil
               end

               local building = slot:building()
               return not building:is_null_interface() and building
          end

          -- Search for building with the supplied key in any of the slots
          for slot_index = 0, slot_list:num_items() - 1 do
               local slot = slot_list:item_at(slot_index)
               if slot and not slot:is_null_interface() and slot:building() and not slot:building():is_null_interface() then
                    if slot:building():name() == building_key then
                         local building = slot:building()
                         return not building:is_null_interface() and building
                    end
               end
          end

          return nil
     end,

     --- @function get_bonus_value_for_region
     --- @desc Gets a region by key and checks if scripted bonus values are applied to it or it's owner
     --- @return int representing the found bonus values
     get_bonus_value_for_region = function(region_key, bonus_value_key)
          local region = cm:get_region(region_key)
          if not region or region:is_null_interface() then
               -- so such region is found
               return 0
          end

          if not is_string(bonus_value_key) then
               script_error("get_bonus_value_for_region called, but bonus_value_key is not a string!")
               return 0
          end

          local region_owner = region:owning_faction()

          if not region_owner:is_null_interface() then
               local bonus_value_from_faction = cm:get_factions_bonus_value(region_owner, bonus_value_key)
               local bonus_value_from_region = cm:get_regions_bonus_value(region, bonus_value_key)
               return bonus_value_from_faction + bonus_value_from_region
          end

          return 0
     end,

     get_blessing_and_disaster_chances_texts = function(civ_level_index)
          local blessing_chance_text = tostring(pillars_civilization.config.levels[civ_level_index].blessing_chance) ..
          "%"
          local disaster_chance_text = tostring(pillars_civilization.get_civilization_disaster_chance(civ_level_index)) ..
          "%"
          return blessing_chance_text, disaster_chance_text
     end,

     get_level_points_range_text = function(level_index)
          local level = pillars_civilization.config.levels[level_index]
          local high_range = pillars_civilization.config.levels[level_index + 1] and
          tostring(pillars_civilization.config.levels[level_index + 1].lower_bound - 1) or ""
          local low_range = tostring(math.max(level.lower_bound, 0))
          local points_range_text = ""
          if level_index == 1 then
               points_range_text = "≤ " .. high_range
          elseif level_index == #pillars_civilization.config.levels then
               points_range_text = "≥ " .. low_range
          else
               points_range_text = low_range .. " - " .. high_range
          end
          return points_range_text
     end,

     get_remaining_turns_until_civilization_transition_can_happen = function()
          return pillars_civilization.persistent.turn_last_civilization_state_transition_occurred +
          pillars_civilization.config.civilization_state_transition_cooldown_turns - cm:turn_number()
     end,

     --- @function	could_transition_to_new_civilization_state
     --- @desc		read only function that checks if we could change the civilization state/name
     could_transition_to_new_civilization_state = function()
          if pillars_civilization.current_level_index == -1 -- used to set pillars_civilization.current_level_index for the first time
              or pillars_civilization.persistent.cheat_meter_points -- dev ui cheat
              or pillars_civilization.get_remaining_turns_until_civilization_transition_can_happen() <= 0
          then
               return true
          else
               return false
          end
     end,

     --- @function set_civilization_state
     --- @desc sets the civilization meter, the civilization name and applies misc civilization-related effects
     --- @p int civilization_meter
     --- @p [opt=nil] is_called_on_firsttick is a boolean flag which should be set to true only when the function is called on first tick callback
     set_civilization_state = function(civilization_meter, is_called_on_firsttick)
          local old_meter = pillars_civilization.persistent.current_meter
          pillars_civilization.persistent.current_meter = civilization_meter
          local is_called_on_firsttick_str = is_called_on_firsttick and " on first tick" or ""
          output("civilization meter changed from '" ..
          old_meter .. "' to '" .. civilization_meter .. "'" .. is_called_on_firsttick_str)

          -- update civilization name
          local result_civilization_level, result_civilization_level_index
          for index, civilization_level in ipairs(pillars_civilization.config.levels) do
               if civilization_level.lower_bound <= civilization_meter then
                    result_civilization_level = civilization_level
                    result_civilization_level_index = index
               else
                    break
               end
          end

          -- check if the visuals are overridden
          local result_civilization_visual_level_index = result_civilization_level_index
          if is_number(pillars_civilization.persistent.visual_level_override_index) and pillars_civilization.persistent.visual_level_override_index > 0 then
               result_civilization_visual_level_index = pillars_civilization.persistent.visual_level_override_index
          end

          local old_level_index = pillars_civilization.current_level_index

          if old_level_index ~= result_civilization_level_index and pillars_civilization.could_transition_to_new_civilization_state() then
               if not is_called_on_firsttick then
                    pillars_civilization.persistent.turn_last_civilization_state_transition_occurred = cm:turn_number()
               end

               -- we could also provide the previous level, in case C++ needs to detect initial setup or rapid jump
               local new_name = pillars_civilization.config.levels[result_civilization_visual_level_index].name
               local old_name = ""
               if old_level_index > 0 then
                    old_name = pillars_civilization.config.levels[old_level_index].name
                    if not is_called_on_firsttick then
                         pillars_civilization.trigger_pillars_civilization_message_event(
                         pillars_civilization.config.ui.changed_civilization_level_message, nil, new_name)
                    end
               end

               pillars_civilization.apply_civilization_level_to_world(new_name)

               output("civilization level changed from '" ..
               old_name .. "' to '" .. new_name .. "'" .. is_called_on_firsttick_str)
               pillars_civilization.current_level_index = result_civilization_level_index

               pillars_civilization.apply_horde_effects_red_crown(old_level_index, result_civilization_level_index)
          end

          pillars_civilization.apply_factions_effects(old_level_index, result_civilization_level_index)
     end,

     --- @function apply_civilization_level_to_world
     --- @desc applies the civilization level to the world if not using custom civilization levels
     --- @p string level_name, Name of level
     apply_civilization_level_to_world = function(level_name)
          if cm:model():world():get_civilization_level_int() <= #pillars_civilization.config.levels then
               cm:set_new_civilization_level(level_name)
          end
     end,

     --- @function	get_civilization_level_with_name
     --- @desc		returns the config object of the civilization level with the supplied name
     --- @p string level_name, Name of level
     get_civilization_level_with_name = function(level_name)
          for _, level in ipairs(pillars_civilization.config.levels) do
               if level.name == level_name then
                    return level
               end
          end
          return nil
     end,

     --- @function	get_current_civilization_level
     --- @desc		return the current civilization's object
     get_current_civilization_level = function()
          if pillars_civilization.current_level_index < 0 or pillars_civilization.current_level_index > #pillars_civilization.config.levels then
               -- return "prosperity" by default
               return pillars_civilization.config.levels[#pillars_civilization.config.levels]
          else
               return pillars_civilization.config.levels[pillars_civilization.current_level_index]
          end
     end,

     --- @function	get_level_effect_bundle_key
     --- @desc		Returns the key of the effect bundle that should be applied to the supplied faction on the supplied civilization level and number of turns the bundle should last; Can return empty string
     get_level_effect_bundle_key = function(civ_level, faction_key, dont_return_settled_factions_bundle)
          local faction_overriding_effect_bundle = pillars_civilization.persistent.overriding_level_effect_bundles
          [faction_key]
          if faction_overriding_effect_bundle and faction_overriding_effect_bundle.level_bundles and faction_overriding_effect_bundle.level_bundles[pillars_civilization.config.levels[civ_level].name] then
               local overriding_effect_bundle_key = faction_overriding_effect_bundle.level_bundles
               [pillars_civilization.config.levels[civ_level].name]
               return overriding_effect_bundle_key, faction_overriding_effect_bundle.remaining_turns
          end

          if pillars_civilization.is_nomad_faction(faction_key) then
               return pillars_civilization.config.levels[civ_level].nomads_effect_bundle_key or "", 0
          elseif table_contains(sea_peoples_playable_faction_keys, faction_key) then
               return pillars_civilization.config.levels[civ_level].sea_peoples_playable_effect_bundle_key or "", 0
          elseif pillars_civilization.is_sea_peoples_faction(faction_key) then
               return pillars_civilization.config.levels[civ_level].sea_peoples_effect_bundle_key or "", 0
          elseif cm:get_faction(faction_key):is_allowed_to_capture_territory() then
               if not dont_return_settled_factions_bundle then
                    return pillars_civilization.config.levels[civ_level].settled_factions_effect_bundle_key or "", 0
               end
          else
               output("WARNING: @ pillars_civilization.get_level_effect_bundle_key: Faction '" ..
               faction_key ..
               "' is not present in the lists of nomads and sea peoples, nor is allowed to capture territory.")
          end

          return "", -1
     end,

     --- @func	apply_factions_effects
     --- @desc	give appropriate buffs to factions depending on current level of Civilization and remove effects pertaining to other civ levels (if applicable)
     --- @desc	The first time this function is called old_civ_level should be -1
     --- @p		old_civ_level, new_civ_level integers - it is perfectly valid for them to be equal (that will be the normal & most common scenario)
     --- @p		boolean skip_remove_old, Whether to skip removing the effect bundle for old_civ_level
     --- @p		boolean skip_add_new, Whether to skip adding the effect bundle for new_civ_level
     --- @p		string only_for_faction_key, If supplied, applying/removing of effect will be performed only for this faction
     apply_factions_effects = function(old_civ_level, new_civ_level, skip_remove_old, skip_add_new, only_for_faction_key)
          if old_civ_level == -1 then
               return
          end

          if old_civ_level < 1 or old_civ_level > #pillars_civilization.config.levels or new_civ_level < 1 or new_civ_level > #pillars_civilization.config.levels then
               output("Error @ pillars_civilization.apply_factions_effects: Invalid civilization level given: " ..
               old_civ_level ..
               "; and " .. new_civ_level .. "; must be between 1 and " .. #pillars_civilization.config.levels)
               return
          end

          local faction_list = cm:model():world():faction_list();

          for i = 0, faction_list:num_items() - 1 do
               local faction = faction_list:item_at(i);
               local faction_name = faction:name();

               if not faction:is_dead() and (not only_for_faction_key or only_for_faction_key == faction_name) then
                    for level = 1, #pillars_civilization.config.levels do
                         if level == new_civ_level then
                              local new_effect_bundle_key, bundle_duration = pillars_civilization
                              .get_level_effect_bundle_key(new_civ_level, faction_name)
                              if new_effect_bundle_key ~= "" and bundle_duration >= 0 and not skip_add_new then
                                   cm:apply_effect_bundle(new_effect_bundle_key, faction_name, bundle_duration)
                              end
                         else
                              local old_effect_bundle_key = pillars_civilization.get_level_effect_bundle_key(level,
                                   faction_name)
                              if old_effect_bundle_key ~= "" and not skip_remove_old then
                                   cm:remove_effect_bundle(old_effect_bundle_key, faction_name)
                              end
                         end
                    end
               end
          end
     end,

     set_civilization_tracker_expanded_state = function(expanded)
          local anim_name = expanded and "show" or "hide"
          pillars_civilization.component_cache.civilization_container_component:TriggerAnimation(anim_name)
     end,

     set_is_hidden_by_ui_override = function(hide)
          pillars_civilization.persistent.is_hidden_by_ui_override = hide
          pillars_civilization.update_ui()
     end,

     set_system_enabled = function(flag)
          pillars_civilization.persistent.is_system_enabled = flag
          if not flag then
               core:remove_listener("pillars_civilization_RoundStart")
               core:remove_listener("pillars_civilization_UITriggerScriptEvent")
               core:remove_listener("pillars_civilization_ContextTriggerEvent")
               core:remove_listener("pillars_civilization_CharacterAncillaryGained")
               core:remove_listener("pillars_civilization_CharacterAncillaryLost")
               core:remove_listener("pillars_civilization_CharacterEntersMilitaryForce")
               core:remove_listener("pillars_civilization_CharacterLeavesMilitaryForce")
               core:remove_listener("pillars_civilization_UIReloaded")
               pillars_civilization.remove_civilization_tracker_listeners()
          else
               pillars_civilization.add_civilization_tracker_listeners()
          end
     end,

     --- @function		get_civilization_disaster_chance
     --- @p [opt=nil]	civilization_index if the argument is not specified then we seek to get the current civilization's disaster chance to happen
     get_civilization_disaster_chance = function(civilization_index)
          if civilization_index ~= nil
              and (civilization_index < 0 or civilization_index > #pillars_civilization.config.levels)
          then
               output("ERROR: invalid civilization index " .. civilization_index .. " supplied!")
               return
          end

          local civilization_level = nil
          if civilization_index ~= nil then
               civilization_level = pillars_civilization.config.levels[civilization_index]
          else
               civilization_level = pillars_civilization.get_current_civilization_level()
               civilization_index = pillars_civilization.current_level_index
          end

          local disaster_chance = civilization_level.disaster_chance
          if modular_difficulty_campaign.variables.maat_extra_disaster_chance and not table.is_empty(modular_difficulty_campaign.variables.maat_extra_disaster_chance) then
               disaster_chance = disaster_chance +
               modular_difficulty_campaign.variables.maat_extra_disaster_chance[civilization_index]
          end

          return math.max(disaster_chance, 0)
     end,

     --- @function		set_civilization_disaster_chance_to_zero
     --- @desc	sets the civilization disaster chance to zero; useful for tutorial purposes
     set_civilization_disaster_chance_to_zero = function()
          modular_difficulty_campaign.variables.maat_extra_disaster_chance =
          {
               [1] = -100, -- during "Collapse" civilization
               [2] = -100, -- during "Crisis" civilization
               [3] = -100, -- during "Prosperity" civilization
          }
     end,

     --------------------------------------------------
     -- Legitimacy War related functions

     --- @function	is_recovering_from_legitimacy_war
     --- @p			`war` an element of pillars_civilization.persistent.wars
     is_recovering_from_legitimacy_war = function(war)
          if war.war_duration_penalty > 0 then
               war.recovering_from_war = true
          else
               war.recovering_from_war = false
          end
          return war.recovering_from_war
     end,

     --- @function	get_political_state
     --- @p			`war` an element of pillars_civilization.persistent.wars
     get_political_state = function(war)
          if war.name == "egyptian" then
               return egypt_political_states
          elseif war.name == "hatti" then
               return hatti_political_states
          end
     end,

     --- @function	update_legitimacy_war
     --- @desc		checks the properties of a specific type of legitimacy war
     --- @p			`war` used to query the properties of a legitimacy war
     --- @return		the civilization meter points from the specific legitimacy war in question
     update_legitimacy_war = function(war)
          local obj = pillars_civilization.get_political_state(war)
          if not obj then
               script_error("Oh No! political states object is invalid!")
          end

          local turns_into_legitimacy_war = cm:turn_number() - obj.persistent.start_turn_of_legitimacy_war or 0
          local war_points = 0
          if obj:political_state() == "legitimacy_war" then
               war_points = pillars_civilization.config.penalty_per_turn_from_legitimacy_war * turns_into_legitimacy_war
               if war_points > pillars_civilization.config.max_war_duration_penalty then
                    war_points = pillars_civilization.config.max_war_duration_penalty
               end

               war.recovering_from_war = false -- edge case where a legitimacy war might start while we're in "recovery" (under normal circumstances this should never happen)
          elseif obj:political_state() ~= "legitimacy_war" and pillars_civilization.is_recovering_from_legitimacy_war(war) then
               war_points = war.war_duration_penalty - pillars_civilization.config
               .recovery_per_turn_after_legitimacy_war
          else
               war.recovering_from_war = false
          end

          war.war_duration_penalty = war_points

          return war_points
     end,

     --- @function	calculate_legitimacy_wars_meter
     --- @desc		calculates civilization points due to any legitimacy_wars
     --- @return		the total civilization meter penalty due to any legitimacy_wars
     calculate_legitimacy_wars_meter = function()
          if not is_table(pillars_civilization.persistent.wars) then
               script_error("For some reason `pillars_civilization.persistent.wars` is not a table.")
          end

          local wars_points = 0
          for _, war in ipairs(pillars_civilization.persistent.wars) do
               wars_points = wars_points + pillars_civilization.update_legitimacy_war(war)
          end

          return -wars_points
     end,

     calculate_pretenders_meter = function()
          pillars_civilization.persistent.pretenders_meter = -pillars_civilization.config.penalty_per_pretender *
          (egypt_political_states:get_num_pretenders() + hatti_political_states:get_num_pretenders())
          return pillars_civilization.persistent.pretenders_meter
     end,

     -- End of Legitimacy War related functions
     --------------------------------------------------

     --------------------------------------------------
     -- Incident related functions

     --- @func	calculate_incident_meter
     --- @desc	deprecated because by latest design incidents do not affect the Civilization meter
     calculate_incident_meter = function(is_compensating)
          local incident = pillars_civilization.get_current_incident()
          if not incident then
               return
          end

          pillars_civilization.persistent.incident_meter = incident.civ_points_change or 0
          if is_compensating then
               local current_incident_duration = cm:turn_number() -
               pillars_civilization.persistent.turn_last_incident_was_spawned
               if pillars_civilization.is_incident_negative(pillars_civilization.get_current_incident()) then
                    pillars_civilization.persistent.incident_meter = pillars_civilization.persistent.incident_meter +
                    pillars_civilization.config.incident_compensation_per_turn * current_incident_duration
               else
                    pillars_civilization.persistent.incident_meter = pillars_civilization.persistent.incident_meter -
                    pillars_civilization.config.incident_compensation_per_turn * current_incident_duration
               end
          end
     end,

     --- @func	get_current_incident
     --- @desc	convenience function to get the current incident that's in effect
     get_current_incident = function()
          if pillars_civilization.persistent.current_incident_index == -1 then
               return nil
          end

          return pillars_civilization.config.incidents[pillars_civilization.persistent.current_incident_index]
     end,

     --- @func	get_incident_affected_regions
     --- @desc	a helper function that returns the supplied incident's affected_regions table
     get_incident_affected_regions = function(incident)
          local region_keys = {
               --[1] = {"region_key1"},
               --[2] = {"region_key2"},
          }

          if incident.name == "Earthquake" then
               table.insert(region_keys, pillars_civilization.persistent.earthquake_region_hit_name)
          else
               for _, group_name in ipairs(pillars_civilization.config.province_group_templates[pillars_civilization.persistent.chosen_template_index]) do
                    if pillars_civilization.config.province_groups[group_name] then
                         for _, province_key in ipairs(pillars_civilization.config.province_groups[group_name]) do
                              local target_province = cm:get_province(province_key)
                              if target_province then
                                   local region_list = target_province:regions()
                                   for i = 0, region_list:num_items() - 1 do
                                        local curr_region = region_list:item_at(i)
                                        table.insert(region_keys, curr_region:name())
                                   end
                              else
                                   output("get_incident_affected_regions got an invalid province key: " .. province_key)
                              end
                         end
                    else
                         output(
                         "get_incident_affected_regions there is no group in pillars_civilization.config.province_groups with a key: " ..
                         group_name)
                    end
               end
          end

          return region_keys
     end,

     --- @ func	get_incident_affected_provinces
     --- @desc	a helper function that returns the supplied incident's affected_provinces table
     get_incident_affected_provinces = function(incident)
          local province_keys = {
               --[1] = {"province_key1"},
               --[2] = {"province_key2"},
          }

          if incident.name == "Earthquake" then
               local province_key = cm:get_region(pillars_civilization.persistent.earthquake_region_hit_name)
               :province_name()
               table.insert(province_keys, province_key)
          else
               for _, group_name in ipairs(pillars_civilization.config.province_group_templates[pillars_civilization.persistent.chosen_template_index]) do
                    if pillars_civilization.config.province_groups[group_name] then
                         for _, province_key in ipairs(pillars_civilization.config.province_groups[group_name]) do
                              local target_province = cm:get_province(province_key)
                              if target_province and not target_province:is_null_interface() then
                                   table.insert(province_keys, province_key)
                              else
                                   output(
                                   "WARNING: @ pillars_civilization.get_incident_affected_provinces: Province with key '" ..
                                   province_key .. "' does not exist!")
                              end
                         end
                    else
                         output(
                         "WARNING: @ pillars_civilization.get_incident_affected_provinces: Province group with name '" ..
                         group_name .. "' does not exist!")
                    end
               end
          end

          return province_keys
     end,

     --- @func	is_incident_negative
     --- @desc	check if the supplied incident is a negative one (ie. it's a disaster)
     is_incident_negative = function(incident)
          if incident.civ_points_change ~= 0 then
               return incident.civ_points_change < 0
          end
          return not incident.is_positive_with_0_points_change
     end,

     --- @func	reset_incident_stats
     --- @desc	deprecated because by latest design incidents do not affect the Civilization meter
     reset_incident_stats = function()
          pillars_civilization.persistent.incident_meter = 0
          pillars_civilization.persistent.current_incident_index = -1
     end,

     get_current_incident_remaining_turns = function()
          local current_incident_index = pillars_civilization.persistent.current_incident_index
          if current_incident_index < 0 or current_incident_index > #pillars_civilization.config.incidents then
               return false
          end

          return pillars_civilization.persistent.turn_last_incident_was_spawned +
          pillars_civilization.config.incidents[current_incident_index].bundle_duration - cm:turn_number()
     end,

     is_any_incident_in_effect = function()
          local current_incident_remaining_turns = pillars_civilization.get_current_incident_remaining_turns()
          return is_number(current_incident_remaining_turns) and current_incident_remaining_turns > 0 or false
     end,

     can_trigger_incident = function()
          local can_potentially_trigger = cm:turn_number() >=
          pillars_civilization.persistent.turn_last_incident_was_spawned +
          pillars_civilization.get_current_civilization_level().incident_cooldown
          if not can_potentially_trigger then
               return false
          end

          local are_all_blessings_disabled = pillars_civilization.are_all_blessings_disabled()
          local are_all_disasters_disabled = pillars_civilization.are_all_disasters_disabled()

          return can_potentially_trigger and not (are_all_blessings_disabled and are_all_disasters_disabled)
     end,

     is_incident_disabled = function(incident)
          for _, incident_name in ipairs(pillars_civilization.persistent.disabled_incident_names) do
               if incident_name == incident.name then
                    return true
               end
          end

          return false
     end,

     --- @func	are_all_blessings_disabled
     --- @desc	a helper function to quickly determine if all blessings are disabled
     are_all_blessings_disabled = function()
          for _, incident in ipairs(pillars_civilization.config.incidents) do
               -- if at least one blessing is not disabled return false
               if not pillars_civilization.is_incident_negative(incident) and not table.contains(pillars_civilization.persistent.disabled_incident_names, incident.name) then
                    return false
               end
          end

          return true
     end,

     --- @func	are_all_disasters_disabled
     --- @desc	a helper function to quickly determine if all disasters are disabled
     are_all_disasters_disabled = function()
          for _, incident in ipairs(pillars_civilization.config.incidents) do
               -- if at least one disaster is not disabled return false
               if pillars_civilization.is_incident_negative(incident) and not table.contains(pillars_civilization.persistent.disabled_incident_names, incident.name) then
                    return false
               end
          end

          return true
     end,

     --- @function	update_incidents
     --- @desc		picks a random incident to spawn if applicable, applies its effects, and calculates the civilization points impacted from it
     update_incidents = function()
          if not pillars_civilization.is_any_incident_in_effect() then
               pillars_civilization.clear_current_incident()
          end

          if pillars_civilization.can_trigger_incident() then
               pillars_civilization.try_apply_incident()
          end
     end,

     try_apply_incident = function()
          local current_civilization = pillars_civilization.get_current_civilization_level()

          local chosen_incident_index = -1
          local roll = cm:model():random_int(1, 100)
          if roll <= current_civilization.blessing_chance then
               chosen_incident_index = pillars_civilization.select_random_blessing()
          else
               roll = roll - current_civilization.blessing_chance
               if roll <= pillars_civilization.get_civilization_disaster_chance() then
                    chosen_incident_index = pillars_civilization.select_random_disaster()
               end
          end

          if chosen_incident_index >= 0 then
               pillars_civilization.apply_incident(chosen_incident_index)
          end
     end,

     apply_incident = function(incident_index)
          local current_incident = pillars_civilization.config.incidents[incident_index]
          local affected_region_name = current_incident:apply()
          if not affected_region_name then
               return
          end

          pillars_civilization.persistent.current_incident_index = incident_index
          pillars_civilization.persistent.turn_last_incident_was_spawned = cm:turn_number()

          local affected_region = cm:get_region(affected_region_name)
          pillars_civilization.trigger_pillars_civilization_message_event(current_incident.event_info, affected_region)

          local affected_regions = pillars_civilization.get_incident_affected_regions(current_incident)

          cm:set_incident_ambience_sound(current_incident.name, affected_regions)

          pillars_civilization.set_incident_vfx_visibility(current_incident, true)
     end,

     clear_current_incident = function()
          local incident_index = pillars_civilization.persistent.current_incident_index
          if incident_index == -1 then
               return
          end

          local current_incident = pillars_civilization.config.incidents[incident_index]
          pillars_civilization.set_incident_vfx_visibility(current_incident, false)

          local affected_regions = {}

          cm:set_incident_ambience_sound("", affected_regions)

          pillars_civilization.persistent.current_incident_index = -1
          pillars_civilization.persistent.earthquake_region_hit_name = ""
     end,

     -- Shows/hides VFX onto the incident's affected regions' settlements
     set_incident_vfx_visibility = function(incident, visible)
          local is_negative = pillars_civilization.is_incident_negative(incident)
          local vfx = is_negative and pillars_civilization.config.incident_vfx_negative or
          pillars_civilization.config.incident_vfx_positive

          local affected_regions = pillars_civilization.get_incident_affected_regions(incident)
          for _, region_key in ipairs(affected_regions) do
               local region = cm:get_region(region_key)
               local garrison_residence_cqi = region:garrison_residence():command_queue_index()

               if visible then
                    cm:add_garrison_residence_vfx(garrison_residence_cqi, vfx,
                         pillars_civilization.config.incident_vfx_show_in_shroud, false, false)
               else
                    cm:remove_garrison_residence_vfx(garrison_residence_cqi, vfx)
               end
          end
     end,

     select_random_blessing = function()
          local max_weight = 0
          for _, incident in ipairs(pillars_civilization.config.incidents) do
               if not pillars_civilization.is_incident_negative(incident) and not pillars_civilization.is_incident_disabled(incident) then
                    max_weight = max_weight + pillars_civilization.get_incident_current_weight(incident)
               end
          end

          if max_weight == 0 then
               return -1
          end

          local rand = cm:model():random_int(1, max_weight)
          local chosen_incident_index = -1
          local current_weight = -1

          for index, incident in ipairs(pillars_civilization.config.incidents) do
               if not pillars_civilization.is_incident_negative(incident) and not pillars_civilization.is_incident_disabled(incident) then
                    current_weight = pillars_civilization.get_incident_current_weight(incident)
                    if rand < current_weight then
                         chosen_incident_index = index
                         break
                    end
                    rand = rand - current_weight
               end
          end
          return chosen_incident_index
     end,

     select_random_disaster = function()
          local max_weight = 0
          for _, incident in ipairs(pillars_civilization.config.incidents) do
               if pillars_civilization.is_incident_negative(incident) and not pillars_civilization.is_incident_disabled(incident) then
                    max_weight = max_weight + pillars_civilization.get_incident_current_weight(incident)
               end
          end

          if max_weight == 0 then
               return -1
          end

          local rand = cm:model():random_int(1, max_weight)
          local chosen_incident_index = -1
          local current_weight = -1

          for index, incident in ipairs(pillars_civilization.config.incidents) do
               if pillars_civilization.is_incident_negative(incident) and not pillars_civilization.is_incident_disabled(incident) then
                    current_weight = pillars_civilization.get_incident_current_weight(incident)
                    if rand < current_weight then
                         chosen_incident_index = index
                         break
                    end
                    rand = rand - current_weight
               end
          end
          return chosen_incident_index
     end,

     --- @function	damage_main_building
     --- @desc		does damage to the main building of the supplied region's settlement
     damage_main_building = function(region, damage_percent)
          if not region or region:is_null_interface() or not is_number(damage_percent) then
               script_error("invalid arguments")
               return
          end

          local region_key = region:name()
          local main_building = pillars_civilization.get_main_building_of_region(region_key)
          if not main_building then
               script_error("no main building in region")
               return
          end

          local main_building_name = main_building:name()
          local main_building_resultant_health_percent = main_building:percent_health() - damage_percent

          cm:instant_set_building_health_percent(region_key, main_building_name, main_building_resultant_health_percent)
     end,

     --- @function	damage_settlement_buildings
     --- @desc		does damage to `num_buildings_to_damage` buildings of the supplied region's settlement (excluding the main building)
     damage_settlement_buildings = function(region, num_buildings_to_damage, damage_percentage)
          if not region or region:is_null_interface() or not is_number(num_buildings_to_damage) or not is_number(damage_percentage) then
               script_error("invalid arguments")
               return
          end

          local region_key = region:name()
          local damaged_buildings = {}
          local loop_counter = 0
          local max_attempts = 1000
          local settlement_slot_list = region:settlement():slot_list()
          local last_building_index = settlement_slot_list:num_items() - 1
          -- we stop trying if we run out of things to damage, we damaged all the things we wanted, or after max_attempts
          while
               #damaged_buildings < region:num_buildings() and #damaged_buildings < num_buildings_to_damage and loop_counter <= max_attempts
          do
               loop_counter = loop_counter + 1
               local building_index = cm:model():random_int(1, last_building_index)
               if settlement_slot_list:item_at(building_index):has_building() and (not table.contains(damaged_buildings, building_index)) then
                    local building_to_damage = settlement_slot_list:item_at(building_index):building()
                    local building_name = building_to_damage:name()
                    local building_resultant_health_percent = building_to_damage:percent_health() - damage_percentage
                    cm:instant_set_building_health_percent(region_key, building_name, building_resultant_health_percent)
                    table.insert(damaged_buildings, building_index)
               end
          end
          if loop_counter >= max_attempts then
               output("we could not damage all buildings for some reason")
          end
     end,

     get_incident_current_weight = function(incident)
          local current_level_index = pillars_civilization.current_level_index
          if current_level_index < 0 or current_level_index > #incident.weight_per_civ_level then
               output("ERROR @ pillars_civilization.get_incident_current_weight() - Invalid index!")
               return
          end

          return incident.weight_per_civ_level[current_level_index]
     end,

     -- End of Incident related functions
     --------------------------------------------------

     --------------------------------------------------
     -- Technology related functions

     -- @function	calculate_technology_meter
     -- @desc		calculates the impact to the civilization meter originating from various technologies
     calculate_technology_meter = function()
          local technology_points = 0
          for _, tech in ipairs(pillars_civilization.config.technologies) do
               if tech.bonus_points_per_pillars_region_owned_by_faction_with_technology then
                    tech.get_points = pillars_civilization
                    .get_bonus_points_per_pillars_region_owned_by_faction_with_technology(tech)
               end

               technology_points = technology_points + tech:get_points()
          end

          pillars_civilization.persistent.technology_points = technology_points
          return technology_points
     end,

     get_bonus_points_per_pillars_region_owned_by_faction_with_technology = function(technology_config)
          return function(technology_config)
               -- add `bonus_points_per_pillars_region_owned_by_faction_with_technology` civ points per every PoC settlement owned by any faction that has done this research
               local points = 0
               for _, pillar_region_key in ipairs(pillars_civilization.config.regions) do
                    local pillar_region = cm:get_region(pillar_region_key)
                    if pillar_region and not pillar_region:is_null_interface() then
                         local pillar_region_owning_faction = pillar_region:owning_faction()
                         if not pillar_region_owning_faction:is_rebel() and pillar_region_owning_faction:has_technology(technology_config.key) then
                              points = points +
                              technology_config.bonus_points_per_pillars_region_owned_by_faction_with_technology
                         end
                    end
               end

               return points
          end
     end,

     -- End of Technology related functions
     --------------------------------------------------

     --------------------------------------------------
     -- Ancillary related functions

     --- @function	calculate_ancillaries_meter
     --- @desc		calculates the civilization meter contribution from ancillaries
     calculate_ancillaries_meter = function()
          if pillars_civilization.persistent.red_crown_wearer_cqi == -1 then
               pillars_civilization.persistent.ancillary_points = 0
               return 0
          end

          pillars_civilization.persistent.ancillary_points = pillars_civilization.config.red_crown
          .civilization_meter_boost
          return pillars_civilization.persistent.ancillary_points
     end,

     --- @function	update_red_crown_bonuses
     --- @p	add_bonuses: boolean flag that tells us if we should add the new red crown related bonuses
     update_red_crown_bonuses = function(add_bonuses)
          if add_bonuses then
               pillars_civilization.apply_horde_effects_red_crown(nil, pillars_civilization.current_level_index)
          else
               pillars_civilization.apply_horde_effects_red_crown(pillars_civilization.current_level_index)
          end
     end,

     --- @function	apply_horde_effects_red_crown
     --- @p [opt=nil] civilization_level_index_to_remove: integer, remove the effect_bundle of the indicated civilization level index
     --- @p [opt=nil] civilization_level_index_to_apply: integer, apply the effect_bundle of the indicated civilization level index
     apply_horde_effects_red_crown = function(civilization_level_index_to_remove, civilization_level_index_to_apply)
          if not pillars_civilization.persistent.red_crown_wearer_cqi or pillars_civilization.persistent.red_crown_wearer_cqi == -1 then
               return
          end

          local character = cm:get_character_by_fm_cqi(pillars_civilization.persistent.red_crown_wearer_cqi)
          local character_cqi
          if character and not character:is_wounded() and character:family_member():is_alive() then
               character_cqi = character:command_queue_index()
          else
               -- the character is dead or wounded, we don't need to remove or add anything.
               return
          end

          if civilization_level_index_to_remove and civilization_level_index_to_remove > 0 and civilization_level_index_to_remove <= #pillars_civilization.config.levels then
               local nomads_red_crown_old_civilization_effect_bundle_key = pillars_civilization.config.levels
               [civilization_level_index_to_remove].nomads_red_crown_effect_bundle_key
               local sea_peoples_red_crown_old_civilization_effect_bundle_key = pillars_civilization.config.levels
               [civilization_level_index_to_remove].sea_peoples_red_crown_effect_bundle_key

               cm:remove_effect_bundle_from_character(nomads_red_crown_old_civilization_effect_bundle_key, character_cqi)
               cm:remove_effect_bundle_from_character(sea_peoples_red_crown_old_civilization_effect_bundle_key,
                    character_cqi)
          end

          if civilization_level_index_to_apply and civilization_level_index_to_apply > 0 and civilization_level_index_to_apply <= #pillars_civilization.config.levels then
               local nomads_red_crown_current_civilization_effect_bundle_key = pillars_civilization.config.levels
               [civilization_level_index_to_apply].nomads_red_crown_effect_bundle_key
               local sea_peoples_red_crown_current_civilization_effect_bundle_key = pillars_civilization.config.levels
               [civilization_level_index_to_apply].sea_peoples_red_crown_effect_bundle_key

               cm:apply_effect_bundle_to_character(nomads_red_crown_current_civilization_effect_bundle_key, character_cqi,
                    0)
               cm:apply_effect_bundle_to_character(sea_peoples_red_crown_current_civilization_effect_bundle_key,
                    character_cqi, 0)
          end
     end,

     apply_initial_province_effect_bundle = function(data, should_damage_buildings)
          local first_affected_region = nil
          local weighted_list = weighted_list:new_from_pairs_list(data.template_options)
          local _, index = weighted_list:weighted_select()
          pillars_civilization.persistent.chosen_template_index = index

          for _, group_name in ipairs(pillars_civilization.config.province_group_templates[pillars_civilization.persistent.chosen_template_index]) do
               if pillars_civilization.config.province_groups[group_name] then
                    for _, province_key in ipairs(pillars_civilization.config.province_groups[group_name]) do
                         local target_province = cm:get_province(province_key)
                         if target_province then
                              local region_list = target_province:regions()
                              for j = 0, region_list:num_items() - 1 do
                                   local target_region = region_list:item_at(j)
                                   local region_owner_key = target_region:owning_faction():name()
                                   if should_damage_buildings then
                                        pillars_civilization.damage_main_building(target_region,
                                             data.damage_amount_percentage)
                                        pillars_civilization.damage_settlement_buildings(target_region,
                                             data.num_buildings_to_damage, data.damage_amount_percentage)
                                   end

                                   for i = 1, #data.bundle_keys do
                                        if not target_province:has_effect_bundle(data.bundle_keys[i], region_owner_key) then
                                             -- add one additional turn because the effect bundle is added on round start and start turn reduces the bundle's turns thus losing 1 turn
                                             cm:apply_effect_bundle_to_province(data.bundle_keys[i], target_region:name(),
                                                  data.bundle_duration + 1)
                                             if not first_affected_region then
                                                  first_affected_region = target_region:name()
                                             end
                                        end
                                   end
                              end
                         else
                              output("apply_initial_province_effect_bundle got an invalid province key: " .. province_key)
                         end
                    end
               else
                    output(
                    "apply_initial_province_effect_bundle there is no group setup in pillars_civilization.config.province_groups with a key: " ..
                    group_name)
               end
          end
          return first_affected_region
     end,

     -- End of Ancillary related functions
     --------------------------------------------------

     on_round_start = function()
          -- NOTE: if we no longer add the incident's effect bundles on round start - modify calls to apply_effect_bundle_to_region so they don't add 1 additional turn
          pillars_civilization.update_civilization_meter(true)

          -- reduce number of remaining turns after the effect bundle has been reapplied because the faction's turn start will then reduce the effect bundle's duration
          for _, overriding_level_effect_bundle in dpairs(pillars_civilization.persistent.overriding_level_effect_bundles) do
               if overriding_level_effect_bundle.level_bundles then
                    overriding_level_effect_bundle.remaining_turns = overriding_level_effect_bundle.remaining_turns - 1
               end
          end
     end,

     on_saving_game = function(context)
          if not pillars_civilization.persistent or not is_table(pillars_civilization.persistent) then
               script_error("persistent table is invalid!")
               return
          end

          cm:save_named_value("pillars_civilization", pillars_civilization.persistent, context)
     end,

     on_loading_game = function(context)
          if not pillars_civilization.persistent or not is_table(pillars_civilization.persistent) then
               script_error("persistent table is invalid!")
               return
          end

          pillars_civilization.persistent = cm:load_named_value("pillars_civilization", pillars_civilization.persistent,
               context)
          pillars_civilization.persistent.current_meter = pillars_civilization.persistent.current_meter or -1

          if pillars_civilization.persistent.breakdown_cities_and_points_per_level == nil then
               pillars_civilization.persistent.breakdown_cities_and_points_per_level = {}
               for i = 0, #pillars_civilization.config.points_per_level do
                    --for index, level in pairs(pillars_civilization.config.points_per_level) do
                    pillars_civilization.persistent.breakdown_cities_and_points_per_level[i] = {
                         cities_by_level = 0,
                         points_by_level = 0
                    }
               end
          end

          if not pillars_civilization.persistent.wars or table.is_empty(pillars_civilization.persistent.wars) then
               pillars_civilization.persistent.wars = {}
               for _, war_type in ipairs(pillars_civilization.config.war_types) do
                    local war = {
                         name = war_type,
                         war_duration_penalty = 0,
                         recovering_from_war = false,
                    }
                    table.insert(pillars_civilization.persistent.wars, war)
               end
          end

          pillars_civilization.persistent.is_system_enabled = is_nil(pillars_civilization.persistent.is_system_enabled) or
          pillars_civilization.persistent.is_system_enabled
          pillars_civilization.persistent.is_hidden_by_ui_override = pillars_civilization.persistent
          .is_hidden_by_ui_override or false
          pillars_civilization.persistent.current_incident_index = pillars_civilization.persistent
          .current_incident_index or -1
          pillars_civilization.persistent.turn_last_incident_was_spawned = pillars_civilization.persistent
          .turn_last_incident_was_spawned or -1
          pillars_civilization.persistent.turn_last_civilization_state_transition_occurred = pillars_civilization
          .persistent.turn_last_civilization_state_transition_occurred or 0
          pillars_civilization.persistent.incident_meter = pillars_civilization.persistent.incident_meter or 0
          pillars_civilization.persistent.pretenders_meter = pillars_civilization.persistent.pretenders_meter or 0
          pillars_civilization.persistent.commands_meter_sources = pillars_civilization.persistent
          .commands_meter_sources or {}
          pillars_civilization.persistent.technology_points = pillars_civilization.persistent.technology_points or 0
          pillars_civilization.persistent.cheat_meter_points = pillars_civilization.persistent.cheat_meter_points or nil
          pillars_civilization.persistent.earthquake_region_hit_name = pillars_civilization.persistent
          .earthquake_region_hit_name or ""
          pillars_civilization.persistent.disabled_incident_names = pillars_civilization.persistent
          .disabled_incident_names or {}
          pillars_civilization.persistent.ancillary_points = pillars_civilization.persistent.ancillary_points or 0
          pillars_civilization.persistent.red_crown_wearer_cqi = pillars_civilization.persistent.red_crown_wearer_cqi or
          -1
          pillars_civilization.persistent.overriding_level_effect_bundles = pillars_civilization.persistent
          .overriding_level_effect_bundles or {}
          pillars_civilization.persistent.chosen_template_index = pillars_civilization.persistent.chosen_template_index or
          0
     end,

     update_visuals = function()
          if pillars_civilization.persistent.visual_level_override_index > 0 then
               local level = pillars_civilization.config.levels
               [pillars_civilization.persistent.visual_level_override_index]
               pillars_civilization.apply_civilization_level_to_world(level.name)
          elseif pillars_civilization.persistent.is_system_enabled then
               local current_level = pillars_civilization.get_current_civilization_level()
               pillars_civilization.apply_civilization_level_to_world(current_level.name)
          else
               local civilization_level_when_disabled = pillars_civilization.config.levels
               [pillars_civilization.config.index_of_level_to_use_for_mood_when_system_is_disabled]
               pillars_civilization.apply_civilization_level_to_world(civilization_level_when_disabled.name)
          end
     end,

     -- end of Non-UI functions
     --------------------------------------------------
     -- Cheat functions

     --- @function cheat_set_meter
     --- @desc Changes the civilization meter for testing purposes, it will reset to the true one next round
     --- @p int new_meter represents the new civilization meter
     cheat_set_meter = function(new_meter)
          pillars_civilization.set_civilization_state(new_meter)
          pillars_civilization.update_ui()
     end,

     --- @function cheat_set_level
     --- @desc Changes the civilization level for testing purposes, it will reset to the true one next round
     cheat_set_level = function(new_level)
          if new_level < 1 or new_level > #pillars_civilization.config.levels then
               output("invalid civilization level given: " ..
               new_level .. "; must be between 1 and " .. #pillars_civilization.config.levels)
               return
          end

          local old_name = pillars_civilization.config.levels[pillars_civilization.current_level_index].name
          local new_name = pillars_civilization.config.levels[new_level].name
          pillars_civilization.trigger_pillars_civilization_message_event(
          pillars_civilization.config.ui.changed_civilization_level_message, nil, new_name)

          pillars_civilization.apply_civilization_level_to_world(new_name)
          pillars_civilization.apply_factions_effects(pillars_civilization.current_level_index, new_level)

          -- this forces recalculation next turn
          pillars_civilization.persistent.current_meter = -1
          pillars_civilization.current_level_index = new_level
          pillars_civilization.update_ui()
     end,

     --- @function	cheat_trigger_incident
     --- @desc		Triggers desired incident. Function used for testing purposes.
     --- @p			incident_index, used to index into the `pillars_civilization.config.incidents` table and access the desired incident
     cheat_trigger_incident = function(incident_index)
          if incident_index < 0 or incident_index > #pillars_civilization.config.incidents then
               output("ERROR: invalid `incident_index`!")
               return
          end

          pillars_civilization.clear_current_incident()
          pillars_civilization.apply_incident(incident_index)
          pillars_civilization.update_civilization_meter(false)
     end,

     toggle_dev_ui = function()
          local civilization_dev_ui_panel_component, created = core:get_or_create_component(
          "dev_ui_pillars_civilization", "UI/dev_ui/dev_ui_pillars_civilization")
          if not civilization_dev_ui_panel_component then
               output("ERROR: The Pillars of Civilization DEV UI layout was not found!")
               return
          end
          local should_show = not civilization_dev_ui_panel_component:Visible() or created
          civilization_dev_ui_panel_component:SetVisible(should_show)
     end,

     -- end of Cheat functions
     --------------------------------------------------
}

-- hat-trick: turn the index table into an index + string_key table
for _, incident in ipairs(pillars_civilization.config.incidents) do
     pillars_civilization.config.incidents[incident.name] = incident
end

for _, incident in ipairs(pillars_civilization.config.incidents) do
     if incident.name == "Earthquake" then
          incident.apply = function(self)
               local region_list = cm:model():world():region_manager():region_list()

               local random_region = nil
               local province_capital_region = nil
               local last_region_index = region_list:num_items() - 1
               local max_attempts = 1000
               local i = 0
               repeat
                    random_region = region_list:item_at(cm:model():random_int(0, last_region_index))
                    province_capital_region = cm:get_province_capital_for_region(random_region)
                    i = i + 1
               until (random_region and not random_region:is_null_interface() and province_capital_region and not province_capital_region:is_null_interface() and not province_capital_region:is_abandoned() or i > max_attempts)

               pillars_civilization.damage_main_building(province_capital_region, self.damage_amount_percentage)
               pillars_civilization.damage_settlement_buildings(province_capital_region, self.num_buildings_to_damage,
                    self.damage_amount_percentage)

               local province_capital_region_name = province_capital_region:name()

               for i = 1, #self.bundle_keys do
                    -- add one additional turn because the effect bundle is added on round start and start turn reduces the bundle's turns thus losing 1 turn
                    cm:apply_effect_bundle_to_region(self.bundle_keys[i], province_capital_region_name,
                         self.bundle_duration + 1)
               end

               pillars_civilization.persistent.earthquake_region_hit_name = province_capital_region_name

               return province_capital_region_name
          end
     elseif incident.name == "Flood" then
          incident.apply = function(self)
               if not is_table(self.template_options) then
                    output("ERROR: no template_options table for incident '" .. self.name .. "'!")
                    return ""
               end

               if self.template_options[1] == nil then
                    output("ERROR: incident '" .. self.name .. "' has no affected regions!")
                    return ""
               end

               local first_affected_region = pillars_civilization.apply_initial_province_effect_bundle(self, true)

               return first_affected_region
          end
     elseif incident.name == "Drought" then
          incident.apply = function(self)
               if not is_table(self.template_options) then
                    output("ERROR: no template_options table for incident '" .. self.name .. "'!")
                    return ""
               end

               if self.template_options[1] == nil then
                    output("ERROR: incident '" .. self.name .. "' has no affected regions!")
                    return ""
               end

               local current_season_key = cm:model():current_season_key()
               if not table_contains(self.applicable_season_keys, current_season_key) then
                    return nil
               end

               local first_affected_region = pillars_civilization.apply_initial_province_effect_bundle(self)

               return first_affected_region
          end
     elseif incident.name == "Plague" then
          incident.apply = function(self)
               if not is_table(self.template_options) then
                    output("ERROR: no template_options table for incident '" .. self.name .. "'!")
                    return ""
               end

               if self.template_options[1] == nil then
                    output("ERROR: incident '" .. self.name .. "' has no affected regions!")
                    return ""
               end

               local first_affected_region = pillars_civilization.apply_initial_province_effect_bundle(self)

               return first_affected_region
          end
     elseif incident.name == "Fertility" then
          incident.apply = function(self)
               if not is_table(self.template_options) then
                    output("ERROR: no template_options table for incident '" .. self.name .. "'!")
                    return ""
               end

               if self.template_options[1] == nil then
                    output("ERROR: incident '" .. self.name .. "' has no affected regions!")
                    return ""
               end

               local first_affected_region = pillars_civilization.apply_initial_province_effect_bundle(self)

               return first_affected_region
          end
     elseif incident.name == "NaturesBounty" then
          incident.apply = function(self)
               if not is_table(self.template_options) then
                    output("ERROR: no template_options table for incident '" .. self.name .. "'!")
                    return ""
               end

               if self.template_options[1] == nil then
                    output("ERROR: incident '" .. self.name .. "' has no affected regions!")
                    return ""
               end

               local first_affected_region = pillars_civilization.apply_initial_province_effect_bundle(self)

               return first_affected_region
          end
     elseif incident.name == "WonderfulWeather" then
          incident.apply = function(self)
               if not is_table(self.template_options) then
                    output("ERROR: no template_options table for incident '" .. self.name .. "'!")
                    return ""
               end

               if self.template_options[1] == nil then
                    output("ERROR: incident '" .. self.name .. "' has no affected regions!")
                    return ""
               end

               local first_affected_region = pillars_civilization.apply_initial_province_effect_bundle(self)

               return first_affected_region
          end
     else
          script_error("Unknown incident.")
     end

     if not incident.incident_event_name then
          incident.incident_event_name = incident.name
     end
end

cm:add_saving_game_callback(function(context) pillars_civilization.on_saving_game(context) end)
cm:add_loading_game_callback(function(context) pillars_civilization.on_loading_game(context) end)


core:add_listener(
     "pillars_civilization_RoundStart",
     "RoundStart",
     true,
     function(context)
          pillars_civilization.on_round_start()
     end,
     true
)

core:add_listener(
     "pillars_civilization_NewCampaignStarted",
     "NewCampaignStarted",
     true,
     function(context)
          if not pillars_civilization.persistent.is_system_enabled then
               return -- Do nothing and let the FirstTickAfterWorldCreated handler do all the required work.
          end

          pillars_civilization.update_civilization_meter(false)
     end,
     false
)

core:add_listener(
     "pillars_civilization_FirstTickAfterWorldCreated",
     "FirstTickAfterWorldCreated",
     true,
     function(context)
          if pillars_civilization.persistent.is_system_enabled then
               pillars_civilization.set_civilization_state(pillars_civilization.persistent.current_meter, true)
          else
               -- Currently, the civilization level passed to the CPP is used for visual/audio mood only, so we pass some default level here.
               local civilization_level_when_disabled = pillars_civilization.config.levels
               [pillars_civilization.config.index_of_level_to_use_for_mood_when_system_is_disabled]
               pillars_civilization.apply_civilization_level_to_world(civilization_level_when_disabled.name)
          end

          -- Always init the UI, as when the system is disabled, the UI should be hidden.
          pillars_civilization.init_ui()
     end,
     false
)

-- Pillars of Civilization meter DevUi buttons
-- pillars_civilization_UITriggerScriptEvent
core:add_listener(
     "pillars_civilization_UITriggerScriptEvent",
     "UITriggerScriptEvent",
     function(context)
          return string.find(context:trigger(), "pillars_debug_")
     end,
     function(context)
          local event_split = context:trigger():split(":")
          local event_name = event_split[1]

          if event_name == "pillars_debug_change_civ_points" then
               if pillars_civilization.persistent.current_meter == -1 then
                    -- covers the edge case where we push in cheats at first turn of the game and pillars_civilization.persistent.current_meter is still -1
                    -- this is not necessary for gameplay experience, mostly done for correctness & completeness (mostly when seeing debug output logs etc.)
                    pillars_civilization.update_civilization_meter(false)
               end

               local cheat_meter = pillars_civilization.persistent.cheat_meter_points or 0
               cheat_meter = cheat_meter + tonumber(event_split[2])
               pillars_civilization.persistent.cheat_meter_points = cheat_meter
               pillars_civilization.update_civilization_meter(false)
          elseif event_name == "pillars_debug_restore_civ_points" then
               if pillars_civilization.persistent.cheat_meter_points then
                    pillars_civilization.persistent.cheat_meter_points = nil
                    pillars_civilization.update_civilization_meter(false)
               end
          elseif event_name == "pillars_debug_trigger_incident" then
               local requested_incident_event_name = tostring(event_split[2])
               local incident_index = pillars_civilization.get_incident_index_by_event_name(
               requested_incident_event_name)
               pillars_civilization.cheat_trigger_incident(incident_index)
          end
     end,
     true
)

-- pillars_civilization_ContextTriggerEvent
core:add_listener(
     "pillars_civilization_ContextTriggerEvent",
     "ContextTriggerEvent",
     function(context)
          return context.string:split(":")[1] == "PillarsButton"
     end,
     function(context)
          local params = context.string:split(":")
          local command = params[2]
          if command == "ZoomToIncidentAffectedRegion" then
               local province_key = params[3]
               local region_key = cm:get_province(province_key):capital():name()
               cm:scroll_camera_to_settlement(region_key)
          elseif command == "PillarsTrackerHoverOn" then
               pillars_civilization.set_civilization_tracker_expanded_state(true)
          elseif command == "PillarsTrackerHoverOff" then
               pillars_civilization.set_civilization_tracker_expanded_state(false)
          else
               output("Error: unknown button '" .. command .. "'")
          end
     end,
     true
)

--pillars_civilization_CharacterAncillaryGained
core:add_listener(
     "pillars_civilization_CharacterAncillaryGained",
     "CharacterAncillaryGained",
     true,
     function(context)
          local ancillary_key = context:ancillary()
          if ancillary_key == pillars_civilization.config.red_crown.ancillary_key then
               local character = context:character()
               pillars_civilization.persistent.red_crown_wearer_cqi = character:family_member():command_queue_index()
               pillars_civilization.update_red_crown_bonuses(true)
          end
     end,
     true
)

--pillars_civilization_CharacterAncillaryLost
core:add_listener(
     "pillars_civilization_CharacterAncillaryLost",
     "CharacterAncillaryLost",
     true,
     function(context)
          local ancillary_key = context:ancillary()
          local character = context:character()
          local character_cqi = character:family_member():command_queue_index()
          if character_cqi == pillars_civilization.persistent.red_crown_wearer_cqi and ancillary_key == pillars_civilization.config.red_crown.ancillary_key then
               pillars_civilization.update_red_crown_bonuses(false)
               pillars_civilization.persistent.red_crown_wearer_cqi = -1
          end
     end,
     true
)

-- pillars_civilization_CharacterEntersMilitaryForce
core:add_listener(
     "pillars_civilization_CharacterEntersMilitaryForce",
     "CharacterEntersMilitaryForce",
     true,
     function(context)
          local character = context:character()
          local character_cqi = character:family_member():command_queue_index()
          if character_cqi == pillars_civilization.persistent.red_crown_wearer_cqi then
               pillars_civilization.update_red_crown_bonuses(true)
          end
     end,
     true
)

-- pillars_civilization_CharacterLeavesMilitaryForce
core:add_listener(
     "pillars_civilization_CharacterLeavesMilitaryForce",
     "CharacterLeavesMilitaryForce",
     true,
     function(context)
          local character = context:character()
          local character_cqi = character:family_member():command_queue_index()
          if character_cqi == pillars_civilization.persistent.red_crown_wearer_cqi then
               pillars_civilization.update_red_crown_bonuses(false)
          end
     end,
     true
)

-- pillars_civilization_UIReloaded
core:add_listener(
     "pillars_civilization_UIReloaded",
     "UIReloaded",
     true,
     function(context)
          pillars_civilization.init_ui()
     end,
     true
)

-- Set effect bundle for the Battle Hud to be displayed if we are in a battle against Nomads / Sea People
-- PendingBattle event is not triggered when you load directly into PreBattle, while PanelOpenedCampaign event is triggered too early before
-- the gameplay systems are initialized, so the approach with ComponentLClickUp is implemented here
core:add_listener(
     "pillars_civilization_PreBattlePanelOpenedCampaign",
     "PanelOpenedCampaign",
     function(context)
          return context.string == "popup_pre_battle" and pillars_civilization.persistent.is_system_enabled
     end,
     function(context)
          core:svr_save_string("battle_hud_poc_effect_bundle_key", "")

          core:add_listener(
               "pillars_civilization_lclick_start_battle",
               "ComponentLClickUp",
               function(context) return context.string == "button_attack" end,
               function(context)
                    local enemy_attacker = cm:get_pending_battle_general_for_primary_enemy_faction(cm:get_local_faction(true))
                    local battle_hud_poc_effect_bundle_key = enemy_attacker and
                    pillars_civilization.get_level_effect_bundle_key(pillars_civilization.current_level_index,
                         enemy_attacker:faction():name(), true)

                    core:svr_save_string("battle_hud_poc_effect_bundle_key", battle_hud_poc_effect_bundle_key)
               end,
               true
          )

          core:add_listener(
               "pillars_civilization_PreBattlePanelClosedCampaign",
               "PanelClosedCampaign",
               function(context)
                    return context.string == "popup_pre_battle"
               end,
               function(context)
                    core:remove_listener("pillars_civilization_lclick_start_battle")
               end,
               false
          )
     end,
     true
)

core:add_listener(
     "pillars_civilization_RegionFactionChangeEvent",
     "RegionFactionChangeEvent",
     true,
     function(context)
          local current_incident_remaining_turns = pillars_civilization.get_current_incident_remaining_turns()
          if not current_incident_remaining_turns then
               return
          end

          local should_reapply_incident_effects = false

          local current_incident = pillars_civilization.get_current_incident()
          local incident_affected_region_keys = pillars_civilization.get_incident_affected_regions(current_incident)

          -- check if any of the current incident's affected regions belong in any of the subject province's regions (as an extra precaution)
          local province_key = context:region():province_name()
          local province = cm:get_province(province_key)
          local region_list = province:regions()
          local last_region_index = region_list:num_items() - 1
          for i = 0, last_region_index do
               local region_key = region_list:item_at(i):name()
               should_reapply_incident_effects = should_reapply_incident_effects or
               table_contains(incident_affected_region_keys, region_key)
          end

          if not should_reapply_incident_effects then
               return
          end

          -- update the incident's bundle for every region accordingly
          for _, region_key in ipairs(incident_affected_region_keys) do
               for i = 1, #current_incident.bundle_keys do
                    local bundle_key = current_incident.bundle_keys[i]
                    local region = cm:get_region(region_key)
                    local curr_province = region:province()
                    local owning_faction = region:owning_faction()
                    if not curr_province:has_effect_bundle(bundle_key, owning_faction:name()) then
                         -- the effect bundle has been invalidated by the region faction change event, therefore reapply it with the remaining duration
                         cm:apply_effect_bundle_to_province(bundle_key, region_key, current_incident_remaining_turns)
                    end
               end
          end
     end,
     true,
     true
)
