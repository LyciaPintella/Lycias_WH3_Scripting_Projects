out("anc_mod: INIT.")
local ancillary_master_list = {
     --["building_id"] = {"anc1","anc2"}
     --bronze proofing hall
     ["phar_main_all_resource_production_bronze_mine_derivative_type_a_2"] = { "phar_main_common_equipment_axe", "phar_main_common_equipment_club", "phar_main_common_equipment_spear", "phar_main_common_equipment_khopesh", "phar_main_common_equipment_sword", },
     --wisdom codices
     ["phar_main_all_province_management_main_building_poc_legitimacy_influence_boost_3"] = { "phar_main_common_general_16", "phar_main_rare_18", "phar_main_rare_8", },
     --translators quarters
     ["phar_main_all_province_management_main_building_poc_happiness_boost_1"] = { "phar_main_common_general_17", "phar_main_common_general_25", "phar_main_common_general_26", "phar_main_common_general_27", "phar_main_rare_11", },
     --tarsus pottery landmark
     ["phar_main_all_landmark_production_boost_tarsus_1"] = { "phar_main_rare_37" },
     --healer buildings
     ["phar_main_all_province_management_growth_type_a_3"] = { "phar_main_common_general_10", "phar_main_rare_2", "phar_main_rare_6", "phar_sea_common_1", "phar_sea_rare_8", },
     ["phar_map_bab_province_management_happiness_growth_type_a_3"] = { "phar_main_common_general_10", "phar_main_rare_6", "phar_main_rare_6", "phar_sea_common_1", "phar_sea_rare_8", },
     --royal fisheries
     ["phar_main_all_resource_production_port_coast_2"] = { "phar_main_rare_27", "phar_main_rare_40", "phar_sea_common_2", },
     --royal goldsmiths
     ["phar_main_all_resource_production_modifier_gold_3"] = { "phar_main_rare_24", "phar_main_rare_28" },
     ["phar_main_tausret_resource_production_modifier_gold_3"] = { "phar_main_rare_24", "phar_main_rare_28" },
     --smuggler port
     ["phar_main_all_resource_production_port_coast_derivative_type_a_1"] = { "phar_main_common_general_1", "phar_main_common_general_19", "phar_main_common_general_2", "phar_main_common_general_8", "phar_main_rare_12", "phar_main_rare_14", "phar_main_rare_9", },
     --stonecarver district
     ["phar_main_all_resource_production_stone_mine_derivative_type_a_1"] = { "phar_main_common_general_21", "phar_main_rare_32" },
     ["phar_main_irsu_resource_production_stone_mine_derivative_type_a_1"] = { "phar_main_common_general_21", "phar_main_rare_32" },
     --Visitors quarters
     ["phar_main_all_province_management_roads_3"] = { "phar_main_common_general_22", "phar_main_common_general_24", "phar_main_common_general_28", "phar_main_common_general_7", "phar_main_common_general_9", "phar_main_rare_1", },
     ["phar_map_bab_province_management_influence_roads_type_a_3"] = { "phar_main_common_general_22", "phar_main_common_general_24", "phar_main_common_general_28", "phar_main_common_general_7", "phar_main_common_general_9", "phar_main_rare_1", },
     ["phar_map_myc_province_management_roads_3"] = { "phar_main_common_general_22", "phar_main_common_general_24", "phar_main_common_general_28", "phar_main_common_general_7", "phar_main_common_general_9", "phar_main_rare_1", },
     ["phar_sea_peleset_province_management_movement_production_boost_3"] = { "phar_sea_rare_9", "phar_main_common_general_22", "phar_main_common_general_24", "phar_main_common_general_28", "phar_main_common_general_7", "phar_main_common_general_9", "phar_main_rare_1", },
     --royal jeweller
     ["phar_main_all_resource_production_gold_mine_derivative_type_b_1"] = { "phar_main_rare_30", "phar_main_rare_38", "phar_main_rare_43", "phar_main_rare_49", },
     ["phar_main_irsu_resource_production_gold_mine_derivative_type_b_1"] = { "phar_main_rare_30", "phar_main_rare_38", "phar_main_rare_43", "phar_main_rare_49", },
     --drinking establishments
     ["phar_main_all_province_management_happiness_type_c_3"] = { "phar_main_common_general_12", "phar_main_rare_19", "phar_main_rare_31", "phar_main_rare_42", "phar_main_rare_7", },
     ["phar_main_ram_province_management_production_boost_happiness_3"] = { "phar_main_common_general_12", "phar_main_rare_19", "phar_main_rare_31", "phar_main_rare_42", "phar_main_rare_7", },
     --grant_units_to_character_by_position_from_faction                                                                               --the cook does nothing without a mod =)
     ["phar_main_all_resource_production_modifier_food_3"] = { "phar_main_common_general_23", "phar_main_common_general_29", "phar_main_common_general_3", "phar_sea_common_6", },
     ["phar_main_tausret_resource_production_modifier_food_3"] = { "phar_main_common_general_23", "phar_main_common_general_29", "phar_main_common_general_3", "phar_sea_common_6", },
     --bazaars
     ["phar_main_all_resource_production_fruit_oasis_derivative_type_a_1"] = { "phar_main_common_general_20", "phar_main_rare_10", "phar_main_rare_13", },
     ["phar_main_irsu_resource_production_fruit_oasis_derivative_type_a_1"] = { "phar_main_common_general_20", "phar_main_rare_10", "phar_main_rare_13", },
     --southern natives
     ["phar_main_all_military_native_type_a_kush_4"] = { "phar_main_rare_4" },
     ["phar_main_all_military_native_type_a_nubia_4"] = { "phar_main_rare_4" },
     --meso natives
     ["phar_map_all_military_native_type_a_haltamti_4"] = { "phar_main_rare_3", "phar_main_rare_5", },
     ["phar_map_all_military_native_type_a_mat_assur_4"] = { "phar_main_rare_3", "phar_main_rare_5", },
     ["phar_map_all_military_native_type_a_mat_tamti_4"] = { "phar_main_rare_3", "phar_main_rare_5", },
     --cult centres
     ["phar_main_religion_cult_center_grand_temple_amun_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_anubis_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_arinna_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_asherah_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_aten_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_baal_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_el_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_horus_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_isis_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_kumarbi_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_kurunta_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_moloch_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_osiris_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_ptah_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_ra_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_set_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_shaushka_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_tarhunz_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_thoth_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_main_religion_cult_center_grand_temple_yamm_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_map_religion_cult_center_grand_temple_aphrodite_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_map_religion_cult_center_grand_temple_apollo_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_map_religion_cult_center_grand_temple_ares_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_map_religion_cult_center_grand_temple_ashur_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_map_religion_cult_center_grand_temple_inshushinak_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_map_religion_cult_center_grand_temple_ishtar_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_map_religion_cult_center_grand_temple_marduk_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_map_religion_cult_center_grand_temple_ninurta_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_map_religion_cult_center_grand_temple_poseidon_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     ["phar_map_religion_cult_center_grand_temple_zeus_1"] = { "phar_main_common_general_14", "phar_main_common_general_15", },
     --royal bronze worker
     ["phar_main_all_resource_production_modifier_bronze_3"] = { "phar_main_common_armour_heavy", "phar_main_common_armour_light", "phar_main_common_armour_medium", },
     ["phar_main_tausret_resource_production_modifier_bronze_3"] = { "phar_main_common_armour_heavy", "phar_main_common_armour_light", "phar_main_common_armour_medium", },
     --champions hall
     ["phar_main_amenmesse_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_bay_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_canaan_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_hatti_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_irsu_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_kemet_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_kuru_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_kurunta_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_ramesses_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_seti_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_suppiluliuma_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_main_tausret_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_map_achean_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_map_ash_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_map_bab_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_map_elam_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_map_luwian_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_map_meso_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_map_mycenae_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_map_thracian_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_map_urartu_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     ["phar_map_wilusa_military_administration_unit_training_type_b_1"] = { "phar_main_common_general_11", "phar_main_rare_15", "phar_main_rare_16", "phar_main_rare_17", },
     --Woodcutters districts
     ["phar_main_all_resource_production_wood_canaan_type_a_derivative_1"] = { "phar_main_common_equipment_bow", "phar_main_common_equipment_chariot", "phar_main_common_shield_large", "phar_main_common_shield_medium", "phar_main_common_shield_small", },
     ["phar_main_all_resource_production_wood_hatti_derivative_2"] = { "phar_main_common_equipment_bow", "phar_main_common_equipment_chariot", "phar_main_common_shield_large", "phar_main_common_shield_medium", "phar_main_common_shield_small", },
     ["phar_map_all_resource_production_wood_mesopotamia_type_a_derivative_1"] = { "phar_main_common_equipment_bow", "phar_main_common_equipment_chariot", "phar_main_common_shield_large", "phar_main_common_shield_medium", "phar_main_common_shield_small", },
     ["phar_map_wood_production_aegean_derivative_1"] = { "phar_main_common_equipment_bow", "phar_main_common_equipment_chariot", "phar_main_common_shield_large", "phar_main_common_shield_medium", "phar_main_common_shield_small", },
     ["phar_map_wood_production_assuwa_derivative_1"] = { "phar_main_common_equipment_bow", "phar_main_common_equipment_chariot", "phar_main_common_shield_large", "phar_main_common_shield_medium", "phar_main_common_shield_small", },
     ["phar_map_wood_production_thrace_derivative_1"] = { "phar_main_common_equipment_bow", "phar_main_common_equipment_chariot", "phar_main_common_shield_large", "phar_main_common_shield_medium", "phar_main_common_shield_small", },
}

local building_spawn_chance = {
     --["building_id"] = number
     ["phar_main_all_resource_production_bronze_mine_derivative_type_a_2"] = 3,
     ["phar_main_all_resource_production_modifier_bronze_3"] = 3,
     ["phar_main_tausret_resource_production_modifier_bronze_3"] = 3,
     ["phar_main_amenmesse_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_bay_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_canaan_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_hatti_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_irsu_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_kemet_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_kuru_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_kurunta_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_ramesses_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_seti_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_suppiluliuma_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_tausret_military_administration_unit_training_type_b_1"] = 3,
     ["phar_map_achean_military_administration_unit_training_type_b_1"] = 3,
     ["phar_map_ash_military_administration_unit_training_type_b_1"] = 3,
     ["phar_map_bab_military_administration_unit_training_type_b_1"] = 3,
     ["phar_map_elam_military_administration_unit_training_type_b_1"] = 3,
     ["phar_map_luwian_military_administration_unit_training_type_b_1"] = 3,
     ["phar_map_meso_military_administration_unit_training_type_b_1"] = 3,
     ["phar_map_mycenae_military_administration_unit_training_type_b_1"] = 3,
     ["phar_map_thracian_military_administration_unit_training_type_b_1"] = 3,
     ["phar_map_urartu_military_administration_unit_training_type_b_1"] = 3,
     ["phar_map_wilusa_military_administration_unit_training_type_b_1"] = 3,
     ["phar_main_all_resource_production_wood_canaan_type_a_derivative_1"] = 3,
     ["phar_main_all_resource_production_wood_hatti_derivative_2"] = 2,
     ["phar_map_all_resource_production_wood_mesopotamia_type_a_derivative_1"] = 3,
     ["phar_map_wood_production_aegean_derivative_1"] = 3,
     ["phar_map_wood_production_assuwa_derivative_1"] = 3,
     ["phar_map_wood_production_thrace_derivative_1"] = 3,
     ["phar_main_all_province_management_main_building_poc_legitimacy_influence_boost_3"] = 3,
     ["phar_main_all_province_management_main_building_poc_happiness_boost_1"] = 3,
     ["phar_main_all_province_management_growth_type_a_3"] = 3,
     ["phar_map_bab_province_management_happiness_growth_type_a_3"] = 3,
     ["phar_main_all_resource_production_port_coast_2"] = 3,
     ["phar_main_all_resource_production_modifier_gold_3"] = 3,
     ["phar_main_tausret_resource_production_modifier_gold_3"] = 3,
     ["phar_main_all_resource_production_port_coast_derivative_type_a_1"] = 3,
     ["phar_main_all_resource_production_stone_mine_derivative_type_a_1"] = 3,
     ["phar_main_irsu_resource_production_stone_mine_derivative_type_a_1"] = 3,
     ["phar_main_all_province_management_roads_3"] = 3,
     ["phar_map_bab_province_management_influence_roads_type_a_3"] = 3,
     ["phar_map_myc_province_management_roads_3"] = 3,
     ["phar_sea_peleset_province_management_movement_production_boost_3"] = 3,
     ["phar_main_all_resource_production_gold_mine_derivative_type_b_1"] = 3,
     ["phar_main_irsu_resource_production_gold_mine_derivative_type_b_1"] = 3,
     ["phar_main_all_province_management_happiness_type_c_3"] = 3,
     ["phar_main_ram_province_management_production_boost_happiness_3"] = 3,
     ["phar_main_all_resource_production_modifier_food_3"] = 3,
     ["phar_main_tausret_resource_production_modifier_food_3"] = 3,
     ["phar_main_all_military_native_type_a_kush_4"] = 3,
     ["phar_main_all_military_native_type_a_nubia_4"] = 3,
     ["phar_map_all_military_native_type_a_haltamti_4"] = 3,
     ["phar_map_all_military_native_type_a_mat_assur_4"] = 3,
     ["phar_map_all_military_native_type_a_mat_tamti_4"] = 3,
     ["phar_main_all_resource_production_fruit_oasis_derivative_type_a_1"] = 5,
     ["phar_main_irsu_resource_production_fruit_oasis_derivative_type_a_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_amun_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_anubis_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_arinna_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_asherah_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_aten_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_baal_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_el_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_horus_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_isis_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_kumarbi_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_kurunta_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_moloch_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_osiris_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_ptah_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_ra_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_set_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_shaushka_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_tarhunz_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_thoth_1"] = 5,
     ["phar_main_religion_cult_center_grand_temple_yamm_1"] = 5,
     ["phar_map_religion_cult_center_grand_temple_aphrodite_1"] = 5,
     ["phar_map_religion_cult_center_grand_temple_apollo_1"] = 5,
     ["phar_map_religion_cult_center_grand_temple_ares_1"] = 5,
     ["phar_map_religion_cult_center_grand_temple_ashur_1"] = 5,
     ["phar_map_religion_cult_center_grand_temple_inshushinak_1"] = 5,
     ["phar_map_religion_cult_center_grand_temple_ishtar_1"] = 5,
     ["phar_map_religion_cult_center_grand_temple_marduk_1"] = 5,
     ["phar_map_religion_cult_center_grand_temple_ninurta_1"] = 5,
     ["phar_map_religion_cult_center_grand_temple_poseidon_1"] = 5,
     ["phar_map_religion_cult_center_grand_temple_zeus_1"] = 5,
     ["phar_main_all_landmark_production_boost_tarsus_1"] = 8,
}

core:add_listener(
     "forge_detect",
     "FactionTurnStart",
     function(context)
          out("anc_mod: INIT2.")
          for building, anc_list in pairs(ancillary_master_list) do
               if context:faction():building_exists(building) then
                    out("anc_mod: " .. building .. " detected for " .. context:faction():name())
                    return true
               end
          end
          out("anc_mod: " .. context:faction():name() .. " has no tracked buildings.")
          return false
     end,
     function(context)
          out("anc_mod: Faction has at least one tracked building, but we need to check for others.")
          local region_list = context:faction():region_list()

          for building, anc_list in pairs(ancillary_master_list) do
               out("anc_mod: checks for building " .. building)
               local chances_to_spawn = return_building_number(building, region_list)
               spawn_ancillaries(context:faction():name(), chances_to_spawn, anc_list, building)
          end
     end,
     true
)


function return_building_number(building_key, region_list)
     out("anc_mod: func called to find number of " .. building_key)
     local number_to_return = 0
     for i = 0, region_list:num_items() - 1 do
          this_region = region_list:item_at(i)

          if this_region:building_exists(building_key) then
               --out("anc_mod: "..building_key.."detected in region")
               local this_slot_list = this_region:slot_list()

               for j = 0, this_slot_list:num_items() - 1 do
                    local this_slot = this_slot_list:item_at(j)

                    if this_slot:has_building() and this_slot:building():name() == building_key then
                         out("anc_mod: " .. building_key .. "detected in slot")
                         number_to_return = number_to_return + 1
                    end
               end
          end
     end
     out("anc_mod: returning value of " .. number_to_return)
     return number_to_return
end

function spawn_ancillaries(faction, chances, ancillary_list, building)
     out("anc_mod: func called to spawn ancillaries")
     if chances == 0 then
          out("anc_mod: no buildings, no chance - ending script")
          return
     end
     local dice_roll = building_spawn_chance[building]
     out("anc_mod: func called to spawn ancillaries2")
     out("anc_mod: func called to spawn ancillaries2" .. dice_roll)

     for i = 1, chances do
          if cm:model():random_percent(dice_roll) then
               local random_number = cm:model():random_int(1, #ancillary_list)
               out("anc_mod: Awarding ancillary: " .. ancillary_list[random_number])
               cm:add_ancillary_to_faction(faction, ancillary_list[random_number], true)
          end
     end
end
