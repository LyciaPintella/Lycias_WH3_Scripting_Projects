out("Loading phar_modular_difficulty_config.lua")

modular_difficulty_campaign = {}

modular_difficulty_campaign.config = {
     diplomatic_requirements_thresholds = {
          bundle_key = "phar_main_modular_difficulty_diplomatic_requirements_thresholds",
          low = -20,
          medium = -10,
          high = 20,
     },

     diplomatic_deal_distance_penalties_for_war = {
          -- All personalities must be included in each difficulty level, otherwise some of the values will leak through when changing the setting.
          None    = {
               phar_default = { -25, -40 },
               phar_default_early = { -35, -60 },
               phar_diplomat = { -100, -100 },
               phar_diplomat_early = { -110, -120 },
               phar_isolationist = { -200, -200 },
               phar_isolationist_early = { -300, -300 },
               phar_militarist = { -18, -30 },
               phar_militarist_early = { -36, -50 },
               phar_opportunist = { -35, -45 },
               phar_opportunist_early = { -45, -55 },
               phar_schemer = { -35, -60 },
               phar_schemer_early = { -35, -60 },
               phar_servile = { -100, -100 },
               -- 			phar_servile_early = {-100,-100},
               phar_trader = { -35, -60 },
               phar_trader_early = { -35, -60 },
               phar_tutorial_peace_lover = { 0, 0 },
               phar_unique_amenmesse = { -18, -30 },
               phar_unique_amenmesse_early = { -36, -50 },
               phar_unique_babylon = { -18, -30 },
               phar_unique_babylon_early = { -36, -50 },
               phar_unique_bay = { -100, -100 },
               phar_unique_bay_early = { -110, -120 },
               phar_unique_irsu = { -35, -45 },
               phar_unique_irsu_early = { -45, -55 },
               phar_unique_kurunta = { -35, -60 },
               phar_unique_kurunta_early = { -35, -60 },
               phar_unique_mycenae = { -36, -50 },
               phar_unique_mycenae_early = { -36, -50 },
               phar_unique_ramesses = { -35, -45 },
               phar_unique_ramesses_early = { -45, -55 },
               phar_unique_seti = { -18, -30 },
               phar_unique_seti_early = { -36, -50 },
               phar_unique_suppiliuma = { -35, -45 },
               phar_unique_suppiliuma_early = { -45, -55 },
               phar_unique_tausret = { -35, -60 },
               phar_unique_tausret_early = { -35, -60 },
               phar_unique_troy = { -36, -50 },
               phar_unique_troy_early = { -36, -50 },
               troy_default = { -25, -40 },
               troy_default_early = { -35, -60 },
               troy_diplomat = { -100, -100 },
               troy_diplomat_early = { -110, -120 },
               troy_diplomat_early_faithful_ally = { -100, -100 },
               troy_diplomat_faithful_ally = { -110, -120 },
               troy_isolationist = { -200, -200 },
               troy_isolationist_early = { -300, -300 },
               troy_militarist = { -18, -30 },
               troy_militarist_early = { -36, -50 },
               troy_militarist_early_faithful_ally = { -18, -30 },
               troy_militarist_faithful_ally = { -36, -50 },
               troy_opportunist = { -35, -45 },
               troy_opportunist_early = { -45, -55 },
               troy_opportunist_early_faithful_ally = { -35, -45 },
               troy_opportunist_faithful_ally = { -45, -55 },
               troy_schemer = { -25, -40 },
               troy_schemer_early = { -35, -60 },
               troy_schemer_early_faithful_ally = { -25, -40 },
               troy_schemer_faithful_ally = { -35, -60 },
               troy_servile = { -100, -100 },
               troy_servile_early = { -100, -100 },
               troy_servile_early_faithful_ally = { -100, -100 },
               troy_servile_faithful_ally = { -100, -100 },
               troy_trader = { -35, -60 },
               troy_trader_early = { -35, -60 },
               troy_unique_memnon = { -18, -30 },
               troy_unique_paris_hector = { -25, -40 },
               troy_unique_paris_hector_early = { -25, -40 },
               troy_unique_penthesilea = { -18, -30 },
               troy_unique_penthesilea_early = { -18, -30 },
               troy_unique_priams_troy = { -80, -100 },
               troy_unique_priams_troy_early = { -80, -100 },
               troy_unique_rhesus = { -25, -40 },
               troy_unique_sarpedon = { -35, -60 },
               troy_unique_sarpedon_early = { -35, -60 },
          },
          Low     = {
               phar_default = { -14, -20 },
               phar_default_early = { -20, -30 },
               phar_diplomat = { -10, -100 },
               phar_diplomat_early = { -40, -110 },
               phar_isolationist = { -40, -100 },
               phar_isolationist_early = { -100, -200 },
               phar_militarist = { -5, -12 },
               phar_militarist_early = { -10, -24 },
               phar_opportunist = { -25, -30 },
               phar_opportunist_early = { -35, -40 },
               phar_schemer = { -20, -30 },
               phar_schemer_early = { -20, -30 },
               phar_servile = { -10, -100 },
               phar_servile_early = { -10, -100 },
               phar_trader = { -20, -30 },
               phar_trader_early = { -20, -30 },
               phar_tutorial_peace_lover = { 0, 0 },
               phar_unique_amenmesse = { -5, -12 },
               phar_unique_amenmesse_early = { -10, -24 },
               phar_unique_babylon = { -5, -12 },
               phar_unique_babylon_early = { -10, -24 },
               phar_unique_bay = { -10, -100 },
               phar_unique_bay_early = { -40, -110 },
               phar_unique_irsu = { -25, -30 },
               phar_unique_irsu_early = { -35, -40 },
               phar_unique_kurunta = { -20, -30 },
               phar_unique_kurunta_early = { -20, -30 },
               phar_unique_mycenae = { -10, -24 },
               phar_unique_mycenae_early = { -10, -24 },
               phar_unique_ramesses = { -25, -30 },
               phar_unique_ramesses_early = { -35, -40 },
               phar_unique_seti = { -5, -12 },
               phar_unique_seti_early = { -10, -24 },
               phar_unique_suppiliuma = { -25, -30 },
               phar_unique_suppiliuma_early = { -35, -40 },
               phar_unique_tausret = { -20, -30 },
               phar_unique_tausret_early = { -20, -30 },
               phar_unique_troy = { -10, -24 },
               phar_unique_troy_early = { -10, -24 },
               troy_default = { -14, -20 },
               troy_default_early = { -20, -30 },
               troy_diplomat = { -10, -100 },
               troy_diplomat_early = { -40, -110 },
               troy_diplomat_early_faithful_ally = { -10, -100 },
               troy_diplomat_faithful_ally = { -40, -110 },
               troy_isolationist = { -40, -100 },
               troy_isolationist_early = { -100, -200 },
               troy_militarist = { -5, -12 },
               troy_militarist_early = { -10, -24 },
               troy_militarist_early_faithful_ally = { -5, -12 },
               troy_militarist_faithful_ally = { -10, -24 },
               troy_opportunist = { -25, -30 },
               troy_opportunist_early = { -35, -40 },
               troy_opportunist_early_faithful_ally = { -25, -30 },
               troy_opportunist_faithful_ally = { -35, -40 },
               troy_schemer = { -14, -20 },
               troy_schemer_early = { -20, -30 },
               troy_schemer_early_faithful_ally = { -14, -20 },
               troy_schemer_faithful_ally = { -20, -30 },
               troy_servile = { -10, -100 },
               troy_servile_early = { -10, -100 },
               troy_servile_early_faithful_ally = { -10, -100 },
               troy_servile_faithful_ally = { -10, -100 },
               troy_trader = { -20, -30 },
               troy_trader_early = { -20, -30 },
               troy_unique_memnon = { -5, -12 },
               troy_unique_paris_hector = { -14, -20 },
               troy_unique_paris_hector_early = { -14, -20 },
               troy_unique_penthesilea = { -5, -12 },
               troy_unique_penthesilea_early = { -5, -12 },
               troy_unique_priams_troy = { -50, -60 },
               troy_unique_priams_troy_early = { -50, -60 },
               troy_unique_rhesus = { -14, -20 },
               troy_unique_sarpedon = { -20, -30 },
               troy_unique_sarpedon_early = { -20, -30 },
          },
          Medium  = {
               phar_default = { -3, -5 },
               phar_default_early = { -3, -5 },
               phar_diplomat = { -1, -2 },
               phar_diplomat_early = { -3, -5 },
               phar_isolationist = { -3, -5 },
               phar_isolationist_early = { -15, -25 },
               phar_militarist = { -5, -10 },
               phar_militarist_early = { 0, -5 },
               phar_opportunist = { -7, -14 },
               phar_opportunist_early = { -5, -20 },
               phar_schemer = { 0, -10 },
               phar_schemer_early = { 0, -10 },
               phar_servile = { -1, -2 },
               phar_servile_early = { -1, -2 },
               phar_trader = { 0, -10 },
               phar_trader_early = { 0, -10 },
               phar_tutorial_peace_lover = { 0, 0 },
               phar_unique_amenmesse = { -5, -10 },
               phar_unique_amenmesse_early = { 0, -5 },
               phar_unique_babylon = { -5, -10 },
               phar_unique_babylon_early = { 0, -5 },
               phar_unique_bay = { -1, -2 },
               phar_unique_bay_early = { -1, -5 },
               phar_unique_irsu = { -7, -14 },
               phar_unique_irsu_early = { -5, -20 },
               phar_unique_kurunta = { 0, -10 },
               phar_unique_kurunta_early = { 0, -10 },
               phar_unique_mycenae = { 0, -5 },
               phar_unique_mycenae_early = { 0, -5 },
               phar_unique_ramesses = { -7, -14 },
               phar_unique_ramesses_early = { -5, -20 },
               phar_unique_seti = { -5, -10 },
               phar_unique_seti_early = { 0, -5 },
               phar_unique_suppiliuma = { -7, -14 },
               phar_unique_suppiliuma_early = { -5, -20 },
               phar_unique_tausret = { 0, -10 },
               phar_unique_tausret_early = { 0, -10 },
               phar_unique_troy = { 0, -5 },
               phar_unique_troy_early = { 0, -5 },
               troy_default = { -3, -5 },
               troy_default_early = { 0, -10 },
               troy_diplomat = { -1, -2 },
               troy_diplomat_early = { -1, -5 },
               troy_diplomat_early_faithful_ally = { -1, -2 },
               troy_diplomat_faithful_ally = { -3, -5 },
               troy_isolationist = { -5, -15 },
               troy_isolationist_early = { -15, -25 },
               troy_militarist = { -5, -10 },
               troy_militarist_early = { 0, -5 },
               troy_militarist_early_faithful_ally = { -5, -10 },
               troy_militarist_faithful_ally = { 0, -5 },
               troy_opportunist = { -7, -14 },
               troy_opportunist_early = { -5, -20 },
               troy_opportunist_early_faithful_ally = { -7, -14 },
               troy_opportunist_faithful_ally = { -5, -20 },
               troy_schemer = { -3, -5 },
               troy_schemer_early = { 0, -10 },
               troy_schemer_early_faithful_ally = { -3, -5 },
               troy_schemer_faithful_ally = { 0, -10 },
               troy_servile = { -1, -2 },
               troy_servile_early = { -1, -2 },
               troy_servile_early_faithful_ally = { -1, -2 },
               troy_servile_faithful_ally = { -1, -2 },
               troy_trader = { 0, -10 },
               troy_trader_early = { 0, -10 },
               troy_unique_memnon = { -5, -10 },
               troy_unique_paris_hector = { -3, -5 },
               troy_unique_paris_hector_early = { -14, -14 },
               troy_unique_penthesilea = { -5, -10 },
               troy_unique_penthesilea_early = { -5, -10 },
               troy_unique_priams_troy = { -50, -50 },
               troy_unique_priams_troy_early = { -50, -50 },
               troy_unique_rhesus = { -3, -5 },
               troy_unique_sarpedon = { 0, -10 },
               troy_unique_sarpedon_early = { 0, -10 },
          },
          High    = { -- defaults
               phar_default = { 0, 0 },
               phar_default_early = { 0, 0 },
               phar_diplomat = { 0, 0 },
               phar_diplomat_early = { 0, 0 },
               phar_isolationist = { 0, 0 },
               phar_isolationist_early = { 0, 0 },
               phar_militarist = { 0, 0 },
               phar_militarist_early = { 0, 0 },
               phar_opportunist = { 0, 0 },
               phar_opportunist_early = { 0, 0 },
               phar_schemer = { 0, 0 },
               phar_schemer_early = { 0, 0 },
               phar_servile = { 0, 0 },
               phar_servile_early = { 0, 0 },
               phar_trader = { 0, 0 },
               phar_trader_early = { 0, 0 },
               phar_tutorial_peace_lover = { 0, 0 },
               phar_unique_amenmesse = { 0, 0 },
               phar_unique_amenmesse_early = { 0, 0 },
               phar_unique_babylon = { 0, 0 },
               phar_unique_babylon_early = { 0, 0 },
               phar_unique_bay = { 0, 0 },
               phar_unique_bay_early = { 0, 0 },
               phar_unique_irsu = { 0, 0 },
               phar_unique_irsu_early = { 0, 0 },
               phar_unique_kurunta = { 0, 0 },
               phar_unique_kurunta_early = { 0, 0 },
               phar_unique_mycenae = { 0, 0 },
               phar_unique_mycenae_early = { 0, 0 },
               phar_unique_ramesses = { 0, 0 },
               phar_unique_ramesses_early = { 0, 0 },
               phar_unique_seti = { 0, 0 },
               phar_unique_seti_early = { 0, 0 },
               phar_unique_suppiliuma = { 0, 0 },
               phar_unique_suppiliuma_early = { 0, 0 },
               phar_unique_tausret = { 0, 0 },
               phar_unique_tausret_early = { 0, 0 },
               phar_unique_troy = { 0, 0 },
               phar_unique_troy_early = { 0, 0 },
               troy_default = { 0, 0 },
               troy_default_early = { 0, 0 },
               troy_diplomat = { 0, 0 },
               troy_diplomat_early = { 0, 0 },
               troy_diplomat_early_faithful_ally = { 0, 0 },
               troy_diplomat_faithful_ally = { 0, 0 },
               troy_isolationist = { 0, 0 },
               troy_isolationist_early = { 0, 0 },
               troy_militarist = { 0, 0 },
               troy_militarist_early = { 0, 0 },
               troy_militarist_early_faithful_ally = { 0, 0 },
               troy_militarist_faithful_ally = { 0, 0 },
               troy_opportunist = { 0, 0 },
               troy_opportunist_early = { 0, 0 },
               troy_opportunist_early_faithful_ally = { 0, 0 },
               troy_opportunist_faithful_ally = { 0, 0 },
               troy_schemer = { 0, 0 },
               troy_schemer_early = { 0, 0 },
               troy_schemer_early_faithful_ally = { 0, 0 },
               troy_schemer_faithful_ally = { 0, 0 },
               troy_servile = { 0, 0 },
               troy_servile_early = { 0, 0 },
               troy_servile_early_faithful_ally = { 0, 0 },
               troy_servile_faithful_ally = { 0, 0 },
               troy_trader = { 0, 0 },
               troy_trader_early = { 0, 0 },
               troy_unique_memnon = { 0, 0 },
               troy_unique_paris_hector = { 0, 0 },
               troy_unique_paris_hector_early = { 0, 0 },
               troy_unique_penthesilea = { 0, 0 },
               troy_unique_penthesilea_early = { 0, 0 },
               troy_unique_priams_troy = { 0, 0 },
               troy_unique_priams_troy_early = { 0, 0 },
               troy_unique_rhesus = { 0, 0 },
               troy_unique_sarpedon = { 0, 0 },
               troy_unique_sarpedon_early = { 0, 0 },
          },
          Option4 = {
               phar_default = { 5, 20 },
               phar_default_early = { 5, 20 },
               phar_diplomat = { 5, 20 },
               phar_diplomat_early = { 5, 20 },
               phar_isolationist = { 5, 20 },
               phar_isolationist_early = { 5, 20 },
               phar_militarist = { 5, 20 },
               phar_militarist_early = { 5, 20 },
               phar_opportunist = { 5, 20 },
               phar_opportunist_early = { 5, 20 },
               phar_schemer = { 5, 20 },
               phar_schemer_early = { 5, 20 },
               phar_servile = { 5, 20 },
               phar_servile_early = { 5, 20 },
               phar_trader = { 5, 20 },
               phar_trader_early = { 5, 20 },
               phar_tutorial_peace_lover = { 5, 20 },
               phar_unique_amenmesse = { 5, 20 },
               phar_unique_amenmesse_early = { 5, 20 },
               phar_unique_babylon = { 5, 20 },
               phar_unique_babylon_early = { 5, 20 },
               phar_unique_bay = { 5, 20 },
               phar_unique_bay_early = { 5, 20 },
               phar_unique_irsu = { 5, 20 },
               phar_unique_irsu_early = { 5, 20 },
               phar_unique_kurunta = { 5, 20 },
               phar_unique_kurunta_early = { 5, 20 },
               phar_unique_mycenae = { 5, 20 },
               phar_unique_mycenae_early = { 5, 20 },
               phar_unique_ramesses = { 5, 20 },
               phar_unique_ramesses_early = { 5, 20 },
               phar_unique_seti = { 5, 20 },
               phar_unique_seti_early = { 5, 20 },
               phar_unique_suppiliuma = { 5, 20 },
               phar_unique_suppiliuma_early = { 5, 20 },
               phar_unique_tausret = { 5, 20 },
               phar_unique_tausret_early = { 5, 20 },
               phar_unique_troy = { 5, 20 },
               phar_unique_troy_early = { 5, 20 },
               troy_default = { 5, 20 },
               troy_default_early = { 5, 20 },
               troy_diplomat = { 5, 20 },
               troy_diplomat_early = { 5, 20 },
               troy_diplomat_early_faithful_ally = { 5, 20 },
               troy_diplomat_faithful_ally = { 5, 20 },
               troy_isolationist = { 5, 20 },
               troy_isolationist_early = { 5, 20 },
               troy_militarist = { 5, 20 },
               troy_militarist_early = { 5, 20 },
               troy_militarist_early_faithful_ally = { 5, 20 },
               troy_militarist_faithful_ally = { 5, 20 },
               troy_opportunist = { 5, 20 },
               troy_opportunist_early = { 5, 20 },
               troy_opportunist_early_faithful_ally = { 5, 20 },
               troy_opportunist_faithful_ally = { 5, 20 },
               troy_schemer = { 5, 20 },
               troy_schemer_early = { 5, 20 },
               troy_schemer_early_faithful_ally = { 5, 20 },
               troy_schemer_faithful_ally = { 5, 20 },
               troy_servile = { 5, 20 },
               troy_servile_early = { 5, 20 },
               troy_servile_early_faithful_ally = { 5, 20 },
               troy_servile_faithful_ally = { 5, 20 },
               troy_trader = { 5, 20 },
               troy_trader_early = { 5, 20 },
               troy_unique_memnon = { 5, 20 },
               troy_unique_paris_hector = { 5, 20 },
               troy_unique_paris_hector_early = { 5, 20 },
               troy_unique_penthesilea = { 5, 20 },
               troy_unique_penthesilea_early = { 5, 20 },
               troy_unique_priams_troy = { 5, 20 },
               troy_unique_priams_troy_early = { 5, 20 },
               troy_unique_rhesus = { 5, 20 },
               troy_unique_sarpedon = { 5, 20 },
               troy_unique_sarpedon_early = { 5, 20 },
          },
     },

     army_size = {
          low = 10,
          medium = 15,
          --high = 20,
     },

     egyptian_culture_key = "phar_main_clt_kemets",
     hatti_culture_key = "phar_main_clt_hatti",
     canaan_culture_key = "phar_main_clt_canaan",
     sea_peoples_culture_key = "phar_main_clt_sea_peoples",

     -- for "maat_disaster_intensity" setting: the values here can also be negative (lowering the chance for a disaster to happen)
     maat_extra_disaster_chance = {
          low = {
               [1] = -10, -- during "Collapse" civilization
               [2] = -7, -- during "Crisis" civilization
               [3] = -2, -- during "Prosperity" civilization
          },
          medium = {
               [1] = 7, -- during "Collapse" civilization
               [2] = 5, -- during "Crisis" civilization
               [3] = 2, -- during "Prosperity" civilization
          },
          high = {
               [1] = 14, -- during "Collapse" civilization
               [2] = 12, -- during "Crisis" civilization
               [3] = 10, -- during "Prosperity" civilization
          },
     },
     cai_legitimacy_modifier_values = {
          ["None"] = -1.1,
          ["Low"] = -0.5,
          ["Medium"] = 0,
          ["High"] = 0.5,
          ["Option4"] = 1.0,
     },

     royal_decrees_research_rate = {
          bundle_key = "phar_main_modular_difficulty_royal_decrees_research_rate",
          low = -25, -- a value of -50 will double research time (low research rate)
          high = 100, -- a value of 150 will reduce research time by half (high research rate)
     },

     recruitment_capacity_player = {
          bundle_key = "phar_main_modular_difficulty_recruitment_capacity_player",
          effect_key = "troy_effect_army_campaign_recruitment_points",
          low = -1,
          medium = 2,
          high = 3,
     },

     recruitment_points_ai = {
          bundle_key = "phar_main_modular_difficulty_recruitment_points_ai",
          effect_key = "troy_effect_faction_unit_recruitment_points",
          low = -1,
          medium = 2,
          high = 3,
     },

     movement_action_points = {
          bundle_key = "phar_main_effect_bundle_modular_difficulty_movement_action_points",
          army_effect_key = "troy_effect_army_campaign_movement_mod_armies",
          fleet_effect_key = "troy_effect_army_campaign_movement_mod_fleets",
          low_army = -25, -- percent rate to add to the current movement points
          low_fleet = -25, -- percent rate to add to the current movement points
          medium_army = 0, -- percent rate to add to the current movement points
          medium_fleet = 0, -- percent rate to add to the current movement points
          high_army = 25, -- percent rate to add to the current movement points
          high_fleet = 25, -- percent rate to add to the current movement points
     },

     resource_availability = {
          bundle_key = "phar_main_effect_bundle_modular_difficulty_resource_availability",
          effect_key = "troy_effect_economy_add_deposit_stone", -- Pharaoh has only stone deposits in provinces - 22/12/2022
          effect_scope = "faction_to_province_own",
          low = -5000,                                  -- flat amount to add to a province's current mineral deposits
          medium = 5000,                                -- flat amount to add to a province's current mineral deposits
          high = 10000,                                 -- flat amount to add to a province's current mineral deposits
     },

     rebellion_threshold = { -- aka repression_threshold
          default = -100,
          low = -125,    -- the lower setting should make the rebellion harder to happen
          medium = -70,
          high = -50,
     },

     fully_equipped_generals = {
          randomize_order_of_ancillary_assignment = true, -- if this is false then ancillaries will be given to characters/generals in the order specified with the table below ancillary_categories
          ancillary_categories = {
               {
                    category = "armour",
                    amount_to_give = 1,
               },
               {
                    category = "shield",
                    amount_to_give = 1,
               },
               {
                    category = "weapon",
                    amount_to_give = 1,
               },
               {
                    category = "mount",
                    amount_to_give = 1,
               },
               {
                    category = "follower",
                    amount_to_give = 2,
               },
               {
                    category = "item",
                    amount_to_give = 2,
               },
          },
     },

     ai_behavior = {
          friendly_stance = "CAI_STRATEGIC_STANCE_VERY_FRIENDLY",
          aggressive_stance = "CAI_STRATEGIC_STANCE_VERY_UNFRIENDLY",
     },

     unbreakable_units = {
          bundle_key = "phar_main_modular_difficulty_unbreakable_units",
     },

     vanguard_deployment = {
          bundle_key = "phar_sea_modular_difficulty_vanguard_deployment_units",
     },

     applicable_list_of_maat_disasters = {
          "Earthquake",
          "Flood",
          "Plague",
          "Drought",
     },

     max_pretenders_to_the_throne = {
          low = 2,
          medium = 3,
          high = 4,
     },

     attrition_intensity = {
          bundle_key = "phar_main_modular_difficulty_attrition_intensity",
          effect_key = "phar_main_damage_mod_attrition_record_all",
          effect_scope = "faction_to_force_own_unseen",
          low = -25,
          medium = 25,
          high = 50,
     },

     ai_building_cost = {
          bundle_key = "phar_main_modular_difficulty_ai_building_cost",
          effect_key = "troy_effect_building_cost_mod_all",
          effect_scope = "faction_to_region_own_unseen",
          low = -25,
          medium = 25,
          high = 50,
     },

     player_replenishment = {
          bundle_key = "phar_main_modular_difficulty_player_replenishment",
          effect_key = "phar_sea_unrestricted_replenishment_bonus",
          effect_scope = "faction_to_force_own_factionwide",
          low = -25,
          --medium = 25,
          high = 50,
     },

     ai_replenishment = {
          bundle_key = "phar_main_modular_difficulty_ai_replenishment",
          effect_key = "troy_rem_rhesus_countless_host_unit_replenishment",
          effect_scope = "faction_to_faction_own_unseen",
          low = -25,
          medium = 25,
          high = 50,
     },

     ranged_unit_ammo = {
          bundle_key = "phar_main_modular_difficulty_ranged_ammo",
          effect_key = "troy_effect_army_ammunitions_all",
          effect_scope = "faction_to_force_own_factionwide",
          low = -20,
          medium = 20,
          high = 30,
     },

     player_unit_upkeep = {
          bundle_key = "troy_mth_effect_bundle_mercenaries_from_griffin_dilemma_dummy",
          effect_key = "troy_effect_army_upkeep_mod_all",
          effect_scope = "faction_to_force_own_factionwide",
          low = -25,
          medium = 25,
          high = 35,
     },

     ai_unit_upkeep = {
          bundle_key = "troy_mth_effect_bundle_mercenaries_from_griffin_dilemma_dummy",
          effect_key = "troy_effect_army_upkeep_mod_all",
          effect_scope = "faction_to_force_own_factionwide",
          low = -25,
          medium = 25,
          high = 35,
     },

     adjust_ai_public_order = {
          bundle_key = "phar_main_modular_difficulty_adjust_public_order",
          effect_key = "troy_effect_faction_public_order_difficulty_level",
          effect_scope = "faction_to_province_own_unseen",
          low = -5,
          medium = 0,
          high = 5,
     },

     adjust_player_public_order = {
          bundle_key = "phar_main_modular_difficulty_adjust_public_order",
          effect_key = "troy_effect_faction_public_order_difficulty_level",
          effect_scope = "faction_to_province_own_unseen",
          low = -5,
          medium = 0,
          high = 5,
     },

     battle_weather_effects_mod = {
          none = 0,
          low = 0.75,
          medium = 1.0,
          high = 1.25,
          very_high = 1.5
     },

     flanking_morale_penalties_mod = {
          none = 0,
          low = 0.75,
          medium = 1.0,
          high = 1.25,
          very_high = 1.5
     },

     battle_terrain_effects_mod = {
          none = 0,
          --very_low = 0.25,--
          low = 0.85,
          medium = 1,
          high = 1.15,
          very_high = 1.3
     },

     lethality_mode = {
          enabled = 0,
          disabled = 1,
          max_value = 2,
     },

     general_xp_gain = {
          None   = 0.33,
          Low    = 0.75,
          Medium = 1, -- default
          High   = 1.25,
     },

     character_aging = {
          None    = {
               age_of_elderhood_override = 80,
               base_die_chance_override = 2,
               per_year_die_chance_override = 2,
          },
          Low     = {
               age_of_elderhood_override = 80,
               base_die_chance_override = 2,
               per_year_die_chance_override = 2,
          },
          Medium  = {
               age_of_elderhood_override = 80,
               base_die_chance_override = 2,
               per_year_die_chance_override = 2,
          },
          High    = { -- defaults
               age_of_elderhood_override = 80,
               base_die_chance_override = 2,
               per_year_die_chance_override = 2,
          },
          Option4 = {
               age_of_elderhood_override = 80,
               base_die_chance_override = 2,
               per_year_die_chance_override = 2,
          },
     },
}

