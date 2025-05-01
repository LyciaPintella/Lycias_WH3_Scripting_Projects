local force_Items = {
    loading_fix = true
};

function force_Items:start_items_listeners()
    local grimgor_faction_key = "wh_main_grn_greenskins";
    local grimgor_faction = cm:get_faction(grimgor_faction_key);
    local malekith_faction_key = "wh2_main_def_naggarond";
    local malekith_faction = cm:get_faction(malekith_faction_key);
    local rakarth_faction_key = "wh2_twa03_def_rakarth";
    local rakarth_faction = cm:get_faction(rakarth_faction_key);
    local harkon_faction_key = "wh2_dlc11_cst_vampire_coast";
    local harkon_faction = cm:get_faction(harkon_faction_key);
    local noctilus_faction_key = "wh2_dlc11_cst_noctilus";
    local noctilus_faction = cm:get_faction(noctilus_faction_key);
    local aranessa_faction_key = "wh2_dlc11_cst_pirates_of_sartosa";
    local aranessa_faction = cm:get_faction(aranessa_faction_key);
    local cylostra_faction_key = "wh2_dlc11_cst_the_drowned";
    local cylostra_faction = cm:get_faction(cylostra_faction_key);

    if grimgor_faction:is_human() then
        core:add_listener("Grimgor_CharacterRankUp", "CharacterRankUp", function(context)
            local character = context:character();
            return character:character_subtype("wh_main_grn_grimgor_ironhide") and character:rank() >= 12;
        end, function()
            cm:add_ancillary_to_faction(grimgor_faction, "wh_main_anc_armour_blood-forged_armour", false);
        end, false);
    elseif malekith_faction:is_human() then
        core:add_listener("Malekith_CharacterRankUp", "CharacterRankUp", function(context)
            local character = context:character();
            return character:character_subtype("wh2_main_def_malekith") and character:rank() >= 17;
        end, function()
            cm:add_ancillary_to_faction(malekith_faction, "wh2_main_anc_enchanted_item_supreme_spellshield", false);
        end, false);
    end
end
cm:add_post_first_tick_callback(function()
    force_Items:start_items_listeners()
end);
