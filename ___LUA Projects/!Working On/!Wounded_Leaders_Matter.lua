local dwarf_grudge = _G[dwarf_grudge_key]
local bundle_key = "Sam_Wounded_Leader"
local effect_groups = {
    default_effects = {},
	

    wh2_dlc09_sc_tmb_tomb_kings = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc11_sc_cst_vampire_coast = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_sc_def_dark_elves = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_sc_hef_high_elves = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_sc_lzd_lizardmen = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_sc_skv_skaven = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_dlc05_sc_wef_wood_elves = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_sc_brt_bretonnia = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_sc_emp_empire = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh3_main_effect_corruption_vampiric_events_bad", effect_scope = "faction_to_region_own", value = 0},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_sc_ksl_kislev = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_sc_teb_teb = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_sc_dwf_dwarfs = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_sc_grn_greenskins = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_sc_grn_savage_orcs = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_sc_nor_norsca = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_sc_vmp_vampire_counts = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_sc_nur_nurgle = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_sc_kho_khorne = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_sc_tze_tzeentch = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_sc_sla_slaanesh = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_sc_dae_daemons = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_sc_cth_cathay = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_sc_ksl_kislev = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_sc_ogr_ogre_kingdoms = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc09_tmb_khemri = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh2_main_effect_building_construction_time_mod_all", effect_scope = "faction_to_region_own", value = 15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc09_tmb_followers_of_nagash = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc09_tmb_lybaras = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc09_tmb_exiles_of_nehek = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc11_cst_noctilus = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh_main_effect_raise_dead_recruitment_cost_mod", effect_scope = "faction_to_character_own", value = 25},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc11_cst_pirates_of_sartosa = {
        {effect_key = "wh_main_effect_force_all_campaign_movement_range", effect_scope = "faction_to_navy_own", value = -25},
        {effect_key = "wh_main_effect_raise_dead_recruitment_cost_mod", effect_scope = "faction_to_character_own", value = 25},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc11_cst_the_drowned = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_character_stat_mod_miscast_chance", effect_scope = "faction_to_force_own", value = 15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc11_cst_vampire_coast = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -8},
        {effect_key = "wh_main_effect_force_stat_missile_damage", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc11_def_the_blessed_dread = {
        {effect_key = "wh_main_effect_force_all_campaign_movement_range", effect_scope = "faction_to_navy_own", value = -25},
        {effect_key = "wh_main_effect_force_stat_melee_attack", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_def_cult_of_pleasure = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_agent_action_cost_mod", effect_scope = "faction_to_character_own", value = 25},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_def_naggarond = {
        {effect_key = "wh_main_effect_force_all_campaign_replenishment_rate", effect_scope = "faction_to_force_own", value = -4.25},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_def_hag_graef = {
        {effect_key = "wh_main_effect_force_stat_leadership", effect_scope = "faction_to_force_own", value = -6.75},
        {effect_key = "wh3_main_effect_corruption_chaos_events_bad", effect_scope = "faction_to_region_own", value = 0},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_def_har_ganeth = {
        {effect_key = "wh_main_effect_force_stat_melee_attack", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -10}
    },
    wh2_twa03_def_rakarth = {
        {effect_key = "wh_main_effect_force_stat_melee_attack", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_hef_avelorn = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_hef_eataine = {
        {effect_key = "wh2_main_effect_force_stat_melee_attack_vs_dark_elves", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_hef_nagarythe = {
        {effect_key = "wh_main_effect_agent_action_cost_mod", effect_scope = "faction_to_character_own", value = 25},
        {effect_key = "wh_main_effect_force_stat_missile_damage", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_hef_order_of_loremasters = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_character_stat_mod_miscast_chance", effect_scope = "faction_to_force_own", value = 15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_hef_yvresse = {
        {effect_key = "wh2_main_effect_building_construction_time_mod_all", effect_scope = "faction_to_region_own", value = 15},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc15_hef_imrik = {
        {effect_key = "wh_main_effect_force_stat_armour", effect_scope = "faction_to_force_own", value = -12.5},
        {effect_key = "wh_main_effect_force_all_campaign_recruitment_cost_all", effect_scope = "faction_to_force_own", value = 15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc12_lzd_cult_of_sotek = {
        {effect_key = "wh_main_effect_force_all_campaign_replenishment_rate", effect_scope = "faction_to_force_own", value = -4.25},
        {effect_key = "wh3_main_effect_corruption_chaos_events_bad", effect_scope = "faction_to_region_own", value = 0},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc13_lzd_spirits_of_the_jungle = {
        {effect_key = "wh2_dlc13_lzd_weapon_strength_kroxigor", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_lzd_hexoatl = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_lzd_itza = {
        {effect_key = "wh_main_effect_force_stat_leadership", effect_scope = "faction_to_force_own", value = -6.75},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_lzd_last_defenders = {
        {effect_key = "wh_main_effect_force_stat_melee_attack", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_lzd_tlaqua = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_force_stat_speed", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc17_lzd_oxyotl = {
        {effect_key = "wh_main_effect_force_stat_leadership", effect_scope = "faction_to_force_own", value = -6.75},
        {effect_key = "wh_main_effect_force_stat_speed", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc09_skv_clan_rictus = {
        {effect_key = "wh_main_effect_force_stat_speed", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh2_main_effect_character_mod_loyalty_new_turn", effect_scope = "faction_to_character_own", value = -1},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_skv_clan_eshin = {
        {effect_key = "wh_main_effect_agent_action_cost_mod", effect_scope = "faction_to_character_own", value = 25},
        {effect_key = "wh2_main_pooled_resource_skaven_food_army", effect_scope = "faction_to_force_own", value = -1},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_skv_clan_mors = {
        {effect_key = "wh_main_effect_force_stat_melee_attack", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh2_main_effect_character_mod_loyalty_new_turn", effect_scope = "faction_to_character_own", value = -1},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_skv_clan_pestilens = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh2_main_effect_character_mod_loyalty_new_turn", effect_scope = "faction_to_character_own", value = -1},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1}
    },
    wh2_main_skv_clan_skyre = {
        {effect_key = "wh_main_effect_technology_research_points", effect_scope = "faction_to_faction_own", value = -20},
        {effect_key = "wh2_main_effect_character_mod_loyalty_new_turn", effect_scope = "faction_to_character_own", value = -1},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_main_skv_clan_moulder = {
        {effect_key = "wh_main_effect_force_stat_melee_attack", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_dlc05_wef_argwylon = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_dlc05_wef_wood_elves = {
        {effect_key = "wh_main_effect_force_stat_leadership", effect_scope = "faction_to_force_own", value = -6.75},
        {effect_key = "wh_main_effect_force_stat_missile_damage", effect_scope = "faction_to_force_own", value = -8.75},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc16_wef_sisters_of_twilight = {
        {effect_key = "wh_main_effect_force_stat_leadership", effect_scope = "faction_to_force_own", value = -6.75},
        {effect_key = "wh_main_effect_force_stat_missile_damage", effect_scope = "faction_to_force_own", value = -8.75},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc16_wef_drycha = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_force_stat_missile_damage", effect_scope = "faction_to_force_own", value = -8.75},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc14_brt_chevaliers_de_lyonesse = {
        {effect_key = "wh_main_effect_force_stat_armour", effect_scope = "faction_to_force_own", value = -12.5},
        {effect_key = "wh3_main_effect_corruption_chaos_events_bad", effect_scope = "faction_to_region_own", value = 0},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_brt_bordeleaux = {
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_brt_bretonnia = {
        {effect_key = "wh_main_effect_force_all_campaign_upkeep", effect_scope = "faction_to_force_own", value = 5},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_brt_carcassonne = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_force_all_campaign_upkeep", effect_scope = "faction_to_force_own", value = 5},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc13_emp_golden_order = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh2_main_effect_force_stat_miscast", effect_scope = "faction_to_force_own", value = 0},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc13_emp_the_huntmarshals_expedition = {
        {effect_key = "wh_main_effect_force_stat_leadership", effect_scope = "faction_to_force_own", value = -6.75},
        {effect_key = "wh_main_effect_force_stat_missile_damage", effect_scope = "faction_to_force_own", value = -8.75}
    },
    wh_main_emp_empire = {
        {effect_key = "wh_main_effect_force_all_campaign_upkeep", effect_scope = "faction_to_force_own", value = 0},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_emp_cult_of_sigmar = {
        {effect_key = "wh_main_effect_force_all_campaign_upkeep", effect_scope = "faction_to_force_own", value = 0},
        {effect_key = "wh_main_effect_force_stat_melee_attack", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_grn_crooked_moon = {
        {effect_key = "wh_main_effect_force_stat_speed", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh_main_effect_force_stat_melee_attack", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1}
    },
    wh_main_grn_greenskins = {
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh_main_effect_force_stat_armour", effect_scope = "faction_to_force_own", value = -12.5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_grn_orcs_of_the_bloody_hand = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh2_main_effect_force_stat_miscast", effect_scope = "faction_to_force_own", value = 0},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc15_grn_bonerattlaz = {
        {effect_key = "wh3_main_effect_corruption_vampiric_events_bad", effect_scope = "faction_to_region_own", value = 0},
        {effect_key = "wh_main_effect_force_stat_leadership", effect_scope = "faction_to_force_own", value = -6.75},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc15_grn_broken_axe = {
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh2_main_effect_force_all_campaign_sacking_income", effect_scope = "faction_to_character_own", value = -15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_dwf_dwarfs = {
        {effect_key = "wh_main_effect_force_all_campaign_upkeep", effect_scope = "faction_to_force_own", value = 0},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_dwf_karak_izor = {
        {effect_key = "wh3_main_effect_corruption_chaos_events_bad", effect_scope = "faction_to_region_own", value = 0},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_dwf_karak_kadrin = {
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh_main_effect_force_stat_melee_attack", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc17_dwf_thorek_ironbrow = {
        {effect_key = "wh_main_effect_force_all_campaign_upkeep", effect_scope = "faction_to_force_own", value = 0},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_dwf_the_ancestral_throng = {
        {effect_key = "wh_main_effect_force_all_campaign_upkeep", effect_scope = "faction_to_force_own", value = 0},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_dlc08_nor_norsca = {
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh_main_effect_force_stat_weapon_strength", effect_scope = "faction_to_force_own", value = -7.5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_dlc08_nor_wintertooth = {
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh_main_effect_force_stat_weapon_strength", effect_scope = "faction_to_force_own", value = -7.5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh2_dlc11_vmp_the_barrow_legion = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_raise_dead_recruitment_cost_mod", effect_scope = "faction_to_character_own", value = 15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_vmp_schwartzhafen = {
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = -5},
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = 5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh_main_vmp_vampire_counts = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_raise_dead_recruitment_cost_mod", effect_scope = "faction_to_character_own", value = 15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_vmp_caravan_of_blue_roses = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_raise_dead_recruitment_cost_mod", effect_scope = "faction_to_character_own", value = 15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_nur_poxmakers_of_nurgle = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_force_stat_melee_defence", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_kho_exiles_of_khorne = {
        {effect_key = "wh_main_effect_force_all_campaign_upkeep", effect_scope = "faction_to_force_own", value = 0},
        {effect_key = "wh_main_effect_force_stat_melee_attack", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_tze_oracles_of_tzeentch = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh2_main_effect_force_stat_miscast", effect_scope = "faction_to_force_own", value = 0},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_sla_seducers_of_slaanesh = {
        {effect_key = "wh_main_effect_force_stat_speed", effect_scope = "faction_to_force_own", value = -10},
        {effect_key = "wh3_main_effect_force_all_seduce_units_budget", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_dae_daemon_prince = {
        {effect_key = "wh_main_effect_force_all_campaign_replenishment_rate", effect_scope = "faction_to_force_own", value = -4.25},
        {effect_key = "wh_main_effect_force_all_campaign_recruitment_cost_all", effect_scope = "faction_to_force_own", value = 10},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_cth_the_northern_provinces = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_force_stat_missile_damage", effect_scope = "faction_to_region_own", value = -8},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_cth_the_western_provinces = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh3_main_effect_corruption_chaos_events_bad", effect_scope = "faction_to_region_own", value = 0},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_ksl_the_ice_court = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh_main_effect_force_stat_melee_attack_vs_chaos_norsca", effect_scope = "faction_to_force_own", value = -6},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_ksl_the_great_orthodoxy = {
        {effect_key = "wh_main_effect_force_all_campaign_upkeep", effect_scope = "faction_to_force_own", value = 0},
        {effect_key = "wh3_main_effect_corruption_chaos_events_bad", effect_scope = "faction_to_region_own", value = 0},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_ksl_ursun_revivalists = {
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh_main_effect_force_stat_melee_attack_vs_chaos_norsca", effect_scope = "faction_to_force_own", value = -6},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_ogr_goldtooth = {
        {effect_key = "wh_main_effect_force_stat_charge_bonus_pct", effect_scope = "faction_to_force_own", value = -15},
        {effect_key = "wh2_main_effect_force_all_campaign_sacking_income", effect_scope = "faction_to_character_own", value = -15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    },
    wh3_main_ogr_disciples_of_the_maw = {
        {effect_key = "wh3_main_effect_winds_of_magic_events", effect_scope = "faction_to_force_own", value = -9.75},
        {effect_key = "wh2_main_effect_force_all_campaign_sacking_income", effect_scope = "faction_to_character_own", value = -15},
        {effect_key = "wh_main_effect_agent_action_success_chance", effect_scope = "faction_to_character_own", value = 5},
        {effect_key = "wh_main_effect_public_order_events", effect_scope = "faction_to_province_own_factionwide", value = -5},
        {effect_key = "wh_main_effect_force_unit_stat_morale", effect_scope = "faction_to_force_own", value = -5},
        {effect_key = "Sam_Wounded_Leader_Dummy", effect_scope = "faction_to_faction_own_unseen", value = 1},
        {effect_key = "wh_main_effect_growth_all", effect_scope = "faction_to_province_own", value = -12.5}
    }
}
local default_effects_blacklist = {true}
local function is_faction_of_type(faction_to_test, is_human)
    local h = faction_to_test:is_human()
    if is_human == false then
        return not h
    elseif is_human == true then
        return h
    end
    return true
end
local function build_wounded_leader_bundle(target_faction)
    local faction_key = target_faction:name()
    local sub_key = target_faction:subculture()
    local new_bundle = cm:create_new_custom_effect_bundle(bundle_key)
    out("WoundedLeader: Building wounded leader bundle for " .. faction_key .. " of subculture " .. sub_key)
    local added_effects = false
    if not default_effects_blacklist[sub_key] and (not default_effects_blacklist[faction_key]) then
        local effect_entries = effect_groups.default_effects
        for i = 1, #effect_entries do
            local effect_record = effect_entries[i]
            if is_faction_of_type(target_faction, effect_record.is_human) then
                new_bundle:add_effect(effect_record.effect_key, effect_record.effect_scope, effect_record.value)
                added_effects = true
            end
        end
    end
    if effect_groups[faction_key] then
        out("WoundedLeader: Adding effects for faction key to bundle")
        local effect_entries = effect_groups[faction_key]
        for i = 1, #effect_entries do
            local effect_record = effect_entries[i]
            if is_faction_of_type(target_faction, effect_record.is_human) then
                new_bundle:add_effect(effect_record.effect_key, effect_record.effect_scope, effect_record.value)
                added_effects = true
            end
        end
    end
    if effect_groups[sub_key] then
        out("Adding effects for sub key to bundle")
        local effect_entries = effect_groups[sub_key]
        for i = 1, #effect_entries do
            local effect_record = effect_entries[i]
            if is_faction_of_type(target_faction, effect_record.is_human) then
                new_bundle:add_effect(effect_record.effect_key, effect_record.effect_scope, effect_record.value)
                added_effects = true
            end
        end
    end
    if added_effects then
        cm:apply_custom_effect_bundle_to_faction(new_bundle, target_faction)
        out("WoundedLeader: Building Successfully completed and effects applied.")
    end
end
local function check_faction_leader_status(faction)
    if (faction:faction_leader()):is_wounded() and (not faction:has_effect_bundle(bundle_key)) then
        out("WoundedLeader: Leader is wounded, building bundles for faction")
        build_wounded_leader_bundle(faction)
    elseif not (faction:faction_leader()):is_wounded() and faction:has_effect_bundle(bundle_key) then
        out("WoundedLeader: Leader is no longer wounded, removing bundles for faction")
        cm:remove_effect_bundle(bundle_key, faction:name())
    end
end
local function is_character_attacker(pb, character)
    if character:command_queue_index() == (pb:attacker()):command_queue_index() then return true end
    for i = 0, (pb:secondary_attackers()):num_items() - 1 do
        if ((pb:secondary_attackers()):item_at(i)):command_queue_index() == character:command_queue_index() then return true end
    end
    return false
end
cm:add_first_tick_callback(function()
    core:add_listener("CheckWoundedFactionLeaders", "FactionTurnStart", function(context) return not ((context:faction()):faction_leader()):is_null_interface() end,
                      function(context)
        local faction = context:faction()
        local ok, err = pcall(function()
            out("WoundedLeader: Checking faction: " .. faction:name() .. " for wounded leader")
            check_faction_leader_status(faction)
        end)
        if not ok then
            out("WoundedLeader: **********************************************************************************************************")
            out("WoundedLeader: **********************************************************************************************************")
            out("WoundedLeader: " .. tostring(err))
            out("WoundedLeader: " .. debug.traceback())
            out("WoundedLeader: **********************************************************************************************************")
            out("WoundedLeader: **********************************************************************************************************")
        end
    end, true)
    out("WoundedLeader: Initialized")
end)
