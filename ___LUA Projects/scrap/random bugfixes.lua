--logging
--reset the log
local function jsessionlog()
     if not (__write_output_to_logfile or __enable_jadlog) then
          return;
     end
     local logTimeStamp = os.date("%d, %m %Y %X")
     --# assume logTimeStamp: string

     local popLog = io.open("jNoAutoConversion.txt", "w+")
     popLog:write("NEW LOG [" .. logTimeStamp .. "] \n")
     popLog:flush()
     popLog:close()
end
jsessionlog()


local function jlog(text)
     if not (__write_output_to_logfile or __enable_jadlog) then
          return;
     end

     local logText = tostring(text)
     local popLog = io.open("jNoAutoConversion.txt", "a+")
     popLog:write(logText .. " \n")
     popLog:flush()
     popLog:close()
end


local function add_building(slot)
     cm:callback(function()
          cm:region_slot_instantly_upgrade_building(slot, "jadawin_ruin_1")
     end, 0.3)
end


--known possible reasons for region change event:
--"normal capture" (attack and occupy)
--"abandoned" (attack and raze)
--"unopposed capture" (colonization of ruins, but also occupation immediately after sacking)
--"unknown reason" ?
--
--more?
core:add_listener(
     "JNOAUTOCONVERSION_REGION_FACTION_CHANGE",
     "RegionFactionChangeEvent",
     function(context)
          return true;
     end,
     function(context)
          local previous_owner_faction = context:previous_faction()
          local previous_owner_culture = "none"
          if not previous_owner_faction:is_null_interface() then
               previous_owner_culture = previous_owner_faction:culture()
          end
          --jlog(previous_owner_culture)
          local reason = context:reason()
          local region = context:region()
          --jlog("The region "..region:name().." changed ownership. The reason is: "..reason)
          --jlog(reason)
          local new_owner_faction = region:owning_faction()
          local new_owner_faction_name = new_owner_faction:name()
          local is_human = new_owner_faction:is_human()

          if (reason == "normal capture" or reason == "unopposed capture") and previous_owner_culture ~= "rebels" then
               local treasury_difference = 0
               cm:callback(function()
                    local slot_list = region:slot_list()
                    local new_owner_culture = region:owning_faction():culture()
                    local affects_ai = true
                    if mct_noauto then
                         local mct_mymod = mct_noauto:get_mod_by_key("jadawin_no_autoconversion")
                         affects_ai = mct_mymod:get_option_by_key("affect_ai"):get_finalized_setting()
                    end
                    if new_owner_faction:is_human() or affects_ai then
                         if new_owner_culture ~= previous_owner_culture then
                              jlog(
                              "A settlement was captured and the previous and the new owner have a different culture, so we destroy the buildings.")
                              if is_human then
                                   cm:disable_event_feed_events(true, "", "", "provinces_building_demolished")
                              end
                              local treasury_before = new_owner_faction:treasury()
                              --jlog("Conquering faction's treasury before the occupation: "..treasury_before)
                              --loop through slots of this region
                              for i = 0, slot_list:num_items() - 1 do
                                   if not slot_list:is_empty() then
                                        if slot_list:item_at(i):has_building() then
                                             local building_name = slot_list:item_at(i):building():name()
                                             local slot_type = slot_list:item_at(i):type()
                                             --delete the building unless it's the settlement building, a port, or a resource building
          if not (string.find(building_name, "resource") or slot_type == "primary" or slot_type == "port") then
               cm:region_slot_instantly_dismantle_building(slot_list:item_at(i))
               if new_owner_faction:is_human() then
                    add_building(slot_list:item_at(i))
               end
          end
                                        end
                                   end
                              end
                              local treasury_after = new_owner_faction:treasury()
                              --jlog("Conquering faction's treasury after the occupation: "..treasury_after)
                              treasury_difference = treasury_after - treasury_before
                              --jlog("We take this amount from the conquering faction's treasury: "..treasury_difference)
                              cm:treasury_mod(new_owner_faction_name, (math.ceil(treasury_difference * (-0.5))))
                              if is_human then
                                   cm:callback(function()
                                        cm:disable_event_feed_events(false, "", "", "provinces_building_demolished")
                                   end, 0.5)
                              end
                         else
                              --jlog("A settlement was captured but the previous and the new owner have the same culture, so we allow building conversion.")
                         end
                    end
               end, 0.1)
          end
     end,
     true
)

core:add_listener(
     "MCT_NOAUTO",
     "MctInitialized",
     true,
     function(context)
          mct_noauto = context:mct()
     end,
     true
)