modular_difficulty_campaign.ui_panel = {
     name = "modular_difficulty_panel",
     layout_path = "UI/Common UI/modular_difficulty",
     apply_button = "button_accept",
     reset_button = "reset_to_defaults",
     tutorial_button = "button_tutorial",
     templates = {
          dropdown = {
               component_name = "template_dropdown",
               component = nil,
          },
          checkbox = {
               component_name = "template_toggle",
               component = nil,
          },
          slider = {
               component_name = "template_slider",
               component = nil,
          },
     },
     list_component_name = "expanding_list_items",
     settings_category_tabs = {
          campaign = "campaign",
          battle = "battle",
          ai = "ai"
     },
     settings_component_types = {
          checkbox = "checkbox",
          dropdown = "dropdown",
          slider = "slider"
     }
}

local function configure_and_apply_bundle_from_standard_dropdown(setting_name, apply_for_ai, apply_for_human)
     if not apply_for_ai and not apply_for_human then
          -- if both flags are down then nothing for us to do here
          script_error(
          "ERROR: configure_and_apply_bundle_from_standard_dropdown() called but both apply for AI/human flags are false, returning.")
          return
     end

     local state_value = mdm.state[setting_name].value
     local config = modular_difficulty_campaign.config[setting_name]
     local bundle = cm:create_new_custom_effect_bundle(config.bundle_key)

     local effect_value
     if state_value == "None" then
          -- no need to apply bundle if "default" option is selected
          -- remove the bundle by key to handle the case where user selected higher than default and went back
          if apply_for_human then
               -- this approach using get local faction is okay for modular difficulty, since this feature is not available in multiplayer
               local local_human_name = cm:get_local_faction_name()
               if local_human_name then
                    cm:remove_effect_bundle(config.bundle_key, local_human_name)
               end
          end
          if apply_for_ai then
               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local curr_faction = faction_list:item_at(i)
                    if not curr_faction:is_human() then
                         cm:remove_effect_bundle(config.bundle_key, curr_faction:name())
                    end
               end
          end

          return
     elseif state_value == "Low" then
          effect_value = config.low
     elseif state_value == "Medium" then
          effect_value = config.medium
     elseif state_value == "High" then
          effect_value = config.high
     end
     bundle:add_effect(config.effect_key, config.effect_scope, effect_value)
     bundle:set_duration(0)

     if apply_for_human then
          -- this approach using get local faction is okay for modular difficulty, since this feature is not available in multiplayer
          local local_human = cm:get_local_faction()
          if local_human then
               cm:apply_custom_effect_bundle_to_faction(bundle, local_human)
          end
     end
     if apply_for_ai then
          local faction_list = cm:model():world():faction_list()
          for i = 0, faction_list:num_items() - 1 do
               local curr_faction = faction_list:item_at(i)
               if not curr_faction:is_human() then
                    cm:apply_custom_effect_bundle_to_faction(bundle, curr_faction)
               end
          end
     end
