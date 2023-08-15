local bad_legendary_lord_defeated_traits = {
     ["morglum_necksnapper"] = { trait = "morglum_necksnapper" },
     ["grumlock_and_gazbag_greenskin"] = { trait = "grumlock_and_gazbag_greenskin" },
     ["grumlock_and_gazbag_dark_elf"] = { trait = "grumlock_and_gazbag_dark_elf" },
     ["vrion_vampire_count"] = { trait = "vrion_vampire_count" },
     ["vrion_vampire_coast"] = { trait = "vrion_vampire_coast" },
     ["ushoran"] = { trait = "ushoran" }
}


local function get_bad_legendary_lord_defeated_traits(character)
     local pb = cm:model():pending_battle()
     local LL_attackers = {}
     local LL_defenders = {}
     local was_attacker = false

     local num_attackers = cm:pending_battle_cache_num_attackers()
     local num_defenders = cm:pending_battle_cache_num_defenders()

     if pb:night_battle() == true or pb:ambush_battle() == true then
          num_attackers = 1
          num_defenders = 1
     end

     for i = 1, num_attackers do
          local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i)
          local char_obj = cm:model():character_for_command_queue_index(this_char_cqi)

          if this_char_cqi == character:cqi() then
               was_attacker = true
               break
          end

          if char_obj:is_null_interface() == false then
               local char_subtype = char_obj:character_subtype_key()

               if bad_legendary_lord_defeated_traits[char_subtype] ~= nil then
                    table.insert(LL_attackers, char_subtype)
               end
          end
     end

     if was_attacker == false then
          return LL_attackers
     end

     for i = 1, num_defenders do
          local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i)
          local char_obj = cm:model():character_for_command_queue_index(this_char_cqi)

          if char_obj:is_null_interface() == false then
               local char_subtype = char_obj:character_subtype_key()

               if bad_legendary_lord_defeated_traits[char_subtype] ~= nil then
                    table.insert(LL_defenders, char_subtype)
               end
          end
     end
     return LL_defenders
end

local function bad_legend_defeated_traits()
     core:add_listener(
          "bad_legendary_lord_defeated_traits",
          "CharacterCompletedBattle",
          true,
          function(context)
               local character = context:character()
               if cm:char_is_general_with_army(character) and character:won_battle() then
                    local LL_enemies = get_bad_legendary_lord_defeated_traits(character)

                    for i = 1, #LL_enemies do
                         local LL_trait = bad_legendary_lord_defeated_traits[LL_enemies[i]]

                         if LL_trait ~= nil then
                              local trait = LL_trait.trait
                              campaign_traits:give_trait(character, trait)
                         end
                    end
               end
          end,
          true
     )
end


cm:add_first_tick_callback(function() bad_legend_defeated_traits() end)
