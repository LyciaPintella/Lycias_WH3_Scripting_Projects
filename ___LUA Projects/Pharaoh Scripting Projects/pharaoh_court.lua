out("Loading phar_court.lua")

-- related files:
--	phar_court_positions.lua
--	phar_court_intrigues.lua
--	phar_court_plots.lua
--	phar_court_ui.lua
--	phar_court_ai.lua
--	phar_court_cheats_tests.lua
court =
{
     config =
     {
          -- if set to false this requires factions to be vassals of the court leader to gain court positions
          ignore_vassalage = true,
          min_legitimacy_to_claim_position = 0,
          -- not all pschent_crown effects use this multiplier, but many do
          pschent_crown_effect_multiplier = 2,
          pschent_crown_ancillary_name = "phar_main_crown_pschent",
          -- if set to true, the AI will apply the treasurer and commander discounts normally
          -- if set to false, the AI will not apply the discounts, unless they were influenced by a human
          give_discounts_from_AI_positions = true,
          apply_discounts_immediately_on_set = true,
          apply_discounts_immediately_on_influence = true,

          position_kicked_ban_duration = 5, -- if a faction has been kicked from a position it can't claim the position again for this amount of turns
          position_kick_cooldown = 5, -- the court leader can kick someone from their position with this cooldown
          -- the bonuses or penalties are defined in DaVE records so need to be clamped to within [-6, 6]
          position_kick_diplomatic_effect = -2,
          -- the cost for the court leader to kick someone from their position is the position holder's legitimacy multiplied by this
          position_kick_cost_multiplier_legitimacy = 2,
          -- the cost for the court leader to kick someone from their position is multiplied by this - IF the position requires a region and the position holder owns it
          position_kick_cost_multiplier_region = 3,

          -- how many court actions are needed for an intrigue (by default, some intrigues override it)
          intrigues_court_actions_needed = 1,
          -- this only applies if the faction can purchase actions
          autopurchase_intrigue_actions = true,

          -- how many court actions are needed for a plot (by default, some plots override it)
          plots_court_actions_needed = 1,
          -- this only applies if the faction can purchase actions
          autopurchase_plot_actions = true,

          autopurchase_requests = true,

          can_take_positions_during_war = true,
          can_make_requests_during_war = true,

          can_leader_give_position_to_factions = true,

          reset_position_regard_on_becoming_vacant = true,
          -- factions that are related to the court leader have their claim cost multiplied by this
          related_claim_multiplier = 0.5,
          demand_dominance_cost = 50,

          -- requests do not use the standard cooldown period, which is taken from the Shemsu Hor period
          non_shemsu_hor_request_cooldown = 5,
          -- intrigues can be used every turn, but not the same intrigue on the same position multiple times per turn!
          intrigue_cooldown = 1,
          -- this applies to plots and intrigues against the pharaoh and high king
          leader_extra_cost_record = "phar_main_court_pharaoh_court_action_surcharge",
          -- only used for testing and only if leader_extra_cost_record is not found
          test_leader_extra_cost_record =
          {
               { "troy_gold", -100 },
          },

          claim_position_cost =
          {
               -- this is the main way to set up costs
               claim_position_resource_costs_record = "phar_main_court_claim_position_base",
               -- this is meant for testing, only used if the main cost is removed or commented
               claim_test_cost =
               {
                    { "troy_gold", -1 },
               },

               -- the faction legitimacy is multiplied by this coefficient to form a portion of the faction CANDIDATE_VALUE
               legitimacy_coefficient = 1,
               -- the faction strength is multiplied by this coefficient to form a portion of the faction CANDIDATE_VALUE
               strength_coefficient = 0.0,

               -- cost is defined by the sum of CANDIDATE_VALUE of top contenders, this variable controls how many are summed up
               top_contenders_to_sum = 3,
               -- the player CANDIDATE_VALUE is multiplied by this coefficient and substracted from the the score of each candidate, before the top 'top_contenders_to_sum' get summed, to form the cost for claiming a position
               player_coefficient = 0.5,

               include_position_holders_as_pretenders = false,

               -- faction contender scores to claim positions are calculated in get_faction_claim_candidate_value
               -- AI factions need at least this score to be able to claim positions
               min_valid_score_ai_claims = -50,
               -- factions with at least this score are shown in the UI as contenders
               min_valid_score_claim_price_calculation = -50,
               -- factions with at least this score can be given the position by the court leader (nil means no limit)
               min_valid_score_give_position_by_leader = nil,
          },

          purchase_court_action_cost =
          {
               -- this is the main way to set up costs
               purchase_court_action_cost_record = "phar_main_court_gold_cost_per_action",
               -- this is meant for testing, only used if the main cost is removed or commented
               action_test_cost =
               {
                    { "troy_gold", -100 },
               },
          },

          court_resource_factor = "phar_main_court",
          -- legitimacies that decay with time (up and down towards 0). used by plots
          court_legitimacy_decay_factor_key = "phar_map_court_decay",
          -- matches the diplomacy category to the regard gain multiplier
          -- the diplomacy categories are in DIPLOMATIC_ATTITUDE_CATEGORY, from 0 (DIPLOMATIC_ATTITUDE_CATEGORY_HOSTILE) to 6 (DIPLOMATIC_ATTITUDE_CATEGORY_BEST_FRIENDS), with 3 being neutral
          diplomacy_regard_config =
          {
               [0] = 0.5,
               [1] = 0.5,
               [2] = 0.75,
               [3] = 1,
               [4] = 1.25,
               [5] = 1.5,
               [6] = 1.5,
          },
     },

     -- for things designers don't need to bother with
     developer_config =
     {
          -- in all the places where requests are used by index
          small_request_index = 1,
          large_request_index = 2,

          shared_state =
          {
               position_key_state = "court_position_held",
               position_localized_name_state = "court_position_held_localized",
               pschent_multiplier = "egypt_court_pschent_multiplier",
          },
     },

     factions_config =
     {
          default =
          {
               -- factions can have additional_intrigues = {...} to add intrigues or unavailable_intrigues = {...} to remove from these
               available_intrigues = { "conspire", "assist", "gossip", "counter", "encourage", "discourage", "undermine" },
               available_plots = { "threaten", "discredit", "blackmail" },
               max_court_actions_per_turn = 1,
               -- how many actions the factions can acumulate between turns
               -- they reset on Shemsu Hor
               -- they include the 'free' actions gained every turn from max_court_actions_per_turn and extra_actions_this_turn
               max_accumulated_actions = 1,
               starting_plot_level = 1,
               max_plot_level = 5,
               -- automatically reveal all plots started by AI factions
               reveal_plots = false,
               -- automatically reveal plots started by other factions that target this faction
               reveal_targeting_plots = false,
               -- the chance to be targeted by an AI plot - higher number means higher chance
               ai_plot_target_weight = 1,
               min_regard = 0,
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_default" },
               request_regard_cost = 60,
               -- how many court actions are needed for a request (by default, some requests override it)
               requests_court_actions_needed = 1,
               gossip_reveals_all_plots = false,
               intrigue_gold_gain = nil,
               -- if true, each time a plot against the faction fails it will get an extra court action for the turn
               gain_court_action_on_plot_failed = false,
          },
          -- egyptian
          phar_main_ramesses =
          {
               max_court_actions_per_turn = 2,
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_ramesses" },
               -- not supposed to be saved, but filled after load or when position changes
               owned_positions = {},
               -- not supposed to be saved, for convenient access
               -- faction_persistent_data reference
          },
          phar_main_amenmesse =
          {
               can_purchase_court_actions = true,
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_amenmesse_1", "random_localisation_strings_string_phar_main_court_faction_ability_amenmesse_2", "random_localisation_strings_string_phar_main_court_faction_ability_amenmesse_3" },
          },
          phar_main_tausret =
          {
               additional_intrigues = { "flip" },
               reveal_targeting_plots = true,
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_tausret_1", "random_localisation_strings_string_phar_main_court_faction_ability_tausret_2", "random_localisation_strings_string_phar_main_court_faction_ability_tausret_3" },
               ai_plot_target_weight = 2,
          },
          phar_main_seti =
          {
               min_regard = -60,
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_seti_1", "random_localisation_strings_string_phar_main_court_faction_ability_seti_2" },
          },
          -- canaan
          phar_main_bay =
          {
               additional_intrigues = { "assume" },
               reveal_plots = true,
               additional_legitimacy_positions =
               {
                    pharaoh = 5,
                    high_king = 5,
                    vizier = 4,
                    tuhkanti = 4,
                    royal_treasurer = 4,
                    lawgiver = 4,
                    high_priest_of_amun = 4,
                    first_commander = 3,
                    tuhhigh_commanderkanti = 3,
                    viceroy_of_kush = 3,
               },
               additional_legitimacy_plots =
               {
                    discredit = 3,
                    embezzle = 2,
               },
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_bay_1", "random_localisation_strings_string_phar_main_court_faction_ability_bay_2" },
          },
          phar_main_irsu =
          {
               unavailable_intrigues = { "gossip", "encourage", "discourage", },
               random_position_regard_gain = 60,
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_irsu_1", "random_localisation_strings_string_phar_main_court_faction_ability_irsu_2", "random_localisation_strings_string_phar_main_court_faction_ability_irsu_3" },
          },
          -- hatti
          phar_main_kurunta =
          {
               starting_plot_level = 2,
               max_plot_level = 6,
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_kurunta_1", "random_localisation_strings_string_phar_main_court_faction_ability_kurunta_2" },
          },
          phar_main_suppiluliuma =
          {
               -- whenever the faction has a position in the court and a new position is filled in this court, this faction gains this much regard with it
               new_position_regard_gained = 60,
               gossip_regard_gain_multiplier = 2,
               encourage_regard_gain_multiplier = 2,
               discourage_regard_gain_multiplier = 2,
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_suppiluliuma_1", "random_localisation_strings_string_phar_main_court_faction_ability_suppiluliuma_2" },
          },

          -- sea people
          phar_sea_peleset =
          {
               additional_intrigues = { "endorse", },
               unavailable_intrigues = { "assist", },
               conspire_additional_cost = "phar_main_court_pharaoh_court_action_surcharge",
               conspire_regard_cost_multiplier = 0,
               regard_gained_with_conspirators = 20,
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_peleset_1", "random_localisation_strings_string_phar_main_court_faction_ability_peleset_2" },
          },
          phar_sea_sherden =
          {
               additional_intrigues = { "provoke", },
               claim_cost_multiplier = 2,
               plot_additional_cost = "phar_main_court_pharaoh_court_action_surcharge",
               plot_against_faction_chance_change = -10,
               kill_plotter_on_failure = true,
               ai_plot_target_weight = 0.5,
               faction_abilities_strings = { "random_localisation_strings_string_phar_main_court_faction_ability_sherden_1", "random_localisation_strings_string_phar_main_court_faction_ability_sherden_2", "random_localisation_strings_string_phar_main_court_faction_ability_sherden_3" },
          },

          -- aegean
          troy_main_dan_mycenae =
          {
               requests_court_actions_needed = 0,
               request_regard_cost = 40,
               faction_abilities_strings = { "random_localisation_strings_string_phar_map_court_faction_ability_mycenae_1", "random_localisation_strings_string_phar_map_court_faction_ability_mycenae_2" },
          },

          troy_main_trj_troy =
          {
               gossip_reveals_all_plots = true,
               -- the index is the level of the plot, the value is how much gold the faction gains
               discourage_gold_gain =
               {
                    100,
                    200,
                    300,
                    400,
                    500,
                    600,
               },
               faction_abilities_strings = { "random_localisation_strings_string_phar_map_court_faction_ability_troy_1", "random_localisation_strings_string_phar_map_court_faction_ability_troy_2" },
          },

          -- mesopotamian
          phar_map_babylon =
          {
               additional_intrigues = { "insult", },
               -- each time a plot against the faction fails it will get an extra court action for the turn
               gain_court_action_on_plot_failed = true,
               faction_abilities_strings = { "random_localisation_strings_string_phar_map_court_faction_ability_babylon_1", "random_localisation_strings_string_phar_map_court_faction_ability_babylon_2" },
          },

          -- this one is assyria's ingame name
          phar_map_ninurta =
          {
               additional_plots = { "assassinate", },
               additional_intrigues = { "collude", },
               unavailable_intrigues = { "conspire", },
               faction_abilities_strings = { "random_localisation_strings_string_phar_map_court_faction_ability_ninurta_1", "random_localisation_strings_string_phar_map_court_faction_ability_ninurta_2" },
          },

     },

     -- used to iterate through, filled in first_tick_init
     resource_keys =
     {
     },
     -- lower value means more messages get printed
     -- priotity 100 - the print cheat
     -- priority 10 - errors showing something is seriously broken
     -- priority 1 - position character changed (gained or lost their position)
     -- no priority given - everything else, intrigue and relations changes, TODOs, etc.
     min_priority_to_print = 10,

     -- messages only get printed if their priority is at least min_priority_to_print
     -- or if min_priority_to_print is negative
     output = function(str, priority)
          if not str then
               return
          end

          if court.min_priority_to_print > 0 then
               if not priority or court.min_priority_to_print > priority then
                    return
               end
          end

          out("*** _PHARAOH COURT_ ***: " .. str)
     end,

     egyptian_court =
     {
          court_name = "egyptian_court",

          config =
          {
               ruler_position = "pharaoh",
               court_legitimacy_factor_key = "phar_legitimacy_court_intrigue",
               -- for legitimacy provided by positions
               court_legitimacy_positions_factor_key = "phar_legitimacy_court_position",
               court_legitimacy_text_icon = "[[img:icon_pr_egyptian_legitimacy_small]][[/img]]",

               -- only factions of these cultures will be accepted in the court
               acceptable_cultures =
               {
                    "phar_main_clt_kemet",
                    "phar_main_clt_canaan",
                    "phar_main_clt_hatti",
                    "phar_main_clt_sea_peoples",
                    "phar_map_clt_mesopotamian",
                    "troy_main_clt_danaans",
                    "troy_main_clt_trojans",
                    "troy_rem_clt_thraco_phrygians",
               },

               -- these factions will not be accepted even if they are of the accepted culture
               banned_factions =
               {
                    "phar_main_kaska",
                    "phar_main_al_khufu_invasion_kemet",
                    "phar_main_al_khufu_invasion_libu",
                    "phar_main_al_khufu_invasion_nubians",
                    "phar_main_al_khufu_invasion_sea_people",
                    "phar_main_libu",
                    "phar_main_habiru",
                    "phar_main_meshwesh",
                    "phar_main_libu_invaders",
                    "phar_main_phrygian_invaders",
                    "phar_main_egyptian_rebels",
                    "phar_main_hittites_rebels",
                    "phar_main_canaan_rebels",
               },

               -- all AIs with these factions will choose this court
               AI_acceptable_factions =
               {
                    "phar_main_bay",
               },

               sacred_lands = sacred_egypt_lands,
               mercenaries_replenishment_chance_percent = 20,
               -- the max number of units that can be replenished per turn
               mercenaries_replenishment_per_turn = 2,

               -- this lists all positions available in this court. the positions themselves are in phar_court_positions.lua
               -- here we list the position name, the initial holder (of any), and overrides of the position config (bonuses, icons, localisation, etc.)
               available_positions =
               {
                    -- each position is in the format of
                    -- position_name =
                    -- {
                    -- -- the initial values can be set using the faction (e.g. "phar_main_amenmesse") to put the faction leader in that position)
                    -- -- or the character lookup string (e.g. "faction:phar_map_assyria,forename:1616884972") for characters in the pharaoh's faction)
                    -- initial_holder = [X],

                    -- -- bonuses given to the faction holding the position
                    -- bonus_pack = {...},
                    -- -- bonuses given to the character holding this position
                    -- character_bonus_pack = {...},
                    -- -- [optional] the units given to the position as mercenaries
                    -- position_units = {...}
                    -- -- [optional] the units provided to the position when the Pschent crown is equipped
                    -- position_units_pschent = {...}
                    -- -- [optional] the units given by this position on request
                    -- request_units = {...}
                    -- -- [optional] the units given by this position on request when the Pschent crown is equipped
                    -- request_units_pschent_pschent = {...}
                    -- -- [optional] by default the unit requests are not available to the court leader (normally they get the same units and they should not stack). when this is anything but 'nil' or 'false', the court leader can make this request
                    -- is_unit_request_available_to_court_leader = true,
                    -- -- the bonuses given to the faction requesting the first and second request from this position
                    -- request_bonus_packs = { {...}, {...}},
                    -- -- bonuses given instead of bonus_pack if the #Pschent crown is worn by the court leader
                    -- pschent_crown_override_bonus_pack = {...},
                    -- -- bonuses given instead of character_bonus_pack if the #Pschent crown is worn by the court leader
                    -- pschent_crown_override_character_bonus_pack = {...},
                    -- -- bonuses given instead of request_bonus_packs if the #Pschent crown is worn by the court leader
                    -- pschent_crown_override_request_bonus_packs = { {...}, {...}},

                    -- -- optional override for the position name localization key for this court
                    -- localization_key = [X],
                    -- -- optional override for the position icon for this court
                    -- icon_path = [X],
                    -- -- optional override for the position description for this court
                    -- description_localization_key = [X],
                    -- -- optional override for the position help_page_key for this court
                    -- help_page_key = [X],
                    -- }

                    pharaoh =
                    {
                         -- the pharaoh position holder is controlled by egypt_political_states (in phar_political_states_egyptian.lua)
                         initial_holder = "",
                    },
                    vizier =
                    {
                         initial_holder = "phar_main_rhacotis",

                         -- bonuses
                         bonus_pack =
                         {
                              -- gives discounts to intrigues, linked to court_discount_mod in pay_for_intrigue
                              --"phar_main_court_vizier_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_vizier_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                                   --"phar_main_court_vizier_small_request",
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },

                         -- optional, will be used instead of bonus_pack when the court has the #Pschent crown
                         pschent_crown_override_bonus_pack =
                         {
                              "phar_main_court_vizier_faction_bundle_pschent",
                         },

                         -- optional, will be used instead of character_bonus_pack when the court has the #Pschent crown
                         pschent_crown_override_character_bonus_pack =
                         {
                              "phar_main_court_vizier_character_bundle",
                         },

                         -- optional, will be used instead of request_bonus_packs when the court has the #Pschent crown
                         pschent_crown_override_request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                                   "phar_main_court_vizier_small_request_pschent",
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },
                    },
                    first_commander =
                    {
                         initial_holder = "phar_main_setnakhte",
                         discounts_bundle = "phar_main_court_discounts_units",
                         discounts_scope = "faction_to_province_own",
                         -- factions who influence the discounts get this mark so they can see the influence
                         can_see_discounts_mark = "can_see_discount_plans_commander",

                         -- bonuses
                         bonus_pack =
                         {
                              "phar_main_court_first_commander_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_first_commander_character_bundle",
                         },

                         -- units provided as mercenary to the position holder
                         position_units =
                         {
                              {
                                   unit_key = "phar_main_pharaoh_elite_royal_khopesh_guards",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_pharaoh_elite_royal_archers",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_pharaoh_elite_royal_chariot_companions",
                                   amount = 1,
                              },
                         },

                         -- units given to the First Commander position holder (when court leader wears the Pshent crown)
                         position_units_pschent =
                         {
                              {
                                   unit_key = "phar_main_pharaoh_elite_royal_khopesh_guards",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_pharaoh_elite_royal_archers",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_pharaoh_elite_royal_chariot_companions",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_pharaoh_elite_pharaoh_guard",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_pharaoh_elite_braves_of_the_king",
                                   amount = 1,
                              },
                         },

                         request_units =
                         {
                              {
                                   unit_key = "phar_main_pharaoh_elite_royal_khopesh_guards",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_pharaoh_elite_royal_archers",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_pharaoh_elite_royal_chariot_companions",
                                   amount = 1,
                              },
                         },

                         -- if you want to give different units when Pschent crown is equipped - use request_units_pschent_pschent table and list them inside

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },

                         -- optional, will be used instead of character_bonus_pack when the court has the #Pschent crown
                         pschent_crown_override_character_bonus_pack =
                         {
                              "phar_main_court_first_commander_character_bundle_pschent",
                         },

                         pschent_crown_override_bonus_pack =
                         {
                              "phar_main_court_first_commander_faction_bundle_pschent",
                         },
                    },
                    royal_treasurer =
                    {
                         initial_holder = "phar_main_faiyum",
                         discounts_bundle = "phar_main_court_discounts_buildings",
                         discounts_scope = "faction_to_region_own",
                         -- factions who influence the discounts get this mark so they can see the influence
                         can_see_discounts_mark = "can_see_discount_plans_treasurer",

                         bonus_pack =
                         {
                              "phar_main_court_royal_treasurer_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_royal_treasurer_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },

                         pschent_crown_override_bonus_pack =
                         {
                              "phar_main_court_royal_treasurer_faction_bundle_pschent",
                         },
                    },
                    high_priest_of_amun =
                    {
                         initial_holder = "phar_main_waset",
                         main_god_key = "amun",

                         bonus_pack =
                         {
                              "phar_main_court_high_priest_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_high_priest_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                                   "phar_main_court_high_priest_small_request",
                              },
                              -- second element is bonus packs for large request
                              {
                                   "phar_main_court_high_priest_large_request",
                              },
                         },

                         -- optional, will be used instead of bonus_pack when the court has the #Pschent crown
                         pschent_crown_override_bonus_pack =
                         {
                              "phar_main_court_high_priest_faction_bundle_pschent",
                         },

                         -- optional, will be used instead of request_bonus_packs when the court has the #Pschent crown
                         pschent_crown_override_request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                                   "phar_main_court_high_priest_small_request_pschent",
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },
                    },
                    viceroy_of_kush =
                    {
                         initial_holder = "phar_main_amenmesse",
                         related_region_plot_success_chance_modifier =
                         {
                              -- the owner of the region will get +X% chance to their preferred outcome (success if they are plotter, failure if they are the plot target)
                              threaten = 30,
                         },

                         bonus_pack =
                         {
                              "phar_main_court_viceroy_kush_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_viceroy_kush_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },

                         -- optional, will be used instead of bonus_pack when the court has the #Pschent crown
                         pschent_crown_override_bonus_pack =
                         {
                              "phar_main_court_viceroy_kush_faction_bundle_pschent",
                         },

                         -- units given to the holder of the position
                         position_units =
                         {
                              {
                                   unit_key = "phar_main_nat_nub_kushite_archers",
                                   amount = 2,
                              },
                              {
                                   unit_key = "phar_main_nat_nub_kushite_spearmen",
                                   amount = 2,
                              },
                         },

                         -- units given to the holder of viceroy_of_kush when the pschent crown is equipped
                         position_units_pschent =
                         {
                              {
                                   unit_key = "phar_main_nat_nub_kushite_archers",
                                   amount = 4,
                              },
                              {
                                   unit_key = "phar_main_nat_nub_kushite_spearmen",
                                   amount = 4,
                              },
                         },

                         is_unit_request_available_to_court_leader = true,

                         request_units =
                         {
                              {
                                   unit_key = "phar_main_nat_nub_kushite_archers",
                                   amount = 2,
                              },
                              {
                                   unit_key = "phar_main_nat_nub_kushite_spearmen",
                                   amount = 2,
                              },
                         },

                         -- units given as a request from the viceroy_of_kush when the pschent crown is equipped
                         request_units_pschent_pschent =
                         {
                              {
                                   unit_key = "phar_main_nat_nub_kushite_archers",
                                   amount = 4,
                              },
                              {
                                   unit_key = "phar_main_nat_nub_kushite_spearmen",
                                   amount = 4,
                              },
                         },
                    },
               },

               localization_keys =
               {
                    treasurer_set_discounts_description = "phar_main_court_egyptian_treasurer_set_discounts_description",
                    treasurer_influence_single_discount_description =
                    "phar_main_court_egyptian_treasurer_influence_single_discount_description",
                    treasurer_influence_discounts_description =
                    "phar_main_court_egyptian_treasurer_influence_discounts_description",
                    treasurer_see_discounts_description = "phar_main_court_egyptian_treasurer_see_discounts_description",
                    commander_set_discounts_description = "phar_main_court_egyptian_commander_set_discounts_description",
                    commander_influence_single_discount_description =
                    "phar_main_court_egyptian_commander_influence_single_discount_description",
                    commander_influence_discounts_description =
                    "phar_main_court_egyptian_commander_influence_discounts_description",
                    commander_see_discounts_description = "phar_main_court_egyptian_commander_see_discounts_description",
               },
          },

          --autofilled from fill_court_positions according to available_positions
          positions = {},

          persistent =
          {
               next_plot_generation_turn = 0,
               -- we track data for active plots,
               -- NOTE: plots get resolved (succeed or fail) and are cleared on a certain turn
               --	(if the Shemsu Hor system is active - on the next Shemsu Hor)
               -- format is something like this:
               -- plots_persistent_data_by_resolve_turn =
               -- {
               --	[resolve_turn] =
               --	{
               --		[plot_key] =
               --		{
               --			{
               --				plot_id = [unique number],
               --				plotting_faction = [faction key],
               --				target_court_name = [court_name],
               --				targeted_position = [position key],
               --				plot_level = [int level],
               --				revealed_to = {"faction 1", ...},
               --				invalidated [optional] indicates the plot should not be shown or resolved
               --					-- this can happen because the targeted position was vacated, but removing a plot while iterating the list can be problematic
               --				court_leader_support = true, -- optional, court leader support (via Strongarm request) means it will be 100% successful
               --				force_failure = true, -- optional, a result of the Insult intrigue means it will 100% fail
               -- 				targeted_character_family_cqi - used when the character is removed from the position, but we need to show them in the log
               --				success = true/false, -- set only when the plot is resolved, nil otherwise
               --				-- other future data
               --			},
               --			.. other plots of this type
               --		},
               --		.. plots of other types
               --	}
               --	.. plots that resolve on other turns
               -- }
               plots_persistent_data_by_resolve_turn = {
               },
          },

          political_states = function()
               return egypt_political_states
          end,

          court_legitimacy = function()
               return egypt_legitimacy
          end,

          ruling_faction = function(self)
               return self.political_states().persistent.current_ruling_faction_key
          end,
     },

     hittite_court =
     {
          court_name = "hittite_court",

          config =
          {
               ruler_position = "high_king",
               court_legitimacy_factor_key = "phar_hatti_legitimacy_court_intrigue",
               -- for legitimacy provided by positions
               court_legitimacy_positions_factor_key = "phar_hatti_legitimacy_court_position",
               court_legitimacy_text_icon = "[[img:icon_pr_hatti_legitimacy_small]][[/img]]",

               -- only factions of these cultures will be accepted in the court
               acceptable_cultures =
               {
                    "phar_main_clt_kemet",
                    "phar_main_clt_canaan",
                    "phar_main_clt_hatti",
                    "phar_main_clt_sea_peoples",
                    "phar_map_clt_mesopotamian",
                    "troy_main_clt_danaans",
                    "troy_main_clt_trojans",
                    "troy_rem_clt_thraco_phrygians",
               },

               -- these factions will not be accepted even if they are of the accepted culture
               banned_factions =
               {
                    "phar_main_kaska",
                    "phar_main_al_khufu_invasion_kemet",
                    "phar_main_al_khufu_invasion_libu",
                    "phar_main_al_khufu_invasion_nubians",
                    "phar_main_al_khufu_invasion_sea_people",
                    "phar_main_libu",
                    "phar_main_habiru",
                    "phar_main_meshwesh",
                    "phar_main_libu_invaders",
                    "phar_main_phrygian_invaders",
                    "phar_main_egyptian_rebels",
                    "phar_main_hittites_rebels",
                    "phar_main_canaan_rebels",
               },

               -- all AIs with these factions will choose this court
               AI_acceptable_factions =
               {
                    "phar_main_irsu",
               },

               sacred_lands = sacred_hatti_lands,
               mercenaries_replenishment_chance_percent = 20,
               -- the max number of units that can be replenished per turn
               mercenaries_replenishment_per_turn = 2,

               available_positions =
               {
                    high_king =
                    {
                         initial_holder = "", -- the high_king position holder is controlled by hatti_political_states (in phar_political_states_hittite.lua)
                    },
                    tuhkanti =
                    {
                         initial_holder = "",

                         -- ui section
                         localization_key = "ui_text_replacements_localised_text_phar_position_tukhanti",
                         icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_tuhkanti.png",
                         description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_tukhanti_description",
                         help_page_key = "help_crown_court_hittite_positions_tukhanti",

                         -- bonuses section
                         bonus_pack =
                         {
                              --"phar_main_court_tuhkanti_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_tuhkanti_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                                   --"phar_main_court_tuhkanti_small_request",
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },
                    },
                    high_commander =
                    {
                         initial_holder = "phar_main_kanesh",

                         -- ui section
                         localization_key = "ui_text_replacements_localised_text_phar_position_high_commander",
                         icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_high_commander.png",
                         description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_high_commander_description",
                         help_page_key = "help_crown_court_hittite_positions_high_commander",

                         discounts_bundle = "phar_main_court_discounts_units",
                         discounts_scope = "faction_to_province_own",
                         -- factions who influence the discounts get this mark so they can see the influence
                         can_see_discounts_mark = "can_see_discount_plans_commander",

                         bonus_pack =
                         {
                              "phar_main_court_high_commander_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_high_commander_character_bundle",
                         },

                         -- units provided as mercenary to the position holder
                         position_units =
                         {
                              {
                                   unit_key = "phar_main_great_king_elite_mesedi",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_great_king_elite_royal_hittite_chargers",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_great_king_elite_royal_hittite_chariots",
                                   amount = 1,
                              },
                         },

                         request_units =
                         {
                              {
                                   unit_key = "phar_main_great_king_elite_mesedi",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_great_king_elite_royal_hittite_chargers",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_main_great_king_elite_royal_hittite_chariots",
                                   amount = 1,
                              },
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },
                    },
                    lawgiver =
                    {
                         initial_holder = "phar_main_tuwana",

                         -- ui section
                         localization_key = "ui_text_replacements_localised_text_phar_position_lawgiver",
                         icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_lawgiver.png",
                         description_localization_key =
                         "ui_text_replacements_localised_text_phar_main_court_lawgiver_description",
                         help_page_key = "help_crown_court_hittite_positions_lawgiver",

                         discounts_bundle = "phar_main_court_discounts_buildings",
                         discounts_scope = "faction_to_region_own",
                         -- factions who influence the discounts get this mark so they can see the influence
                         can_see_discounts_mark = "can_see_discount_plans_treasurer",

                         bonus_pack =
                         {
                              "phar_main_court_lawgiver_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_lawgiver_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },
                    },
                    high_judge =
                    {
                         initial_holder = "phar_main_purushanda",

                         bonus_pack =
                         {
                              "phar_main_court_high_judge_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_high_judge_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                                   "phar_main_court_high_judge_large_request",
                              },
                         },
                    },
                    chief_of_royal_bodyguards =
                    {
                         initial_holder = "phar_main_sapinuwa",

                         bonus_pack =
                         {
                              "phar_main_court_chief_bodyguards_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_chief_bodyguards_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                                   "phar_main_court_chief_bodyguards_large_request",
                              },
                         },
                    },
               },

               localization_keys =
               {
                    treasurer_set_discounts_description = "phar_main_court_hatti_treasurer_set_discounts_description",
                    treasurer_influence_single_discount_description =
                    "phar_main_court_hatti_treasurer_influence_single_discount_description",
                    -- this will not be used for now, as the item that allows multiple bonuses to be influenced is strictly Egyptian... but it is better to have it for completion and futureproofing
                    treasurer_influence_discounts_description =
                    "Select %d bonuses to force %d%% discount on next Shemsu Hor. Other discounts will decrease correspondingly.",
                    treasurer_see_discounts_description = "phar_main_court_hatti_treasurer_see_discounts_description",
                    commander_set_discounts_description = "phar_main_court_hatti_commander_set_discounts_description",
                    commander_influence_single_discount_description =
                    "phar_main_court_hatti_commander_influence_single_discount_description",
                    -- this will not be used for now, as the item that allows multiple bonuses to be influenced is strictly Egyptian... but it is better to have it for completion and futureproofing
                    commander_influence_discounts_description =
                    "Select %d bonuses to force %d%% discount on next Shemsu Hor. Other discounts will decrease correspondingly.",
                    commander_see_discounts_description = "phar_main_court_hatti_commander_see_discounts_description",
               },
          },

          --autofilled from fill_court_positions according to available_positions
          positions = {},

          persistent =
          {
               next_plot_generation_turn = 0,
               mercenaries_provided = {},
               plots_persistent_data_by_resolve_turn = {
               },
          },

          political_states = function()
               return hatti_political_states
          end,

          court_legitimacy = function()
               return hatti_legitimacy
          end,

          ruling_faction = function(self)
               return self.political_states().persistent.current_ruling_faction_key
          end,
     },

     aegean_court =
     {
          court_name = "aegean_court",

          config =
          {
               ruler_position = "wanax",
               court_legitimacy_factor_key = "phar_aegea_legitimacy_court_intrigue",
               -- for legitimacy provided by positions
               court_legitimacy_positions_factor_key = "phar_aegea_legitimacy_court_position",
               court_legitimacy_text_icon = "[[img:icon_pr_aegean_legitimacy_small]][[/img]]",

               -- only factions of these cultures will be accepted in the court
               acceptable_cultures =
               {
                    "phar_main_clt_kemet",
                    "phar_main_clt_canaan",
                    "phar_main_clt_hatti",
                    "phar_main_clt_sea_peoples",
                    "phar_map_clt_mesopotamian",
                    "troy_main_clt_danaans",
                    "troy_main_clt_trojans",
                    "troy_rem_clt_thraco_phrygians",
               },

               -- these factions will not be accepted even if they are of the accepted culture
               banned_factions =
               {
                    "phar_main_kaska",
                    "phar_main_al_khufu_invasion_kemet",
                    "phar_main_al_khufu_invasion_libu",
                    "phar_main_al_khufu_invasion_nubians",
                    "phar_main_al_khufu_invasion_sea_people",
                    "phar_main_libu",
                    "phar_main_habiru",
                    "phar_main_meshwesh",
                    "phar_main_libu_invaders",
                    "phar_main_phrygian_invaders",
                    "phar_main_egyptian_rebels",
                    "phar_main_hittites_rebels",
                    "phar_main_canaan_rebels",
               },

               court_effect_bundle_treasurer = "phar_main_court_discounts_buildings",
               court_effect_bundle_commander = "phar_main_court_discounts_units",

               -- all AIs with these factions will choose this court
               -- AI_acceptable_factions =
               -- {
               -- 	"phar_main_irsu",
               -- },

               sacred_lands = sacred_aeg_lands,
               mercenaries_replenishment_chance_percent = 20,
               -- the max number of units that can be replenished per turn
               mercenaries_replenishment_per_turn = 2,
               -- locked_until_legitimacy_war_end = true,

               available_positions =
               {
                    wanax =
                    {
                         initial_holder = "", -- the wanax position holder is controlled by aegean political_states
                    },
                    lawagetes =
                    {
                         initial_holder = "",
                         -- bonuses section
                         bonus_pack =
                         {
                              "phar_map_court_lawagetes_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_map_court_lawagetes_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                                   "phar_map_court_lawagetas_small_request",
                              },
                              -- second element is bonus packs for large request
                              {
                                   "phar_map_court_lawagetas_large_request",
                              },
                         },
                    },
                    mycenian_heqetas =
                    {
                         initial_holder = "troy_main_dan_mycenae", -- Agamemnon

                         discounts_bundle = "phar_main_court_discounts_units",
                         discounts_scope = "faction_to_province_own",
                         -- factions who influence the discounts get this mark so they can see the influence
                         can_see_discounts_mark = "can_see_discount_plans_commander",

                         bonus_pack =
                         {
                              "phar_map_court_heqetas_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_high_commander_character_bundle",
                         },

                         -- units provided as mercenary to the position holder
                         position_units =
                         {
                              {
                                   unit_key = "phar_map_achaean_elite_temple_warriors",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_map_achaean_elite_stalker_skirmishers",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_map_achaean_elite_myrmidon_swordsmen",
                                   amount = 1,
                              },
                         },

                         request_units =
                         {
                              {
                                   unit_key = "phar_map_achaean_elite_temple_warriors",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_map_achaean_elite_stalker_skirmishers",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_map_achaean_elite_myrmidon_swordsmen",
                                   amount = 1,
                              },
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },
                    },
                    anatolian_heqetas =
                    {
                         initial_holder = "faction:troy_main_trj_troy,forename:1247459162", -- Hector of Troy, in the Faction of Priam

                         discounts_bundle = "phar_main_court_discounts_units",
                         discounts_scope = "faction_to_province_own",
                         -- factions who influence the discounts get this mark so they can see the influence
                         can_see_discounts_mark = "can_see_discount_plans_commander",

                         bonus_pack =
                         {
                              "phar_map_court_heqetas_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_high_commander_character_bundle",
                         },

                         -- units provided as mercenary to the position holder
                         position_units =
                         {
                              {
                                   unit_key = "phar_map_wilusan_elite_champions_of_troy",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_map_wilusan_elite_trojan_nobles",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_map_wilusan_elite_dardanian_defenders",
                                   amount = 1,
                              },
                         },

                         request_units =
                         {
                              {
                                   unit_key = "phar_map_wilusan_elite_champions_of_troy",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_map_wilusan_elite_trojan_nobles",
                                   amount = 1,
                              },
                              {
                                   unit_key = "phar_map_wilusan_elite_dardanian_defenders",
                                   amount = 1,
                              },
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },
                    },
                    grand_telestas =
                    {
                         initial_holder = "troy_main_dan_knossos",
                         -- ui section
                         localization_key = "ui_text_replacements_localised_text_phar_position_grand_telestas",
                         icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_royal_treasurer.png",
                         description_localization_key =
                         "ui_text_replacements_localised_text_phar_map_court_aegea_grand_telestas_description",
                         help_page_key = "help_crown_court_aegean_positions_grand_telestas",

                         discounts_bundle = "phar_main_court_discounts_buildings",
                         discounts_scope = "faction_to_region_own",
                         -- factions who influence the discounts get this mark so they can see the influence
                         can_see_discounts_mark = "can_see_discount_plans_treasurer",

                         bonus_pack =
                         {
                              "phar_main_court_royal_treasurer_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_main_court_royal_treasurer_aegean_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },
                    },
                    oracle =
                    {
                         initial_holder = "troy_main_dan_dionysias",
                         localization_key = "ui_text_replacements_localised_text_phar_position_oracle",
                         icon_path = "ui\\skins\\default\\court\\position_icons\\icon_court_position_oracle.png",
                         description_localization_key =
                         "ui_text_replacements_localised_text_phar_map_court_aegea_oracle_description",
                         help_page_key = "help_crown_court_aegean_positions_oracle",
                         main_god_key = "zeus",

                         bonus_pack =
                         {
                              "phar_map_court_oracle_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_map_court_oracle_character_bundle",
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                                   "phar_map_court_oracle_small_request",
                              },
                              -- second element is bonus packs for large request
                              {
                                   "phar_map_court_oracle_large_request",
                              },
                         },
                    },
               },

               localization_keys =
               {
                    treasurer_set_discounts_description = "phar_map_court_aegea_grand_telestas_set_discounts_description",
                    treasurer_influence_single_discount_description =
                    "phar_map_court_aegea_grand_telestas_influence_single_discount_description",
                    -- this will not be used for now, as the item that allows multiple bonuses to be influenced is strictly Egyptian... but it is better to have it for completion and futureproofing
                    treasurer_influence_discounts_description =
                    "Select %d bonuses to force %d%% discount on next Shemsu Hor. Other discounts will decrease correspondingly.",
                    treasurer_see_discounts_description = "phar_map_court_aegea_grand_telestas_see_discounts_description",

                    commander_set_discounts_description =
                    "phar_map_court_aegea_mycenian_heqetas_set_discounts_description",
                    commander_influence_single_discount_description =
                    "phar_map_court_aegea_mycenian_heqetas_influence_single_discount_description",
                    -- this will not be used for now, as the item that allows multiple bonuses to be influenced is strictly Egyptian... but it is better to have it for completion and futureproofing
                    commander_influence_discounts_description =
                    "Select %d bonuses to force %d%% discount on next Shemsu Hor. Other discounts will decrease correspondingly.",
                    commander_see_discounts_description =
                    "phar_map_court_aegea_mycenian_heqetas_see_discounts_description",
               },
          },

          --autofilled from fill_court_positions according to available_positions
          positions = {},

          persistent =
          {
               next_plot_generation_turn = 0,
               mercenaries_provided = {},
               plots_persistent_data_by_resolve_turn = {
               },
          },

          political_states = function()
               return aegean_political_states
          end,

          court_legitimacy = function()
               return aegean_legitimacy
          end,

          ruling_faction = function(self)
               return self.political_states().persistent.current_ruling_faction_key
          end,
     },

     mesopotamian_court =
     {
          court_name = "mesopotamian_court",

          config =
          {
               ruler_position = "king_of_universe",
               court_legitimacy_factor_key = "phar_meso_legitimacy_court_intrigue",
               -- for legitimacy provided by positions
               court_legitimacy_positions_factor_key = "phar_meso_legitimacy_court_position",
               court_legitimacy_text_icon = "[[img:icon_pr_mesopotamian_legitimacy_small]][[/img]]",

               -- only factions of these cultures will be accepted in the court
               acceptable_cultures =
               {
                    "phar_main_clt_kemet",
                    "phar_main_clt_canaan",
                    "phar_main_clt_hatti",
                    "phar_main_clt_sea_peoples",
                    "phar_map_clt_mesopotamian",
                    "troy_main_clt_danaans",
                    "troy_main_clt_trojans",
                    "troy_rem_clt_thraco_phrygians",
               },

               -- these factions will not be accepted even if they are of the accepted culture
               banned_factions =
               {
                    "phar_main_kaska",
                    "phar_main_al_khufu_invasion_kemet",
                    "phar_main_al_khufu_invasion_libu",
                    "phar_main_al_khufu_invasion_nubians",
                    "phar_main_al_khufu_invasion_sea_people",
                    "phar_main_libu",
                    "phar_main_habiru",
                    "phar_main_meshwesh",
                    "phar_main_libu_invaders",
                    "phar_main_phrygian_invaders",
                    "phar_main_egyptian_rebels",
                    "phar_main_hittites_rebels",
                    "phar_main_canaan_rebels",
               },

               court_effect_bundle_treasurer = "phar_main_court_discounts_buildings",
               court_effect_bundle_commander = "phar_main_court_discounts_units",

               -- all AIs with these factions will choose this court
               -- AI_acceptable_factions =
               -- {
               -- 	"phar_main_irsu",
               -- },

               sacred_lands = sacred_meso_lands,
               mercenaries_replenishment_chance_percent = 20,
               -- the max number of units that can be replenished per turn
               mercenaries_replenishment_per_turn = 2,
               any_faction_can_hold_multiple_positions = true,

               available_positions =
               {

                    king_of_universe =
                    {
                         initial_holder = "phar_map_assyria", -- the king_of_universe position holder is controlled by meso_political_states (in phar_political_states_mesopotamian.lua)

                         request_units =
                         {
                              {
                                   unit_key = "phar_map_meso_elite_royal_marya",
                                   amount = 1,
                              },
                         },
                    },

                    king_of_assur =
                    {
                         initial_holder = "faction:phar_map_assyria,forename:1616884972", -- Ashur-Nirari III, in phar_map_assyria, heir to the faction leader, who is king of the universe instead
                         related_region_key = "phar_map_aranzah_assur",
                         related_region_plot_success_chance_modifier =
                         {
                              -- the owner of the region will get +X% chance to their preferred outcome (success if they are plotter, failure if they are the plot target)
                              threaten = 30,
                         },

                         bonus_pack =
                         {
                         },

                         character_bonus_pack =
                         {
                              "phar_map_court_king_of_assur_character_bundle",
                         },

                         -- units provided as mercenary to the position holder
                         position_units =
                         {
                              {
                                   unit_key = "phar_map_meso_elite_assur_noblemen",
                                   amount = 1,
                              },
                         },

                         is_unit_request_available_to_court_leader = true,
                         request_units =
                         {
                              {
                                   unit_key = "phar_map_meso_elite_assur_noblemen",
                                   amount = 1,
                              },
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },

                    },

                    king_of_babylon =
                    {
                         initial_holder = "phar_map_babylon",
                         main_god_key = "marduk",
                         related_region_key = "phar_map_kan_digirak_babylon",
                         related_region_plot_success_chance_modifier =
                         {
                              -- the owner of the region will get +X% chance to their preferred outcome (success if they are plotter, failure if they are the plot target)
                              threaten = 30,
                         },

                         -- bonuses section
                         bonus_pack =
                         {
                              "phar_map_court_king_of_babylon_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                         },

                         -- units provided as mercenary to the position holder
                         position_units =
                         {
                              {
                                   unit_key = "phar_map_meso_elite_babylonian_specialists",
                                   amount = 1,
                              },
                         },

                         is_unit_request_available_to_court_leader = true,
                         request_units =
                         {
                              {
                                   unit_key = "phar_map_meso_elite_babylonian_specialists",
                                   amount = 1,
                              },
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                                   "phar_main_court_high_priest_small_request",
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },
                    },

                    king_of_hanigalbat =
                    {
                         initial_holder = "phar_map_ninurta",
                         related_region_key = "phar_map_hanigalbat_dur_katlimmu",
                         related_region_plot_success_chance_modifier =
                         {
                              -- the owner of the region will get +X% chance to their preferred outcome (success if they are plotter, failure if they are the plot target)
                              threaten = 30,
                         },

                         bonus_pack =
                         {
                         },

                         character_bonus_pack =
                         {
                         },

                         -- units provided as mercenary to the position holder
                         position_units =
                         {
                              {
                                   unit_key = "phar_map_meso_elite_euphrats_tigers_chariots",
                                   amount = 1,
                              },
                         },

                         is_unit_request_available_to_court_leader = true,
                         request_units =
                         {
                              {
                                   unit_key = "phar_map_meso_elite_euphrats_tigers_chariots",
                                   amount = 1,
                              },
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                              },
                         },
                    },

                    king_of_elam =
                    {
                         initial_holder = "phar_map_igihalkid",
                         related_region_key = "phar_map_northern_elam_susa",
                         related_region_plot_success_chance_modifier =
                         {
                              -- the owner of the region will get +X% chance to their preferred outcome (success if they are plotter, failure if they are the plot target)
                              threaten = 30,
                         },

                         bonus_pack =
                         {
                              "phar_map_court_king_of_elam_faction_bundle",
                         },

                         character_bonus_pack =
                         {
                              "phar_map_court_king_of_elam_character_bundle",
                         },

                         -- units provided as mercenary to the position holder
                         position_units =
                         {
                              {
                                   unit_key = "phar_map_meso_elite_elamite_royal_chargers",
                                   amount = 1,
                              },
                         },

                         is_unit_request_available_to_court_leader = true,
                         request_units =
                         {
                              {
                                   unit_key = "phar_map_meso_elite_elamite_royal_chargers",
                                   amount = 1,
                              },
                         },

                         request_bonus_packs =
                         {
                              -- first element is bonus packs for small request
                              {
                              },
                              -- second element is bonus packs for large request
                              {
                                   "phar_main_court_high_judge_large_request",
                              },
                         },
                    },
               },

               localization_keys =
               {
                    treasurer_set_discounts_description = "phar_map_court_meso_king_of_babylon_set_discounts_description",
                    treasurer_influence_single_discount_description =
                    "phar_map_court_meso_king_of_babylon_influence_single_discount_description",
                    -- this will not be used for now, as the item that allows multiple bonuses to be influenced is strictly Egyptian... but it is better to have it for completion and futureproofing
                    treasurer_influence_discounts_description =
                    "Select %d bonuses to force %d%% discount on next Shemsu Hor. Other discounts will decrease correspondingly.",
                    treasurer_see_discounts_description = "phar_map_court_meso_king_of_babylon_see_discounts_description",

                    -- THESE ARE NOT USED IN THIS COURT, they are added just for completion and to avoid future crashes from modding, etc.
                    commander_set_discounts_description = "phar_main_court_hatti_commander_set_discounts_description",
                    commander_influence_single_discount_description =
                    "phar_main_court_hatti_commander_influence_single_discount_description",
                    -- this will not be used for now, as the item that allows multiple bonuses to be influenced is strictly Egyptian... but it is better to have it for completion and futureproofing
                    commander_influence_discounts_description =
                    "Select %d bonuses to force %d%% discount on next Shemsu Hor. Other discounts will decrease correspondingly.",
                    commander_see_discounts_description = "phar_main_court_hatti_commander_see_discounts_description",
               },
          },

          --autofilled from fill_court_positions according to available_positions
          positions = {},

          persistent =
          {
               next_plot_generation_turn = 0,
               mercenaries_provided = {},
               plots_persistent_data_by_resolve_turn = {
               },
          },

          political_states = function()
               return meso_political_states
          end,

          court_legitimacy = function()
               return meso_legitimacy
          end,

          ruling_faction = function(self)
               return self.political_states().persistent.current_ruling_faction_key
          end,
     },

     persistent = {
          court_log = {},
          -- we track data for factions,
          -- table for each faction is created in get_faction_persistent_data
          -- NOTE: most of this data is temporary and is cleared on Shemsu Hor, except unit recruitment given by position
          -- format is something like this:
          -- factions_data =
          -- {
          --		{	faction_key = "faction",
          --			favour =
          --			{ -- favour provided by request towards position or position itself
          --				{
          --					god_key = "god_name",
          --					favour_amount = [X],
          --					remove_at_turn = [Y],
          --				},
          --				... other gods
          --			},
          --			actions_used_this_turn = [X], -- optional
          --			unread_log_against_plots_count = 0, -- optional
          --			unread_log_against_plots_by_turn = {}, -- optional, maps turn to notification number
          --			unread_log_other_plots_count = 0, -- optional
          --			unread_log_other_plots_by_turn = {}, -- optional, maps turn to notification number
          --			conspirators =
          --			{ -- positions keys for positions this faction has used 'conspire' with
          --			},
          --			factions_court_cache = [COURT NAME], -- optional, indicates the faction has position in this court. can also be given by cheats
          --		},... other factions
          -- }

          factions_data = {
          },
          -- increased every time a plot is added, to be sure they have a unique plot_id
          plot_last_id = 0,
     },

     -- caching the court factions belong to
     factions_court_cache = {
          -- [faction_key] = faction_court_obj OR false (or nil as default)
     },

     --------------------------------------------------------------
     ----------------------- common functions ---------------------
     --------------------------------------------------------------

     court_functions =
     {
          set_ruling_faction_allowed_positions = function(court_obj, max_allowed_positions_num)
               local ruling_faction = court_obj:ruling_faction()
               if not ruling_faction then
                    court.output("Error: 'set_ruling_faction_allowed_positions' called but there is no court ruler!")
                    return nil
               end

               local ruling_faction_persistent_data = court.util_functions.get_faction_persistent_data(ruling_faction)
               -- since the ruler also a position the faction holds, we need to increase it
               ruling_faction_persistent_data.allowed_positions = max_allowed_positions_num + 1
               return true
          end,
     },

     shemsu_hor =
     {
          -------------------------------------------------------------------------------------
          -- EXTERNAL METHODS: meant to be called from outside this file, for UI or AI purposes

          -------------------------------------------------------------------
          -- INTERNAL METHODS - meant to only be called from inside this file

          on_about_to_advance = function()
               -- we give the players the chance to claim positions, and right before Shemsu Hor ends we give the AI a chance to claim positions
               if shemsu_hor.is_shemsu_hor() then
                    court.ai_position_claims.process_ai_claims()
               end
          end,

          on_arrived = function()
               for _, court_obj in ipairs(court.all_courts) do
                    court.plot_functions:resolve_plots(court_obj)
               end

               for _, faction_data in ipairs(court.persistent.factions_data) do
                    -- most shemsu hor marks are in positions, but these are used for things like claimed positions
                    faction_data.shemsu_hor_marks = {}
               end

               for _, court_obj in ipairs(court.all_courts) do
                    court.shemsu_hor.on_arrived_court(court_obj)
               end

               for _, data_for_faction in ipairs(court.persistent.factions_data) do
                    local faction_key = data_for_faction.faction_key
                    -- clear temporary favour with the gods
                    for i = #data_for_faction.favour, 1, -1 do
                         deities.grant_favour(faction_key,
                              data_for_faction.favour[i].god_key,
                              -data_for_faction.favour[i].favour_amount,
                              "court")
                    end
                    data_for_faction.favour = {}

                    local feature_available = feature_unlock.is_feature_unlocked_for_faction(faction_key,
                         feature_ids_config.court)
                    if feature_available then
                         -- data_for_faction holds only persistent data, we need the config as well
                         local faction_config = court.util_functions.get_faction_config(faction_key)
                         if faction_config and faction_config.random_position_regard_gain then
                              local regard_gained = faction_config.random_position_regard_gain
                              court.shemsu_hor.gain_regard_with_random_position(faction_key, regard_gained)
                         end
                    end
                    data_for_faction.conspirators = nil
               end
          end,

          gain_regard_with_random_position = function(faction_key, regard_gained)
               local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
               if not court_obj then
                    return false
               end

               local faction_obj = cm:get_faction(faction_key)
               if faction_obj:is_human()
                   and not court.util_functions.is_court_legitimacy_unlocked(court_obj, faction_key)
               then
                    return false
               end

               local valid_positions = {}
               for _, position_obj in ipairs(court_obj.positions) do
                    -- vacant positions, and positions held by the faction in question are not valid
                    if position_obj.persistent.current_holder_faction
                        and position_obj.persistent.current_holder ~= faction_key
                    then
                         table.insert(valid_positions, position_obj)
                    end
               end

               if #valid_positions <= 0 then
                    return false
               end

               local random_index = cm:model():random_int(1, #valid_positions)
               local position_obj = valid_positions[random_index]
               local diplomacy_multiplier = court.position_functions.get_diplomacy_regard_change_multiplier(position_obj,
                    faction_key)
               local modified_regard_gained = regard_gained * diplomacy_multiplier
               court.position_functions.change_regard_towards_faction_by_obj(position_obj, faction_key,
                    modified_regard_gained)
               return true
          end,

          on_arrived_court = function(faction_court)
               for _, position_obj in ipairs(faction_court.positions) do
                    position_obj.persistent.shemsu_hor_marks = {}

                    if position_obj.persistent.units
                        and position_obj.persistent.units["request"]
                        and (not is_empty_table(position_obj.persistent.units["request"]))
                    then
                         court.mercenary_functions.remove_units_by_source(faction_court, position_obj, "request")
                    end
               end
          end,

          -- if Shemsu Hor is enabled, returns the turn of the next Shemsu Hor
          -- if disabled, returns the turn after the Shemsu Hor period
          get_cooldown_end_turn = function()
               local current_turn = cm:model():turn_number()
               local cooldown = -1
               if shemsu_hor.is_active then
                    -- the cooldown will end at the next Shemsu Hor
                    local cooldown = shemsu_hor.get_turns_to_shemsu_hor()
                    -- however, if now is Shemsu hor this means we need the one after
                    if cooldown == 0 then
                         cooldown = shemsu_hor.get_shemsu_hor_period()
                    end
               else
                    -- if Shemsu Hor is disabled we take the default cooldown
                    -- some abilities may have their own separate cooldown, they don't call get_cooldown_end_turn
                    cooldown = court.config.non_shemsu_hor_request_cooldown
               end
               local cooldown_end_turn = current_turn + cooldown
               return cooldown_end_turn
          end,
     }, -- shemsu_hor

     mercenary_functions =
     {
          -------------------------------------------------------------------
          -- INTERNAL METHODS - meant to only be called from inside this file

          -- remove_at_turn is an optional integer which indicates when we should remove these units (used when we don't have Shemsu Hor)
          add_units_to_mercenary_pool = function(court_obj, position_obj, faction_obj, units_table, source_str,
                                                 remove_at_turn)
               if not position_obj.persistent.units then
                    position_obj.persistent.units = {}
               end

               if not position_obj.persistent.units[source_str] then
                    position_obj.persistent.units[source_str] = {}
               end

               local source_table = position_obj.persistent.units[source_str]

               local factions_table = nil
               if is_number(remove_at_turn) then
                    if not source_table[remove_at_turn] then
                         source_table[remove_at_turn] = {}
                    end
                    factions_table = source_table[remove_at_turn]
               else
                    factions_table = source_table
               end

               local faction_key = faction_obj:name()
               if not factions_table[faction_key] then
                    factions_table[faction_key] = {}
               end

               local faction_table = factions_table[faction_key]

               for _, unit_table in ipairs(units_table) do
                    local unit_key = unit_table.unit_key
                    local unit_amount = unit_table.amount
                    if faction_table[unit_key] then
                         faction_table[unit_key] = faction_table[unit_key] + unit_amount
                    else
                         faction_table[unit_key] = unit_amount
                    end
                    court.mercenary_functions.change_unit_in_mercenary_pool(
                         court_obj,
                         faction_obj,
                         unit_key,
                         unit_amount,
                         true) -- this indicates we change the available units, not just the max
               end
          end,

          -- this is called when something changes the units provided from a source
          -- for now - the crown gives additional units, we must add them when the crown is equipped
          -- and revert to the fewer units table when crown is removed
          -- to avoid exploits this tries to change only the max amount. the available is only changed to avoid having more than the max
          change_units_in_mercenary_pool = function(court_obj, position_obj, faction_obj, units_table, source_str)
               if not position_obj.persistent.units then
                    position_obj.persistent.units = {}
               end

               if not position_obj.persistent.units[source_str] then
                    position_obj.persistent.units[source_str] = {}
               end

               local source_table = position_obj.persistent.units[source_str]
               local faction_key = faction_obj:name()
               if not source_table[faction_key] then
                    source_table[faction_key] = {}
               end

               local faction_table = source_table[faction_key]
               -- this is what was previously provided
               local old_units_list = table_deep_copy(faction_table)
               -- we need to change the unit amount with the difference
               for _, unit_table in ipairs(units_table) do
                    local unit_key = unit_table.unit_key
                    local unit_amount = unit_table.amount
                    local amount_changed
                    if old_units_list[unit_key] then
                         -- the amount can be negative, if the old list gave more units
                         amount_changed = unit_amount - old_units_list[unit_key]
                         old_units_list[unit_key] = nil
                    else
                         -- the old ist did not give any untis of this type
                         amount_changed = unit_amount
                    end
                    faction_table[unit_key] = unit_amount
                    court.mercenary_functions.change_unit_in_mercenary_pool(
                         court_obj,
                         faction_obj,
                         unit_key,
                         amount_changed)
               end

               -- these are the units that were provided in the old table, but not the new one
               -- they were not removed while iterating the new table, we must remove them separately

               local keyset = {}
               -- we sort the action keys alphabetically so we can iterate deterministically
               for unit_key, _ in pairs(old_units_list) do
                    table.insert(keyset, unit_key)
               end
               keyset = table_stable_sort(keyset, function(a, b) return tostring(a) < tostring(b) end)

               for _, unit_key in ipairs(keyset) do
                    local unit_amount = old_units_list[unit_key]
                    court.mercenary_functions.change_unit_in_mercenary_pool(
                         court_obj,
                         faction_obj,
                         unit_key,
                         -unit_amount)
               end
          end,

          -- remove_at_turn is an optional parameter - some units need to be removed at a particular turn when their request timed out
          remove_units_by_source = function(court_obj, position_obj, source_str, remove_at_turn)
               if not position_obj.persistent.units then
                    return
               end

               if not position_obj.persistent.units[source_str] then
                    return
               end

               local source_table = position_obj.persistent.units[source_str]

               local factions_table = nil
               if is_number(remove_at_turn) then
                    if not source_table[remove_at_turn] then
                         return
                    end
                    factions_table = source_table[remove_at_turn]
               else
                    factions_table = source_table
               end

               local keyset = {}
               -- we sort the action keys alphabetically so we can iterate deterministically
               for faction_key, _ in pairs(factions_table) do
                    table.insert(keyset, faction_key)
               end
               keyset = table_stable_sort(keyset, function(a, b) return tostring(a) < tostring(b) end)

               for _, faction_key in ipairs(keyset) do
                    local faction_obj = cm:get_faction(faction_key)
                    local units_table = factions_table[faction_key]

                    local keyset2 = {}
                    -- we sort the action keys alphabetically so we can iterate deterministically
                    for unit_key, _ in pairs(units_table) do
                         table.insert(keyset2, unit_key)
                    end
                    keyset2 = table_stable_sort(keyset2, function(a, b) return tostring(a) < tostring(b) end)
                    for _, unit_key in ipairs(keyset2) do
                         local unit_amount = units_table[unit_key]
                         court.mercenary_functions.change_unit_in_mercenary_pool(
                              court_obj,
                              faction_obj,
                              unit_key,
                              -unit_amount,
                              true) -- this indicates we change the available units, not just the max
                    end
               end

               if is_number(remove_at_turn) then
                    position_obj.persistent.units[source_str][remove_at_turn] = {}
               else
                    position_obj.persistent.units[source_str] = {}
               end
          end,

          -- mercenary_record is the court record about the unit, if there is any
          -- if I can make it so it's called only from add_units_to_mercenary_pool - move it there
          change_unit_in_mercenary_pool = function(court_obj, faction_obj, unit_key, unit_amount_change,
                                                   should_change_available_amount)
               local faction_cqi = faction_obj:command_queue_index()

               local old_max_amount = cm:get_max_units_in_faction_mercenary_pool(faction_cqi, unit_key, "")
               local new_max_amount = old_max_amount + unit_amount_change
               local old_amount = cm:num_units_in_faction_mercenary_pool(faction_cqi, unit_key)
               local new_amount = old_amount
               if should_change_available_amount then
                    new_amount = old_amount + unit_amount_change
               end

               if new_max_amount < 0 then
                    new_max_amount = 0
               end

               new_amount = math.clamp(new_amount, 0, new_max_amount)

               local replenishment_chance = court_obj.config.mercenaries_replenishment_chance_percent
               local replenishment_per_turn = court_obj.config.mercenaries_replenishment_per_turn

               if new_amount == 0 and new_max_amount == 0 then
                    cm:remove_unit_from_faction_mercenary_pool(faction_obj, unit_key, "")
               else
                    cm:add_unit_to_faction_mercenary_pool(faction_obj,
                         unit_key, -- unit to add to Special Recruitment/merceneries
                         new_amount, -- number of units to add
                         replenishment_chance, -- replenishment chance
                         new_max_amount, -- max amount of units in the pool
                         replenishment_per_turn, -- max amount of units that can be replenished in the pool per turn
                         0,  -- xp level
                         "", "", "") -- custom params may be empty
               end
          end,
     }, -- mercenary_functions

     -- used for favour provided until the next Shemsu Hor
     favour_functions =
     {
          -------------------------------------------------------------------
          -- INTERNAL METHODS - meant to only be called from inside this file

          get_favour_record = function(faction_table, god_key)
               local result = table_find(faction_table.favour, function(e) return e.god_key == god_key end)
               return result
          end,

          -- mercenary_record is the court record about the unit, if there is any
          add_temporary_favour = function(faction_table, god_key_param, favour_amount, remove_at_turn)
               local favour_record = court.favour_functions.get_favour_record(faction_table, god_key_param)
               if not favour_record then
                    favour_record =
                    {
                         god_key = god_key_param,
                         favour_amount = 0,
                         remove_at_turn = remove_at_turn,
                    }
                    table.insert(faction_table.favour, favour_record)
               end

               favour_record.favour_amount = favour_record.favour_amount + favour_amount
               deities.grant_favour(faction_table.faction_key,
                    god_key_param, favour_amount, "court")
          end,
     }, -- favour_functions

     -- these are related to the UI log shown to the player, not logging debug info
     log_functions =
     {
          log_court_action = function(logged_action_str, acting_faction_key, target_position_str, ...)
               -- I'm logging the faction because the Chief of Royal Bodyguards gets notifications for other faction doing intrigues
               local logged_item =
               {
                    action_str = logged_action_str,
                    faction_key = acting_faction_key,
                    position_str = target_position_str,
                    additional_params = arg,
               }

               -- tostring because the debugger does not show int indexed values
               local current_turn = tostring(cm:model():turn_number())
               if not court.persistent.court_log[current_turn] then
                    court.persistent.court_log[current_turn] = {}
               end

               table.insert(court.persistent.court_log[current_turn], logged_item)

               local human_factions = cm:get_human_factions()
               for i = 1, #human_factions do
                    local faction_key = human_factions[i]

                    if court.log_functions.can_faction_view_log_item(faction_key, logged_item) then
                         local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
                         local faction_court = court.util_functions.get_faction_court_for_faction(faction_key)

                         if logged_item.action_str == "plot_created"
                             or logged_item.action_str == "plot_succeeded"
                             or logged_item.action_str == "plot_failed"
                             or logged_item.action_str == "plot_revealed"
                         then
                              local plot_persistent_data = logged_item.additional_params[1]
                              if plot_persistent_data.plotting_faction ~= faction_key then
                                   if faction_table.owned_positions
                                       and table_find(faction_table.owned_positions, plot_persistent_data.targeted_position)
                                   then
                                        if not faction_table.unread_log_against_plots_count then
                                             faction_table.unread_log_against_plots_count = 0
                                        end
                                        faction_table.unread_log_against_plots_count = faction_table
                                        .unread_log_against_plots_count + 1
                                        if not faction_table.unread_log_against_plots_by_turn then
                                             faction_table.unread_log_against_plots_by_turn = {}
                                        end
                                        if not faction_table.unread_log_against_plots_by_turn[current_turn] then
                                             faction_table.unread_log_against_plots_by_turn[current_turn] = 0
                                        end
                                        faction_table.unread_log_against_plots_by_turn[current_turn] = faction_table
                                        .unread_log_against_plots_by_turn[current_turn] + 1
                                   else
                                        if not faction_table.unread_log_other_plots_count then
                                             faction_table.unread_log_other_plots_count = 0
                                        end
                                        faction_table.unread_log_other_plots_count = faction_table
                                        .unread_log_other_plots_count + 1
                                        if not faction_table.unread_log_other_plots_by_turn then
                                             faction_table.unread_log_other_plots_by_turn = {}
                                        end
                                        if not faction_table.unread_log_other_plots_by_turn[current_turn] then
                                             faction_table.unread_log_other_plots_by_turn[current_turn] = 0
                                        end
                                        faction_table.unread_log_other_plots_by_turn[current_turn] = faction_table
                                        .unread_log_other_plots_by_turn[current_turn] + 1
                                   end
                              end
                         end

                         if faction_key == cm:get_local_faction_name(true) then
                              local icon_alert_component = core:get_ui_root():SequentialFind(court.ui.config
                              .component_ids.icon_alert)
                              if icon_alert_component then
                                   local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
                                   local have_unread_plots = court.log_functions.has_unread_notifications(faction_table)
                                   icon_alert_component:SetVisible(have_unread_plots)
                              end
                         end
                    end
               end
               if acting_faction_key == cm:get_local_faction_name(true) then
                    -- log_court_action() function is not the best place for this, but it has everything we need, instead of replicating the code
                    local action_name = logged_action_str
                    local action_subname = ""
                    if action_name == "intrigue_used" then
                         action_subname = arg[1]
                    elseif action_name == "plot_created" then
                         action_subname = arg[1].plot_key
                    elseif action_name == "request_used" then
                         local request_index = arg[1]
                         local faction_court = court.util_functions.get_faction_court_for_faction(acting_faction_key)
                         local court_position_obj = court.util_functions.get_court_position(faction_court,
                              target_position_str)
                         if court_position_obj ~= nil then
                              local request_obj = court_position_obj.requests[request_index]
                              action_subname = request_obj.request_name
                         end
                    end

                    if action_subname ~= "" then
                         cm:notify_court_action_used(acting_faction_key, action_name, action_subname)
                    end
               end
          end,

          can_faction_view_log_item = function(faction_key, logged_item)
               local faction_court = court.util_functions.get_faction_court_for_faction(faction_key)
               local logger_faction_court = court.util_functions.get_faction_court_for_faction(logged_item.faction_key)

               if (not faction_court) or faction_court ~= logger_faction_court then
                    return false
               end

               if logged_item.action_str == "request_used" then
                    -- for logged items involving requests only the two factions involved in the request can view it
                    local court_position_obj = court.util_functions.get_court_position(faction_court,
                         logged_item.position_str)
                    if court_position_obj == nil then
                         return false
                    end

                    local position_faction = court_position_obj.persistent.current_holder_faction
                    if faction_key == logged_item.faction_key or faction_key == position_faction then
                         return true
                    end
                    return false
               elseif logged_item.action_str == "intrigue_used" then
                    -- for logged items involving intrigues only the initiator faction can view the intrigue
                    if faction_key == logged_item.faction_key then
                         return true
                    end
                    return false
               elseif logged_item.action_str == "plot_created" or logged_item.action_str == "plot_revealed" then
                    -- only the two factions involved in the plot and those factions whom plot is revealed to can view the logged item
                    local court_position_obj = court.util_functions.get_court_position(faction_court,
                         logged_item.position_str)
                    if court_position_obj == nil then
                         return false
                    end

                    local position_faction = court_position_obj.persistent.current_holder_faction
                    if faction_key == logged_item.faction_key or faction_key == position_faction then
                         return true
                    end

                    if is_table(logged_item.additional_params) then
                         local plot_persistent_data = logged_item.additional_params[1]
                         local revealed_to_faction = table_find(plot_persistent_data.revealed_to, faction_key)
                         if revealed_to_faction then
                              return true
                         end
                    end

                    return false
               end

               -- for "plot_succeeded", "plot_failed", "position_gained", "position_lost" (or other) logged items all factions in the same faction court can view them
               return true
          end,

          --- @function get_viewable_log_items_count
          --- @desc get number of viewable log items for a faction
          --- @p string faction_key: the faction's db key
          --- @p [opt=nil] number turn_number - if this is set then retrieve the number of log items viewable to the specified faction only for said turn_number
          get_viewable_log_items_count = function(faction_key, turn_number)
               local log_message_count_for_turn = function(turn_number)
                    local count = 0
                    local turn_str = tostring(turn_number)
                    if court.persistent.court_log[turn_str] then
                         local logged_items = court.persistent.court_log[turn_str]
                         for _, logged_item in ipairs(logged_items) do
                              if court.log_functions.can_faction_view_log_item(faction_key, logged_item) then
                                   count = count + 1
                              end
                         end
                    end
                    return count
               end

               if turn_number then
                    return log_message_count_for_turn(turn_number)
               end

               local total_count = 0
               local current_turn = cm:model():turn_number()
               for i = 1, current_turn do
                    total_count = total_count + log_message_count_for_turn(i)
               end

               return total_count
          end,

          has_unread_notifications = function(faction_table)
               local have_unread_plots = (is_number(faction_table.unread_log_against_plots_count) and faction_table.unread_log_against_plots_count > 0)
                   or (is_number(faction_table.unread_log_other_plots_count) and faction_table.unread_log_other_plots_count > 0)
               return have_unread_plots
          end,
     }, -- log_functions

     event_message_functions =
     {
          send_court_plot_failed_event = function(faction_court_obj, plot_persistent_data)
               if (not plot_persistent_data) or (not faction_court_obj) then
                    script_error("ERROR: send_court_plot_failed_event called but supplied improper parameters provided")
                    return
               end

               local plotting_faction_key = plot_persistent_data.plotting_faction
               local position_obj = court.util_functions.get_court_position(faction_court_obj,
                    plot_persistent_data.targeted_position)
               local character_lookup_str = position_obj.persistent.current_holder
               local character_obj = cm:get_character(character_lookup_str)
               local character_cqi = character_obj:command_queue_index()
               local position_localization_key = court.position_functions.get_position_name_localization_key(
               position_obj, faction_court_obj)

               local plot_config = court.plots:get_plot_config_by_key(plot_persistent_data.plot_key)
               local plot_localization_source = court.plot_functions.get_plot_name_source(plot_config, faction_court_obj)
               local critical_failure_string = ""
               if plot_persistent_data.killed_plotter then
                    local plotting_faction = cm:get_faction(plotting_faction_key)
                    local plotter_character = plotting_faction:faction_leader()
                    local plotter_display_name = plotter_character:onscreen_name()
                    critical_failure_string = get_localised_text_replacement_and_source_safe_formatted(
                    court.ui.config.localization_keys.killed_by_plotter_event_key, plotter_display_name)
               end

               -- plot failed event only sent to the plotting faction
               cm:add_event_feed_event("court_plot_fails", plotting_faction_key, 0,
                    position_localization_key, plot_localization_source, critical_failure_string, character_cqi)
          end,

          send_court_plot_succeeds_event = function(faction_court_obj, plot_persistent_data)
               if (not plot_persistent_data) or (not faction_court_obj) then
                    script_error("ERROR: send_court_plot_failed_event called but supplied improper parameters provided")
                    return
               end

               local plotting_faction_key = plot_persistent_data.plotting_faction
               local position_obj = court.util_functions.get_court_position(faction_court_obj,
                    plot_persistent_data.targeted_position)
               core:trigger_event("ScriptEventCourtPlotSucceeded", { plot_persistent_data = plot_persistent_data, })

               local character_lookup_str = position_obj.persistent.current_holder
               local position_localization_key = court.position_functions.get_position_name_localization_key(
               position_obj, faction_court_obj)

               local plot_config = court.plots:get_plot_config_by_key(plot_persistent_data.plot_key)

               -- plot success event sent to all human factions in the court, including the plotter
               local player_factions = cm:get_human_factions()
               for _, faction_key in ipairs(player_factions) do
                    local faction_court_for_faction = court.util_functions.get_faction_court_for_faction(faction_key)
                    -- we check if the faction is in the same court
                    if faction_court_for_faction
                        and faction_court_for_faction == faction_court_obj
                        and court.util_functions.is_court_legitimacy_unlocked(faction_court_for_faction, faction_key)
                        and feature_unlock.is_feature_unlocked_for_faction(faction_key, feature_ids_config.court)
                    then
                         local plot_localization_source = court.plot_functions.get_plot_name_source(plot_config,
                              faction_court_obj)
                         cm:add_event_feed_event("court_plot_succeeds", faction_key, 0,
                              character_lookup_str,
                              position_localization_key, plot_localization_source)
                    end
               end
          end,

          -- this method should be called after the position is filled, so it has the holder
          send_court_position_gained_event = function(faction_court_obj, gained_position_obj)
               local character_lookup_str = gained_position_obj.persistent.current_holder
               local holder_faction_key = gained_position_obj.persistent.current_holder_faction
               local position_localization_key = court.position_functions.get_position_name_localization_key(
               gained_position_obj, faction_court_obj)

               local player_factions = cm:get_human_factions()
               for _, faction_key in ipairs(player_factions) do
                    local faction_court_for_faction = court.util_functions.get_faction_court_for_faction(faction_key)

                    -- we check if the faction is in the same court
                    if faction_court_for_faction
                        and faction_court_for_faction == faction_court_obj
                        and court.util_functions.is_court_legitimacy_unlocked(faction_court_for_faction, faction_key)
                        and feature_unlock.is_feature_unlocked_for_faction(faction_key, feature_ids_config.court)
                    then
                         local event_str = nil
                         if faction_key == holder_faction_key then
                              event_str = "court_position_gained_own"
                         else
                              event_str = "court_position_gained_other"
                         end
                         cm:add_event_feed_event(event_str, faction_key, 0,
                              character_lookup_str,
                              position_localization_key)
                    end
               end
          end,

          -- this method is called before the position is abandoned, so it still has the holder
          send_court_position_abandoned_event = function(faction_court, abandoned_position_obj)
               local character_lookup_str = abandoned_position_obj.persistent.current_holder
               local holder_faction_key = abandoned_position_obj.persistent.current_holder_faction
               local position_localization_key = court.position_functions.get_position_name_localization_key(
               abandoned_position_obj, faction_court)

               local player_factions = cm:get_human_factions()
               for _, faction_key in ipairs(player_factions) do
                    local faction_court_for_faction = court.util_functions.get_faction_court_for_faction(faction_key)
                    -- we check if the faction is in the same court
                    if faction_court_for_faction
                        and faction_court_for_faction == faction_court
                        and court.util_functions.is_court_legitimacy_unlocked(faction_court_for_faction, faction_key)
                        and feature_unlock.is_feature_unlocked_for_faction(faction_key, feature_ids_config.court)
                    then
                         -- this condition will probably change, thus a different if from the one above
                         if faction_key ~= holder_faction_key then
                              cm:add_event_feed_event("court_position_abandoned", faction_key, 0,
                                   character_lookup_str,
                                   position_localization_key)
                         end
                    end
               end
          end,
     }, -- event_message_functions

     util_functions =
     {
          -------------------------------------------------------------------------------------
          -- EXTERNAL METHODS: meant to be called from outside this file, for UI or AI purposes

          -------------------------------------------------------------------
          -- INTERNAL METHODS - meant to only be called from inside this file

          get_faction_court_by_name = function(court_name)
               for _, court_obj in ipairs(court.all_courts) do
                    if court_name == court_obj.court_name then
                         return court_obj
                    end
               end

               court.output("Error: unknown court received: '" .. court_name .. "' in Court_ScriptEventDiscountsSet!", 10)
               return nil
          end,

          get_faction_court_for_faction = function(faction_name)
               local faction_persistent_data = court.util_functions.get_faction_persistent_data(faction_name)
               if faction_persistent_data.faction_court_name then
                    local court_obj = court.util_functions.get_faction_court_by_name(faction_persistent_data
                    .faction_court_name)
                    return court_obj
               end

               if court.factions_court_cache[faction_name] ~= nil then
                    return court.factions_court_cache[faction_name]
               end

               local result = court.util_functions.get_faction_court_for_faction_no_cache(faction_name)
               court.factions_court_cache[faction_name] = result
               return result
          end,

          get_faction_court_for_faction_no_cache = function(faction_name)
               local faction_obj = cm:get_faction(faction_name)
               -- the faction could be destroyed
               if not faction_obj then
                    return false
               end

               -- rebels don't have a court
               if faction_obj:is_rebel() then
                    return false
               end

               local feature_unlocked = feature_unlock.is_feature_unlocked_for_faction(faction_name,
                    feature_ids_config.court)
               if (not feature_unlocked) and faction_obj:is_human() then
                    return false
               end

               for _, court_obj in ipairs(court.all_courts) do
                    if court.util_functions.does_faction_belong_to_court(court_obj, faction_name) then
                         return court_obj
                    end
               end

               return false
          end,

          does_faction_belong_to_court = function(court_obj, faction_key)
               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
               if faction_table
                   and faction_table.faction_court_name
               then
                    return faction_table.faction_court_name == court_obj.court_name
               end

               local pretenders = court_obj.political_states() and court_obj.political_states().persistent.pretenders
               if pretenders and #pretenders > 0
                   and pretenders[1] == faction_key
               then
                    return true
               end

               if court.util_functions.is_court_legitimacy_unlocked(court_obj, faction_key) then
                    return true
               end

               for available_position_name, available_position_config in dpairs(court_obj.config.available_positions) do
                    if available_position_config and available_position_config.initial_holder == faction_key then
                         return true
                    end
               end

               return false
          end,

          -- called on new game or loading
          first_tick_init = function()
               court.resource_keys = cm:model():get_economy_resource_keys()
               for _, court_obj in ipairs(court.all_courts) do
                    court.util_functions.first_tick_init_court(court_obj)
               end

               if court.egyptian_court.persistent.leader_hacked or court.hittite_court.persistent.leader_hacked then
                    court.output("ERROR: set_cheat_court_leader was used on this save, it will not behave consistently",
                         100)
               end

               for _, court_obj in ipairs(court.all_courts) do
                    court.util_functions.check_court_integrity(court_obj)
               end

               if not cm:is_benchmark_mode() then
                    local current_faction_key = cm:model():world():whose_turn_is_it():name()
                    local pending_dilemmas = court.persistent.pending_dilemmas
                    if pending_dilemmas then
                         for _, pending_dilemma in ipairs(pending_dilemmas) do
                              if current_faction_key == pending_dilemma.faction_key then
                                   cm:trigger_custom_dilemma(pending_dilemma.faction_key,
                                        pending_dilemma.db_dilemma_key,
                                        pending_dilemma.payload1,
                                        pending_dilemma.payload2,
                                        pending_dilemma.payload3,
                                        pending_dilemma.payload4
                                   )
                              end
                         end
                    end
               end
          end,

          -- called on new game or loading
          first_tick_init_court = function(faction_court)
               for _, positions_table in ipairs(faction_court.positions) do
                    if positions_table.persistent.current_holder_faction then
                         local faction_specific_table = court.util_functions.get_faction_persistent_data(positions_table
                         .persistent.current_holder_faction)
                         if not faction_specific_table.owned_positions then
                              faction_specific_table.owned_positions = {}
                         end
                         if not table_find(faction_specific_table.owned_positions, positions_table.persistent.name) then
                              table.insert(faction_specific_table.owned_positions, positions_table.persistent.name)
                         end
                    end
               end

               -- if the Hatti court has a similar crown we will need to set different shared state keys
               if faction_court.persistent.pschent_crown then
                    cm:set_script_state(court.developer_config.shared_state.pschent_multiplier,
                         court.config.pschent_crown_effect_multiplier)
               end

               if is_table(faction_court.config.AI_acceptable_factions) then
                    for _, autoaccepted_faction_name in ipairs(faction_court.config.AI_acceptable_factions) do
                         local faction_obj = cm:get_faction(autoaccepted_faction_name)
                         if faction_obj and (not faction_obj:is_null_interface())
                             and (not faction_obj:is_human())
                             and (not faction_obj:is_dead())
                             and (not court.util_functions.is_court_legitimacy_unlocked(faction_court, autoaccepted_faction_name))
                         then
                              court.util_functions.unlock_legitimacy(faction_court, autoaccepted_faction_name, true)
                         end
                    end
               end
          end,

          -- called on new game
          new_game_init = function()
               for _, court_obj in ipairs(court.all_courts) do
                    court.util_functions.fill_court_positions(court_obj, true)
               end
          end,

          --- @function can_claim_position_directly
          --- @desc checks if the faction can claim a position for its leader (without selecting a character)
          --- @p object faction_court - one of the courts listed in court.all_courts
          --- @p string faction_key - the faction trying to claim a position
          --- @p [opt=nil] object position_obj - the position that is tested. if none is provided we test against all positions
          --- @p [opt=false] bool skip_payment - if set to anything other than false/nil the faction will not pay for the position
          --- @p [opt=nil] string supporting_faction_key - the court leader faction, when it gives away the position to [faction_key]
          --- @return boolean, string: whether the faction can claim the position, and if false - the message why they can't claim it
          can_claim_position_directly = function(faction_court, faction_key, position_obj, skip_payment,
                                                 supporting_faction_key)
               local error_message = ""

               local can_claim_position, can_claim_position_error_message = court.util_functions.can_claim_position(
               faction_court, faction_key, skip_payment)
               if not can_claim_position then
                    -- no need to use append_as_red_bullet_point, can_claim_position_directly returns the errors as red bullet
                    error_message = court.util_functions.message_append(error_message, can_claim_position_error_message)
               end

               local faction_obj = cm:get_faction(faction_key)
               local leader_character_obj = faction_obj:faction_leader()
               local is_character_eligible, is_character_eligible_error_message = court.util_functions
               .is_character_eligible(faction_court, leader_character_obj, false)
               if not is_character_eligible then
                    -- no need to use append_as_red_bullet_point, is_character_eligible returns the errors as red bullet
                    error_message = court.util_functions.message_append(error_message,
                         is_character_eligible_error_message)
               end

               local tested_positions = position_obj and { position_obj } or faction_court.positions
               local suitable_position = nil
               local position_error_message = nil
               for index, position_obj in ipairs(tested_positions) do
                    local is_suitable, suitability_message = court.util_functions.is_position_suitable_for_claiming(
                    faction_court, position_obj, faction_key, supporting_faction_key)
                    if is_suitable then
                         suitable_position = position_obj
                         break
                    else
                         position_error_message = suitability_message
                    end
               end

               if not suitable_position then
                    -- no need to use append_as_red_bullet_point, is_position_suitable_for_claiming returns the errors as red bullet
                    error_message = court.util_functions.message_append(error_message, position_error_message)
               end

               if faction_court.config.any_faction_can_hold_multiple_positions then
                    local non_player_facing_error_text =
                    "In this court factions can not claim positions directly, they give them to their Generals!"
                    error_message = court.util_functions.append_as_red_bullet_point(error_message,
                         non_player_facing_error_text)
               else
                    local ruling_faction_key = faction_court:ruling_faction()
                    if ruling_faction_key == faction_key then
                         local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
                         .leader_can_not_claim_position_directly)
                         error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
                    end
               end

               local faction_persistent_data = court.util_functions.get_faction_persistent_data(faction_key)
               if position_obj
                   and faction_persistent_data
                   and is_table(faction_persistent_data.position_bans)
               then
                    local can_claim_turn = faction_persistent_data.position_bans[position_obj.name]
                        or (position_obj.alt_name and faction_persistent_data.position_bans[position_obj.alt_name])
                        or 0

                    if can_claim_turn > cm:model():turn_number() then
                         local claim_turn_str = tostring(can_claim_turn)
                         local formatter_text, _ = get_localised_text_replacement_and_source_safe_formatted(
                         court.ui.config.localization_keys.can_claim_turn_X, claim_turn_str)
                         error_message = court.util_functions.append_as_red_bullet_point(error_message, formatter_text)
                    end
               end

               if error_message == "" then
                    return true
               end
               return false, error_message
          end,

          --- @function can_give_own_character_a_position
          --- @desc checks if the leader of the court can give a position to one of their characters
          --- @p object faction_court - one of the courts listed in court.all_courts
          --- @p string faction_key - the faction trying to claim a position for a character
          --- @p [opt=nil] object position_obj - the position that is tested. if none is provided we test against all positions
          --- @p [opt=nil] object character_obj - character script interface getting the position. if none is provided we test against all faction characters
          --- @p [opt=nil] string supporting_faction_key - the court leader faction, when it gives away the position to [faction_key]
          --- @return boolean, string : whether giving the position is possible, localized message string on why it is impossible
          can_give_own_character_a_position = function(faction_court, faction_key, position_obj, character_obj,
                                                       supporting_faction_key)
               local error_message = ""

               -- testing the state of the court and the faction in general
               local can_claim_position, can_claim_position_error_message = court.util_functions.can_claim_position(
               faction_court, faction_key)
               if not can_claim_position then
                    -- no need to use append_as_red_bullet_point, can_claim_position_directly returns the errors as red bullet
                    error_message = court.util_functions.message_append(error_message, can_claim_position_error_message)
               end

               -- testing the position, or any available position
               local tested_positions = position_obj and { position_obj } or faction_court.positions
               local suitable_position = nil
               local position_error_message = nil
               for index, position_obj in ipairs(tested_positions) do
                    local is_suitable, suitability_message = court.util_functions.is_position_suitable_for_claiming(
                    faction_court, position_obj, faction_key, supporting_faction_key)
                    if is_suitable then
                         suitable_position = position_obj
                         break
                    else
                         position_error_message = suitability_message
                    end
               end

               if not suitable_position then
                    if #tested_positions == 1 then
                         error_message = court.util_functions.message_append(error_message, position_error_message)
                    else
                         error_message = court.util_functions.message_append(error_message,
                              get_localised_text_replacement(court.ui.config.localization_keys.no_available_positions))
                    end
               end

               -- testing the character, or any available character
               if character_obj then
                    local is_character_eligible, is_character_eligible_error_message = court.util_functions
                    .is_character_eligible(faction_court, character_obj)
                    if not is_character_eligible then
                         -- no need to use append_as_red_bullet_point, is_character_eligible returns the errors as red bullet
                         error_message = court.util_functions.message_append(error_message,
                              is_character_eligible_error_message)
                    end
               else
                    local faction_obj = cm:get_faction(faction_key)
                    local available_characters = court.util_functions.get_eligible_characters(faction_court, faction_obj)
                    if not is_table(available_characters) or #available_characters == 0 then
                         -- then we add the text that there are no characters
                         local localized_text, _ = get_localised_text_replacement(court.ui.config.localization_keys
                         .no_available_characters)
                         error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
                    end
               end

               -- if the court allows any faction to put any number of characters in a position - these are the only checks we need to do
               if faction_court.config.any_faction_can_hold_multiple_positions then
                    if error_message == "" then
                         return true
                    end
                    return false, error_message
               end

               local local_ruling_faction = faction_court:ruling_faction()
               if not local_ruling_faction then
                    return false -- there is no ruling faction, we're not even sending an error message
               end

               local localized_ruling_faction_name = common.get_localised_string("factions_screen_name_" ..
               local_ruling_faction)
               local localized_faction_name = common.get_localised_string("factions_screen_name_" .. faction_key)
               if faction_key ~= local_ruling_faction then
                    local localized_text, _ = get_localised_text_replacement_and_source_formatted(
                    court.ui.config.localization_keys.only_leader_can_appoint_character_to_position,
                         localized_ruling_faction_name, localized_faction_name)
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
               end

               local faction_persistent_data = court.util_functions.get_faction_persistent_data(faction_key)
               if not faction_persistent_data.owned_positions then
                    faction_persistent_data.owned_positions = {}
               end

               local owned_positions = #faction_persistent_data.owned_positions
               local faction_max_positions = faction_persistent_data.allowed_positions
               if not faction_max_positions then
                    local legitimacy_system = faction_court.court_legitimacy()
                    local power_system = legitimacy_system.powers_system
                    faction_max_positions = power_system:get_max_court_positions_available(faction_key)
                    if faction_max_positions then
                         -- we cache it for next time
                         faction_persistent_data.allowed_positions = faction_max_positions
                    else
                         -- no luck, we get the default value
                         -- the court leader can have 1 extra position by default
                         -- since the court leader itself is now also a position, we increase it by 1
                         faction_max_positions = 2
                    end
               end

               if faction_max_positions <= owned_positions then
                    local localized_text, _ = get_localised_text_replacement_and_source(court.ui.config
                    .localization_keys.leader_has_max_positions)
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
               end

               if shemsu_hor.is_active and not shemsu_hor.is_shemsu_hor() then
                    -- normally positions can be taken or given to charactes only on Shemsu Hor
                    -- however, there is an exception - if the ruler got their position this turn they are allowed to
                    -- so we do not add an error message in this case
                    local ruler_position = court.util_functions.get_court_position(faction_court,
                         faction_court.config.ruler_position)
                    local current_turn = cm:model():turn_number()
                    if ruler_position.persistent.turn_gained ~= current_turn then
                         local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
                         .claim_position_only_during_shemsu_hor)
                         error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
                    end
               end

               if error_message == "" then
                    return true, ""
               end

               return false, error_message
          end,

          -- helper functions for claiming positions

          -- returns if the faction is capable of claiming a position in general - it can afford it, has enough court actions, the court in the proper state - factors excluding the specific character and position
          can_claim_position = function(faction_court, faction_key, skip_payment)
               local error_message = ""

               local has_pending_dilemma = court.util_functions.is_dilemma_active()
               if has_pending_dilemma then
                    local localized_error, _ = get_localised_random_string_and_source(court.ui.config.localization_keys
                    .dilemma_is_active)
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_error)
               end

               local max_court_actions_per_turn = court.util_functions.max_court_actions_for_faction(faction_key)
               local court_actions_used_this_turn = court.util_functions.get_court_actions_used_this_turn(faction_key)
               if max_court_actions_per_turn - court_actions_used_this_turn < 1 then
                    local text, _ = get_localised_text_replacement_and_source_formatted(
                    court.plots.localization_keys.faction_out_of_court_actions, max_court_actions_per_turn)
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, text)
               end

               if (not court.config.can_take_positions_during_war) and court.util_functions.is_in_legitimacy_war(faction_court)
               then
                    local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
                    .can_not_claim_position_during_war)
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
               end

               local legitimacy_amt = faction_court.court_legitimacy():get_legitimacy(faction_key)

               if legitimacy_amt < court.config.min_legitimacy_to_claim_position then
                    local localized_text, _ = get_localised_text_replacement_and_source_formatted(
                    court.ui.config.localization_keys.not_enough_legitimacy_to_claim_position,
                         court.config.min_legitimacy_to_claim_position, legitimacy_amt)
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
               end

               if shemsu_hor.is_active and not shemsu_hor.is_shemsu_hor() then
                    local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
                    .claim_position_only_during_shemsu_hor)
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
               end

               if not skip_payment then
                    local claim_cost_obj = court.position_functions.get_claim_position_cost_obj(faction_court,
                         faction_key)
                    local faction_obj = cm:get_faction(faction_key)
                    local can_afford = faction_obj:can_afford_resource_cost_object(claim_cost_obj)
                    if not can_afford then
                         local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
                         .can_not_afford_fees_for_position)
                         error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
                    end
               end

               if not court.util_functions.is_faction_accepted_in_court(faction_court, faction_key) then
                    return false, "Faction is not accepted in this court"
               end

               if error_message == "" then
                    return true
               end

               return false, error_message
          end,

          --- @function is_character_eligible
          --- @desc checks if the character can hold a position in this court
          --- @p object faction_court - one of the courts listed in court.all_courts
          --- @p object character_obj - the character we want to test
          --- @p [opt = true] bool test_position - if the function should test the character for already holding a positon
          --- @return boolean, string: whether giving the charactger is eligible, and if false - the message why they are not eligible (message is currently not shown to players, thus not localized)
          is_character_eligible = function(faction_court, character_obj, test_position)
               if (not character_obj) or
                   character_obj:is_null_interface()
               then
                    -- not having an eligible character can be a result from a faction missing a leader for a few frames
                    -- this is not a player-facing error, so we return no error message
                    return false, ""
               end
               if test_position == nil then
                    test_position = true
               end
               local error_message = ""
               if character_obj:is_wounded() then
                    local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
                    .cant_claim_character_wounded)
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
               end

               if not character_obj:character_type("general") then
                    -- should not be a player facing error
                    local localized_text = "Only generals can gain positions"
                    error_message = court.util_functions.append_as_red_bullet_point(error_message, localized_text)
               end

               if test_position then
                    local character_holds_position = false
                    for index, position_obj in ipairs(faction_court.positions) do
                         if position_obj and position_obj.persistent.current_holder then
                              local holder_character = cm:get_character(position_obj.persistent.current_holder)
                              if holder_character and holder_character:command_queue_index() == character_obj:command_queue_index() then
                                   character_holds_position = true
                                   break
                              end
                         end
                    end
                    if character_holds_position then
                         -- should not be a player facing error
                         local non_player_facing_error_text = "Character already holds a position"
                         error_message = court.util_functions.append_as_red_bullet_point(error_message,
                              non_player_facing_error_text)
                    end
               end

               -- some courts allow any faction to put any character in any (non-court-leader) position
               -- we don't check for these
               if not faction_court.config.any_faction_can_hold_multiple_positions then
                    local faction_leader_character = character_obj:faction():faction_leader()
                    local court_leader_faction = faction_court:ruling_faction()

                    if court_leader_faction == character_obj:faction():name() then
                         -- the leader faction is trying to give a position to its character
                         -- they can't give a sposition to their faction leader, we need to check for that
                         if faction_leader_character == character_obj then
                              -- should not be a player facing error
                              local localized_text = "You can only give the position to your generals, not your leader"
                              error_message = court.util_functions.append_as_red_bullet_point(error_message,
                                   localized_text)
                         end
                    else
                         if faction_leader_character ~= character_obj then
                              -- a non-leader faction is trying to give a position to a non-faction-leader character - they can't do that
                              local localized_text =
                              "Only the court leader can give positions to characters in this court!"
                              error_message = court.util_functions.append_as_red_bullet_point(error_message,
                                   localized_text)
                         end
                    end
               end

               -- should we check if the character already holds a position?
               if error_message == "" then
                    return true
               end

               return false, error_message
          end,

          -- supporting_faction_key is an optional parameter, used when the court leader gives away the position to faction_key
          is_position_suitable_for_claiming = function(faction_court, position_obj, faction_key, supporting_faction_key)
               local error_message = ""

               local holds_related_region, related_region_message = court.util_functions.does_faction_own_related_region(
               faction_key, faction_court, position_obj)
               if not holds_related_region then
                    if supporting_faction_key then
                         -- if the court leader holds the required region, they can give the position to anyone
                         holds_related_region, related_region_message = court.util_functions
                         .does_faction_own_related_region(supporting_faction_key, faction_court, position_obj)
                    end

                    if not holds_related_region then
                         error_message = court.util_functions.message_append(error_message, related_region_message)
                    end
               end

               if position_obj.persistent.current_holder_faction then
                    -- should not be a player facing error
                    local non_player_facing_error_text = "This position is not vacant"
                    error_message = court.util_functions.append_as_red_bullet_point(error_message,
                         non_player_facing_error_text)
               end

               if position_obj.position_config.claim_forbidden then
                    -- should not be a player facing error
                    local non_player_facing_error_text = "You can't claim this position"
                    error_message = court.util_functions.append_as_red_bullet_point(error_message,
                         non_player_facing_error_text)
               end

               if error_message == "" then
                    return true
               end

               return false, error_message
          end,

          get_position_related_region = function(faction_court, position_obj)
               local court_specific_config = court.util_functions.get_position_config_from_court(faction_court,
                    position_obj)
               if (not court_specific_config)
                   or (not is_string(court_specific_config.related_region_key))
               then
                    -- there is no related region
                    return nil
               end

               local related_region_obj = cm:get_region(court_specific_config.related_region_key)
               if (not related_region_obj)
                   or related_region_obj:is_null_interface()
               then
                    return nil
               end

               return related_region_obj
          end,

          -- positions can have related regions that give them some effects
          does_faction_own_related_region = function(faction_key, faction_court, position_obj)
               local related_region_obj = court.util_functions.get_position_related_region(faction_court, position_obj)
               if not related_region_obj then
                    -- this position has no related region
                    return true
               end

               local region_owner = related_region_obj:owning_faction()
               if (not region_owner)
                   or region_owner:is_null_interface()
                   or region_owner:name() ~= faction_key
               then
                    local localized_text = get_localised_text_replacement(court.ui.config.localization_keys
                    .need_region_to_claim)
                    local position_localized_string = court.position_functions.get_localized_position_name(position_obj,
                         faction_court)
                    local error_message = common.string_safe_format(localized_text,
                         related_region_obj:localised_display_name(), position_localized_string)
                    error_message = court.util_functions.append_as_red_bullet_point("", error_message)
                    return false, error_message
               end

               return true
          end,

          --- @function get_eligible_characters
          --- @desc returns all the generals from the faction who can claim a position - it assumed the faction can give positions to characters
          --- @p object faction_court - one of the courts listed in court.all_courts
          --- @p object faction_key - the faction whose characters we need to test
          --- @return table with the characters as character_script_interface
          get_eligible_characters = function(faction_court, faction_obj)
               local characters = faction_obj:character_list()
               local available_characters = {}

               for i = 0, characters:num_items() - 1 do
                    local character_obj = characters:item_at(i);
                    if court.util_functions.is_character_eligible(faction_court, character_obj) then
                         table.insert(available_characters, character_obj)
                    end
               end

               return available_characters
          end,

          get_character_at_position = function(faction_court, court_position_str)
               local court_position = court.util_functions.get_court_position(faction_court, court_position_str)
               if not court_position then
                    return nil
               end
               return court_position.persistent.current_holder
          end,

          get_court_position = function(faction_court, court_position_str, supress_output)
               if not court_position_str then
                    if not supress_output then
                         court.output("Error - empty 'court_position_str' param sent to get_court_position!", 10)
                    end
                    return nil
               end

               local found_position = table_find(faction_court.positions,
                    function(e) return e.name == court_position_str or e.alt_name == court_position_str end)

               if not found_position and not supress_output then
                    court.output("Error - court_position_str '" .. court_position_str .. "' not found!", 10)
               end
               return found_position
          end,

          is_faction_accepted_in_court = function(faction_court, faction_key)
               local faction_obj = cm:get_faction(faction_key)
               if faction_court.config.banned_factions then
                    if table_find(faction_court.config.banned_factions, faction_key) then
                         return false
                    end
               end

               local faction_culture = faction_obj:culture()
               for _, accepted_cuture in ipairs(faction_court.config.acceptable_cultures) do
                    if accepted_cuture == faction_culture then
                         return true
                    end
               end

               return false
          end,

          -- if the faction leader of the faction is in any way related to the court leader character (including by marriage)
          is_related_to_leader = function(faction_court, faction_key)
               local local_ruling_faction_key = faction_court:ruling_faction()
               if not local_ruling_faction_key then
                    return false
               end
               local local_ruling_faction = cm:get_faction(local_ruling_faction_key)
               if (not local_ruling_faction)
                   or local_ruling_faction:is_null_interface()
               then
                    return false
               end

               local court_leader_character = local_ruling_faction:faction_leader()
               if not court_leader_character then
                    return false
               end

               local faction_obj = cm:get_faction(faction_key)
               local faction_leader_character = faction_obj:faction_leader()
               if not faction_leader_character then
                    return false
               end

               local is_related = court_leader_character:family_member():is_in_same_family_as(faction_leader_character
               :family_member())
               return is_related
          end,

          is_subject_to_leader = function(faction_court, faction_obj)
               if court.config.ignore_vassalage then
                    return true
               end

               local local_ruling_faction = faction_court:ruling_faction()
               if not local_ruling_faction then
                    -- if there is no leader you can't be their subject
                    return false
               end

               local leader_faction_obj = cm:get_faction(local_ruling_faction)
               if not leader_faction_obj then
                    court.output("Can't find faction object for court leader '" .. local_ruling_faction .. "'!", 10)
                    return false
               end

               local result = faction_obj:is_subject_of(leader_faction_obj)
               return result
          end,

          -- for cheats and debug purposes
          lock_legitimacy = function(faction_court, faction_name)
               local legitimacy_id = faction_court.court_legitimacy().config.id
               if legitimacy_choice.persistent.unlocked_legitimacies[legitimacy_id]
                   and legitimacy_choice.persistent.unlocked_legitimacies[legitimacy_id][faction_name]
               then
                    legitimacy_choice.persistent.unlocked_legitimacies[legitimacy_id][faction_name] = nil
               end
          end,

          unlock_legitimacy = function(faction_court, faction_name, ignore_checks)
               legitimacy_choice:unlock_legitimacy(faction_court.court_legitimacy(), faction_name, ignore_checks)
          end,

          -- fills the faction_court.positions tables, and sets the initial holders
          fill_court_positions = function(faction_court, set_initial_holders)
               local position_templates_by_legitimacy = {}
               for available_position_name, available_position_config in dpairs(faction_court.config.available_positions) do
                    local position_template = table_find(court.position_templates,
                         function(e) return e.name == available_position_name or e.alt_name == available_position_name end)
                    table.insert(position_templates_by_legitimacy, position_template)
               end
               position_templates_by_legitimacy = table_stable_sort(position_templates_by_legitimacy,
                    function(position_a, position_b)
                         return position_a.position_config.legitimacy_provided >
                         position_b.position_config.legitimacy_provided
                    end)

               for index, position_template in ipairs(position_templates_by_legitimacy) do
                    local available_position_name = position_template.name
                    local court_position_setup = faction_court.config.available_positions[available_position_name]
                        or (position_template.alt_name and faction_court.config.available_positions[position_template.alt_name])

                    local initial_holder = court_position_setup.initial_holder
                    local new_table_created = false
                    local position_instance = court.util_functions.get_court_position(faction_court,
                         position_template.name, true)
                    if not position_instance then
                         position_instance = { persistent = table_deep_copy(position_template.persistent) }
                         new_table_created = true
                    end

                    setmetatable(position_instance, position_template)
                    position_template.__index = position_template

                    -- needed to match the persistent portions in save/load
                    position_instance.persistent.name = position_template.name

                    if set_initial_holders and initial_holder then
                         if initial_holder == "" and available_position_name == faction_court.config.ruler_position then
                              -- court leader assignment is managed by political states, thus we will get the `initial_holder` configuration from there
                              -- (`court.util_functions:ruling_faction()` hasn't been initialized yet at this point)
                              initial_holder = faction_court.political_states():get_ruler_faction()
                         end

                         local faction_obj = initial_holder and cm:get_faction(initial_holder)
                         if faction_obj and (not faction_obj:is_null_interface()) then
                              local character_obj = faction_obj:faction_leader()
                              if character_obj:is_null_interface() then
                                   court.output(
                                   "Error: can't find the leader of faction '" ..
                                   initial_holder .. "' as initial holder of position '" .. position_template.name .. "'",
                                        10)
                              else
                                   local result = court.position_functions.give_position_internal(faction_court,
                                        character_obj, position_template.name,
                                        true, -- suppress_eligibility_checks
                                        true, -- skip_payment
                                        true -- initial_holder
                                   )

                                   -- initial holder is a faction
                                   court.util_functions.unlock_legitimacy(faction_court, initial_holder, true)
                              end
                         elseif initial_holder ~= nil and initial_holder ~= "" then
                              local character_obj = cm:get_character(initial_holder)
                              if character_obj and (not character_obj:is_null_interface()) then
                                   local result = court.position_functions.give_position_internal(faction_court,
                                        character_obj, position_template.name,
                                        true, -- suppress_eligibility_checks
                                        true, -- skip_payment
                                        true -- initial_holder
                                   )

                                   -- initial holder is a character
                                   local faction_name = character_obj:faction():name()
                                   court.util_functions.unlock_legitimacy(faction_court, faction_name, true)
                              end
                         end
                    end

                    if new_table_created then
                         table.insert(faction_court.positions, position_instance)
                    end
               end
          end,

          -- related to the pschent_crown - changes the state and the bonuses provided
          set_pschent_crown_equipped = function(faction_court, equipped)
               if to_bool(faction_court.persistent.pschent_crown) == to_bool(equipped) then
                    court.output("set_pschent_crown_equipped called but no actual change is requested.")
                    return
               end

               -- we need to remove the old bonuses
               for _, position_obj in ipairs(faction_court.positions) do
                    -- skipping if the position is empty
                    if position_obj and position_obj.persistent.current_holder_faction and position_obj.persistent.current_holder_faction ~= "" then
                         local character_obj = cm:get_character(position_obj.persistent.current_holder)
                         court.position_functions.remove_position_bonuses(faction_court, character_obj, position_obj)
                    end
               end

               -- change the state of the court
               faction_court.persistent.pschent_crown = equipped
               local court_name = faction_court.court_name
               if equipped then
                    court.output("pschent_crown equipped to '" .. court_name .. "'")
               else
                    court.output("pschent_crown unequipped from '" .. court_name .. "'")
               end

               -- and give the new bonuses
               for _, position_obj in ipairs(faction_court.positions) do
                    -- skipping if the position is empty
                    if position_obj and position_obj.persistent.current_holder_faction and position_obj.persistent.current_holder_faction ~= "" then
                         -- the bonuses and units provided may have changed with the crown, we need to update them
                         local character_obj = cm:get_character(position_obj.persistent.current_holder)
                         court.position_functions.give_position_bonuses(faction_court, character_obj, position_obj)
                         court.position_functions.update_position_mercenary_units(faction_court, position_obj)
                    end

                    -- some positions need to update data even when the position is vacant,
                    -- this is why this call is not in the if above
                    if is_function(position_obj.on_crown_state_changed) then
                         position_obj:on_crown_state_changed(faction_court, equipped)
                    end
                    -- the discounts may be changed from the crown change
                    court.discount_functions.on_crown_state_changed(position_obj, faction_court, equipped)
               end

               -- if Hittite have their pschent crown equivalent they will need different script state strings
               if equipped then
                    cm:set_script_state(court.developer_config.shared_state.pschent_multiplier,
                         court.config.pschent_crown_effect_multiplier)
               else
                    cm:remove_script_state(court.developer_config.shared_state.pschent_multiplier)
               end
          end,

          is_pschent_crown_equipped = function(faction_court)
               if court.util_functions.is_in_legitimacy_war(faction_court) then
                    -- this should not occur, but in case it does - if there is a legitimacy war, there is no official court leader and the crown effects are not applied
                    return false
               end
               -- in case it is nil we want to force true/false
               local result = faction_court.persistent.pschent_crown or false
               return result
          end,

          is_in_legitimacy_war = function(court_obj)
               local result = court_obj:political_states():political_state() == "legitimacy_war"
               return result
          end,

          get_faction_persistent_data = function(faction_str)
               local faction_config = court.util_functions.get_faction_config(faction_str)
               -- get_faction_config must create a new table if none exists, so no need to check if it is nil
               -- but we should check if we already cached it
               if faction_config.faction_persistent_data then
                    return faction_config.faction_persistent_data
               end

               local faction_data = table_find(court.persistent.factions_data,
                    function(e) return e.faction_key == faction_str end)
               if faction_data then
                    -- we cache it for easier access next time
                    faction_config.faction_persistent_data = faction_data
                    return faction_data
               end

               faction_data = {
                    faction_key = faction_str,
                    units = {},
                    favour = {},
               }
               table.insert(court.persistent.factions_data, faction_data)

               -- we cache it for easier access next time
               faction_config.faction_persistent_data = faction_data
               return faction_data
          end,

          max_court_actions_for_faction = function(faction_key)
               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
               -- the actions available by default to the faction
               local standard_actions = court.util_functions.get_property(faction_key, "max_court_actions_per_turn")

               -- we get the actions available from script bonuses
               local bonus_actions = 0
               local faction_obj = cm:get_faction(faction_key)
               if faction_obj then
                    bonus_actions = faction_obj:bonus_values():scripted_value("court_actions_mod", "value")
               end

               -- actions obtained through intrigues, purchases, or other rules
               local extra_actions = faction_table.extra_actions_this_turn or 0
               local result = standard_actions + bonus_actions + extra_actions
               return result
          end,

          add_court_extra_actions_for_faction = function(faction_key, amount)
               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)

               if faction_table.extra_actions_this_turn then
                    faction_table.extra_actions_this_turn = faction_table.extra_actions_this_turn + amount
               else
                    faction_table.extra_actions_this_turn = amount
               end
          end,

          get_court_actions_used_this_turn = function(faction_key)
               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
               local result = faction_table.actions_used_this_turn or 0
               return result
          end,

          get_available_court_actions = function(faction_key)
               local max_court_actions_per_turn = court.util_functions.max_court_actions_for_faction(faction_key)
               local court_actions_used_this_turn = court.util_functions.get_court_actions_used_this_turn(faction_key)
               local available_actions = max_court_actions_per_turn - court_actions_used_this_turn
               return available_actions
          end,

          can_use_court_actions = function(faction_key, num_actions)
               local available_actions = court.util_functions.get_available_court_actions(faction_key)
               if available_actions < num_actions then
                    return false
               end
               return true
          end,

          -- increase_amount is optional, 1 by default
          increase_used_court_actions_for_faction = function(faction_court, faction_key, increase_amount)
               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
               court.util_functions.increase_used_court_actions_for_faction_by_table(faction_table, increase_amount)
          end,

          -- increase_amount is optional, 1 by default
          increase_used_court_actions_for_faction_by_table = function(faction_table, increase_amount)
               local increase = increase_amount
               if not increase then
                    increase = 1
               end

               if faction_table.actions_used_this_turn then
                    faction_table.actions_used_this_turn = faction_table.actions_used_this_turn + increase
               else
                    faction_table.actions_used_this_turn = increase
               end

               local event_data =
               {
                    acting_faction = faction_table.faction_key,
                    acting_faction_obj = cm:get_faction(faction_table.faction_key),
                    number_of_actions = increase,
               }
               core:trigger_event("CourtActionTriggerScriptEvent", event_data)
          end,

          on_round_start = function()
               court.output("round started")
               if not court.persistent.factions_data then
                    return
               end

               for _, court_obj in ipairs(court.all_courts) do
                    court.util_functions.check_position_integrity(court_obj)
                    court.util_functions.on_round_start_court(court_obj)
                    court.plot_generation.generate_ai_plots(court_obj)
               end

               if shemsu_hor.is_active then
                    if shemsu_hor.get_turns_to_shemsu_hor() == shemsu_hor.get_shemsu_hor_period() - 1 then
                         court.util_functions.clear_shemsu_hor_log_and_notifications()
                    end
               else
                    court.util_functions.remove_old_log_items_and_notifications()
               end

               for _, faction_table in ipairs(court.persistent.factions_data) do
                    if faction_table.actions_used_this_turn then
                         faction_table.actions_used_this_turn = nil
                    end

                    local extra_actions_this_turn = nil
                    local max_accumulated_actions = court.util_functions.get_property(faction_table.faction_key,
                         "max_accumulated_actions")
                    local new_actions = court.util_functions.get_property(faction_table.faction_key,
                         "max_court_actions_per_turn")
                    if max_accumulated_actions > new_actions then
                         local feature_available = feature_unlock.is_feature_unlocked_for_faction(
                         faction_table.faction_key, feature_ids_config.court)
                         local court_for_faction = court.util_functions.get_faction_court_for_faction(faction_table
                         .faction_key)
                         local turns_to = shemsu_hor.get_turns_to_shemsu_hor()
                         local period = shemsu_hor.get_shemsu_hor_period()
                         -- the faction needs to have the Court feature unlocked and belong to a court
                         -- also right after Shemsu Hor factions lose all their accumulated actions - so we reset them on that turn
                         if feature_available
                             and court_for_faction
                             and turns_to ~= period - 1
                         then
                              -- new_actions is the amount of new actions we get this turn by default, so the max extra actions is reduced by it
                              local max_extra_actions = max_accumulated_actions - new_actions
                              local available_actions = court.util_functions.get_available_court_actions(faction_table
                              .faction_key)
                              if max_extra_actions < available_actions then
                                   -- accumulating all the previously available actions would bring the sum over the accumulation limit, so we use it instead
                                   extra_actions_this_turn = max_extra_actions
                              else
                                   -- all the previously available actions can accumulate, so are now considered extra actions
                                   extra_actions_this_turn = available_actions
                              end
                         end
                    end
                    faction_table.extra_actions_this_turn = extra_actions_this_turn

                    if faction_table.has_cease_request then
                         faction_table.has_cease_request = nil
                    end

                    if faction_table.has_embezzle_request then
                         faction_table.has_embezzle_request = nil
                    end

                    if faction_table.has_assassinate_request then
                         faction_table.has_assassinate_request = nil
                    end

                    if not shemsu_hor.is_active then
                         -- we should check the things that would otherwise be cleared on Shemsu Hor but have cooldowns now
                         local feature_available = feature_unlock.is_feature_unlocked_for_faction(
                         faction_table.faction_key, feature_ids_config.court)
                         if feature_available then
                              local random_position_regard_gain = court.util_functions.get_property(
                              faction_table.faction_key, "random_position_regard_gain")
                              local faction_persistent_data = court.util_functions.get_faction_persistent_data(
                              faction_table.faction_key)
                              if random_position_regard_gain then
                                   local current_turn = cm:model():turn_number()
                                   if (not is_number(faction_persistent_data.next_random_regard_gain))
                                       or faction_persistent_data.next_random_regard_gain <= current_turn
                                   then
                                        local success = court.shemsu_hor.gain_regard_with_random_position(
                                        faction_table.faction_key, random_position_regard_gain)
                                        if success then
                                             faction_persistent_data.next_random_regard_gain = current_turn +
                                             court.config.non_shemsu_hor_request_cooldown
                                        end
                                   end
                              end

                              if is_table(faction_persistent_data.favour) and #faction_persistent_data.favour > 0 then
                                   local current_turn = cm:model():turn_number()
                                   for index = #faction_persistent_data.favour, 1, -1 do
                                        local god_favor_table = faction_persistent_data.favour[index]
                                        if is_number(god_favor_table.remove_at_turn) and god_favor_table.remove_at_turn <= current_turn then
                                             deities.grant_favour(faction_table.faction_key,
                                                  god_favor_table.god_key,
                                                  -god_favor_table.favour_amount,
                                                  "court")
                                             table.remove(faction_persistent_data.favour, index)
                                        end
                                   end
                              end
                         end
                    end
               end

               -- if the Shemsu Hor system is not active, we try to claim position and resolve plots that end on this turn
               if not shemsu_hor.is_active then
                    for _, court_obj in ipairs(court.all_courts) do
                         -- the order is important! first we let the AIs claim any vacant position
                         court.ai_position_claims.process_ai_claims_for_court(court_obj)
                         -- then we resolve the plots so positions can become vacant and the player can take them
                         -- if the player doesn't, the AIs will get their chance next turn
                         court.plot_functions:resolve_plots(court_obj)
                    end
               end
          end,

          on_round_start_court = function(faction_court)
               for _, position_obj in ipairs(faction_court.positions) do
                    -- some positions may give discounts
                    court.discount_functions.on_round_start(position_obj, faction_court)
                    if is_function(position_obj.on_round_start) then
                         position_obj:on_round_start(faction_court)
                    end
               end
          end,

          -- if Shemsu Hor is active we need to clear the log and all notifications
          clear_shemsu_hor_log_and_notifications = function()
               -- we clear the court log right after Shemsu Hor is over
               -- we only show the events from the current Shemsu Hor
               court.persistent.court_log = {}

               -- the plots resolved on Shemsu Hor, but can still be seen as resolved
               -- but now we need to clear any unseen notifications, because you can't see them, any more
               local human_factions = cm:get_human_factions()
               for i = 1, #human_factions do
                    local faction_key = human_factions[i]
                    local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
                    if faction_table then
                         faction_table.unread_log_against_plots_count = 0
                         faction_table.unread_log_against_plots_by_turn = {}
                         faction_table.unread_log_other_plots_count = 0
                         faction_table.unread_log_other_plots_by_turn = {}
                    end
               end
          end,

          -- if Shemsu Hor is inactive we need to clear only logged items which are too old
          remove_old_log_items_and_notifications = function()
               local current_turn = cm:model():turn_number()
               local shown_log_turns = court.ui.config.log_items_slots
               local oldest_log_start_turn = current_turn - shown_log_turns
               local turn_str = tostring(oldest_log_start_turn)
               court.persistent.court_log[turn_str] = nil

               -- we must reduce the total number of notifications with the number of notifications for the oldest turn
               -- thus if the player was targeted by a plot, but never opened the court to see it, the UI notification must be removed as soon as the plot is resolved and gone
               local human_factions = cm:get_human_factions()
               for i = 1, #human_factions do
                    local faction_key = human_factions[i]
                    local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
                    if faction_table then
                         if faction_table.unread_log_against_plots_by_turn
                             and is_number(faction_table.unread_log_against_plots_by_turn[turn_str])
                         then
                              faction_table.unread_log_against_plots_count = faction_table
                              .unread_log_against_plots_count - faction_table.unread_log_against_plots_by_turn[turn_str]
                              faction_table.unread_log_against_plots_by_turn[turn_str] = nil
                         end

                         if faction_table.unread_log_other_plots_by_turn
                             and is_number(faction_table.unread_log_other_plots_by_turn[turn_str])
                         then
                              faction_table.unread_log_other_plots_count = faction_table.unread_log_other_plots_count -
                              faction_table.unread_log_other_plots_by_turn[turn_str]
                              faction_table.unread_log_other_plots_by_turn[turn_str] = nil
                         end
                    end
               end
          end,

          check_court_integrity = function(faction_court)
               if not is_table(faction_court.positions) then
                    court.output("ERROR: For some reason `court.positions` is not a table @ `check_court_integrity`")
                    return
               end

               -- for this save migration we need turn_number so we can set the resolve turn
               if faction_court.persistent.plots_persistent_data then
                    -- save migration from when plots all resolved on Shemsu Hor
                    -- they may still resolve on Shemsu Hor, but now the data structure is different and we must sort them by resolve turn
                    local resolve_turn = cm:model():turn_number()
                    if shemsu_hor.is_active then
                         -- if Shemsu Hor is active, the resolve turn is the next Shemsu Hor
                         resolve_turn = resolve_turn + shemsu_hor:get_turns_to_shemsu_hor()
                    else
                         -- if Shemsu Hor is not active, the resolve turn depends on the duration of the plot
                         -- this should not normally happen, legacy saves with plots should have Shemsu Hor active
                         resolve_turn = resolve_turn + 1
                    end
                    faction_court.persistent.plots_persistent_data_by_resolve_turn[resolve_turn] = faction_court
                    .persistent.plots_persistent_data
                    faction_court.persistent.plots_persistent_data = nil
               end

               court.util_functions.check_position_integrity(faction_court)

               -- setting up the holder of the ruling court position (pharaoh/high king/ wanax / king of the universe)
               -- it is controlled from outside the court
               local ruling_faction_key = faction_court:ruling_faction()

               local is_in_legitimacy_war = court.util_functions.is_in_legitimacy_war(faction_court)
               local ruling_faction_obj = ruling_faction_key and cm:get_faction(ruling_faction_key)
               if ruling_faction_obj and (not ruling_faction_obj:is_null_interface()) then
                    local ruling_position_str = faction_court.config.ruler_position
                    local ruling_position_obj = court.util_functions.get_court_position(faction_court,
                         ruling_position_str)
                    local current_holder_faction = ruling_position_obj.persistent.current_holder_faction

                    if current_holder_faction and current_holder_faction ~= ruling_faction_key and (not is_in_legitimacy_war) then
                         local ruler_character_obj = ruling_faction_obj:faction_leader()
                         if current_holder_faction and current_holder_faction ~= "" then
                              court.util_functions.clear_court_position_for_faction(current_holder_faction)
                         end
                         local result = court.position_functions.give_position_internal(faction_court,
                              ruler_character_obj, ruling_position_str,
                              true, -- suppress_eligibility_checks
                              true -- skip_payment
                         )
                         if result then
                              court.output("Setting " ..
                              ruling_position_str .. " to ruler position in court " .. faction_court.court_name)
                         else
                              court.output(
                              "Could not set " ..
                              ruling_position_str .. " to ruler position in court " .. faction_court.court_name, 100)
                         end

                         court.util_functions.unlock_legitimacy(faction_court, ruling_faction_key)
                    end
               end

               court.util_functions.check_plot_integrity(faction_court)
          end,

          check_position_integrity = function(faction_court)
               for _, position_obj in ipairs(faction_court.positions) do
                    -- skipping if the position is empty. There's nothing to fix up here if there isn't a current holder faction
                    if position_obj and position_obj.persistent.current_holder_faction and position_obj.persistent.current_holder_faction ~= "" then
                         local faction_key = position_obj.persistent.current_holder_faction
                         local holder_faction = cm:get_faction(faction_key)
                         -- can be different from faction_court due to old bugs, and needs to be fixed
                         local actual_faction_court = court.util_functions.get_faction_court_for_faction(faction_key)

                         local position_str = position_obj.name

                         if not court.util_functions.is_court_legitimacy_unlocked(faction_court, faction_key) then
                              court.util_functions.unlock_legitimacy(faction_court, faction_key, true)
                         end

                         local court_specific_config = court.util_functions.get_position_config_from_court(faction_court,
                              position_obj)
                         if court_specific_config and court_specific_config.initial_holder == faction_key then
                              -- the initial holders of a position are exempt from the court check
                              -- because they may not have unlocked the court feature yet, so are considered not to have a court
                              -- but must not be kicked out of it before they unlock it
                              -- there is no point in adding this exception only if they have not yet unlocked the court - if they are initial holders of court positions they should already be in the court and can't change it
                              actual_faction_court = faction_court
                         elseif position_str == faction_court.config.ruler_position then
                              -- the court rulers are also exempt from the court check
                              -- also because they may not have unlocked the court feature yet, so are considered not to have a court
                              -- there is no point in adding this exception only if they have not yet unlocked the court - if they are rulers of the court they should already be in the court and can't change it
                              actual_faction_court = faction_court
                         else
                              -- if the initial holder was a character from that faction, they are considered members as well
                              local character_obj = cm:get_character(court_specific_config.initial_holder)
                              if character_obj
                                  and (not character_obj:is_null_interface())
                                  and character_obj:faction():name() == faction_key
                              then
                                   actual_faction_court = faction_court
                              end
                         end
                         local holder_character = cm:get_character(position_obj.persistent.current_holder)

                         if (not holder_faction)
                             or holder_faction:is_null_interface()
                             or holder_faction:is_dead()
                             or holder_faction:is_rebel()
                             or (not holder_character)
                             or holder_character:is_null_interface()
                             or (not holder_character:family_member():is_alive())
                             or actual_faction_court ~= faction_court
                             or (not court.util_functions.is_faction_accepted_in_court(faction_court, faction_key))
                         then
                              local error_msg = "ERROR: in court '" ..
                              faction_court.court_name ..
                              "' removing '" ..
                              tostring(position_obj.persistent.current_holder) ..
                              "' from the position of '" .. position_str .. "'"
                              script_error(error_msg)
                              court.output(error_msg, 100)
                              court.position_functions.remove_character_from_position(faction_court, position_str)
                         end
                    end
               end
          end,

          check_plot_integrity = function(faction_court)
               local plot_ids_to_remove = {}
               for plot_resolve_turn, plots_by_resolve_turn in dpairs(faction_court.persistent.plots_persistent_data_by_resolve_turn) do
                    for plot_key, plots_of_type in dpairs(plots_by_resolve_turn) do
                         for _, plot_persistent_data in ipairs(plots_of_type) do
                              local plotter_faction_key = plot_persistent_data.plotting_faction
                              local faction_obj = cm:get_faction(plotter_faction_key)
                              if faction_obj:is_dead() then
                                   table.insert(plot_ids_to_remove, plot_persistent_data.plot_id)
                              end
                         end
                    end
               end

               for _, plot_id in ipairs(plot_ids_to_remove) do
                    court.plot_functions:remove_plot(faction_court.court_name, plot_id)
               end
          end,

          gain_resources_from_region = function(faction_key, region_object, multiplier)
               for _, resource_key in ipairs(court.resource_keys) do
                    local income_resource = region_object:pooled_resource_income(resource_key)
                    local multiplied_resource = income_resource * multiplier
                    if multiplied_resource then
                         cm:faction_add_pooled_resource(faction_key, resource_key, court.config.court_resource_factor,
                              multiplied_resource)
                    end
               end
          end,

          get_faction_config = function(faction_key)
               local faction_config = court.factions_config[faction_key]

               if faction_config then
                    return faction_config
               end

               local new_faction_config = table_deep_copy(court.factions_config.default)
               court.factions_config[faction_key] = new_faction_config
               return new_faction_config
          end,

          -- intended to get all factions across egyptian and hittite sacred lands
          -- will get additional filters, e.g. being subject to the court leader
          get_factions_in_regions = function(region_list)
               local faction_list = {}
               for _, region_key in ipairs(region_list) do
                    local region_obj = cm:get_region(region_key)
                    if region_obj then
                         local faction_obj = region_obj:owning_faction()
                         if faction_obj then
                              if not table_contains(faction_list, faction_obj) then
                                   table.insert(faction_list, faction_obj)
                              end
                         end
                    else
                         court.output("ERROR: sacred land region '" .. region_key .. "' not found!", 10)
                    end
               end
               return faction_list
          end,

          get_property = function(faction_key, property_key)
               if not faction_key then
                    return court.factions_config.default[property_key]
               end

               local faction_specific_table = court.util_functions.get_faction_config(faction_key)
               if faction_specific_table and faction_specific_table[property_key] then
                    return faction_specific_table[property_key]
               end

               return court.factions_config.default[property_key]
          end,

          get_position_config_from_court = function(court_obj, position_obj)
               local court_specific_config = court_obj.config.available_positions[position_obj.name]

               if not court_specific_config and position_obj.alt_name then
                    court_specific_config = court_obj.config.available_positions[position_obj.alt_name]
               end

               return court_specific_config
          end,

          message_append = function(message, addition)
               -- just in case someone misuses the function
               if (not message) or (not addition) then
                    return message
               end
               if message ~= "" then
                    message = message .. "\n"
               end
               message = message .. addition
               return message
          end,

          append_as_red_bullet_point = function(message, addition)
               local addition_bullet_point = string.format(court.ui.config.localization_keys.red_bullet_point, addition)
               message = court.util_functions.message_append(message, addition_bullet_point)
               return message
          end,

          get_court_action_purchase_cost_obj = function(faction_key, action_points_purchased)
               local can_purchase_actions = court.util_functions.get_property(faction_key, "can_purchase_court_actions")
               if not can_purchase_actions then
                    -- faction can not purchase court actions
                    return nil
               end
               local cost_obj = cm:create_new_custom_resource_cost()

               local max_court_actions_per_turn = court.util_functions.max_court_actions_for_faction(faction_key)
               local court_actions_used_this_turn = court.util_functions.get_court_actions_used_this_turn(faction_key)

               -- the cost increases with every purchased or otherwise obtained action
               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
               local extra_actions = faction_table.extra_actions_this_turn or 0

               for i = 1, action_points_purchased do
                    local cost_multiplier = extra_actions + i
                    -- this is the main way to set up costs
                    if court.config.purchase_court_action_cost.purchase_court_action_cost_record then
                         local added_cost_obj = cm:create_new_custom_resource_cost()
                         added_cost_obj:get_cost_from_record(court.config.purchase_court_action_cost
                         .purchase_court_action_cost_record)
                         added_cost_obj:multiply_by(cost_multiplier)
                         cost_obj:add(added_cost_obj)
                    elseif court.config.purchase_court_action_cost.action_test_cost then
                         -- this is meant for testing, only used if the main cost is removed or commented
                         for _, resource_info in ipairs(court.config.purchase_court_action_cost.action_test_cost) do
                              cost_obj:add_resource_cost(resource_info[1], court.config.court_resource_factor,
                                   cost_multiplier * resource_info[2])
                         end
                    end
               end
               return cost_obj
          end,

          add_court_action_purchase_cost = function(faction_key, cost_obj, action_points_purchased)
               local purchase_cost_obj = court.util_functions.get_court_action_purchase_cost_obj(faction_key,
                    action_points_purchased)
               if not purchase_cost_obj then
                    return
               end

               local resources = purchase_cost_obj:resources()
               for i = 1, #resources do
                    local resource = resources[i][1]
                    local new_price = resources[i][2]
                    if new_price > 0 then
                         script_error(
                         "court action prices should use negative resources, but cost has positive numbers!")
                    end
                    cost_obj:add_resource_cost(resource, court.config.court_resource_factor, new_price)
               end
          end,

          purchase_court_actions = function(faction_key, actions_count)
               if not actions_count then
                    actions_count = 1
               end
               local faction_obj = cm:get_faction(faction_key)

               local cost_obj = court.util_functions.get_court_action_purchase_cost_obj(faction_key, actions_count)
               if not cost_obj then
                    court.output("Error: faction '" ..
                    faction_key .. "' tried to purchase an action, but is not allowed to!")
                    return
               end

               local can_afford = faction_obj:can_afford_resource_cost_object(cost_obj)
               if not can_afford then
                    court.output("Error: faction '" ..
                    faction_key .. "' tried to purchase an action, but can't afford it!")
                    return
               end

               cm:faction_apply_resource_transaction(faction_obj, cost_obj)

               court.util_functions.add_court_extra_actions_for_faction(faction_key, actions_count)
          end,

          add_court_leader_extra_cost = function(cost_obj)
               if court.config.leader_extra_cost_record then
                    local leader_extra_cost = cm:create_new_custom_resource_cost()
                    leader_extra_cost:get_cost_from_record(court.config.leader_extra_cost_record)
                    cost_obj:add(leader_extra_cost)
               elseif court.config.test_leader_extra_cost_record then
                    -- this is meant for testing, only used if the main cost is removed or commented
                    for _, resource_info in ipairs(court.config.test_leader_extra_cost_record) do
                         cost_obj:add_resource_cost(resource_info[1], court.config.court_resource_factor,
                              resource_info[2])
                    end
               end
          end,

          clear_court_position_for_faction = function(faction_key, faction_court)
               if not faction_court then
                    faction_court = court.util_functions.get_faction_court_for_faction(faction_key)
               end

               if not faction_court then
                    return
               end

               for _, position_obj in ipairs(faction_court.positions) do
                    if position_obj and position_obj.persistent and
                        position_obj.persistent.current_holder_faction and
                        position_obj.persistent.current_holder_faction == faction_key
                    then
                         local position_str = position_obj.name
                         court.position_functions.remove_character_from_position(faction_court, position_str)
                    end
               end
          end,

          is_dilemma_active = function()
               -- we can not use CampaignUI.DoesEventTypeRequireResponse because put_off dilemmas do not require response
               -- we can not use CampaignUI.DoesEventTypeExist("faction_event_dilemmaevent_feed_target_dilemma_faction") because it returns true after the dilemma is resolved
               local has_pending_action = cm:model():has_pending_action()
               local has_queued_intervention = is_table(final_intervention_list) and #final_intervention_list > 0
               return has_pending_action or has_queued_intervention
          end,

          add_pending_dilemma = function(faction_key, db_dilemma_key, payload1, payload2, payload3, payload4)
               if not court.persistent.pending_dilemmas then
                    court.persistent.pending_dilemmas = {}
               end

               local pending_dilemma =
               {
                    faction_key = faction_key,
                    db_dilemma_key = db_dilemma_key,
                    payload1 = payload1,
                    payload2 = payload2,
                    payload3 = payload3,
                    payload4 = payload4,
               }
               table.insert(court.persistent.pending_dilemmas, pending_dilemma)
          end,

          remove_pending_dilemma = function(faction_key, db_dilemma_key)
               if not court.persistent.pending_dilemmas then
                    return
               end

               table_erase_if_first_only(
                    court.persistent.pending_dilemmas,
                    function(elem)
                         return elem.faction_key == faction_key and elem.db_dilemma_key == db_dilemma_key
                    end
               )
          end,

          -- turns the number to string wrapping it into the appropriate string as parameter, to add colors with tags, possibly +
          wrap_number_to_string = function(number)
               local localization_key = court.ui.config.localization_keys.number_wrapper_positive
               if number < 0 then
                    localization_key = court.ui.config.localization_keys.number_wrapper_negative
               end

               local wrapped_string, _ = get_localised_text_replacement_and_source_formatted(localization_key, number)
               return wrapped_string
          end,

          gain_regard_with_conspirators = function(faction_court, faction_key, regard_gained)
               local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
               local conspirators = faction_table.conspirators
               if not is_table(conspirators) then
                    return
               end

               for i = 1, #conspirators do
                    local position_key = conspirators[i]
                    local position_obj = court.util_functions.get_court_position(faction_court, position_key)
                    local diplomacy_multiplier = court.position_functions.get_diplomacy_regard_change_multiplier(
                    position_obj, faction_key)
                    local modified_regard = regard_gained * diplomacy_multiplier
                    court.position_functions.change_regard_towards_faction_by_name(faction_court, position_key,
                         faction_key, modified_regard)
               end
               faction_table.conspirators = nil
          end,

          -- @function kill_faction_leader
          --- @desc convenience method to kill the leader of the faction - does sanity checks and make the lookup string
          --- @p string faction_key - the key of the faction we want kill the leader of
          --- @p [opt=false] boolean should_kill_force - if we want the army destroyed as well
          --- @p [opt="ASSASSINATED"] string kill_reason - record from death_types for the kill reason
          --- @return bool - if we killed the character
          kill_faction_leader = function(faction_key, should_kill_force, kill_reason)
               local faction_obj = cm:get_faction(faction_key)
               if (not faction_obj)
                   or faction_obj:is_null_interface()
               then
                    return false
               end

               local leader_character = faction_obj:faction_leader()
               return court.util_functions.kill_character_and_force(leader_character, should_kill_force, kill_reason)
          end,

          -- @function kill_character_and_force
          --- @desc convenience method to kill a character - does sanity checks and builds the lookup string
          --- @p object character_obj - character script interface for the character we want killed
          --- @p [opt=false] boolean should_kill_force - if we want the army destroyed as well
          --- @p [opt="ASSASSINATED"] string kill_reason - record from death_types for the kill reason
          --- @return bool - if we killed the character
          kill_character_and_force = function(character_obj, should_kill_force, kill_reason)
               if (not character_obj)
                   or character_obj:is_null_interface()
                   or character_obj:is_wounded()
               then
                    return false
               end

               local family_member_cqi = character_obj:family_member():command_queue_index()
               local target_character_lookup = "family_member_cqi:" .. family_member_cqi
               should_kill_force = should_kill_force or false
               kill_reason = kill_reason or "ASSASSINATED"
               cm:kill_character_and_commanded_unit_with_dt(target_character_lookup, should_kill_force, kill_reason)
               return true
          end,

          is_court_legitimacy_unlocked = function(court_obj, faction_key)
               -- as far as the Court is concerned, these factions do not have their legitimacy unlocked, so can not interact in the court in any way, not even opening the UI
               if not court.util_functions.is_faction_accepted_in_court(court_obj, faction_key) then
                    return false
               end
               local result = legitimacy_choice:legitimacy_unlocked(court_obj.court_legitimacy(), faction_key)
               return result
          end,
     }, -- util_functions

     save_load_functions =
     {
          save_court = function(context)
               for _, court_obj in ipairs(court.all_courts) do
                    court.save_load_functions.save_specific_court(court_obj, context)
               end

               cm:save_named_value("Common_Court", court.persistent, context)
          end,

          save_specific_court = function(faction_court, context)
               local positions_name = faction_court.court_name .. "_positions"
               cm:save_named_value(positions_name, faction_court.positions, context)

               local persistent_name = faction_court.court_name .. "_persistent"
               cm:save_named_value(persistent_name, faction_court.persistent, context)
          end,

          load_court = function(context)
               for _, court_obj in ipairs(court.all_courts) do
                    court.save_load_functions.load_specific_court(court_obj, context)
               end

               court.persistent = cm:load_named_value("Common_Court", court.persistent, context)
               --save migration
               if not court.persistent.factions_data then
                    court.persistent.factions_data = {}
               end

               --save migration
               if not court.persistent.court_log then
                    court.persistent.court_log = {}
               end

               --save migration
               if not court.persistent.plot_last_id then
                    court.persistent.plot_last_id = 0
               end
          end,

          load_specific_court = function(faction_court, context)
               court.util_functions.fill_court_positions(faction_court, false)
               local positions_name = faction_court.court_name .. "_positions"
               local loaded_positions = cm:load_named_value(positions_name, faction_court.positions, context)
               if loaded_positions then
                    for _, loaded_position in ipairs(loaded_positions) do
                         local court_position = table_find(faction_court.positions,
                              function(e) return e.name == loaded_position.persistent.name end)
                         if court_position then
                              court_position.persistent = loaded_position.persistent
                         else
                              court.output(
                              "Warning: court '" ..
                              faction_court.court_name ..
                              "' could not find position '" .. loaded_position.persistent.name .. "'. possibly old save.",
                                   10)
                         end
                    end
               end

               local persistent_name = faction_court.court_name .. "_persistent"
               faction_court.persistent = cm:load_named_value(persistent_name, faction_court.persistent, context)

               faction_court.persistent.plots_persistent_data_by_resolve_turn = faction_court.persistent
               .plots_persistent_data_by_resolve_turn or {}
          end,
     }, -- save_load_functions
}

