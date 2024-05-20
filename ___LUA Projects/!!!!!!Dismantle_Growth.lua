local function dismantle_growth(region_key)
     out("Calling function remove_growth " .. "")
     local region = cm:get_region(region_key)
     local slot_list = region:settlement():slot_list()
          for i = 0, slot_list:num_items() - 1 do
               if not slot_list:is_empty() then
                    if slot_list:item_at(i):has_building() then
                         local building_name = slot_list:item_at(i):building():name()
                         if not string.find(building_name, "wh_main_brt_farm") and (string.find(building_name, "growth") or string.find(building_name, "farm")) then
                              cm:region_slot_instantly_dismantle_building(slot_list:item_at(i))
                         end
                    end
               end
          end
end
local function Growth_Listener()
     core:add_listener(
          "DismantleGrowthListener",
          "BuildingCompleted",
          function(context)
               return (
                    context:building():slot():type() == "primary" and context:building():building_level() == 5
               )
          end,
          function(context)
               out("AI Construction Priorities Reworked: Dismantle Growth Listener found the following data about a tier 5 settlement: " ..
                    context:building():region_key() ..
                    context:building():region_key():province_regions() ..
                    context:building():region_key():owning_faction():owned_regions())

               local region_owner = context:building():region():owning_faction()
               if not region_owner:is_human() then
                    for _, current_province in model_pairs(region_owner:provinces()) do
                         for _, current_region in model_pairs(current_province:owned_regions()) do
                              dismantle_growth(current_region)
                         end

                    end
               end
          end,
          true
     )
end
cm:add_post_first_tick_callback(function() Growth_Listener() end)