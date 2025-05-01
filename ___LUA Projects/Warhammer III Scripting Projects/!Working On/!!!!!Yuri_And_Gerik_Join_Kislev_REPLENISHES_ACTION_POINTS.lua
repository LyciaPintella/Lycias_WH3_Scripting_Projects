local function z_yuri_unlocked()
     local human_factions = cm:get_human_factions();
     local target_faction = "wh3_main_ksl_the_ice_court";
     for i = 1, #human_factions do
          if cm:get_faction(human_factions[i]):subculture() == "wh3_main_sc_ksl_kislev" then
               target_faction = human_factions[i]
          end;
     end;
     if not cm:get_saved_value("mod_yuri_spawn") then
          cm:spawn_character_to_pool(target_faction, "names_name_2145104588", "", "", "", 18, true, "general",
               "wh3_main_pro_ksl_yuri_0", true, "")
          cm:set_saved_value("mod_yuri_spawn", true)
     end;
     -- Set Character CQI's
     core:add_listener(
          "gerik_created",
          "CharacterCreated",
          function(context)
               local character = context:character()
               return character:character_subtype("z_ksl_gerik_hero")
          end,
          function(context)
               local character = context:character()
               local char_lookup_str = cm:char_lookup_str(character)
               local char_cqi = character:command_queue_index() -- Not needed for now, but this is how we can get it later.

               cm:callback(
                    function()
                         cm:replenish_action_points(char_lookup_str)
                         --cm:set_character_immortality(char_lookup_str, true)
                    end,
                    0.5
               )
          end,
          true
     )
     core:add_listener(
          "Gerik_Dilemma_lord",
          "DilemmaChoiceMadeEvent",
          function(context)
               return context:dilemma() == "z_mod_dilemma_gerik";
          end,
          function(context)
               local choice = context:choice();
               if choice == 0 then
                    cm:spawn_unique_agent(cm:get_faction(target_faction):command_queue_index(), "z_ksl_gerik_hero", false);
               elseif choice == 1 then
                    cm:spawn_character_to_pool(target_faction, "names_name_1002144812", "", "", "", 18, true, "general",
                         "wh3_main_pro_ksl_gerik_0", true, "")
               end;
          end,
          true
     )
end

cm:add_first_tick_callback(function() z_yuri_unlocked() end);