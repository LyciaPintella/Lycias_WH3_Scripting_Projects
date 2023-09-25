local function prevent_phoenix_gate_growth_for_first_owner()
    if cm:is_new_game() then
        -- prevents growth in the phoenix gate province for the first owner
        cm:apply_effect_bundle_to_region("wh2_dlc10_dark_elf_fortress_gate", "wh3_main_combi_region_phoenix_gate", 0)
    end
end
cm:add_first_tick_callback_new(function()
    prevent_phoenix_gate_growth_for_first_owner()
end);
