local function misc_setup()
    if cm:is_new_game() then

        -- Karak Norn

        cm:transfer_region_to_faction("wh3_main_combi_region_gristle_valley", "wh_main_dwf_karak_norn")
        local kkn_region = cm:model():world():region_manager():region_by_key("wh3_main_combi_region_gristle_valley")
        cm:instantly_set_settlement_primary_slot_level(kkn_region:settlement(), 2)
        cm:heal_garrison(kkn_region:cqi())
        cm:transfer_region_to_faction("wh3_main_combi_region_karak_azgaraz", "wh_main_dwf_karak_norn")
        local kkn1_region = cm:model():world():region_manager():region_by_key("wh3_main_combi_region_karak_azgaraz")
        cm:instantly_set_settlement_primary_slot_level(kkn1_region:settlement(), 2)
        cm:heal_garrison(kkn1_region:cqi())

        -- Leaf-Cutterz

        cm:transfer_region_to_faction("wh3_main_combi_region_sun_tree_glades", "wh2_dlc12_grn_leaf_cutterz_tribe")
        local lct_region = cm:model():world():region_manager():region_by_key("wh3_main_combi_region_sun_tree_glades")
        cm:instantly_set_settlement_primary_slot_level(lct_region:settlement(), 1)
        cm:heal_garrison(lct_region:cqi())

        -- Grom (broken axe)

        cm:make_diplomacy_available("wh2_dlc15_grn_broken_axe", "wh_main_brt_lyonesse")
        cm:force_declare_war("wh2_dlc15_grn_broken_axe", "wh2_main_hef_yvresse", false, false)

        -- Barrow Legion

        -- cm:make_diplomacy_available("wh2_dlc11_vmp_the_barrow_legion", "wh3_main_brt_aquitaine")
        cm:force_grant_military_access("wh2_dlc11_vmp_the_barrow_legion", "wh2_dlc15_grn_broken_axe", false)
        -- cm:force_grant_military_access("wh2_dlc15_grn_broken_axe", "wh2_dlc11_vmp_the_barrow_legion", false)

    end
end
cm:add_first_tick_callback_new(function()
    misc_setup()
end);
