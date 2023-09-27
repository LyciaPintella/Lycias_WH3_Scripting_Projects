-- removes all secondary buildings in the player's main settlement
function Lib.Campaign.Settlements.remove_all_main_settlement_buildings()
    callback(function()
        local player_main_settlement_interface = Lib.Campaign.Faction_Info.get_player_main_settlement_interface()
        local active_slot_list = player_main_settlement_interface:slot_list()
        local active_slot_number = active_slot_list:num_items()
        for i = 0, active_slot_number - 1 do
            local slot = active_slot_list:item_at(i)
            if (slot:name() == "secondary" and slot:has_building()) then
                Utilities.print("Building found, instantly dismantling " .. slot:building():name())
                cm:instantly_dismantle_building_in_region(slot)
            end
        end
    end)
end

-- script/autotest/lib/campaign/settlements.lua
