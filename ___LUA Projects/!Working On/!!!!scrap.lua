-- TO-DO
-- update mod agent subtype and ancillary tables (mod support in general)
-- update event messages
-- update faction/subculture icons for event messages

-- NEEDS TESTING
-- was trigger_dilemma_with_targets fixed?
-- multiplayer support (up to 8 players, different subcultures, head-to-head, coop, simultaneous turns)

--mct variables
local enable_value = true
local scope_value = "player_ai"
local ai_delay_value = 50
local preferance1_value = "race"
local preferance2_value = "player"
local preferance3_value = "met"
local preferance4_value = "relation"
local preferance5_value = "major"
local preferance6_value = "disabled"
local tmb_restriction_value = false
local cst_restriction_value = false
local wef_restriction_value = false
--beta
local playable_faction_only_value = false
local include_seccessionists_value = false
local dilemmas_per_turn_value = 10
local dilemmas_per_turn_per_sc_value = 1
local dilemmas_per_turn_player_value = 1
local cross_race_value = "disable"
local refugee_types_value = "immortal"
local nakai_vassal_value = "do_nothing"
local savage_restriction_value = false
local chs_restriction_value = "no_restrictions"

local faction_event_picture = {
     ["wh_main_emp_empire"] = 591,
     ["wh_main_emp_middenland"] = 591,
     ["wh_main_vmp_vampire_counts"] = 594,
     ["wh_main_vmp_schwartzhafen"] = 770,
     ["wh2_dlc11_vmp_the_barrow_legion"] = 594,
     ["wh_main_dwf_dwarfs"] = 592,
     ["wh_main_dwf_karak_izor"] = 592,
     ["wh_main_dwf_karak_kadrin"] = 592,
     ["wh_main_grn_greenskins"] = 593,
     ["wh_main_grn_crooked_moon"] = 593,
     ["wh_main_grn_orcs_of_the_bloody_hand"] = 593,
     ["wh2_dlc09_tmb_khemri"] = 606,
     ["wh2_dlc09_tmb_exiles_of_nehek"] = 606,
     ["wh2_dlc09_tmb_lybaras"] = 606,
     ["wh2_dlc09_tmb_followers_of_nagash"] = 606,
     ["wh_main_brt_bretonnia"] = 751,
     ["wh_main_brt_bordeleaux"] = 752,
     ["wh_main_brt_carcassonne"] = 753,
     --["wh2_main_hef_avelorn"] = 780,
     ["wh2_main_hef_eataine"] = 771,
     ["wh2_main_hef_order_of_loremasters"] = 772,
     ["wh2_main_hef_nagarythe"] = 771,
     ["wh2_main_def_naggarond"] = 773,
     ["wh2_main_def_har_ganeth"] = 779,
     ["wh2_main_def_cult_of_pleasure"] = 774,
     ["wh2_main_lzd_hexoatl"] = 775,
     ["wh2_main_lzd_last_defenders"] = 776,
     ["wh2_dlc12_lzd_cult_of_sotek"] = 788,
     ["wh2_main_lzd_tlaqua"] = 788,
     ["wh2_main_skv_clan_mors"] = 777,
     ["wh2_dlc09_skv_clan_rictus"] = 778,
     ["wh2_main_skv_clan_pestilens"] = 778,
     ["wh2_main_skv_clan_skryre"] = 787,
     ["wh_dlc05_wef_argwylon"] = 605,
     ["wh_dlc05_wef_wood_elves"] = 605,
     ["wh_dlc08_nor_norsca"] = 800,
     ["wh_dlc08_nor_wintertooth"] = 800,
     ["wh2_dlc11_def_the_blessed_dread"] = 782,
     ["wh2_dlc11_cst_vampire_coast"] = 786,
     ["wh2_dlc11_cst_noctilus"] = 785,
     ["wh2_dlc11_cst_pirates_of_sartosa"] = 783,
     ["wh2_dlc11_cst_the_drowned"] = 784,
     ["wh2_dlc13_lzd_spirits_of_the_jungle"] = 775,
     ["wh2_dlc13_emp_the_huntmarshals_expedition"] = 591,
     ["wh2_dlc14_brt_chevaliers_de_lyonesse"] = 751,
     ["wh2_main_skv_clan_eshin"] = 778,
     ["wh2_main_def_hag_graef"] = 773,
     ["wh_main_chs_chaos"] = 595,

     --MIXU Part 1--
     ["wh_main_brt_artois"] = 751,
     ["wh_main_brt_bastonne"] = 751,
     ["wh_main_brt_lyonesse"] = 751,
     ["wh_main_brt_parravon"] = 751,
     ["wh_main_dwf_karak_azul"] = 592,
     ["wh_main_emp_wissenland"] = 591,
     ["wh_main_ksl_kislev"] = 591,
     ["wh_dlc05_wef_torgovann"] = 591,
     ["wh_main_emp_averland"] = 591,
     ["wh_main_emp_hochland"] = 591,
     ["wh_main_emp_marienburg"] = 591,
     ["wh_main_emp_nordland"] = 591,
     ["wh_main_emp_ostermark"] = 591,
     ["wh_main_emp_ostland"] = 591,
     ["wh_main_emp_stirland"] = 591,
     ["wh_main_emp_talabecland"] = 591,

     --MIXU Part 2--
     ["wh2_main_brt_knights_of_origo"] = 751,
     ["wh2_main_def_scourge_of_khaine"] = 773,
     ["wh_main_grn_red_fangs"] = 593,
     ["wh2_main_hef_saphery"] = 771,
     ["wh2_main_hef_chrace"] = 771,
     ["wh2_main_hef_caledor"] = 771,
     ["wh2_main_lzd_itza"] = 775,
     ["wh2_main_lzd_tlaxtlan"] = 775,
     ["wh_main_nor_skaeling"] = 800,
     ["wh2_dlc09_tmb_numas"] = 606,
     ["wh_dlc05_wef_wydrioth"] = 605,
}

--backup picture ids
local subculture_event_picture = {
     ["wh_dlc03_sc_bst_beastmen"] = 596,
     ["wh_dlc05_sc_wef_wood_elves"] = 605,
     ["wh_main_sc_brt_bretonnia"] = 751,
     ["wh_main_sc_chs_chaos"] = 595,
     ["wh_main_sc_dwf_dwarfs"] = 592,
     ["wh_main_sc_emp_empire"] = 591,
     ["wh_main_sc_grn_greenskins"] = 593,
     ["wh_main_sc_grn_savage_orcs"] = 593,
     ["wh_dlc08_sc_nor_norsca"] = 800,
     ["wh_main_sc_teb_teb"] = 591,
     ["mixer_teb_southern_realms"] = 591,
     ["wh_main_sc_vmp_vampire_counts"] = 594,
     ["wh2_dlc09_sc_tmb_tomb_kings"] = 606,
     ["wh2_dlc11_sc_cst_vampire_coast"] = 785,
     ["wh2_main_sc_def_dark_elves"] = 773,
     ["wh2_main_sc_hef_high_elves"] = 771,
     ["wh2_main_sc_lzd_lizardmen"] = 775,
     ["wh2_main_sc_skv_skaven"] = 778,
     ["wh3_main_sc_cth_cathay"] = 17,
     ["wh3_main_sc_dae_daemons"] = 10,
     ["wh3_main_sc_kho_khorne"] = 11,
     ["wh3_main_sc_ksl_kislev"] = 15,
     ["wh3_main_sc_nur_nurgle"] = 12,
     ["wh3_main_sc_ogr_ogre_kingdoms"] = 16,
     ["wh3_main_sc_sla_slaanesh"] = 13,
     ["wh3_main_sc_tze_tzeentch"] = 14,
     ["wh3_dlc23_sc_chd_chaos_dwarfs"] = 50,
}

