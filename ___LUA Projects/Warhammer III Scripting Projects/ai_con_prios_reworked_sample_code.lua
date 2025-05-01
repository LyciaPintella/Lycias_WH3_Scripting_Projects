-- -------------------------------------------------------------------------- --
--                   Confederation Includes Treasury (CIT)                    --
-- -------------------------------------------------------------------------- --
--
-- When confederating a faction you gain their current treasury as well.

-- TODO Implement new feature that increases the globalLimit for each army that was confederated.
-- We'll likely have to just keep a running total of the number of armies each faction has at the start of each turn.


-- -------------------------------------------------------------------------- --
--                      CIT System Declarations                               --
-- -------------------------------------------------------------------------- --


-- Initialize the settings with default values.
-- If MCT is used then some of these values will be overwritten by MCT.
local modSettings = {
     enableLogging       = false,              -- Allow a log file to be written.
     logErrorsOnly       = false,              -- If logging is enabled, should we only log error messages?
     logName             = "ace_confederate_treasury.txt",
     includeAI           = true,               -- Whether or not the AI should also get the bonus background income when confederating.
     includeTreasury     = true,               -- Whether or not confederation should also grant the confederated faction's treasury to the confederating faction.
     includeAncillaries  = true,               -- Whether or not confederation should also grant all the ancillaries of the confederated faction.
     uniquenessLimit     = 50,                 -- Items at or above this uniqness score will display an event notification to the player when received.
     rdllLimit           = 10000,              -- The maximum amount of treasury granted to the confederating faction if the RDLL interaction mode is set to Limited.
     rdllInteractionMode = "rdllModeLimit",    -- The interaction mode that determines how this mod interacts with the Recruit Defeated Legendary Lords (RDLL) mod.
     globalLimit         = 30000,              -- The maximum amount of treasury granted to the confederating faction, regardless of RDLL mod.
}

-- This will be the number of seconds to wait before a the treasury is transferred.
local treasuryTransferDelay = 1

-- The following MCT settings are locked and may not be changed once the campaign starts.
local lockedSettings = {
     includeAI = true
}


-- -------------------------------------------------------------------------- --
--                            Function Definitions                            --
-- -------------------------------------------------------------------------- --


local function sorted_pairs(t)
     -- Provided by GPT-4. Sorting a dictionary is key to preventing desyncs in multiplayer.
     -- Extract and sort the keys
     local keys = {}
     for k in pairs(t) do
          table.insert(keys, k)
     end
     table.sort(keys)

     -- Iterator function
     local i = 0
     return function()
          i = i + 1
          local key = keys[i]
          if key then
               return key, t[key]
          end
     end