end

modular_difficulty_campaign.settings = {
     -- Prototype setting
     -- NOTE about dropdowns: The dropdown_options table is a list of tables of the type { "option key", "localisation key" }.
     -- Option keys are fixed: "None", "Low", "Medium", "High", "Option4", "Option5", "Option6", "Option7", "Option8", "Option9", in that order.
     -- If you want to start the dropdown at a different option than "None", you can set dropdown_first_option_idx to the 0-based index of the first option in the dropdown.
     -- The localisation key should be defined in the random_localisation_strings table in the database, and should be reused if possible.
     -- See also the option_infos database tables
     --[[
	["example_setting"] = {                          -- The key of the setting. Used for localisation (database table modular_difficulty_localised_strings) and to access the setting in the code.
		achievement_key = "phar_main_ach_example",   -- Not currently used. The achievement key for this setting.
		is_locked = false,                           -- Not currently used. If this setting is locked behind an achievement.
		was_previously_locked = true,                -- Not currently used. If this setting was locked until the player unlocked the achievement.
		ui = {
			category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,          -- The category of the setting, see settings_category_tabs above
			component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,  -- The type of the component, see settings_component_types above
			campaign_changeable = true,              -- If this setting can be changed during the campaign rather than only at the start
			dropdown_first_option_idx = 1,           -- Only for dropdowns: the index of the first option in the dropdown, if the component type is dropdown, see the note above
			dropdown_options = {                     -- Only for dropdowns: the options for the dropdown, see the note above
				{"Low", "modular_difficulty_5"},     -- In this example, we start at "Low" rather than "None" because dropdown_first_option_idx is 1
				{"Medium", "modular_difficulty_2"},
				{"High", "modular_difficulty_4"},
			},
			ui_order = 1,                            -- The order of the setting in the UI
		},
		default_value = "Low",                       -- The default value of the setting. An option key from the dropdown_options table, 0/1 for checkboxes, or a number for sliders.
		callback = function()                        -- The callback function for the setting
			local state_value = mdm.state["example_setting"].value
			-- Apply the setting to the game state here
		end,
	},
	]] --
     ["ironman"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
               ui_order = 20,
          },
          default_value = 0,
          callback = function()
               local state_value = mdm.state["ironman"].value
               cm:enable_legendary_mode_restrictions(state_value == 1 and true or false)
          end,
     },
     ["player_unit_upkeep"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 34,
          },
          default_value = "None",
          callback = function()
               configure_and_apply_bundle_from_standard_dropdown("player_unit_upkeep", false, true)
          end,
     },
     ["ai_unit_upkeep"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.ai,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 53,
          },
          default_value = "None",
          callback = function()
               configure_and_apply_bundle_from_standard_dropdown("ai_unit_upkeep", true, false)
          end,
     },
     ["player_budget"] = {
          achievement_key = "phar_main_ach_al_akhenaten_amarna",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = false,
               ui_order = 1,
          },
          default_value = "None",
          callback = function()
               local player_faction_key = cm:get_local_faction_name()
               if not player_faction_key then
                    -- no local faction means this is an autorun, returning
                    return
               end
               local state_value = mdm.state["player_budget"].value
               local resource_to_give = {
                    food =
                    {
                         key    = "troy_food",
                         factor = "troy_resource_factor_faction",
                         value  = 0
                    },
                    stone =
                    {
                         key    = "troy_stones",
                         factor = "troy_resource_factor_faction",
                         value  = 0
                    },
                    wood =
                    {
                         key    = "troy_wood",
                         factor = "troy_resource_factor_faction",
                         value  = 0
                    },
                    bronze =
                    {
                         key    = "troy_bronze",
                         factor = "troy_resource_factor_faction",
                         value  = 0
                    },
                    gold =
                    {
                         key    = "troy_gold",
                         factor = "troy_resource_factor_faction",
                         value  = 0
                    },
               }
               if state_value == "None" then
                    -- default value, do nothing.
               elseif state_value == "Low" then
                    resource_to_give.food.value   = -2400
                    resource_to_give.stone.value  = -600
                    resource_to_give.wood.value   = -100
                    resource_to_give.bronze.value = -350
                    resource_to_give.gold.value   = -70
               elseif state_value == "Medium" then
                    resource_to_give.food.value   = 2750
                    resource_to_give.stone.value  = 550
                    resource_to_give.wood.value   = 150
                    resource_to_give.bronze.value = 450
                    resource_to_give.gold.value   = 110
               elseif state_value == "High" then
                    resource_to_give.food.value   = 5500
                    resource_to_give.stone.value  = 1200
                    resource_to_give.wood.value   = 300
                    resource_to_give.bronze.value = 800
                    resource_to_give.gold.value   = 180
               end

               for _, resource in dpairs(resource_to_give) do
                    cm:faction_add_pooled_resource(player_faction_key, resource.key, resource.factor, resource.value)
               end
          end,
     },
     ["ai_budget"] = {
          achievement_key = "phar_main_ach_al_muwatalli_vassals",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.ai,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = false,
               ui_order = 40,
          },
          default_value = "None",
          callback = function()
               local state_value = mdm.state["ai_budget"].value
               local resource_to_give = {
                    food =
                    {
                         key    = "troy_food",
                         factor = "troy_resource_factor_faction",
                         value  = 0
                    },
                    stone =
                    {
                         key    = "troy_stones",
                         factor = "troy_resource_factor_faction",
                         value  = 0
                    },
                    wood =
                    {
                         key    = "troy_wood",
                         factor = "troy_resource_factor_faction",
                         value  = 0
                    },
                    bronze =
                    {
                         key    = "troy_bronze",
                         factor = "troy_resource_factor_faction",
                         value  = 0
                    },
                    gold =
                    {
                         key    = "troy_gold",
                         factor = "troy_resource_factor_faction",
                         value  = 0
                    },
               }

               if state_value == "None" then
                    -- default value, do nothing.
               elseif state_value == "Low" then
                    resource_to_give.food.value   = -100
                    resource_to_give.stone.value  = -100
                    resource_to_give.wood.value   = -100
                    resource_to_give.bronze.value = -100
                    resource_to_give.gold.value   = -100
               elseif state_value == "Medium" then
                    resource_to_give.food.value   = 100
                    resource_to_give.stone.value  = 100
                    resource_to_give.wood.value   = 100
                    resource_to_give.bronze.value = 100
                    resource_to_give.gold.value   = 100
               elseif state_value == "High" then
                    resource_to_give.food.value   = 500
                    resource_to_give.stone.value  = 500
                    resource_to_give.wood.value   = 500
                    resource_to_give.bronze.value = 500
                    resource_to_give.gold.value   = 500
               end

               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local curr_faction = faction_list:item_at(i)
                    local curr_faction_key = curr_faction:name()
                    if not curr_faction:is_human() then
                         for _, resource in dpairs(resource_to_give) do
                              cm:faction_add_pooled_resource(curr_faction_key, resource.key, resource.factor,
                                   resource.value)
                         end
                    end
               end
          end,
     },
     ["ai_building_cost"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.ai,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 46,
          },
          default_value = "None",
          callback = function()
               configure_and_apply_bundle_from_standard_dropdown("ai_building_cost", true, false)
          end,
     },
     ["player_replenishment"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 33,
               dropdown_options = {
                    { "Default", "modular_difficulty_1" },
                    { "Low",     "modular_difficulty_2" },
                    { "High",    "modular_difficulty_4" },
               },
          },
          default_value = "None",
          callback = function()
               configure_and_apply_bundle_from_standard_dropdown("player_replenishment", false, true)
          end,
     },
     ["ai_replenishment"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.ai,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 44,
          },
          default_value = "None",
          callback = function()
               configure_and_apply_bundle_from_standard_dropdown("ai_replenishment", true, false)
          end,
     },
     ["enslave_sack_no_replenish"] = {
          achievement_key = "phar_main_ach_amen_conf_any_faction",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
               ui_order = 31,
          },
          default_value = 0,
          callback = function()
               local state_value = mdm.state["enslave_sack_no_replenish"].value
               local bundle_key = "phar_main_modular_difficulty_enslave_sack_replenish"
               local bundle = cm:create_new_custom_effect_bundle(bundle_key)
               bundle:add_effect("troy_rem_rhesus_countless_host_army_cannot_enslave", "faction_to_force_own_factionwide",
                    state_value)
               bundle:set_duration(0)

               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local curr_faction = faction_list:item_at(i)
                    cm:apply_custom_effect_bundle_to_faction(bundle, curr_faction)
               end
          end,
     },
     ["no_retreat"] = {
          achievement_key = "phar_main_ach_local_deities_max_3",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.battle,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
               ui_order = 38,
          },
          default_value = 0,
          callback = function()
               local state_value = mdm.state["no_retreat"].value
               modular_difficulty_campaign.variables.no_retreat = state_value ~= 0 or false
          end,
     },
     ["adjust_player_public_order"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 35,
          },
          default_value = "None",
          callback = function()
               configure_and_apply_bundle_from_standard_dropdown("adjust_player_public_order", false, true)
          end,
     },
     ["adjust_ai_public_order"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.ai,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 48,
          },
          default_value = "None",
          callback = function()
               configure_and_apply_bundle_from_standard_dropdown("adjust_ai_public_order", true, false)
          end,
     },
     ["attrition_intensity"] = {
          achievement_key = "phar_main_ach_battle_fire",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 24,
          },
          default_value = "None",
          callback = function()
               configure_and_apply_bundle_from_standard_dropdown("attrition_intensity", true, true)
          end,
     },
     ["recruitment_capacity_player"] = {
          achievement_key = "phar_main_ach_sup_province_growth",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = false,
               ui_order = 13,
          },
          default_value = "None",
          callback = function()
               local state_value = mdm.state["recruitment_capacity_player"].value

               local recruitment_cap_mod = nil
               if state_value == "None" then
                    recruitment_cap_mod = 0
               elseif state_value == "Low" then
                    recruitment_cap_mod = modular_difficulty_campaign.config.recruitment_capacity_player.low
               elseif state_value == "Medium" then
                    recruitment_cap_mod = modular_difficulty_campaign.config.recruitment_capacity_player.medium
               elseif state_value == "High" then
                    recruitment_cap_mod = modular_difficulty_campaign.config.recruitment_capacity_player.high
               end

               if not recruitment_cap_mod then
                    return
               end

               local player_faction = cm:get_local_faction(true)
               if not player_faction or player_faction:is_null_interface() then
                    return
               end

               local bundle = cm:create_new_custom_effect_bundle(modular_difficulty_campaign.config
               .recruitment_capacity_player.bundle_key)
               bundle:add_effect(modular_difficulty_campaign.config.recruitment_capacity_player.effect_key,
                    "faction_to_province_own", recruitment_cap_mod)
               bundle:add_effect(modular_difficulty_campaign.config.recruitment_capacity_player.effect_key,
                    "faction_to_force_own", recruitment_cap_mod)                                                                             -- covers the case that the player faction is a "horde" faction
               bundle:set_duration(0)

               cm:apply_custom_effect_bundle_to_faction(bundle, player_faction)
          end,
     },
     ["ranged_unit_ammo"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.battle,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 39,
          },
          default_value = "None",
          callback = function()
               configure_and_apply_bundle_from_standard_dropdown("ranged_unit_ammo", true, true)
          end
     },
     ["sea_people_invasions"] = {
          achievement_key = "phar_main_ach_survive_sea_people",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
               ui_order = 32,
          },
          default_value = 1,
          callback = function()
               local state_value = (mdm.state["sea_people_invasions"].value == 1) and true or false
               modular_difficulty_campaign.variables.sea_people_invasions = state_value
               core:trigger_event("ScriptedEventSeaPeopleIntensityUpdate")
          end
     },
     ["total_annihilation"] = {
          achievement_key = "phar_main_ach_seti_war_egypt",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
               ui_order = 30,
          },
          default_value = 0,
          callback = function()
               local state_value = (mdm.state["total_annihilation"].value == 1) and true or false
               modular_difficulty_campaign.variables.total_annihilation = state_value
          end
     },
     ["no_alliances"] = {
          achievement_key = "phar_main_ach_bay_backstab",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.ai,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 42,
          },
          default_value = 0,
          callback = function()
               local state_value = (mdm.state["no_alliances"].value == 1) and true or false

               --when state value is enabled, we want to apply
               if state_value == true then
                    local faction_list = cm:model():world():faction_list()
                    for i = 0, faction_list:num_items() - 1 do
                         local curr_faction = faction_list:item_at(i)
                         if (curr_faction:num_allies() > 0) then
                              local defensive_allies = curr_faction:factions_defensive_alliance_with();
                              local military_allies = curr_faction:factions_military_alliance_with();



                              if defensive_allies then
                                   for i = 0, defensive_allies:num_items() - 1 do
                                        cm:force_break_alliance(curr_faction:name(), defensive_allies:item_at(i):name(),
                                             true)
                                   end
                              end
                              if military_allies then
                                   for i = 0, military_allies:num_items() - 1 do
                                        cm:force_break_alliance(curr_faction:name(), military_allies:item_at(i):name(),
                                             true)
                                   end
                              end
                         end
                    end
                    -- if state value is true (enabled), we want to pass false state value to force_diplomacy (preventing alliances)
                    cm:force_diplomacy("all", "all", "military alliance", not state_value, not state_value, false, false)
                    cm:force_diplomacy("all", "all", "defensive alliance", not state_value, not state_value, false, false)
               end
          end
     },
     ["no_rebellions"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
               ui_order = 26,
          },
          default_value = 0,
          callback = function()
               local state_value = (mdm.state["no_rebellions"].value == 1) and true or false
               modular_difficulty_campaign.variables.no_rebellions = state_value

               cm:disable_rebellions_worldwide(state_value)

               if state_value == true then
                    --destroy rebel armies
                    local rebels_faction = cm:model():faction_for_command_queue_index(1);
                    local rebel_forces = rebels_faction:military_force_list()
                    for i = 0, rebel_forces:num_items() - 1 do
                         force = rebel_forces:item_at(i)
                         if not force:is_null_interface() then
                              cm:destroy_military_force(force:command_queue_index())
                         end
                    end
               end
          end
     },
     ["no_influence_manager"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
          },
          default_value = 0,
          callback = function()
               local state_value = (mdm.state["no_influence_manager"].value == 1) and true or false
               if phar_influence_monitor then
                    if phar_influence_monitor.variables.influence_tiers_disabled ~= state_value then
                         phar_influence_monitor.variables.influence_tiers_disabled = state_value
                         core:trigger_event("ScriptedEventInfluenceManagerStateChanged")
                    end
               end
          end
     },
     ["no_fog_of_war"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 27,
          },
          default_value = 0,
          callback = function()
               local state_value = (mdm.state["no_fog_of_war"].value == 1) and true or false
               modular_difficulty_campaign.variables.no_fog_of_war = state_value

               local region_keys = {}
               if state_value == true then
                    local region_list = cm:model():world():region_manager():region_list()
                    for i = 0, region_list:num_items() - 1 do
                         table.insert(region_keys, region_list:item_at(i):name())
                    end
                    cm:make_regions_visible_in_shroud_for_faction(cm:get_local_faction_name(), region_keys)
               end
          end
     },
     ["no_ai_trade_offers"] = {
          achievement_key = "phar_main_ach_al_hatshepsut_realms",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.ai,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 41,
          },
          default_value = 0,
          callback = function()
               local state_value = (mdm.state["no_ai_trade_offers"].value == 1) and true or false

               --when state value is enabled, we want to apply
               if state_value == true then
                    local faction_list = cm:model():world():faction_list()
                    local player_faction
                    for i = 0, faction_list:num_items() - 1 do
                         if faction_list:item_at(i):is_human() then
                              player_faction = faction_list:item_at(i):name()
                              break
                         end
                    end
                    -- if state value is true (enabled), we want to pass false state value to force_diplomacy (preventing trades)
                    cm:force_diplomacy("all", string.format("faction:%s", player_faction),
                         "barter agreements, single barters", not state_value, true, false, false)
               end
          end
     },
     ["random_personalities"] = {
          achievement_key = "phar_main_ach_become_great_king",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 4,
          },
          default_value = 0,
          callback = function()
               local state_value = (mdm.state["random_personalities"].value == 1) and true or false
               --Random start pos feature will most likely need a separate modular difficulty config file. cai_personalities
               -- table will be moved to it.
               local cai_personalities = {
                    "phar_main_canaanites_easy",
                    "phar_main_canaanites_easy_early",
                    "phar_main_canaanites_hard",
                    "phar_main_canaanites_hard_early",
                    "phar_main_canaanites_normal",
                    "phar_main_canaanites_normal_early",
                    "phar_main_egyptians_easy",
                    "phar_main_egyptians_easy_early",
                    "phar_main_egyptians_hard",
                    "phar_main_egyptians_hard_early",
                    "phar_main_egyptians_normal",
                    "phar_main_egyptians_normal_early",
                    "phar_main_hittites_easy",
                    "phar_main_hittites_easy_early",
                    "phar_main_hittites_hard",
                    "phar_main_hittites_hard_early",
                    "phar_main_hittites_normal",
                    "phar_main_hittites_normal_early",
                    "phar_main_hordes_easy",
                    "phar_main_hordes_easy_early",
                    "phar_main_hordes_hard",
                    "phar_main_hordes_hard_early",
                    "phar_main_hordes_normal",
                    "phar_main_hordes_normal_early",
                    "phar_main_kushites_easy",
                    "phar_main_kushites_easy_early",
                    "phar_main_kushites_hard",
                    "phar_main_kushites_hard_early",
                    "phar_main_kushites_normal",
                    "phar_main_kushites_normal_early",
                    "phar_main_playable_campaign_personality_aggressive",
                    "phar_main_playable_campaign_personality_defensive",
                    "phar_main_playable_campaign_personality_passive",
                    "phar_main_playable_campaign_personality_plah",
                    "phar_main_unique_amenmesse_easy",
                    "phar_main_unique_amenmesse_easy_early",
                    "phar_main_unique_amenmesse_hard",
                    "phar_main_unique_amenmesse_hard_early",
                    "phar_main_unique_amenmesse_normal",
                    "phar_main_unique_amenmesse_normal_early",
                    "phar_main_unique_bay_easy",
                    "phar_main_unique_bay_easy_early",
                    "phar_main_unique_bay_hard",
                    "phar_main_unique_bay_hard_early",
                    "phar_main_unique_bay_normal",
                    "phar_main_unique_bay_normal_early",
                    "phar_main_unique_irsu_easy",
                    "phar_main_unique_irsu_easy_early",
                    "phar_main_unique_irsu_hard",
                    "phar_main_unique_irsu_hard_early",
                    "phar_main_unique_irsu_normal",
                    "phar_main_unique_irsu_normal_early",
                    "phar_main_unique_kurunta_easy",
                    "phar_main_unique_kurunta_easy_early",
                    "phar_main_unique_kurunta_hard",
                    "phar_main_unique_kurunta_hard_early",
                    "phar_main_unique_kurunta_normal",
                    "phar_main_unique_kurunta_normal_early",
                    "phar_main_unique_ramesses_easy",
                    "phar_main_unique_ramesses_easy_early",
                    "phar_main_unique_ramesses_hard",
                    "phar_main_unique_ramesses_hard_early",
                    "phar_main_unique_ramesses_normal",
                    "phar_main_unique_ramesses_normal_early",
                    "phar_main_unique_seti_easy",
                    "phar_main_unique_seti_easy_early",
                    "phar_main_unique_seti_hard",
                    "phar_main_unique_seti_hard_early",
                    "phar_main_unique_seti_normal",
                    "phar_main_unique_seti_normal_early",
                    "phar_main_unique_suppiliuma_easy",
                    "phar_main_unique_suppiliuma_easy_early",
                    "phar_main_unique_suppiliuma_hard",
                    "phar_main_unique_suppiliuma_hard_early",
                    "phar_main_unique_suppiliuma_normal",
                    "phar_main_unique_suppiliuma_normal_early",
                    "phar_main_unique_tausret_easy",
                    "phar_main_unique_tausret_easy_early",
                    "phar_main_unique_tausret_hard",
                    "phar_main_unique_tausret_hard_early",
                    "phar_main_unique_tausret_normal",
                    "phar_main_unique_tausret_normal_early",

               }
               local faction_list = cm:model():world():faction_list()
               local personalities_table_length = table.maxn(cai_personalities)

               if state_value == true then
                    for i = 0, faction_list:num_items() - 1 do
                         local curr_faction = faction_list:item_at(i)
                         if not curr_faction:is_human() then
                              local random_personality = cai_personalities
                              [cm:model():random_int(1, personalities_table_length)]
                              cm:force_change_cai_faction_personality(curr_faction:name(), random_personality)
                         end
                    end
               end
          end
     },
     ["no_auto_resolve"] = {
          achievement_key = "phar_main_ach_sup_annex_kurunta",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.battle,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 37,
          },
          default_value = 0,
          callback = function()
               local state_value = (mdm.state["no_auto_resolve"].value == 1) and true or false

               if (state_value) then
                    uim:override("hide_pre_battle_autoresolve"):lock()
                    uim:override("hide_pre_battle_autoresolve"):set_allowed(false)
               else
                    uim:override("hide_pre_battle_autoresolve"):unlock()
                    uim:override("hide_pre_battle_autoresolve"):set_allowed(true)
               end
          end
     },
     ["no_trading"] = {
          achievement_key = "phar_main_ach_al_hatshepsut_realms",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
               ui_order = 22,
          },
          default_value = 0,
          callback = function()
               local is_trading_enabled = mdm.state["no_trading"].value ~= 1

               -- Apply the effect on the start of the player's next turn (by design)
               -- The modular difficulty callback() functions are called after load,
               -- so no need to worry about exiting the game after the below listener is added
               core:add_listener(
                    "modular_difficulty_no_trading",
                    "FactionTurnStart",
                    function(context)
                         return context:faction():name() == cm:get_local_faction_name(true)
                    end,
                    function(context)
                         cm:faction_allow_trading(context:faction(), is_trading_enabled)
                    end,
                    false
               )
          end
     },
     ["trespassing_diplomatic_penalty_disabled"] = {
          achievement_key = "phar_main_ach_ambitions",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
               ui_order = 23,
          },
          default_value = 0,
          callback = function()
               local is_penalty_enabled = mdm.state["trespassing_diplomatic_penalty_disabled"].value ~= 1

               cm:set_trespassing_diplomatic_penalty_enabled(is_penalty_enabled)
          end
     },
     ["diplomatic_requirements_thresholds"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = false,
               ui_order = 7,
          },
          default_value = "None",
          callback = function()
               local cfg = modular_difficulty_campaign.config.diplomatic_requirements_thresholds

               local effect_bundle_key = cfg.bundle_key
               local state_value = mdm.state["diplomatic_requirements_thresholds"].value
               local effect_value = 0

               if state_value == "Low" then
                    effect_value = cfg.low
               elseif state_value == "Medium" then
                    effect_value = cfg.medium
               elseif state_value == "High" then
                    effect_value = cfg.high
               end

               local faction = cm:get_local_faction(true)
               cm:remove_effect_bundle(effect_bundle_key, faction:name())

               if effect_value ~= 0 then
                    local custom_effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)

                    if custom_effect_bundle:effects():num_items() > 0 then
                         custom_effect_bundle:set_effect_value(custom_effect_bundle:effects():item_at(0), effect_value)
                         cm:apply_custom_effect_bundle_to_faction(custom_effect_bundle, faction)
                    end
               end
          end
     },
     ["diplomatic_deal_distance_penalties_for_war"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.ai,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_options = {
                    { "none",      "none" },
                    { "low",       "modular_difficulty_2" },
                    { "medium",    "modular_difficulty_3" },
                    { "high",      "modular_difficulty_1" }, -- default
                    { "very_high", "modular_difficulty_6" },
               },
               campaign_changeable = true,
               ui_order = 8,
          },
          default_value = "High",
          callback = function()
               local cfg = modular_difficulty_campaign.config.diplomatic_deal_distance_penalties_for_war
               local state_value = mdm.state["diplomatic_deal_distance_penalties_for_war"].value
               local penalties_table = cfg[state_value]

               if penalties_table and is_table(penalties_table) then
                    for personality_key, penalty_min_max in pairs(penalties_table) do
                         -- Set the float shared states for the min and max penalties of the WAR deal component for the given personality.
                         -- The format of the state key is "long_distance_penalty_<min/max>_<deal component key>_<personality key>"
                         cm:set_script_state("long_distance_penalty_min_WAR_" .. personality_key, penalty_min_max[1])
                         cm:set_script_state("long_distance_penalty_max_WAR_" .. personality_key, penalty_min_max[2])
                    end
               end
          end
     },
     ["army_size"] = {
          achievement_key = "phar_main_ach_sup_kill_kurunta",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = false,
               dropdown_first_option_idx = 1,
               dropdown_options = {
                    { "default", "modular_difficulty_1" },
                    { "low",     "modular_difficulty_2" },
                    { "mid",     "modular_difficulty_3" },
               },
               ui_order = 12,
          },
          default_value = "Low",
          callback = function()
               -- nothing to do. this is set only in the UI before starting new campaign
          end,
          callback_pre_campaign_start = function()
               local state_value = mdm.state["army_size"].value

               local cfg = modular_difficulty_campaign.config.army_size
               -- because we want the settings for the dropdowns to have localised names,
               -- internally we use a vector of 4 strings (s_dropdown_string_options in OptionsModularDifficulty.cpp) to contain the possible values for the dropdown options
               -- so dropdowns with 4 options always have "None", "low", "Medium", "High" as options internally, no matter what the localised strings in the UI say
               -- and in this case, when we have 3 options, we should always use "Low", "Medium", "High" for the state of the setting, hence why we have the weird situation
               -- of having "Medium" state when using the setting listed as "Low" in the UI

               local max_units = 20
               if state_value == "Low" then
                    -- do nothing, corresponds to default value.
               elseif state_value == "Medium" then
                    max_units = cfg.low
               elseif state_value == "High" then
                    max_units = cfg.medium
               end

               local ui_root = core:get_ui_root()
               if not ui_root then
                    return
               end

               local uic_sp_grand_campaign = ui_root:SequentialFind("sp_grand_campaign")
               if uic_sp_grand_campaign then
                    uic_sp_grand_campaign:InterfaceFunction("set_max_army_size", max_units)
               end
          end
     },
     ["random_startpos"] = {
          achievement_key = "phar_main_ach_become_pharaoh",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 3,
          },
          default_value = 0,
          callback = function()
               local state_value = (mdm.state["random_startpos"].value == 1) and true or false
               core:trigger_event("ModularDifficultyRandomStartPosEnabled", state_value)
          end
     },
     ["shuffle_commands"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 3,
          },
          default_value = 0,
     },
     ["allow_egyptian_gods"] = {
          achievement_key = "phar_main_ach_discover_realms_egypt",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 9,
          },
          default_value = 1,
          callback = function()
               local setting_state = mdm.state["allow_egyptian_gods"].value == 1
               if not setting_state then
                    table.insert(modular_difficulty_campaign.variables.excluded_god_culture_keys,
                         modular_difficulty_campaign.config.egyptian_culture_key)
               end
          end
     },
     ["allow_hatti_gods"] = {
          achievement_key = "phar_main_ach_discover_realms_hatti",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 10,
          },
          default_value = 1,
          callback = function()
               local setting_state = mdm.state["allow_hatti_gods"].value == 1
               if not setting_state then
                    table.insert(modular_difficulty_campaign.variables.excluded_god_culture_keys,
                         modular_difficulty_campaign.config.hatti_culture_key)
               end
          end
     },
     ["allow_canaan_gods"] = {
          achievement_key = "phar_main_ach_discover_realms_canaan",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 11,
          },
          default_value = 1,
          callback = function()
               local setting_state = mdm.state["allow_canaan_gods"].value == 1
               if not setting_state then
                    table.insert(modular_difficulty_campaign.variables.excluded_god_culture_keys,
                         modular_difficulty_campaign.config.canaan_culture_key)
               end
          end
     },
     ["gods_autodiscovered"] = {
          achievement_key = "phar_main_ach_discover_realms_all",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 8,
          },
          default_value = 0,
          callback = function()
               -- work done on `mdm_new_campaign_init` listener
          end
     },
     ["toggle_maat"] = {
          achievement_key = "phar_main_ach_maat_crisis",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 14,
          },
          default_value = 1,
          callback_on_new_campaign_started_event = function()
               local maat_enabled = mdm.state["toggle_maat"].value == 1
               pillars_civilization.set_system_enabled(maat_enabled)
          end,
     },
     ["maat_disaster_intensity"] = {
          achievement_key = "phar_main_ach_survive_sea_people",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 19,
          },
          default_value = "None",
          callback = function()
               local state_setting = mdm.state["maat_disaster_intensity"].value

               if state_setting == "None" then
                    modular_difficulty_campaign.variables.maat_extra_disaster_chance = {}
               elseif state_setting == "Low" then
                    modular_difficulty_campaign.variables.maat_extra_disaster_chance = modular_difficulty_campaign
                    .config.maat_extra_disaster_chance.low
               elseif state_setting == "Medium" then
                    modular_difficulty_campaign.variables.maat_extra_disaster_chance = modular_difficulty_campaign
                    .config.maat_extra_disaster_chance.medium
               elseif state_setting == "High" then
                    modular_difficulty_campaign.variables.maat_extra_disaster_chance = modular_difficulty_campaign
                    .config.maat_extra_disaster_chance.high
               end
          end,
     },
     ["maat_visual_override"] = {
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 15,
               dropdown_first_option_idx = 0,
               dropdown_options = {
                    { "none",   "modular_difficulty_none" },
                    { "low",    "modular_difficulty_maat_level_collapse" },
                    { "medium", "modular_difficulty_maat_level_crisis" },
                    { "high",   "modular_difficulty_maat_level_prosperity" },
               },
          },
          default_value = "None",
          callback = function()
               local state_setting = mdm.state["maat_visual_override"].value

               if state_setting == "None" then
                    pillars_civilization.persistent.visual_level_override_index = 0
               elseif state_setting == "Low" then
                    pillars_civilization.persistent.visual_level_override_index = 1
               elseif state_setting == "Medium" then
                    pillars_civilization.persistent.visual_level_override_index = 2
               elseif state_setting == "High" then
                    pillars_civilization.persistent.visual_level_override_index = 3
               end

               -- Enforce the visual override immediately when changed during the campaign.
               pillars_civilization.update_visuals()
          end,
     },
     ["cai_legitimacy_modifier"] = {
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 20,
               dropdown_first_option_idx = 0,
               dropdown_options = {
                    { "none",      "modular_difficulty_none" },
                    { "low",       "modular_difficulty_2" },
                    { "medium",    "modular_difficulty_1" }, --deafult--
                    { "high",      "modular_difficulty_4" },
                    { "very high", "modular_difficulty_6" },
               },
          },
          default_value = "Medium",
          callback = function()
               local state_setting = mdm.state["cai_legitimacy_modifier"].value

               modular_difficulty_campaign.variables.cai_legitimacy_modifier_value = modular_difficulty_campaign.config
               .cai_legitimacy_modifier_values[state_setting] or 0
          end,
     },
     ["royal_decrees_research_rate"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_first_option_idx = 1,
               dropdown_options = {
                    { "default", "modular_difficulty_1" },
                    { "low",     "modular_difficulty_2" },
                    { "high",    "modular_difficulty_4" },
               },
               campaign_changeable = false,
               ui_order = 6,
          },
          default_value = "Low",
          callback = function()
               local state_setting = mdm.state["royal_decrees_research_rate"].value
               local cfg = modular_difficulty_campaign.config.royal_decrees_research_rate

               -- because we want the settings for the dropdowns to have localised names,
               -- internally we use a vector of 4 strings (s_dropdown_string_options in OptionsModularDifficulty.cpp) to contain the possible values for the dropdown options
               -- so dropdowns with 4 options always have "None", "low", "Medium", "High" as options internally, no matter what the localised strings in the UI say
               -- and in this case, when we have 3 options, we should always use "Low", "Medium", "High" for the state of the setting, hence why we have the weird situation
               -- of having "Medium" state when using the setting listed as "Low" in the UI
               local bundle_value = nil
               if state_setting == "Low" then
                    -- do nothing, this is the default case, corresponds to "Default" option in the dropdown
               elseif state_setting == "Medium" then
                    bundle_value = cfg.low -- corresponds to selecting "Low" in the dropdown
               elseif state_setting == "High" then
                    bundle_value = cfg.high -- corresponds to selecting "High" in the dropdown
               end

               if not bundle_value then
                    return
               end

               local modded_research_rate_bundle = cm:create_new_custom_effect_bundle(cfg.bundle_key)
               local first_effect = modded_research_rate_bundle:effects():item_at(0) -- should be "troy_effect_faction_research_rate_mod"
               modded_research_rate_bundle:set_effect_value(first_effect, bundle_value)

               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local faction = faction_list:item_at(i)
                    if faction and not faction:is_null_interface() and not faction:is_rebel() and not faction:is_dead() then
                         cm:apply_custom_effect_bundle_to_faction(modded_research_rate_bundle, faction)
                    end
               end
          end
     },
     ["fully_leveled_generals"] = {
          achievement_key = "phar_main_ach_al_thutmose_conquest",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
               ui_order = 29,
          },
          default_value = 0,
          callback = function(called_mid_game)
               local active = mdm.state["fully_leveled_generals"].value == 1
               if not active then
                    core:remove_listener("modular_difficulty_fully_leveled_generals_CharacterCreated")
                    core:remove_listener("modular_difficulty_fully_leveled_generals_NewCharacterRecruited")
                    cm:remove_script_state("fully_leveled_generals_modular_difficulty")
                    return
               end

               -- fully rank-up any newly created character
               core:add_listener("modular_difficulty_fully_leveled_generals_CharacterCreated",
                    "CharacterCreated",
                    true,
                    function(context)
                         local character = context:character()
                         if not cm:char_is_general(character) then
                              return
                         end

                         local max_rank = cm:set_rank_to_max(cm:char_lookup_str(character))
                         cm:set_script_state("fully_leveled_generals_modular_difficulty", max_rank + 1)
                    end,
                    true,
                    true) -- prevent adding the listener multiple times

               -- fully rank-up any newly recruited general
               core:add_listener("modular_difficulty_fully_leveled_generals_NewCharacterRecruited",
                    "NewCharacterRecruited",
                    true,
                    function(context)
                         local character = context:character()
                         if not cm:char_is_general(character) then
                              return
                         end

                         local max_rank = cm:set_rank_to_max(cm:char_lookup_str(character))
                         cm:set_script_state("fully_leveled_generals_modular_difficulty", max_rank + 1)
                    end,
                    true,
                    true) -- prevent adding the listener multiple times

               -- `called_mid_game` flag is used here because we want the code below to happen only at the start of the game
               if called_mid_game then
                    return
               end

               local max_rank = 0

               -- fully rank-up all generals in the world
               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local faction = faction_list:item_at(i)
                    if faction and not faction:is_null_interface() and not faction:is_dead() then
                         local character_list = faction:character_list()
                         for j = 0, character_list:num_items() - 1 do
                              local character = character_list:item_at(j)
                              if cm:char_is_general(character) then
                                   max_rank = cm:set_rank_to_max(cm:char_lookup_str(character))
                              end
                         end
                    end
               end

               cm:set_script_state("fully_leveled_generals_modular_difficulty", max_rank + 1)
          end
     },
     ["movement_action_points"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 21,
          },
          default_value = "None",
          callback = function()
               local state_setting = mdm.state["movement_action_points"].value

               local cfg = modular_difficulty_campaign.config.movement_action_points

               local army_value = nil
               local fleet_value = nil
               if state_setting == "None" then
                    army_value = nil
                    fleet_value = nil
               elseif state_setting == "Low" then
                    army_value = cfg.low_army
                    fleet_value = cfg.low_fleet
               elseif state_setting == "Medium" then
                    army_value = cfg.medium_army
                    fleet_value = cfg.medium_fleet
               elseif state_setting == "High" then
                    army_value = cfg.high_army
                    fleet_value = cfg.high_fleet
               end

               if not army_value or not fleet_value then
                    core:remove_listener("modular_difficulty_action_points_FactionLiberated")

                    local faction_list = cm:model():world():faction_list()
                    for i = 0, faction_list:num_items() - 1 do
                         local faction = faction_list:item_at(i)
                         if faction and not faction:is_null_interface() and not faction:is_dead() then
                              cm:remove_effect_bundle(cfg.bundle_key, faction:name())
                         end
                    end
                    return
               end

               local faction_bundle = cm:create_new_custom_effect_bundle(cfg.bundle_key)
               faction_bundle:add_effect(cfg.army_effect_key, "faction_to_force_own", army_value)
               faction_bundle:add_effect(cfg.fleet_effect_key, "faction_to_force_own", fleet_value)
               faction_bundle:set_duration(0)

               -- apply bundle to all forces in the world and any force that will be created for the remainder of the campaign
               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local faction = faction_list:item_at(i)
                    if faction and not faction:is_null_interface() and not faction:is_dead() then
                         cm:apply_custom_effect_bundle_to_faction(faction_bundle, faction)
                    end
               end

               -- apply bundle to any newly created/revived faction
               core:add_listener("modular_difficulty_action_points_FactionLiberated",
                    "FactionLiberated",
                    true,
                    function(context)
                         cm:apply_custom_effect_bundle_to_faction(faction_bundle, context:faction())
                    end,
                    true)
          end
     },
     ["resource_availability"] = {
          achievement_key = "phar_main_ach_amen_conquer_nile",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = false,
               ui_order = 2,
          },
          default_value = "None",
          callback = function()
               configure_and_apply_bundle_from_standard_dropdown("resource_availability", true, true)
          end
     },
     ["recruitment_points_ai"] = {
          achievement_key = "phar_main_ach_irsu_raze_ers",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.ai,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 45,
          },
          default_value = "None",
          callback = function()
               local state_value = mdm.state["recruitment_points_ai"].value

               local recruitment_mod = nil
               if state_value == "None" then
                    recruitment_mod = 0
               elseif state_value == "Low" then
                    recruitment_mod = modular_difficulty_campaign.config.recruitment_points_ai.low
               elseif state_value == "Medium" then
                    recruitment_mod = modular_difficulty_campaign.config.recruitment_points_ai.medium
               elseif state_value == "High" then
                    recruitment_mod = modular_difficulty_campaign.config.recruitment_points_ai.high
               end

               if recruitment_mod == nil then
                    return
               end

               local bundle_key = modular_difficulty_campaign.config.recruitment_points_ai.bundle_key
               local ai_faction_bundle = cm:create_new_custom_effect_bundle(bundle_key)
               ai_faction_bundle:add_effect(modular_difficulty_campaign.config.recruitment_points_ai.effect_key,
                    "faction_to_province_own", recruitment_mod)
               ai_faction_bundle:add_effect(modular_difficulty_campaign.config.recruitment_points_ai.effect_key,
                    "faction_to_force_own", recruitment_mod)                                                                                  -- "horde" faction
               ai_faction_bundle:set_duration(0)

               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local faction = faction_list:item_at(i)
                    if faction and not faction:is_null_interface() and not faction:is_dead() and not faction:is_human() then
                         cm:apply_custom_effect_bundle_to_faction(ai_faction_bundle, faction)
                    end
               end
          end,
     },
     ["rebellion_threshold"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = true,
               ui_order = 25,
          },
          default_value = "None",
          callback = function()
               local state_setting = mdm.state["rebellion_threshold"].value

               local value = nil
               if state_setting == "None" then
                    value = modular_difficulty_campaign.config.rebellion_threshold.default
               elseif state_setting == "Low" then
                    value = modular_difficulty_campaign.config.rebellion_threshold.low
               elseif state_setting == "Medium" then
                    value = modular_difficulty_campaign.config.rebellion_threshold.medium
               elseif state_setting == "High" then
                    value = modular_difficulty_campaign.config.rebellion_threshold.high
               end

               if value == nil then
                    return
               end

               cm:set_script_state("public_order_repression_threshold", value)
          end
     },
     ["fully_equipped_generals"] = {
          achievement_key = "phar_main_ach_al_thutmose_conquest",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = true,
               ui_order = 28,
          },
          default_value = 0,
          callback = function(called_mid_game)
               local active = mdm.state["fully_equipped_generals"].value == 1
               if not active then
                    core:remove_listener("modular_difficulty_fully_equipped_generals_CharacterCreated")
                    return
               end

               local ancillaries_categorized = get_ancillaries_categorized()

               -- fully equip any newly created character
               core:add_listener(
                    "modular_difficulty_fully_equipped_generals_CharacterCreated",
                    "CharacterCreated",
                    true,
                    function(context)
                         local character = context:character()
                         if not character:has_military_force() then
                              return
                         end

                         modular_difficulty_campaign.utility_functions.fully_equip_general(character,
                              ancillaries_categorized)
                    end,
                    true,
                    true) -- prevent adding the listener multiple times

               -- `called_mid_game` flag is used here because we want the code below which updates the ancillaries of all existing characters in the world to occur only on the start of the game (not on the `ScriptEventModularDifficultyManagerStateUpdated` event call)
               if called_mid_game then
                    return
               end

               local ancillaries_categorized = get_ancillaries_categorized()
               -- fully equip all characters in the world
               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local faction = faction_list:item_at(i)
                    if faction and not faction:is_null_interface() and not faction:is_dead() then
                         local character_list = faction:character_list()
                         for j = 0, character_list:num_items() - 1 do
                              local character = character_list:item_at(j)
                              if character:is_male() or character:is_faction_leader() then -- the faction leader check is for Tausret
                                   modular_difficulty_campaign.utility_functions.fully_equip_general(character,
                                        ancillaries_categorized)
                              end
                         end
                    end
               end
          end
     },
     ["ai_behavior"] = {
          achievement_key = "phar_main_ach_kur_court_full",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.ai,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_first_option_idx = 1,
               dropdown_options = {
                    --	{"default", "modular_difficulty_1"},
                    { "low",  "modular_difficulty_1" },
                    { "mid",  "modular_difficulty_ai_behavior_dropdown_1" },
                    { "high", "modular_difficulty_ai_behavior_dropdown_3" },
               },
               campaign_changeable = false,
               ui_order = 47,
          },
          default_value = "Low",
          callback = function()
               local state_setting = mdm.state["ai_behavior"].value
               local strategic_stance_key = nil

               if state_setting == "Low" then
                    return
               elseif state_setting == "Medium" then -- UI: "Aggressive"
                    strategic_stance_key = modular_difficulty_campaign.config.ai_behavior.aggressive_stance
               elseif state_setting == "High" then -- UI: "Passive/Friendly"
                    strategic_stance_key = modular_difficulty_campaign.config.ai_behavior.friendly_stance
               end

               if strategic_stance_key == nil then
                    return
               end

               local player_faction_key = cm:get_local_faction_name(true)
               if not player_faction_key then
                    return
               end

               -- set the disposition of enemy ai factions towards player
               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local faction = faction_list:item_at(i)
                    if faction and not faction:is_null_interface() and not faction:is_dead() and not faction:is_human() then
                         cm:cai_strategic_stance_manager_promote_specified_stance_towards_target_faction(faction:name(),
                              player_faction_key, strategic_stance_key)
                    end
               end
          end
     },
     ["unbreakable_units"] = {
          achievement_key = "phar_main_ach_ram_pschent",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.battle,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_options = {
                    { "default", "modular_difficulty_1" },
                    { "low",     "modular_difficulty_unbreakable_units_dropdown_1" },
                    { "mid",     "modular_difficulty_unbreakable_units_dropdown_2" },
                    { "high",    "modular_difficulty_unbreakable_units_dropdown_3", }
               },
               campaign_changeable = false,
               ui_order = 36,
          },
          default_value = "None",
          callback = function()
               local state_setting = mdm.state["unbreakable_units"].value
               if state_setting == "None" then
                    return
               end

               local bundle_key = modular_difficulty_campaign.config.unbreakable_units.bundle_key
               local bundle = cm:create_new_custom_effect_bundle(bundle_key)
               bundle:add_effect("troy_mth_effect_all_units_unbreakable", "faction_to_force_own", 1)
               bundle:add_effect("troy_effect_hero_self_morale_spec_unwavering", "faction_to_force_own", 1)
               bundle:set_duration(0)

               local apply_on_owned_units = function()
                    local local_faction = cm:get_local_faction()
                    if local_faction then
                         cm:apply_custom_effect_bundle_to_faction(bundle, local_faction)
                    end
               end

               local apply_on_ai_units = function()
                    local faction_list = cm:model():world():faction_list()
                    for i = 0, faction_list:num_items() - 1 do
                         local faction = faction_list:item_at(i)
                         if faction and not faction:is_null_interface() and not faction:is_dead() and not faction:is_human() then
                              cm:apply_custom_effect_bundle_to_faction(bundle, faction)
                         end
                    end
               end

               local apply_to_all_units = function()
                    local faction_list = cm:model():world():faction_list()
                    for i = 0, faction_list:num_items() - 1 do
                         local faction = faction_list:item_at(i)
                         if faction and not faction:is_null_interface() and not faction:is_dead() then
                              cm:apply_custom_effect_bundle_to_faction(bundle, faction)
                         end
                    end
               end

               if state_setting == "Low" then -- in the UI: "Yours"
                    apply_on_owned_units()
               elseif state_setting == "Medium" then -- in the UI: "Theirs"
                    apply_on_ai_units()
               elseif state_setting == "High" then -- in the UI: "Both"
                    apply_to_all_units()
               end

               -- apply bundle to any newly created/revived faction
               core:add_listener("modular_difficulty_unbreakable_units_FactionLiberated",
                    "FactionLiberated",
                    true,
                    function(context)
                         if state_setting == "Medium" or state_setting == "High" then
                              cm:apply_custom_effect_bundle_to_faction(bundle, context:faction())
                         end
                    end,
                    true,
                    true)
          end
     },
     ["vanguard_deployment"] = {
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.battle,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_first_option_idx = 2,
               dropdown_options = {
                    -- text is the same, reusing it
                    { "default", "modular_difficulty_1" },
                    --{"low", "modular_difficulty_unbreakable_units_dropdown_1"},
                    --{"mid", "modular_difficulty_unbreakable_units_dropdown_2"},
                    { "high",    "modular_difficulty_unbreakable_units_dropdown_3" }
               },
               campaign_changeable = false,
               ui_order = 36,
          },
          default_value = "None",
          callback = function()
               local state_setting = mdm.state["vanguard_deployment"].value
               if state_setting == "None" then
                    return
               end

               local bundle_key = modular_difficulty_campaign.config.vanguard_deployment.bundle_key

               --We will be sticking with Default and Both options on this Customization Option.
               --local apply_on_owned_units = function()
               --	local local_faction = cm:get_local_faction_name()
               --	if local_faction then
               --		cm:apply_effect_bundle(bundle_key, local_faction, 0)
               --	end
               --end

               --local apply_on_ai_units = function()
               --	local faction_list = cm:model():world():faction_list()
               --	for i = 0, faction_list:num_items() - 1 do
               --		local faction = faction_list:item_at(i)
               --		if faction and not faction:is_null_interface() and not faction:is_dead() and not faction:is_human() then
               --			cm:apply_effect_bundle(bundle_key, faction:name(), 0)
               --		end
               --	end
               --end

               local apply_to_all_units = function()
                    local faction_list = cm:model():world():faction_list()
                    for i = 0, faction_list:num_items() - 1 do
                         local faction = faction_list:item_at(i)
                         if faction and not faction:is_null_interface() and not faction:is_dead() then
                              cm:apply_effect_bundle(bundle_key, faction:name(), 0)
                         end
                    end
               end

               --if state_setting == "Low" then			-- in the UI: "Yours"
               --	apply_on_owned_units()
               --elseif state_setting == "Medium" then		-- in the UI: "Theirs"
               --	apply_on_ai_units()
               if state_setting == "High" then -- in the UI: "Both"
                    apply_to_all_units()
               end

               -- apply bundle to any newly created/revived faction
               core:add_listener("modular_difficulty_vanguard_deployment_FactionLiberated",
                    "FactionLiberated",
                    true,
                    function(context)
                         if state_setting == "Medium" or state_setting == "High" then
                              cm:apply_effect_bundle(bundle, context:faction():name())
                         end
                    end,
                    true,
                    true)
          end
     },
     -- "list_of_maat_disasters" are implemented as 4 checkboxes
     ["list_of_maat_disasters_earthquake"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 15,
               component_parent = "maat_disasters_parent",
          },
          default_value = 1,
          callback = function()
               local is_disaster_disabled = mdm.state["list_of_maat_disasters_earthquake"].value == 0
               local is_applicable = not not table.contains(
               modular_difficulty_campaign.config.applicable_list_of_maat_disasters, "Earthquake")

               if is_disaster_disabled and is_applicable then
                    table.insert(pillars_civilization.persistent.disabled_incident_names, "Earthquake")
               end
          end
     },
     ["list_of_maat_disasters_flood"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 16,
               component_parent = "maat_disasters_parent",
          },
          default_value = 1,
          callback = function()
               local is_disaster_disabled = mdm.state["list_of_maat_disasters_flood"].value == 0
               local is_applicable = not not table.contains(
               modular_difficulty_campaign.config.applicable_list_of_maat_disasters, "Flood")

               if is_disaster_disabled and is_applicable then
                    table.insert(pillars_civilization.persistent.disabled_incident_names, "Flood")
               end
          end
     },
     ["list_of_maat_disasters_plague"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 17,
               component_parent = "maat_disasters_parent",
          },
          default_value = 1,
          callback = function()
               local is_disaster_disabled = mdm.state["list_of_maat_disasters_plague"].value == 0
               local is_applicable = not not table.contains(
               modular_difficulty_campaign.config.applicable_list_of_maat_disasters, "Plague")

               if is_disaster_disabled and is_applicable then
                    table.insert(pillars_civilization.persistent.disabled_incident_names, "Plague")
               end
          end
     },
     ["list_of_maat_disasters_drought"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 18,
               component_parent = "maat_disasters_parent",
          },
          default_value = 1,
          callback = function()
               local is_disaster_disabled = mdm.state["list_of_maat_disasters_drought"].value == 0
               local is_applicable = not not table.contains(
               modular_difficulty_campaign.config.applicable_list_of_maat_disasters, "Drought")

               if is_disaster_disabled and is_applicable then
                    table.insert(pillars_civilization.persistent.disabled_incident_names, "Drought")
               end
          end
     },
     ["max_pretenders_to_the_throne"] = {
          achievement_key = "phar_main_ach_ram_become_pharaoh",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               campaign_changeable = false,
               ui_order = 5,
          },
          default_value = "None",
          callback = function()
               local state_setting = mdm.state["max_pretenders_to_the_throne"].value

               local max_pretenders = 0
               if state_setting == "None" then
                    return -- the default setting
               elseif state_setting == "Low" then
                    max_pretenders = modular_difficulty_campaign.config.max_pretenders_to_the_throne.low
               elseif state_setting == "Medium" then
                    max_pretenders = modular_difficulty_campaign.config.max_pretenders_to_the_throne.medium
               elseif state_setting == "High" then
                    max_pretenders = modular_difficulty_campaign.config.max_pretenders_to_the_throne.high
               end

               egypt_political_states:set_max_pretenders(max_pretenders)
               hatti_political_states:set_max_pretenders(max_pretenders)
          end
     },
     ["all_royal_powers_available"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 6,
          },
          default_value = 0,
          callback = function()
               local state_value = mdm.state["all_royal_powers_available"].value == 1

               if state_value then
                    for _, legitimacy_object in ipairs(legitimacy_choice.legitimacy_objects) do
                         legitimacy_object.powers_system:enable_all_royal_powers()
                    end
               end
          end,
     },
     ["battle_weather_effects_mod"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.battle,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_options = {
                    { "none",      "modular_difficulty_none" },
                    { "low",       "modular_difficulty_2" },
                    { "medium",    "modular_difficulty_1" }, -- default
                    { "high",      "modular_difficulty_4" },
                    { "very high", "modular_difficulty_6" },
               },
               campaign_changeable = true,
               ui_order = 50,
          },
          default_value = "Medium",
          callback = function()
               local state_setting = mdm.state["battle_weather_effects_mod"].value

               local value = 1.0
               if state_setting == "None" then
                    value = modular_difficulty_campaign.config.battle_weather_effects_mod.none
               elseif state_setting == "Low" then
                    value = modular_difficulty_campaign.config.battle_weather_effects_mod.low
               elseif state_setting == "Medium" then
                    value = modular_difficulty_campaign.config.battle_weather_effects_mod.medium
               elseif state_setting == "High" then
                    value = modular_difficulty_campaign.config.battle_weather_effects_mod.high
               elseif state_setting == "Option4" then
                    value = modular_difficulty_campaign.config.battle_weather_effects_mod.very_high
               end

               cm:set_script_state("weather_effects_mod_modular_difficulty", value)
          end
     },
     ["flanking_morale_penalties_mod"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.battle,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_options = {
                    { "none",      "modular_difficulty_none" },
                    { "low",       "modular_difficulty_2" },
                    { "medium",    "modular_difficulty_1" }, -- default
                    { "high",      "modular_difficulty_4" },
                    { "very high", "modular_difficulty_6" },
               },
               campaign_changeable = true,
               ui_order = 52,
          },
          default_value = "Medium",
          callback = function()
               local state_setting = mdm.state["flanking_morale_penalties_mod"].value

               local value = 1.0
               if state_setting == "None" then
                    value = modular_difficulty_campaign.config.flanking_morale_penalties_mod.none
               elseif state_setting == "Low" then
                    value = modular_difficulty_campaign.config.flanking_morale_penalties_mod.low
               elseif state_setting == "Medium" then
                    value = modular_difficulty_campaign.config.flanking_morale_penalties_mod.medium
               elseif state_setting == "High" then
                    value = modular_difficulty_campaign.config.flanking_morale_penalties_mod.high
               elseif state_setting == "Option4" then
                    value = modular_difficulty_campaign.config.flanking_morale_penalties_mod.very_high
               end

               cm:set_script_state("flanking_mod_modular_difficulty", value)
          end
     },
     ["battle_terrain_effects_mod"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.battle,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_options = {
                    { "none",      "modular_difficulty_none" },
                    { "low",       "modular_difficulty_2" },
                    { "medium",    "modular_difficulty_1" }, -- default
                    { "high",      "modular_difficulty_4" },
                    { "very high", "modular_difficulty_6" },
               },
               campaign_changeable = true,
               ui_order = 51,
          },
          default_value = "Medium",
          callback = function()
               local state_setting = mdm.state["battle_terrain_effects_mod"].value

               local value = 1.0
               if state_setting == "None" then
                    value = modular_difficulty_campaign.config.battle_terrain_effects_mod.none
               elseif state_setting == "Low" then
                    value = modular_difficulty_campaign.config.battle_terrain_effects_mod.low
               elseif state_setting == "Medium" then
                    value = modular_difficulty_campaign.config.battle_terrain_effects_mod.medium
               elseif state_setting == "High" then
                    value = modular_difficulty_campaign.config.battle_terrain_effects_mod.high
               elseif state_setting == "Option4" then
                    value = modular_difficulty_campaign.config.battle_terrain_effects_mod.very_high
               end

               cm:set_script_state("terrain_mod_modular_difficulty", value)
          end
     },
     ["immortal_faction_leaders"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 54,
          },
          default_value = 0,
          callback = function()
               local state_value = mdm.state["immortal_faction_leaders"].value == 1

               if state_value then
                    return -- if immortal faction leaders are set then the immortality aspect is handled by DB setup
               end

               modular_difficulty_campaign.utility_functions.make_faction_leaders_mortal()
          end
     },
     ["any_ancient_legacy"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 55,
          },
          default_value = 0,
          callback = function()
               local state_value = mdm.state["any_ancient_legacy"].value == 1

               if state_value then -- if immortal any ancient legacy then
                    return
               end
          end
     },
     ["turns_per_year"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_first_option_idx = 1,
               dropdown_options = {
                    { "Low",     "modular_difficulty_turns_per_year_1" },
                    { "Medium",  "modular_difficulty_turns_per_year_3" },
                    { "High",    "modular_difficulty_turns_per_year_6" },
                    { "Option4", "modular_difficulty_turns_per_year_12" },
               },
               campaign_changeable = false,
               ui_order = 53,
          },
          default_value = "Medium",

          callback_pre_campaign_start = function()
               local rounds_per_year = -1
               local rounds_per_year_setting = mdm.state.turns_per_year.value

               if rounds_per_year_setting == "Low" then
                    rounds_per_year = 1
               elseif rounds_per_year_setting == "Medium" then
                    rounds_per_year = 3
               elseif rounds_per_year_setting == "High" then
                    rounds_per_year = 6
               elseif rounds_per_year_setting == "Option4" then
                    rounds_per_year = 12
               end

               common.set_rounds_per_year_override_tweaker(rounds_per_year)
          end,
     },

     ["seasons"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_options = {
                    { "None",   "modular_difficulty_seasons_disabled" },
                    { "Low",    "modular_difficulty_seasons_regular" },
                    { "Medium", "modular_difficulty_seasons_impactful" }, -- Not implemented for now
               },
               campaign_changeable = false,
               ui_order = 54,
          },
          default_value = "Low",

          callback_pre_campaign_start = function()
               local seasons_setting = mdm.state.seasons.value
               local seasons = -1

               if seasons_setting == "None" then
                    seasons = 0
               elseif seasons_setting == "Low" then
                    seasons = 1
               elseif seasons_setting == "Medium" then
                    seasons = 2
               end

               common.set_season_severity_override_tweaker(seasons)
          end,
     },

     ["lethality_mode"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.battle,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_options = {
                    { "None",   "modular_difficulty_1" },
                    { "Low",    "modular_difficulty_5" },
                    { "Medium", "modular_difficulty_percent_100" },
               },
               campaign_changeable = true,
               ui_order = 57,
          },
          default_value = "None",
          callback = function()
               local state_setting = mdm.state["lethality_mode"].value
               local value = 0
               if state_setting == "None" then
                    value = modular_difficulty_campaign.config.lethality_mode.enabled
               elseif state_setting == "Low" then
                    value = modular_difficulty_campaign.config.lethality_mode.disabled
               elseif state_setting == "Medium" then
                    value = modular_difficulty_campaign.config.lethality_mode.max_value
               end

               cm:set_script_state("lethality_mode_modular_difficulty", value)
          end
     },

     ["general_xp_gain"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_options = {
                    { "none",   "none" },
                    { "low",    "modular_difficulty_2" },
                    { "medium", "modular_difficulty_1" }, -- default
                    { "high",   "modular_difficulty_4" },
               },
               campaign_changeable = true,
               ui_order = 58,
          },
          default_value = "Medium",
          callback = function()
               local xp_setting = mdm.state["general_xp_gain"].value
               xp_general_modifier_modular_difficulty = modular_difficulty_campaign.config.general_xp_gain[xp_setting]
          end
     },

     ["character_aging"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.dropdown,
               dropdown_options = {
                    { "none",      "none" },
                    { "low",       "modular_difficulty_2" },
                    { "medium",    "modular_difficulty_3" },
                    { "high",      "modular_difficulty_1" }, -- default
                    { "very_high", "modular_difficulty_6" },
               },
               campaign_changeable = true,
               ui_order = 59,
          },
          default_value = "High",
          callback = function()
               local setting_value = mdm.state["character_aging"].value
               local current_value_config = modular_difficulty_campaign.config.character_aging[setting_value]
               for override_key, override_value in pairs(current_value_config) do
                    cm:set_script_state(override_key, override_value)
               end
          end
     },

     ["feature_gating"] = {
          achievement_key = "",
          is_locked = false,
          was_previously_locked = true,
          ui = {
               category = modular_difficulty_campaign.ui_panel.settings_category_tabs.campaign,
               component_type = modular_difficulty_campaign.ui_panel.settings_component_types.checkbox,
               campaign_changeable = false,
               ui_order = 60,
          },
          default_value = 1,
          callback = function()
               local state_value = mdm.state["feature_gating"].value == 1
               local all_features_unlocked = not state_value
               modular_difficulty_campaign.variables.all_features_unlocked = all_features_unlocked
               if all_features_unlocked then
                    feature_unlock.unlock_everything_for_everyone()
               end
          end,

          on_load = function()
               local state_value = mdm.state["feature_gating"].value == 1
               local all_features_unlocked = not state_value
               modular_difficulty_campaign.variables.all_features_unlocked = all_features_unlocked
          end,
     },
}