-- these are the courts deemed ready and implemented in the game
court.all_courts =
{
     court.egyptian_court,
     court.hittite_court,
     court.aegean_court,
     court.mesopotamian_court,
}

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------

cm:add_saving_game_callback(function(context) court.save_load_functions.save_court(context) end)
cm:add_loading_game_callback(function(context) court.save_load_functions.load_court(context) end)

--------------------------------------------------------------
----------------------- EVENT LISTENERS  ---------------------
--------------------------------------------------------------

-- court_FirstTick
-- called on first tick of new campaign only
cm:add_first_tick_callback_new(
     function(context)
          court.util_functions.new_game_init()
     end
)

-- called on each game load
cm:add_first_tick_callback(
     function(context)
          court.util_functions.first_tick_init()
     end
)

-- court_RoundStart
-- called at the start of every round
core:add_listener(
     "court_RoundStart",
     "RoundStart",
     true,
     function(context)
          court.util_functions.on_round_start()
     end,
     true
)

--Court_ShemsuHor_Arrived
core:add_listener(
     "Court_ShemsuHor_Arrived",
     "ShemsuHor_Arrived",
     true,
     function(context)
          court.shemsu_hor.on_arrived()
     end,
     true
)

--Court_ShemsuHor_About_to_Advance
core:add_listener(
     "Court_ShemsuHor_About_to_Advance",
     "ShemsuHor_About_to_Advance",
     true,
     function(context)
          court.shemsu_hor.on_about_to_advance()
     end,
     true
)

