local modSettings = {
     enable_Bret_Barracks_Replacement = true, -- Replace starting Bretonnian barracks with stables.
}

local regions = { "wh3_main_combi_region_couronne", "wh3_main_combi_region_miragliano",
     "wh3_main_combi_region_bordeleaux", "wh3_main_combi_region_lyonesse", "wh3_main_combi_region_copher",
     "wh3_main_combi_region_zandri", "wh3_main_combi_region_castle_carcassonne" }
local function out(t) ModLog("AI Construction Priorities Reworked " .. tostring(t) .. ".") end
local function add_building(slot)
     cm:callback(function()
          cm:region_slot_instantly_upgrade_building(slot, "wh_main_brt_stables_1")
     end, 0.3)
end

local function remove_barracks(region_key)
     out("Calling function remove_barracks " .. "")
     local region = cm:get_region(region_key)
     local slot_list = region:settlement():slot_list()
     if cm:is_new_game() then
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
end

local function remove_barracks_add_stables(region_key)
     out("Calling function remove_barracks_add_stables " .. "")
     local region = cm:get_region(region_key)
     local slot_list = region:settlement():slot_list()
     if cm:is_new_game() then
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
end

local function loop_through_list()
     out("Calling function loop_through_list " .. "")
     for i, region_key in pairs(regions) do
          remove_barracks_add_stables(region_key)
     end
end

local function initialize_bretonnian_barracks_replacement()
     --if modSettings.enable_Bret_Barracks_Replacement then
          local turn_number = cm:model():turn_number()
          cm:callback(function()
               if (turn_number == 1) then
                    loop_through_list()
                    remove_barracks("wh3_main_combi_region_desolation_of_drakenmoor")
               end
          end, 2.0)
     --end
end

cm:add_first_tick_callback_new(function()
     initialize_bretonnian_barracks_replacement()
end)