-- modular difficulty start
modular_difficulty_campaign.mdm_new_state = {
     ["ironman"] = {
          value = modular_difficulty_campaign.settings.ironman.default_value,
     },
     ["player_unit_upkeep"] = {
          value = modular_difficulty_campaign.settings.player_unit_upkeep.default_value,
     },
     ["ai_unit_upkeep"] = {
          value = modular_difficulty_campaign.settings.ai_unit_upkeep.default_value,
     },
     ["ai_building_cost"] = {
          value = modular_difficulty_campaign.settings.ai_building_cost.default_value,
     },
     ["player_replenishment"] = {
          value = modular_difficulty_campaign.settings.player_replenishment.default_value,
     },
     ["ai_replenishment"] = {
          value = modular_difficulty_campaign.settings.ai_replenishment.default_value,
     },
     ["no_retreat"] = {
          value = modular_difficulty_campaign.settings.no_retreat.default_value,
     },
     ["vanguard_deployment"] = {
          value = modular_difficulty_campaign.settings.vanguard_deployment.default_value,
     },
     ["enslave_sack_no_replenish"] = {
          value = modular_difficulty_campaign.settings.enslave_sack_no_replenish.default_value,
     },
     ["adjust_player_public_order"] = {
          value = modular_difficulty_campaign.settings.adjust_player_public_order.default_value,
     },
     ["adjust_ai_public_order"] = {
          value = modular_difficulty_campaign.settings.adjust_ai_public_order.default_value,
     },
     ["player_budget"] = {
          value = modular_difficulty_campaign.settings.player_budget.default_value,
     },
     ["ai_budget"] = {
          value = modular_difficulty_campaign.settings.ai_budget.default_value,
     },
     ["attrition_intensity"] = {
          value = modular_difficulty_campaign.settings.attrition_intensity.default_value,
     },
     ["recruitment_capacity_player"] = {
          value = modular_difficulty_campaign.settings.recruitment_capacity_player.default_value,
     },
     ["ranged_unit_ammo"] = {
          value = modular_difficulty_campaign.settings.ranged_unit_ammo.default_value,
     },
     ["sea_people_invasions"] = {
          value = modular_difficulty_campaign.settings.sea_people_invasions.default_value,
     },
     ["total_annihilation"] = {
          value = modular_difficulty_campaign.settings.total_annihilation.default_value,
     },
     ["no_alliances"] = {
          value = modular_difficulty_campaign.settings.no_alliances.default_value,
     },
     ["no_rebellions"] = {
          value = modular_difficulty_campaign.settings.no_rebellions.default_value,
     },
     ["no_influence_manager"] = {
          value = modular_difficulty_campaign.settings.no_influence_manager.default_value,
     },
     ["no_fog_of_war"] = {
          value = modular_difficulty_campaign.settings.no_fog_of_war.default_value,
     },
     ["no_ai_trade_offers"] = {
          value = modular_difficulty_campaign.settings.no_ai_trade_offers.default_value,
     },
     ["random_personalities"] = {
          value = modular_difficulty_campaign.settings.random_personalities.default_value,
     },
     ["no_auto_resolve"] = {
          value = modular_difficulty_campaign.settings.no_auto_resolve.default_value,
     },
     ["no_trading"] = {
          value = modular_difficulty_campaign.settings.no_trading.default_value,
     },
     ["trespassing_diplomatic_penalty_disabled"] = {
          value = modular_difficulty_campaign.settings.trespassing_diplomatic_penalty_disabled.default_value,
     },
     ["diplomatic_requirements_thresholds"] = {
          value = modular_difficulty_campaign.settings.diplomatic_requirements_thresholds.default_value,
     },
     ["diplomatic_deal_distance_penalties_for_war"] = {
          value = modular_difficulty_campaign.settings.diplomatic_deal_distance_penalties_for_war.default_value,
     },
     ["army_size"] = {
          value = modular_difficulty_campaign.settings.army_size.default_value,
     },
     ["random_startpos"] = {
          value = modular_difficulty_campaign.settings.random_startpos.default_value,
     },
     ["shuffle_commands"] = {
          value = modular_difficulty_campaign.settings.shuffle_commands.default_value,
     },
     ["allow_egyptian_gods"] = {
          value = modular_difficulty_campaign.settings.allow_egyptian_gods.default_value,
     },
     ["allow_hatti_gods"] = {
          value = modular_difficulty_campaign.settings.allow_hatti_gods.default_value,
     },
     ["allow_canaan_gods"] = {
          value = modular_difficulty_campaign.settings.allow_canaan_gods.default_value,
     },
     ["gods_autodiscovered"] = {
          value = modular_difficulty_campaign.settings.gods_autodiscovered.default_value,
     },
     ["toggle_maat"] = {
          value = modular_difficulty_campaign.settings.toggle_maat.default_value,
     },
     ["maat_disaster_intensity"] = {
          value = modular_difficulty_campaign.settings.maat_disaster_intensity.default_value,
     },
     ["maat_visual_override"] = {
          value = modular_difficulty_campaign.settings.maat_visual_override.default_value,
     },
     ["cai_legitimacy_modifier"] = {
          value = modular_difficulty_campaign.settings.cai_legitimacy_modifier.default_value,
     },
     ["royal_decrees_research_rate"] = {
          value = modular_difficulty_campaign.settings.royal_decrees_research_rate.default_value,
     },
     ["fully_leveled_generals"] = {
          value = modular_difficulty_campaign.settings.fully_leveled_generals.default_value,
     },
     ["movement_action_points"] = {
          value = modular_difficulty_campaign.settings.movement_action_points.default_value,
     },
     ["resource_availability"] = {
          value = modular_difficulty_campaign.settings.resource_availability.default_value,
     },
     ["recruitment_points_ai"] = {
          value = modular_difficulty_campaign.settings.recruitment_points_ai.default_value,
     },
     ["rebellion_threshold"] = {
          value = modular_difficulty_campaign.settings.rebellion_threshold.default_value,
     },
     ["fully_equipped_generals"] = {
          value = modular_difficulty_campaign.settings.fully_equipped_generals.default_value,
     },
     ["ai_behavior"] = {
          value = modular_difficulty_campaign.settings.ai_behavior.default_value,
     },
     ["unbreakable_units"] = {
          value = modular_difficulty_campaign.settings.unbreakable_units.default_value,
     },
     ["list_of_maat_disasters_earthquake"] = {
          value = modular_difficulty_campaign.settings.list_of_maat_disasters_earthquake.default_value,
     },
     ["list_of_maat_disasters_flood"] = {
          value = modular_difficulty_campaign.settings.list_of_maat_disasters_flood.default_value,
     },
     ["list_of_maat_disasters_plague"] = {
          value = modular_difficulty_campaign.settings.list_of_maat_disasters_plague.default_value,
     },
     ["list_of_maat_disasters_drought"] = {
          value = modular_difficulty_campaign.settings.list_of_maat_disasters_drought.default_value,
     },
     ["max_pretenders_to_the_throne"] = {
          value = modular_difficulty_campaign.settings.max_pretenders_to_the_throne.default_value,
     },
     ["all_royal_powers_available"] = {
          value = modular_difficulty_campaign.settings.all_royal_powers_available.default_value,
     },
     ["battle_weather_effects_mod"] = {
          value = modular_difficulty_campaign.settings.battle_weather_effects_mod.default_value,
     },
     ["flanking_morale_penalties_mod"] = {
          value = modular_difficulty_campaign.settings.flanking_morale_penalties_mod.default_value,
     },
     ["battle_terrain_effects_mod"] = {
          value = modular_difficulty_campaign.settings.battle_terrain_effects_mod.default_value,
     },
     ["immortal_faction_leaders"] = {
          value = modular_difficulty_campaign.settings.immortal_faction_leaders.default_value,
     },
     ["any_ancient_legacy"] = {
          value = modular_difficulty_campaign.settings.any_ancient_legacy.default_value,
     },
     ["turns_per_year"] = {
          value = modular_difficulty_campaign.settings.turns_per_year.default_value,
     },
     ["seasons"] = {
          value = modular_difficulty_campaign.settings.seasons.default_value,
     },
     ["lethality_mode"] = {
          value = modular_difficulty_campaign.settings.lethality_mode.default_value,
     },
     ["general_xp_gain"] = {
          value = modular_difficulty_campaign.settings.general_xp_gain.default_value,
     },
     ["character_aging"] = {
          value = modular_difficulty_campaign.settings.character_aging.default_value,
     },
     ["feature_gating"] = {
          value = modular_difficulty_campaign.settings.feature_gating.default_value,
     },
}