local wh_agents = {
     { ["faction"] = "wh_main_emp_middenland",                    ["subtype"] = "wh_dlc03_emp_boris_todbringer",                  ["dlc"] = { "TW_WH1_BEASTMEN" } },
     { ["faction"] = "wh3_main_emp_cult_of_sigmar",               ["subtype"] = "wh_dlc04_emp_volkmar",                           ["dlc"] = { "TW_WH1_LORDS_AND_UNITS_1" } },
     { ["faction"] = "wh2_dlc13_emp_golden_order",                ["subtype"] = "wh_main_emp_balthasar_gelt",                     ["dlc"] = { "TW_WH1_BASE_GAME" } },
     { ["faction"] = "wh_main_emp_empire",                        ["subtype"] = "wh_main_emp_karl_franz",                         ["dlc"] = { "TW_WH1_BASE_GAME" } },
     { ["faction"] = "wh3_main_vmp_caravan_of_blue_roses",        ["subtype"] = "wh_dlc04_vmp_helman_ghorst",                     ["dlc"] = { "TW_WH1_LORDS_AND_UNITS_1" } },
     { ["faction"] = "wh_main_vmp_schwartzhafen",                 ["subtype"] = "wh_dlc04_vmp_vlad_con_carstein",                 ["dlc"] = { "TW_WH1_BASE_GAME" } },
     { ["faction"] = "wh_main_vmp_schwartzhafen",                 ["subtype"] = "wh_pro02_vmp_isabella_von_carstein",             ["dlc"] = { "TW_WH1_ISABELLA_FREE" } },
     { ["faction"] = "wh_main_vmp_schwartzhafen",                 ["subtype"] = "wh_pro02_vmp_isabella_von_carstein_hero",        ["dlc"] = { "TW_WH1_ISABELLA_FREE" } },
     { ["faction"] = "wh2_dlc11_vmp_the_barrow_legion",           ["subtype"] = "wh_main_vmp_heinrich_kemmler",                   ["dlc"] = { "TW_WH1_BASE_GAME" } },
     { ["faction"] = "wh_main_vmp_vampire_counts",                ["subtype"] = "wh_main_vmp_mannfred_von_carstein",              ["dlc"] = { "TW_WH1_BASE_GAME" } },
     { ["faction"] = "wh_main_vmp_mousillon",                     ["subtype"] = "wh_dlc05_vmp_red_duke",                          ["dlc"] = { "TW_WH1_WOOD_ELVES" } },
     { ["faction"] = "wh_main_dwf_dwarfs",                        ["subtype"] = "wh_main_dwf_thorgrim_grudgebearer",              ["dlc"] = { "TW_WH1_BASE_GAME" } },
     { ["faction"] = "wh_main_dwf_karak_kadrin",                  ["subtype"] = "wh_main_dwf_ungrim_ironfist",                    ["dlc"] = { "TW_WH1_BASE_GAME" } },
     { ["faction"] = "wh_main_dwf_karak_izor",                    ["subtype"] = "wh_dlc06_dwf_belegar",                           ["dlc"] = { "TW_WH1_LORDS_AND_UNITS_2" } },
     { ["faction"] = "wh3_main_dwf_the_ancestral_throng",         ["subtype"] = "wh_pro01_dwf_grombrindal",                       ["dlc"] = { "TW_WH1_GROMBRINDAL" } },
     { ["faction"] = "wh_main_grn_crooked_moon",                  ["subtype"] = "wh_dlc06_grn_skarsnik",                          ["dlc"] = { "TW_WH1_LORDS_AND_UNITS_2" } },
     { ["faction"] = "wh2_dlc15_grn_bonerattlaz",                 ["subtype"] = "wh_main_grn_azhag_the_slaughterer",              ["dlc"] = { "TW_WH1_BASE_GAME" } },
     { ["faction"] = "wh_main_grn_greenskins",                    ["subtype"] = "wh_main_grn_grimgor_ironhide",                   ["dlc"] = { "TW_WH1_BASE_GAME" } },
     { ["faction"] = "wh_main_grn_orcs_of_the_bloody_hand",       ["subtype"] = "wh_dlc06_grn_wurrzag_da_great_prophet",          ["dlc"] = { "TW_WH1_LORDS_AND_UNITS_2_FREE" } },
     { ["faction"] = "wh2_dlc09_tmb_followers_of_nagash",         ["subtype"] = "wh2_dlc09_tmb_arkhan",                           ["dlc"] = { "TW_WH2_TOMB_KINGS" } },
     { ["faction"] = "wh2_dlc09_tmb_lybaras",                     ["subtype"] = "wh2_dlc09_tmb_khalida",                          ["dlc"] = { "TW_WH2_TOMB_KINGS" } },
     { ["faction"] = "wh2_dlc09_tmb_exiles_of_nehek",             ["subtype"] = "wh2_dlc09_tmb_khatep",                           ["dlc"] = { "TW_WH2_TOMB_KINGS" } },
     { ["faction"] = "wh2_dlc09_tmb_khemri",                      ["subtype"] = "wh2_dlc09_tmb_settra",                           ["dlc"] = { "TW_WH2_TOMB_KINGS" } },
     { ["faction"] = "wh_main_brt_bretonnia",                     ["subtype"] = "wh_main_brt_louen_leoncouer",                    ["dlc"] = { "TW_WH1_BRETONNIA_FREE" } },
     { ["faction"] = "wh_main_brt_bordeleaux",                    ["subtype"] = "wh_dlc07_brt_alberic",                           ["dlc"] = { "TW_WH1_BRETONNIA_FREE" } },
     { ["faction"] = "wh_main_brt_carcassonne",                   ["subtype"] = "wh_dlc07_brt_fay_enchantress",                   ["dlc"] = { "TW_WH1_BRETONNIA_FREE" } },
     { ["faction"] = "wh2_main_hef_order_of_loremasters",         ["subtype"] = "wh2_main_hef_teclis",                            ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "wh2_main_hef_eataine",                      ["subtype"] = "wh2_main_hef_tyrion",                            ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "wh2_main_hef_eataine",                      ["subtype"] = "wh2_main_hef_prince_alastar",                    ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "wh2_main_hef_avelorn",                      ["subtype"] = "wh2_dlc10_hef_alarielle",                        ["dlc"] = { "TW_WH2_DLC10_QUEEN_CRONE" } },
     { ["faction"] = "wh2_main_hef_nagarythe",                    ["subtype"] = "wh2_dlc10_hef_alith_anar",                       ["dlc"] = { "TW_WH2_DLC10_ALITH_ANAR_FREE" } },
     { ["faction"] = "wh2_dlc11_def_the_blessed_dread",           ["subtype"] = "wh2_dlc11_def_lokhir",                           ["dlc"] = { "TW_WH2_DLC11_LOKHIR_FREE" } },
     { ["faction"] = "wh2_main_def_naggarond",                    ["subtype"] = "wh2_main_def_malekith",                          ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "wh2_main_def_cult_of_pleasure",             ["subtype"] = "wh2_main_def_morathi",                           ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "wh2_main_lzd_hexoatl",                      ["subtype"] = "wh2_main_lzd_lord_mazdamundi",                   ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "wh2_main_lzd_last_defenders",               ["subtype"] = "wh2_main_lzd_kroq_gar",                          ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "wh2_dlc12_lzd_cult_of_sotek",               ["subtype"] = "wh2_dlc12_lzd_tehenhauin",                       ["dlc"] = { "TW_WH2_DLC12_PROPHET" } },
     { ["faction"] = "wh2_main_lzd_tlaqua",                       ["subtype"] = "wh2_dlc12_lzd_tiktaqto",                         ["dlc"] = { "TW_WH2_DLC12_TIKTAQTO_FREE" } },
     { ["faction"] = "wh2_main_skv_clan_pestilens",               ["subtype"] = "wh2_main_skv_lord_skrolk",                       ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "wh2_dlc09_skv_clan_rictus",                 ["subtype"] = "wh2_dlc09_skv_tretch_craventail",                ["dlc"] = { "TW_WH2_TRETCH_FREE" } },
     { ["faction"] = "wh2_main_skv_clan_mors",                    ["subtype"] = "wh2_main_skv_queek_headtaker",                   ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "wh2_main_skv_clan_skryre",                  ["subtype"] = "wh2_dlc12_skv_ikit_claw",                        ["dlc"] = { "TW_WH2_DLC12_PROPHET" } },
     { ["faction"] = "wh_dlc05_wef_argwylon",                     ["subtype"] = "wh_dlc05_wef_durthu",                            ["dlc"] = { "TW_WH1_WOOD_ELVES" } },
     { ["faction"] = "wh_dlc05_wef_wood_elves",                   ["subtype"] = "wh_dlc05_wef_orion",                             ["dlc"] = { "TW_WH1_WOOD_ELVES" } },
     { ["faction"] = "wh_dlc08_nor_wintertooth",                  ["subtype"] = "wh_dlc08_nor_throgg",                            ["dlc"] = { "TW_WH1_NORSCA" } },
     { ["faction"] = "wh_dlc08_nor_norsca",                       ["subtype"] = "wh_dlc08_nor_wulfrik",                           ["dlc"] = { "TW_WH1_NORSCA" } },
     { ["faction"] = "wh_dlc08_nor_norsca",                       ["subtype"] = "wh_dlc08_nor_arzik",                             ["dlc"] = { "TW_WH1_NORSCA" } },
     { ["faction"] = "wh_dlc08_nor_norsca",                       ["subtype"] = "wh_dlc08_nor_kihar",                             ["dlc"] = { "TW_WH1_NORSCA" } },
     { ["faction"] = "wh_dlc08_nor_norsca",                       ["subtype"] = "wh3_main_ie_nor_burplesmirk_spewpit",            ["dlc"] = { "TW_WH1_NORSCA" } },
     { ["faction"] = "wh_dlc08_nor_norsca",                       ["subtype"] = "wh3_main_ie_nor_killgore_slaymaim",              ["dlc"] = { "TW_WH1_NORSCA" } },
     { ["faction"] = "wh2_main_def_har_ganeth",                   ["subtype"] = "wh2_dlc10_def_crone_hellebron",                  ["dlc"] = { "TW_WH2_DLC10_QUEEN_CRONE" } },
     { ["faction"] = "wh2_dlc11_cst_pirates_of_sartosa",          ["subtype"] = "wh2_dlc11_cst_aranessa",                         ["dlc"] = { "TW_WH2_DLC11_VAMPIRE_COAST" } },
     { ["faction"] = "wh2_dlc11_cst_the_drowned",                 ["subtype"] = "wh2_dlc11_cst_cylostra",                         ["dlc"] = { "TW_WH2_DLC11_VAMPIRE_COAST" } },
     { ["faction"] = "wh2_dlc11_cst_vampire_coast",               ["subtype"] = "wh2_dlc11_cst_harkon",                           ["dlc"] = { "TW_WH2_DLC11_VAMPIRE_COAST" } },
     { ["faction"] = "wh2_dlc11_cst_noctilus",                    ["subtype"] = "wh2_dlc11_cst_noctilus",                         ["dlc"] = { "TW_WH2_DLC11_VAMPIRE_COAST" } },
     { ["faction"] = "wh2_dlc11_cst_cylostra",                    ["subtype"] = "wh2_dlc11_cst_ghost_paladin",                    ["dlc"] = { "TW_WH2_DLC11_VAMPIRE_COAST" } },
     { ["faction"] = "wh2_dlc13_emp_the_huntmarshals_expedition", ["subtype"] = "wh2_dlc13_emp_cha_markus_wulfhart",              ["dlc"] = { "TW_WH2_DLC13_HUNTER" } },
     { ["faction"] = "wh2_dlc13_emp_the_huntmarshals_expedition", ["subtype"] = "wh2_dlc13_emp_hunter_jorek_grimm",               ["dlc"] = { "TW_WH2_DLC13_HUNTER" } },
     { ["faction"] = "wh2_dlc13_emp_the_huntmarshals_expedition", ["subtype"] = "wh2_dlc13_emp_hunter_rodrik_l_anguille",         ["dlc"] = { "TW_WH2_DLC13_HUNTER" } },
     { ["faction"] = "wh2_dlc13_emp_the_huntmarshals_expedition", ["subtype"] = "wh2_dlc13_emp_hunter_doctor_hertwig_van_hal",    ["dlc"] = { "TW_WH2_DLC13_HUNTER" } },
     { ["faction"] = "wh2_dlc13_emp_the_huntmarshals_expedition", ["subtype"] = "wh2_dlc13_emp_hunter_kalara_of_wydrioth",        ["dlc"] = { "TW_WH2_DLC13_HUNTER" } },
     { ["faction"] = "wh2_dlc13_lzd_spirits_of_the_jungle",       ["subtype"] = "wh2_dlc13_lzd_nakai",                            ["dlc"] = { "TW_WH2_DLC13_HUNTER" } },
     { ["faction"] = "wh2_main_lzd_itza",                         ["subtype"] = "wh2_dlc13_lzd_gor_rok",                          ["dlc"] = { "TW_WH2_DLC13_GOR_ROK_FREE" } },
     { ["faction"] = "wh_dlc03_bst_beastmen",                     ["subtype"] = "wh_dlc03_bst_khazrak",                           ["dlc"] = { "TW_WH1_BEASTMEN" } },
     { ["faction"] = "wh2_dlc17_bst_malagor",                     ["subtype"] = "wh_dlc03_bst_malagor",                           ["dlc"] = { "TW_WH1_BEASTMEN" } },
     { ["faction"] = "wh_dlc05_bst_morghur_herd",                 ["subtype"] = "wh_dlc05_bst_morghur",                           ["dlc"] = { "TW_WH1_BEASTMEN" } },
     { ["faction"] = "wh2_dlc14_brt_chevaliers_de_lyonesse",      ["subtype"] = "wh2_dlc14_brt_repanse",                          ["dlc"] = { "TW_WH2_DLC14_REPANSE_FREE" } },
     { ["faction"] = "wh2_dlc14_brt_chevaliers_de_lyonesse",      ["subtype"] = "wh2_dlc14_brt_henri_le_massif",                  ["dlc"] = { "TW_WH2_DLC14_REPANSE_FREE" } },
     { ["faction"] = "wh2_main_skv_clan_eshin",                   ["subtype"] = "wh2_dlc14_skv_deathmaster_snikch",               ["dlc"] = { "TW_WH2_DLC14_SHADOW" } },
     { ["faction"] = "wh2_main_def_hag_graef",                    ["subtype"] = "wh2_dlc14_def_malus_darkblade",                  ["dlc"] = { "TW_WH2_DLC14_SHADOW" } },
     { ["faction"] = "wh2_dlc15_grn_broken_axe",                  ["subtype"] = "wh2_dlc15_grn_grom_the_paunch",                  ["dlc"] = { "TW_WH2_DLC15_WARDEN" } },
     { ["faction"] = "wh2_main_hef_yvresse",                      ["subtype"] = "wh2_dlc15_hef_eltharion",                        ["dlc"] = { "TW_WH2_DLC15_WARDEN" } },
     { ["faction"] = "wh2_dlc15_hef_imrik",                       ["subtype"] = "wh2_dlc15_hef_imrik",                            ["dlc"] = { "TW_WH2_DLC15_IMRIK_FREE" } },
     { ["faction"] = "wh2_main_skv_clan_moulder",                 ["subtype"] = "wh2_dlc16_skv_throt_the_unclean",                ["dlc"] = { "TW_WH2_DLC16_TWILIGHT" } },
     { ["faction"] = "wh2_main_skv_clan_moulder",                 ["subtype"] = "wh2_dlc16_skv_ghoritch",                         ["dlc"] = { "TW_WH2_DLC16_TWILIGHT" } },
     { ["faction"] = "wh2_dlc16_wef_drycha",                      ["subtype"] = "wh2_dlc16_wef_drycha",                           ["dlc"] = { "TW_WH1_WOOD_ELVES", "TW_WH2_DLC16_TWILIGHT" } },
     { ["faction"] = "wh2_dlc16_wef_drycha",                      ["subtype"] = "wh2_dlc16_wef_coeddil",                          ["dlc"] = { "TW_WH1_WOOD_ELVES", "TW_WH2_DLC16_TWILIGHT" } },
     { ["faction"] = "wh2_dlc16_wef_sisters_of_twilight",         ["subtype"] = "wh2_dlc16_wef_ariel",                            ["dlc"] = { "TW_WH2_DLC16_TWILIGHT" } },
     { ["faction"] = "wh2_dlc16_wef_sisters_of_twilight",         ["subtype"] = "wh2_dlc16_wef_sisters_of_twilight",              ["dlc"] = { "TW_WH2_DLC16_TWILIGHT" } },
     { ["faction"] = "wh2_twa03_def_rakarth",                     ["subtype"] = "wh2_twa03_def_rakarth",                          ["dlc"] = { "TW_WH2_TWA_03_RAKARTH" } },
     { ["faction"] = "wh2_dlc17_bst_taurox",                      ["subtype"] = "wh2_dlc17_bst_taurox",                           ["dlc"] = { "TW_WH2_DLC17_SILENCE" } },
     { ["faction"] = "wh2_dlc17_lzd_oxyotl",                      ["subtype"] = "wh2_dlc17_lzd_oxyotl",                           ["dlc"] = { "TW_WH2_DLC17_SILENCE" } },
     { ["faction"] = "wh2_dlc17_dwf_thorek_ironbrow",             ["subtype"] = "wh2_dlc17_dwf_thorek",                           ["dlc"] = { "TW_WH2_DLC17_THOREK_FREE" } },
     { ["faction"] = "wh3_main_cth_the_northern_provinces",       ["subtype"] = "wh3_main_cth_miao_ying",                         ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh3_main_cth_the_western_provinces",        ["subtype"] = "wh3_main_cth_zhao_ming",                         ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh3_main_dae_daemon_prince",                ["subtype"] = "wh3_main_dae_daemon_prince",                     ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh3_main_kho_exiles_of_khorne",             ["subtype"] = "wh3_main_kho_skarbrand",                         ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh3_main_ksl_the_great_orthodoxy",          ["subtype"] = "wh3_main_ksl_kostaltyn",                         ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh3_main_ksl_the_ice_court",                ["subtype"] = "wh3_main_ksl_katarin",                           ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh3_main_ksl_ursun_revivalists",            ["subtype"] = "wh3_main_ksl_boris",                             ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh3_main_nur_poxmakers_of_nurgle",          ["subtype"] = "wh3_main_nur_kugath",                            ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh3_main_ogr_disciples_of_the_maw",         ["subtype"] = "wh3_main_ogr_skrag_the_slaughterer",             ["dlc"] = { "TW_WH3_OGRE_KINGDOMS" } },
     { ["faction"] = "wh3_main_ogr_goldtooth",                    ["subtype"] = "wh3_main_ogr_greasus_goldtooth",                 ["dlc"] = { "TW_WH3_OGRE_KINGDOMS" } },
     { ["faction"] = "wh3_main_sla_seducers_of_slaanesh",         ["subtype"] = "wh3_main_sla_nkari",                             ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh3_main_tze_oracles_of_tzeentch",          ["subtype"] = "wh3_main_tze_kairos",                            ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh3_dlc20_chs_azazel",                      ["subtype"] = "wh3_dlc20_sla_azazel",                           ["dlc"] = { "TW_WH3_DLC20_CHAMPIONS" } },
     { ["faction"] = "wh3_dlc20_chs_festus",                      ["subtype"] = "wh3_dlc20_nur_festus",                           ["dlc"] = { "TW_WH3_DLC20_CHAMPIONS" } },
     { ["faction"] = "wh3_dlc20_chs_valkia",                      ["subtype"] = "wh3_dlc20_kho_valkia",                           ["dlc"] = { "TW_WH3_DLC20_CHAMPIONS" } },
     { ["faction"] = "wh3_dlc20_chs_vilitch",                     ["subtype"] = "wh3_dlc20_tze_vilitch",                          ["dlc"] = { "TW_WH3_DLC20_CHAMPIONS" } },
     { ["faction"] = "wh_main_chs_chaos",                         ["subtype"] = "wh_main_chs_archaon",                            ["dlc"] = { "TW_WH1_CHAOS" } },
     { ["faction"] = "wh3_dlc20_chs_kholek",                      ["subtype"] = "wh_dlc01_chs_kholek_suneater",                   ["dlc"] = { "TW_WH1_CHAOS" } },
     { ["faction"] = "wh3_dlc20_chs_sigvald",                     ["subtype"] = "wh_dlc01_chs_prince_sigvald",                    ["dlc"] = { "TW_WH1_CHAOS" } },
     { ["faction"] = "wh3_main_chs_shadow_legion",                ["subtype"] = "wh3_main_dae_belakor",                           ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "wh2_main_lzd_itza",                         ["subtype"] = "wh2_dlc12_lzd_lord_kroak",                       ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "wh_main_dwf_karak_izor",                    ["subtype"] = "wh_dlc06_dwf_thane_ghost_1",                     ["dlc"] = { "TW_WH1_LORDS_AND_UNITS_2" } },
     { ["faction"] = "wh_main_dwf_karak_izor",                    ["subtype"] = "wh_dlc06_dwf_thane_ghost_2",                     ["dlc"] = { "TW_WH1_LORDS_AND_UNITS_2" } },
     { ["faction"] = "wh_main_dwf_karak_izor",                    ["subtype"] = "wh_dlc06_dwf_runesmith_ghost",                   ["dlc"] = { "TW_WH1_LORDS_AND_UNITS_2" } },
     { ["faction"] = "wh_main_dwf_karak_izor",                    ["subtype"] = "wh_dlc06_dwf_master_engineer_ghost",             ["dlc"] = { "TW_WH1_LORDS_AND_UNITS_2" } },
     { ["faction"] = "wh_main_vmp_vampire_counts",                ["subtype"] = "wh2_dlc17_vmp_kevon_lloydstein",                 ["dlc"] = { "TW_WH2_BASE_GAME" } },
     { ["faction"] = "",                                          ["subtype"] = "wh2_pro08_neu_gotrek",                           ["dlc"] = { "TW_WH2_GOTREK_FELIX" } },
     { ["faction"] = "",                                          ["subtype"] = "wh2_pro08_neu_felix",                            ["dlc"] = { "TW_WH2_GOTREK_FELIX" } },
     { ["faction"] = "wh3_dlc23_chd_zhatan",                      ["subtype"] = "wh3_dlc23_chd_zhatan",                           ["dlc"] = { "TW_WH3_CHAOS_DWARFS" } },
     { ["faction"] = "wh3_dlc23_chd_legion_of_azgorh",            ["subtype"] = "wh3_dlc23_chd_drazhoath",                        ["dlc"] = { "TW_WH3_CHAOS_DWARFS" } },
     { ["faction"] = "wh3_dlc23_chd_astragoth",                   ["subtype"] = "wh3_dlc23_chd_astragoth",                        ["dlc"] = { "TW_WH3_CHAOS_DWARFS" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc23_neu_ulrika",                           ["dlc"] = { "TW_WH3_ULRIKA_FREE" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc23_chd_gorduz_backstabber",               ["dlc"] = { "TW_WH3_CHAOS_DWARFS" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_pro11_chs_cha_harald_hammerstorm",           ["dlc"] = { "TW_WH3_PRO11_HARALD_HAMMERSTORM" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc24_ksl_mother_ostankya",                  ["dlc"] = { "TW_WH3_SHADOWS_OF_CHANGE" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc24_tze_the_changeling",                   ["dlc"] = { "TW_WH3_SHADOWS_OF_CHANGE" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc24_cth_yuan_bo",                          ["dlc"] = { "TW_WH3_SHADOWS_OF_CHANGE" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc24_tze_aekold_helbrass",                  ["dlc"] = { "TW_WH3_AEKOLD_FREE" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc24_cth_saytang_the_watcher",              ["dlc"] = { "TW_WH3_SHADOWS_OF_CHANGE" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc24_ksl_the_golden_knight",                ["dlc"] = { "TW_WH3_SHADOWS_OF_CHANGE" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_dwf_garagrim_ironfist",                ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_DWF" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_dwf_lord_mikael_leadstrong",           ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_DWF" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_dwf_malakai_makaisson",                ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_DWF" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_emp_elspeth_von_draken",               ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_EMP" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_emp_theodore_bruckner",                ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_EMP" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_neu_gotrek_hero",                      ["dlc"] = { "TW_WH2_GOTREK_FELIX" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_nur_bray_shaman_wild_chieftain",       ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_NUR" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_nur_castellan_chieftain",              ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_NUR" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_nur_epidemius",                        ["dlc"] = { "TW_WH3_EPIDEMIUS_FREE" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_nur_exalted_hero_chieftain",           ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_NUR" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_nur_fimir_balefiend_shadow_chieftain", ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_NUR" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_nur_kayzk_the_befouled",               ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_NUR" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_nur_skin_wolf_werekin_chieftain",      ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_NUR" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc25_nur_tamurkhan",                        ["dlc"] = { "TW_WH3_THRONES_OF_DECAY_NUR" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_pro12_kho_cha_karanak",                      ["dlc"] = { "TW_WH3_PRO12_KARANAK" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc26_grn_gorbad_ironclaw",                  ["dlc"] = { "TW_WH3_OMENS_OF_DESTRUCTION_GRN" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc26_grn_snagla_grobpsit",                  ["dlc"] = { "TW_WH3_OMENS_OF_DESTRUCTION_GRN" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc26_kho_arbaal_the_undefeated",            ["dlc"] = { "TW_WH3_BASE_GAME" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc26_kho_scyla_anfingrimm",                 ["dlc"] = { "TW_WH3_OMENS_OF_DESTRUCTION_KHO" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc26_kho_skarr_bloodwrath",                 ["dlc"] = { "TW_WH3_OMENS_OF_DESTRUCTION_KHO" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc26_kho_skulltaker",                       ["dlc"] = { "TW_WH3_OMENS_OF_DESTRUCTION_KHO" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc26_ogr_bragg_the_gutsman",                ["dlc"] = { "TW_WH3_OMENS_OF_DESTRUCTION_OGR" } },
     { ["faction"] = "",                                          ["subtype"] = "wh3_dlc26_ogr_golgfag_maneater",                 ["dlc"] = { "TW_WH3_OMENS_OF_DESTRUCTION_OGR" } },
}

--MIXU--
local mixu_agents = {
     { ["faction"] = "wh_main_brt_lyonesse",           ["subtype"] = "brt_adalhard" },
     { ["faction"] = "wh_main_brt_carcassonne",        ["subtype"] = "brt_amalric_de_gaudaron" },
     { ["faction"] = "",                               ["subtype"] = "brt_bohemond" },
     { ["faction"] = "wh_main_brt_parravon",           ["subtype"] = "brt_cassyon" },
     { ["faction"] = "wh_main_brt_artois",             ["subtype"] = "brt_chilfroy" },
     { ["faction"] = "wh2_main_brt_knights_of_origo",  ["subtype"] = "brt_donna_don_domingio" },
     { ["faction"] = "wh2_main_brt_knights_of_origo",  ["subtype"] = "brt_john_tyreweld" },
     { ["faction"] = "wh2_main_bst_ripper_horn",       ["subtype"] = "bst_ghorros_warhoof" },
     { ["faction"] = "",                               ["subtype"] = "bst_slugtongue" },
     { ["faction"] = "",                               ["subtype"] = "chs_azubhor_clawhand" },
     { ["faction"] = "",                               ["subtype"] = "chs_egrimm_van_horstmann" },
     { ["faction"] = "",                               ["subtype"] = "chs_malofex_the_storm_chaser" },
     { ["faction"] = "",                               ["subtype"] = "cst_drekla" },
     { ["faction"] = "wh2_main_def_naggarond",         ["subtype"] = "def_kouran_darkhand" },
     { ["faction"] = "wh2_main_def_scourge_of_khaine", ["subtype"] = "def_tullaris_dreadbringer" },
     { ["faction"] = "wh_main_dwf_zhufbar",            ["subtype"] = "dwf_grimm_burloksson" },
     { ["faction"] = "wh_main_dwf_karak_azul",         ["subtype"] = "dwf_kazador_dragonslayer" },
     { ["faction"] = "",                               ["subtype"] = "dwf_kragg_the_grim" },
     { ["faction"] = "wh_main_emp_stirland",           ["subtype"] = "emp_alberich_haupt_anderssen" },
     { ["faction"] = "",                               ["subtype"] = "emp_alberich_von_korden" },
     { ["faction"] = "",                               ["subtype"] = "emp_alberich_von_korden_hero" },
     { ["faction"] = "wh_main_emp_hochland",           ["subtype"] = "emp_aldebrand_ludenhof" },
     { ["faction"] = "mixer_emp_van_der_kraal",        ["subtype"] = "emp_edvard_van_der_kraal" },
     { ["faction"] = "wh_main_emp_wissenland",         ["subtype"] = "emp_elspeth" },
     { ["faction"] = "wh_main_emp_talabecland",        ["subtype"] = "emp_helmut_feuerbach" },
     { ["faction"] = "wh_main_emp_empire",             ["subtype"] = "emp_luthor_huss" },
     { ["faction"] = "wh_main_emp_averland",           ["subtype"] = "emp_marius_leitdorf" },
     { ["faction"] = "wh_main_emp_nordland",           ["subtype"] = "emp_theoderic_gausser" },
     { ["faction"] = "wh_main_emp_wissenland",         ["subtype"] = "emp_theodore_bruckner" },
     { ["faction"] = "wh_main_emp_ostland",            ["subtype"] = "emp_valmir_von_raukov" },
     { ["faction"] = "wh_main_emp_middenland",         ["subtype"] = "emp_vorn_thugenheim" },
     { ["faction"] = "wh_main_emp_ostermark",          ["subtype"] = "emp_wolfram_hertwig" },
     { ["faction"] = "wh_main_grn_red_fangs",          ["subtype"] = "grn_gorfang_rotgut" },
     { ["faction"] = "wh2_main_hef_saphery",           ["subtype"] = "hef_belannaer" },
     { ["faction"] = "",                               ["subtype"] = "hef_caradryan" },
     { ["faction"] = "wh2_main_hef_chrace",            ["subtype"] = "hef_korhil" },
     { ["faction"] = "",                               ["subtype"] = "lzd_chakax" },
     { ["faction"] = "wh2_main_lzd_xlanhuapec",        ["subtype"] = "lzd_lord_huinitenuchli" },
     { ["faction"] = "wh2_main_lzd_tlaxtlan",          ["subtype"] = "lzd_tetto_eko" },
     { ["faction"] = "wh_main_nor_skaeling",           ["subtype"] = "nor_egil_styrbjorn" },
     { ["faction"] = "wh2_main_skv_clan_mordkin",      ["subtype"] = "skv_feskit" },
     { ["faction"] = "wh2_dlc09_tmb_numas",            ["subtype"] = "tmb_ramhotep" },
     { ["faction"] = "wh2_dlc09_tmb_numas",            ["subtype"] = "tmb_tutankhanut" },
     { ["faction"] = "wh2_dlc09_tmb_numas",            ["subtype"] = "tze_melekh_the_changer" },
     { ["faction"] = "",                               ["subtype"] = "vmp_dieter_helsnicht" },
     { ["faction"] = "wh_dlc05_wef_torgovann",         ["subtype"] = "wef_daith" },
     { ["faction"] = "wh_dlc05_wef_wydrioth",          ["subtype"] = "wef_naieth_the_prophetess" },
     { ["faction"] = "",                               ["subtype"] = "wef_wychwethyl" },
}

--XOUDAD High Elves Expanded--
local xoudad_agents = {
     { ["faction"] = "", ["subtype"] = "wax_emp_valten" },
}

--CATAPH TEB--
local teb_agents = {
     { ["faction"] = "mixer_teb_tilea",              ["subtype"] = "teb_borgio_the_besieger" },
     { ["faction"] = "mixer_teb_catrazza",           ["subtype"] = "teb_catrazza" },
     { ["faction"] = "mixer_teb_bilbali",            ["subtype"] = "teb_lucrezzia_belladonna" },
     { ["faction"] = "mixer_teb_gashnag",            ["subtype"] = "teb_gashnag" },
     { ["faction"] = "mixer_teb_border_princes",     ["subtype"] = "teb_gausser" },
     { ["faction"] = "mixer_teb_estalia",            ["subtype"] = "teb_lupio" },
     { ["faction"] = "mixer_teb_new_world_colonies", ["subtype"] = "teb_cadavo" },
     { ["faction"] = "mixer_teb_colombo",            ["subtype"] = "teb_colombo" },
}

--CATAPH Kraka Drak--
local kraka_agents = {
     { ["faction"] = "wh_main_dwf_kraka_drak", ["subtype"] = "kraka_cromson" },
}

--Project Resurrection - Parte Legendary Lords--
local parte_agents = {
     { ["faction"] = "wh2_main_skv_clan_moulder",     ["subtype"] = "skv_skweel_gnawtooth" },
     { ["faction"] = "wh2_main_def_blood_hall_coven", ["subtype"] = "def_hag_queen_malida" },
     { ["faction"] = "wh2_main_hef_cothique",         ["subtype"] = "hef_aislinn" },
     { ["faction"] = "wh_main_dwf_barak_varr",        ["subtype"] = "dwf_byrrnoth_grundadrakk" },
     { ["faction"] = "wh_main_dwf_karak_ziflin",      ["subtype"] = "dwf_rorek_granitehand" },
     { ["faction"] = "wh_main_dwf_karak_hirn",        ["subtype"] = "dwf_alrik_ranulfsson" },
}

--We'z Speshul--
local speshul_agents = {
     { ["faction"] = "wh_main_grn_greenskins",              ["subtype"] = "spcha_grn_borgut_facebeater" },
     { ["faction"] = "wh_main_grn_orcs_of_the_bloody_hand", ["subtype"] = "spcha_grn_grokka_goreaxe" },
     { ["faction"] = "",                                    ["subtype"] = "spcha_grn_tinitt_foureyes" }, -- wh_main_grn_black_venom -- wh2_main_grn_arachnos
     { ["faction"] = "wh2_main_grn_blue_vipers",            ["subtype"] = "spcha_grn_grak_beastbasha" },
     { ["faction"] = "wh_main_grn_crooked_moon",            ["subtype"] = "spcha_grn_duffskul" },
     { ["faction"] = "",                                    ["subtype"] = "spcha_grn_snagla_grobspit" }, -- wh_main_grn_black_venom -- wh2_main_grn_arachnos
}

--Whysofurious' Additional Lords & Heroes--
local wsf_agents = {
     { ["faction"] = "wh_main_emp_empire",                ["subtype"] = "genevieve" },
     { ["faction"] = "wh_main_vmp_vampire_counts",        ["subtype"] = "helsnicht" },
     { ["faction"] = "wh_main_vmp_schwartzhafen",         ["subtype"] = "konrad" },
     { ["faction"] = "wh_main_vmp_mousillon",             ["subtype"] = "mallobaude" },
     --{["faction"] = "", ["subtype"] = "sycamo"},
     { ["faction"] = "wh2_main_vmp_necrarch_brotherhood", ["subtype"] = "zacharias" },
}

--Ordo Draconis - Templehof Expanded--
local ordo_agents = {
     { ["faction"] = "wh_main_vmp_rival_sylvanian_vamps", ["subtype"] = "abhorash" },
     { ["faction"] = "wh_main_vmp_rival_sylvanian_vamps", ["subtype"] = "vmp_walach_harkon_hero" },
     { ["faction"] = "wh_main_vmp_rival_sylvanian_vamps", ["subtype"] = "tib_kael" },
}

--WsF' Vampire Bloodlines: The Strigoi--
local strigoi_agents = {
     { ["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "ushoran" },
     { ["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "vorag" },
     { ["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "str_high_priest" },
     { ["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "nanosh" },
}

--OvN Second Start--
local second_start_agents = {
     --{["faction"] = "wh2_main_hef_yvresse", ["subtype"] = "sr_grim"},
}

--OvN Lost Factions - Beta--
local lost_factions_agents = {
     --{["faction"] = "", ["subtype"] = "ovn_hlf_ll"},
     --{["faction"] = "", ["subtype"] = "ovn_araby_ll"},
     --{["faction"] = "", ["subtype"] = "Sultan_Jaffar"},
     --{["faction"] = "", ["subtype"] = "morgan_bernhardt"},
}

--Empire Master Engineer
local zf_agents = {
     { ["faction"] = "", ["subtype"] = "wh_main_emp_jubal_falk" },
}

--Cataph's High Elf Sea Patrol
local seahelm_agents = {
     { ["faction"] = "", ["subtype"] = "AK_aislinn" },
}
--Mixu's: Vangheist's Revenge
local mixu_vangheist = {
     { ["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_vangheist",                  ["dlc"] = { "TW_WH2_DLC11_VAMPIRE_COAST" } },
     { ["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_the_white_death",  ["dlc"] = { "TW_WH2_DLC11_VAMPIRE_COAST" } },
     { ["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_tia_drowna",       ["dlc"] = { "TW_WH2_DLC11_VAMPIRE_COAST" } },
     { ["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_dreng_gunddadrak", ["dlc"] = { "TW_WH2_DLC11_VAMPIRE_COAST" } },
     { ["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_khoskog",          ["dlc"] = { "TW_WH2_DLC11_VAMPIRE_COAST" } },
}

local locked_ai_generals = {
     --{["id"] = "2140784160",	["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "wh_pro01_dwf_grombrindal"},                                                                  -- Grombrindal
     --{["id"] = "2140783606",	["faction"] = "wh_main_grn_greenskins", ["subtype"] = "wh_main_grn_azhag_the_slaughterer"},                                                     -- Azhag the Slaughterer
     --{["id"] = "2140784146",	["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "wh_dlc04_vmp_helman_ghorst", ["dlc"] = "TW_WH_LORDS_AND_UNITS_1"},                   -- Helman Ghorst
     --{["id"] = "2140784202",	["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "wh_pro02_vmp_isabella_von_carstein"},                                                 -- Isabella von Carstein

     --{["id"] = "",	["faction"] = "wh2_main_hef_eataine", ["subtype"] = "wh2_main_hef_prince_alastar"},                                                                         -- Alastar
     --{["id"] = "2140784127",	["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "wh_dlc03_bst_malagor"},                                                                   -- Malagor
     --{["id"] = "2140784189",	["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "wh_dlc05_bst_morghur"},                                                                   -- Morghur
     --{["id"] = "2140783648",	["faction"] = "wh2_dlc13_emp_golden_order", ["subtype"] = "wh_main_emp_balthasar_gelt"},                                                        -- Balthasar Gelt
     --{["id"] = "2140784136",	["faction"] = "wh_main_emp_empire", ["subtype"] = "wh_dlc04_emp_volkmar", ["dlc"] = "TW_WH_LORDS_AND_UNITS_1"},                                  -- Volkmar the Grim
}

-- "major" factions  -- faction:can_be_human() backup
local playable_factions = {
     "wh2_main_hef_eataine",
     "wh2_main_hef_order_of_loremasters",
     "wh2_main_hef_avelorn",
     "wh2_main_hef_nagarythe",
     "wh2_main_lzd_hexoatl",
     "wh2_main_lzd_last_defenders",
     "wh2_dlc13_lzd_spirits_of_the_jungle",
     "wh2_dlc12_lzd_cult_of_sotek",
     "wh2_main_lzd_itza",
     "wh2_main_lzd_tlaqua",
     "wh2_main_def_naggarond",
     "wh2_main_def_cult_of_pleasure",
     "wh2_main_def_har_ganeth",
     "wh2_dlc11_def_the_blessed_dread",
     "wh2_main_def_hag_graef",
     "wh2_main_skv_clan_mors",
     "wh2_main_skv_clan_pestilens",
     "wh2_dlc09_skv_clan_rictus",
     "wh2_main_skv_clan_skryre",
     "wh2_main_skv_clan_eshin",
     "wh2_dlc11_cst_vampire_coast",
     "wh2_dlc11_cst_noctilus",
     "wh2_dlc11_cst_pirates_of_sartosa",
     "wh2_dlc11_cst_the_drowned",
     "wh2_dlc09_tmb_khemri",
     "wh2_dlc09_tmb_lybaras",
     "wh2_dlc09_tmb_followers_of_nagash",
     "wh2_dlc09_tmb_exiles_of_nehek",
     "wh_main_emp_empire",
     "wh2_dlc13_emp_golden_order",
     "wh2_dlc13_emp_the_huntmarshals_expedition",
     "wh_main_dwf_dwarfs",
     "wh_main_dwf_karak_izor",
     "wh_main_dwf_karak_kadrin",
     "wh_main_grn_greenskins",
     "wh_main_grn_crooked_moon",
     "wh_main_grn_orcs_of_the_bloody_hand",
     "wh_main_vmp_vampire_counts",
     "wh_main_vmp_schwartzhafen",
     "wh2_dlc11_vmp_the_barrow_legion",
     "wh_dlc08_nor_norsca",
     "wh_dlc08_nor_wintertooth",
     "wh_main_brt_bretonnia",
     "wh_main_brt_bordeleaux",
     "wh_main_brt_carcassonne",
     "wh2_dlc14_brt_chevaliers_de_lyonesse",
     "wh_dlc05_wef_wood_elves",
     "wh_dlc05_wef_argwylon",
     "wh_dlc03_bst_beastmen",
     "wh_main_chs_chaos",
     "wh2_dlc15_hef_imrik",
     "wh2_main_hef_yvresse",
     "wh2_dlc15_grn_broken_axe",
     "wh2_main_skv_clan_moulder",
     "wh2_dlc16_wef_drycha",
     "wh2_dlc16_wef_sisters_of_twilight",
     "wh2_twa03_def_rakarth",
     "wh2_dlc17_lzd_oxyotl",
     "wh2_dlc17_dwf_thorek_ironbrow",
     "wh2_dlc17_bst_taurox",
     "wh3_main_cth_the_northern_provinces",
     "wh3_main_cth_the_western_provinces",
     "wh3_main_dae_daemon_prince",
     "wh3_main_kho_exiles_of_khorne",
     "wh3_main_ksl_the_great_orthodoxy",
     "wh3_main_ksl_the_ice_court",
     "wh3_main_ksl_ursun_revivalists",
     "wh3_main_nur_poxmakers_of_nurgle",
     "wh3_main_ogr_disciples_of_the_maw",
     "wh3_main_ogr_goldtooth",
     "wh3_main_sla_seducers_of_slaanesh",
     "wh3_main_tze_oracles_of_tzeentch",
     "wh_dlc05_bst_morghur_herd",
     "wh3_main_vmp_caravan_of_blue_roses",
     "wh3_main_emp_cult_of_sigmar",
     "wh3_main_dwf_the_ancestral_throng",
     "wh3_main_chs_shadow_legion",
     "wh3_dlc20_chs_vilitch",
     "wh3_dlc20_chs_valkia",
     "wh3_dlc20_chs_sigvald",
     "wh3_dlc20_chs_kholek",
     "wh3_dlc20_chs_festus",
     "wh3_dlc20_chs_azazel",
     "wh2_dlc17_bst_malagor",
     "wh2_dlc15_grn_bonerattlaz",
     "wh3_dlc23_chd_zhatan",
     "wh3_dlc23_chd_legion_of_azgorh",
     "wh3_dlc23_chd_astragoth",
     "wh_main_emp_wissenland",
     "wh3_dlc24_tze_the_deceivers",
     "wh3_dlc24_cth_the_celestial_court",
     "wh3_dlc24_ksl_daughters_of_the_forest",
     "wh3_dlc25_dwf_malakai",
     "wh3_dlc25_nur_tamurkhan",
     "wh3_dlc25_nur_epidemius",
     "wh3_dlc26_grn_gorbad_ironclaw",
     "wh3_dlc26_kho_arbaal",
     "wh3_dlc26_kho_skulltaker",
     "wh3_dlc26_ogr_golgfag",
}

local alastar_quests = {
     { "wh2_main_anc_armour_lions_pelt", 1 },
}

local chs_subtype_anc = {
     ["wh3_main_ksl_katarin"] = {
          { "mission", "wh3_main_anc_weapon_frost_fang",        "wh3_main_ie_qb_ksl_katarin_frost_fang", 7 },
          { "mission", "wh3_main_anc_armour_the_crystal_cloak", "wh3_main_qb_ksl_katarin_crystal_cloak", 10, nil, "wh3_main_camp_quest_katarin_the_crystal_cloak_001", 245, 291 }
     },
     ["wh3_main_ksl_kostaltyn"] = {
          { "mission", "wh3_main_anc_weapon_the_burning_brazier", "wh3_main_qb_ksl_kostaltyn_burning_brazier", 10, nil, "wh3_main_camp_quest_kostaltyn_burning_brazier_001", 153, 162 }
     },
     ["wh3_main_ksl_boris"] = {
          { "mission", "wh3_main_anc_weapon_shard_blade",     "wh3_main_ie_qb_ksl_boris_shard_blade",     7 },
          { "mission", "wh3_main_anc_armour_armour_of_ursun", "wh3_main_ie_qb_ksl_boris_armour_of_ursun", 10 }
     },
     ["wh3_main_ogr_greasus_goldtooth"] = {
          { "mission", "wh3_main_anc_weapon_sceptre_of_titans",   "wh3_main_ie_qb_ogr_greasus_sceptre_of_titans", 7 },
          { "mission", "wh3_main_anc_talisman_overtyrants_crown", "wh3_main_qb_ogr_greasus_overtyrants_crown",    10, nil, "wh3_main_camp_quest_greasus_overtyrants_crown_001", 591, 240 }
     },
     ["wh3_main_ogr_skrag_the_slaughterer"] = {
          { "mission", "wh3_main_anc_enchanted_item_cauldron_of_the_great_maw", "wh3_main_qb_ogr_skrag_cauldron_of_the_great_maw", 10, nil, "wh3_main_camp_quest_skrag_cauldron_of_the_great_maw_001", 515, 238 }
     },
     ["wh3_main_kho_skarbrand"] = {
          { "mission", "wh3_main_anc_weapon_slaughter_and_carnage", "wh3_main_qb_kho_skarbrand_slaughter_and_carnage", 10, nil, "wh3_main_camp_quest_skarbrand_slaughter_and_carnage_001", 285, 278 }
     },
     ["wh3_main_nur_kugath"] = {
          { "mission", "wh3_main_anc_weapon_necrotic_missiles", "wh3_main_qb_nur_kugath_necrotic_missiles", 10, nil, "wh3_main_camp_quest_kugath_necrotic_missiles_001", 465, 256 }
     },
     ["wh3_main_sla_nkari"] = {
          { "mission", "wh3_main_anc_weapon_witstealer_sword", "wh3_main_qb_sla_nkari_witstealer_sword", 10, nil, "wh3_main_camp_quest_nkari_witstealer_sword_001", 30, 431 }
     },
     ["wh3_main_tze_kairos"] = {
          { "mission", "wh3_main_anc_arcane_item_staff_of_tomorrow", "wh3_main_qb_tze_kairos_staff_of_tomorrow", 10, nil, "wh3_main_camp_quest_kairos_staff_of_tomorrow_001", 253, 400 }
     },
     ----------------------
     ------ CHAMPIONS -----
     ----------------------
     ["wh3_dlc20_sla_azazel"] = {
          { "mission", "wh3_dlc20_anc_weapon_daemonblade", "wh3_dlc20_qb_chs_azazel_daemonblade", 15, nil, "wh3_dlc20_azazel_cam_quest_mission_001", 452, 505 }
     },
     ["wh3_dlc20_nur_festus"] = {
          { "mission", "wh3_dlc20_anc_enchanted_item_pestilent_potions", "wh3_dlc20_qb_chs_festus_pestilent_potions", 15, nil, "wh3_dlc20_festus_cam_quest_mission_001", 375, 396 }
     },
     ["wh3_dlc20_kho_valkia"] = {
          { "mission", "wh3_dlc20_anc_armour_the_scarlet_armour",   "wh3_dlc20_qb_chs_valkia_the_scarlet_armour", 8 },
          { "mission", "wh3_dlc20_anc_enchanted_item_daemonshield", "wh3_dlc20_qb_chs_valkia_daemonshield",       12 },
          { "mission", "wh3_dlc20_anc_weapon_the_spear_slaupnir",   "wh3_dlc20_qb_chs_valkia_the_spear_slaupnir", 15, nil, "wh3_dlc20_valkia_cam_quest_mission_001", 393, 515 }
     },
     ["wh3_dlc20_tze_vilitch"] = {
          { "mission", "wh3_dlc20_anc_arcane_item_vessel_of_chaos", "wh3_dlc20_qb_chs_vilitch_vessel_of_chaos", 15, nil, "wh3_dlc20_vilitch_cam_quest_mission_001", 237, 513 }
     }
}

local im_subtype_anc = {
     ----------------------
     ------- EMPIRE -------
     ----------------------
     ["wh_main_emp_karl_franz"] = {
          { "mission", "wh2_dlc13_anc_weapon_runefang_drakwald", "wh3_main_ie_qb_emp_karl_franz_reikland_runefang", 7,  nil, "war.camp.advice.quests.001", 342, 585 },
          { "mission", "wh_main_anc_weapon_ghal_maraz",          "wh3_main_ie_qb_emp_karl_franz_ghal_maraz",        12, nil, nil,                          440, 439 },
          { "mission", "wh_main_anc_talisman_the_silver_seal",   "wh3_main_ie_qb_emp_karl_franz_silver_seal",       17, nil, nil,                          431, 496 },
     },
     ["wh_main_emp_balthasar_gelt"] = {
          { "mission", "wh_main_anc_enchanted_item_cloak_of_molten_metal", "wh3_main_ie_qb_emp_balthasar_gelt_cloak_of_molten_metal", 7,  nil, "war.camp.advice.quests.001", 347, 544 },
          { "mission", "wh_main_anc_talisman_amulet_of_sea_gold",          "wh3_main_ie_qb_emp_balthasar_gelt_amulet_of_sea_gold",    12, nil, nil,                          267, 339 },
          { "mission", "wh_main_anc_arcane_item_staff_of_volans",          "wh3_main_ie_qb_emp_balthasar_gelt_staff_of_volans",       17, nil, nil,                          367, 498 },
     },
     ["wh_dlc04_emp_volkmar"] = {
          { "mission", "wh_dlc04_anc_talisman_jade_griffon",   "wh3_main_ie_qb_emp_volkmar_the_grim_jade_griffon",     7,  nil, "war.camp.advice.quests.001", 465, 502 },
          { "mission", "wh_dlc04_anc_weapon_staff_of_command", "wh3_main_ie_qb_emp_volkmar_the_grim_staff_of_command", 12, nil, nil,                          343, 496 },
     },
     ["wh2_dlc13_emp_cha_markus_wulfhart"] = {
          { "mission", "wh2_dlc13_anc_weapon_amber_bow", "wh3_main_ie_qb_emp_wulfhart_amber_bow", 7, nil, "war.camp.advice.quests.001", 118, 258 },
     },

     ----------------------
     ------- DWARFS -------
     ----------------------
     ["wh_dlc06_dwf_belegar"] = {
          { "mission", "wh_dlc06_anc_weapon_the_hammer_of_angrund", "wh3_main_ie_qb_dwf_belegar_ironhammer_hammer_of_angrund",  12, nil, nil,                          510, 348 },
          { "mission", "wh_dlc06_anc_armour_shield_of_defiance",    "wh3_main_ie_qb_dwf_belegar_ironhammer_shield_of_defiance", 7,  nil, "war.camp.advice.quests.001", 531, 373 },
     },
     ["wh_pro01_dwf_grombrindal"] = {
          { "mission", "wh_pro01_anc_armour_armour_of_glimril_scales",     "wh3_main_ie_qb_dwf_grombrindal_armour_of_glimril",       7,  nil, "war.camp.advice.quests.001", 337, 525 },
          { "mission", "wh_pro01_anc_weapon_the_rune_axe_of_grombrindal",  "wh3_main_ie_qb_dwf_grombrindal_rune_axe_of_grombrindal", 12, nil, nil,                          422, 628 },
          { "mission", "wh_pro01_anc_talisman_cloak_of_valaya",            "wh3_main_ie_qb_dwf_grombrindal_rune_cloak_of_valaya",    17, nil, nil,                          545, 588 },
          { "mission", "wh_pro01_anc_enchanted_item_rune_helm_of_zhufbar", "wh3_main_ie_qb_dwf_grombrindal_rune_helm_of_zhufbar",    22, nil, nil,                          531, 408 },
     },
     ["wh_main_dwf_thorgrim_grudgebearer"] = {
          { "mission", "wh_main_anc_armour_the_armour_of_skaldour",            "wh3_main_ie_qb_dwf_thorgrim_grudgebearer_armour_of_skaldour",    12, nil, nil,                          434, 622 },
          { "mission", "wh_main_anc_weapon_the_axe_of_grimnir",                "wh3_main_ie_qb_dwf_thorgrim_grudgebearer_axe_of_grimnir",        7,  nil, "war.camp.advice.quests.001", 467, 277 },
          { "mission", "wh_main_anc_enchanted_item_the_great_book_of_grudges", "wh3_main_ie_qb_dwf_thorgrim_grudgebearer_book_of_grudges",       22, nil, nil,                          470, 498 },
          { "mission", "wh_main_anc_talisman_the_dragon_crown_of_karaz",       "wh3_main_ie_qb_dwf_thorgrim_grudgebearer_dragon_crown_of_karaz", 17, nil, nil,                          440, 439 },
     },
     ["wh_main_dwf_ungrim_ironfist"] = {
          { "mission", "wh_main_anc_weapon_axe_of_dargo",              "wh3_main_ie_qb_dwf_ungrim_ironfist_axe_of_dargo",            17, nil, nil,                          542, 593 },
          { "mission", "wh_main_anc_talisman_dragon_cloak_of_fyrskar", "wh3_main_ie_qb_dwf_ungrim_ironfist_dragon_cloak_of_fyrskar", 12, nil, nil,                          506, 510 },
          { "mission", "wh_main_anc_armour_the_slayer_crown",          "wh3_main_ie_qb_dwf_ungrim_ironfist_slayer_crown",            7,  nil, "war.camp.advice.quests.001", 353, 542 },
     },
     ["wh2_dlc17_dwf_thorek"] = {
          { "mission", "wh2_dlc17_anc_armour_thoreks_rune_armour", "wh3_main_ie_qb_dwf_thorek_rune_armour_quest", 7 },
          { "mission", "wh2_dlc17_anc_weapon_klad_brakak",         "wh3_main_ie_qb_dwf_thorek_klad_brakak",       12, nil, "war.camp.advice.quests.001", 481, 156 },
     },
     ----------------------
     ----- GREENSKINS -----
     ----------------------
     ["wh2_dlc15_grn_grom_the_paunch"] = {
          { "mission", "wh2_dlc15_anc_weapon_axe_of_grom",          "wh3_main_ie_qb_grn_grom_axe_of_grom",  12, nil, "war.camp.advice.quests.001", 409, 214 },
          { "mission", "wh2_dlc15_anc_enchanted_item_lucky_banner", "wh3_main_ie_qb_grn_grom_lucky_banner", 7 },
     },
     ["wh_dlc06_grn_skarsnik"] = {
          { "mission", "wh_dlc06_anc_weapon_skarsniks_prodder", "wh3_main_ie_qb_grn_skarsnik_skarsniks_prodder", 7, nil, "war.camp.advice.quests.001", 512, 346 },
     },
     ["wh_dlc06_grn_wurrzag_da_great_prophet"] = {
          { "mission", "wh_dlc06_anc_enchanted_item_baleful_mask", "wh3_main_ie_qb_grn_wurrzag_da_great_green_prophet_baleful_mask",   7,  nil, "war.camp.advice.quests.001", 416, 253 },
          { "mission", "wh_dlc06_anc_arcane_item_squiggly_beast",  "wh3_main_ie_qb_grn_wurrzag_da_great_green_prophet_squiggly_beast", 12, nil, nil,                          364, 433 },
          { "mission", "wh_dlc06_anc_weapon_bonewood_staff",       "wh3_main_ie_qb_grn_wurrzag_da_great_green_prophet_bonewood_staff", 17, nil, nil,                          475, 402 },
     },
     ["wh_main_grn_azhag_the_slaughterer"] = {
          { "mission", "wh_main_anc_enchanted_item_the_crown_of_sorcery", "wh3_main_ie_qb_grn_azhag_the_slaughterer_crown_of_sorcery",  7,  nil, "war.camp.advice.quests.001", 563, 601 },
          { "mission", "wh_main_anc_armour_azhags_ard_armour",            "wh3_main_ie_qb_grn_azhag_the_slaughterer_azhags_ard_armour", 12, nil, nil,                          338, 361 },
          { "mission", "wh_main_anc_weapon_slaggas_slashas",              "wh3_main_ie_qb_grn_azhag_the_slaughterer_slaggas_slashas",   17, nil, nil,                          416, 253 },
     },
     ["wh_main_grn_grimgor_ironhide"] = {
          { "mission", "wh_main_anc_armour_blood-forged_armour", "wh3_main_ie_qb_grn_grimgor_ironhide_blood_forged_armour", 12, nil, nil,                          542, 593 },
          { "mission", "wh_main_anc_weapon_gitsnik",             "wh3_main_ie_qb_grn_grimgor_ironhide_gitsnik",             7,  nil, "war.camp.advice.quests.001", 450, 420 },
     },

     ----------------------
     --- VAMPIRE COUNTS ---
     ----------------------
     ["wh_main_vmp_mannfred_von_carstein"] = {
          { "mission", "wh_main_anc_armour_armour_of_templehof",   "wh3_main_ie_qb_vmp_mannfred_von_carstein_armour_of_templehof",   12, nil, nil,                          336, 367 },
          { "mission", "wh_main_anc_weapon_sword_of_unholy_power", "wh3_main_ie_qb_vmp_mannfred_von_carstein_sword_of_unholy_power", 7,  nil, "war.camp.advice.quests.001", 467, 277 },
     },
     ["wh_dlc04_vmp_helman_ghorst"] = {
          { "mission", "wh_dlc04_anc_arcane_item_the_liber_noctus", "wh3_main_ie_qb_vmp_helman_ghorst_liber_noctus", 7, nil, "war.camp.advice.quests.001", 356, 357 },
     },
     ["wh_main_vmp_heinrich_kemmler"] = {
          { "mission", "wh_main_anc_arcane_item_skull_staff",                   "wh3_main_ie_qb_vmp_heinrich_kemmler_skull_staff",      17, nil, nil,                          337, 438 },
          { "mission", "wh_main_anc_enchanted_item_cloak_of_mists_and_shadows", "wh3_main_ie_qb_vmp_heinrich_kemmler_cloak_of_mists",   12, nil, nil,                          362, 499 },
          { "mission", "wh_main_anc_weapon_chaos_tomb_blade",                   "wh3_main_ie_qb_vmp_heinrich_kemmler_chaos_tomb_blade", 7,  nil, "war.camp.advice.quests.001", 356, 357 },
     },
     ["wh_dlc04_vmp_vlad_con_carstein"] = {
          { "mission", "wh_dlc04_anc_talisman_the_carstein_ring", "wh3_main_ie_qb_vmp_vlad_von_carstein_the_carstein_ring", 12, nil, nil,                          533, 314 },
          { "mission", "wh_dlc04_anc_weapon_blood_drinker",       "wh3_main_ie_qb_vmp_vlad_von_carstein_blood_drinker",     7,  nil, "war.camp.advice.quests.001", 482, 505 },
     },
     ["wh_pro02_vmp_isabella_von_carstein"] = {
          { "mission", "wh_pro02_anc_enchanted_item_blood_chalice_of_bathori", "wh3_main_ie_qb_vmp_isabella_von_carstein_blood_chalice_of_bathori", 8, nil, "war.camp.advice.quests.001", 478, 467 },
     },

     ----------------------
     -------- CHAOS -------
     ----------------------
     ["wh_main_chs_archaon"] = {
          { "mission", "wh_main_anc_armour_the_armour_of_morkar",            "wh3_main_ie_qb_chs_archaon_armour_of_morkar",    12, nil, nil,                          576, 617 },
          { "mission", "wh_main_anc_enchanted_item_the_crown_of_domination", "wh3_main_ie_qb_chs_archaon_crown_of_domination", 22, nil, nil,                          470, 701 },
          { "mission", "wh_main_anc_talisman_the_eye_of_sheerian",           "wh3_main_ie_qb_chs_archaon_eye_of_sheerian",     17, nil, nil,                          596, 660 },
          { "mission", "wh_main_anc_weapon_the_slayer_of_kings",             "wh3_main_ie_qb_chs_archaon_slayer_of_kings",     7,  nil, "war.camp.advice.quests.001", 543, 593 },
     },
     ["wh_dlc01_chs_prince_sigvald"] = {
          { "mission", "wh_main_anc_armour_auric_armour", "wh3_main_ie_qb_chs_prince_sigvald_auric_armour", 12, nil, nil,                          434, 622 },
          { "mission", "wh_main_anc_weapon_sliverslash",  "wh3_main_ie_qb_chs_prince_sigvald_sliverslash",  7,  nil, "war.camp.advice.quests.001", 522, 649 },
     },
     ["wh_dlc01_chs_kholek_suneater"] = {
          { "mission", "wh_main_anc_weapon_starcrusher", "wh3_main_ie_qb_chs_kholek_suneater_starcrusher", 7, nil, "war.camp.advice.quests.001", 565, 575 },
     },
     ["wh3_dlc20_sla_azazel"] = {
          { "mission", "wh3_dlc20_anc_weapon_daemonblade", "wh3_dlc20_ie_qb_chs_azazel_daemonblade", 15, nil, "wh3_dlc20_azazel_cam_quest_mission_001", 315, 729 }
     },
     ["wh3_dlc20_nur_festus"] = {
          { "mission", "wh3_dlc20_anc_enchanted_item_pestilent_potions", "wh3_dlc20_ie_qb_chs_festus_pestilent_potions", 15, nil, "wh3_dlc20_festus_cam_quest_mission_001", 435, 728 }
     },
     ["wh3_dlc20_kho_valkia"] = {
          { "mission", "wh3_dlc20_anc_armour_the_scarlet_armour",   "wh3_dlc20_ie_qb_chs_valkia_the_scarlet_armour", 8 },
          { "mission", "wh3_dlc20_anc_enchanted_item_daemonshield", "wh3_dlc20_ie_qb_chs_valkia_daemonshield",       12 },
          { "mission", "wh3_dlc20_anc_weapon_the_spear_slaupnir",   "wh3_dlc20_ie_qb_chs_valkia_the_spear_slaupnir", 15, nil, "wh3_dlc20_valkia_cam_quest_mission_001", 566, 700 }
     },
     ["wh3_dlc20_tze_vilitch"] = {
          { "mission", "wh3_dlc20_anc_arcane_item_vessel_of_chaos", "wh3_dlc20_ie_qb_chs_vilitch_vessel_of_chaos", 15, nil, "wh3_dlc20_vilitch_cam_quest_mission_001", 490, 709 }
     },
     ["wh3_main_dae_belakor"] = {
          { "reward", "wh3_main_anc_weapon_blade_of_shadow", nil, 7 }
     },
     ----------------------
     ------ BEASTMEN ------
     ----------------------
     ["wh_dlc03_bst_khazrak"] = {
          { "mission", "wh_dlc03_anc_armour_the_dark_mail", "wh3_main_ie_qb_bst_khazrak_one_eye_the_dark_mail", 12, nil, nil,                          418, 553 },
          { "mission", "wh_dlc03_anc_weapon_scourge",       "wh3_main_ie_qb_bst_khazrak_one_eye_scourge",       7,  nil, "war.camp.advice.quests.001", 360, 544 },
     },
     ["wh_dlc03_bst_malagor"] = {
          { "mission", "wh_dlc03_anc_enchanted_item_icons_of_vilification", "wh3_main_ie_qb_bst_malagor_the_dark_omen_the_icons_of_vilification", 7, nil, "war.camp.advice.quests.001", 389, 490 },
     },
     ["wh_dlc05_bst_morghur"] = {
          { "mission", "wh_main_anc_weapon_stave_of_ruinous_corruption", "wh3_main_ie_qb_bst_morghur_stave_of_ruinous_corruption", 7, nil, "war.camp.advice.quests.001", 276, 483 },
     },
     ["wh2_dlc17_bst_taurox"] = {
          { "mission", "wh2_dlc17_anc_weapon_rune_tortured_axes", "wh3_main_ie_qb_bst_taurox_rune_tortured_axes", 7, nil, "war.camp.advice.quests.001", 108, 637 },
     },

     ---------------------
     ----- WOOD ELVES -----
     ----------------------
     ["wh_dlc05_wef_orion"] = {
          { "mission", "wh_dlc05_anc_enchanted_item_horn_of_the_wild_hunt", "wh3_main_ie_qb_wef_orion_the_horn_of_the_wild", 7,  nil, "war.camp.advice.quests.001", 334, 427 },
          { "mission", "wh_dlc05_anc_talisman_cloak_of_isha",               "wh3_main_ie_qb_wef_orion_the_cloak_of_isha",    12, nil, nil,                          335, 414 },
          { "mission", "wh_dlc05_anc_weapon_spear_of_kurnous",              "wh3_main_ie_qb_wef_orion_the_spear_of_kurnous", 17, nil, nil,                          335, 397 },
     },
     ["wh_dlc05_wef_durthu"] = {
          { "mission", "wh_dlc05_anc_weapon_daiths_sword", "wh3_main_ie_qb_wef_durthu_daiths_sword", 7, nil, "war.camp.advice.quests.001", 335, 397 },
     },
     ["wh2_dlc16_wef_sisters_of_twilight"] = {
          { "mission", "wh2_dlc16_anc_mount_wef_cha_sisters_of_twilight_forest_dragon", "wh3_main_ie_qb_wef_sisters_dragon", 12, nil, "war.camp.advice.quests.001", 58, 489 },
     },
     ["wh2_dlc16_wef_drycha"] = {
          { "mission", "wh2_dlc16_anc_enchanted_item_fang_of_taalroth", "wh3_main_ie_qb_wef_drycha_coeddil_unchained", 7, nil, "war.camp.advice.quests.001", 348, 404 },
     },

     ----------------------
     ------ BRETONNIA -----
     ----------------------
     ["wh_main_brt_louen_leoncouer"] = {
          { "mission", "wh_main_anc_weapon_the_sword_of_couronne",      "wh3_main_ie_qb_brt_louen_sword_of_couronne",    12, nil, "war.camp.advice.quests.001", 276, 483 },
          { "mission", "wh2_dlc12_anc_armour_brt_armour_of_brilliance", "wh3_main_ie_qb_brt_louen_armour_of_brilliance", 3 },
     },
     ["wh_dlc07_brt_fay_enchantress"] = {
          { "mission", "wh_dlc07_anc_arcane_item_the_chalice_of_potions",   "wh3_main_ie_qb_brt_fay_enchantress_chalice_of_potions", 12, nil, "war.camp.advice.quests.001", 258, 535 },
          { "mission", "wh2_dlc12_anc_enchanted_item_brt_morgianas_mirror", "wh3_main_ie_qb_brt_fay_morgianas_mirror",               3 },
     },
     ["wh_dlc07_brt_alberic"] = {
          { "mission", "wh_dlc07_anc_weapon_trident_of_manann",                "wh3_main_ie_qb_brt_alberic_trident_of_bordeleaux", 7, nil, "war.camp.advice.quests.001", 264, 347 },
          { "mission", "wh2_dlc12_anc_enchanted_item_brt_braid_of_bordeleaux", "wh3_main_ie_qb_brt_alberic_braid_of_bordeleaux",   12 },
     },
     ["wh2_dlc14_brt_repanse"] = {
          { "mission", "wh2_dlc14_anc_weapon_sword_of_lyonesse", "wh3_main_ie_qb_brt_repanse_sword_of_lyonesse", 7, nil, "war.camp.advice.quests.001", 325, 237 },
     },

     ----------------------
     ------- NORSCA -------
     ----------------------
     ["wh_dlc08_nor_wulfrik"] = {
          { "mission", "wh_dlc08_anc_weapon_sword_of_torgald", "wh3_main_ie_qb_nor_wulfrik_the_wanderer_sword_of_torgald", 7, nil, "war.camp.advice.quests.001", 251, 500 },
     },
     ["wh_dlc08_nor_throgg"] = {
          { "mission", "wh_dlc08_anc_enchanted_item_wintertooth_crown", "wh3_main_ie_qb_nor_throgg_wintertooth_crown", 7, nil, "war.camp.advice.quests.001", 502, 509 },
     },

     ----------------------
     ----- HIGH ELVES -----
     ----------------------
     ["wh2_main_hef_tyrion"] = {
          { "mission", "wh2_main_anc_armour_dragon_armour_of_aenarion", "wh3_main_ie_qb_hef_tyrion_dragon_armour_of_aenarion", 7,  nil, "war.camp.advice.quest.tyrion.dragon_armour_of_aenarion.001", 135, 398 },
          { "mission", "wh2_main_anc_weapon_sunfang",                   "wh3_main_ie_qb_hef_tyrion_sunfang",                   12, nil, "war.camp.advice.quest.tyrion.sunfang.001",                   196, 438 },
          { "mission", "wh2_main_anc_enchanted_item_heart_of_avelorn",  "wh3_main_ie_qb_hef_tyrion_heart_of_avelorn",          17 },
     },
     ["wh2_main_hef_teclis"] = {
          { "mission", "wh2_main_anc_enchanted_item_scroll_of_hoeth",    "wh2_main_vortex_narrative_hef_the_lies_of_the_druchii", 2 },
          { "mission", "wh2_main_anc_arcane_item_moon_staff_of_lileath", "wh2_main_vortex_narrative_hef_the_vermin_of_hruddithi", 4 },
          { "mission", "wh2_main_anc_armour_war_crown_of_saphery",       "wh3_main_ie_qb_hef_teclis_war_crown_of_saphery",        7,  nil, "war.camp.advice.quest.teclis.war_crown_of_saphery.001", 91,  173 },
          { "mission", "wh2_main_anc_weapon_sword_of_teclis",            "wh3_main_ie_qb_hef_teclis_sword_of_teclis",             12, nil, "war.camp.advice.quest.teclis.sword_of_teclis.001",      135, 398 },
     },
     ["wh2_dlc10_hef_alarielle"] = {
          { "mission", "wh2_dlc10_anc_talisman_shieldstone_of_isha",   "wh3_main_ie_qb_hef_alarielle_shieldstone_of_isha", 7 },
          { "mission", "wh2_dlc10_anc_enchanted_item_star_of_avelorn", "wh3_main_ie_qb_hef_alarielle_star_of_avelorn",     12, nil, "war.camp.advice.quests.001", 246, 593 },
     },
     ["wh2_dlc10_hef_alith_anar"] = {
          { "mission", "wh2_dlc10_anc_enchanted_item_the_shadow_crown", "wh3_main_ie_qb_hef_alith_anar_the_shadow_crown", 4 },
          { "mission", "wh2_dlc10_anc_weapon_moonbow",                  "wh3_main_ie_qb_hef_alith_anar_the_moonbow",      7, nil, "war.camp.advice.quests.001", 43, 421 },
     },
     ["wh2_dlc15_hef_eltharion"] = {
          { "mission", "wh2_dlc15_anc_talisman_talisman_of_hoeth",    "wh3_main_ie_qb_hef_eltharion_talisman_of_hoeth",      7, nil, "war.camp.advice.quests.001", 213, 420 },
          { "mission", "wh2_dlc15_anc_armour_helm_of_yvresse",        "wh3_main_ie_qb_hef_eltharion_helm_of_yvresse",        12 },
          { "mission", "wh2_dlc15_anc_weapon_fangsword_of_eltharion", "wh3_main_ie_qb_hef_eltharion_fangsword_of_eltharion", 17 },
     },
     ["wh2_dlc15_hef_imrik"] = {
          { "mission", "wh2_dlc15_anc_armour_armour_of_caledor", "wh3_main_ie_qb_hef_imrik_armour_of_caledor", 8, nil, "war.camp.advice.quests.001", 164, 509 },
     },

     ----------------------
     ----- DARK ELVES -----
     ----------------------
     ["wh2_main_def_malekith"] = {
          { "mission", "wh2_main_anc_arcane_item_circlet_of_iron", "wh3_main_ie_qb_def_malekith_circlet_of_iron",     7,  nil, "war.camp.advice.quest.malekith.circlet_of_iron.001",     37,  643 },
          { "mission", "wh2_main_anc_weapon_destroyer",            "wh3_main_ie_qb_def_malekith_destroyer",           12, nil, "war.camp.advice.quest.malekith.destroyer.001",           135, 398 },
          { "mission", "wh2_main_anc_armour_supreme_spellshield",  "wh3_main_ie_qb_def_malekith_supreme_spellshield", 17, nil, "war.camp.advice.quest.malekith.supreme_spellshield.001", 148, 222 },
          { "mission", "wh2_main_anc_armour_armour_of_midnight",   "wh3_main_ie_qb_def_malekith_armour_of_midnight",  4 },
     },
     ["wh2_main_def_morathi"] = {
          { "mission", "wh2_main_anc_weapon_heartrender_and_the_darksword", "wh3_main_ie_qb_def_morathi_heartrender_and_the_darksword", 12, nil, "war.camp.advice.quest.morathi.heartrender_and_the_darksword.001", 83, 454 },
          { "mission", "wh2_main_anc_arcane_item_wand_of_the_kharaidon",    "wh3_main_ie_qb_def_morathi_wand_of_kharaidon",             7 },
          { "mission", "wh2_main_anc_talisman_amber_amulet",                "wh3_main_ie_qb_def_morathi_amber_amulet",                  4 },
     },
     ["wh2_dlc10_def_crone_hellebron"] = {
          { "mission", "wh2_dlc10_anc_weapon_deathsword_and_the_cursed_blade", "wh3_main_ie_qb_def_hellebron_deathsword_and_the_cursed_blade", 12, nil, "war.camp.advice.quests.001", 37, 643 },
          { "mission", "wh2_dlc10_anc_talisman_amulet_of_dark_fire",           "wh3_main_ie_qb_def_hellebron_amulet_of_dark_fire",             7 },
     },
     ["wh2_dlc11_def_lokhir"] = {
          { "mission", "wh2_main_anc_armour_helm_of_the_kraken", "wh3_main_ie_qb_lokhir_helm_of_the_kraken", 12, nil, "wh2_dlc11.camp.advice.quest.lokhir.001", 158, 128 },
          { "mission", "wh2_dlc11_anc_weapon_red_blades",        "wh3_main_ie_qb_def_lokhir_red_blades",     3 },
     },
     ["wh2_dlc14_def_malus_darkblade"] = {
          { "mission", "wh2_dlc14_anc_weapon_warpsword_of_khaine", "wh3_main_ie_qb_def_malus_warpsword_of_khaine", 7, nil, "war.camp.advice.quests.001", 492, 128 },
     },
     ["wh2_twa03_def_rakarth"] = {
          { "mission", "wh2_twa03_anc_weapon_whip_of_agony", "wh3_main_ie_qb_def_rakarth_whip_of_agony", 7, nil, "war.camp.advice.quests.001", 238, 557 },
     },

     ----------------------
     ------ LIZARDMEN -----
     ----------------------
     ["wh2_main_lzd_lord_mazdamundi"] = {
          { "mission", "wh2_main_anc_weapon_cobra_mace_of_mazdamundi",             "wh3_main_ie_qb_lzd_mazdamundi_cobra_mace_of_mazdamundi",     12, nil, "war.camp.advice.quest.mazdamundi.cobra_mace_of_mazdamundi.001",     54, 295 },
          { "mission", "wh2_main_anc_magic_standard_sunburst_standard_of_hexoatl", "wh3_main_ie_qb_lzd_mazdamundi_sunburst_standard_of_hexoatl", 7,  nil, "war.camp.advice.quest.mazdamundi.sunburst_standard_of_hexoatl.001", 35, 392 },
     },
     ["wh2_main_lzd_kroq_gar"] = {
          { "mission", "wh2_main_anc_enchanted_item_hand_of_gods",     "wh3_main_ie_qb_liz_kroq_gar_hand_of_gods",             12, nil, "war.camp.advice.quest.kroqgar.hand_of_gods.001",             35,  392 },
          { "mission", "wh2_main_anc_weapon_revered_spear_of_tlanxla", "wh3_main_ie_qb_liz_kroq_gar_revered_spear_of_tlanxla", 7,  nil, "war.camp.advice.quest.kroqgar.revered_spear_of_tlanxla.001", 153, 229 },
     },
     ["wh2_dlc12_lzd_tehenhauin"] = {
          { "mission", "wh2_dlc12_anc_enchanted_item_plaque_of_sotek", "wh3_main_ie_qb_lzd_tehenhauin_plaque_of_sotek", 7, nil, "war.camp.advice.quests.001", 107, 201 },
     },
     ["wh2_dlc12_lzd_tiktaqto"] = {
          { "mission", "wh2_dlc12_anc_enchanted_item_mask_of_heavens", "wh3_main_ie_qb_lzd_tiktaqto_mask_of_heavens", 7, nil, "war.camp.advice.quests.001", 331, 191 },
     },
     ["wh2_dlc13_lzd_nakai"] = {
          { "mission", "wh2_dlc13_anc_enchanted_item_golden_tributes", "wh3_main_ie_qb_lzd_nakai_golden_tributes", 7,  nil, "war.camp.advice.quests.001", 105, 195 },
          { "mission", "wh2_dlc13_talisman_the_ogham_shard",           "wh3_main_ie_qb_lzd_nakai_the_ogham_shard", 10, nil, nil,                          227, 566 },
     },
     ["wh2_dlc13_lzd_gor_rok"] = {
          { "mission", "wh2_dlc13_anc_armour_the_shield_of_aeons", "wh3_main_ie_qb_lzd_gorrok_the_shield_of_aeons", 7, nil, "war.camp.advice.quests.001", 107, 201 },
          { "mission", "wh2_dlc13_anc_weapon_mace_of_ulumak",      "wh3_main_ie_qb_lzd_the_mace_of_ulumak",         3 }
     },
     ["wh2_dlc17_lzd_oxyotl"] = {
          { "mission", "wh2_dlc17_anc_weapon_the_golden_blowpipe_of_ptoohee", "wh3_main_ie_qb_lzd_oxyotl_the_golden_blowpipe_of_ptoohee", 7, nil, "war.camp.advice.quests.001", 248, 679 },
     },

     ----------------------
     ------- SKAVEN -------
     ----------------------
     ["wh2_main_skv_queek_headtaker"] = {
          { "mission", "wh2_main_anc_armour_warp_shard_armour", "wh3_main_ie_qb_skv_queek_headtaker_warp_shard_armour", 7,  nil, "war.camp.advice.quest.queek.warp_shard_armour.001", 398, 246 },
          { "mission", "wh2_main_anc_weapon_dwarf_gouger",      "wh3_main_ie_qb_skv_queek_headtaker_dwarfgouger",       12, nil, "war.camp.advice.quest.queek.dwarfgouger.001",       486, 297 },
     },
     ["wh2_main_skv_lord_skrolk"] = {
          { "mission", "wh2_main_anc_arcane_item_the_liber_bubonicus", "wh3_main_ie_qb_skv_skrolk_liber_bubonicus",   7,  nil, "war.camp.advice.quest.skrolk.liber_bubonicus.001",   114, 155 },
          { "mission", "wh2_main_anc_weapon_rod_of_corruption",        "wh3_main_ie_qb_skv_skrolk_rod_of_corruption", 12, nil, "war.camp.advice.quest.skrolk.rod_of_corruption.001", 44,  287 },
     },
     ["wh2_dlc09_skv_tretch_craventail"] = {
          { "mission", "wh2_dlc09_anc_enchanted_item_lucky_skullhelm", "wh3_main_ie_qb_skv_tretch_lucky_skullhelm", 7, nil, "dlc09.camp.advice.quest.tretch.lucky_skullhelm.001", 75, 523 },
     },
     ["wh2_dlc12_skv_ikit_claw"] = {
          { "mission", "wh2_dlc12_anc_weapon_storm_daemon", "wh3_main_ie_qb_ikit_claw_storm_daemon", 7, nil, "war.camp.advice.quests.001", 97, 270 },
     },
     ["wh2_dlc14_skv_deathmaster_snikch"] = {
          { "mission", "wh2_dlc14_anc_armour_the_cloak_of_shadows",    "wh3_main_ie_qb_skv_snikch_the_cloak_of_shadows",    7, nil, "war.camp.advice.quests.001", 546, 278 },
          { "mission", "wh2_dlc14_anc_weapon_whirl_of_weeping_blades", "wh3_main_ie_qb_skv_snikch_whirl_of_weeping_blades", 3 },
     },
     ["wh2_dlc16_skv_throt_the_unclean"] = {
          { "mission", "wh2_dlc16_anc_enchanted_item_whip_of_domination", "wh3_main_ie_qb_skv_throt_main_whip_of_domination", 7, nil, "war.camp.advice.quests.001", 462, 618 },
          { "mission", "wh2_dlc16_anc_weapon_creature_killer",            "wh3_main_ie_qb_skv_throt_main_creature_killer",    3 },
     },

     ----------------------
     ----- TOMB KINGS -----
     ----------------------
     ["wh2_dlc09_tmb_settra"] = {
          { "mission", "wh2_dlc09_anc_enchanted_item_the_crown_of_nehekhara", "wh3_main_ie_qb_tmb_settra_the_crown_of_nehekhara",    7,  nil, "dlc09.camp.advice.quest.settra.the_crown_of_nehekhara.001",    329, 601 },
          { "mission", "wh2_dlc09_anc_weapon_the_blessed_blade_of_ptra",      "wh3_main_ie_qb_tmb_settra_the_blessed_blade_of_ptra", 12, nil, "dlc09.camp.advice.quest.settra.the_blessed_blade_of_ptra.001", 474, 239 },
     },
     ["wh2_dlc09_tmb_arkhan"] = {
          { "mission", "wh2_dlc09_anc_weapon_the_tomb_blade_of_arkhan", "wh3_main_ie_qb_tmb_arkhan_the_tomb_blade_of_arkhan", 7,  nil, "dlc09.camp.advice.quest.arkhan.the_tomb_blade_of_arkhan.001", 362, 168 },
          { "mission", "wh2_dlc09_anc_arcane_item_staff_of_nagash",     "wh3_main_ie_qb_tmb_arkhan_the_staff_of_nagash",      12, nil, "dlc09.camp.advice.quest.arkhan.the_staff_of_nagash.001",      370, 218 },
     },
     ["wh2_dlc09_tmb_khatep"] = {
          { "mission", "wh2_dlc09_anc_arcane_item_the_liche_staff", "wh3_main_ie_qb_tmb_khatep_the_liche_staff", 7, nil, "dlc09.camp.advice.quest.khatep.the_liche_staff.001", 16, 571 },
     },
     ["wh2_dlc09_tmb_khalida"] = {
          { "mission", "wh2_dlc09_anc_weapon_the_venom_staff", "wh3_main_ie_qb_tmb_khalida_venom_staff", 12, nil, "dlc09.camp.advice.quest.khalida.venom_staff.001", 434, 221 },
     },

     ----------------------
     ---- VAMPIRE COAST ---
     ----------------------
     ["wh2_dlc11_cst_harkon"] = {
          { "mission", "wh2_dlc11_anc_enchanted_item_slann_gold", "wh3_main_ie_qb_cst_harkon_quest_for_slann_gold", 12, nil, "wh2_dlc11.camp.advice.quest.harkon.001", 89, 354 },
     },
     ["wh2_dlc11_cst_noctilus"] = {
          { "mission", "wh2_dlc11_anc_enchanted_item_captain_roths_moondial", "wh3_main_ie_qb_cst_noctilus_captain_roths_moondial", 12, nil, "wh2_dlc11.camp.advice.quest.noctilus.001", 220, 230 },
     },
     ["wh2_dlc11_cst_aranessa"] = {
          { "mission", "wh2_dlc11_anc_weapon_krakens_bane", "wh3_main_ie_qb_cst_aranessa_krakens_bane", 12, nil, "wh2_dlc11.camp.advice.quest.aranessa.001", 260, 590 },
     },
     ["wh2_dlc11_cst_cylostra"] = {
          { "mission", "wh2_dlc11_anc_arcane_item_the_bordeleaux_flabellum", "wh3_main_ie_qb_cst_cylostra_the_bordeleaux_flabellum", 7, nil, "wh2_dlc11.camp.advice.quest.cylostra.001", 218, 492 },
     },

     ----------------------
     ------- KISLEV -------
     ----------------------
     ["wh3_main_ksl_katarin"] = {
          { "mission", "wh3_main_anc_weapon_frost_fang",        "wh3_main_ie_qb_ksl_katarin_frost_fang",    7 },
          { "mission", "wh3_main_anc_armour_the_crystal_cloak", "wh3_main_ie_qb_ksl_katarin_crystal_cloak", 10, nil, "wh3_main_camp_quest_katarin_the_crystal_cloak_001", 497, 698 }
     },
     ["wh3_main_ksl_kostaltyn"] = {
          { "mission", "wh3_main_anc_weapon_the_burning_brazier", "wh3_main_ie_qb_ksl_kostaltyn_burning_brazier", 10, nil, "wh3_main_camp_quest_kostaltyn_burning_brazier_001", 417, 610 }
     },
     ["wh3_main_ksl_boris"] = {
          { "mission", "wh3_main_anc_weapon_shard_blade",     "wh3_main_ie_qb_ksl_boris_shard_blade",     7 },
          { "mission", "wh3_main_anc_armour_armour_of_ursun", "wh3_main_ie_qb_ksl_boris_armour_of_ursun", 10 }
     },

     ----------------------
     ---- OGRE KINGDOMS ---
     ----------------------
     ["wh3_main_ogr_greasus_goldtooth"] = {
          { "mission", "wh3_main_anc_weapon_sceptre_of_titans",   "wh3_main_ie_qb_ogr_greasus_sceptre_of_titans", 7 },
          { "mission", "wh3_main_anc_talisman_overtyrants_crown", "wh3_main_ie_qb_ogr_greasus_overtyrants_crown", 10, nil, "wh3_main_camp_quest_greasus_overtyrants_crown_001", 665, 432 }
     },
     ["wh3_main_ogr_skrag_the_slaughterer"] = {
          { "mission", "wh3_main_anc_enchanted_item_cauldron_of_the_great_maw", "wh3_main_ie_qb_ogr_skrag_cauldron_of_the_great_maw", 10, nil, "wh3_main_camp_quest_skrag_cauldron_of_the_great_maw_001", 647, 544 }
     },

     ----------------------
     -------- KHORNE ------
     ----------------------
     ["wh3_main_kho_skarbrand"] = {
          { "mission", "wh3_main_anc_weapon_slaughter_and_carnage", "wh3_main_ie_qb_kho_skarbrand_slaughter_and_carnage", 10, nil, "wh3_main_camp_quest_skarbrand_slaughter_and_carnage_001", 528, 670 }
     },

     ----------------------
     -------- NURGLE ------
     ----------------------
     ["wh3_main_nur_kugath"] = {
          { "mission", "wh3_main_anc_weapon_necrotic_missiles", "wh3_main_ie_qb_nur_kugath_necrotic_missiles", 10, nil, "wh3_main_camp_quest_kugath_necrotic_missiles_001", 585, 588 }
     },

     ----------------------
     ------- SLAANESH -----
     ----------------------
     ["wh3_main_sla_nkari"] = {
          { "mission", "wh3_main_anc_weapon_witstealer_sword", "wh3_main_ie_qb_sla_nkari_witstealer_sword", 10, nil, "wh3_main_camp_quest_nkari_witstealer_sword_001", 264, 626 }
     },

     ----------------------
     ------- TZEENCH ------
     ----------------------
     ["wh3_main_tze_kairos"] = {
          { "mission", "wh3_main_anc_arcane_item_staff_of_tomorrow", "wh3_main_ie_qb_tze_kairos_staff_of_tomorrow", 10, nil, "wh3_main_camp_quest_kairos_staff_of_tomorrow_001", 490, 711 }
     },

     ----------------------
     -------- MIXU --------
     ----------------------
     ["brt_adalhard"] = {
          { "", "mixu_anc_armour_brt_adalhard_lions_cloak", "", 12 }
     },
     ["brt_bohemond"] = {
          { "", "mixu_anc_armour_brt_bohemond_bohemonds_shield", "", 12 }
     },
     ["brt_chilfroy"] = {
          { "", "mixu_anc_weapon_brt_chilfroy_lance_of_artois",                   "", 13 },
          { "", "mixu_anc_enchanted_item_brt_chilfroy_antlers_of_the_great_hunt", "", 9 }
     },
     ["brt_cassyon"] = {
          { "", "mixu_anc_weapon_brt_cassyon_the_glorfinial", "", 13 }
     },
     ["mixu_elspeth_von_draken"] = {
          { "", "mixu_anc_weapon_emp_elspeth_von_draken_the_pale_scythe",        "", 17 },
          { "", "mixu_anc_arcane_item_emp_elspeth_von_draken_deaths_timekeeper", "", 12 }
     },
     ["emp_theoderic_gausser"] = {
          { "", "mixu_anc_enchanted_item_emp_theoderic_gausser_sea_dragon_cloak", "", 10 }
     },
     ["wef_daith"] = {
          { "", "mixu_anc_armour_wef_daith_the_oaken_armour", "", 15 }
     },
     ["dwf_kazador_dragonslayer"] = {
          { "", "mixu_anc_armour_dwf_kazador_dragonslayer_armour_of_karak_azul", "", 9 },
          { "", "mixu_anc_weapon_dwf_kazador_dragonslayer_hammer_karak_azul",    "", 15 }
     },
     ["emp_edward_van_der_kraal"] = {
          { "", "mixu_anc_enchanted_item_emp_edward_van_der_kraal_the_cursed_skull", "", 15 }
     },
     ["emp_theodore_bruckner"] = {
          { "", "mixu_anc_talisman_emp_theodore_bruckner_baleflame_amulet", "", 5 },
          { "", "mixu_anc_weapon_emp_theodore_bruckner_liarsbane",          "", 10 }
     },
     ["brt_almaric_de_gaudaron"] = {
          { "", "mixu_anc_talisman_brt_almaric_de_gaudaron_the_icon_of_the_lady", "", 10 }
     },
     ["wh_dlc03_emp_boris_todbringer"] = {
          { "", "mixu_anc_enchanted_item_emp_boris_todbringer_talisman_of_ulric", "", 15 }
     },
     ["emp_vorn_thugenheim"] = {
          { "", "mixu_anc_talisman_emp_vorn_thugenheim_heart_of_middenheim",   "", 15 },
          { "", "mixu_anc_enchanted_item_emp_vorn_thugenheim_pelt_of_horrors", "", 10 }
     },
     ["emp_wolfram_hertwig"] = {
          { "", "mixu_anc_talisman_emp_wolfram_hertwig_kislevite_icon", "", 14 }
     }

}

local im_missing_anc = {
     ["wh2_dlc10_hef_alarielle"] = {
          { "", "wh2_dlc10_anc_magic_standard_banner_of_avelorn", "", 1 },
          { "", "wh2_dlc10_anc_arcane_item_stave_of_avelorn",     "", 1 }
     },
     ["wh2_dlc12_skv_ikit_claw"] = {
          { "", "wh2_dlc12_anc_armour_iron_frame", "", 1 }
     },
     ["wh_dlc06_grn_skarsnik"] = {
          { "", "wh_dlc06_anc_magic_standard_skarsniks_boyz", "", 1 }
     },
     ["wh2_dlc12_lzd_tehenhauin"] = {
          { "", "wh2_dlc12_anc_weapon_blade_of_the_serpents_tongue", "", 1 }
     },
     ["wh_main_grn_grimgor_ironhide"] = {
          { "", "wh_main_anc_magic_standard_da_immortulz", "", 1 }
     },
     ["wh2_main_hef_prince_alastar"] = {
          { "", "wh2_main_anc_armour_lions_pelt", "", 1 }
     },
     ["wh_dlc03_emp_boris_todbringer"] = {
          { "", "wh_main_anc_talisman_the_white_cloak_of_ulric", "", 1 }
     },
     ["wh2_dlc10_hef_alith_anar"] = {
          { "", "wh2_dlc10_anc_talisman_stone_of_midnight", "", 1 }
     },
     ["wh_main_vmp_heinrich_kemmler"] = {
          { "", "wh2_dlc11_anc_follower_vmp_the_ravenous_dead", "", 1 }
     },
     ["wh2_dlc12_lzd_tiktaqto"] = {
          { "", "wh2_dlc12_anc_weapon_the_blade_of_ancient_skies", "", 1 }
     },
     ["wh2_dlc11_cst_harkon"] = {
          { "", "wh2_dlc11_anc_follower_captain_drekla", "", 1 }
     },
     ["wh2_dlc15_hef_imrik"] = {
          { "", "wh2_dlc15_anc_weapon_star_lance", "", 1 }
     },
     ["wh2_twa03_def_rakarth"] = {
          { "", "wh2_twa03_anc_armour_beast_armour_of_karond_kar", "", 1 }
     },
     ["wh2_dlc17_dwf_thorek"] = {
          { "", "wh_main_anc_rune_master_rune_of_stoicism",       "", 1 },
          { "", "wh2_dlc17_anc_follower_dwf_kraggi",              "", 1 },
          { "", "wh2_dlc17_anc_rune_engineering_rune_of_burning", "", 1 }
     },
     ["wh2_dlc17_lzd_oxyotl"] = {
          { "", "wh2_dlc17_anc_banner_lzd_poison_fireblood_toxin",  "", 1 },
          { "", "wh2_dlc17_anc_banner_lzd_poison_toadskin_essence", "", 1 }
     },
     --new
     ["wh_pro02_vmp_isabella_von_carstein_hero"] = {
          { "", "wh_pro02_anc_enchanted_item_blood_chalice_of_bathori", "", 1 }
     },
     ["wh_dlc04_vmp_vlad_von_carstein_hero"] = {
          { "", "wh_dlc04_anc_talisman_the_carstein_ring", "", 1 },
          { "", "wh_dlc04_anc_weapon_blood_drinker",       "", 1 }
     }
}

local subtype_immortality = {
     --["wh_dlc03_emp_boris_todbringer"] = true,
     --["wh_dlc05_vmp_red_duke"] = true,
     --["wh2_main_hef_prince_alastar"] = true -- no longer needed (the empire undivided update made him immortal)
     --["wh2_dlc09_tmb_arkhan"] = true,
     --["wh2_dlc09_tmb_khalida"] = true,
     --["wh2_dlc09_tmb_khatep"] = true,
     --["wh2_dlc09_tmb_settra"] = true,
     --["wh2_dlc11_cst_aranessa"] = true,
     --["wh2_dlc11_cst_cylostra"] = true,
     --["wh2_dlc11_cst_harkon"] = true,
     --["wh2_dlc11_cst_noctilus"] = true,
     --["wh3_dlc23_chd_zhatan"] = true,
     --["wh3_dlc23_chd_drazhoath"] = true,
     --["wh3_dlc23_chd_astragoth"] = true,
}

local names_of_power_traits = {
     "wh2_main_trait_def_name_of_power_co_01_blackstone",
     "wh2_main_trait_def_name_of_power_co_02_wyrmscale",
     "wh2_main_trait_def_name_of_power_co_03_poisonblade",
     "wh2_main_trait_def_name_of_power_co_04_headreaper",
     "wh2_main_trait_def_name_of_power_co_05_spiteheart",
     "wh2_main_trait_def_name_of_power_co_06_soulblaze",
     "wh2_main_trait_def_name_of_power_co_07_bloodscourge",
     "wh2_main_trait_def_name_of_power_co_08_griefbringer",
     "wh2_main_trait_def_name_of_power_co_09_the_hand_of_wrath",
     "wh2_main_trait_def_name_of_power_co_10_fatedshield",
     "wh2_main_trait_def_name_of_power_co_11_drakecleaver",
     "wh2_main_trait_def_name_of_power_co_12_hydrablood",
     "wh2_main_trait_def_name_of_power_ar_01_lifequencher",
     "wh2_main_trait_def_name_of_power_ar_02_the_tempest_of_talons",
     "wh2_main_trait_def_name_of_power_ar_03_shadowdart",
     "wh2_main_trait_def_name_of_power_ar_04_barbstorm",
     "wh2_main_trait_def_name_of_power_ar_05_beastbinder",
     "wh2_main_trait_def_name_of_power_ar_06_fangshield",
     "wh2_main_trait_def_name_of_power_ar_07_wrathbringer",
     "wh2_main_trait_def_name_of_power_ar_08_moonshadow",
     "wh2_main_trait_def_name_of_power_ar_09_granitestance",
     "wh2_main_trait_def_name_of_power_ar_10_the_grey_vanquisher",
     "wh2_main_trait_def_name_of_power_ar_11_krakenclaw",
     "wh2_main_trait_def_name_of_power_ar_12_grimgaze",
     "wh2_main_trait_def_name_of_power_ca_01_dreadtongue",
     "wh2_main_trait_def_name_of_power_ca_02_darkpath",
     "wh2_main_trait_def_name_of_power_ca_03_khainemarked",
     "wh2_main_trait_def_name_of_power_ca_04_the_black_conqueror",
     "wh2_main_trait_def_name_of_power_ca_05_leviathanrage",
     "wh2_main_trait_def_name_of_power_ca_06_emeraldeye",
     "wh2_main_trait_def_name_of_power_ca_07_barbedlash",
     "wh2_main_trait_def_name_of_power_ca_08_pathguard",
     "wh2_main_trait_def_name_of_power_ca_09_the_dark_marshall",
     "wh2_main_trait_def_name_of_power_ca_10_the_dire_overseer",
     "wh2_main_trait_def_name_of_power_ca_11_gatesmiter",
     "wh2_main_trait_def_name_of_power_ca_12_the_tormentor",
}

local subculture_chaos = {
     "wh_main_sc_chs_chaos",
     --"wh_dlc03_sc_bst_beastmen",
     --"wh3_dlc23_sc_chd_chaos_dwarfs",
     "wh_dlc08_sc_nor_norsca",
     "wh3_main_sc_dae_daemons",
     "wh3_main_sc_kho_khorne",
     "wh3_main_sc_nur_nurgle",
     "wh3_main_sc_sla_slaanesh",
     "wh3_main_sc_tze_tzeentch",
}

local chs_loreful_restrictions = {
     ["wh_main_chs_chaos"] = {
          subculture = {}, -- subcultures allowed to confederated "wh_main_chs_chaos"
          faction = {}   -- factions allowed to confederated "wh_main_chs_chaos"
     },
     ["wh3_main_chs_shadow_legion"] = {
          subculture = {},
          faction = {}
     },
     ["wh3_main_dae_daemon_prince"] = {
          subculture = {},
          faction = {}
     },
     ["wh3_dlc20_chs_vilitch"] = {
          subculture = { "wh3_main_sc_tze_tzeentch" },
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion" },
     },
     ["wh3_dlc20_chs_valkia"] = {
          subculture = { "wh3_main_sc_kho_khorne" },
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion" },
     },
     ["wh3_dlc20_chs_sigvald"] = {
          subculture = { "wh3_main_sc_sla_slaanesh" },
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion", "wh3_dlc20_chs_azazel" },
     },
     ["wh3_dlc20_chs_kholek"] = {
          subculture = {},
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion" },
     },
     ["wh3_dlc20_chs_festus"] = {
          subculture = { "wh3_main_sc_nur_nurgle" },
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion" },
     },
     ["wh3_dlc20_chs_azazel"] = {
          subculture = { "wh3_main_sc_sla_slaanesh" },
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion", "wh3_dlc20_chs_sigvald" },
     },
     ["wh3_main_sc_kho_khorne"] = {
          subculture = { "wh3_main_sc_kho_khorne" },
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion", "wh3_dlc20_chs_azazel" },
     },
     ["wh3_main_sc_nur_nurgle"] = {
          subculture = { "wh3_main_sc_nur_nurgle" },
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion", "wh3_dlc20_chs_festus" },
     },
     ["wh3_main_sc_sla_slaanesh"] = {
          subculture = { "wh3_main_sc_sla_slaanesh" },
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion", "wh3_dlc20_chs_sigvald", "wh3_dlc20_chs_azazel" },
     },
     ["wh3_main_sc_tze_tzeentch"] = {
          subculture = { "wh3_main_sc_tze_tzeentch" },
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion", "wh3_dlc20_chs_vilitch" },
     },
     ["wh_dlc08_sc_nor_norsca"] = {
          subculture = { "wh_dlc08_sc_nor_norsca" },
          faction = { "wh_main_chs_chaos", "wh3_main_dae_daemon_prince", "wh3_main_chs_shadow_legion" },
     },
}

local subculture_exempted = {
     --"wh_main_sc_chs_chaos",
     --"wh_dlc03_sc_bst_beastmen",
     --rogue
     "wh2_main_rogue",
     "wh2_main_rogue_chaos",
     --prologue
     "wh3_main_pro_sc_kho_khorne",
     "wh3_main_pro_sc_ksl_kislev",
     "wh3_main_pro_sc_tze_tzeentch",
     --mods
     "wh_main_sc_nor_warp",
     "wh_main_sc_nor_troll",
     "wh_main_sc_nor_albion",
     "wh_main_sc_lzd_amazon",
     "wh_main_sc_nor_fimir",
     --"wh3_dlc23_sc_chd_chaos_dwarfs",
}

local confed_restricted_subcultures = {
     -- by default
     --"wh2_dlc09_sc_tmb_tomb_kings",
     --"wh2_main_rogue",
     --"wh2_main_rogue_chaos",
     --"wh_main_sc_chs_chaos",
     --"wh_main_sc_grn_savage_orcs",
     --"wh_main_sc_teb_teb",
     --"wh2_dlc11_sc_cst_vampire_coast",
     --ovn
     --"wh_main_sc_emp_araby",
     --"wh_main_sc_nor_fimir",
}

local faction_exempted = {
     "wh2_dlc13_lzd_defenders_of_the_great_plan", --nakai vassal
     "wh2_dlc13_lzd_avengers",                   --wulfhart hostility mechanic
     "wh2_dlc10_def_blood_voyage",               --queen & crone mechanic
     "wh2_main_chs_chaos_incursion_def",         --cai_diplomacy_excluded_factions table
     "wh2_main_chs_chaos_incursion_hef",         --cai_diplomacy_excluded_factions table
     "wh2_main_chs_chaos_incursion_lzd",         --cai_diplomacy_excluded_factions table
     "wh2_main_chs_chaos_incursion_skv",         --cai_diplomacy_excluded_factions table
     "wh2_main_nor_hung_incursion_def",          --cai_diplomacy_excluded_factions table
     "wh2_main_nor_hung_incursion_hef",          --cai_diplomacy_excluded_factions table
     "wh2_main_nor_hung_incursion_lzd",          --cai_diplomacy_excluded_factions table
     "wh2_main_nor_hung_incursion_skv",          --cai_diplomacy_excluded_factions table
     "wh2_main_skv_unknown_clan_def",            --cai_diplomacy_excluded_factions table
     "wh2_main_skv_unknown_clan_hef",            --cai_diplomacy_excluded_factions table
     "wh2_main_skv_unknown_clan_lzd",            --cai_diplomacy_excluded_factions table
     "wh2_main_skv_unknown_clan_skv",            --cai_diplomacy_excluded_factions table
     "wh3_main_kho_brazen_throne",               --chaos realm
     "wh3_main_nur_bubonic_swarm",               --chaos realm
     "wh3_main_sla_rapturous_excess",            --chaos realm
     "wh3_main_tze_all_seeing_eye",              --chaos realm
     "wh3_main_rogue_shadow_legion",             --chaos realm
     "wh3_main_rogue_the_bloody_harvest",        --chaos realm
     "wh3_main_rogue_the_fluxion_host",          --chaos realm
     "wh3_main_rogue_the_pleasure_tide",         --chaos realm
     "wh3_main_rogue_the_putrid_swarm",          --chaos realm
     "_prologue",
     "_waaagh",
     "_brayherd",
     "wh_main_emp_empire_separatists",              --Empire Secessionists
     "wh3_main_cth_dissenter_lords_of_jinshen",     --zhao ming "rebels"
     "wh3_main_cth_rebel_lords_of_nan_yang",        --miao ying "rebels"
     "wh_main_chs_chaos_separatists",               --brt quest battle
     "wh2_dlc09_skv_clan_rictus_separatists",       --loyalty mechanic
     "wh2_dlc11_cst_noctilus_separatists",          --loyalty mechanic
     "wh2_dlc11_cst_pirates_of_sartosa_separatists", --loyalty mechanic
     "wh2_dlc11_cst_the_drowned_separatists",       --loyalty mechanic
     "wh2_dlc11_cst_vampire_coast_separatists",     --loyalty mechanic
     "wh2_dlc11_def_the_blessed_dread_separatists", --loyalty mechanic
     "wh2_main_def_cult_of_pleasure_separatists",   --loyalty mechanic
     "wh2_main_def_hag_graef_separatists",          --loyalty mechanic
     "wh2_main_def_har_ganeth_separatists",         --loyalty mechanic
     "wh2_main_def_naggarond_separatists",          --loyalty mechanic
     "wh2_main_skv_clan_eshin_separatists",         --loyalty mechanic
     "wh2_main_skv_clan_mors_separatists",          --loyalty mechanic
     "wh2_main_skv_clan_moulder_separatists",       --loyalty mechanic
     "wh2_main_skv_clan_pestilens_separatists",     --loyalty mechanic
     "wh2_main_skv_clan_skryre_separatists",        --loyalty mechanic
     "wh2_twa03_def_rakarth_separatists",           --loyalty mechanic
     "wh_main_nor_norsca_separatists",              --not used, I believe
     "wh_main_nor_norsca_separatists_sorcerer_lord", --not used, I believe
     "wh2_dlc11_brt_bretonnia_dil",                 --cst mission
     "wh2_dlc11_def_dark_elves_dil",                --cst mission
     "wh2_dlc11_emp_empire_dil",                    --cst mission
     "wh2_dlc11_nor_norsca_dil",                    --cst mission
     "wh2_dlc11_cst_vampire_coast_rebels",          --wulfhart mission
     "wh3_main_cth_rebel_lords_of_nan_yang",        --miao ying starting opponent
     "wh3_dlc21_vmp_jiangshi_rebels",               --nakai victory objective
     "wh3_dlc21_cst_dead_flag_fleet",               --nakai victory objective
     "_invasion",                                   --empire and world root invasion armies
     "_shanty",                                     --roving pirate and treasure map armies
     "wh_dlc08_chs_chaos_challenger_tzeentch",      --norscan gods mechanic
     "wh_dlc08_chs_chaos_challenger_slaanesh",      --norscan gods mechanic
     "wh_dlc08_chs_chaos_challenger_nurgle",        --norscan gods mechanic
     "wh_dlc08_chs_chaos_challenger_khorne",        --norscan gods mechanic
     --"wh3_main_cth_cathay_mp", --?
     --"wh2_dlc16_wef_waystone_faction_3", --?
     --"wh2_dlc16_wef_waystone_faction_2", --?
     --"wh2_dlc16_wef_waystone_faction_1", --?
     --"wh3_dlc23_chd_conclave", --can't receive chd lls for some reason?!
     --"wh3_dlc23_chd_minor_faction", --can't receive chd lls for some reason?!
     --"wh3_dlc24_tze_the_deceivers",
}

local faction_seccessionists = {
     "wh2_dlc09_skv_clan_rictus_separatists",       --loyalty mechanic
     "wh2_dlc11_cst_noctilus_separatists",          --loyalty mechanic
     "wh2_dlc11_cst_pirates_of_sartosa_separatists", --loyalty mechanic
     "wh2_dlc11_cst_the_drowned_separatists",       --loyalty mechanic
     "wh2_dlc11_cst_vampire_coast_separatists",     --loyalty mechanic
     "wh2_dlc11_def_the_blessed_dread_separatists", --loyalty mechanic
     "wh2_main_def_cult_of_pleasure_separatists",   --loyalty mechanic
     "wh2_main_def_hag_graef_separatists",          --loyalty mechanic
     "wh2_main_def_har_ganeth_separatists",         --loyalty mechanic
     "wh2_main_def_naggarond_separatists",          --loyalty mechanic
     "wh2_main_skv_clan_eshin_separatists",         --loyalty mechanic
     "wh2_main_skv_clan_mors_separatists",          --loyalty mechanic
     "wh2_main_skv_clan_moulder_separatists",       --loyalty mechanic
     "wh2_main_skv_clan_pestilens_separatists",     --loyalty mechanic
     "wh2_main_skv_clan_skryre_separatists",        --loyalty mechanic
     "wh2_twa03_def_rakarth_separatists",           --loyalty mechanic
}

local bundle_confederation = {
     "wh2_main_bundle_confederation_skv",
     "wh2_main_bundle_confederation_lzd",
     "wh2_main_bundle_confederation_hef",
     "wh2_main_bundle_confederation_def",
     "wh_main_bundle_confederation_grn",
     "wh_main_bundle_confederation_vmp",
     "wh_main_bundle_confederation_dwf",
     "wh_main_bundle_confederation_emp",
     "wh_main_bundle_confederation_brt",
     "wh_main_bundle_confederation_wef",
     "wh_dlc03_beastmen_confederation_help",
     "wh3_main_bundle_confederation_cth",
     "wh3_main_bundle_confederation_dae",
     "wh3_main_bundle_confederation_kho",
     "wh3_main_bundle_confederation_nur",
     "wh3_main_bundle_confederation_ogr",
     "wh3_main_bundle_confederation_sla",
     "wh3_main_bundle_confederation_tze",
     "wh3_dlc23_bundle_confederation_chd",
}

local bret_confederation_tech = {
     { tech = "wh_dlc07_tech_brt_heraldry_artois",      faction = "wh_main_brt_artois" },
     { tech = "wh_dlc07_tech_brt_heraldry_bastonne",    faction = "wh_main_brt_bastonne" },
     { tech = "wh_dlc07_tech_brt_heraldry_bordeleaux",  faction = "wh_main_brt_bordeleaux" },
     { tech = "wh_dlc07_tech_brt_heraldry_bretonnia",   faction = "wh_main_brt_bretonnia" },
     { tech = "wh_dlc07_tech_brt_heraldry_carcassonne", faction = "wh_main_brt_carcassonne" },
     { tech = "wh_dlc07_tech_brt_heraldry_lyonesse",    faction = "wh_main_brt_lyonesse" },
     { tech = "wh_dlc07_tech_brt_heraldry_parravon",    faction = "wh_main_brt_parravon" },
     { tech = "wh3_main_tech_brt_heraldry_aquitaine",   faction = "wh3_main_brt_aquitaine" }
}

local function sm0_log_reset()
     if not __write_output_to_logfile then
          return
     end
     local logTimeStamp = os.date("%d, %m %Y %X")
     local popLog = io.open("sm0_log.txt", "w+")
     popLog:write("NEW LOG [" .. logTimeStamp .. "] \n")
     popLog:flush()
     popLog:close()
end

---@param text string
local function sm0_log(text)
     if not __write_output_to_logfile then
          return
     end
     local logText = tostring(text)
     local logTimeStamp = os.date("%d, %m %Y %X")
     local popLog = io.open("sm0_log.txt", "a")
     local faction = cm:whose_turn_is_it():item_at(0):name()
     popLog:write("RD:  [" ..
     logTimeStamp ..
     "] [Turn: " .. tostring(cm:model():turn_number()) .. "(" .. tostring(faction) .. ")]:  " .. logText .. "  \n")
     popLog:flush()
     popLog:close()
end

local function RDDEBUG()
     if not __write_output_to_logfile then
          return
     end
     --Vanish's PCaller
     --All credits to vanish
     local function safeCall(func)
          --out("safeCall start")
          local status, result = pcall(func)
          if not status then
               sm0_log("ERROR")
               sm0_log(tostring(result))
               sm0_log(debug.traceback())
          end
          --out("safeCall end")
          return result
     end

     --local oldTriggerEvent = core.trigger_event

     local function pack2(...) return { n = select('#', ...), ... } end
     local function unpack2(t) return unpack(t, 1, t.n) end

     local function wrapFunction(f, argProcessor)
          return function(...)
               --out("start wrap ")
               local someArguments = pack2(...)
               if argProcessor then
                    safeCall(function() argProcessor(someArguments) end)
               end
               local result = pack2(safeCall(function() return f(unpack2(someArguments)) end))
               --for k, v in pairs(result) do
               --    out("Result: " .. tostring(k) .. " value: " .. tostring(v))
               --end
               --out("end wrap ")
               return unpack2(result)
          end
     end

     -- function myTriggerEvent(event, ...)
     --     local someArguments = { ... }
     --     safeCall(function() oldTriggerEvent(event, unpack( someArguments )) end)
     -- end

     local function tryRequire(fileName)
          local loaded_file = loadfile(fileName)
          if not loaded_file then
               out("Failed to find mod file with name " .. fileName)
          else
               out("Found mod file with name " .. fileName)
               out("Load start")
               local local_env = getfenv(1)
               setfenv(loaded_file, local_env)
               loaded_file()
               out("Load end")
          end
     end

     local function logFunctionCall(f, name)
          return function(...)
               out("function called: " .. name)
               return f(...)
          end
     end

     local function logAllObjectCalls(object)
          local metatable = getmetatable(object)
          for name, f in pairs(getmetatable(object)) do
               if is_function(f) then
                    out("Found " .. name)
                    if name == "Id" or name == "Parent" or name == "Find" or name == "Position" or name == "CurrentState" or name == "Visible" or name == "Priority" or "Bounds" then
                         --Skip
                    else
                         metatable[name] = logFunctionCall(f, name)
                    end
               end
               if name == "__index" and not is_function(f) then
                    for indexname, indexf in pairs(f) do
                         out("Found in index " .. indexname)
                         if is_function(indexf) then
                              f[indexname] = logFunctionCall(indexf, indexname)
                         end
                    end
                    out("Index end")
               end
          end
     end

     -- logAllObjectCalls(core)
     -- logAllObjectCalls(cm)
     -- logAllObjectCalls(game_interface)

     core.trigger_event = wrapFunction(
          core.trigger_event,
          function(ab)
               --out("trigger_event")
               --for i, v in pairs(ab) do
               --    out("i: " .. tostring(i) .. " v: " .. tostring(v))
               --end
               --out("Trigger event: " .. ab[1])
          end
     )

     cm.check_callbacks = wrapFunction(
          cm.check_callbacks,
          function(ab)
               --out("check_callbacks")
               --for i, v in pairs(ab) do
               --    out("i: " .. tostring(i) .. " v: " .. tostring(v))
               --end
          end
     )

     local currentAddListener = core.add_listener
     local function myAddListener(core, listenerName, eventName, conditionFunc, listenerFunc, persistent)
          local wrappedCondition = nil
          if is_function(conditionFunc) then
               --wrappedCondition =  wrapFunction(conditionFunc, function(arg) out("Callback condition called: " .. listenerName .. ", for event: " .. eventName) end)
               wrappedCondition = wrapFunction(conditionFunc)
          else
               wrappedCondition = conditionFunc
          end
          currentAddListener(
               core, listenerName, eventName, wrappedCondition, wrapFunction(listenerFunc), persistent
          --core, listenerName, eventName, wrappedCondition, wrapFunction(listenerFunc, function(arg) out("Callback called: " .. listenerName .. ", for event: " .. eventName) end), persistent
          )
     end
     core.add_listener = myAddListener
end

---@param faction FACTION_SCRIPT_INTERFACE
local function immortality_backup(faction)
     local char_list = faction:character_list()
     for i = 0, char_list:num_items() - 1 do
          local char = char_list:item_at(i)
          if subtype_immortality[char:character_subtype_key()] then
               sm0_log("immortality_backup: " .. tostring(char:character_subtype_key()))
               cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), true)
          end
     end
end

---@param faction FACTION_SCRIPT_INTERFACE
local function equip_quest_anc(faction)
     local missing_anc = {}
     local subtype_anc = {}
     --if cm:get_campaign_name() == "main_warhammer" then
     --    missing_anc = me_missing_anc
     --    subtype_anc = me_subtype_anc
     --elseif cm:get_campaign_name() == "wh2_main_great_vortex" then
     --    missing_anc = vor_missing_anc
     --    subtype_anc = vor_subtype_anc
     if cm:get_campaign_name() == "main_warhammer" then --"main_warhammer" --"wh3_main_combi"
          subtype_anc = im_subtype_anc
          missing_anc = im_missing_anc
     elseif cm:get_campaign_name() == "wh3_main_chaos" then
          subtype_anc = chs_subtype_anc
     elseif cm:get_campaign_name() == "wh3_main_prologue" then
          --prologue
     end
     local char_list = faction:character_list()
     for i = 0, char_list:num_items() - 1 do
          local current_char = char_list:item_at(i)
          if missing_anc[current_char:character_subtype_key()] then
               local ancillaries = missing_anc[current_char:character_subtype_key()]
               for j = 1, #ancillaries do
                    local current_ancillary = ancillaries[j]
                    local current_ancillary_key = current_ancillary[2]
                    cm:force_add_ancillary(current_char, current_ancillary_key, true, true)
               end
          end
          if subtype_anc[current_char:character_subtype_key()] then
               local quests = subtype_anc[current_char:character_subtype_key()]
               for j = 1, #quests do
                    local current_quest_record = quests[j]
                    local current_ancillary_key = current_quest_record[2]
                    local current_rank_req = current_quest_record[4]
                    if current_char:rank() >= current_rank_req and not current_char:has_ancillary(current_ancillary_key) then --and current_char:faction():ancillary_exists(current_ancillary_key)
                         cm:force_add_ancillary(current_char, current_ancillary_key, true, true)
                    end
               end
          end
     end
end

---@param quests table
---@param subtype string
local function ancillary_on_rankup(quests, subtype)
     for i = 1, #quests do
          local current_quest = quests[i]
          local ancillary = current_quest[1]
          local rank = current_quest[2]
          core:add_listener(
               "sm0" .. ancillary .. "_CharacterTurnStart",
               "CharacterTurnStart",
               function(context)
                    return context:character():character_subtype(subtype) and context:character():rank() >= rank and
                    not context:character():has_ancillary(ancillary)
               end,
               function(context)
                    cm:force_add_ancillary(context:character(), ancillary, true, false)
               end,
               false
          )
     end
end

---@param faction FACTION_SCRIPT_INTERFACE
---@return boolean
local function are_lords_missing(faction)
     for i = 1, #locked_ai_generals do
          if faction:name() == locked_ai_generals[i].faction and not cm:get_saved_value(locked_ai_generals[i].subtype .. "_spawned") then
               local char_list = faction:character_list()
               local char_found = false
               for j = 0, char_list:num_items() - 1 do
                    local current_char = char_list:item_at(j)
                    if current_char:character_subtype_key() == locked_ai_generals[i].subtype then
                         cm:set_saved_value(locked_ai_generals[i].subtype .. "_spawned", faction:name())
                         char_found = true
                    end
               end
               if not char_found then
                    local factions_of_same_subculture = faction:factions_of_same_subculture()
                    for j = 0, factions_of_same_subculture:num_items() - 1 do
                         local current_faction = factions_of_same_subculture:item_at(j)
                         local char_list = current_faction:character_list()
                         for k = 0, char_list:num_items() - 1 do
                              local current_char = char_list:item_at(k)

                              if current_char:character_subtype_key() == locked_ai_generals[i].subtype then
                                   cm:set_saved_value(locked_ai_generals[i].subtype .. "_spawned", current_faction:name())
                                   char_found = true
                              end
                         end
                    end
               end
               return not char_found and
               (not is_string(locked_ai_generals[i].dlc) or (is_string(locked_ai_generals[i].dlc) and cm:is_dlc_flag_enabled(locked_ai_generals[i].dlc, faction:name())))
          end
     end
end

-- pre empire undivided spawn location check
---@param x number
---@param y number
---@return bool
local function is_valid_spawn_coordinate(x, y)
     local is_valid = true
     if is_number(x) and is_number(y) and x ~= -1 and y ~= -1 then
          --local faction_list = cm:model():world():faction_list()
          --for i = 0, faction_list:num_items() - 1 do
          --    local current_faction = faction_list:item_at(i)
          --    local char_list = current_faction:character_list()
          --    for j = 0, char_list:num_items() - 1 do
          --        local current_char = char_list:item_at(j)
          --        if current_char:logical_position_x() == x and current_char:logical_position_y() == y then
          --            is_valid = false
          --            --sm0_log("char_list/is_valid: false")
          --            break
          --        end
          --    end
          --    if is_valid then
          --        local region_list = current_faction:region_list()
          --        for j = 0, region_list:num_items() - 1 do
          --            local current_region = region_list:item_at(j)
          --            if current_region:settlement():logical_position_x() == x and current_region:settlement():logical_position_y() == y then
          --                is_valid = false
          --                --sm0_log("current_region/is_valid: false")
          --                break
          --            end
          --        end
          --    end
          --end
     else
          is_valid = false
     end
     return is_valid
end

-- pre empire undivided spawn location search
---@param faction FACTION_SCRIPT_INTERFACE
---@param x number
---@param y number
---@return number, number
local function find_valid_spawn_coordinates(faction, x, y)
     if not is_faction(faction) then
          sm0_log("ERROR: find_valid_spawn_coordinates() called but supplied faction [" ..
          tostring(faction) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end
     if not is_number(x) then
          sm0_log("ERROR: find_valid_spawn_coordinates() called but supplied x [" .. tostring(x) .. "] is not a number.")
          return
     end
     if not is_number(y) then
          sm0_log("ERROR: find_valid_spawn_coordinates() called but supplied y [" .. tostring(y) .. "] is not a number.")
          return
     end
     -- Written by Vandy.
     local spawn_X, spawn_Y = cm:find_valid_spawn_location_for_character_from_position(faction, x, y, true)
     --sm0_log("find_valid_spawn_coordinates: x="..tostring(spawn_X)..", y="..tostring(spawn_Y))
     local valid = false
     while not valid do
          if is_valid_spawn_coordinate(spawn_X, spawn_Y) then
               valid = true
               break
          end
          local square = { x - 10, x + 10, y - 10, y + 10 }
          spawn_X, spawn_Y = cm:find_valid_spawn_location_for_character_from_position(faction,
               cm:random_number(square[2], square[1]), cm:random_number(square[4], square[3]), true)
          --sm0_log("while not valid: x="..tostring(spawn_X)..", y="..tostring(spawn_Y))
     end
     --sm0_log("return: x="..tostring(spawn_X)..", y="..tostring(spawn_Y))
     return spawn_X, spawn_Y
end

---@param confederator FACTION_SCRIPT_INTERFACE
---@param confederated FACTION_SCRIPT_INTERFACE
local function spawn_missing_lords(confederator, confederated)
     local start_region --confederator:region_list():item_at(0)
     local x, y
     --if start_region then sm0_log("spawn_missing_lords 1: "..confederator:name().." | Region: "..start_region:name()) end
     if confederator:has_home_region() then
          start_region = confederator:home_region()
          --if start_region then sm0_log("spawn_missing_lords 2: "..confederator:name().." | Region: "..start_region:name()) end
          x, y = cm:find_valid_spawn_location_for_character_from_settlement(confederator:name(), start_region:name(),
               false, true, 9)
          --sm0_log("find_valid_spawn_location_for_character_from_settlement: x="..tostring(x)..", y="..tostring(y))
     else
          if not confederator:military_force_list():item_at(0):general_character():is_at_sea() and confederator:military_force_list():item_at(0):general_character():has_region() then
               start_region = confederator:military_force_list():item_at(0):general_character():region()
          else
               sm0_log("ERROR: Could not find valid region!")
               return
          end
     end
     if not is_valid_spawn_coordinate(x, y) or not confederator:has_home_region() then
          --x, y = cm:find_valid_spawn_location_for_character_from_position(confederator:name(), confederator:military_force_list():item_at(0):general_character():logical_position_x() + 1, confederator:military_force_list():item_at(0):general_character():logical_position_y(), true)
          local char_lookup = cm:char_lookup_str(confederator:military_force_list():item_at(0):general_character())
          x, y = cm:find_valid_spawn_location_for_character_from_character(confederator:name(), char_lookup, true, 9)
          --sm0_log("find_valid_spawn_location_for_character_from_position: x="..tostring(x)..", y="..tostring(y))
     end
     if not is_valid_spawn_coordinate(x, y) then
          -- CA's method did not provide a valid position, try Vandy's method instead
          local spawn_x, spawn_y
          if confederator:has_home_region() then
               spawn_x = confederator:home_region():settlement():logical_position_x()
               spawn_y = confederator:home_region():settlement():logical_position_y()
          else
               spawn_x = confederator:military_force_list():item_at(0):general_character():logical_position_x()
               spawn_y = confederator:military_force_list():item_at(0):general_character():logical_position_y()
          end
          if is_valid_spawn_coordinate(spawn_x, spawn_y) then x, y = find_valid_spawn_coordinates(confederator:name(),
                    spawn_x, spawn_y) end
          --sm0_log("find_valid_spawn_coordinates: x="..tostring(x)..", y="..tostring(y))
     end
     --sm0_log("Trying to revive Faction: "..confederated:name().." | Region: "..start_region:name())
     if is_valid_spawn_coordinate(x, y) then
          local char_cqi
          cm:create_force(
               confederated:name(),
               "wh2_main_hef_inf_spearmen_0",
               start_region:name(),
               1000, --x
               700, --y
               true,
               function(cqi)
                    --sm0_log("spawn_missing_lords | Faction revived: "..confederated:name().." | Region: "..start_region:name().." | CQI: "..cqi)
                    char_cqi = cqi
                    --local char = cm:get_character_by_cqi(char_cqi)
                    --if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and not cm:get_saved_value("sm0_immortal_cqi"..char_cqi) then
                    --    cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
                    --		cm:set_character_immortality(cm:char_lookup_str(char_cqi), true)
                    --	end, 0.5)
                    --    cm:set_saved_value("sm0_immortal_cqi"..char_cqi, true)
                    --end

                    --spawn lords
                    if are_lords_missing(confederated) then
                         for i = 1, #locked_ai_generals do
                              if confederated:name() == locked_ai_generals[i].faction and not cm:get_saved_value(locked_ai_generals[i].subtype .. "_spawned") then
                                   if locked_ai_generals[i].id ~= "" and not cm:get_saved_value("ci_starting_generals_unlocked_ai") then
                                        cm:unlock_starting_general_recruitment(locked_ai_generals[i].id,
                                             locked_ai_generals[i].faction) end
                                   --sm0_log("spawn_missing_lords | are_lords_missing | char_found = "..tostring(char_found))
                                   for n = 1, 10 do
                                        if not cm:get_saved_value(locked_ai_generals[i].subtype .. "_spawned") then
                                             --sm0_log("spawn_missing_lords | are_lords_missing | cm:get_saved_value(locked_ai_generals[i].subtype..\"_spawned\") = "..tostring(cm:get_saved_value(locked_ai_generals[i].subtype.."_spawned")))
                                             x, y = cm:find_valid_spawn_location_for_character_from_position(
                                             confederated:name(), x, y, true, 7)
                                             -- backup
                                             if not is_valid_spawn_coordinate(x, y) then
                                                  -- CA's method did not provide a valid position, try Vandy's method instead
                                                  local spawn_x, spawn_y
                                                  if confederator:has_home_region() then
                                                       spawn_x = confederator:home_region():settlement()
                                                       :logical_position_x()
                                                       spawn_y = confederator:home_region():settlement()
                                                       :logical_position_y()
                                                  else
                                                       spawn_x = confederator:military_force_list():item_at(0)
                                                       :general_character():logical_position_x()
                                                       spawn_y = confederator:military_force_list():item_at(0)
                                                       :general_character():logical_position_y()
                                                  end
                                                  if is_valid_spawn_coordinate(spawn_x, spawn_y) then x, y =
                                                       find_valid_spawn_coordinates(confederator:name(), spawn_x, spawn_y) end
                                                  --sm0_log("find_valid_spawn_coordinates: x="..tostring(x)..", y="..tostring(y))
                                             end
                                             if is_valid_spawn_coordinate(x, y) then
                                                  cm:create_force(
                                                       confederated:name(),
                                                       "wh2_main_hef_inf_spearmen_0",
                                                       start_region:name(),
                                                       1000, --x
                                                       700, --y
                                                       false,
                                                       function(cqi)
                                                            local char = cm:get_character_by_cqi(cqi)
                                                            --sm0_log("["..n..".] spawn_lord | subtype: "..char:character_subtype_key().." | Forename: "..char:get_forename().." | Surname: "..char:get_surname().." | CQI: "..cqi)
                                                            for k = 1, #locked_ai_generals do
                                                                 if char:character_subtype(locked_ai_generals[k].subtype) and not cm:get_saved_value(locked_ai_generals[k].subtype .. "_spawned") then
                                                                      --cm:set_character_immortality(cm:char_lookup_str(cqi), true)
                                                                      sm0_log("[" ..
                                                                      n ..
                                                                      ".] spawn_missing_lords: " ..
                                                                      char:character_subtype_key() .. " spawned!")
                                                                      cm:set_saved_value(
                                                                      locked_ai_generals[k].subtype .. "_spawned",
                                                                           confederated:name())
                                                                 end
                                                            end
                                                            --if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and not cm:get_saved_value("sm0_immortal_cqi"..cqi) then
                                                            --    cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
                                                            --        cm:set_character_immortality(cm:char_lookup_str(cqi), true)
                                                            --    end, 0.1)
                                                            --    cm:set_saved_value("sm0_immortal_cqi"..cqi, true)
                                                            --end
                                                            cm:kill_character(cqi, true)
                                                            --cm:kill_character_and_commanded_unit(cm:char_lookup_str(cqi), true)
                                                            --if is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()] then cm:set_character_immortality(cm:char_lookup_str(cqi), false) end
                                                            --cm:callback(function()
                                                            --if char:is_wounded() then cm:stop_character_convalescing(cqi) end
                                                            --end, 0.5)
                                                            if n >= 10 or cm:get_saved_value(locked_ai_generals[i].subtype .. "_spawned") then
                                                                 if char_cqi and cm:get_character_by_cqi(char_cqi) then
                                                                      cm:kill_character(char_cqi, true) end
                                                                 --cm:kill_character_and_commanded_unit(cm:char_lookup_str(char_cqi), true)
                                                            end
                                                       end
                                                  )
                                             end
                                        end
                                   end
                              end
                         end
                    end
                    cm:callback(function()
                         kill_faction(confederated:name()) --backup
                         --cm:kill_all_armies_for_faction(confederated) --backup
                         cm:kill_character(char_cqi, true)
                         --cm:kill_character_and_commanded_unit(cm:char_lookup_str(char_cqi), true)
                         local char_list = confederated:character_list()
                         for i = 0, char_list:num_items() - 1 do
                              local char = char_list:item_at(i)
                              --if char then sm0_log("DEAD FACTION char: "..char:character_subtype_key()) end
                              if cm:char_is_agent(char) or cm:char_is_general(char) then
                                   cm:kill_character(char:command_queue_index(), true)
                                   --cm:kill_character_and_commanded_unit(cm:char_lookup_str(char:command_queue_index()), true)
                                   --if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
                                   --    cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), false)
                                   --    cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), false)
                                   --end
                              end
                         end
                    end, 2)
               end
          )
     else
          sm0_log("ERROR: Could not find valid spawn position!")
     end
end
---@param faction FACTION_SCRIPT_INTERFACE
---@return string | boolean
local function confed_penalty(faction)
     if not is_faction(faction) then
          sm0_log("ERROR: confed_penalty() called but supplied faction [" ..
          tostring(faction) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return false
     end

     local has_confed_bundle
     for i = 1, #bundle_confederation do
          if faction:has_effect_bundle(bundle_confederation[i]) then
               has_confed_bundle = bundle_confederation[i]
               break
          end
     end
     return has_confed_bundle
end

---@param confederator FACTION_SCRIPT_INTERFACE
---@param confederated FACTION_SCRIPT_INTERFACE
---@param character CHARACTER_SCRIPT_INTERFACE
---@param agents table
local function lord_events_mp(confederator, confederated, character, agents)
     for _, agent in ipairs(agents) do
          local subtype = agent.subtype

          if subtype == character:character_subtype_key() then
               --if subtype == character:character_subtype_key() and ((not is_string(agent.dlc) and not is_table(agent.dlc)) or (is_string(agent.dlc) and cm:is_dlc_flag_enabled(agent.dlc, confederator))
               --or (is_table(agent.dlc) and cm:is_dlc_flag_enabled(agent.dlc[1], confederator) and cm:is_dlc_flag_enabled(agent.dlc[2], confederator))) then
               --if is_table(agent.dlc) then
               --    for i = 1, #agent.dlc do
               --        sm0_log("agent.dlc["..i.."]: "..tostring(agent.dlc[i]).." == "..tostring(cm:is_dlc_flag_enabled(agent.dlc[i], confederator)))
               --    end
               --elseif is_string(agent.dlc) then
               --    sm0_log("agent.dlc: "..tostring(agent.dlc).." == "..tostring(cm:is_dlc_flag_enabled(agent.dlc, confederator)))
               --end
               for i = 1, #agent.dlc do
                    sm0_log("agent.dlc: " ..
                    tostring(agent.dlc[i]) .. " == " ..
                    tostring(cm:is_dlc_flag_enabled(agent.dlc[i], confederator:name())))
                    if not cm:is_dlc_flag_enabled(agent.dlc[i], confederator:name()) then
                         return
                    end
               end
               CampaignUI.TriggerCampaignScriptEvent(confederator:command_queue_index(),
                    "RD|" .. tostring(character:command_queue_index()) ..
                    ":" .. subtype .. ";" .. tostring(confederated:name()))
          end
     end
end

---@param faction FACTION_SCRIPT_INTERFACE
---@param character CHARACTER_SCRIPT_INTERFACE
---@param agents table
local function lord_events(faction, character, agents)
     if not is_faction(faction) then
          sm0_log("ERROR: lord_events() called but supplied faction [" ..
          tostring(faction) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end
     if not is_character(character) then
          sm0_log("ERROR: lord_events() called but supplied character [" ..
          tostring(character) .. "] is not a CHARACTER_SCRIPT_INTERFACE.")
          return
     end
     if not is_table(agents) then
          sm0_log("ERROR: lord_events() called but supplied agents [" .. tostring(agents) .. "] is not a table.")
          return
     end
     if not faction:is_human() then
          sm0_log("ERROR: lord_events() called but supplied faction is not human.")
          return
     end

     for _, agent in ipairs(agents) do
          local subtype = agent.subtype
          if subtype == character:character_subtype_key() then
               for i = 1, #agent.dlc do
                    sm0_log("agent.dlc: " ..
                    tostring(agent.dlc[i]) .. " == " .. tostring(cm:is_dlc_flag_enabled(agent.dlc[i], faction:name())))
                    if cm:is_dlc_flag_enabled(agent.dlc[i], faction:name()) then
                         if character then
                              local subtype = character:character_subtype_key()
                              local picture = faction_event_picture[faction:name()]
                              if not is_number(picture) then
                                   picture = subculture_event_picture[faction:subculture()]
                              end
                              local char_type = "legendary_lord"
                              if cm:char_is_agent(character) then char_type = "legendary_hero" end
                              --sm0_log("Faction event picture | Number: "..tostring(picture))
                              --sm0_log("Faction event Title 1: "..common.get_localised_string("event_feed_strings_text_title_event_" .. char_type .. "_available"))
                              --sm0_log("Faction event Title 2: "..common.get_localised_string("event_feed_strings_text_title_event_"..subtype.."_LL_unlocked"))
                              --sm0_log("Faction event Description: "..common.get_localised_string("event_feed_strings_text_description_event_"..subtype.."_LL_unlocked"))
                              if picture and common.get_localised_string("event_feed_strings_text_title_event_" .. subtype .. "_LL_unlocked")
                                  and common.get_localised_string("event_feed_strings_text_description_event_" .. subtype .. "_LL_unlocked") and char_type then
                                   cm:show_message_event(
                                        faction:name(),
                                        "event_feed_strings_text_title_event_" .. char_type .. "_available",
                                        "event_feed_strings_text_title_event_" .. subtype .. "_LL_unlocked",
                                        "", --"event_feed_strings_text_description_event_" .. subtype .. "_LL_unlocked",
                                        true,
                                        picture
                                   )
                              end
                         end
                    end
               end
          end
     end
end

---@param faction FACTION_SCRIPT_INTERFACE
local function apply_diplomacy(faction)
     if not is_faction(faction) then
          sm0_log("ERROR: apply_diplomacy() called but supplied faction [" ..
          tostring(faction) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end

     local subculture = faction:subculture()
     local culture = faction:culture()
     local confed_option_value
     local confederation_options_mod
     --local mct = core:get_static_object("mod_configuration_tool")
     --if mct then
     --    confederation_options_mod = mct:get_mod_by_key("confederation_options")
     --    if confederation_options_mod then
     --        local confed_option = confederation_options_mod:get_option_by_key(culture)
     --        if confed_option then
     --            confed_option_value = confed_option:get_finalized_setting()
     --        else
     --            confed_option = confederation_options_mod:get_option_by_key(subculture)
     --            confed_option_value = confed_option:get_finalized_setting()
     --        end
     --    end
     --end
     local option = {}
     option.source = "faction:" .. faction:name()
     option.target = "culture:" .. culture
     if confed_option_value == "free_confed" then
          option.offer = true
          option.accept = true
          option.both_directions = true
     elseif confed_option_value == "player_only" then
          if faction:is_human() then
               option.offer = true
               option.accept = true
               option.both_directions = false
          else
               option.offer = false
               option.accept = true
               option.both_directions = false
          end
     elseif confed_option_value == "disabled" then
          option.offer = false
          option.accept = false
          option.both_directions = false
     elseif confed_option_value == "no_tweak" or confed_option_value == nil then
          option.offer = true
          option.accept = true
          option.both_directions = false
          for i, subculture_confed in ipairs(confed_restricted_subcultures) do
               if subculture == subculture_confed then
                    --option.target = "subculture:" .. subculture
                    --option.offer = false
                    --option.accept = false
                    --option.both_directions = false
                    option.target = nil
                    option.offer = nil
                    option.accept = nil
                    option.both_directions = nil
               end
          end
          --if vfs.exists("script/campaign/mod/cataph_teb_defeat.lua") and subculture == "mixer_teb_southern_realms " then
          --    option.target = "subculture:" .. subculture
          --    option.offer = true
          --    option.accept = true
          --    option.both_directions = false
          --end
          if faction:pooled_resource_manager():resource("emp_loyalty"):is_null_interface() == false then
               option.offer = false
               option.accept = false
               option.both_directions = false
          end
          if subculture == "wh_dlc05_sc_wef_wood_elves" then
               option.target = "subculture:" .. subculture
               option.accept = false
               option.both_directions = false
               --oak_region = cm:get_region("wh_main_yn_edri_eternos_the_oak_of_ages")
               --if oak_region:building_exists("wh_dlc05_wef_oak_of_ages_3") or oak_region:building_exists("wh_dlc05_wef_oak_of_ages_4") or oak_region:building_exists("wh_dlc05_wef_oak_of_ages_5") then
               --	option.offer = true
               --else
               option.offer = false
               --end
          end
     end
     cm:callback(
          function(context)
               if option.offer ~= nil and option.accept ~= nil and option.both_directions ~= nil then
                    cm:force_diplomacy(option.source, option.target, "form confederation", option.offer, option.accept,
                         option.both_directions, false)
               end
               if confed_option_value == "no_tweak" or confed_option_value == nil then
                    if faction:name() == "wh_main_vmp_rival_sylvanian_vamps" then
                         cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps",
                              "faction:wh_main_vmp_vampire_counts", "form confederation", false, false, true, false)
                         cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps",
                              "faction:wh_main_vmp_schwartzhafen", "form confederation", false, false, true, false)
                    end
                    if subculture == "wh_main_sc_brt_bretonnia" and faction:is_human() and faction:name() ~= "wh2_dlc14_brt_chevaliers_de_lyonesse" then
                         for i = 1, #bret_confederation_tech do
                              local has_tech = faction:has_technology(bret_confederation_tech[i].tech)
                              cm:force_diplomacy("faction:" .. faction:name(),
                                   "faction:" .. bret_confederation_tech[i].faction, "form confederation", has_tech,
                                   has_tech, true, false)
                         end
                    end
                    if faction:is_human() and faction:pooled_resource_manager():resource("emp_loyalty"):is_null_interface() == false then
                         cm:force_diplomacy("faction:" .. faction:name(),
                              "faction:wh2_dlc13_emp_the_huntmarshals_expedition", "form confederation", true, true,
                              false, false)
                         cm:force_diplomacy("faction:" .. faction:name(), "faction:wh2_main_emp_sudenburg",
                              "form confederation", true, true, false, false)
                         cm:force_diplomacy("faction:" .. faction:name(), "faction:wh3_main_emp_cult_of_sigmar",
                              "form confederation", true, true, false, false)
                    end
                    ---hack fix to stop this re-enabling confederation when it needs to stay disabled
                    ---please let's make this more robust!
                    if subculture == "wh2_main_sc_hef_high_elves" then
                         local grom_faction = cm:get_faction("wh2_dlc15_grn_broken_axe")
                         if grom_faction ~= false and grom_faction:is_human() then
                              cm:force_diplomacy("subculture:wh2_main_sc_hef_high_elves", "faction:wh2_main_hef_yvresse",
                                   "form confederation", false, true, false, false)
                         end
                    end
                    --if vfs.exists("script/campaign/mod/!ovn_me_lost_factions_start.lua") then
                    --    cm:force_diplomacy("faction:wh2_main_emp_grudgebringers", "all", "form confederation", false, false, false, false)
                    --    cm:force_diplomacy("faction:wh2_main_emp_the_moot", "all", "form confederation", false, false, false, false)
                    --end
                    if faction:name() == "wh2_dlc16_wef_drycha" then
                         cm:force_diplomacy("faction:wh2_dlc16_wef_drycha", "culture:wh_dlc05_wef_wood_elves",
                              "form confederation", false, false, true, false)
                         cm:force_diplomacy("faction:wh2_dlc16_wef_drycha", "faction:wh_dlc05_wef_argwylon",
                              "form confederation", true, true, true, false)
                    end
                    --- only player(s) - excluding Drycha - can confederate
                    if subculture == "wh_dlc05_sc_wef_wood_elves" and faction:name() ~= "wh2_dlc16_wef_drycha" and faction:is_human() then
                         cm:force_diplomacy("culture:wh_dlc05_wef_wood_elves", "culture:wh_dlc05_wef_wood_elves",
                              "form confederation", false, false, true, false)
                         cm:force_diplomacy("faction:" .. faction:name(), "culture:wh_dlc05_wef_wood_elves",
                              "form confederation", true, true, true, false)
                    end
                    -- Kislev confederation restriction for follower feature
                    if faction:is_human() and faction:name() == "wh3_main_ksl_the_ice_court" or faction:is_human() and faction:name() == "wh3_main_ksl_the_great_orthodoxy" then
                         cm:force_diplomacy("faction:wh3_main_ksl_the_ice_court",
                              "faction:wh3_main_ksl_the_great_orthodoxy", "form confederation", false, false, true, false)
                    end
               end
          end, 1, "changeDiplomacyOptions"
     )
end


---@param faction FACTION_SCRIPT_INTERFACE
---@param criteria string
---@return boolean
local function faction_has_valid_characters(faction, criteria)
     if not is_faction(faction) then
          sm0_log("ERROR: faction_has_valid_characters() called but supplied faction [" ..
          tostring(faction) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return false
     end

     local faction_leader_cqi = faction:faction_leader():command_queue_index()
     local char_list = faction:character_list()
     for i = 0, char_list:num_items() - 1 do
          local char = char_list:item_at(i)
          local command_queue_index = char:command_queue_index()
          if criteria == "has_immortal_characters" and char:character_details():is_immortal() then
               return true
          elseif criteria == "has_unique_characters" and char:character_details():is_unique() then
               return true
          elseif criteria == "has_characters" and char:character_subtype_key() ~= "wh3_prologue_general_test" and (cm:char_is_general(char) or cm:char_is_agent(char)) then
               return true
          end
     end
     return false
end

---@param confederator FACTION_SCRIPT_INTERFACE
---@param confederated FACTION_SCRIPT_INTERFACE
---@param criteria string
---@return boolean
local function dead_faction_has_valid_characters(confederator, confederated, criteria)
     if not is_faction(confederator) then
          sm0_log("ERROR: dead_faction_has_valid_characters() called but supplied confederator [" ..
          tostring(confederator) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end
     if not is_faction(confederated) then
          sm0_log("ERROR: dead_faction_has_valid_characters() called but supplied confederated [" ..
          tostring(confederated) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end

     local start_region --confederator:region_list():item_at(0)
     local x, y
     --if start_region then sm0_log("spawn_missing_lords 1: "..confederator:name().." | Region: "..start_region:name()) end
     if confederator:has_home_region() then
          start_region = confederator:home_region()
          --if start_region then sm0_log("spawn_missing_lords 2: "..confederator:name().." | Region: "..start_region:name()) end
          x, y = cm:find_valid_spawn_location_for_character_from_settlement(confederator:name(), start_region:name(),
               false, true, 9)
          --sm0_log("find_valid_spawn_location_for_character_from_settlement: x="..tostring(x)..", y="..tostring(y))
     else
          if not confederator:military_force_list():item_at(0):general_character():is_at_sea() and confederator:military_force_list():item_at(0):general_character():has_region() then
               start_region = confederator:military_force_list():item_at(0):general_character():region()
          else
               sm0_log("ERROR: Could not find valid region!")
               return
          end
     end
     if not is_valid_spawn_coordinate(x, y) or not confederator:has_home_region() then
          --x, y = cm:find_valid_spawn_location_for_character_from_position(confederator:name(), confederator:military_force_list():item_at(0):general_character():logical_position_x() + 1, confederator:military_force_list():item_at(0):general_character():logical_position_y(), true)
          local char_lookup = cm:char_lookup_str(confederator:military_force_list():item_at(0):general_character())
          x, y = cm:find_valid_spawn_location_for_character_from_character(confederator:name(), char_lookup, true, 9)
          --sm0_log("find_valid_spawn_location_for_character_from_position: x="..tostring(x)..", y="..tostring(y))
     end
     -- backup
     if not is_valid_spawn_coordinate(x, y) then
          -- CA's method did not provide a valid position, try Vandy's method instead
          local spawn_x, spawn_y
          if confederator:has_home_region() then
               spawn_x = confederator:home_region():settlement():logical_position_x()
               spawn_y = confederator:home_region():settlement():logical_position_y()
          else
               spawn_x = confederator:military_force_list():item_at(0):general_character():logical_position_x()
               spawn_y = confederator:military_force_list():item_at(0):general_character():logical_position_y()
          end
          if is_valid_spawn_coordinate(spawn_x, spawn_y) then x, y = find_valid_spawn_coordinates(confederator:name(),
                    spawn_x, spawn_y) end
          --sm0_log("find_valid_spawn_coordinates: x="..tostring(x)..", y="..tostring(y))
     end
     --sm0_log("Trying to revive Faction:  "..confederated:name().." | Region: "..start_region:name())
     --sm0_log("confed_revived: x="..tostring(x)..", y="..tostring(y))
     if is_valid_spawn_coordinate(x, y) and start_region then
          cm:create_force_with_general( --create_force_with_general is used because create_force sometimes stops working
               confederated:name(),
               "wh2_main_hef_inf_spearmen_0",
               start_region:name(),
               x,
               y,
               "general",
               "wh3_prologue_general_test",
               "rdll_dummy",
               "",
               "",
               "",
               false,
               --"revive_faction_force",
               --true,
               function(cqi)
                    faction_has_valid_characters(confederated, criteria)
               end
          )
     end
end

---@param confederator FACTION_SCRIPT_INTERFACE
---@param confederated FACTION_SCRIPT_INTERFACE
local function confed_revived(confederator, confederated)
     if not is_faction(confederator) then
          sm0_log("ERROR: confed_revived() called but supplied confederator [" ..
          tostring(confederator) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end
     if not is_faction(confederated) then
          sm0_log("ERROR: confed_revived() called but supplied confederated [" ..
          tostring(confederated) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end

     --pre confed character cqi list generation to compare with post confed char list to determine which legendary chars are new
     local char_list = confederator:character_list()
     local pre_confed_char_list = {}
     for i = 0, char_list:num_items() - 1 do
          local char = char_list:item_at(i)
          local command_queue_index = char:command_queue_index()
          if is_character(char) then
               sm0_log("Faction: " ..
                    confederator:name() ..
                    " | " ..
                    "Character cqi: " ..
                    command_queue_index .. " | " .. "Subtype: " .. char:character_subtype_key() .. " | Forename: "
                    .. common.get_localised_string(char:get_forename()) ..
                    " | Surname: " .. common.get_localised_string(char:get_surname()))
               if cm:char_is_agent(char) or cm:char_is_general(char) then
                    table.insert(pre_confed_char_list, command_queue_index)
               end
          end
     end

     --Alastar
     if confederated:name() == "wh2_main_hef_eataine" and not cm:get_saved_value("sm0_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked") then
          local char_found = false
          local faction_list = cm:model():world():faction_list()
          for i = 0, faction_list:num_items() - 1 do
               local current_faction = faction_list:item_at(i)
               local char_list = current_faction:character_list()
               for j = 0, char_list:num_items() - 1 do
                    local current_char = char_list:item_at(j)
                    if current_char:character_subtype_key() == "wh2_main_hef_prince_alastar" then
                         char_found = true
                    end
               end
          end
          if not char_found then
               sm0_log("spawn_missing_lords: " .. "wh2_main_hef_prince_alastar" .. " spawned!")
               cm:spawn_character_to_pool(confederator:name(), "names_name_2147360555", "names_name_2147360560", "", "",
                    18, true, "general", "wh2_main_hef_prince_alastar", true, "")
               cm:set_saved_value("sm0_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked", true)
               ancillary_on_rankup(alastar_quests, "wh2_main_hef_prince_alastar")
               if confederator:is_human() then
                    local picture = faction_event_picture[confederator:name()]
                    if not is_number(picture) then
                         picture = subculture_event_picture[confederator:subculture()]
                    end
                    cm:show_message_event(
                         confederator:name(),
                         "event_feed_strings_text_title_event_legendary_lord_available",
                         "event_feed_strings_text_title_event_wh2_main_hef_prince_alastar_LL_unlocked",
                         "", --"event_feed_strings_text_description_event_wh2_main_hef_prince_alastar_LL_unlocked",
                         true,
                         picture
                    )
               end
               cm:lock_starting_character_recruitment("638763060", "wh2_main_hef_eataine")
          end
     end

     core:add_listener(
          "sm0_confed_revived_FactionJoinsConfederation",
          "FactionJoinsConfederation",
          function(context)
               return context:confederation():name() == confederator:name() and
               context:faction():name() == confederated:name()
          end,
          function(context)
               sm0_log("Faction: " .. confederator:name() .. " :confederated: " .. confederated:name())
               cm:callback(function()
                    if confed_penalty(confederator) then cm:remove_effect_bundle(confed_penalty(confederator),
                              confederator:name()) end
               end, 0.5)
               -- kislev -100 devotion due to war counter
               if confederator:subculture() == "wh3_main_sc_ksl_kislev" then
                    cm:faction_add_pooled_resource(confederator:name(), "wh3_main_ksl_devotion", "declared_war_on_kislev",
                         100)
               end
               -- some faction leaders need a immortality reset after confederation
               immortality_backup(context:confederation())
               --pre confed character cqi list generation to compare with post confed char list to determine which legendary chars are new
               local char_list = confederator:character_list()
               local faction_leader_cqi = nil
               for i = 0, char_list:num_items() - 1 do
                    local char = char_list:item_at(i)
                    local current_cqi = char:command_queue_index()
                    if is_character(char) and (cm:char_is_agent(char) or cm:char_is_general(char)) and not table.contains(pre_confed_char_list, current_cqi) then
                         if confederator:is_human() then
                              lord_events(confederator, char, wh_agents)
                              if vfs.exists("script/campaign/wh3_main_combi/mod/mixu_spawn_characters_ie.lua.lua") then
                                   lord_events(confederator, char, mixu_agents) end
                         end
                         if faction_leader_cqi == nil and cm:char_is_general(char) then
                              faction_leader_cqi =
                              current_cqi                -- faction leader has the lowest cqi of all newly spawned characters
                         end
                         if refugee_types_value == "immortal" or (current_cqi ~= faction_leader_cqi and refugee_types_value == "faction_leader") then
                              if char:character_details():is_immortal() then
                                   sm0_log("IMMORTAL CHARACTER | Faction: " ..
                                        confederated:name() .. " | " .. "Character cqi:" .. current_cqi .. " | subtype: "
                                        .. common.get_localised_string(char:character_subtype_key()) .. " | Forename: "
                                        .. common.get_localised_string(char:get_forename()) ..
                                        " | Surname: " .. common.get_localised_string(char:get_surname()))
                              elseif char:character_details():is_unique() then
                                   sm0_log("UNIQUE CHARACTER | Faction: " ..
                                        confederated:name() .. " | " .. "Character cqi:" .. current_cqi .. " | subtype: "
                                        .. common.get_localised_string(char:character_subtype_key()) .. " | Forename: "
                                        .. common.get_localised_string(char:get_forename()) ..
                                        " | Surname: " .. common.get_localised_string(char:get_surname()))
                              else
                                   sm0_log("MORTAL CHARACTER | Faction: " ..
                                        confederated:name() .. " | " .. "Character cqi:" .. current_cqi .. " | subtype: "
                                        .. common.get_localised_string(char:character_subtype_key()) .. " | Forename: "
                                        .. common.get_localised_string(char:get_forename()) ..
                                        " | Surname: " .. common.get_localised_string(char:get_surname()))
                              end
                              cm:kill_character(current_cqi, true)
                         elseif refugee_types_value == "all" then
                              --unstuck heroes (recently fixed by CA)
                              --if cm:char_is_agent(char) then
                              --    local agent_region = char:region()
                              --    local x, y
                              --    if confederator:has_home_region() then
                              --        agent_region = confederator:home_region()
                              --        x, y = cm:find_valid_spawn_location_for_character_from_settlement(confederator:name(), agent_region:name(), false, true, 1)
                              --    else
                              --        if not confederator:military_force_list():item_at(0):general_character():is_at_sea() and confederator:military_force_list():item_at(0):general_character():has_region() then
                              --            agent_region = confederator:military_force_list():item_at(0):general_character():region()
                              --            local char_lookup = cm:char_lookup_str(confederator:military_force_list():item_at(0):general_character())
                              --            x, y = cm:find_valid_spawn_location_for_character_from_character(confederator:name(), char_lookup, true, 1)
                              --        else
                              --            sm0_log("ERROR: Could not find valid region!")
                              --            return
                              --        end
                              --    end
                              --    if is_valid_spawn_coordinate(x, y) then
                              --        cm:teleport_to(cm:char_lookup_str(char:cqi()), x, y)
                              --    else
                              --        sm0_log("ERROR: Could not find valid coordinates! (x = "..tostring(x)..", y = "..tostring(y))
                              --    end
                              --end
                         end
                    end
               end

               cm:set_saved_value("rd_choice_0_" .. confederated:name(), false)
          end,
          false
     )
     --if confederated:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" then cm:set_saved_value("sm0_rd_wh2_dlc13_lzd_spirits_of_the_jungle", true) end
     if confederated:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" then
          local defender_faction = cm:model():world():faction_by_key("wh2_dlc13_lzd_defenders_of_the_great_plan")
          if nakai_vassal_value == "do_nothing" then
               --core:remove_listener("confederation_listener")
               --core:remove_listener("confederation_expired")
          elseif nakai_vassal_value == "confederate" and defender_faction and not defender_faction:is_dead() then
               cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_broken", "");
               cm:disable_event_feed_events(true, "", "", "diplomacy_treaty_negotiated_vassal");

               cm:force_confederation(confederator:name(), "wh2_dlc13_lzd_defenders_of_the_great_plan");

               cm:callback(
               function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_broken", "") end,
                    1);
               cm:callback(
               function() cm:disable_event_feed_events(false, "", "", "diplomacy_treaty_negotiated_vassal") end, 1)
          elseif nakai_vassal_value == "abandon" then
               if defender_faction:is_null_interface() == false then
                    cm:disable_event_feed_events(true, "wh_event_category_conquest", "", "")
                    cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "")

                    cm:kill_all_armies_for_faction(defender_faction)
                    local region_list = defender_faction:region_list()
                    for j = 0, region_list:num_items() - 1 do
                         local region = region_list:item_at(j):name()
                         cm:set_region_abandoned(region)
                    end

                    cm:callback(function()
                         cm:disable_event_feed_events(false, "wh_event_category_conquest", "", "");
                         cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "");
                    end, 0.5)
               end
          else
               sm0_log("confed_revived: wh2_dlc13_lzd_spirits_of_the_jungle | something went wrong")
          end
     end

     -- new revive & confed method
     local confed_payload = cm:create_payload()
     confed_payload:form_confederation(confederator, confederated, true)
     cm:apply_payload(confed_payload, confederator)
end

---@param confederator FACTION_SCRIPT_INTERFACE
---@param confederated FACTION_SCRIPT_INTERFACE
local function confed_revived_old(confederator, confederated)
     if not is_faction(confederator) then
          sm0_log("ERROR: confed_revived() called but supplied confederator [" ..
          tostring(confederator) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end
     if not is_faction(confederated) then
          sm0_log("ERROR: confed_revived() called but supplied confederated [" ..
          tostring(confederated) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end

     --old create_force revival method
     local start_region --confederator:region_list():item_at(0)
     local x, y
     --if start_region then sm0_log("spawn_missing_lords 1: "..confederator:name().." | Region: "..start_region:name()) end
     if confederator:has_home_region() then
          start_region = confederator:home_region()
          --if start_region then sm0_log("spawn_missing_lords 2: "..confederator:name().." | Region: "..start_region:name()) end
          x, y = cm:find_valid_spawn_location_for_character_from_settlement(confederator:name(), start_region:name(),
               false, true, 9)
          --sm0_log("find_valid_spawn_location_for_character_from_settlement: x="..tostring(x)..", y="..tostring(y))
     else
          if not confederator:military_force_list():item_at(0):general_character():is_at_sea() and confederator:military_force_list():item_at(0):general_character():has_region() then
               start_region = confederator:military_force_list():item_at(0):general_character():region()
          else
               sm0_log("ERROR: Could not find valid region!")
               return
          end
     end
     if not is_valid_spawn_coordinate(x, y) or not confederator:has_home_region() then
          --x, y = cm:find_valid_spawn_location_for_character_from_position(confederator:name(), confederator:military_force_list():item_at(0):general_character():logical_position_x() + 1, confederator:military_force_list():item_at(0):general_character():logical_position_y(), true)
          local char_lookup = cm:char_lookup_str(confederator:military_force_list():item_at(0):general_character())
          x, y = cm:find_valid_spawn_location_for_character_from_character(confederator:name(), char_lookup, true, 9)
          --sm0_log("find_valid_spawn_location_for_character_from_position: x="..tostring(x)..", y="..tostring(y))
     end
     -- backup
     if not is_valid_spawn_coordinate(x, y) then
          -- CA's method did not provide a valid position, try Vandy's method instead
          local spawn_x, spawn_y
          if confederator:has_home_region() then
               spawn_x = confederator:home_region():settlement():logical_position_x()
               spawn_y = confederator:home_region():settlement():logical_position_y()
          else
               spawn_x = confederator:military_force_list():item_at(0):general_character():logical_position_x()
               spawn_y = confederator:military_force_list():item_at(0):general_character():logical_position_y()
          end
          if is_valid_spawn_coordinate(spawn_x, spawn_y) then x, y = find_valid_spawn_coordinates(confederator:name(),
                    spawn_x, spawn_y) end
          --sm0_log("find_valid_spawn_coordinates: x="..tostring(x)..", y="..tostring(y))
     end
     --sm0_log("Trying to revive Faction:  "..confederated:name().." | Region: "..start_region:name())
     --sm0_log("confed_revived: x="..tostring(x)..", y="..tostring(y))
     if is_valid_spawn_coordinate(x, y) and start_region then
          --create_force_with_general is used because create_force sometimes stops working
          --cm:create_force(
          --    --  string faction key,
          --    --  string unit list,
          --    --  string region key,
          --    --  number x,
          --    --  number y,
          --    --  boolean exclude named characters,
          --    --  [function success callback],
          --    --  [boolean command queue]
          --    confederated:name(),
          --    "wh2_main_hef_inf_spearmen_0",
          --    start_region:name(),
          --    x,
          --    y,
          --    true,
          --cm:transfer_region_to_faction(confederator:home_region():name(), confederated:name())
          cm:create_force_with_general(
          --  string faction key,
          --  string unit list,
          --  string region key,
          --  number x,
          --  number y,
          --  string agent type,
          --  string agent subtype,
          --  string forename,
          --  string clan name,
          --  string family name,
          --  string other name,
          --  boolean make faction leader,
          --  [function success callback],
          --  [boolean force diplomatic discovery]
               confederated:name(),
               "wh2_main_hef_inf_spearmen_0",
               start_region:name(),
               x,
               y,
               "general",
               "wh3_prologue_general_test",
               "rdll_dummy",
               "",
               "",
               "",
               false,
               --"revive_faction_force",
               --true,
               function(cqi)
                    --sm0_log("Faction revived: "..confederated:name().." | Region: "..start_region:name().." | CQI: "..cqi)
                    --equip_quest_anc(confederated)
                    local faction_leader_cqi = confederated:faction_leader():command_queue_index()
                    local char_list = confederated:character_list()
                    local hit_list = {}
                    for i = 0, char_list:num_items() - 1 do
                         local char = char_list:item_at(i)
                         local command_queue_index = char:command_queue_index()
                         --remove names of power traits
                         --local char_lookup = cm:char_lookup_str(char)
                         --if cm:char_is_agent(char) or cm:char_is_general(char) then
                         --    cm:force_reset_skills(char_lookup)
                         --    for j = 1, #names_of_power_traits do
                         --        if char:has_trait(names_of_power_traits[j]) then
                         --            cm:force_remove_trait(char_lookup, names_of_power_traits[j])
                         --        end
                         --    end
                         --end
                         --if not char:has_military_force() and (cm:char_is_general(char) or cm:char_is_agent(char)) then cm:kill_character(command_queue_index, true) end --kill colonels
                         if confederator:is_human() then
                              --lord_events_mp(confederator, confederated, char, wh_agents)
                              --if vfs.exists("script/campaign/wh3_main_combi/mod/mixu_spawn_characters_ie.lua.lua") then lord_events_mp(confederator, confederated, char, mixu_agents) end
                              --if vfs.exists("script/campaign/mod/mixu_darkhand.lua") then lord_events_mp(confederator, confederated, char, mixu2_agents) end
                              --if vfs.exists("script/campaign/mod/eltharion_yvresse_add.lua") then lord_events_mp(confederator, confederated, char, xoudad_agents) end
                              --if vfs.exists("script/campaign/main_warhammer/mod/cataph_kraka_drak.lua") then lord_events_mp(confederator, confederated, char, kraka_agents) end
                              --if vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then lord_events_mp(confederator, confederated, char, teb_agents) end
                              --if vfs.exists("script/export_helpers_enforest.lua") then lord_events_mp(confederator, confederated, char, parte_agents) end
                              --if vfs.exists("script/campaign/main_warhammer/mod/spcha_live_launch.lua") then lord_events_mp(confederator, confederated, char, speshul_agents) end
                              --if vfs.exists("script/export_helpers_why_grudge.lua") then lord_events_mp(confederator, confederated, char, wsf_agents) end
                              --if vfs.exists("script/export_helpers_ordo_draconis_why.lua") then lord_events_mp(confederator, confederated, char, ordo_agents) end
                              --if vfs.exists("script/export_helpers_why_strigoi_camp.lua") then lord_events_mp(confederator, confederated, char, strigoi_agents) end
                              --if vfs.exists("script/campaign/mod/@zf_master_engineer_setup_vandy") then lord_events_mp(confederator, confederated, char, zf_agents) end
                              --if vfs.exists("script/campaign/mod/cataph_aislinn") then lord_events_mp(confederator, confederated, char, seahelm_agents) end
                              --if vfs.exists("script/campaign/mod/mixu_shadewraith") then lord_events_mp(confederator, confederated, char, mixu_vangheist) end
                              --if vfs.exists("script/campaign/mod/ovn_rogue.lua") then lord_events_mp(confederator, confederated, char, second_start_agents) end
                              --if vfs.exists("script/campaign/mod/sr_chaos.lua") then lord_events_mp(confederator, confederated, char, lost_factions_agents) end
                              sm0_log("Faction: " ..
                              confederated:name() ..
                              " | " ..
                              "Character cqi:" ..
                              command_queue_index ..
                              " | Forename: " ..
                              common.get_localised_string(char:get_forename()) ..
                              " | Surname: " .. common.get_localised_string(char:get_surname()))
                         end
                         --if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and not cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
                         --    --cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
                         --        cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), true)
                         --    --end, 0.5)
                         --    cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), true)
                         --end
                         --if char:character_subtype("wh_main_brt_louen_leoncouer") then
                         --    cm:force_add_ancillary(char, "wh_main_anc_mount_brt_louen_barded_warhorse", true, true)
                         --end
                         --if is_surtha_ek(char) then
                         --    cm:force_add_ancillary(char, "wh_dlc10_anc_mount_nor_surtha_ek_marauder_chariot", true, true)
                         --end
                         if cm:char_is_agent(char) or cm:char_is_general(char) then
                              table.insert(hit_list, command_queue_index)
                              if command_queue_index ~= cqi and (refugee_types_value == "immortal" or (not char:is_faction_leader() and refugee_types_value == "faction_leader")) then
                                   --cm:kill_character(command_queue_index, true)
                              end
                         end
                    end
                    if confederated:name() == "wh2_main_hef_eataine" and not cm:get_saved_value("sm0_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked") then
                         local char_found = false
                         local faction_list = cm:model():world():faction_list()
                         for i = 0, faction_list:num_items() - 1 do
                              local current_faction = faction_list:item_at(i)
                              local char_list = current_faction:character_list()
                              for j = 0, char_list:num_items() - 1 do
                                   local current_char = char_list:item_at(j)
                                   if current_char:character_subtype_key() == "wh2_main_hef_prince_alastar" then
                                        char_found = true
                                   end
                              end
                         end
                         if not char_found then
                              sm0_log("spawn_missing_lords: " .. "wh2_main_hef_prince_alastar" .. " spawned!")
                              cm:spawn_character_to_pool(confederator:name(), "names_name_2147360555",
                                   "names_name_2147360560", "", "", 18, true, "general", "wh2_main_hef_prince_alastar",
                                   true, "")
                              cm:set_saved_value("sm0_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked", true)
                              ancillary_on_rankup(alastar_quests, "wh2_main_hef_prince_alastar")
                              if confederator:is_human() then
                                   local picture = faction_event_picture[confederator:name()]
                                   if not is_number(picture) then
                                        picture = subculture_event_picture[confederator:subculture()]
                                   end
                                   cm:show_message_event(
                                        confederator:name(),
                                        "event_feed_strings_text_title_event_legendary_lord_available",
                                        "event_feed_strings_text_title_event_wh2_main_hef_prince_alastar_LL_unlocked",
                                        "", --"event_feed_strings_text_description_event_wh2_main_hef_prince_alastar_LL_unlocked",
                                        true,
                                        picture
                                   )
                              end
                              cm:lock_starting_character_recruitment("638763060", "wh2_main_hef_eataine")
                         end
                    end
                    core:add_listener(
                         "sm0_confed_revived_FactionJoinsConfederation",
                         "FactionJoinsConfederation",
                         function(context)
                              return context:confederation():name() == confederator:name() and
                              context:faction():name() == confederated:name()
                         end,
                         function(context)
                              sm0_log("Faction: " ..
                              confederator:name() .. " :confederated: " .. confederated:name() .. " | CQI: " .. cqi)
                              cm:callback(function()
                                   if confed_penalty(confederator) then cm:remove_effect_bundle(
                                        confed_penalty(confederator), confederator:name()) end
                              end, 0.5)
                              -- some faction leaders need a immortality reset after confederation
                              immortality_backup(context:confederation())
                              -- execute useless mod compatibility
                              --if cm:get_saved_value("sm0_immortal_cqi"..cqi) then cm:set_character_immortality(cm:char_lookup_str(cqi), true) end
                              --if cm:get_saved_value("sm0_immortal_cqi"..faction_leader_cqi) then cm:set_character_immortality(cm:char_lookup_str(faction_leader_cqi), true) end
                              -- kill command doesn't work reliably...
                              cm:kill_character(cqi, true)
                              --if cqi and cm:get_character_by_cqi(cqi) then cm:kill_character(cqi, true) end
                              --cm:callback(function()
                              --if refugee_types_value == "immortal" then
                              --    cm:kill_character(faction_leader_cqi, true)
                              --end
                              --end, 0.5)

                              for i = 1, #hit_list do
                                   local current_cqi = hit_list[i]
                                   local char = cm:get_character_by_cqi(current_cqi)
                                   if char then
                                        if confederator:is_human() then
                                             lord_events(confederator, char, wh_agents)
                                             if vfs.exists("script/campaign/wh3_main_combi/mod/mixu_spawn_characters_ie.lua.lua") then
                                                  lord_events(confederator, char, mixu_agents) end
                                        end
                                        if refugee_types_value == "immortal" or (current_cqi ~= faction_leader_cqi and refugee_types_value == "faction_leader") then
                                             if char:character_details():is_immortal() then
                                                  sm0_log("IMMORTAL CHARACTER | Faction: " ..
                                                       confederated:name() ..
                                                       " | " .. "Character cqi:" .. current_cqi .. " | subtype: "
                                                       .. common.get_localised_string(char:character_subtype_key()) ..
                                                       " | Forename: "
                                                       .. common.get_localised_string(char:get_forename()) ..
                                                       " | Surname: " .. common.get_localised_string(char:get_surname()))
                                             elseif char:character_details():is_unique() then
                                                  sm0_log("UNIQUE CHARACTER | Faction: " ..
                                                       confederated:name() ..
                                                       " | " .. "Character cqi:" .. current_cqi .. " | subtype: "
                                                       .. common.get_localised_string(char:character_subtype_key()) ..
                                                       " | Forename: "
                                                       .. common.get_localised_string(char:get_forename()) ..
                                                       " | Surname: " .. common.get_localised_string(char:get_surname()))
                                             end
                                             cm:kill_character(current_cqi, true)
                                        elseif refugee_types_value == "all" then
                                             --unstuck heroes
                                             if cm:char_is_agent(char) then
                                                  local agent_region = char:region()
                                                  local x, y
                                                  if confederator:has_home_region() then
                                                       agent_region = confederator:home_region()
                                                       x, y = cm:find_valid_spawn_location_for_character_from_settlement(
                                                       confederator:name(), agent_region:name(), false, true, 1)
                                                  else
                                                       if not confederator:military_force_list():item_at(0):general_character():is_at_sea() and confederator:military_force_list():item_at(0):general_character():has_region() then
                                                            agent_region = confederator:military_force_list():item_at(0)
                                                            :general_character():region()
                                                            local char_lookup = cm:char_lookup_str(confederator
                                                            :military_force_list():item_at(0):general_character())
                                                            x, y = cm
                                                            :find_valid_spawn_location_for_character_from_character(
                                                            confederator:name(), char_lookup, true, 1)
                                                       else
                                                            sm0_log("ERROR: Could not find valid region!")
                                                            return
                                                       end
                                                  end
                                                  if is_valid_spawn_coordinate(x, y) then
                                                       cm:teleport_to(cm:char_lookup_str(char:cqi()), x, y)
                                                  else
                                                       sm0_log("ERROR: Could not find valid coordinates! (x = " ..
                                                       tostring(x) .. ", y = " .. tostring(y))
                                                  end
                                             end
                                        end
                                   end
                              end

                              --cm:kill_character_and_commanded_unit(cm:char_lookup_str(cqi), true)
                              --cm:kill_character_and_commanded_unit(cm:char_lookup_str(faction_leader_cqi), true)
                              --apply_diplomacy(confederator)
                              --local char_list = context:confederation():character_list()
                              --for i = 0, char_list:num_items() - 1 do
                              --    local char = char_list:item_at(i)
                              --    if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
                              --        cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), false)
                              --        cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), false)
                              --    end
                              --end



                              -- respawn and kill faction again, so they count as "dead" for grudges and missions in general (doesn't work)
                              --
                              --if is_valid_spawn_coordinate(x, y) and start_region then
                              --    cm:create_force_with_general( --create_force_with_general is used because create_force sometimes stops working
                              --        confederated:name(),
                              --        "wh2_main_hef_inf_spearmen_0",
                              --        start_region:name(),
                              --        x,
                              --        y,
                              --        "general",
                              --        "wh3_prologue_general_test",
                              --        "rdll_dummy",
                              --        "",
                              --        "",
                              --        "",
                              --        false,
                              --        --"revive_faction_force",
                              --        --true,
                              --        function(cqi)
                              --            cm:kill_character(cqi, true)
                              --        end
                              --    )
                              --end
                              --

                              cm:set_saved_value("rd_choice_0_" .. confederated:name(), false)
                         end,
                         false
                    )
                    --if confederated:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" then cm:set_saved_value("sm0_rd_wh2_dlc13_lzd_spirits_of_the_jungle", true) end
                    if confederated:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" then
                         local defender_faction = cm:model():world():faction_by_key(
                         "wh2_dlc13_lzd_defenders_of_the_great_plan")
                         if nakai_vassal_value == "do_nothing" then
                              --core:remove_listener("confederation_listener")
                              --core:remove_listener("confederation_expired")
                         elseif nakai_vassal_value == "confederate" and defender_faction and not defender_faction:is_dead() then
                              cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_broken", "");
                              cm:disable_event_feed_events(true, "", "", "diplomacy_treaty_negotiated_vassal");

                              cm:force_confederation(confederator:name(), "wh2_dlc13_lzd_defenders_of_the_great_plan");

                              cm:callback(
                              function() cm:disable_event_feed_events(false, "",
                                        "wh_event_subcategory_diplomacy_treaty_broken", "") end, 1);
                              cm:callback(
                              function() cm:disable_event_feed_events(false, "", "", "diplomacy_treaty_negotiated_vassal") end,
                                   1)
                         elseif nakai_vassal_value == "abandon" then
                              if defender_faction:is_null_interface() == false then
                                   cm:disable_event_feed_events(true, "wh_event_category_conquest", "", "")
                                   cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "")

                                   cm:kill_all_armies_for_faction(defender_faction)
                                   local region_list = defender_faction:region_list()
                                   for j = 0, region_list:num_items() - 1 do
                                        local region = region_list:item_at(j):name()
                                        cm:set_region_abandoned(region)
                                   end

                                   cm:callback(function()
                                        cm:disable_event_feed_events(false, "wh_event_category_conquest", "", "");
                                        cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "");
                                   end, 0.5)
                              end
                         else
                              sm0_log("confed_revived: wh2_dlc13_lzd_spirits_of_the_jungle | something went wrong")
                         end
                    end
                    if not confederator:is_human() then
                         --cm:disable_event_feed_events(false, "", "", "faction_joins_confederation")
                    end
                    --cm:callback(function()
                    --cm:force_confederation(confederator:name(), confederated:name())
                    --end, 0.01) --give the message_events some time
               end,
               false
          )
     else
          sm0_log("ERROR: Could not find valid spawn position! [" .. confederator:name() .. "]")
     end
     --]]
end

---@param confederator FACTION_SCRIPT_INTERFACE
---@param confederated FACTION_SCRIPT_INTERFACE
---@param player_confederation_count number
local function rd_dilemma(confederator, confederated, player_confederation_count)
     if not is_faction(confederator) then
          sm0_log("ERROR: rd_dilemma() called but supplied confederator [" ..
          tostring(confederator) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end
     if not is_faction(confederated) then
          sm0_log("ERROR: rd_dilemma() called but supplied confederated [" ..
          tostring(confederated) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end
     if not is_number(player_confederation_count) then
          sm0_log("ERROR: rd_dilemma() called but supplied player_confederation_count [" ..
          tostring(player_confederation_count) .. "] is not a number.")
          return
     end

     local subculture = confederator:subculture()
     core:add_listener(
          "rd_trigger_dilemma" .. confederated:name() .. player_confederation_count,
          "DilemmaChoiceMadeEvent",
          function(context)
               return context:dilemma() == "sm0_rd_" .. subculture .. "_" .. player_confederation_count
          end,
          function(context)
               local choice = context:choice()
               if choice == 0 then
                    sm0_log("Accept refugees: " .. confederated:name())
                    confed_revived(confederator, confederated)
                    --confed_revived_old(confederator, confederated)
                    cm:set_saved_value("rd_choice_0_" .. confederated:name(), confederator:name())
               elseif choice == 1 then
                    sm0_log("Reject refugees: " .. confederated:name())
                    cm:set_saved_value("rd_choice_1_" .. confederated:name(), confederator:name())
               elseif choice == 2 then
                    sm0_log("Kill refugees: " .. confederated:name())
                    cm:set_saved_value("rd_choice_2_" .. confederated:name(), true)
               else -- choice == 3
                    sm0_log("Delay your decision: " .. confederated:name())
                    cm:set_saved_value("rd_choice_3_" .. confederated:name(), cm:model():turn_number() + 25)
               end
               --cm:callback(function()
               --    if cm:model():difficulty_level() == -3 then
               --        cm:disable_saving_game(false)
               --        cm:autosave_at_next_opportunity()
               --    end
               --end, 3)
          end,
          false
     )

     --provided by omlett
     --note first param expects script interfaces, not command queue indices!
     --note also doesn't support on_trigger_callback or force_dilemma_immediately, maybe add that later?
     ---@param faction FACTION_SCRIPT_INTERFACE
     ---@param dilemma_key string
     ---@param target_faction FACTION_SCRIPT_INTERFACE
     local function please_trigger_dilemma_with_targets(faction, dilemma_key, target_faction)
          local dbldr = cm:create_dilemma_builder(dilemma_key)
          if target_faction then
               dbldr:add_target("default", target_faction)
          end

          local choice_keys = { "FIRST", "SECOND", "THIRD", "FOURTH" }
          local dilemma_choices = dbldr:possible_choices()
          for i = 1, #dilemma_choices do
               dbldr:remove_choice_payload(choice_keys[i])
          end

          local ui_detail_keys = { "rd_first", "rd_first2", "rd_second", "rd_third", "rd_fourth" }
          for i = 1, #dilemma_choices do
               local payload_builder = cm:create_payload()
               payload_builder:clear()
               for j = 1, #ui_detail_keys do
                    if string.find(ui_detail_keys[j], string.lower(choice_keys[i])) then
                         payload_builder:text_display(ui_detail_keys[j])
                    end
               end
               dbldr:add_choice_payload(choice_keys[i], payload_builder)
          end

          cm:launch_custom_dilemma_from_builder(dbldr, faction)
     end
     ---------------------------------------------------
     if not confederator:is_dead() then
          sm0_log("trigger_dilemma_with_targets:" ..
          "sm0_rd_" ..
          subculture ..
          "_" ..
          player_confederation_count ..
          " | confederator:cqi = " ..
          confederator:command_queue_index() .. " | confederated:cqi = " .. confederated:command_queue_index())
          --cm:trigger_dilemma_with_targets(confederator:command_queue_index(), "sm0_rd_"..subculture.."_"..player_confederation_count, confederated:command_queue_index(), 0, 0, 0, 0, 0, nil, false)
          please_trigger_dilemma_with_targets(confederator, "sm0_rd_" .. subculture .. "_" .. player_confederation_count,
               confederated)
          --confed_revived(confederator, confederated)
     else
          sm0_log("ERROR: Can't confederate dead factions! [confederator: " ..
          confederator:name() .. " | confederated: " .. confederated:name() .. "]")
          core:remove_listener("rd_trigger_dilemma" .. confederated:name() .. player_confederation_count)
     end
end

---@param faction FACTION_SCRIPT_INTERFACE
---@return boolean
local function is_faction_seccessionist(faction)
     if not is_faction(faction) then
          sm0_log("ERROR: is_faction_seccessionist() called but supplied faction [" ..
          tostring(faction) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end

     for i = 1, #faction_seccessionists do
          if faction:name():find(faction_seccessionists[i]) then
               return true
          end
     end
     return false
end

---@param faction FACTION_SCRIPT_INTERFACE
---@return boolean
local function is_faction_exempted(faction)
     if not is_faction(faction) then
          sm0_log("ERROR: is_faction_exempted() called but supplied faction [" ..
          tostring(faction) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end

     for i = 1, #subculture_exempted do
          if faction:subculture() == subculture_exempted[i] then
               return true
          end
     end
     for i = 1, #faction_exempted do
          if faction:name():find(faction_exempted[i]) then
               return true
          end
     end
     if faction:is_rebel() or faction:is_quest_battle_faction() then
          return true
     end
     if faction:name() == "wh2_dlc11_vmp_the_barrow_legion" and vfs.exists("script/campaign/main_warhammer/mod/liche_init.lua") then --hobo
          return true
     end
     if faction:name() == "wh3_dlc24_tze_the_deceivers" and not faction:is_human() and not faction:is_dead() then --deceiver stays "alive" without army and settlements causing script crashes
          return true
     end
     return false
end

---@param faction FACTION_SCRIPT_INTERFACE
---@param refugee FACTION_SCRIPT_INTERFACE
---@return boolean
local function is_human_and_rejected_faction(faction, refugee)
     if not is_faction(faction) then
          sm0_log("ERROR: is_human_and_rejected_faction() called but supplied faction [" ..
          tostring(faction) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end
     if not is_faction(refugee) then
          sm0_log("ERROR: is_human_and_rejected_faction() called but supplied refugee [" ..
          tostring(refugee) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end
     local confederator_key = cm:get_saved_value("rd_choice_1_" .. refugee:name())
     return faction:is_human() and faction:name() == confederator_key
end

---@param faction FACTION_SCRIPT_INTERFACE
---@param refugee FACTION_SCRIPT_INTERFACE
---@return boolean
local function is_valid_candidate(faction, refugee)
     if not is_faction(faction) then
          sm0_log("ERROR: is_valid_faction() called but supplied faction [" ..
          tostring(faction) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return false
     end
     if not is_faction(refugee) then
          sm0_log("ERROR: is_valid_faction() called but supplied refugee [" ..
          tostring(refugee) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return false
     end
     if faction:is_dead() then
          return false
     end
     if is_faction_exempted(faction) then
          return false
     end
     if cm:get_saved_value("rd_choice_0_" .. faction:name()) then
          return false
     end
     if is_human_and_rejected_faction(faction, refugee) then
          return false
     end
     if (faction:is_human() and scope_value == "ai") or (not faction:is_human() and scope_value == "player") then
          return false
     end
     if playable_faction_only_value and not faction:can_be_human() then --playable_faction_only_value and (not faction:can_be_human() or not table.contains(playable_factions, faction:name()))
          return false
     end

     return true
end

---@param faction_list FACTION_LIST_SCRIPT_INTERFACE | table | nil
---@param preferance_type string
---@param faction FACTION_SCRIPT_INTERFACE
---@return table | nil
local function get_prefered_faction_list(faction_list, preferance_type, faction)
     if not is_faction(faction) then
          sm0_log("ERROR: get_prefered_faction_list() called but supplied faction [" ..
          tostring(faction) .. "] is not a FACTION_SCRIPT_INTERFACE.")
          return
     end
     if not is_string(preferance_type) then
          sm0_log("ERROR: get_prefered_faction_list() called but supplied preferance_type [" ..
          tostring(preferance_type) .. "] is not a string.")
          return
     end

     --sm0_log("get_prefered_faction_list | preferance_type: "..tostring(preferance_type).." | faction: "..tostring(faction:name()))
     local prefered_factions = {}
     local factions = {}
     local human_factions = cm:get_human_factions()

     if not is_table(faction_list) and not is_factionlist(faction_list) then
          if chs_restriction_value == "ca_restrictions" and cross_race_value == "disable" then
               faction_list = faction:factions_of_same_subculture()
          else
               faction_list = cm:model():world():faction_list()
          end
     end

     if is_factionlist(faction_list) then
          --sm0_log("is_factionlist(faction_list)")
          local argwylon = cm:get_faction("wh_dlc05_wef_argwylon")
          for i = 0, faction_list:num_items() - 1 do
               local faction_current = faction_list:item_at(i)
               if faction_current and not faction_current:is_dead() and not is_faction_exempted(faction_current) and not cm:get_saved_value("rd_choice_0_" .. faction_current:name())
                   and not is_human_and_rejected_faction(faction_current, faction) and ((faction_current:is_human() and (scope_value == "player" or scope_value == "player_ai"))
                        or (not faction_current:is_human() and (scope_value == "ai" or scope_value == "player_ai")))
                   and ((faction_current:subculture() == faction:subculture() and not (chs_restriction_value == "loreful_restrictions" and table.contains(subculture_chaos, faction_current:subculture())))
                        --cross_race
                        or (faction_current:subculture() ~= faction:subculture()
                             and not ((chs_restriction_value == "loreful_restrictions" or chs_restriction_value == "ca_restrictions") and table.contains(subculture_chaos, faction_current:subculture()))
                             and (cross_race_value == "player_ai" or (cross_race_value == "player_only" and faction_current:is_human())))
                        --chs
                        or (chs_restriction_value == "no_restrictions" and table.contains(subculture_chaos, faction_current:subculture()) and table.contains(subculture_chaos, faction:subculture()))
                        or (chs_restriction_value == "loreful_restrictions" and table.contains(subculture_chaos, faction_current:subculture())
                             and (chs_loreful_restrictions[faction:name()]
                                  and ((table.contains(chs_loreful_restrictions[faction:name()].faction, faction_current:name()) or table.contains(chs_loreful_restrictions[faction:name()].subculture, faction_current:subculture())))
                                  or (chs_loreful_restrictions[faction:subculture()]
                                       and (table.contains(chs_loreful_restrictions[faction:subculture()].faction, faction_current:name()) or table.contains(chs_loreful_restrictions[faction:subculture()].subculture, faction_current:subculture())))))
                        --playable factions only option
                        and (not playable_faction_only_value or (playable_faction_only_value and (faction_current:can_be_human() or table.contains(playable_factions, faction_current:name())))))
                   --chs
                   and (faction:subculture() ~= "wh_main_sc_chs_chaos" or (chs_restriction_value ~= "ca_restrictions" and faction:subculture() == "wh_main_sc_chs_chaos")
                        or (chs_restriction_value == "ca_restrictions" and (faction_current:name() == "wh_main_chs_chaos" or faction_current:name() == "wh3_main_chs_shadow_legion")))
                   --tmb
                   and (faction:subculture() ~= "wh2_dlc09_sc_tmb_tomb_kings" or (not tmb_restriction_value and faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings")
                        or (tmb_restriction_value and faction_current:subculture() == "wh2_dlc09_sc_tmb_tomb_kings"
                             and faction:name() ~= "wh2_dlc09_tmb_the_sentinels" and faction:name() ~= "wh2_dlc09_tmb_followers_of_nagash"
                             and faction_current:name() ~= "wh2_dlc09_tmb_the_sentinels" and faction_current:name() ~= "wh2_dlc09_tmb_followers_of_nagash")
                        or (tmb_restriction_value and faction_current:name() == "wh2_dlc09_tmb_the_sentinels" and faction:name() == "wh2_dlc09_tmb_followers_of_nagash")
                        or (tmb_restriction_value and faction_current:name() == "wh2_dlc09_tmb_followers_of_nagash" and faction:name() == "wh2_dlc09_tmb_the_sentinels"))
                   --wef
                   and (faction:subculture() ~= "wh_dlc05_sc_wef_wood_elves" or (not wef_restriction_value and faction:subculture() == "wh_dlc05_sc_wef_wood_elves")
                        or (wef_restriction_value and faction:subculture() == "wh_dlc05_sc_wef_wood_elves" and (faction_current:name() == "wh_dlc05_wef_argwylon"
                             or (faction_current:name() == "wh2_dlc16_wef_drycha" and faction:name() == "wh_dlc05_wef_argwylon")
                             or (faction_current:name() == "wh2_dlc16_wef_drycha" and (not argwylon or argwylon:is_dead()))
                             or (faction_current:name() ~= "wh2_dlc16_wef_drycha" and faction:name() ~= "wh2_dlc16_wef_drycha")))) then
                    table.insert(factions, faction_current:name())
               end
          end
          cm:shuffle_table(factions)
     elseif is_table(faction_list) then
          --sm0_log("is_table(faction_list)")
          factions = faction_list
     end

     if preferance_type == "race" then
          -- preferance: race
          if is_table(factions) then
               for i = 1, #factions do
                    local faction_current = cm:get_faction(factions[i])
                    if faction_current:subculture() == faction:subculture() then
                         table.insert(prefered_factions, faction_current:name())
                         --sm0_log("race | faction: "..tostring(faction_current:name()).." | met: "..tostring("true"))
                    end
               end
               for i = 1, #factions do
                    local faction_current = cm:get_faction(factions[i])
                    if not table.contains(prefered_factions, faction_current:name()) then
                         table.insert(prefered_factions, faction_current:name())
                         --sm0_log("race | faction: "..tostring(faction_current:name()).." | met: "..tostring("false"))
                    end
               end
          else
               sm0_log("preferance: race | something went wrong")
               return
          end
     elseif preferance_type == "met" then
          -- preferance: met
          if is_table(factions) then
               for i = 1, #factions do
                    local faction_current = cm:get_faction(factions[i])
                    local factions_met_list = faction_current:factions_met()
                    for j = 0, factions_met_list:num_items() - 1 do
                         local faction_met = factions_met_list:item_at(j)
                         if faction_met:name() == faction:name() then
                              table.insert(prefered_factions, faction_current:name())
                              --sm0_log("has_met | faction: "..tostring(faction_current:name()).." | met: "..tostring("true"))
                         end
                    end
               end
               for i = 1, #factions do
                    local faction_current = cm:get_faction(factions[i])
                    if not table.contains(prefered_factions, faction_current:name()) then
                         table.insert(prefered_factions, faction_current:name())
                         --sm0_log("has_met | faction: "..tostring(faction_current:name()).." | met: "..tostring("false"))
                    end
               end
          else
               sm0_log("preferance: met | something went wrong")
               return
          end
     elseif preferance_type == "relation" then
          -- preferance: relation
          local faction_standings = {}
          if is_table(factions) then
               for i = 1, #factions do
                    local subculture_faction = cm:get_faction(factions[i])
                    local standing = faction:diplomatic_standing_with(subculture_faction:name())
                    --sm0_log("relation | factions: "..tostring(factions[i]).." | faction: "..tostring(faction:name()).." | standing: "..tostring(standing))
                    table.insert(faction_standings, { standing = standing - 0.001 * i, name = subculture_faction:name() })
               end
               -- messes up the previous table order if more than one key has an equal relation number
               table.sort(faction_standings, function(a, b) return tonumber(a.standing) > tonumber(b.standing) end)

               for _, faction in ipairs(faction_standings) do
                    table.insert(prefered_factions, faction.name)
                    --sm0_log("relation | faction: "..tostring(faction.name).." | saved_standing: "..tostring(faction.standing))
               end
          else
               sm0_log("preferance: relation | something went wrong")
               return
          end
     elseif preferance_type == "major" then
          -- preferance: major
          if is_table(factions) then
               for i = 1, #factions do
                    local faction_current = cm:get_faction(factions[i])
                    if faction_current and (faction_current:can_be_human() or table.contains(playable_factions, factions[i])) then
                         table.insert(prefered_factions, factions[i])
                         --sm0_log("is_major | faction: "..tostring(factions[i]).." | major: "..tostring("true"))
                    end
               end
               for i = 1, #factions do
                    if not table.contains(prefered_factions, factions[i]) then
                         table.insert(prefered_factions, factions[i])
                         --sm0_log("is_major | faction: "..tostring(factions[i]).." | major: "..tostring("false"))
                    end
               end
          else
               sm0_log("preferance: major | something went wrong")
               return
          end
     elseif preferance_type == "minor" then
          -- preferance: minor
          if is_table(factions) then
               for i = 1, #factions do
                    local faction_current = cm:get_faction(factions[i])
                    if faction_current and (not faction_current:can_be_human() or not table.contains(playable_factions, factions[i])) then
                         table.insert(prefered_factions, factions[i])
                         --sm0_log("is_minor | faction: "..tostring(factions[i]).." | minor: "..tostring("true"))
                    end
               end
               for i = 1, #factions do
                    if not table.contains(prefered_factions, factions[i]) then
                         table.insert(prefered_factions, factions[i])
                         --sm0_log("is_minor | faction: "..tostring(factions[i]).." | minor: "..tostring("false"))
                    end
               end
          else
               sm0_log("preferance: minor | something went wrong")
               return
          end
     elseif preferance_type == "player" then --and (scope_value == "player" or scope_value == "player_ai") then
          -- preferance: player
          if is_table(factions) then
               for i = 1, #factions do
                    --sm0_log("player | factions: "..tostring(factions[i]))
                    local subculture_faction = cm:get_faction(factions[i])
                    if subculture_faction and subculture_faction:is_human() then
                         table.insert(prefered_factions, subculture_faction:name())
                         --sm0_log("is_human | faction: "..tostring(subculture_faction:name()).." | human: "..tostring("true"))
                    end
               end
               for i = 1, #factions do
                    local faction_current = cm:get_faction(factions[i])
                    if not table.contains(prefered_factions, faction_current:name()) then
                         table.insert(prefered_factions, faction_current:name())
                         --sm0_log("is_human | faction: "..tostring(faction_current:name()).." | human: "..tostring("false"))
                    end
               end
          else
               sm0_log("preferance: player | something went wrong")
               return
          end
     elseif preferance_type == "ai" then --and (scope_value == "ai" or scope_value == "player_ai") then
          -- preferance: ai
          if is_table(factions) then
               for i = 1, #factions do
                    local subculture_faction = cm:get_faction(factions[i])
                    if not subculture_faction:is_human() then
                         table.insert(prefered_factions, subculture_faction:name())
                         --sm0_log("is_ai | faction: "..tostring(subculture_faction:name()).." | ai: "..tostring("true"))
                    end
               end
               for i = 1, #factions do
                    if not table.contains(prefered_factions, factions[i]) then
                         table.insert(prefered_factions, factions[i])
                         --sm0_log("is_ai | faction: "..tostring(factions[i]).." | ai: "..tostring("false"))
                    end
               end
          else
               sm0_log("preferance: ai | something went wrong")
               return
          end
     elseif preferance_type == "alternate" then
          -- preferance: player alternate (only applies to mp same subculture)
          if is_table(factions) then
               --if cm:is_multiplayer() and (cm:get_saved_value("faction_P2") or cm:get_saved_value("faction_P1")) then
               --    local player1_current_pos
               --    local player2_current_pos
               --    for i = 1, #factions do
               --        local subculture_faction = cm:get_faction(factions[i])
               --        if subculture_faction:name() == human_factions[1] then
               --            player1_current_pos = i
               --        elseif subculture_faction:name() == human_factions[2] then
               --            player2_current_pos = i
               --        end
               --    end
               --    prefered_factions = factions
               --    if is_number(player1_current_pos) and is_number(player2_current_pos) then
               --        if ((player1_current_pos < player2_current_pos) and cm:get_saved_value("faction_P1"))
               --        or ((player2_current_pos < player1_current_pos) and cm:get_saved_value("faction_P2")) then
               --            prefered_factions[player1_current_pos], prefered_factions[player2_current_pos] = prefered_factions[player2_current_pos], prefered_factions[player1_current_pos]
               --        end
               --    end
               --else
               prefered_factions = factions
               --end
          else
               sm0_log("preferance: alternate | something went wrong")
               return
          end
     elseif preferance_type == "random" then
          -- preferance: random
          if is_table(factions) then
               cm:shuffle_table(factions)
               prefered_factions = factions
          else
               sm0_log("preferance: random | something went wrong")
               return
          end
     else
          -- preferance: nil
          if is_table(factions) then
               prefered_factions = factions
          else
               sm0_log("preferance: nil | something went wrong")
               return
          end
     end

     --for i, faction in ipairs(prefered_factions) do
     --    sm0_log("return | "..tostring(preferance_type).." | prefered_factions["..i.."]: "..tostring(faction))
     --end
     return prefered_factions
end

---@param enable_value boolean
local function init_recruit_defeated_listeners(enable_value)
     local human_factions = cm:get_human_factions()
     local faction_P1 = cm:get_faction(human_factions[1]) --host
     core:remove_listener("recruit_defeated_FactionTurnEnd")
     core:remove_listener("recruit_defeated_FactionTurnStart")
     core:remove_listener("delayed_spawn_listener")
     core:remove_listener("backup_delayed_spawn_listener")
     core:remove_listener("recruit_defeated_DilemmaIssuedEvent")
     core:remove_listener("recruit_defeated_FactionTurnStart")
     core:remove_listener("recruit_defeated_DilemmaChoiceMadeEvent")
     core:remove_listener("recruit_defeated_FactionJoinsConfederation")
     core:remove_listener("recruit_defeated_ScriptEventConfederationExpired")
     core:remove_listener("recruit_defeated_UITrigger")
     --core:remove_listener("recruit_defeated_confederation_listener")
     core:remove_listener("recruit_defeated_nakai_horde_MilitaryForceCreated")

     if enable_value then
          core:add_listener(
               "recruit_defeated_nakai_horde_MilitaryForceCreated",
               "MilitaryForceCreated",
               function(context)
                    return context:military_force_created():faction():name() ~= "wh2_dlc13_lzd_spirits_of_the_jungle"
                        and context:military_force_created():force_type():key() == "NAKAI_BOUND_HORDE"
               end,
               function(context)
                    cm:convert_force_to_type(context:military_force_created(), "ARMY")
               end,
               true
          )

          core:add_listener(
               "recruit_defeated_FactionTurnEnd",
               "FactionTurnEnd",
               true,
               function(context)
                    if not (cm:model():turn_number() == 1 and context:faction():is_human()) then
                         if cm:get_saved_value("rd_choice_1_" .. context:faction():name()) then
                              cm:set_saved_value("rd_choice_1_" .. context:faction():name(), false)
                         end
                         if cm:get_saved_value("rd_choice_2_" .. context:faction():name()) then
                              cm:set_saved_value("rd_choice_2_" .. context:faction():name(), false)
                         end
                         if cm:get_saved_value("delayed_spawn_" .. context:faction():name()) then
                              cm:set_saved_value("delayed_spawn_" .. context:faction():name(), false)
                              sm0_log("Faction spawned delayed: " .. context:faction():name())
                         end
                    end
               end,
               true
          )

          core:add_listener(
               "recruit_defeated_FactionTurnStart",
               "FactionTurnStart",
               true,
               function(context)
                    if not (cm:model():turn_number() == 1 and context:faction():is_human()) then
                         if cm:get_saved_value("sought_refuge_" .. context:faction():name()) then
                              cm:set_saved_value("sought_refuge_" .. context:faction():name(), false)
                              sm0_log("Faction respawned: " .. context:faction():name())
                         end
                    end
               end,
               true
          )

          if not cm:get_saved_value("delayed_spawn_listener") and cm:model():turn_number() == 1 then
               if not cm:is_multiplayer() then
                    core:add_listener(
                         "delayed_spawn_listener",
                         "PanelOpenedCampaign",
                         function(context)
                              return context.string == "popup_pre_battle" and cm:model():turn_number() == 1
                         end,
                         function(context)
                              local faction_list = cm:model():world():faction_list()
                              for i = 0, faction_list:num_items() - 1 do
                                   local current_faction = faction_list:item_at(i)
                                   if current_faction:is_dead() then -- delayed spawn?
                                        -- faction exceptions
                                        if not is_faction_exempted(current_faction) then
                                             cm:set_saved_value("delayed_spawn_" .. current_faction:name(), true)
                                             sm0_log("Faction will spawn delayed: " .. current_faction:name())
                                        end
                                   end
                              end
                              cm:set_saved_value("delayed_spawn_listener", true)
                              core:remove_listener("backup_delayed_spawn_listener")
                              --core:remove_listener("delayed_spawn_listener")
                         end,
                         false
                    )
               end
               core:add_listener(
                    "backup_delayed_spawn_listener",
                    "FactionAboutToEndTurn",
                    function(context)
                         return context:faction():name() == faction_P1:name() and cm:model():turn_number() == 1
                    end,
                    function(context)
                         local faction_list = cm:model():world():faction_list()
                         for i = 0, faction_list:num_items() - 1 do
                              local current_faction = faction_list:item_at(i)
                              if current_faction:is_dead() then -- delayed spawn?
                                   -- faction exceptions
                                   if not is_faction_exempted(current_faction) then
                                        cm:set_saved_value("delayed_spawn_" .. current_faction:name(), true)
                                        sm0_log("Faction will spawn delayed: " .. current_faction:name())
                                   end
                              end
                         end
                         cm:set_saved_value("delayed_spawn_listener", true)
                         --core:remove_listener("backup_delayed_spawn_listener")
                         core:remove_listener("delayed_spawn_listener")
                    end,
                    false
               )
          end

          core:add_listener(
               "recruit_defeated_FactionTurnStart",
               "FactionTurnStart", -- "FactionDeath" wh3_5.0.0 addition
               function(context)
                    local human_factions = cm:get_human_factions()
                    return cm:model():turn_number() >= 2 and context:faction():is_human() and
                    (not cm:is_multiplayer()                                                                       --singleplayer
                         or cm:whose_turn_is_it():num_items() == 1                                                 -- multiplayer, simultaneous turns disabled, execute every player turn
                         or context:faction():name() == human_factions[1])                                         -- multiplayer, simultaneous turns enabled, execute at host turn
               end,
               function(context)
                    --if cm:model():difficulty_level() == -3 then cm:disable_saving_game(true) end
                    local confederation_limit = dilemmas_per_turn_value
                    local player_confederation_limit = dilemmas_per_turn_player_value
                    local confederation_count = 1
                    local player_confederation_count = 1
                    local subcultures_accepting_refugees = {}
                    local dilemmas = {}
                    local ai_confeds = {}
                    local confederation_subculture_limit = dilemmas_per_turn_per_sc_value
                    if cm:is_multiplayer() then
                         player_confederation_limit = 1
                    end
                    local faction_list = cm:model():world():faction_list() --context:faction():factions_of_same_subculture() --cm:model():world():faction_list()
                    for i = 0, faction_list:num_items() - 1 do
                         local current_faction = faction_list:item_at(i)
                         if confederation_count <= confederation_limit and current_faction:is_dead()
                             -- mct beta
                             and (not playable_faction_only_value or (playable_faction_only_value and (current_faction:can_be_human() or table.contains(playable_factions, current_faction:name()))))
                             -- mct restrictions
                             and ((current_faction:subculture() ~= "wh2_dlc09_sc_tmb_tomb_kings" --and current_faction:subculture() ~= "wh_main_sc_grn_savage_orcs"
                                       and current_faction:subculture() ~= "wh2_dlc11_sc_cst_vampire_coast")
                                  --or (not savage_restriction_value and current_faction:subculture() == "wh_main_sc_grn_savage_orcs")
                                  or (not cst_restriction_value and current_faction:subculture() == "wh2_dlc11_sc_cst_vampire_coast")
                                  or ((not tmb_restriction_value and current_faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings")
                                       or (tmb_restriction_value and current_faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" and current_faction:name() ~= "wh2_dlc09_tmb_khemri"
                                       --and current_faction:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and current_faction:name() ~= "wh2_dlc09_tmb_the_sentinels"
                                       )))
                             -- dilemma conditions
                             and not cm:get_saved_value("sought_refuge_" .. current_faction:name()) and not cm:get_saved_value("delayed_spawn_" .. current_faction:name())
                             and (not cm:get_saved_value("rd_choice_3_" .. current_faction:name()) or cm:model():turn_number() >= cm:get_saved_value("rd_choice_3_" .. current_faction:name()))
                             and not cm:get_saved_value("rd_choice_2_" .. current_faction:name()) then
                              -- faction exceptions
                              if (not is_faction_exempted(current_faction) and not include_seccessionists_value)
                                  or (include_seccessionists_value and (not is_faction_exempted(current_faction) or is_faction_seccessionist(current_faction))) then --and not current_faction:subculture() == "wh_dlc08_sc_nor_norsca"
                                   local prefered_factions = nil
                                   if preferance6_value and preferance6_value ~= "disabled" then
                                        prefered_factions = get_prefered_faction_list(prefered_factions,
                                             preferance6_value, current_faction)
                                   end
                                   if preferance5_value and preferance5_value ~= "disabled" then
                                        prefered_factions = get_prefered_faction_list(prefered_factions,
                                             preferance5_value, current_faction)
                                   end
                                   if preferance4_value and preferance4_value ~= "disabled" then
                                        prefered_factions = get_prefered_faction_list(prefered_factions,
                                             preferance4_value, current_faction)
                                   end
                                   if preferance3_value and preferance3_value ~= "disabled" then
                                        prefered_factions = get_prefered_faction_list(prefered_factions,
                                             preferance3_value, current_faction)
                                   end
                                   if preferance2_value and preferance2_value ~= "disabled" then
                                        prefered_factions = get_prefered_faction_list(prefered_factions,
                                             preferance2_value, current_faction)
                                   end
                                   if preferance1_value and preferance1_value ~= "disabled" then
                                        prefered_factions = get_prefered_faction_list(prefered_factions,
                                             preferance1_value, current_faction)
                                   end
                                   --old
                                   if preferance1_value == "disabled" and preferance2_value == "disabled" and preferance3_value == "disabled"
                                       and preferance4_value == "disabled" and preferance5_value == "disabled" and preferance6_value == "disabled" then
                                        prefered_factions = get_prefered_faction_list(prefered_factions, "random",
                                             current_faction)                                                               -- returns factions_of_same_subculture as vector<string>
                                   end
                                   local prefered_faction = nil
                                   local prefered_faction_key = prefered_factions[1]
                                   --old
                                   --if prefered_factions and #prefered_factions >= 1 then
                                   --    local rng_index = cm:random_number(#prefered_factions)
                                   --    local prefered_faction_key = prefered_factions[rng_index]
                                   --    prefered_faction = cm:get_faction(prefered_faction_key)
                                   --end
                                   if prefered_faction_key then
                                        prefered_faction = cm:get_faction(prefered_faction_key)
                                   end
                                   sm0_log("recruit_defeated_FactionTurnStart | prefered_faction = " ..
                                   tostring(prefered_faction_key) ..
                                   " | dead_faction = " .. tostring(current_faction:name()))
                                   --Limit confederations and thus force spawns to one per subculture
                                   if prefered_faction and ((prefered_faction:is_human() and player_confederation_limit > 1) or not table.contains(subcultures_accepting_refugees, prefered_faction:subculture())) then
                                        if prefered_faction:is_human() then
                                             --if prefered_faction and not faction_P1:is_dead() and current_faction:subculture() == faction_P1:subculture()
                                             --and cm:get_saved_value("rd_choice_1_"..current_faction:name()) ~= faction_P1:name() and prefered_faction:name() == faction_P1:name() then
                                             if not confed_penalty(prefered_faction) and player_confederation_count <= player_confederation_limit and (scope_value == "player_ai" or scope_value == "player")
                                                 and cm:is_factions_turn_by_key(prefered_faction:name()) and not prefered_faction:is_idle_human()
                                             then
                                                  if are_lords_missing(current_faction) then
                                                       sm0_log("[" ..
                                                       player_confederation_count ..
                                                       "] Player 1 intends to spawn missing lords for: " ..
                                                       current_faction:name())
                                                       --spawn_missing_lords(prefered_faction, current_faction)
                                                       --making sure there are no further confederations happening during the spawn_missing_lords loop
                                                       player_confederation_count = player_confederation_count +
                                                       player_confederation_limit
                                                       confederation_count = confederation_count + confederation_limit
                                                  else
                                                       sm0_log("[" ..
                                                       player_confederation_count ..
                                                       "] Player 1 intends to confederate: " .. current_faction:name())
                                                       table.insert(dilemmas,
                                                            { prefered_faction, current_faction,
                                                                 player_confederation_count })
                                                       --rd_dilemma(prefered_faction, current_faction, player_confederation_count)
                                                       --if cm:is_multiplayer() and faction_P1:subculture() == faction_P2:subculture() then
                                                       --    cm:set_saved_value("faction_P1", true)
                                                       --    cm:set_saved_value("faction_P2", false)
                                                       --end
                                                       table.insert(subcultures_accepting_refugees,
                                                            prefered_faction:subculture())
                                                       player_confederation_count = player_confederation_count + 1
                                                       confederation_count = confederation_count + 1
                                                       for i, faction in ipairs(prefered_factions) do
                                                            sm0_log("player_confed | " ..
                                                            tostring("after get_prefered_faction_list") ..
                                                            " | prefered_factions[" .. i .. "]: " .. tostring(faction))
                                                       end
                                                  end
                                             end
                                             --elseif prefered_faction and cm:is_multiplayer() and not faction_P2:is_dead() and current_faction:subculture() == faction_P2:subculture()
                                             --and cm:get_saved_value("rd_choice_1_"..current_faction:name()) ~= faction_P2:name() and prefered_faction:name() == faction_P2:name() then
                                             --    if confed_penalty(faction_P2) == "" and player_confederation_count <= player_confederation_limit and (scope_value == "player_ai"  or scope_value == "player")
                                             --    and context:faction():name() == faction_P2:name() then
                                             --        if are_lords_missing(current_faction) then
                                             --            sm0_log("["..player_confederation_count.."] Player 2 intends to spawn missing lords for: "..current_faction:name())
                                             --            spawn_missing_lords(faction_P2, current_faction)
                                             --            --making sure there are no further confederations happening during the spawn_missing_lords loop
                                             --            player_confederation_count = player_confederation_count + player_confederation_limit
                                             --            confederation_count = confederation_count + confederation_limit
                                             --        else
                                             --            sm0_log("["..player_confederation_count.."] Player 2 intends to confederate: "..current_faction:name())
                                             --            rd_dilemma(faction_P2, current_faction, player_confederation_count)
                                             --            if cm:is_multiplayer() and faction_P1:subculture() == faction_P2:subculture() then
                                             --                cm:set_saved_value("faction_P2", true)
                                             --                cm:set_saved_value("faction_P1", false)
                                             --            end
                                             --            player_confederation_count = player_confederation_count + 1
                                             --        end
                                             --    end
                                        else --ai
                                             if scope_value == "player_ai" or scope_value == "ai" then
                                                  if prefered_faction
                                                      and prefered_faction:subculture() ~= "wh_dlc03_sc_bst_beastmen" and current_faction:subculture() ~= "wh_main_sc_grn_savage_orcs" then -- disabled for beastmen/savage orcs because they are able to respawn anyways
                                                       if ai_delay_value == 1 or cm:model():turn_number() >= ai_delay_value then                                              --if ai_delay == 0 or cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) == 0 then
                                                            if are_lords_missing(current_faction) then
                                                                 sm0_log("[" ..
                                                                 confederation_count ..
                                                                 "] AI: " ..
                                                                 current_faction:name() ..
                                                                 " intends to spawn missing lords!")
                                                                 --spawn_missing_lords(prefered_faction, current_faction)
                                                                 --making sure there are no further confederations happening during the spawn_missing_lords loop
                                                                 player_confederation_count = player_confederation_count +
                                                                 player_confederation_limit
                                                                 confederation_count = confederation_count +
                                                                 confederation_limit
                                                            else
                                                                 sm0_log("[" ..
                                                                 confederation_count ..
                                                                 "] AI: " ..
                                                                 prefered_faction:name() ..
                                                                 " intends to confederate: " .. current_faction:name())
                                                                 table.insert(ai_confeds,
                                                                      { prefered_faction, current_faction })
                                                                 --confed_revived(prefered_faction, current_faction)
                                                                 confederation_count = confederation_count + 1
                                                                 table.insert(subcultures_accepting_refugees,
                                                                      prefered_faction:subculture())
                                                                 --for i, faction in ipairs(prefered_factions) do
                                                                 --    sm0_log("ai_confed | "..tostring("after get_prefered_faction_list").." | prefered_factions["..i.."]: "..tostring(faction))
                                                                 --end
                                                            end
                                                            --else
                                                            --    if not cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) then --if not cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) then
                                                            --        cm:set_saved_value("sm0_rd_delay_"..current_faction:name(), ai_delay - 1) --cm:set_saved_value("sm0_rd_delay_"..current_faction:name(), ai_delay - 1)
                                                            --    else
                                                            --        local turns_delay = cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) - 1 --local turns_delay = cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) - 1
                                                            --        cm:set_saved_value("sm0_rd_delay_"..current_faction:name(), turns_delay) --cm:set_saved_value("sm0_rd_delay_"..current_faction:name(), turns_delay)
                                                            --    end
                                                       end
                                                  end
                                             end
                                        end
                                   end
                              end
                         end
                    end
                    if #ai_confeds >= 1 or #dilemmas >= 1 then
                         cm:disable_event_feed_events(true, "", "", "faction_joins_confederation")
                         cm:disable_event_feed_events(true, "", "", "diplomacy_faction_destroyed")
                         cm:disable_event_feed_events(true, "", "", "diplomacy_faction_encountered")
                         cm:disable_event_feed_events(true, "", "", "diplomacy_trespassing")
                         cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_deaths", "")
                         core:remove_listener("confederation_listener")
                         core:remove_listener("confederation_expired")
                         sm0_log("#ai_confeds >= 1 or #dilemmas >= 1 | disable_event_feed_events")
                    end
                    if #dilemmas >= 1 then
                         local confederator = dilemmas[1][1]
                         local confederated = dilemmas[1][2]
                         local player_confederation_count = dilemmas[1][3]
                         sm0_log("#dilemmas >= 1 | " ..
                         confederator:name() .. " | " .. confederated:name() .. " | " .. player_confederation_count)
                         local subculture = confederator:subculture()
                         core:add_listener(
                              "rd_disable_event_feed_events_DilemmaChoiceMadeEvent",
                              "DilemmaChoiceMadeEvent",
                              function(context)
                                   return context:dilemma() == "sm0_rd_" .. subculture .. "_" ..
                                   player_confederation_count
                              end,
                              function(context)
                                   cm:callback(function()
                                        cm:disable_event_feed_events(false, "", "", "diplomacy_trespassing")
                                        cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_deaths",
                                             "")
                                        cm:disable_event_feed_events(false, "", "", "diplomacy_faction_destroyed")
                                        cm:disable_event_feed_events(false, "", "", "faction_joins_confederation")
                                        cm:disable_event_feed_events(false, "", "", "diplomacy_faction_encountered")
                                        start_confederation_listeners() --global function / wh_campaign_setup.lua
                                        sm0_log("DilemmaChoiceMadeEvent | enable_event_feed_events |" ..
                                        confederator:name() .. " | " .. player_confederation_count)
                                   end, 1, "rd_disable_event_feed_events_callback")
                              end,
                              false
                         )
                    elseif #dilemmas < 1 and #ai_confeds >= 1 then
                         local confederator = ai_confeds[#ai_confeds][1]
                         local confederated = ai_confeds[#ai_confeds][2]
                         sm0_log("#dilemmas >= 1 | " .. confederator:name() .. " | " .. confederator:name())
                         core:add_listener(
                              "rd_disable_event_feed_events_FactionJoinsConfederation",
                              "FactionJoinsConfederation",
                              function(context)
                                   return context:confederation():name() == confederator:name() and
                                   context:faction():name() == confederated:name()
                              end,
                              function(context)
                                   cm:callback(function()
                                        cm:disable_event_feed_events(false, "", "", "diplomacy_trespassing")
                                        cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_deaths",
                                             "")
                                        cm:disable_event_feed_events(false, "", "", "diplomacy_faction_destroyed")
                                        cm:disable_event_feed_events(false, "", "", "faction_joins_confederation")
                                        cm:disable_event_feed_events(false, "", "", "diplomacy_faction_encountered")
                                        start_confederation_listeners() --global function / wh_campaign_setup.lua
                                        sm0_log("FactionJoinsConfederation | enable_event_feed_events | " ..
                                        confederator:name() .. " | " .. confederator:name())
                                   end, 1, "rd_disable_event_feed_events_callback")
                              end,
                              false
                         )
                    end

                    for i = 1, #ai_confeds do
                         local confederator = ai_confeds[i][1]
                         local confederated = ai_confeds[i][2]
                         confed_revived(confederator, confederated)
                         --confed_revived_old(confederator, confederated)
                    end
                    for i = 1, #dilemmas do
                         local confederator = dilemmas[i][1]
                         local confederated = dilemmas[i][2]
                         local player_confederation_count = dilemmas[i][3]
                         sm0_log("rd_dilemma | " ..
                         confederator:name() .. " | " .. confederated:name() .. " | " .. player_confederation_count)
                         rd_dilemma(confederator, confederated, player_confederation_count)
                    end
                    --cm:callback(function()
                    --    if cm:model():difficulty_level() == -3 then
                    --        cm:disable_saving_game(false)
                    --        cm:autosave_at_next_opportunity()
                    --    end
                    --end, 3, "recruit_defeated_FactionTurnStart_callback")
               end,
               true
          )

          core:add_listener(
               "recruit_defeated_FactionJoinsConfederation",
               "FactionJoinsConfederation",
               true,
               function(context)
                    cm:set_saved_value("sought_refuge_" .. context:faction():name(), context:confederation():name())
                    if not cm:get_saved_value("rd_choice_0_" .. context:faction():name()) then sm0_log(
                         "Diplomatic/Norscan/Greenskin Confederation: " ..
                         context:confederation():name() .. " :confederated: " .. context:faction():name()) end

                    --if context:confederation():subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
                    --    local characterList = context:confederation():character_list()
                    --    for i = 0, characterList:num_items() - 1 do
                    --        local current_char = characterList:item_at(i)
                    --        if current_char:is_faction_leader() then --cm:char_is_general(current_char)
                    --            cm:set_character_immortality(cm:char_lookup_str(current_char:command_queue_index()), true)
                    --        end
                    --    end
                    --end
               end,
               true
          )

          --core:add_listener(
          --    "recruit_defeated_ScriptEventConfederationExpired",
          --    "ScriptEventConfederationExpired",
          --    true,
          --    function(context)
          --        local faction = cm:get_faction(context.string)
          --        apply_diplomacy(faction)
          --    end,
          --    true
          --)
          --Multiplayer listener
          core:add_listener(
               "recruit_defeated_UITrigger",
               "UITrigger",
               function(context)
                    return context:trigger():starts_with("RD|")
               end,
               function(context)
                    local faction_cqi = context:faction_cqi()
                    local str = context:trigger()
                    local info = string.gsub(str, "RD|", "")
                    local char_cqi_end = string.find(info, ":")
                    local char_cqi = string.sub(info, 1, char_cqi_end - 1)
                    local subtype_end = string.find(info, ";")
                    local subtype = string.sub(info, char_cqi_end + 1, subtype_end - 1)
                    local confederated = string.sub(info, subtype_end + 1)
                    local character = cm:get_character_by_cqi(char_cqi)
                    local confederator
                    local confederated_faction = cm:get_faction(confederated)
                    local human_factions = cm:get_human_factions()
                    --sm0_log("Faction event recruit_defeated_UITrigger | subtype: "..tostring(subtype))
                    for i = 1, #human_factions do
                         local human_faction = cm:get_faction(human_factions[i])
                         if human_faction:command_queue_index() == faction_cqi then
                              confederator = human_factions[i]
                         end
                    end
                    if not character and confederated_faction then
                         local character_list = confederated_faction:character_list()
                         for i = 0, character_list:num_items() - 1 do
                              local current_char = character_list:item_at(i)
                              if current_char:character_subtype_key() == subtype then
                                   character = current_char
                              end
                         end
                    end
                    if character then
                         local picture = faction_event_picture[confederator]
                         if not is_number(picture) then
                              local confederator_faction = cm:get_faction(confederator)
                              picture = subculture_event_picture[confederator_faction:subculture()]
                         end
                         local char_type = "legendary_lord"
                         if cm:char_is_agent(character) then char_type = "legendary_hero" end
                         --sm0_log("Faction event picture | Number: "..tostring(picture))
                         --sm0_log("Faction event Title 1: "..common.get_localised_string("event_feed_strings_text_title_event_" .. char_type .. "_available"))
                         --sm0_log("Faction event Title 2: "..common.get_localised_string("event_feed_strings_text_title_event_"..subtype.."_LL_unlocked"))
                         --sm0_log("Faction event Description: "..common.get_localised_string("event_feed_strings_text_description_event_"..subtype.."_LL_unlocked"))
                         if picture and common.get_localised_string("event_feed_strings_text_title_event_" .. subtype .. "_LL_unlocked")
                             and common.get_localised_string("event_feed_strings_text_description_event_" .. subtype .. "_LL_unlocked") and char_type then
                              cm:show_message_event(
                                   confederator,
                                   "event_feed_strings_text_title_event_" .. char_type .. "_available",
                                   "event_feed_strings_text_title_event_" .. subtype .. "_LL_unlocked",
                                   "", --"event_feed_strings_text_description_event_" .. subtype .. "_LL_unlocked",
                                   true,
                                   picture
                              )
                         end
                    end
               end,
               true
          )
          if cm:get_saved_value("sm0_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked") then
               ancillary_on_rankup(alastar_quests, "wh2_main_hef_prince_alastar")
          end
          --if not (cm:get_saved_value("wulfharts_agents_".."wh2_dlc13_emp_hunter_doctor_hertwig_van_hal".."_spawned")
          --and cm:get_saved_value("wulfharts_agents_".."wh2_dlc13_emp_hunter_jorek_grimm".."_spawned")
          --and cm:get_saved_value("wulfharts_agents_".."wh2_dlc13_emp_hunter_kalara_of_wydrioth".."_spawned")
          --and cm:get_saved_value("wulfharts_agents_".."wh2_dlc13_emp_hunter_rodrik_l_anguille".."_spawned")) then
          --    core:add_listener(
          --        "recruit_defeated_wulfhart_CharacterTurnStart",
          --        "CharacterTurnStart",
          --        function(context)
          --            local wulfhart_faction = cm:get_faction("wh2_dlc13_emp_the_huntmarshals_expedition")
          --            return context:character():character_subtype_key() == "wh2_dlc13_emp_cha_markus_wulfhart"
          --            and wulfhart_faction and wulfhart_faction:is_dead() and not context:character():faction():is_dead()
          --        end,
          --        function(context)
          --            local wulfharts_agents = {
          --                {agent_subtype = "wh2_dlc13_emp_hunter_doctor_hertwig_van_hal", turn = 1},
          --                {agent_subtype = "wh2_dlc13_emp_hunter_jorek_grimm", turn = 10},
          --                {agent_subtype = "wh2_dlc13_emp_hunter_kalara_of_wydrioth", turn = 20},
          --                {agent_subtype = "wh2_dlc13_emp_hunter_rodrik_l_anguille", turn = 30},
          --            }
          --            local turn_number = cm:model():turn_number()
          --            local refuge_faction = context:character():faction()
          --            local wulfhart_faction_cqi = refuge_faction:command_queue_index()
          --            local wulfhart_capital_cqi
          --            if refuge_faction:has_home_region() then
          --                wulfhart_capital_cqi = refuge_faction:home_region():cqi()
          --            elseif not refuge_faction:military_force_list():item_at(0):general_character():is_at_sea() and refuge_faction:military_force_list():item_at(0):general_character():has_region() then
          --                wulfhart_capital_cqi = refuge_faction:military_force_list():item_at(0):general_character():region():cqi()
          --            end
          --            if wulfhart_capital_cqi and wulfhart_faction_cqi then
          --                for k = 1, #wulfharts_agents do
          --                    if turn_number > wulfharts_agents[k].turn and not cm:get_saved_value("wulfharts_agents_"..wulfharts_agents[k].agent_subtype.."_spawned") then
          --                        local char_found = false
          --                        local faction_list = cm:model():world():faction_list()
          --                        for i = 0, faction_list:num_items() - 1 do
          --                            local current_faction = faction_list:item_at(i)
          --                            local char_list = current_faction:character_list()
          --                            for j = 0, char_list:num_items() - 1 do
          --                                local current_char = char_list:item_at(j)
          --                                if current_char:character_subtype_key() == wulfharts_agents[k].agent_subtype then
          --                                    char_found = true
          --                                    cm:set_saved_value("wulfharts_agents_"..wulfharts_agents[k].agent_subtype.."_spawned", true)
          --                                end
          --                            end
          --                        end
          --                        if not char_found then
          --                            sm0_log("spawn_missing_lords: "..wulfharts_agents[k].agent_subtype.." spawned!")
          --                            cm:spawn_unique_agent_at_region(wulfhart_faction_cqi, wulfharts_agents[k].agent_subtype, wulfhart_capital_cqi, false)
          --                            cm:set_saved_value("wulfharts_agents_"..wulfharts_agents[k].agent_subtype.."_spawned", true)
          --                        end
          --                    end
          --                end
          --            end
          --        end,
          --        true
          --    )
          --else
          --    core:remove_listener("recruit_defeated_wulfhart_CharacterTurnStart")
          --end
     end
end

local function update_recruit_defeated_mct_settings(mct)
     local recruit_defeated_mod = mct:get_mod_by_key("recruit_defeated")
     local settings_table = recruit_defeated_mod:get_settings()
     enable_value = settings_table.a_enable
     scope_value = settings_table.c_scope
     ai_delay_value = settings_table.d_ai_delay
     preferance1_value = settings_table.a_preferance1
     preferance2_value = settings_table.b_preferance2
     preferance3_value = settings_table.c_preferance3
     preferance4_value = settings_table.d_preferance4
     preferance5_value = settings_table.e_preferance5
     preferance6_value = settings_table.f_preferance6
     tmb_restriction_value = settings_table.a_tmb_restriction
     cst_restriction_value = settings_table.b_cst_restriction
     wef_restriction_value = settings_table.d_wef_restriction
     savage_restriction_value = settings_table.c_savage_restriction
     chs_restriction_value = settings_table.chs_restriction

     playable_faction_only_value = settings_table.playable_faction_only
     include_seccessionists_value = settings_table.include_seccessionists
     dilemmas_per_turn_value = settings_table.dilemmas_per_turn
     --dilemmas_per_turn_per_sc_value = settings_table.dilemmas_per_turn_per_sc
     cross_race_value = settings_table.cross_race
     dilemmas_per_turn_player_value = settings_table.dilemmas_per_turn_player
     refugee_types_value = settings_table.refugee_types
     nakai_vassal_value = settings_table.nakai_vassal

     --local a_enable = recruit_defeated_mod:get_option_by_key("a_enable")
     --enable_value = a_enable:get_finalized_setting()
     --local c_scope = recruit_defeated_mod:get_option_by_key("c_scope")
     --scope_value = c_scope:get_finalized_setting()
     --local d_ai_delay = recruit_defeated_mod:get_option_by_key("d_ai_delay")
     --ai_delay_value = d_ai_delay:get_finalized_setting()
     --local a_preferance1 = recruit_defeated_mod:get_option_by_key("a_preferance1")
     --preferance1_value = a_preferance1:get_finalized_setting()
     --local b_preferance2 = recruit_defeated_mod:get_option_by_key("b_preferance2")
     --preferance2_value = b_preferance2:get_finalized_setting()
     --local c_preferance3 = recruit_defeated_mod:get_option_by_key("c_preferance3")
     --preferance3_value = c_preferance3:get_finalized_setting()
     --local d_preferance4 = recruit_defeated_mod:get_option_by_key("d_preferance4")
     --preferance4_value = d_preferance4:get_finalized_setting()
     --local e_preferance5 = recruit_defeated_mod:get_option_by_key("e_preferance5")
     --preferance5_value = e_preferance5:get_finalized_setting()
     --local f_preferance6 = recruit_defeated_mod:get_option_by_key("f_preferance6")
     --preferance6_value = f_preferance6:get_finalized_setting()
     --local a_tmb_restriction = recruit_defeated_mod:get_option_by_key("a_tmb_restriction")
     --tmb_restriction_value = a_tmb_restriction:get_finalized_setting()
     --local b_cst_restriction = recruit_defeated_mod:get_option_by_key("b_cst_restriction")
     --cst_restriction_value = b_cst_restriction:get_finalized_setting()
     --local d_wef_restriction = recruit_defeated_mod:get_option_by_key("d_wef_restriction")
     --wef_restriction_value = d_wef_restriction:get_finalized_setting()
     --local c_savage_restriction = recruit_defeated_mod:get_option_by_key("c_savage_restriction")
     --savage_restriction_value = c_savage_restriction:get_finalized_setting()
end

core:add_listener(
     "recruit_defeated_MctInitialized",
     "MctInitialized",
     true,
     function(context)
          local mct = context:mct()
          update_recruit_defeated_mct_settings(mct)
     end,
     true
)

core:add_listener(
     "recruit_defeated_MctFinalized",
     "MctFinalized",
     true,
     function(context)
          local mct = context:mct()
          update_recruit_defeated_mct_settings(mct)
          init_recruit_defeated_listeners(enable_value)
          sm0_log("recruit_defeated_MctInitialized/enable_value = " .. tostring(enable_value))
          sm0_log("recruit_defeated_MctInitialized/scope_value = " .. tostring(scope_value))
          sm0_log("recruit_defeated_MctInitialized/ai_delay_value = " .. tostring(ai_delay_value))
          sm0_log("recruit_defeated_MctInitialized/preferance1_value = " .. tostring(preferance1_value))
          sm0_log("recruit_defeated_MctInitialized/preferance2_value = " .. tostring(preferance2_value))
          sm0_log("recruit_defeated_MctInitialized/preferance3_value = " .. tostring(preferance3_value))
          sm0_log("recruit_defeated_MctInitialized/preferance4_value = " .. tostring(preferance4_value))
          sm0_log("recruit_defeated_MctInitialized/preferance5_value = " .. tostring(preferance5_value))
          sm0_log("recruit_defeated_MctInitialized/preferance6_value = " .. tostring(preferance6_value))
          sm0_log("recruit_defeated_MctInitialized/tmb_restriction_value = " .. tostring(tmb_restriction_value))
          sm0_log("recruit_defeated_MctInitialized/cst_restriction_value = " .. tostring(cst_restriction_value))
          sm0_log("recruit_defeated_MctInitialized/wef_restriction_value = " .. tostring(wef_restriction_value))
          sm0_log("recruit_defeated_MctInitialized/savage_restriction_value = " .. tostring(savage_restriction_value))
          sm0_log("recruit_defeated_MctInitialized/chs_restriction_value = " .. tostring(chs_restriction_value))
          sm0_log("recruit_defeated_MctInitialized/playable_faction_only_value = " ..
          tostring(playable_faction_only_value))
          sm0_log("recruit_defeated_MctInitialized/include_seccessionists_value = " ..
          tostring(include_seccessionists_value))
          sm0_log("recruit_defeated_MctInitialized/dilemmas_per_turn_value = " .. tostring(dilemmas_per_turn_value))
          sm0_log("recruit_defeated_MctInitialized/dilemmas_per_turn_per_sc_value = " ..
          tostring(dilemmas_per_turn_per_sc_value))
          sm0_log("recruit_defeated_MctInitialized/cross_race_value = " .. tostring(cross_race_value))
          sm0_log("recruit_defeated_MctInitialized/dilemmas_per_turn_player_value = " ..
          tostring(dilemmas_per_turn_player_value))
          sm0_log("recruit_defeated_MctInitialized/refugee_types_value = " .. tostring(refugee_types_value))
          sm0_log("recruit_defeated_MctInitialized/nakai_vassal_value = " .. tostring(nakai_vassal_value))
     end,
     true
)

function sm0_recruit_defeated()
     RDDEBUG()
     local mct
     if get_mct then
          mct = get_mct()
     end

     local version_number =
     "6.0.1"                       --debug: "vs.code" --H&B "1.0" --S&B "1.1" --MCM "2.0" --wh3 release "3.0" --mct support "3.1" --wh3 update 5.1.0 (create_force issue)
     if cm:is_new_game() then
          if not cm:get_saved_value("sm0_log_reset") then
               sm0_log_reset()
               cm:set_saved_value("sm0_log_reset", true)
          end
          if mct then
               sm0_log("Mod Version: RDLL" .. "(" .. version_number .. ")" .. " - MCT enabled")
          else
               sm0_log("Mod Version: RDLL" .. "(" .. version_number .. ")")
          end
     end

     if cm:get_campaign_name() ~= "wh3_main_prologue" then
          --if vfs.exists("script/campaign/mod/!ovn_me_lost_factions_start.lua") then
          --    cm:force_diplomacy("faction:wh2_main_emp_grudgebringers", "all", "form confederation", false, false, false, false)
          --    cm:force_diplomacy("faction:wh2_main_emp_the_moot", "all", "form confederation", false, false, false, false)
          --end

          if mct then
               --sm0_log("sm0_confed/mct/enable_value = "..tostring(enable_value))
               --sm0_log("sm0_confed/mct/restriction_value = "..tostring(restriction_value))
               --[[
            local confederation_options_mod = mct:get_mod_by_key("confederation_options")
            if confederation_options_mod and cm:is_new_game() then
                local tk_option = confederation_options_mod:get_option_by_key("wh2_dlc09_sc_tmb_tomb_kings")
                if tk_option then
                    local tk_value = tk_option:get_finalized_setting()
                    if tk_value == "no_tweak" then
                        cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false, false)
                    end
                end
                --local cst_option = confederation_options_mod:get_option_by_key("wh2_dlc11_sc_cst_vampire_coast")
                --if cst_option then
                --    local cst_value = cst_option:get_finalized_setting()
                --    if cst_value == "no_tweak" then
                --        cm:force_diplomacy("subculture:wh2_dlc11_sc_cst_vampire_coast", "subculture:wh2_dlc11_sc_cst_vampire_coast", "form confederation", false, false, false, false)
                --    end
                --end
                --local teb_option = confederation_options_mod:get_option_by_key("wh_main_sc_teb_teb")
                --if teb_option then
                --    local teb_value = teb_option:get_finalized_setting()
                --    if teb_value == "no_tweak" and not vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then
                --        cm:force_diplomacy("subculture:wh_main_sc_teb_teb", "subculture:wh_main_sc_teb_teb", "form confederation", false, false, false, false)
                --    end
                --end
                --local araby_option = confederation_options_mod:get_option_by_key("wh_main_sc_emp_araby")
                --if araby_option then
                --    local araby_value = araby_option:get_finalized_setting()
                --    if araby_value == "no_tweak" then
                --        cm:force_diplomacy("subculture:wh_main_sc_emp_araby", "subculture:wh_main_sc_emp_araby", "form confederation", false, false, false)
                --    end
                --end
            end
            --]]
               sm0_log("recruit_defeated_MctInitialized/enable_value = " .. tostring(enable_value))
               sm0_log("recruit_defeated_MctInitialized/scope_value = " .. tostring(scope_value))
               sm0_log("recruit_defeated_MctInitialized/ai_delay_value = " .. tostring(ai_delay_value))
               sm0_log("recruit_defeated_MctInitialized/preferance1_value = " .. tostring(preferance1_value))
               sm0_log("recruit_defeated_MctInitialized/preferance2_value = " .. tostring(preferance2_value))
               sm0_log("recruit_defeated_MctInitialized/preferance3_value = " .. tostring(preferance3_value))
               sm0_log("recruit_defeated_MctInitialized/preferance4_value = " .. tostring(preferance4_value))
               sm0_log("recruit_defeated_MctInitialized/preferance5_value = " .. tostring(preferance5_value))
               sm0_log("recruit_defeated_MctInitialized/preferance6_value = " .. tostring(preferance6_value))
               sm0_log("recruit_defeated_MctInitialized/tmb_restriction_value = " .. tostring(tmb_restriction_value))
               sm0_log("recruit_defeated_MctInitialized/cst_restriction_value = " .. tostring(cst_restriction_value))
               sm0_log("recruit_defeated_MctInitialized/wef_restriction_value = " .. tostring(wef_restriction_value))
               sm0_log("recruit_defeated_MctInitialized/savage_restriction_value = " ..
               tostring(savage_restriction_value))
               sm0_log("recruit_defeated_MctInitialized/chs_restriction_value = " .. tostring(chs_restriction_value))
               sm0_log("recruit_defeated_MctInitialized/playable_faction_only_value = " ..
               tostring(playable_faction_only_value))
               sm0_log("recruit_defeated_MctInitialized/include_seccessionists_value = " ..
               tostring(include_seccessionists_value))
               sm0_log("recruit_defeated_MctInitialized/dilemmas_per_turn_value = " .. tostring(dilemmas_per_turn_value))
               sm0_log("recruit_defeated_MctInitialized/dilemmas_per_turn_per_sc_value = " ..
               tostring(dilemmas_per_turn_per_sc_value))
               sm0_log("recruit_defeated_MctInitialized/cross_race_value = " .. tostring(cross_race_value))
               sm0_log("recruit_defeated_MctInitialized/dilemmas_per_turn_player_value = " ..
               tostring(dilemmas_per_turn_player_value))
               sm0_log("recruit_defeated_MctInitialized/refugee_types_value = " .. tostring(refugee_types_value))
               sm0_log("recruit_defeated_MctInitialized/nakai_vassal_value = " .. tostring(nakai_vassal_value))
          else
               for i = 1, #confed_restricted_subcultures do
                    cm:force_diplomacy("subculture:" .. confed_restricted_subcultures[i],
                         "subculture:" .. confed_restricted_subcultures[i], "form confederation", false, false, false,
                         false)
               end

               --enable_value = true
               --tmb_restriction_value = false
               --cst_restriction_value = false
               --wef_restriction_value = false
               --savage_restriction_value = false
               --chs_restriction_value = "no_restrictions"
               --scope_value = "player_ai" --"player_ai"
               --ai_delay_value = 50 --50
               --preferance1_value = "race" --"player"
               --preferance2_value = "player" --"met"
               --preferance3_value = "met" --"relation"
               --preferance4_value = "relation" --"major"
               --preferance5_value = "major" --"disabled"
               --preferance6_value = "disabled" --"disabled"
               --playable_faction_only_value = false
               --include_seccessionists_value = false
               --dilemmas_per_turn_value = 10
               --dilemmas_per_turn_per_sc_value = 1
               --cross_race_value = "disable"
               --dilemmas_per_turn_player_value = 1
               --refugee_types_value = "disable"
               --nakai_vassal_value = "do_nothing"
               --sm0_log("sm0_recruit_defeated | enable_value = "..tostring(enable_value)..
               --" | scope_value = "..tostring(scope_value).." | ai_delay_value = "..tostring(ai_delay_value)..
               --" | preferance1_value = "..tostring(preferance1_value).." | preferance2_value = "..tostring(preferance2_value).." | preferance3_value = "..tostring(preferance3_value))
          end
          init_recruit_defeated_listeners(enable_value)
     end
end
