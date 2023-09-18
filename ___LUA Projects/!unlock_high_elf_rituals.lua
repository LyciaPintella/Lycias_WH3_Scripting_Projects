local function rite_unlock()
     cm:unlock_ritual(cm:get_faction("wh2_main_hef_yvresse"), "wh2_dlc10_ritual_hef_lileath");
     cm:unlock_ritual(cm:get_faction("wh2_main_hef_yvresse"), "wh2_dlc10_ritual_hef_morai_heg");
     cm:unlock_ritual(cm:get_faction("wh2_main_hef_yvresse"), "wh2_dlc15_ritual_hef_eldrazor");
     cm:unlock_ritual(cm:get_faction("wh2_main_hef_yvresse"), "wh2_dlc15_ritual_hef_isha_greater");
     cm:unlock_ritual(cm:get_faction("wh2_main_hef_yvresse"), "wh2_dlc15_ritual_hef_ladrielle");
     cm:unlock_ritual(cm:get_faction("wh2_main_hef_yvresse"), "wh2_dlc15_ritual_hef_vaul_greater");
     cm:unlock_ritual(cm:get_faction("wh2_main_hef_yvresse"), "wh2_main_ritual_hef_asuryan");
     cm:unlock_ritual(cm:get_faction("wh2_main_hef_yvresse"), "wh2_main_ritual_hef_hoeth");
     cm:unlock_ritual(cm:get_faction("wh2_main_hef_yvresse"), "wh2_main_ritual_hef_isha");
     cm:unlock_ritual(cm:get_faction("wh2_main_hef_yvresse"), "wh2_main_ritual_hef_vaul");
end

local function initialize_rite_unlock()
     local turn_number = cm:model():turn_number()
     cm:callback(function()
          if (turn_number == 1) then
               rite_unlock()
          end
     end, 5.0)
end
cm:add_first_tick_callback_new(function()
     initialize_rite_unlock()
end);