end


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
               local confederator     = context:confederation()
               local confederatorName = confederator:name()
               local confederated     = context:faction()
               local confederatedName = confederated:name()


               --- TREASURY ---
               -- We grant the confederating faction the confederated faction's treasury, if enabled in the mod settings.
               if modSettings.includeTreasury then
                    local treasury = confederated:treasury()


                    -- We need to wait a bit for the RDLL mod to save a named value, if the mod is being used, before we check for it.
                    -- So we start a callback to delay the treasury transfer until after the saved value would be saved, if at all.
                    cm:callback(
                         function()
                              local confederatorName = confederatorName
                              local confederatedName = confederatedName
                              local gainAmount       = treasury
                              local logText          = ""


                              -- We respect the gain limits set by the player.
                              if modSettings.globalLimit > 0 and gainAmount > modSettings.globalLimit then
                                   gainAmount = modSettings.globalLimit
                                   logText = " (Globally Limited)"
                              end


                              -- After the delay, we see if this confederation was through the RDLL mod.
                              -- We do this by checking for a specific saved value RDLL generates when confederating.
                              if cm:get_saved_value("rd_choice_0_" .. confederatedName) == false then
                                   -- Then we modify the amount of treasury gained based on the RDLL mode.
                                   if modSettings.rdllInteractionMode ~= "rdllModeDisable" then
                                        -- If the RDLL mode is set to Limited we clamp the amout of treasury gained, if necessary.
                                        if modSettings.rdllInteractionMode == "rdllModeLimit" then
                                             logText = logText .. " (RDLL Mode Limited)"

                                             if gainAmount > modSettings.rdllLimit then
                                                  gainAmount = modSettings.rdllLimit
                                             end
                                        end
                                   else
                                        logText = logText .. " (RDLL Mode Disabled)"
                                        gainAmount = 0
                                   end
                              end


                              -- We grant the (potentially adjusted) treasury.
                              cm:treasury_mod(confederatorName, gainAmount)
                              ace_log(confederatorName ..
                              " confederated " ..
                              confederatedName .. ". Gaining their treasury of: " .. gainAmount .. logText)
                         end,
                         treasuryTransferDelay
                    )
               end


               --- ANCILLARIES ---
               -- We "transfer" all the ancillaries of the condeferated faction, if enabled in the mod settings.
               if modSettings.includeAncillaries then
                    local ancillaryCount         = common.get_context_value("CcoCampaignFaction",
                         confederated:command_queue_index(), "AncillaryList.Size")
                    local ancillaryKey           = nil
                    local isTransferrable        = nil
                    local uniquenessScore        = 0
                    local isUniqueEnough         = false
                    local transferredAncillaries = {
                         -- key = {
                         --     count           = 0,
                         --     isUniqueEnough  = false
                         -- }
                    }


                    for i = 0, ancillaryCount - 1 do
                         isTransferrable = common.get_context_value("CcoCampaignFaction",
                              confederated:command_queue_index(),
                              "AncillaryList.At(" .. i .. ").AncillaryRecordContext.Transferrable")
                         uniquenessScore = common.get_context_value("CcoCampaignFaction",
                              confederated:command_queue_index(),
                              "AncillaryList.At(" .. i .. ").AncillaryRecordContext.UniquenessScore")
                         isUniqueEnough  = uniquenessScore >= modSettings.uniquenessLimit


                         -- We count the number of transferrable ancillaries,
                         -- and record their keys and uniqueness score.
                         if isTransferrable then
                              ancillaryKey = common.get_context_value("CcoCampaignFaction",
                                   confederated:command_queue_index(),
                                   "AncillaryList.At(" .. i .. ").AncillaryRecordContext.Key")

                              if not transferredAncillaries[ancillaryKey] then
                                   transferredAncillaries[ancillaryKey] = {
                                        count          = 1,
                                        isUniqueEnough = isUniqueEnough
                                   }
                              else
                                   transferredAncillaries[ancillaryKey].count = transferredAncillaries[ancillaryKey]
                                   .count + 1
                              end
                         end
                    end


                    -- Finally we remove all the ancillaries from the original faction,
                    -- and grant the same number of each to the confederating faction.
                    for key, data in sorted_pairs(transferredAncillaries) do
                         cm:force_remove_ancillary_from_faction(confederated, key)

                         for x = 1, data.count do
                              cm:add_ancillary_to_faction(confederator, key, data.isUniqueEnough)
                         end

                         ace_log(confederatorName .. " gained " .. data.count .. " " .. key)
                    end
               end
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


local function get_finalized_mct_setting(mctMod, table, settingName)
     -- Loads the finalized MCT setting of the given setting name, if found, then locks the setting to prevent changes to it if it should be locked.
     local setting = mctMod:get_option_by_key(settingName, true)
     if setting then
          table[settingName] = setting:get_finalized_setting()
          if lockedSettings[settingName] then
               -- setting:set_locked(true, common.get_localised_string("ace_btc_mct_setting_locked"))
               setting:set_locked(true,
                    "This setting may not be changed once the campaign has started. Changes must be made at the Main Menu before starting a campaign.")
          end
     end
end


local function get_mct_settings(context)
     -- Loads all of the MCT settings of this mod.

     local mctMod = context:mct():get_mod_by_key("ace_confederate_treasury")

     if not mctMod then return end

     for settingName, _ in sorted_pairs(modSettings) do
          if type(modSettings[settingName]) == "table" then
               for nestedSettingName, _ in sorted_pairs(modSettings[settingName]) do
                    get_finalized_mct_setting(mctMod, modSettings[settingName], nestedSettingName)
               end
          else
               get_finalized_mct_setting(mctMod, modSettings, settingName)
          end
     end
end



-- -------------------------------------------------------------------------- --
--                                 Execution                                  --
-- -------------------------------------------------------------------------- --


-- If we have the MP MCT mod enabled we work with it.
core:add_listener(
     "ace_cit_mct",
     "MctInitialized",
     true,
     function(context)
          get_mct_settings(context)
          isUsingMCT = true
     end,
     true
)


core:add_listener(
     "ace_cit_mct_setting_finalized",
     "MctFinalized",
     true,
     function(context)
          get_mct_settings(context)
     end,
     true
)


cm:add_post_first_tick_callback(init)
