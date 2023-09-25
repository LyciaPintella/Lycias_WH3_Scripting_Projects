local iDiploThreshold = -50
local iRandomThreshold = 5

local function IsValidFaction(factionSource)

    if ((factionSource:is_null_interface() == false) and (factionSource ~= false) and (factionSource:is_vassal() == false) and (factionSource:is_dead() == false) and

        (factionSource:is_rebel() == false) and (factionSource:is_vassal() == false)) then

        out("AAAFyTyAIDeclareWar - Valid faction for war: " .. factionSource:name())
        return true

    else

        return nil

    end

end

local function GetFactionsToWar(factionSource)

    out("AAAFyTyAIDeclareWar - Getting factions to get into a war with: " .. factionSource:name())

    local tableResult = {}

    local listFactionsMet = factionSource:factions_met()

    for iCounter = 0, listFactionsMet:num_items() - 1 do

        local factionCurrent = listFactionsMet:item_at(iCounter)

        if ((factionSource:name() ~= factionCurrent:name()) and (IsValidFaction(factionCurrent)) and (factionCurrent:is_ally_vassal_or_client_state_of(factionSource) == false) and
            (factionSource:is_ally_vassal_or_client_state_of(factionCurrent) == false) and (factionCurrent:at_war_with(factionSource) == false) and
            (factionSource:diplomatic_attitude_towards(factionCurrent:name()) < iDiploThreshold) and (cm:random_number(iRandomThreshold, 0) == iRandomThreshold) and
            (factionSource:is_human() == true and factionCurrent:is_human() == true) == false) then

            out("AAAFyTyAIDeclareWar - Target: " .. factionCurrent:name())
            table.insert(tableResult, factionCurrent:name())

        end

    end

    if #tableResult > 0 then

        return tableResult

    else

        out("AAAFyTyAIDeclareWar - Table is empty!")
        return nil

    end

end

function AAAFyTyAIDeclareWar_Listeners()

    local listFactions = cm:model():world():faction_list()

    core:add_listener("AAAFyTyAIDeclareWar_WorldStartRound", "WorldStartRound", function(context)

        return cm:turn_number() > 0

    end, function(context)

        out("AAAFyTyAIDeclareWar - Turn start!")

        for iCounter = 0, listFactions:num_items() - 1 do

            local factionSource = listFactions:item_at(iCounter)
            local tableToWar = nil

            if IsValidFaction(factionSource) and (factionSource:is_human() == false) then

                tableToWar = GetFactionsToWar(factionSource)

            end

            if tableToWar ~= nil then

                out("AAAFyTyAIDeclareWar - TableToWar has " .. tostring(#tableToWar))

                for iIndex, strCurrent in ipairs(tableToWar) do

                    out("AAAFyTyAIDeclareWar - DECLARING WAR!")
                    cm:callback(function()

                        cm:force_declare_war(factionSource:name(), strCurrent, true, true)

                    end, 0.1)

                end

            end

        end

    end, true)

end

cm:add_first_tick_callback(function()
    AAAFyTyAIDeclareWar_Listeners()
end);