-- Court_FactionDestroyed
core:add_listener(
     "Court_FactionDestroyed",
     "FactionDestroyed",
     true,
     function(context)
          local faction_key = context:faction():name()
          local faction_court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
          if not faction_court_obj then
               return
          end


          court.util_functions.clear_court_position_for_faction(faction_key, faction_court_obj)
          local owned_plots = court.plot_functions:get_plots_owned_by_faction(faction_key)
          for _, plot_persistent_data in ipairs(owned_plots) do
               court.plot_functions:remove_plot(faction_court_obj.court_name, plot_persistent_data.plot_id)
          end
     end,
     true
)

-- Court_FactionCharacterDiedOrWounded
core:add_listener(
     "Court_FactionCharacterDiedOrWounded",
     "FactionCharacterDiedOrWounded",
     true,
     function(context)
          local killed_character_family_cqi = context:family_member():command_queue_index()
          local killed_character = context:family_member():character()
          if killed_character:is_null_interface() or not killed_character:character_type("general") or killed_character:is_wounded() then
               return
          end

          local killed_character_faction_name = killed_character:faction():name()
          if killed_character_faction_name == "rebels" then
               return
          end

          local faction_court = court.util_functions.get_faction_court_for_faction(killed_character_faction_name)
          if not faction_court then
               return
          end

          for _, position_obj in ipairs(faction_court.positions) do
               if position_obj
                   and position_obj.persistent.current_holder
               then
                    local holder_character = cm:get_character(position_obj.persistent.current_holder)
                    if (not holder_character)
                        or (holder_character:is_null_interface())
                    then
                         script_error("ERROR: position '" ..
                         position_obj.name .. "' in court '" .. faction_court.court_name .. "' has an invalid holder!")
                         court.position_functions.remove_character_from_position(faction_court, position_obj.name)
                    else
                         local holder_character_family_cqi = holder_character:family_member():command_queue_index()
                         if holder_character_family_cqi == killed_character_family_cqi then
                              local position_str = position_obj.name
                              court.position_functions.remove_character_from_position(faction_court, position_str)
                         end
                    end
               end
          end
     end,
     true
)

