if not cm:get_saved_value("hef_pegasus_hero_0_spawned") then
     core:add_listener(                           -- One of the most common ways to wait (listen) for a specific event to happen, and then do something with the information provided by that event (context variable).
          "Barney_hef_pegasus_hero_0_spawn",      -- The unique name of this event listener. This can be used to stop the listener later if necessary. Won't be in this case.
          "BuildingCompleted",                    -- The event to trigger on, as listed on https://chadvandy.github.io/tw_modding_resources/WH3/scripting_doc.html
          function(context)                       -- The conditional check function, if this retuns "true" the function below this one will be run. This can also just be "true" if you always want it to run.
               local buildingName = context:building():name()
               -- If the name of the building matches it'll return "true", meaning we can proceed with the next function.
               return buildingName == "wh2_main_special_ellyrian_stables"
          end,
          function(context)
               ace_log("Building constructed, spawning agent...")

               -- "context" will be an object/table with 2 functions as shown here: https://chadvandy.github.io/tw_modding_resources/WH3/scripting_doc.html#BuildingCompleted and is provided by the BuildingCompleted event, one of them is garrison_residence().
               -- garrison_residence() returns a GARRISON_RESIDENCE_SCRIPT_INTERFACE object/table with several functions, as shown here: https://chadvandy.github.io/tw_modding_resources/WH3/scripting_doc.html#GARRISON_RESIDENCE_SCRIPT_INTERFACE
               -- We use the faction() function to return the owning faction's FACTION_SCRIPT_INTERFACE
               local faction = context:garrison_residence():faction()
               local region = context:garrison_residence():region()

               cm:spawn_unique_agent_at_region(faction:command_queue_index(), "hef_pegasus_hero", region:cqi(),
                    false)
               ace_log("Agent spawned for " .. faction:name())
               local character = cm:get_most_recently_created_character_of_type(faction, nil, "hef_pegasus_hero")
               local incidentBuilder = cm:create_incident_builder("hef_pegasus_rec")      -- Incident key from the incidents DB table.
               incidentBuilder:add_target("default", character:family_member())           -- The character family_member object to point the incident at.
               cm:launch_custom_incident_from_builder(incidentBuilder, faction)           -- Make the incident appear.
               ace_log("Incident launched.")
               cm:set_saved_value("hef_pegasus_rec", true)                                -- We ask to save "based_black_grail_knights_spawned = true" in the save file so that we know this already happened when/if the game is loaded later.
               ace_log("Spawn complete.")
          end,
          false      -- "false" means this will only happen once, then the listener will destroy itself.
     )
end
