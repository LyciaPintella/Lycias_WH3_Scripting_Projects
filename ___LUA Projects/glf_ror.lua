---指定文化共用ROR单位。需要添加subculture的key与对应ror单位key, 每次新档生效
-- Adds custom Regiments of Renown to specified factions
local function out(t) ModLog("all_add_custom_ror_wh_all_threes " .. tostring(t) .. " ####") end
local glf_ror_unit_list = {
    -------------------
    ----   Empire   ----
    -------------------
    ["wh_main_sc_emp_empire"] = {"glf_emp_knights_of_the_vengeful_sun_ror"},
    -------------------
    ----   Bretonnia   ----
    -------------------
    ["wh_main_sc_brt_bretonnia"] = {"glf_brt_errant_brigade_ror", "glf_brt_fastrics_skylance_ror", "glf_brt_hippogryph_subspecies_knights_ror"},
    -------------------
    ----   High Elves   ----
    -------------------
    ["wh2_main_sc_hef_high_elves"] = {"glf_hef_spears_of_dabbarloc_ror", "glf_hef_sword_of_hoeth_ror", "glf_hef_revenants_of_khaine_ror"},
    -------------------
    ----   Dark Elves   ----
    -------------------
    ["wh2_main_sc_def_dark_elves"] = {"glf_def_rimeshards_ror", "glf_def_the_voiceless_ones_ror", "glf_def_dread_knights_ror", "glf_def_the_soulskulls_ror"},
    -------------------
    ----   Tomb Kings   ----
    -------------------
    ["wh2_dlc09_sc_tmb_tomb_kings"] = {"glf_tmb_blessed_arrow_of_ptra_ror", "glf_tmb_lion_head_ushabti_ror"}
}
local function glf_culture_ror_units()
    local ror_human_factions = cm:get_human_factions()
    local ror_faction_list = cm:model():world():faction_list()
    for ror_subculture, ror_units in pairs(glf_ror_unit_list) do
        local ror_ai_subculture = true
        for i = 1, #ror_human_factions do
            local faction_key = ror_human_factions[i]
            if cm:get_faction(faction_key):subculture() == ror_subculture then
                out(faction_key)
                for u = 1, #ror_units do
                    local ror_unit = ror_units[u]
                    cm:add_unit_to_faction_mercenary_pool(cm:get_faction(faction_key), ror_unit, "renown", 1, 100, 10, 0.1, 100, 0.1, "", true, ror_unit)
                end
                ror_ai_subculture = true
            end
        end
        if ror_ai_subculture then
            for j = 0, ror_faction_list:num_items() - 1 do
                local ai_faction = ror_faction_list:item_at(j)
                if ai_faction:subculture() == ror_subculture and ai_faction:is_null_interface() == false and ai_faction:is_dead() == false then
                    for u = 1, #ror_units do
                        local ror_unit = ror_units[u]
                        cm:add_unit_to_faction_mercenary_pool(cm:get_faction(ai_faction:name()), ror_unit, "renown", 1, 100, 10, 0.1, "", "", "", true, ror_unit)
                    end
                end
            end
        end
    end
end

cm:add_first_tick_callback_new(function() glf_culture_ror_units() end);