-- Court_ScriptEventRulerChanged
core:add_listener(
     "Court_ScriptEventRulerChanged",
     "ScriptEventRulerChanged",
     true,
     function(context)
          for _, court_obj in ipairs(court.all_courts) do
               local political_state = court_obj.political_states()
               if political_state == context.stored_table.political_states then
                    local ruler_position_key = court_obj.config.ruler_position

                    local court_position_obj = court.util_functions.get_court_position(court_obj, ruler_position_key)
                    -- court_position_obj.persistent.current_holder might be different from context.stored_table.old_ruler_faction_key
                    -- because the old ruler might have died and we vacated the position in Court_FactionCharacterDiedOrWounded
                    if court_position_obj.persistent.current_holder then
                         -- we clear the previous ruler from all positions
                         court.util_functions.clear_court_position_for_faction(
                         court_position_obj.persistent.current_holder, court_obj)
                    end

                    local new_ruler_faction = cm:get_faction(context.stored_table.new_ruler_faction_key)
                    if new_ruler_faction and (not new_ruler_faction:is_null_interface()) then
                         local new_ruler_character = new_ruler_faction:faction_leader()
                         if new_ruler_character and not new_ruler_character:is_null_interface() then
                              court.position_functions.give_position_internal(court_obj, new_ruler_character,
                                   ruler_position_key,
                                   true, -- suppress_eligibility_checks
                                   true -- skip_payment
                              )
                         end
                    end
               end
          end
     end,
     true
)

