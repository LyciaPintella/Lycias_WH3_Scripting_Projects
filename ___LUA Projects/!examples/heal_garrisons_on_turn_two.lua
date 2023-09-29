local out = function(t)
    ModLog("Heal Modded Garrisons On Turn Two: " .. tostring(t) .. ".")
end
local function heal_garrisons_worldwide()
    local turn_number = cm:model():turn_number()
    out("Human turn start detected on turn " .. tostring(turn_number) .. "")
    -- modded garrisons don't switch over until that faction's first turn, so we can't do them until turn 2.
    if (turn_number < 3) then
        out("It's turn one or two, let's heal some garrisons!")
        local region_list = cm:model():world():region_manager():region_list();
        for r = 0, region_list:num_items() - 1 do
            -- out("Healing garrison at region " .. tostring(region_list:item_at(r):name()) .. "")
            cm:callback(function()
                cm:heal_garrison(region_list:item_at(r):cqi());
            end, 0.1)
        end
        if (turn_number == 2) then
            core:remove_listener("HEAL_GARRISONS_WORLDWIDE")
        end
    end
end
local function create_heal_garrisons_listener()
    core:add_listener("HEAL_GARRISONS_WORLDWIDE", "FactionTurnStart", function(context)
        return (context:faction():is_human())
    end, function(context)
        cm:callback(function()
            heal_garrisons_worldwide()
        end, 0.1)
    end, true)
end
cm:add_first_tick_callback_new(function()
    create_heal_garrisons_listener()
end);
