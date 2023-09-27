local function edit_starting_army()
    local custom_starting_army = {
        faction = "wh_main_emp_marienburg",
        subtype = "hkrul_jk",
        forename = "names_name_7470711866",
        units = "reiksguard_foot,wh_main_emp_cav_reiksguard,out_scout,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_greatswords,wh_main_emp_inf_halberdiers,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_handgunners,wh_main_emp_art_great_cannon"
    };
    out("JESSICA Marienburg: custom_starting_army.units = " .. custom_starting_army.units .. ".")

    local marienburg = cm:get_faction(custom_starting_army.faction);
    local general_subtype = custom_starting_army.subtype;
    local general_forename = custom_starting_army.forename;
    local unit_list = custom_starting_army.units;
    local char_list = marienburg:character_list();

    for j = 0, char_list:num_items() - 1 do
        local current_char = char_list:item_at(j);

        if current_char:is_null_interface() == false then
            out("Jessica Marienburg: Checking general_subtype " .. tostring(current_char:character_subtype_key()) .. " against " .. tostring(general_subtype) .. "," .. " with forename " ..
                    tostring(current_char:get_forename()) .. ", against " .. tostring(general_forename) .. ". current_char:has_military_force() is " .. tostring(current_char:has_military_force()) ..
                    ".");

            if current_char:character_subtype_key() == general_subtype and current_char:get_forename() == general_forename and current_char:has_military_force() == true then
                cm:remove_all_units_from_general(current_char);
                out("Jessica: Removing starting units from " .. general_subtype .. " with forename " .. general_forename);
                out("Jessica: Granting new starting units to " .. general_subtype .. " with forename " .. general_forename .. ".");
                for k = 1, #unit_list do
                    local unit = unit_list[k];
                    out("Jessica Marienburg: k = " .. k .. ". tostring(#unit_list) = " .. #unit_list .. ". unit = " .. tostring(unit) .. ". unit_list[k] is " .. unit_list[k] .. ".")

                    cm:grant_unit_to_character(cm:char_lookup_str(current_char:cqi()), unit);
                end
            end
        end
    end
end
cm:add_first_tick_callback_new(function()
    edit_starting_army();
end);
