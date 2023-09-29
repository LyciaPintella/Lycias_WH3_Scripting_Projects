-- -------------------------------------------------------------------------- --
--                   Confederation Includes Treasury (CIT)                    --
-- -------------------------------------------------------------------------- --
--
-- When confederating a faction you gain their current treasury as well.


-- -------------------------------------------------------------------------- --
--                      CIT System Declarations                               --
-- -------------------------------------------------------------------------- --


-- Initialize the settings with default values.
-- If MCT is used then some of these values will be overwritten by MCT.
local modSettings = {
    enableLogging           = false,    -- Allow a log file to be written.
    logErrorsOnly           = false,    -- If logging is enabled, should we only log error messages?
    logName                 = "ace_confederate_treasury.txt",
    includeAI               = true,     -- Whether or not the AI should also get the bonus background income when confederating.
}


-- -------------------------------------------------------------------------- --
--                            Function Definitions                            --
-- -------------------------------------------------------------------------- --


local function ace_log(text, append)
    -- Logging function that may only be called after/on first tick.

    -- Set the optional parameter default value.
    if append == nil then append = true end

    -- Ensure we're allowed to write to the log, and that text is of type string.
    if not modSettings.enableLogging or type(text) ~= "string" then return end

    -- Ensure we're only logging errors, if that's what the settings call for.
    if modSettings.enableLogging and modSettings.logErrorsOnly and not text:find("ERROR:") then return end

    -- Choose the write mode.
    local mode = append and "a" or "w"

    -- Attempt to open the file.
    local logFile, err = io.open(modSettings.logName, mode)
    if not logFile then
        return
    end

    -- Write to the file and close it.
    if text == "" then
        logFile:write("\n")
    else
        logFile:write("Turn " .. cm:turn_number() .. ": " .. text .. "\n")
    end
    logFile:close()
end


local function init()

    -- We clear the log file each new game, or at least track when the script starts.
    if cm:is_new_game() then ace_log("Script start.", false) else ace_log("Script start.") end


    core:add_listener(
        "ace_cit_grant_treasury",
        "FactionJoinsConfederation",
        function(context)
            local isPlayer = context:confederation():is_human()
            return isPlayer or (not isPlayer and modSettings.includeAI)
        end,
        function(context)
            local confederator      = context:confederation()
            local confederatorName  = confederator:name()
            local confederated      = context:faction()
            local confederatedName  = confederated:name()
            local treasury          = confederated:treasury()


            cm:treasury_mod(confederatorName, treasury)

            ace_log(confederatorName .. " confederated " .. confederatedName .. ". Gaining their treasury of: " .. treasury)

        end,
        true
    )


    -- core:add_listener(
    --     "ace_cit_test",
    --     "FactionTurnStart",
    --     function(context)
    --         return cm:turn_number() == 2 or cm:turn_number() == 3
    --     end,
    --     function(context)
    --         local faction       = context:faction()
    --         local factionName   = faction:name()
    --         local turnNumber    = cm:turn_number()
    --         local confedTarget  = nil

    --         if factionName == "wh2_main_skv_clan_skryre" and turnNumber == 2 then
    --             confedTarget = cm:get_faction("wh2_main_skv_clan_pestilens")
    --             cm:force_confederation(factionName, confedTarget:name())
    --         end

    --         if factionName == "wh2_main_skv_clan_skryre" and turnNumber == 3 then
    --             confedTarget = cm:get_faction("wh2_main_skv_clan_moulder")
    --             cm:force_confederation(factionName, confedTarget:name())
    --         end

    --     end,
    --     true
    -- )

end



-- -------------------------------------------------------------------------- --
--                                 Execution                                  --
-- -------------------------------------------------------------------------- --


-- If we have the MP MCT mod enabled we work with it.
core:add_listener(
    "ace_aiut_mct",
    "MctInitialized",
    true,
    function(context)

        local mctMod = context:mct():get_mod_by_key("ace_confederate_background_income")
        if not mctMod then return end

        -- Then we apply the setting value directly if we found it, otherwise we leave it at the default value.
        modSettings.enableLogging           = mctMod:get_option_by_key("enableLogging"):get_finalized_setting()         or modSettings.enableLogging
        modSettings.logErrorsOnly           = mctMod:get_option_by_key("logErrorsOnly"):get_finalized_setting()         or modSettings.logErrorsOnly
        modSettings.includeAI               = mctMod:get_option_by_key("includeAI"):get_finalized_setting()             or modSettings.includeAI

    end,
    true
)


cm:add_post_first_tick_callback(init)