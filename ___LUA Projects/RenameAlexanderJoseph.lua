local function glf_ksl_alexander_start()
     local glf_culture_key = "wh3_main_ksl_kislev"
     local glf_agent_key = "glf_ksl_alexander"
     local glf_agent_type = "champion"
     local glf_agent_saved_value = "glf_ksl_alexander_wh3"
     local glf_character_to_check_rank = 17
     local glf_buildings = {
          "wh3_main_special_ksl_praag_2_1",
          "wh3_main_special_ksl_praag_2_2",
          "wh3_main_special_ksl_praag_2_3"
     };

     if not cm:get_saved_value(glf_agent_saved_value) and glf_LC_settings[glf_agent_key] then
          local glf_ai_subculture = true
          local glf_human_factions = cm:get_human_factions()

          for i = 1, #glf_human_factions do
               local faction_key = glf_human_factions[i]
               if cm:get_faction(faction_key):culture() == glf_culture_key then
                    core:add_listener( --每回合开始时检测是否存在建筑
                         "Wh3GlfAlexander",
                         "FactionRoundStart",
                         function(context)
                              return context:faction():is_human()
                         end,
                         function(context)
                              local glf_faction_key = context:faction()
                              local region_list = glf_faction_key:region_list()
                              for i = 0, region_list:num_items() - 1 do
                                   local current_region = region_list:item_at(i)
                                   for j = 1, #glf_buildings do
                                        local z_building_exists = current_region:building_exists(glf_buildings[j])
                                        if z_building_exists then
                                             local glf_region_key = current_region:name()
                                             glf_spawn_character(glf_faction_key, glf_region_key, glf_agent_key,
                                                  glf_agent_type, glf_agent_saved_value)
                                             --Lycia Modded
                                             local alexander_char = cm:get_most_recently_created_character_of_type(
                                                  glf_faction_key, glf_agent_type)
                                             if alexander_char then
                                                  cm:change_character_custom_name(alexander_char, "Alexander Joseph,",
                                                       "the Field Gunner", "", "")
                                             end
                                             --end Lycia Modded
                                             core:remove_listener("Wh3GlfAlexander")
                                        end;
                                   end;
                              end
                         end,
                         true
                    )
                    glf_ai_subculture = false
               end
          end

          if glf_ai_subculture then
               core:add_listener( --监测人物达到等级为AI生成对应人物
                    "Wh3GlfAlexanderAI",
                    "CharacterRankUp",
                    function(context)
                         local character = context:character()

                         return character:faction():culture() == glf_culture_key and character:character_type("general") and
                         character:rank() >= glf_character_to_check_rank;
                    end,
                    function(context)
                         core:remove_listener("Wh3GlfAlexanderAI")
                         local glf_faction_key = context:character():faction():name()
                         local glf_region_key = context:character():faction():home_region():name()
                         if not cm:get_saved_value(glf_agent_saved_value) then
                              glf_spawn_character(glf_faction_key, glf_region_key, glf_agent_key, glf_agent_type,
                                   glf_agent_saved_value)
                         end
                    end,
                    false
               )
          end
     end
end

cm:add_first_tick_callback(function() glf_ksl_alexander_start() end)
