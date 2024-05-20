local function dismantle_growth(region_key)
     out("AI CPR: dismantle_growth for region " .. region_key)
     local region = cm:get_region(region_key)
     local slot_list = region:settlement():slot_list()
     for i = 0, slot_list:num_items() - 1 do
          local slot = slot_list:item_at(i)
          if slot:has_building() then
               local building_name = slot:building():name()
               -- matching growth buildings (not sure how to do it easily, so keep playing with the string matching)
               if not string.find(building_name, "wh_main_brt_farm") and (string.find(building_name, "growth") or string.find(building_name, "farm")) then
                    out("AI CPR: dismantle_growth removing building " .. building_name)
                    cm:region_slot_instantly_dismantle_building(slot)
               end
          end
     end
end

local function Growth_Listener()
     core:add_listener(
          "AI_CPR_DismantleGrowthListener",
          "BuildingCompleted",
          function(context)
               return context:building():slot():type() == "primary" and context:building():building_level() == 5
          end,
          function(context)
               local region_owner = context:building():region():owning_faction()
               local province = context:building():region():province()
               out("AI CPR: DismantleGrowthListener T5 settlement reached in " ..
               province:key() .. " for " .. region_owner:name())
               -- if the region in which the T5 settlement is owned by the AI
               if not region_owner:is_human() then
                    -- loop through the regions of that province
                    for _, current_region in model_pairs(province:regions()) do
                         -- if the region is owned by the same owner as the primary
                         if current_region:owning_faction():command_queue_index() == region_owner:command_queue_index() then
                              -- remove growth buildings
                              dismantle_growth(current_region)
                         end
                    end
               end
          end,
          true
     )
end

cm:add_first_tick_callback(Growth_Listener)