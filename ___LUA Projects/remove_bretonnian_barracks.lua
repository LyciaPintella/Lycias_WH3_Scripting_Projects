local regions = { "wh3_main_combi_region_couronne", "wh3_main_combi_region_miragliano",
     "wh3_main_combi_region_bordeleaux", "wh3_main_combi_region_lyonesse", "wh3_main_combi_region_copher",
     "wh3_main_combi_region_zandri" }

local function add_building(slot)
     cm:callback(function()
          cm:region_slot_instantly_upgrade_building(slot, "wh_main_brt_stables_1")
     end, 0.3)
end

local function remove_barracks(region_key)
     local region = cm:get_region(region_key)
     local slot_list = region:slot_list()
     for i = 0, slot_list:num_items() - 1 do
          if not slot_list:is_empty() then
               if slot_list:item_at(i):has_building() then
                    local building_name = slot_list:item_at(i):building():name()
                    if string.find(building_name, "wh_main_brt_barracks") then
                         cm:region_slot_instantly_dismantle_building(slot_list:item_at(i))
                    end
               end
          end
     end
end
remove_barracks("wh3_main_combi_region_desolation_of_drakenmoor")

local function remove_barracks_add_stables(region_key)
     local region = cm:get_region(region_key)
     local slot_list = region:slot_list()
     for i = 0, slot_list:num_items() - 1 do
          if not slot_list:is_empty() then
               if slot_list:item_at(i):has_building() then
                    local building_name = slot_list:item_at(i):building():name()
                    if string.find(building_name, "wh_main_brt_barracks") then
                         cm:region_slot_instantly_dismantle_building(slot_list:item_at(i))
                         add_building(slot_list:item_at(i))
                    end
               end
          end
     end
end
local function loop_through_list()
     for i = 0, #regions - 1 do
          local region_key = regions:item_at(i)
          remove_barracks_add_stables(region_key)
     end
end
loop_through_list()
