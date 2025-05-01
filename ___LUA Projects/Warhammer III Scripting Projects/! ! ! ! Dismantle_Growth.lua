local function out(t)
     ModLog("AI CPR: " .. tostring(t) .. ".")
end

local function is_growth_building(building_name)
     return (string.find(building_name, "growth") or string.find(building_name, "farm") or string.find(building_name, "wh_main_brt_hospital")) and not string.find(building_name, "wh_main_brt_farm")
end

local function dismantle_growth(region_key)
     out("dismantle_growth start error checks.")
     out("dismantle_growth for region " .. region_key)
     local region = cm:get_region(region_key)
     if not region then
          out("Error - Region not found for key " .. region_key)
          return
     end
     out("Region " .. region_key .. " found.")

     local settlement = region:settlement()
     if not settlement then
          out("Error - Settlement not found for region " .. region_key)
          return
     end
     out("Settlement found for region " .. region_key)

     local slot_list = settlement:slot_list()
     if not slot_list then
          out("Error - Slot list is nil for region " .. region_key)
          return
     end
     out("Slot list found for region " .. region_key)

     out("dismantle_growth error checks complete.")
     for i = 0, slot_list:num_items() - 1 do
          local slot = slot_list:item_at(i)
          out("AI CPR slot: " .. tostring(slot) .. ", has_building: " .. tostring(slot and slot:has_building()))

          if slot and slot:has_building() then
               local building = slot:building()
               out("Building: " .. tostring(building))

               if building then
                    local building_name = building:name()
                    if is_growth_building(building_name) then
                         out("dismantle_growth removing building " .. building_name)
                         cm:region_slot_instantly_dismantle_building(slot)
                    end
               end
          end
     end
end

local function Growth_Listener()
     out("Creating Listener for Maxed out Provinces.")
     core:add_listener(
          "AI_CPR_DismantleGrowthListener",
          "BuildingCompleted",
          function(context)
               if not context or not context:building() or not context:building():slot() then
                    out("Error - Invalid context in BuildingCompleted listener")
                    return false
               end
               return context:building():slot():type() == "primary" and context:building():building_level() == 5
          end,
          function(context)
               local region = context:building():region()
               local region_key = context:building():region():name()
               local region_owner = region:owning_faction()
               local province = region:province()
               if not province then
                    out("Error - Province not found")
                    return
               end

               out("DismantleGrowthListener T5 settlement reached in " ..
                    (province:key() or "unknown province") ..
                    " for " .. (region_owner:name() or "unknown owner") ..
                    " region_owner:is_human() - " .. tostring(region_owner:is_human()))

               if not region_owner:is_human() then
                    out("Region is owned by an AI faction.")
                    for _, current_region in model_pairs(province:regions()) do
                         if current_region then
                              out("Inspecting region: " .. current_region:name() ..
                                   ", owned by faction: " .. current_region:owning_faction():name())
                              if current_region:owning_faction():command_queue_index() == region_owner:command_queue_index() then
                                   out("CQI checks complete, dismantling growth in region: " .. current_region:name())
                                   dismantle_growth(current_region:name())
                              end
                         else
                              out("Error: current_region is nil in province:regions() iteration.")
                         end
                    end
               end
          end,
          true
     )
end

cm:add_first_tick_callback(Growth_Listener)
