NUIN_AUTO_GOSSIP = NUIN_AUTO_GOSSIP or {}
local mod_NAG = NUIN_AUTO_GOSSIP

-----------------------------------------------------
-- MOD INIT FUNCTION
-----------------------------------------------------

--Not really using this, function inits on first tick callback and then loading callback.
--So just using for debug output.
nuin_auto_gossip = function()
     NML.nModLog("********************************************************************************\n")
     NML.nModLog("Nuin Auto Gossip Loaded\n")
     NML.nModLog("********************************************************************************")
end

-----------------------------------------------------
-- LISTENERS
-----------------------------------------------------

--- @listener nuin_faction_end_turn
--- @desc Checks when a faction ends turn if it is the player, and if an intrigue is unused.
--- If so, uses it on gossip
core:remove_listener("nuin_faction_about_to_end_turn")
core:add_listener(
     "nuin_faction_about_to_end_turn",
     "FactionAboutToEndTurn",
     function(context)
          NML.nModLog("In FactionAboutToEndTurn")
          NML.nModLog("Faction Name: " .. tostring(context:faction():name()))
          local_faction = cm:get_local_faction_name(true)
          NML.nModLog("Identified local faction: " .. tostring(local_faction))
          local court_feature_available = feature_unlock.is_feature_unlocked_for_faction(local_faction,
               feature_ids_config.court)
          if context:faction():name() == local_faction then
               NML.nModLog("Faction is human")
               if court.intrigue_functions.has_faction_intrigue_available(local_faction) then
                    NML.nModLog("Identified that human faction has intrigue available")
                    return true
               end
               NML.nModLog("No intrigue available")
               return false
          end
     end,
     function(context)
          --There is an intrigue available. Lets use it to gossip
          local_faction = cm:get_local_faction_name(true)

          --probably dont need below for auto-goss
          local_court = court.util_functions.get_faction_court_for_faction(local_faction)
          NML.nModLog("Court: " .. tostring(local_court.court_name))
          -- Identify which positions are held by non-faction/family members
          local current_regard = 0
          local last_regard = 0
          local lowest_regard_position
          local i = 0
          for _, position_obj in ipairs(local_court.positions) do
               NML.nModLog("In For Loop")
               if position_obj and position_obj.persistent.current_holder then
                    NML.nModLog("In If 1")
                    local holder_character = cm:get_character(position_obj.persistent.current_holder)
                    if (not holder_character)
                        or (holder_character:is_null_interface())
                    then
                         NML.nModLog("Error position has no character")
                    else
                         NML.nModLog("In If 2")
                         local holder_character_faction = holder_character:faction():name()
                         if holder_character_faction ~= local_faction then
                              NML.nModLog("In If 3")
                              --Character is not in our faction, can gossip against them.
                              current_regard = court.position_functions.get_position_regard_towards_faction_by_obj(
                              position_obj, local_faction)
                              if i == 0 then
                                   last_regard = current_regard
                                   lowest_regard_position = position_obj
                              end
                              NML.nModLog("Current regard: " .. tostring(current_regard))
                              NML.nModLog("Last regard: " .. tostring(last_regard))
                              if current_regard <= last_regard then --Means will choose the LAST zero found, not the first, but otherwise smallest value.
                                   NML.nModLog("In If 4")
                                   NML.nModLog("Pos object is " .. tostring(position_obj))
                                   lowest_regard_position = position_obj
                                   last_regard = current_regard
                              end
                         end
                    end
               end
               i = i + 1
          end
          --we now have a position that is non-faction and has the lowest current_regard
          NML.nModLog("Lowest non-faction position: " .. tostring(lowest_regard_position.name))
          --Perform gossip against this position
          if lowest_regard_position ~= nil then
               court.intrigue_functions.use_intrigue(local_court, local_faction, "gossip", lowest_regard_position.name)
               NML.nModLog("Performed Gossip")
          end
     end,
     true
)