-- Court_CharacterBecomesFactionLeader
core:add_listener(
     "Court_CharacterBecomesFactionLeader",
     "CharacterBecomesFactionLeader",
     true,
     function(context)
          local character_obj = context:character()
          if not character_obj then
               -- should never happen, but better safe than crashed
               return
          end
          local faction_obj = character_obj:faction()
          local faction_name = faction_obj:name()

          local faction_court = court.util_functions.get_faction_court_for_faction(faction_name)
          if not faction_court then
               return
          end

          local current_ruling_faction_key = faction_court:ruling_faction()
          if current_ruling_faction_key ~= faction_name then
               return
          end

          court.position_functions.give_position_internal(faction_court, character_obj,
               faction_court.config.ruler_position,
               true, -- suppress_eligibility_checks
               true -- skip_payment
          )
     end,
     true
)

--Court_ScriptEventLegitimacyWarEnded
core:add_listener(
     "Court_ScriptEventLegitimacyWarEnded",
     "ScriptEventLegitimacyWarEnded",
     true,
     function(context)
          local previous_ruling_faction_key = context.stored_table.previous_ruling_faction_key
          local new_ruling_faction_key = context.stored_table.new_ruling_faction_key
          local str_message = "ScriptEventLegitimacyWarEnded event recieved"
          str_message = str_message .. "\nOld ruler: '" .. tostring(previous_ruling_faction_key) .. "';"
          str_message = str_message .. "\nNew ruler: '" .. tostring(new_ruling_faction_key) .. "';"
          -- this is not an error, but is unusual enough that it should not spam
          court.output(str_message, 100)

          local faction_court = court.util_functions.get_faction_court_for_faction(new_ruling_faction_key)
          local need_to_update_positions = previous_ruling_faction_key ~= new_ruling_faction_key

          if need_to_update_positions then
               if previous_ruling_faction_key then
                    court.util_functions.clear_court_position_for_faction(previous_ruling_faction_key, faction_court)
               end
               if new_ruling_faction_key then
                    court.util_functions.clear_court_position_for_faction(new_ruling_faction_key, faction_court)
               end
          end

          if faction_court then
               -- there is a rare case when the ruler position is held by a different faction than the new ruler (even if it's the same as the current ruler)
               -- I suppose this is from old code that put the save file in an invalid state that it can't easily go out of
               -- in any case, we should fix this
               local ruling_position_str = faction_court.config.ruler_position
               local position_obj = court.util_functions.get_court_position(faction_court, ruling_position_str)
               if position_obj.persistent.current_holder_faction
                   and position_obj.persistent.current_holder_faction ~= new_ruling_faction_key
               then
                    court.util_functions.clear_court_position_for_faction(position_obj.persistent.current_holder_faction)
               end
          end

          if not new_ruling_faction_key then
               court.output("Warning: there is no new court leader after a legitimacy war has ended!", 100)
               return
          end

          if not faction_court then
               court.output(
               "Error:faction '" .. new_ruling_faction_key .. "' is the new court leader but has no court!!", 100)
               return
          end

          if need_to_update_positions then
               court.position_functions.set_court_ruling_position_faction_after_legitimacy_war(faction_court)

               if new_ruling_faction_key then
                    local new_ruling_faction_obj = cm:get_faction(new_ruling_faction_key)
                    local leader_character = new_ruling_faction_obj:faction_leader()
                    local pschent_crown = leader_character:get_ancillary(court.config.pschent_crown_ancillary_name)
                    if pschent_crown and (not pschent_crown:is_null_interface()) then
                         court.util_functions.set_pschent_crown_equipped(faction_court, true)
                    else
                         court.util_functions.set_pschent_crown_equipped(faction_court, false)
                    end

                    if is_function(faction_court.on_legitimacy_war_end) then
                         faction_court:on_legitimacy_war_end()
                    end
                    faction_court.persistent.last_legitimacy_war_winner = new_ruling_faction_key

                    local local_faction_key = cm:get_local_faction_name(true)
                    local local_faction_court = court.util_functions.get_faction_court_for_faction(local_faction_key)
                    if local_faction_court and local_faction_court == faction_court then
                         court.ui:update_court_button_visibility()
                    end
               end
          end
     end,
     true
)

--Court_CharacterAncillaryGained
core:add_listener(
     "Court_CharacterAncillaryGained",
     "CharacterAncillaryGained",
     true,
     function(context)
          local faction = context:character():faction()
          local faction_key = faction:name()
          local faction_court = court.util_functions.get_faction_court_for_faction(faction_key)
          if not faction_court then
               return
          end
          local ancillary_key = context:ancillary()
          if ancillary_key == court.config.pschent_crown_ancillary_name then
               court.util_functions.set_pschent_crown_equipped(faction_court, true)
          end
     end,
     true
)

--Court_CharacterAncillaryLost
core:add_listener(
     "Court_CharacterAncillaryLost",
     "CharacterAncillaryLost",
     true,
     function(context)
          local faction = context:character():faction()
          local faction_key = faction:name()
          local faction_court = court.util_functions.get_faction_court_for_faction(faction_key)
          if not faction_court then
               return
          end
          local ancillary_key = context:ancillary()
          if ancillary_key == court.config.pschent_crown_ancillary_name then
               court.util_functions.set_pschent_crown_equipped(faction_court, false)
          end
     end,
     true
)

--court_DilemmaChoiceMadeEvent
core:add_listener(
     "court_DilemmaChoiceMadeEvent",
     "DilemmaChoiceMadeEvent",
     true,
     function(context)
          local db_dilemma_key = context:dilemma()
          local faction_key = context:faction():name()
          court.util_functions.remove_pending_dilemma(faction_key, db_dilemma_key)
     end,
     true
)

--Court_faction_feature_unlocked
core:add_listener(
     "Court_faction_feature_unlocked",
     "faction_feature_unlocked",
     function(context)
          return context.stored_table and context.stored_table.feature_unlocked == feature_ids_config.court
     end,
     function(context)
          local faction_key = context.stored_table.faction_key
          -- we just unlocked the feature, we need to clear the cashe, we may belong to a court now
          court.factions_court_cache[faction_key] = nil
          local court_obj = court.util_functions.get_faction_court_for_faction(faction_key)
          if not court_obj then
               return
          end

          local faction_table = court.util_functions.get_faction_persistent_data(faction_key)
          if not faction_table then
               return
          end

          if faction_table.owned_positions then
               for _, owned_position in ipairs(faction_table.owned_positions) do
                    local court_position_obj = court.util_functions.get_court_position(court_obj, owned_position)
                    court.position_functions.give_position_mercenary_units(court_obj, court_position_obj)
                    local position_character_obj = cm:get_character(court_position_obj.persistent.current_holder)
                    court.position_functions.give_position_bonuses(court_obj, position_character_obj, court_position_obj)
               end
          end
     end,
     true
)

-- Court_CharacterFactionChange
core:add_listener(
     "Court_CharacterFactionChange",
     "CharacterFactionChange",
     true, -- Conditional trigger
     -- Callback
     function(context)
          local old_faction = context:old_faction()
          if not old_faction then
               return
          end

          local old_faction_key = old_faction:name()
          local court_obj = court.util_functions.get_faction_court_for_faction(old_faction_key)
          if not court_obj then
               return
          end

          local character_obj = context:character()
          local character_cqi = character_obj:command_queue_index()

          for _, position_obj in ipairs(court_obj.positions) do
               if old_faction_key == position_obj.persistent.current_holder_faction then
                    local holder_character = cm:get_character(position_obj.persistent.current_holder)
                    if holder_character and (not holder_character:is_null_interface()) then
                         local holder_cqi = holder_character:command_queue_index()
                         if holder_cqi == character_cqi then
                              court.position_functions.remove_character_from_position(court_obj, position_obj.name)
                              return
                         end
                    end
               end
          end
     end,
     -- Persistency
     true
)
