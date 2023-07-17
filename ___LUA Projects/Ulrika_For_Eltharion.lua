Ulrika_Unlocking = {}
Ulrika_Unlocking.character_unlock_condition_types = { rank = "rank" }
Ulrika_Unlocking.character_alternate_grant_condition_types = {dilemma_payload = "dilemma"}
Ulrika_Unlocking.character_list = {"ulrika"}
Ulrika_Unlocking.character_data = {
     ulrika = {
          condition_to_start_unlock = Ulrika_Unlocking.character_unlock_condition_types.rank,
          ai_condition_to_start_unlock = Ulrika_Unlocking.character_unlock_condition_types.rank,
          alternate_grant_condition = Ulrika_Unlocking.character_alternate_grant_condition_types.dilemma_payload,
          unlock_rank = 11,
          has_spawned = false,
          name = "ulrika",
          forename = "1001259072",
          surname = "247283887",
          subtype = "wh3_dlc23_neu_ulrika",
          require_dlc = "TW_WH3_ULRIKA_FREE",
          allowed_cultures = {"wh2_main_hef_high_elves"},
          override_allowed_factions = {"wh2_main_hef_yvresse"},
          factions_involved = {},
          dilemma_keys = {"wh3_dlc23_neu_ulrika_choice"},
          spawn_hero_dilemma_choice = 0,
          ancillaries = {"wh3_dlc23_anc_arcane_item_blood_shard", "wh3_dlc23_anc_weapon_item_silver_dagger", "wh3_dlc23_anc_follower_neu_gabriella"},
          trigger_dilemma_key = "wh3_dlc23_neu_ulrika_choice",
          alt_reward_dilemma_triggered = false
     }
}

local out = function(t) ModLog("Ulrika For Eltharion: " .. tostring(t) .. ".") end

function Ulrika_Unlocking:ulrika_has_valid_faction_in_campaign(character)
     local character_info = self.character_data[character]
     for i = 1, #character_info.allowed_factions do
          local faction_interface = cm:get_faction(character_info.allowed_factions[i])
          if faction_interface then if not faction_interface:is_null_interface() then return true end end
     end
     return false
end

function Ulrika_Unlocking:get_ulrika_allowed_factions_list(character_data)
     local allowed_factions = {}
     if character_data.override_allowed_factions then
          allowed_factions = character_data.override_allowed_factions
     else
          for _, v in ipairs(character_data.allowed_cultures) do
               local culture_to_allowed_factions = self:get_ulrika_allowed_factions_list(v, character_data.non_playable_factions_allowed)
               for i = 1, #culture_to_allowed_factions do
                    -- Don't setup missions for characters a player wouldn't be able to spawn due to lacking the DLC permissions anyway
                    if character_data.require_dlc ~= nil and cm:faction_has_dlc_or_is_ai(character_data.require_dlc, culture_to_allowed_factions[i]) then
                         table.insert(allowed_factions, culture_to_allowed_factions[i])
                    elseif character_data.require_dlc == nil then
                         table.insert(allowed_factions, culture_to_allowed_factions[i])
                    end
               end
          end
     end
     return allowed_factions
end

function Ulrika_Unlocking:setup_Ulrika_unlocking()
     for i = 1, #self.character_list do
          local character = self.character_list[i]
          local current_character = self.character_data[character]
          -- Generate allowed factions list for character
          if current_character.allowed_factions == nil then
               current_character.allowed_factions = self:ulrika_has_valid_faction_in_campaign(current_character)
          end
          if character and self:ulrika_has_valid_faction_in_campaign(character) then
               if current_character.starting_owner_faction then -- Spawn character at game start if playing as starting owner faction
                    local main_faction = cm:get_faction(current_character.starting_owner_faction)
                    if main_faction then main_faction_human = main_faction:is_human() end
                    if cm:is_new_game() and main_faction_human then self:spawn_hero(current_character.starting_owner_faction, character) end
               else
                    if current_character.condition_to_start_unlock == self.character_unlock_condition_types.rank then
                         self:add_listeners_for_eltharion_rank_unlock(character)
                    end
               end
          end
     end
end
cm:add_first_tick_callback(function() Ulrika_Unlocking:setup_Ulrika_unlocking() end);

function Ulrika_Unlocking:add_listeners_for_eltharion_rank_unlock(character)
     out("Add Ulrika rank unlocking Listener")
     local character_info = self.character_data[character]
     for i = 1, #character_info.allowed_factions do
          local faction_interface = cm:get_faction(character_info.allowed_factions[i])
          out("faction_interface:name(): " .. faction_interface:name() .. ".")
          if faction_interface and faction_interface:is_human() then
               -- there's at least 1 human player of mission factions
               self:spawn_ulrika_on_rank_up(character)
               return
          end
     end
end

function Ulrika_Unlocking:spawn_ulrika_on_rank_up(character)
     local character_info = self.character_data[character]
     if character_info.has_spawned == false then
          for i = 1, #character_info.allowed_factions do
               out("spawn_ulrika_on_rank_up: checking faction " .. character_info.allowed_factions[i]:name() .. ".")
               if cm:get_faction(character_info.allowed_factions[i]):is_human() then
                    cm:add_faction_turn_start_listener_by_name("spawn_ulrika_on_rank_up", character_info.allowed_factions[i], function(context)
                         if character_info.has_spawned == false then
                              local faction = context:faction()
                              local faction_name = faction:name()
                              out("character_info.factions_involved[faction_name]: " .. character_info.factions_involved[faction_name] .. ".")
                              if character_info.factions_involved[faction_name] ~= true and faction:faction_leader():rank() >= character_info.unlock_rank then
                                   character_info.factions_involved[faction_name] = true
                                   out("Legendary Characters: Spawning Ulrika!")
                                   cm:trigger_dilemma(faction:name(), "wh3_dlc23_neu_ulrika_choice")
                              end
                         end
                    end, true)
               end
          end
     end
end

cm:add_saving_game_callback(function(context)
     for i = 1, #Ulrika_Unlocking.character_list do
          local data = Ulrika_Unlocking.character_data[Ulrika_Unlocking.character_list[i]]
          cm:save_named_value(data.name .. ".factions_involved", data.factions_involved, context)
          cm:save_named_value(data.name .. ".has_spawned", data.has_spawned, context)
          if data.allowed_factions then cm:save_named_value(data.name .. ".allowed_factions", data.allowed_factions, context) end
     end
end)

cm:add_loading_game_callback(function(context)
     if cm:is_new_game() == false then
          for i = 1, #Ulrika_Unlocking.character_list do
               local data = Ulrika_Unlocking.character_data[Ulrika_Unlocking.character_list[i]]
               data.factions_involved = cm:load_named_value(data.name .. ".factions_involved", data.factions_involved, context)
               data.has_spawned = cm:load_named_value(data.name .. ".has_spawned", data.has_spawned, context)
               if data.allowed_factions then
                    data.allowed_factions = cm:load_named_value(data.name .. ".allowed_factions", data.allowed_factions, context)
               end
          end
     end
end)